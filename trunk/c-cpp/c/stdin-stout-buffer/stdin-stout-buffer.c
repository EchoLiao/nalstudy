/*
 * =====================================================================================
 *
 *       Filename:  stdin-stout-buffer.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年05月19日 13时09分08秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerlz (nuoliu), nuoerlz@gmail.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <stdio.h> 

int main (int argc, char *argv[])
{
    int i;

    while ( 1 ) 
    {
        printf("x");
        usleep(1000);
    }


    return 0;
}

/*  
 *  测试机器:
 *      Linux 2.6.35.6-45.fc14.i686 GNU/Linux
 *
 *  测试结果:
 *      只有当输出的"x"超过1024个时, 终端上才会有显示.
 *
 *  结论:
 *      所以 stdout buffer 的大小为 1024 字节, 因为 I/O 库只有在 buffer 被填充
 *      满之后才会把其输出终端显示.
 */
