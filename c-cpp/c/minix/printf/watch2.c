/*
 * =====================================================================================
 *
 *       Filename:  watch2.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2010年07月24日 12时53分14秒
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

    while ( 1 )
    {
	printf("                                    ");
	printf("\r"); /* 光标回到行首 */
	printf("Now number: %06d", num);
	fflush(NULL);
	num += 11;
	usleep(10000);
    }

    return 0;
}
