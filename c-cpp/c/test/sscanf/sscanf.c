/*
 * ===========================================================================
 *
 *       Filename:  sscanf.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年04月06日 11时10分28秒
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


/*
 * gcc sscanf.c
 *
 * */

#include <stdio.h>
#include <string.h>


int main (int argc, char *argv[])
{
    char m_szRoomIP[18]="192.168.19.1";
    int a1, a2, a3, a4;

    a1 = a2 = a3 = a4 = 0;
    sscanf(m_szRoomIP, "%d.%d.%d.%d", &a1, &a2, &a3, &a4);
    printf("%d %d %d %d\n", a1, a2, a3, a4);

    return 0;

}
