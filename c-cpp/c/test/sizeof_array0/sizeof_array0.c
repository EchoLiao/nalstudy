/*
 * ===========================================================================
 *
 *       Filename:  sizeof_array0.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年02月16日 10时07分11秒
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
    int A[0];
    int B[1] = { 44 };

    int a = sizeof(A);  // 等于 0 !

    printf("%d\n", a);
    printf("B[0]=%d\n", B[0]);
    printf("&A[0]:%p\n&A[1]:%p\n&B[0]:%p\n", &A[0], &A[1], B);
    printf("\n");

    A[0] = 2;
    A[1] = 3;

    printf("A[0]=%d, A[1]=%d, B[0]=%d\n", A[0], A[1], B[0]);
    printf("\n");

    return 0;
}

