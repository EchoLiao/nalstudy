/*
 * =====================================================================================
 *
 *       Filename:  watch.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2010年07月24日 10时00分45秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerll (nuoliu), lcy3636@126.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
    int num = 1;
    printf("Loading RAM disk onto /dev/ram:\33[23C Loaded:    0 KB\n"); /* QQQQQ */

    /* bug : 输出时, 终端能接受键盘按键! 修正: ./watch2.c AAAAA */
    printf("Now number: #######");
    while ( 1 )
    {
	printf("\b\b\b\b\b\b%06d", num); /* 使用退格键: \b */
	fflush(NULL);
	num += 11;
	sleep(1);
    }

    printf("\b\b\b\b\b");
    return 0;
}

