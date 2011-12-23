/*
 * ===========================================================================
 *
 *       Filename:  unicode_utf-8.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2011年12月23日 15时23分45秒
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
 * Unicode有二字节编码(UCS-2)和四字节编码(UCS-4)两种, 目前常用的二字节编码. 下
 * 面程序给出的是UTF-8转成Unicode(UCS-2)的函数.
 */


#include <string.h>
#include <assert.h>



/*****************************************************************************
 * 将UTF8编码转换成Unicode(UCS-2)编码.
 *
 * 参数:
 *    char* pInput   指向输入字符串(以'\0'结尾)的指针
 *    char* pOutput  指向输出字符串指针的指针
 *    int   outsize  pOutput 缓冲的大小
 *
 * 返回值:
 *    返回转换后的Unicode字符串的字节数, 如果出错则返回 -1
 *
 * 注意:
 *     1. UTF8没有字节序问题, 但是Unicode字符有字节序,
 *        字节序分为大端(Big Endian)和小端(Little Endian)两种,
 *        在Intel处理器中采用小端法表示, 本例中采用小端法表示. (低地址存低位)
 *     2. 请保证 pOutput 缓冲区有足够的空间, 若空间不足, 则只进行部分转换.
 ****************************************************************************/
int enc_utf8_to_unicode(const char* pInput, char* pOutput, int outsize)
{
    assert(pInput != NULL && pOutput != NULL);
    assert(outsize >= 3);

    int  outputSize = 0;  //记录转换后的Unicode字符串的字节数
    char *pout = pOutput;

    while ( *pInput && outputSize + 2 + 1 <= outsize )
    {
        if (*pInput > 0x00 && *pInput <= 0x7F) // 处理单字节UTF8字符
        {
            *pout     = *pInput;
            *(pout+1) = 0;       // 小端法表示, 在高地址填补0
            pInput += 1;
        }
        else if (((*pInput) & 0xE0) == 0xC0) // 处理双字节UTF8字符
        {
            char high = *pInput;
            char low  = *(pInput + 1);

            if ((low & 0xC0) != 0x80) // 检查是否为合法的UTF8字符表示
                return -1;

            *pout     = (high << 6) + (low & 0x3F);
            *(pout+1) = (high >> 2) & 0x07;
            pInput += 2;
        }
        else if (((*pInput) & 0xF0) == 0xE0) // 处理三字节UTF8字符
        {
            char high   = *pInput;
            char middle = *(pInput + 1);
            char low    = *(pInput + 2);

            if (((middle & 0xC0) != 0x80) || ((low & 0xC0) != 0x80))
                return -1;

            *pout     = (middle << 6) + (low & 0x7F);
            *(pout+1) = (high << 4) + ((middle >> 2) & 0x0F);
            pInput += 3;
        }
        else //对于其他字节数的UTF8字符不进行处理
        {
            return -1;
        }

        pout += 2;
        outputSize += 2;
    }

    *pout = 0;

    return outputSize;
}

