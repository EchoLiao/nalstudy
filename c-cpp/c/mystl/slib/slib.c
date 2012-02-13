/*
 * ===========================================================================
 *
 *       Filename:  slib.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月13日 10时20分43秒
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
#include <string.h>
#include <assert.h>
#include <ctype.h>

#include "slib.h"




/*==========================================================================*
 * @Description:
 *      把字符串 src 复制到 dst, 最多复制 dstsize - 1 个字符;
 *      dst 总是以'\0'结尾!
 *
 * @Param  dst
 * @Param  src
 * @Param  dstsize
 *
 * @Returns:
 *      返回指针 dst !
 *
 *==========================================================================*/
char *sl_strncpy(char *dst, const char *src, int *dstsize)
{
    assert(dst != NULL && src != NULL);

    int len = strlen(src);
    int dsize = *dstsize;

    len = (len >= dsize) ? dsize - 1 : len;
    strncpy(dst, src, len);
    dst[len] = '\0';
    *dstsize = len + 1;

    return dst;
}


/*==========================================================================*
 * @Description:
 *      去除字符串 str 两端的空白字符.
 *
 * @Param  str
 *
 * @Returns:
 *      返回去除了两端空白字符的新字符串.
 *
 *==========================================================================*/
char *sl_remove_agspace(char *str)
{
    assert(str != NULL);
    char *pst = str, *pe;
    int len;

    while ( isspace(*pst) )
        pst++;

    len = strlen(pst);
    if ( len == 0 )
        return pst;

    pe = pst + len - 1;
    while ( (pe - pst) >= 0 && isspace(*pe) )
        pe--;
    *(pe + 1) = '\0';

    return pst;
}

