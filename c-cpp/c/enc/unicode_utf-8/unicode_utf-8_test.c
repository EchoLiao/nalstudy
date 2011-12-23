/*
 * ===========================================================================
 *
 *       Filename:  unicode_utf-8_test.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2011年12月23日 17时01分39秒
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
#include <memory.h>
#include <string.h>
#include <assert.h>
#include "unicode_utf-8.h"


#define BUF_LEN 128


int main(int argc, char** argv)
{

#if 0
    //汉字"我"的UTF8编码是 E6 88 91, Unicode编码是 62 11
    char str[20] = {
        0xE6, 0x88, 0x91, // 我
        0xE4, 0xB8, 0x8D, // 不
        0xE8, 0xA6, 0x81, // 要
        0x00,
    };
#else
    // 请保证该文件是以 utf-8 格式存储的!
    char str[20] = "我不要";
#endif
    char uni[BUF_LEN] = { 0 };
    int i;

    int num = enc_utf8_to_unicode(str, uni, BUF_LEN);

    if (num == -1)
    {
        printf("Error!\n");
    }
    else
    {
        if ( num + 2 + 1 >= BUF_LEN )
            fprintf(stderr, "May be NO enuogh space to convertion!\n");

        unsigned char* p = (unsigned char *)uni;
#if 0
        for (i = 0; i < num; i++)
        {
            printf("%02X", *p);
            p++;
        }
        printf("\n");
#else
        for ( i = 0; i < num; i += 2 )
        {
            printf("%x\n", *((unsigned short*)p));
            p += 2;
        }
#endif
    }

    return 0;
}
