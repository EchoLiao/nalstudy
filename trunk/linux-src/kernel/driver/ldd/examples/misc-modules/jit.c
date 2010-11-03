/*
 * jit.c -- the just-in-time module
 *
 * Copyright (C) 2001,2003 Alessandro Rubini and Jonathan Corbet
 * Copyright (C) 2001,2003 O'Reilly & Associates
 *
 * The source code in this file can be freely used, adapted,
 * and redistributed in source or binary form, so long as an
 * acknowledgment appears in derived source files.  The citation
 * should list that the code comes from the book "Linux Device
 * Drivers" by Alessandro Rubini and Jonathan Corbet, published
 * by O'Reilly & Associates.   No warranty is attached;
 * we cannot take responsibility for errors or fitness for use.
 *
 * $Id: jit.c,v 1.16 2004/09/26 07:02:43 gregkh Exp $
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>

#include <linux/time.h>
#include <linux/timer.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
#include <linux/types.h>
#include <linux/spinlock.h>
#include <linux/interrupt.h>

#include <asm/hardirq.h>
/*
 * This module is a silly one: it only embeds short code fragments
 * that show how time delays can be handled in the kernel.
 */

int delay = HZ; /* the default delay, expressed in jiffies */

module_param(delay, int, 0);

MODULE_AUTHOR("Alessandro Rubini");
MODULE_LICENSE("Dual BSD/GPL");

/* use these as data pointers, to implement four files in one function */
enum jit_files {
    JIT_BUSY,
    JIT_SCHED,
    JIT_QUEUE,
    JIT_SCHEDTO
};

/*
 * This function prints one line of data, after sleeping one second.
 * It can sleep in different ways, according to the data pointer
 */
/* 延迟执行 */
int jit_fn(char *buf, char **start, off_t offset,
        int len, int *eof, void *data)
{
    unsigned long j0, j1; /* jiffies */
    wait_queue_head_t wait;

    init_waitqueue_head (&wait);
    j0 = jiffies;
    j1 = j0 + delay;

    switch((long)data) {
        case JIT_BUSY: /* 忙等待 */
            while (time_before(jiffies, j1))
                cpu_relax(); /* 让给其它线程 */
            break;
        case JIT_SCHED: /* 让出处理器 */
            while (time_before(jiffies, j1)) {
                schedule();
            }
            break;
        case JIT_QUEUE: /* 超时, 同时也可以被其它进程唤醒 */
            wait_event_interruptible_timeout(wait, 0, delay);
            break;
        case JIT_SCHEDTO: /* 超时2: 只有超时了才会被唤醒 */
            set_current_state(TASK_INTERRUPTIBLE); /* 可中断 */
            schedule_timeout (delay);
            break;
    }
    j1 = jiffies; /* actual value after we delayed */

    len = sprintf(buf, "%9li %9li\n", j0, j1);
    *start = buf;
    return len;
}

/*
 * This file, on the other hand, returns the current time forever
 */
/* 使用 jiffies 计时器；获取当前时间. */
int jit_currentime(char *buf, char **start, off_t offset,
        int len, int *eof, void *data)
{
    struct timeval tv1;
    struct timespec tv2;
    unsigned long j1;
    u64 j2;

    /* get them four */
    j1 = jiffies; /* 自系统启动以来, 滴答的次数. 每秒HZ次. */
    j2 = get_jiffies_64(); /* 对于64位的jiffies应该用专门的函数访问 */
    do_gettimeofday(&tv1);
    tv2 = current_kernel_time();

    /* print */
    len=0;
    len += sprintf(buf,"0x%08lx 0x%016Lx %10i.%06i\n"
            "%40i.%09i\n",
            j1, j2,
            (int) tv1.tv_sec, (int) tv1.tv_usec,
            (int) tv2.tv_sec, (int) tv2.tv_nsec);
    *start = buf;
    return len;
}

/*
 * The timer example follows
 */

int tdelay = 10;
module_param(tdelay, int, 0);

/* This data structure used as "data" for the timer and tasklet functions */
struct jit_data {
    struct timer_list timer; /* 定时器 */
    struct tasklet_struct tlet; /* tasklet: 其在来的时间被调用 */
    int hi; /* tasklet or tasklet_hi */
    wait_queue_head_t wait;
    unsigned long prevjiffies;
    unsigned char *buf; /* 由内核 /proc 模块提供 */
    int loops; /* 定时的次数 */
};
#define JIT_ASYNC_LOOPS 5 /* 设置定时器的次数 */

void jit_timer_fn(unsigned long arg)
{
    struct jit_data *data = (struct jit_data *)arg;
    unsigned long j = jiffies;
    data->buf += sprintf(data->buf, "%9li  %3li     %i    %6i   %i   %s\n",
            j, j - data->prevjiffies, in_interrupt() ? 1 : 0,
            current->pid, smp_processor_id(), current->comm);

    if (--data->loops) { /* 设置新的计时器 */
        data->timer.expires += tdelay;
        data->prevjiffies = j;
        add_timer(&data->timer);
    } else {
        wake_up_interruptible(&data->wait);
    }
}

/* the /proc function: allocate everything to allow concurrency */
int jit_timer(char *buf, char **start, off_t offset,
        int len, int *eof, void *unused_data)
{
    struct jit_data *data;
    char *buf2 = buf;
    unsigned long j = jiffies;

    data = kmalloc(sizeof(*data), GFP_KERNEL);
    if (!data)
        return -ENOMEM;

    init_timer(&data->timer);
    init_waitqueue_head(&data->wait);

    /* write the first lines in the buffer */
    buf2 += sprintf(buf2, "   time   delta  inirq    pid   cpu command\n");
    buf2 += sprintf(buf2, "%9li  %3li     %i    %6i   %i   %s\n",
            j, 0L, in_interrupt() ? 1 : 0, current->pid,
            smp_processor_id(), current->comm); /* 读取该文件的进程 */

    /* fill the data for our timer function */
    data->prevjiffies = j;
    data->buf = buf2;
    data->loops = JIT_ASYNC_LOOPS;

    /* register the timer */
    data->timer.data = (unsigned long)data; /* timer.function 的参数 */
    data->timer.function = jit_timer_fn;
    data->timer.expires = j + tdelay; /* parameter */
    add_timer(&data->timer);

    /* wait for the buffer to fill */
    /* 等待被 jit_timer_fn() 唤醒  */
    wait_event_interruptible(data->wait, !data->loops);
    if (signal_pending(current))
        return -ERESTARTSYS;
    buf2 = data->buf;
    kfree(data);
    *eof = 1;
    return buf2 - buf;
}

void jit_tasklet_fn(unsigned long arg)
{
    struct jit_data *data = (struct jit_data *)arg;
    unsigned long j = jiffies;
    data->buf += sprintf(data->buf, "%9li  %3li     %i    %6i   %i   %s\n",
            j, j - data->prevjiffies, in_interrupt() ? 1 : 0,
            current->pid, smp_processor_id(), current->comm);

    if (--data->loops) {
        data->prevjiffies = j;
        if (data->hi)
            tasklet_hi_schedule(&data->tlet);
        else
            tasklet_schedule(&data->tlet);
    } else {
        wake_up_interruptible(&data->wait);
    }
}

/* the /proc function: allocate everything to allow concurrency */
int jit_tasklet(char *buf, char **start, off_t offset,
        int len, int *eof, void *arg)
{
    struct jit_data *data;
    char *buf2 = buf;
    unsigned long j = jiffies;
    long hi = (long)arg; /* 调度优先级 */

    data = kmalloc(sizeof(*data), GFP_KERNEL);
    if (!data)
        return -ENOMEM;

    init_waitqueue_head (&data->wait);

    /* write the first lines in the buffer */
    buf2 += sprintf(buf2, "   time   delta  inirq    pid   cpu command\n");
    buf2 += sprintf(buf2, "%9li  %3li     %i    %6i   %i   %s\n",
            j, 0L, in_interrupt() ? 1 : 0,
            current->pid, smp_processor_id(), current->comm);

    /* fill the data for our tasklet function */
    data->prevjiffies = j;
    data->buf = buf2;
    data->loops = JIT_ASYNC_LOOPS;

    /* register the tasklet */ /* jit_tasklet_fn 在将来的时间被调用 */
    tasklet_init(&data->tlet, jit_tasklet_fn, (unsigned long)data);
    data->hi = hi;
    if (hi) /* 调度 tasklet 以高优先级执行 */
        tasklet_hi_schedule(&data->tlet);
    else
        tasklet_schedule(&data->tlet);

    /* wait for the buffer to fill */
    wait_event_interruptible(data->wait, !data->loops);

    if (signal_pending(current))
        return -ERESTARTSYS;
    buf2 = data->buf;
    kfree(data);
    *eof = 1;
    return buf2 - buf;
}



int __init jit_init(void)
{
    /* 使用jiffies 和 获取当前时间 */
    create_proc_read_entry("currentime", 0, NULL, jit_currentime, NULL);

    /* 延迟执行 */
    /* (void*)JIT_BUSY 是 jit_fn()的参数! QQAQQ */
    create_proc_read_entry("jitbusy", 0, NULL, jit_fn, (void *)JIT_BUSY);
    create_proc_read_entry("jitsched",0, NULL, jit_fn, (void *)JIT_SCHED);
    create_proc_read_entry("jitqueue",0, NULL, jit_fn, (void *)JIT_QUEUE);
    create_proc_read_entry("jitschedto", 0, NULL, jit_fn,
            (void *)JIT_SCHEDTO);

    /* 内核定时器 */
    create_proc_read_entry("jitimer", 0, NULL, jit_timer, NULL);

    /* tasklet */
    create_proc_read_entry("jitasklet", 0, NULL, jit_tasklet, NULL);
    create_proc_read_entry("jitasklethi", 0, NULL, jit_tasklet, (void *)1);

    return 0; /* success */
}

void __exit jit_cleanup(void)
{
    remove_proc_entry("currentime", NULL);

    remove_proc_entry("jitbusy", NULL);
    remove_proc_entry("jitsched", NULL);
    remove_proc_entry("jitqueue", NULL);
    remove_proc_entry("jitschedto", NULL);

    remove_proc_entry("jitimer", NULL);

    remove_proc_entry("jitasklet", NULL);
    remove_proc_entry("jitasklethi", NULL);
}

module_init(jit_init);
module_exit(jit_cleanup);
