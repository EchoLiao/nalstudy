/*
 * =====================================================================================
 *
 *       Filename:  char_ptr_string_len.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2010年07月25日 18时19分38秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerll (nuoliu), lcy3636@126.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <string.h>

int main (int argc, char *argv[])
{
    char *controller = "c##";
    printf("%d\n", strlen(controller)); /* 3 */
    return 0;
}
