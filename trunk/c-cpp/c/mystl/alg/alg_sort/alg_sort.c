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


#define SORT_CUTOFF     10



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


/*==========================================================================*
*  @Description:
*       选择排序
*
*  @Param   base
*  @Param   nmemb
*  @Param   size
*  @Param   compar
*
*==========================================================================*/
void Sort_selectSort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *))
{
#define SWAP(a, b, t)  ( (t)=(a), (a)=(b), (b)=(t) )
    assert(base != NULL && nmemb >= 1 && size >= 1 && compar != NULL);

    int s;
    char t, *i, *j, *min;
    char *left = base;
    char *right = left + (nmemb - 1) * size;

    for ( i = left; i <= right - size; i += size )
    {
        min = i;
        for ( j = i + size; j <= right; j += size )
        {
            if ( compar(j, min) < 0 )
                min = j;
        }
        if ( i != min )
            for ( s = 0; s < size; s++ )
                SWAP(*(i+s), *(min+s), t);
    }
#undef SWAP
}


/*==========================================================================*
*  @Description:
*       冒泡排序
*
*  @Param   base
*  @Param   nmemb
*  @Param   size
*  @Param   compar
*
*==========================================================================*/
void Sort_bubbleSort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *))
{
#define SWAP(a, b, t)  ( (t)=(a), (a)=(b), (b)=(t) )
    assert(base != NULL && nmemb >= 1 && size >= 1 && compar != NULL);

    int s, isSwap;
    char t, *i, *j;
    char *left = base;
    char *right = base + (nmemb - 1) * size;

    for ( i = left; i < right; i += size )
    {
        isSwap = 0;
        for ( j = right; j > i; j -= size )
        {
            if ( compar(j, j-size) < 0 )
            {
                isSwap = 1;
                for ( s = 0; s < size; s++ )
                    SWAP(*(j+s), *(j-size+s), t);
            }
        }
        if ( isSwap == 0 )
            break;
    }
#undef SWAP
}


/*==========================================================================*
*  @Description:
*       取三者间的中间值
*
*  @Param   left
*  @Param   right
*  @Param   size
*  @Param   compar
*
*  @Returns:
*==========================================================================*/
static char* Sort_median3(char *left, char *right, int size,
        int(*compar)(const void *, const void *))
{
#define SWAP(a, b, t)  ( (t)=(a), (a)=(b), (b)=(t) )
    int s;
    char t;
    // char *center = left + (right - left) / 2;    // 错误!!
    // 每一步计算都必须取整! 才不至于最后的结果位于字节内!
    char *center = left + (((right - left) / size) / 2) * size;

    if ( compar(left, center) > 0 )
        for ( s = 0; s < size; s++ )
            SWAP(*(left+s), *(center+s), t);
    if ( compar(left, right) > 0 )
        for ( s = 0; s < size; s++ )
            SWAP(*(left+s), *(right+s), t);
    if ( compar(center, right) > 0 )
        for ( s = 0; s < size; s++ )
            SWAP(*(center+s), *(right+s), t);

    for ( s = 0; s < size; s++ )
        SWAP(*(center+s), *(right-size+s), t);

    return right - size;

#undef SWAP
}


/*==========================================================================*
*  @Description:
*       快速排序
*
*  @Param   left
*  @Param   right
*  @Param   size
*  @Param   compar
*==========================================================================*/
static void Sort_quicklySort_priv(char *left, char *right, int size,
        int(*compar)(const void *, const void *))
{
#define SWAP(a, b, t)  ( (t)=(a), (a)=(b), (b)=(t) )

    int s;
    char t, *i, *j, *pivot;

    if ( left + SORT_CUTOFF * size <= right )
    {
        pivot = Sort_median3(left, right, size, compar);
        i = left;
        j = right - size;
        for ( ; ; )
        {
            for ( i += size; compar(i, pivot) < 0; i += size ) { }
            for ( j -= size; compar(j, pivot) > 0; j -= size ) { }
            if ( i < j )
            {
                for ( s = 0; s < size; s++ )
                    SWAP(*(i+s), *(j+s), t);
            }
            else
                break;
        }
        for ( s = 0; s < size; s++ )
            SWAP(*(i+s), *(right-size+s), t);

        Sort_quicklySort_priv(left, i - size, size, compar);
        Sort_quicklySort_priv(i + size, right, size, compar);
    }
    else
        Sort_insertSort(left, (right-left)/size + 1, size, compar);
#undef SWAP
}


/*==========================================================================*
*  @Description:
*       快速排序驱动例程
*
*  @Param   base
*  @Param   nmemb
*  @Param   size
*  @Param   compar
*==========================================================================*/
void Sort_quicklySort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *))
{
    assert(base != NULL && nmemb >= 1 && size >= 1 && compar != NULL);

    if ( nmemb <= 1 )
        return;

    if ( nmemb >= SORT_CUTOFF )
        Sort_quicklySort_priv(base, base + (nmemb-1)*size, size, compar);
    else
        Sort_insertSort(base, nmemb, size, compar);
}

