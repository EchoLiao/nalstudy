/*
 * ===========================================================================
 *
 *       Filename:  alg_sort_test.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年02月04日 17时23分50秒
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

#include <alg/alg_rand/alg_rand.h>
#include <debug/memwatch/memwatch.h>
#include "alg_sort.h"



int compint(const void *a, const void *b)
{
    if ( *(int*)a < *(int*)b )
        return -1;
    else  if ( *(int*)a > *(int*)b )
        return 1;
    else
        return 0;
}

int main (int argc, char *argv[])
{
    int i, *A;
    int nmemb = 1000;

    A = Rand_randN(nmemb);
    if ( A == NULL )
    {
        fprintf(stderr, "Rand_randN() Error!!\n");
        exit(1);
    }
#if 0
    for ( i = 0; i < nmemb; i++ )
        printf("%d ", A[i]);
    printf("\n");
#endif
    printf("\n");

    Sort_insertSort(A, nmemb, sizeof(int), compint);

#if 0
    for ( i = 0; i < nmemb; i++ )
        printf("%d ", A[i]);
    printf("\n");
#endif
    printf("\n");

    for ( i = 1; i < nmemb; i++ )
        assert(A[i-1] + 1 == A[i]);


    free(A);

    return 0;
}
