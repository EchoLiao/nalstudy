/*
 * nbtest.c: read and write in non-blocking mode
 * This should run with any Unix
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
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>

char buffer[4096];

/* 测试非阻塞型操作 */
int main(int argc, char **argv)
{
    int delay = 1, n, m = 0;

    if (argc > 1)
        delay=atoi(argv[1]);
    fcntl(0, F_SETFL, fcntl(0,F_GETFL) | O_NONBLOCK); /* stdin */
    fcntl(1, F_SETFL, fcntl(1,F_GETFL) | O_NONBLOCK); /* stdout */

    while (1) {
        /* 没有数据可读时: 第一次返回0, 之后返回负值. */
        n = read(0, buffer, 4096); /* 立即返回 */

        if (n >= 0) /* 可以把该语句注释后再对比测试 */
        {
            m = write(1, buffer, n);
            /* n = -1; */
        }

        if ((n < 0 || m < 0) && (errno != EAGAIN))
            break;
        /* if ( n == 0 || m == 0) */
        /* { */
            /* printf("end of file\n"); */
            /* [>exit(0);<] */
        /* } */

        sleep(delay);
    }
    perror(n < 0 ? "read from stdin, but no data" : "write to stdout, but");
    exit(1);
}
