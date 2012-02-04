/*
 * ===========================================================================
 *
 *       Filename:  alg_sort.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月04日 15时21分26秒
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
#include <assert.h>



/*==========================================================================*
*  @Description:    
*       插入排序
* 
*  @Param   base
*  @Param   nmemb
*  @Param   size
*  @Param   compar
*==========================================================================*/
void Sort_insertSort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *))
{
#define SWAP(a, b, t)  ( (t)=(a), (a)=(b), (b)=(t) )

    assert(base != NULL && nmemb >= 1 && size >= 1 && compar != NULL);

    char *i, *j, t, *b, *e;
    char *bot = (char*)base;
    char *top = bot + nmemb * size;

    for ( i = bot + size; i < top; i += size )
    {
        for ( j = i; (j-=size) >= bot && compar(i, j) < 0; )
        { }
        if ( i != (j+=size) )
        {
            for ( b = j, e = i-1; b < e; b++, e-- )
                SWAP(*b, *e, t);
            for ( b = i, e = i+size-1; b < e; b++, e-- )
                SWAP(*b, *e, t);
            for ( b = j, e = i+size-1; b < e; b++, e-- )
                SWAP(*b, *e, t);
        }
    }

#undef SWAP
}
