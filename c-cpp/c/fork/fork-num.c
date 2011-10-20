/*
 * ===========================================================================
 *
 *       Filename:  fork-num.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年10月11日 21时11分56秒
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

#include <unistd.h>

int main (int argc, char *argv[])
{
#if 0
    // 包括main进程, 共产生16个进程.
    fork();
    fork();
    fork();
    fork();
#else
    // 包括main进程, 共产生5个进程.
    // 这更像是数学题, 只需要数一下有几个端点, 就知道共有几个进程了!
    //
    // F            -------------------------------
    //                     |P                 |C
    // F            ------------------        1
    //              |P               |C
    // F      --------------         2
    //        |P           |C
    // F   ------          3
    //     |P   |C
    //     5    4
    //
    // fork() && fork() && fork() && fork();
#endif

    while ( 1 )
    {
        sleep(3);
    }

    return 0;
}

