/*
 * ===========================================================================
 *
 *       Filename:  extern2.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年02月17日 16时08分59秒
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

int A = 44;

int main (int argc, char *argv[])
{
    extern int A;
    extern int A;

    A = 3;

    extern int A;

    printf("%d\n", A);

    return 0;
}


/* 
   gcc -Wall -g extern2.c
 * */
