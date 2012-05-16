/*
 * ===========================================================================
 *
 *       Filename:  nal_fps_test.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年03月02日 11时18分32秒
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
#include <math.h>

#include "nal_fps.h"


int main (int argc, char *argv[])
{

    int i, j;
    float f;

    Fps_initProgTime();

    for ( i = 0; i < 10; i++ )
    {
        for ( j = 0; j < 1000000; j++ )
            f = cosf(i);
        Fps_updateFPS();
    }

    f = Fps_getProgTime();

    printf("%f\n", f);

    return 0;
}
