/*
 * pipe.c -- fifo driver for scull
 *
 * Copyright (C) 2001 Alessandro Rubini and Jonathan Corbet
 * Copyright (C) 2001 O'Reilly & Associates
 *
 * The source code in this file can be freely used, adapted,
 * and redistributed in source or binary form, so long as an
 * acknowledgment appears in derived source files.  The citation
 * should list that the code comes from the book "Linux Device
 * Drivers" by Alessandro Rubini and Jonathan Corbet, published
 * by O'Reilly & Associates.   No warranty is attached;
 * we cannot take responsibility for errors or fitness for use.
 *
 */

#include <linux/module.h>
#include <linux/moduleparam.h>

#include <linux/kernel.h>	/* printk(), min() */
#include <linux/slab.h>		/* kmalloc() */
#include <linux/fs.h>		/* everything... */
#include <linux/proc_fs.h>
#include <linux/errno.h>	/* error codes */
#include <linux/types.h>	/* size_t */
#include <linux/fcntl.h>
#include <linux/poll.h>
#include <linux/cdev.h>
#include <asm/uaccess.h>

#include "scull.h"		/* local definitions */

struct scull_pipe {
    /* 无数据可读或可写时, 同休眠在对应的队列上. */
    wait_queue_head_t inq, outq;       /* read and write queues */
    /* 每个 pipi 设置维护一个缓冲区 buffer . */
    char *buffer, *end;                /* begin of buf, end of buf */
    int buffersize;                    /* used in pointer arithmetic */
    char *rp, *wp;                     /* where to read, where to write */
    int nreaders, nwriters;            /* number of openings for r/w */
    struct fasync_struct *async_queue; /* asynchronous readers */
    struct semaphore sem;              /* mutual exclusion semaphore */
    struct cdev cdev;                  /* Char device structure */
};

/* parameters */
static int scull_p_nr_devs = SCULL_P_NR_DEVS;	/* number of pipe devices */
int scull_p_buffer =  SCULL_P_BUFFER;	/* buffer size */
dev_t scull_p_devno;			/* Our first device number */

module_param(scull_p_nr_devs, int, 0);	/* FIXME check perms */
module_param(scull_p_buffer, int, 0);

static struct scull_pipe *scull_p_devices;

static int scull_p_fasync(int fd, struct file *filp, int mode);
static int spacefree(struct scull_pipe *dev);
/*
 * Open and close
 */


static int scull_p_open(struct inode *inode, struct file *filp)
{
    struct scull_pipe *dev;

    dev = container_of(inode->i_cdev, struct scull_pipe, cdev);
    filp->private_data = dev;

    if (down_interruptible(&dev->sem))
        return -ERESTARTSYS;
    if (!dev->buffer) {
        /* allocate the buffer */
        dev->buffer = kmalloc(scull_p_buffer, GFP_KERNEL);
        if (!dev->buffer) {
            up(&dev->sem);
            return -ENOMEM;
        }
    }
    /* 一旦有新的reader或writer读写指针就会复位,
     * 所以writer写入的数据不能保证被reader读取. */
    dev->buffersize = scull_p_buffer;
    dev->end = dev->buffer + dev->buffersize;
    dev->rp = dev->wp = dev->buffer; /* rd and wr from the beginning */
    PDEBUG("new readers or writers\n");

    /* use f_mode,not  f_flags: it's cleaner (fs/open.c tells why) */
    if (filp->f_mode & FMODE_READ)
        dev->nreaders++;
    if (filp->f_mode & FMODE_WRITE)
        dev->nwriters++;
    up(&dev->sem);

    /* 把filp标志为不可定位, 这样, 内核就不会让在这种文件上的lseek调用成功 */
    return nonseekable_open(inode, filp);
}



static int scull_p_release(struct inode *inode, struct file *filp)
{
    struct scull_pipe *dev = filp->private_data;

    /* remove this filp from the asynchronously notified filp's */
    scull_p_fasync(-1, filp, 0); /* 从异步通知列表中删除该 filp */

    down(&dev->sem);
    if (filp->f_mode & FMODE_READ)
        dev->nreaders--;
    if (filp->f_mode & FMODE_WRITE)
        dev->nwriters--;
    if (dev->nreaders + dev->nwriters == 0) {
        kfree(dev->buffer);
        dev->buffer = NULL; /* the other fields are not checked on open */
    }
    up(&dev->sem);

    return 0;
}


/*
 * Data management: read and write
 */

static ssize_t scull_p_read (struct file *filp, char __user *buf,
        size_t count, loff_t *f_pos)
{
    struct scull_pipe *dev = filp->private_data;

    if (down_interruptible(&dev->sem))
        return -ERESTARTSYS;

    while (dev->rp == dev->wp) { /* nothing to read */
        up(&dev->sem); /* release the lock */
        if (filp->f_flags & O_NONBLOCK)
            return -EAGAIN;
        PDEBUG("\"%s\" reading: going to sleep\n", current->comm);
        if (wait_event_interruptible(dev->inq, (dev->rp != dev->wp)))
            return -ERESTARTSYS; /* signal: tell the fs layer to handle it */
        /* otherwise loop, but first reacquire the lock */
        if (down_interruptible(&dev->sem))
            return -ERESTARTSYS;
    }
    /* ok, data is there, return something */
    if (dev->wp > dev->rp)
        count = min(count, (size_t)(dev->wp - dev->rp));
    else /* the write pointer has wrapped, return data up to dev->end */
        count = min(count, (size_t)(dev->end - dev->rp));
    if (copy_to_user(buf, dev->rp, count)) {
        up (&dev->sem);
        return -EFAULT;
    }
    /* 只要有一个reader获得了读取的机会, buffer中的读取指针就会被更新,
     * 所以readers读取的数据是各不相同的! */
    dev->rp += count;
    if (dev->rp == dev->end)
        dev->rp = dev->buffer; /* wrapped */
    up (&dev->sem);

    /* finally, awake any writers and return */
    wake_up_interruptible(&dev->outq); /* 唤醒 writers */
    PDEBUG("\"%s\" did read %li bytes\n",current->comm, (long)count);
    return count;
}

/* Wait for space for writing; caller must hold device semaphore.  On
 * error the semaphore will be released before returning. */
/* 是否有可用的空间? 没有空间了则休眠等待. */
static int scull_getwritespace(struct scull_pipe *dev, struct file *filp)
{
    /* 手工休眠 */
    while (spacefree(dev) == 0) { /* full */
        DEFINE_WAIT(wait); /* 声明建立并初始化一个等待队列入口 */

        up(&dev->sem);
        if (filp->f_flags & O_NONBLOCK) /* 非阻塞? */
            return -EAGAIN;
        PDEBUG("\"%s\" writing: going to sleep\n", current->comm);
        /* 将等待队列入口添加到队列中, 并设置进程的状态 */
        prepare_to_wait(&dev->outq, &wait, TASK_INTERRUPTIBLE);
        /* 在真正进入休眠前要检测一下缓冲区是否已经变得可用了 */
        if (spacefree(dev) == 0)
            schedule();
        finish_wait(&dev->outq, &wait);
        if (signal_pending(current))
            return -ERESTARTSYS; /* signal: tell the fs layer to handle it */
        if (down_interruptible(&dev->sem))
            return -ERESTARTSYS;
    }
    return 0;
}

/* How much space is free? */
static int spacefree(struct scull_pipe *dev) /* CCCCC */
{
    /* 返回值比设备实际可用的空间少 1, 因为判断缓冲区为空的条件为 rp==wp */
    if (dev->rp == dev->wp) /* 缓冲区为空? */
        return dev->buffersize - 1;
    return ((dev->rp + dev->buffersize - dev->wp) % dev->buffersize) - 1;
}

static ssize_t scull_p_write(struct file *filp, const char __user *buf,
        size_t count, loff_t *f_pos)
{
    struct scull_pipe *dev = filp->private_data;
    int result;

    if (down_interruptible(&dev->sem))
        return -ERESTARTSYS;

    /* Make sure there's space to write */
    result = scull_getwritespace(dev, filp);
    if (result)
        return result; /* scull_getwritespace called up(&dev->sem) */

    /* ok, space is there, accept something */
    count = min(count, (size_t)spacefree(dev));
    if (dev->wp >= dev->rp)
        count = min(count, (size_t)(dev->end - dev->wp)); /* to end-of-buf */
    else /* the write pointer has wrapped, fill up to rp-1 */
        count = min(count, (size_t)(dev->rp - dev->wp - 1));
    PDEBUG("Going to accept %li bytes to %p from %p\n", (long)count,
            dev->wp, buf);
    if (copy_from_user(dev->wp, buf, count)) {
        up (&dev->sem);
        return -EFAULT;
    }
    dev->wp += count;
    if (dev->wp == dev->end)
        dev->wp = dev->buffer; /* wrapped */
    up(&dev->sem);

    /* finally, awake any reader */
    wake_up_interruptible(&dev->inq);  /* blocked in read() and select() */

    /* and signal asynchronous readers, explained late in chapter 6 */
    if (dev->async_queue) /* 给所注册了异步通知的进程发送SIGIO信号 */
        kill_fasync(&dev->async_queue, SIGIO, POLL_IN);
    PDEBUG("\"%s\" did write %li bytes\n",current->comm, (long)count);
    return count;
}

/* [<P163>] */
static unsigned int scull_p_poll(struct file *filp, poll_table *wait)
{
    struct scull_pipe *dev = filp->private_data;
    unsigned int mask = 0;

    /*
     * The buffer is circular; it is considered full
     * if "wp" is right behind "rp" and empty if the
     * two are equal.
     */
    down(&dev->sem);

    /* 向 poll_table 结构添加等待队列 */
    poll_wait(filp, &dev->inq,  wait);
    poll_wait(filp, &dev->outq, wait);

    /* 返回位掩码 */
    if (dev->rp != dev->wp)
        mask |= POLLIN | POLLRDNORM;	/* readable */
    if (spacefree(dev))
        mask |= POLLOUT | POLLWRNORM;	/* writable */

    up(&dev->sem);
    return mask;
}



/* 只要在应用程序中的 file->f_flags 的 FASYNC 标志发生了变化, 就会调用该驱动程
 * 序方法. */
static int scull_p_fasync(int fd, struct file *filp, int mode)
{
    struct scull_pipe *dev = filp->private_data;

    /* 把需要异步通知服务的进程(应用程序)的相关信息保存在 async_queue 中?
     * QQQQQ */
    return fasync_helper(fd, filp, mode, &dev->async_queue); /* MMMMM */
}



/* FIXME this should use seq_file */
#ifdef SCULL_DEBUG
/* [<P87>]
 * 根据 offset 的值更新 *start */
static void scullp_proc_offset(char *buf, char **start,
        off_t *offset, int *len)
{
    if (*offset == 0)
        return;
    if (*offset >= *len) {	/* Not there yet */
        *offset -= *len;
        *len = 0;
    } else {			/* We're into the interesting stuff now */
        *start = buf + *offset;
        *offset = 0;
    }
}


static int scull_read_p_mem(char *buf, char **start, off_t offset,
        int count, int *eof, void *data) /* [<P87>] */
{
    int i, len;
    struct scull_pipe *p;

#define LIMIT (PAGE_SIZE-200)	/* don't print any more after this size */
    /* *start 设为非空值, 将通知内核由 *start 指向的数据是 offset
     * 指定的偏移量处的数据. */
    *start = buf;
    len = sprintf(buf, "Default buffersize is %i\n", scull_p_buffer);
    for(i = 0; i<scull_p_nr_devs && len <= LIMIT; i++) {
        p = &scull_p_devices[i];
        if (down_interruptible(&p->sem))
            return -ERESTARTSYS;
        len += sprintf(buf+len, "\nDevice %i: %p\n", i, p);
        /* len += sprintf(buf+len, "   Queues: %p %p\n", p->inq, p->outq);*/
        len += sprintf(buf+len, "   Buffer: %p to %p (%i bytes)\n",
                p->buffer, p->end, p->buffersize);
        len += sprintf(buf+len, "   rp %p   wp %p\n", p->rp, p->wp);
        len += sprintf(buf+len, "   readers %i   writers %i\n",
                p->nreaders, p->nwriters);
        up(&p->sem);
        scullp_proc_offset(buf, start, &offset, &len); /* QQAQQ */
    }
    *eof = (len <= LIMIT);
    return len;
}

#endif



/*
 * The file operations for the pipe device
 * (some are overlayed with bare scull)
 */
struct file_operations scull_pipe_fops = {
    .owner =	THIS_MODULE,
    .llseek =	no_llseek, /* 不支持 lseek */
    .read =	scull_p_read,
    .write =	scull_p_write,
    .poll =	scull_p_poll,
    .ioctl =	scull_ioctl,
    .open =	scull_p_open,
    .release =	scull_p_release,
    .fasync =	scull_p_fasync,
};


/*
 * Set up a cdev entry.
 */
static void scull_p_setup_cdev(struct scull_pipe *dev, int index)
{
    int err, devno = scull_p_devno + index;

    cdev_init(&dev->cdev, &scull_pipe_fops);
    dev->cdev.owner = THIS_MODULE;
    err = cdev_add (&dev->cdev, devno, 1); /* 通告内核 */
    /* Fail gracefully if need be */
    if (err)
        printk(KERN_NOTICE "Error %d adding scullpipe%d", err, index);
}



/*
 * Initialize the pipe devs; return how many we did.
 */
int scull_p_init(dev_t firstdev)
{
    int i, result;

    /* 注册设备编号 */
    result = register_chrdev_region(firstdev, scull_p_nr_devs, "scullp");
    if (result < 0) {
        printk(KERN_NOTICE "Unable to get scullp region, error %d\n",
                result);
        return 0;
    }
    scull_p_devno = firstdev; /* 注册得到的第一个设备编号 */
    scull_p_devices = kmalloc(scull_p_nr_devs * sizeof(struct scull_pipe),
            GFP_KERNEL);
    if (scull_p_devices == NULL) {
        unregister_chrdev_region(firstdev, scull_p_nr_devs);
        return 0;
    }
    memset(scull_p_devices, 0, scull_p_nr_devs * sizeof(struct scull_pipe));
    for (i = 0; i < scull_p_nr_devs; i++) {
        /* 初始化等待队列头(休眠时用). [<P150>] */
        init_waitqueue_head(&(scull_p_devices[i].inq));
        init_waitqueue_head(&(scull_p_devices[i].outq));
        init_MUTEX(&scull_p_devices[i].sem);
        scull_p_setup_cdev(scull_p_devices + i, i);
    }
#ifdef SCULL_DEBUG
    /* 创建 /proc 文件, 并注册相应的输出函数. QQAQQ */
    create_proc_read_entry("scullpipe", 0, NULL, scull_read_p_mem, NULL);
#endif
    return scull_p_nr_devs;
}

/*
 * This is called by cleanup_module or on failure.
 * It is required to never fail, even if nothing was initialized first
 */
void scull_p_cleanup(void)
{
    int i;

#ifdef SCULL_DEBUG
    remove_proc_entry("scullpipe", NULL);
#endif

    if (!scull_p_devices)
        return; /* nothing else to release */

    for (i = 0; i < scull_p_nr_devs; i++) {
        cdev_del(&scull_p_devices[i].cdev); /* 从系统中移除字符设备 */
        kfree(scull_p_devices[i].buffer);
    }
    kfree(scull_p_devices);
    unregister_chrdev_region(scull_p_devno, scull_p_nr_devs);
    scull_p_devices = NULL; /* pedantic */
}