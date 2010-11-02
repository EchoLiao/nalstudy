/*
 * main.c -- the bare scull char module
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

#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>

#include <linux/kernel.h>	/* printk() */
#include <linux/slab.h>		/* kmalloc() */
#include <linux/fs.h>		/* everything... */
#include <linux/errno.h>	/* error codes */
#include <linux/types.h>	/* size_t */
#include <linux/proc_fs.h>
#include <linux/fcntl.h>	/* O_ACCMODE */
#include <linux/seq_file.h>
#include <linux/cdev.h>

#include <asm/system.h>		/* cli(), *_flags */
#include <asm/uaccess.h>	/* copy_*_user */

#include "scull.h"		/* local definitions */

/*
 * Our parameters which can be set at load time.
 */

int scull_major =   SCULL_MAJOR; /* 0 表示动态申请 */
int scull_minor =   0;
int scull_nr_devs = SCULL_NR_DEVS;	/* number of bare scull devices */
int scull_quantum = SCULL_QUANTUM;
int scull_qset =    SCULL_QSET;

module_param(scull_major, int, S_IRUGO);
module_param(scull_minor, int, S_IRUGO);
module_param(scull_nr_devs, int, S_IRUGO);
module_param(scull_quantum, int, S_IRUGO);
module_param(scull_qset, int, S_IRUGO);

MODULE_AUTHOR("Alessandro Rubini, Jonathan Corbet");
MODULE_LICENSE("Dual BSD/GPL");

struct scull_dev *scull_devices;	/* allocated in scull_init_module */


/*
 * Empty out the scull device; must be called with the device
 * semaphore held.
 */
int scull_trim(struct scull_dev *dev)
{
    struct scull_qset *next, *dptr;
    int qset = dev->qset;   /* "dev" is not-null */
    int i;

    /* [<P65>] */
    for (dptr = dev->data; dptr; dptr = next) { /* all the list items */
        if (dptr->data) {
            /* dptr->data[i] 在申请是已被初始化0 */
            for (i = 0; i < qset; i++)
                kfree(dptr->data[i]);  /* 释放量子 */
            kfree(dptr->data); /* 释放量子集(量子目录) */
            dptr->data = NULL;
        }
        next = dptr->next;
        kfree(dptr); /* 释放链表项 */
    }
    dev->size = 0;
    dev->quantum = scull_quantum;
    dev->qset = scull_qset;
    dev->data = NULL;
    return 0;
}


#ifdef SCULL_DEBUG /* use proc only if debugging */
/*
 * The proc filesystem: function to read and entry
 */

/* 把设备的使用情况输送到 /proc/scullmem */
int scull_read_procmem(char *buf, char **start, off_t offset,
        int count, int *eof, void *data)
{
    int i, j, len = 0;
    int limit = count - 80; /* Don't print more than this */

    for (i = 0; i < scull_nr_devs && len <= limit; i++) {
        struct scull_dev *d = &scull_devices[i];
        struct scull_qset *qs = d->data;
        if (down_interruptible(&d->sem))
            return -ERESTARTSYS;
        len += sprintf(buf+len,"\nDevice %i: qset %i, q %i, sz %li\n",
                i, d->qset, d->quantum, d->size);
        for (; qs && len <= limit; qs = qs->next) { /* scan the list */
            len += sprintf(buf + len, "  item at %p, qset at %p\n",
                    qs, qs->data);
            if (qs->data && !qs->next) /* dump only the last item */
                for (j = 0; j < d->qset; j++) {
                    if (qs->data[j])
                        len += sprintf(buf + len, "    % 4i: %8p\n",
                                j, qs->data[j]);
                }
        }
        up(&scull_devices[i].sem);
    }
    *eof = 1;
    return len;
}


/*
 * For now, the seq_file implementation will exist in parallel.  The
 * older read_procmem function should maybe go away, though.
 */

/*
 * Here are our sequence iteration methods.  Our "position" is
 * simply the device number.
 */
/* pos 的意思是指要操作的是第几个设备(scull0 ... scull3) */
static void *scull_seq_start(struct seq_file *s, loff_t *pos)
{
    if (*pos >= scull_nr_devs)
        return NULL;   /* No more to read */
    return scull_devices + *pos;
}

static void *scull_seq_next(struct seq_file *s, void *v, loff_t *pos)
{
    (*pos)++;
    if (*pos >= scull_nr_devs)
        return NULL;
    return scull_devices + *pos;
}

static void scull_seq_stop(struct seq_file *s, void *v)
{
    /* Actually, there's nothing to do here */
}

/* show方法: 内核会调用其来将实际的数据输出到用户空间.
 * v : 是start或next返回的迭代器 */
static int scull_seq_show(struct seq_file *s, void *v)
{
    /* 在seq_file中只能使用 seq_printf 等输出函数, 不能使用 printk 等 */
    struct scull_dev *dev = (struct scull_dev *) v;
    struct scull_qset *d;
    int i;

    if (down_interruptible(&dev->sem))
        return -ERESTARTSYS;
    seq_printf(s, "\nDevice %i: qset %i, q %i, sz %li\n",
            (int) (dev - scull_devices), dev->qset, dev->quantum, dev->size);
    for (d = dev->data; d; d = d->next) { /* scan the list */
        seq_printf(s, "  item at %p, qset at %p\n", d, d->data);
        if (d->data && !d->next) /* dump only the last item */
            for (i = 0; i < dev->qset; i++) {
                if (d->data[i])
                    seq_printf(s, "    % 4i: %8p\n", i, d->data[i]);
            }
    }
    up(&dev->sem);
    return 0;
}

/*
 * Tie the sequence operators up.
 */
static struct seq_operations scull_seq_ops = {
    /* seq_file 所需的四个迭代器对象 */
    .start = scull_seq_start,
    .next  = scull_seq_next,
    .stop  = scull_seq_stop,
    .show  = scull_seq_show
};

/*
 * Now to implement the /proc file we need only make an open
 * method which sets up the sequence operators.
 */
/* /proc 文件(用seq_file实现)的操作函数集中的 open 方法 */
static int scull_proc_open(struct inode *inode, struct file *file)
{
    /* 把 scull_seq_ops(迭代器对象) 通告给内核. MMMMM */
    return seq_open(file, &scull_seq_ops);
}

/*
 * Create a set of file operations for our proc file.
 */
/* 创建一个 file_operations 结构供内核在该/proc文件上进行读取等操作,
 * 因为我们要使用 create_proc_entry, 而不是用 create_proc_read_entry .
 * */
static struct file_operations scull_proc_ops = {
    .owner   = THIS_MODULE,
    .open    = scull_proc_open, /* open 是我们唯一一个要我们实现的操作 */
    .read    = seq_read,
    .llseek  = seq_lseek,
    .release = seq_release
};


/*
 * Actually create (and remove) the /proc file(s).
 */
static void scull_create_proc(void)
{
    struct proc_dir_entry *entry;

    /* 创建 /proc 文件, scull_read_procmem 是read_proc方法 */
    create_proc_read_entry("scullmem", 0 /* default mode */,
            NULL /* parent dir (/proc) */, scull_read_procmem,
            NULL /* client data (scull_remove_proc的参数) */ );

    /* 使用 seq_file 创建 /proc 文件, 其提供 scull 的各个设备的使用情况 */
    entry = create_proc_entry("scullseq", 0 /*default mode */,
            NULL /* parent dir */ );

    if (entry)
        entry->proc_fops = &scull_proc_ops; /* 设置对应的文件操作集 MMMMM */
}

static void scull_remove_proc(void)
{
    /* no problem if it was not registered */
    remove_proc_entry("scullmem", NULL /* parent dir */);
    remove_proc_entry("scullseq", NULL);
}


#endif /* SCULL_DEBUG */





/*
 * Open and close
 */

int scull_open(struct inode *inode, struct file *filp)
{
    struct scull_dev *dev; /* device information */

    /* 取得对应的scull_dev结构体变量的指针(内存地址), inode->i_cdev 是在
     * scull_setup_cdev()(由scull_init_module()调用) 中设置的. */
    dev = container_of(inode->i_cdev, struct scull_dev, cdev); /* CCCCC */
    filp->private_data = dev; /* for other methods */ /* MMMMM */

    /* now trim to 0 the length of the device if open was write-only */
    if ( (filp->f_flags & O_ACCMODE) == O_WRONLY) {
        /* 如果是进行写入操作, 则先清空设备 */
        if (down_interruptible(&dev->sem))
            return -ERESTARTSYS;
        scull_trim(dev); /* ignore errors */
        up(&dev->sem);
    }
    return 0;          /* success */
}

/* close 方法 */
int scull_release(struct inode *inode, struct file *filp)
{
    return 0;
}

/*
 * Follow the list
 * 把指针定位到第n个量子集
 */
struct scull_qset *scull_follow(struct scull_dev *dev, int n)
{
    struct scull_qset *qs = dev->data;

    /* Allocate first qset explicitly if need be */
    if (! qs) { /* 对 write 有效 */
        /* 申请用于保存链表项的空间 */
        qs = dev->data = kmalloc(sizeof(struct scull_qset), GFP_KERNEL);
        if (qs == NULL)
            return NULL;  /* Never mind */
        /* qs->data 和 qs->next 都被初始化为 NULL */
        memset(qs, 0, sizeof(struct scull_qset));
    }

    /* Then follow the list */
    while (n--) {
        if (!qs->next) { /* 对 write 有效 */
            /* 申请用于保存链表项的空间 */
            qs->next = kmalloc(sizeof(struct scull_qset), GFP_KERNEL);
            if (qs->next == NULL)
                return NULL;  /* Never mind */
            /* qs->next->data 和 qs->next->next 都被初始化为 NULL */
            memset(qs->next, 0, sizeof(struct scull_qset));
        }
        qs = qs->next;
        continue;
    }
    return qs;
}

/*
 * Data management: read and write
 */

ssize_t scull_read(struct file *filp, char __user *buf, size_t count,
        loff_t *f_pos)
{
    struct scull_dev *dev = filp->private_data;
    struct scull_qset *dptr;	/* the first listitem */
    int quantum = dev->quantum, qset = dev->qset;
    int itemsize = quantum * qset; /* how many bytes in the listitem */
    int item, s_pos, q_pos, rest;
    ssize_t retval = 0;

    if (down_interruptible(&dev->sem)) /* 获取信号量 */
        return -ERESTARTSYS;
    if (*f_pos >= dev->size)
        goto out;
    if (*f_pos + count > dev->size)
        count = dev->size - *f_pos;

    /* find listitem, qset index, and offset in the quantum */
    item = (long)*f_pos / itemsize; /* 在那个量子集? */
    rest = (long)*f_pos % itemsize; /* 不够一个量子集的部分 */
    s_pos = rest / quantum;         /* 在那个量子? */
    q_pos = rest % quantum;      /* 量子中的那个位置(字节)? */

    /* follow the list up to the right position (defined elsewhere) */
    /* 能执行到这则说明要读取的字节必定存在, 因为前面已对 *f_pos 进行了检查 */
    dptr = scull_follow(dev, item);

    if (dptr == NULL || !dptr->data || ! dptr->data[s_pos])
        goto out; /* don't fill holes */

    /* read only up to the end of this quantum */
    if (count > quantum - q_pos)
        count = quantum - q_pos;

    if (copy_to_user(buf, dptr->data[s_pos] + q_pos, count)) {
        retval = -EFAULT;
        goto out;
    }
    *f_pos += count;
    retval = count;

out:
    up(&dev->sem);
    return retval;
}

/* 一次最多写入一个量子大小的数据 */
ssize_t scull_write(struct file *filp, const char __user *buf, size_t count,
        loff_t *f_pos)
{
    struct scull_dev *dev = filp->private_data;
    struct scull_qset *dptr;
    int quantum = dev->quantum, qset = dev->qset;
    int itemsize = quantum * qset;
    int item, s_pos, q_pos, rest;
    ssize_t retval = -ENOMEM; /* value used in "goto out" statements */

    if (down_interruptible(&dev->sem))
        return -ERESTARTSYS;

    /* find listitem, qset index and offset in the quantum */
    item = (long)*f_pos / itemsize; /* 在那个量子集? */
    rest = (long)*f_pos % itemsize; /* 不够一个量子集的部分 */
    s_pos = rest / quantum;         /* 在那个量子? */
    q_pos = rest % quantum;         /* 量子中的那个字节? */

    /* follow the list up to the right position */
    dptr = scull_follow(dev, item); /* 定位到正确的量子集 */
    if (dptr == NULL)
        goto out;
    if (!dptr->data) {
        /* 为 "保存在量子集中指向量子的指针(量子目录)" 申请空间 */
        dptr->data = kmalloc(qset * sizeof(char *), GFP_KERNEL);
        if (!dptr->data)
            goto out;
        memset(dptr->data, 0, qset * sizeof(char *));
    }
    if (!dptr->data[s_pos]) {
        /* 申请一个量子大小的存储空间 */
        dptr->data[s_pos] = kmalloc(quantum, GFP_KERNEL);
        if (!dptr->data[s_pos])
            goto out;
    }
    /* write only up to the end of this quantum */
    if (count > quantum - q_pos)
        count = quantum - q_pos;

    if (copy_from_user(dptr->data[s_pos]+q_pos, buf, count)) {
        retval = -EFAULT;
        goto out;
    }
    *f_pos += count;
    retval = count;

    /* update the size */
    if (dev->size < *f_pos)
        dev->size = *f_pos;

out:
    up(&dev->sem);
    return retval;
}

/*
 * The ioctl() implementation
 */
int scull_ioctl(struct inode *inode, struct file *filp,
        unsigned int cmd, unsigned long arg)
{

    int err = 0, tmp;
    int retval = 0;

    /*
     * extract the type and number bitfields, and don't decode
     * wrong cmds: return ENOTTY (inappropriate ioctl) before access_ok()
     */
    if (_IOC_TYPE(cmd) != SCULL_IOC_MAGIC) /* 即: 幻数 */
        return -ENOTTY;
    if (_IOC_NR(cmd) > SCULL_IOC_MAXNR)
        return -ENOTTY;

    /*
     * the direction is a bitmask, and VERIFY_WRITE catches R/W
     * transfers. `Type' is user-oriented, while
     * access_ok is kernel-oriented, so the concept of "read" and
     * "write" is reversed
     */
    /* _IOC_READ, _IOC_WRITE 等读写方向都是从用户空间的角度看的 */
    if (_IOC_DIR(cmd) & _IOC_READ) /* 检测是否有读取数据的权限 */
        err = !access_ok(VERIFY_WRITE, (void __user *)arg, _IOC_SIZE(cmd));
    else if (_IOC_DIR(cmd) & _IOC_WRITE) /* 检测是否有写入数据的权限 */
        err =  !access_ok(VERIFY_READ, (void __user *)arg, _IOC_SIZE(cmd));
    if (err) return -EFAULT;

    switch(cmd) {

        case SCULL_IOCRESET:
            scull_quantum = SCULL_QUANTUM;
            scull_qset = SCULL_QSET;
            break;

        case SCULL_IOCSQUANTUM: /* Set: arg points to the value */
            if (! capable (CAP_SYS_ADMIN)) /* 是否有系统管理操作的权限? */
                return -EPERM;
            retval = __get_user(scull_quantum, (int __user *)arg);
            break;

        case SCULL_IOCTQUANTUM: /* Tell: arg is the value */
            if (! capable (CAP_SYS_ADMIN))
                return -EPERM;
            scull_quantum = arg;
            break;

        case SCULL_IOCGQUANTUM: /* Get: arg is pointer to result */
            retval = __put_user(scull_quantum, (int __user *)arg);
            break;

        case SCULL_IOCQQUANTUM: /* Query: return it (it's positive) */
            return scull_quantum;

        case SCULL_IOCXQUANTUM: /* eXchange: use arg as pointer */
            if (! capable (CAP_SYS_ADMIN))
                return -EPERM;
            tmp = scull_quantum;
            retval = __get_user(scull_quantum, (int __user *)arg);
            /* __get_user() 成功执行则返回 0 */
            if (retval == 0)
                retval = __put_user(tmp, (int __user *)arg); /* tmp => arg */
            break;

        case SCULL_IOCHQUANTUM: /* sHift: like Tell + Query */
            if (! capable (CAP_SYS_ADMIN))
                return -EPERM;
            tmp = scull_quantum;
            scull_quantum = arg;
            return tmp;

        case SCULL_IOCSQSET:
            if (! capable (CAP_SYS_ADMIN))
                return -EPERM;
            retval = __get_user(scull_qset, (int __user *)arg);
            break;

        case SCULL_IOCTQSET:
            if (! capable (CAP_SYS_ADMIN))
                return -EPERM;
            scull_qset = arg;
            break;

        case SCULL_IOCGQSET:
            retval = __put_user(scull_qset, (int __user *)arg);
            break;

        case SCULL_IOCQQSET:
            return scull_qset;

        case SCULL_IOCXQSET:
            if (! capable (CAP_SYS_ADMIN))
                return -EPERM;
            tmp = scull_qset;
            retval = __get_user(scull_qset, (int __user *)arg);
            if (retval == 0)
                retval = put_user(tmp, (int __user *)arg);
            break;

        case SCULL_IOCHQSET:
            if (! capable (CAP_SYS_ADMIN))
                return -EPERM;
            tmp = scull_qset;
            scull_qset = arg;
            return tmp;

            /*
             * The following two change the buffer size for scullpipe.
             * The scullpipe device uses this same ioctl method, just to
             * write less code. Actually, it's the same driver, isn't it?
             */

        case SCULL_P_IOCTSIZE:
            scull_p_buffer = arg;
            break;

        case SCULL_P_IOCQSIZE:
            return scull_p_buffer;


        default:  /* redundant, as cmd was checked against MAXNR */
            return -ENOTTY;
    }
    return retval;

}



/*
 * The "extended" operations -- only seek
 */

loff_t scull_llseek(struct file *filp, loff_t off, int whence)
{
    struct scull_dev *dev = filp->private_data;
    loff_t newpos;

    /* off 可以是负值 */
    switch(whence) {
        case 0: /* SEEK_SET */
            newpos = off;
            break;

        case 1: /* SEEK_CUR */
            newpos = filp->f_pos + off;
            break;

        case 2: /* SEEK_END */
            newpos = dev->size + off;
            break;

        default: /* can't happen */
            return -EINVAL;
    }
    if (newpos < 0) return -EINVAL;
    filp->f_pos = newpos;
    return newpos;
}



struct file_operations scull_fops = {
    .owner =    THIS_MODULE,
    .llseek =   scull_llseek,
    .read =     scull_read,
    .write =    scull_write,
    .ioctl =    scull_ioctl,
    .open =     scull_open,
    .release =  scull_release,
};

/*
 * Finally, the module stuff
 */

/*
 * The cleanup function is used to handle initialization failures as well.
 * Thefore, it must be careful to work correctly even if some of the items
 * have not been initialized
 */
void scull_cleanup_module(void)
{
    int i;
    dev_t devno = MKDEV(scull_major, scull_minor);

    /* Get rid of our char dev entries */
    /* 清理 scull(scull0 ... scull3) */
    if (scull_devices) {
        for (i = 0; i < scull_nr_devs; i++) {
            scull_trim(scull_devices + i);
            cdev_del(&scull_devices[i].cdev); /* 从系统中移除字符设备 */
        }
        kfree(scull_devices);
    }

#ifdef SCULL_DEBUG /* use proc only if debugging */
    scull_remove_proc();
#endif

    /* cleanup_module is never called if registering failed */
    unregister_chrdev_region(devno, scull_nr_devs);

    /* and call the cleanup functions for friend devices */
    scull_p_cleanup();
    scull_access_cleanup();

}


/*
 * Set up the char_dev structure for this device.
 */
static void scull_setup_cdev(struct scull_dev *dev, int index)
{
    int err, devno = MKDEV(scull_major, scull_minor + index);

    /* cdev_init 中的参数 scull_fops 的作用是什么? QQQQQ */
    cdev_init(&dev->cdev, &scull_fops); /* 初始化 cdev */
    dev->cdev.owner = THIS_MODULE;
    dev->cdev.ops = &scull_fops; /* MMMMM */ /* 没有该语句可以吗? QQQQQ */
    /* 通告内核该结构(cdev)的信息(把cdev信息保存在inode中). MMMMM */
    err = cdev_add(&dev->cdev, devno, 1); /* devno 是第一个设备编号 */
    /* Fail gracefully if need be */
    if (err)
        printk(KERN_NOTICE "Error %d adding scull%d", err, index);
}


int scull_init_module(void)
{
    int result, i;
    dev_t dev = 0;

    /*
     * Get a range of minor numbers to work with, asking for a dynamic
     * major unless directed otherwise at load time.
     */
    /* 申请设备号 */
    if (scull_major) { /* 使用预先定义的编号 */
        printk(KERN_NOTICE "major -> static alloc\n");
        dev = MKDEV(scull_major, scull_minor);
        /* "scull" 将会出现在 /proc/devices 文件中 */
        result = register_chrdev_region(dev, scull_nr_devs, "scull");
    } else { /* 动态申请 */
        printk(KERN_NOTICE "major -> dynamic alloc\n");
        /* dev : 成功返回后其保存的是已分配范围的第一个编号 */
        result = alloc_chrdev_region(&dev, scull_minor, scull_nr_devs,
                "scull");
        scull_major = MAJOR(dev); /* 留存 */
    }
    if (result < 0) {
        printk(KERN_WARNING "scull: can't get major %d\n", scull_major);
        return result;
    }

    /*
     * allocate the devices -- we can't have them static, as the number
     * can be specified at load time
     */
    /* 申请空间保存设备的必要信息 */
    scull_devices = kmalloc(scull_nr_devs * sizeof(struct scull_dev),
            GFP_KERNEL);
    if (!scull_devices) {
        result = -ENOMEM;
        goto fail;  /* Make this more graceful */
    }
    memset(scull_devices, 0, scull_nr_devs * sizeof(struct scull_dev));

    /* Initialize each device. */ /* 初始化 scull */
    for (i = 0; i < scull_nr_devs; i++) {
        scull_devices[i].quantum = scull_quantum;
        scull_devices[i].qset = scull_qset;
        init_MUTEX(&scull_devices[i].sem); /* 信号量变量初始化为1 */
        scull_setup_cdev(&scull_devices[i], i);
    }

    /* At this point call the init function for any friend device */
    /* 初始化 scullpipe, sculla,  要使用的编号是紧接着 scull 的后边. */
    dev = MKDEV(scull_major, scull_minor + scull_nr_devs);
    dev += scull_p_init(dev); /* 初始化 scullpipe */
    dev += scull_access_init(dev); /* 初始化 sculla */

#ifdef SCULL_DEBUG /* only when debugging */
    scull_create_proc();
#endif

    return 0; /* succeed */

fail:
    scull_cleanup_module();
    return result;
}

module_init(scull_init_module);
module_exit(scull_cleanup_module);
