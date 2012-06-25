/*
 * ===========================================================================
 *
 *       Filename:  strlen.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年06月25日 09时50分29秒
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
#include <string.h>

int main (int argc, char *argv[])
{
    char *str1 = "abcde\r\n";
    char *str2 = "abcde\0\r\n";

    int len1 = strlen(str1);
    int len2 = strlen(str2);

    printf("str1=%d, str2=%d\n", len1, len2);

    return 0;
}

//
// gcc -Wall strlen.c
//
