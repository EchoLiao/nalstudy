/*
 * =====================================================================================
 *
 *       Filename:  extern-static.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年05月18日 15时57分30秒
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

int main (int argc, char *argv[])
{
    /* int gTa; */

    /* 必须加上"extern"表示 gTa 在别的文件中定义! */
    extern int gTa;


    printf("... %d\n", gTa);

    return 0;
}

/* 
    [sre extern-static]$ gcc es.c extern-static.c 
    [sre extern-static]$ 
 */
