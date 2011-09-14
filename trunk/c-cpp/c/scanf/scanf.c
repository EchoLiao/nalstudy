/*
 * ===========================================================================
 *
 *       Filename:  scanf.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年09月14日 15时34分06秒
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

#define IW_FILE "weneed.txt"

int main (int argc, char *argv[])
{
    int id, level, count, i;
    char mac[18], essid[33];
    FILE *pf = NULL;

    if ( (pf = fopen(IW_FILE, "r")) == NULL )
    {
        printf("can not open file\n");
        exit(1);
    }

    fscanf(pf, "%d\n", &count);
    printf("there    count=%d\n", count);
    for ( i = 0; i < count; i++ )
    {
        fscanf(pf, "%d %s %s %d\n", &id, mac, essid, &level);
        printf("NAL %d; %s; %s; %d\n", id, mac, essid, level);
    }

    fclose(pf);
    return 0;
}
