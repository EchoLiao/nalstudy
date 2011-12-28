/*
 * ===========================================================================
 *
 *       Filename:  unicode_utf-8.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2011年12月23日 15时23分48秒
 *        Created:
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


#ifndef UNICODE_UTF_8_H_
#define UNICODE_UTF_8_H_

/*
 * 根据字符的UTF-8编码的第一个字节求出该字符用UTF-8编码存储时所需要多少个
 * 字节空间. 特殊地, 对于只占一个字节的字符(ASCII), 返回值为 0 .
 * */
int enc_get_utf8_size(unsigned char c);


/*
 * 将一个字符的UTF8编码转换成Unicode(UCS-2和UCS-4)编码.
 * */
int enc_utf8_to_unicode_one(const unsigned char *pInput, unsigned long *Unic);

/*
 * 将一个字符的Unicode(UCS-2和UCS-4)编码转换成UTF-8编码.
 * */
int enc_unicode_to_utf8_one(unsigned long unic, unsigned char *pOutput, int outSize);


/*
 * 将字符串的UTF8编码转换成Unicode(UCS-2和UCS-4)编码.
 * */
int enc_utf8_to_unicode(const unsigned char *pInput, int nMembIn,
        unsigned long *pOutput, int *nMembOut);

/* 
 * 将以0结束的字符串的UTF8编码转换成Unicode(UCS-2和UCS-4)编码.
 * */
int enc_utf8_to_unicode_str(const unsigned char *pInput,
        unsigned long *pOutput, int *nMembOut);


/*
 * 将字符串的Unicode(UCS-2和UCS-4)编码转换成UTF8编码.
 * */
int enc_unicode_to_utf8(const unsigned long *pInput, int nMembIn,
        unsigned char *pOutput, int *nMembOut);

/* 
 * 将字符串的Unicode(UCS-2和UCS-4)编码(以0结束)转换成UTF8编码.
 * */
int enc_unicode_to_utf8_str(const unsigned long *pInput,
        unsigned char *pOutput, int *nMembOut);


#endif // UNICODE_UTF_8_H_
