/*
 * =====================================================================================
 *
 *       Filename:  testExcept.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年06月01日 23时18分47秒
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

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "except.h"

Except_T Allocate_Failed = { "(& Allcation failed &)" };

char* edit(int argc, char *argv[])
{
    char *p = NULL;

    p = malloc(-1); // Force an excepttion
    if ( p )
        return p;
    RAISE(Allocate_Failed);
    assert(0);
    return NULL;
}

int main (int argc, char *argv[])
{
    TRY
        edit(argc, argv);
    EXCEPT(Allocate_Failed)
        fprintf(stdout, "(& catch Allocate_Failed &)\n");
    ELSE
        fprintf(stderr, "(& An internal eroor has occurred &)\n");
        RERAISE;
    END_TRY;

    return 0;
}
