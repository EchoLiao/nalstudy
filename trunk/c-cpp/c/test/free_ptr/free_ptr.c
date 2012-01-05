/*
 * ===========================================================================
 *
 *       Filename:  free_ptr.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年01月05日 09时59分25秒
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
#include <stdlib.h>

int main (int argc, char *argv[])
{
    int *p1 = malloc(sizeof(int));
    int *p2 = p1;

    *p1 = 9;

    printf("%p %p\n", p1, p2);
    printf("%d %d\n", *p1, *p2);
    printf("\n");

    /*
       若已free指针p2, 但没设为NULL;
       则p2的值不变, p2所指向的空间的内容是不可预知的.
    */
    free(p2);
    printf("%p %p\n", p1, p2);
    printf("%d %d\n", *p1, *p2);
    printf("\n");

    /*
       若已free指针p2, 且已设为NULL;
       则p2的值为NULL, p2所指向的空间不可访问!
    */
    p2 = NULL;
    printf("%p %p\n", p1, p2);
    printf("%d %d\n", *p1, *p2);
    printf("\n");

    return 0;
}
