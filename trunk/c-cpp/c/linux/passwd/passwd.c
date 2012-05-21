/*
 * ===========================================================================
 *
 *       Filename:  passwd.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年05月21日 22时34分52秒
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
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <pwd.h>
#include <grp.h>

/* 
   getpwuid()
*/
int main (void)
{
    struct passwd *passwd;
    int i = 0;
    for (i = 0; i < 65535; i++)
    {
        if ( NULL != (passwd = getpwuid(i)) )
        {
            printf("uid = %3d\t", i);
            printf ("User: %s\t\t", passwd->pw_name);
            struct group *group;
            group = getgrgid (passwd->pw_gid);
            printf ("Group: %s\n", group->gr_name);
        }
    }

    return 0;
}
