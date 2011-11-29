/*
 * ===========================================================================
 *
 *       Filename:  2dtransf.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年11月29日 22时06分39秒
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

#define PI          3.141592653
#define PI_DIV180   (PI / 180.0)
#define ANG2RAD     PI_DIV180

void n2d_transf(float *xout, float *yout, float x, float y, 
        float a, float tx, float ty)
{
    float sinA = sinf(a);
    float cosA = cosf(a);
    *xout = x*cosA - y*sinA + tx*cosA - ty*sinA;
    *yout = x*sinA + y*cosA + tx*sinA + ty*cosA;
}

int main (int argc, char *argv[])
{
    float x0 = 1.0;
    float y0 = 2.0;
    float px = 2.0;
    float py = 2.0;
    float theta = 45.0;
    float xx, yy;

    float a = -(theta * ANG2RAD);
    float tx = -x0;
    float ty = -y0;

    n2d_transf(&xx, &yy, px, py, a, tx, ty);
    printf("NAL xx=%f, yy=%f\n", xx, yy);

    return 0;
}
