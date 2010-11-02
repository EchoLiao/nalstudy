/*
 * asynctest.c: use async notification to read stdin
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
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <fcntl.h>

int gotdata=0;
void sighandler(int signo)
{
    if (signo==SIGIO)
        gotdata++;
    return;
}

char buffer[4096];

/* [<P168>]
 * 用于测试异步通知.
 *
 * 应用程序通常假设套接字和终端才有异步通知能力.
 *
 * */
int main(int argc, char **argv)
{
    int count;
    struct sigaction action;

    memset(&action, 0, sizeof(action));
    /* 当数据到达时, 所有注册为异步通知的进程都会收到一个 SIGIO 信号, 所以我们
     * 应该为 SIGIO 信号注册自己的处理函数. */
    action.sa_handler = sighandler;
    action.sa_flags = 0;
    sigaction(SIGIO, &action, NULL);


    /* 启用文件的异步通知机制: (1), (2) */

    /* (1). 保存进程ID号于 filp->f_woner 中. */
    fcntl(STDIN_FILENO, F_SETOWN, getpid());

    /* (2). 在设备中设置 FASYNC 标志. */
    /* 只要 file->f_fags 中的 FASYNC 标志发生了变化, 就会调用驱动程序的 fasync
     * 方法(即把该进程标志为需要异步通知服务).
     * */
    fcntl(STDIN_FILENO, F_SETFL, fcntl(STDIN_FILENO, F_GETFL) | FASYNC);


    while(1) {
        /* this only returns if a signal arrives */
        /* 通过使用异步通知, 应用程序可在数据可用时收到一个信号(SIGIO).
         * 在此处可以做别的事情(在这选择了睡眠)而不会因read而被阴塞.
         * */
        sleep(86400); /* one day */
        if (!gotdata)
            continue;
        count=read(0, buffer, 4096);
        /* buggy: if avail data is more than 4kbytes... */
        write(1,buffer,count);
        gotdata=0;
    }
}
