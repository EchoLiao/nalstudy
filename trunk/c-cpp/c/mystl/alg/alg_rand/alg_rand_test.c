/*
 * ===========================================================================
 *
 *       Filename:  alg_rand_test.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年03月16日 16时38分22秒
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
#include <stdlib.h>
#include <time.h>

#include <debug/memwatch/memwatch.h>
#include <alg/alg_rand/alg_rand.h>

#include "alg_rand_test.h"




int main (int argc, char *argv[])
{
    int i, ret;
    float x = 3.42;
    i = (int)x;
    printf("i=%d\n", i);

    srand(time(NULL));

    i = 0;
    while ( i++ < 300 )
    {
        ret = Rand_int(0, 1);
        printf("%d", ret);
        if ( i % 30 == 0 )
            printf("\n");
    }
    printf("\n");



    return 0;
}

