/*
 * ===========================================================================
 *
 *       Filename:  thread.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年02月09日 15时07分01秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerlz (nuoliu), nuoerlz@gmail.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * ===========================================================================
 */

#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

#define NA 100000

static void* doSetConffileForUpdate(void *arg)
{
    int *B, i;

    B = (int*)arg;
    for ( i = 0; i < NA; i++ )
        printf("%d ", B[i]);
    printf("\n");

    while ( 1 ) { sleep(1); }

    return NULL;
}


static void* doListenForUpdate(void *data)
{
    pthread_t	tid;
    int         A[NA] = { 1, 2, 3, 4 };


    /* 
       可以把栈数据传递给新的线程, 但会引入共享问题!
    */
    A[NA - 1] = 55;
    pthread_create(&tid, NULL, &doSetConffileForUpdate, A);
    A[NA - 1] = 66;

    while ( 1 ) { sleep(1); }

    return NULL;
}

int main (int argc, char *argv[])
{
    pthread_t thId;

    pthread_create(&thId, NULL, &doListenForUpdate, NULL);

    while ( 1 ) { sleep(1); }

    return 0;
}
