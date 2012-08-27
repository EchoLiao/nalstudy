/*
 * ===========================================================================
 *
 *       Filename:  and_or.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012/08/27 17时39分51秒
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
#include <assert.h>


int main (int argc, char *argv[])
{
    /* char *str = "abc";
    if ( (unsigned char)*str >= (unsigned char)0x81
            && (unsigned char)*str <= (unsigned char)0x9f
            || (unsigned char)*str >= (unsigned char)0xe0
            && (unsigned char)*str <= (unsigned char)0xfc
       ) {
        printf("abcd\n");
    } */

    int i, j, k, m;

    for ( i = 0; i <= 1; i++ ) {
        for ( j = 0; j <= 1; j++ ) {
            for ( k = 0; k <= 1; k++ ) {
                for ( m = 0; m <= 1; m++ ) {
                    int ret1 =  ( i && j || k && m );
                    int ret2 =  ( (i && j) || (k && m) );
                    // int ret2 =  ( ((i && j) || k) && m ); // 错误!!
                    printf("(%d, %d, %d, %d); ret1=%d, ret2=%d\n",
                            i, j, k, m, ret1, ret2);
                    assert(ret1 == ret2);
                }
            }
        }
    }

    return 0;
}
