/*
 * =====================================================================================
 *
 *       Filename:  testAtom.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年05月29日 17时42分22秒
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
#include <limits.h>
#include <stdlib.h>
#include <time.h>
#include "atom.h"

int main(void)
{
#define TEST_NUM 200000
    int i;
    clock_t bTime, eTime;
    const char *res[TEST_NUM] = { 0 };

    bTime = clock();
    for ( i = 0; i < TEST_NUM; i++ )
    {
        res[i] = (const char *)Atom_int(i);
    }

    for ( i = 0; i < TEST_NUM; i++ )
    {
        Atom_length(res[i]);
    }
    eTime = clock();
    printf("use: %u (clocks)\n", (unsigned int)(eTime - bTime));

    return(0);
}

