/*
 * ===========================================================================
 *
 *       Filename:  sizeof_void.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年01月15日 16时45分20秒
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

int main (int argc, char *argv[])
{
    int a = sizeof(void);
    int b = sizeof(void*);

    printf("sizeof(void)=%d, sizeof(void*)=%d,\n", a, b);

    return 0;
}
