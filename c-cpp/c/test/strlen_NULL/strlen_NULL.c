/*
 * ===========================================================================
 *
 *       Filename:  strlen_NULL.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012/08/29 14时09分02秒
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

#include "stdio.h"
#include "string.h"

int main (int argc, char *argv[])
{
    char *p = NULL;
    int len = strlen(p); // false!!

    printf("@..%d", len);

    return 0;
}
