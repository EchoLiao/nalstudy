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
#include "unicode_utf-8_test.h"


#define BUF_LEN 8192


int main(int argc, char** argv)
{
    int ret;

#if 0

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
    // utf[BUF_LEN] = "我不要";
    char utf[BUF_LEN] = "请保证该文件是以 utf-8 格式存储的!";
#endif
    unsigned long uni[BUF_LEN];

    // int utflen = strlen(utf);
    int i, unilen = BUF_LEN;

    // ret = enc_utf8_to_unicode((unsigned char *)utf, utflen, uni, &unilen);
    ret = enc_utf8_to_unicode_str((unsigned char *)utf, uni, &unilen);
    if ( ret == 0 )
    {
        fprintf(stderr, "1a Error!\n");
    }
    else if ( ret == 1 )
    {
        for ( i = 0; i < unilen; i++ )
        {
            printf("%lX ", uni[i]);
        }
        printf("\n");
    }
    else
    {
        fprintf(stderr, "2a No enough space!\n");
    }


// ================================================================
    char utf2[BUF_LEN];
    unsigned long uni2[BUF_LEN] = {
        0x8BF7, 0x4FDD, 0x8BC1, 0x8BE5, 0x6587, 0x4EF6, 0x662F, 0x4EE5,
        0x20, 0x75, 0x74, 0x66, 0x2D, 0x38, 0x20, 0x683C, 0x5F0F,
        0x5B58, 0x50A8, 0x7684, 0x21, 0x0
    };

    int ret2;
    int utflen2 = BUF_LEN;
    // int unilen2 = 0;

    // for ( j = 0; uni2[j] != 0x0; j++ ) { }

    // unilen2 = j;
    /* ret2 = enc_unicode_to_utf8(uni2, unilen2,
            (unsigned char *)utf2, &utflen2); */
    ret2 = enc_unicode_to_utf8_str(uni2, (unsigned char *)utf2, &utflen2);
    if ( ret2 == 0 )
    {
        fprintf(stderr, "1b Error!\n");
    }
    else if ( ret2 == 1 )
    {
        utf2[utflen2] = '\0';
        printf("%s\n", utf2);
    }
    else
    {
        fprintf(stderr, "2b No enough space!\n");
    }
#endif

    // ================================================================
    // 测试方法: ./unicode_utf-8_test < gbk_code_file.txt
    unsigned char gbk[BUF_LEN];
    unsigned char gbk2[BUF_LEN];
    unsigned long unic[BUF_LEN];
    int           outlen = BUF_LEN;

    fread(gbk, 1, BUF_LEN, stdin);
    // fprintf(stderr, "%s", gbk);
    unsigned char *peof = (unsigned char*)strstr((char*)gbk, "EOF");
    assert(peof != NULL && "Must end of 'EOF'!!");
    gbk[peof - gbk] = '\0';

    ret = enc_GBK_to_unicode_str(gbk, unic, &outlen);
    if ( ret == 0 )
    {
        fprintf(stderr, "1b enc_GBK_to_unicode_str Error!\n");
    }
    else if ( ret == 1 )
    {
        unic[outlen] = 0;
        outlen = BUF_LEN;
        ret = enc_unicode_to_GBK_str(unic, gbk2, &outlen);
        if ( ret == 1 )
        {
            gbk2[outlen] = 0;
            // printf("%s", gbk2);
            assert(strcmp((char*)gbk, (char*)gbk2) == 0);
        }
        else
        {
            fprintf(stderr, "1b enc_unicode_to_GBK_str Error!\n");
        }
    }
    else
    {
        fprintf(stderr, "2b No enough space!\n");
    }



    unsigned char utf8[BUF_LEN];
    unsigned char gbk3[BUF_LEN];
    int utf8_len = BUF_LEN;
    int gbk3_len;

    ret = enc_GBK_to_utf8_str(gbk, utf8, &utf8_len);
    // printf("%s", utf8);
    assert(ret == 1);
    gbk3_len = utf8_len;
    ret = enc_utf8_to_GBK_str(utf8, gbk3, &gbk3_len);
    assert(ret == 1);
    assert(strcmp((char*)gbk, (char*)gbk3) == 0);

    return 0;
}
