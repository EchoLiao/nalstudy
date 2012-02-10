/*
 * ===========================================================================
 *
 *       Filename:  alg_array.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年01月04日 17时19分16秒
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

#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "alg_arrayrep.h"
#include "alg_array.h"

#define T Array_T

/*==========================================================================*
 * @Description:
 *   新建一个动态数组, 长度为length个单位, 每单位size个字节; size必须大于等于1
 *      1. 若length等于0, 则创建一个零存储空间大小的数组;
 *      2. 若length不等于0, 则分配相应的空间, 并初始化为0.
 *
 * @Param   length
 * @Param   size
 *
 * @Returns:
 *   1. 成功, 则返回新建的动态数组的指针(Array_T*);
 *   2. 失败, 则返回NULL.
 *
 *==========================================================================*/
T Array_new(int length, int size)
{
    assert(length >= 0 && size >= 1);

    T array = NULL;
    void *rep = NULL;

    if ( (array=malloc(sizeof(*array))) == NULL )
        goto _MEM_FAIL;

    if (length > 0)
    {
        if ( (rep=calloc(length, size)) == NULL )
            goto _MEM_FAIL;
        ArrayRep_init(array, length, size, rep);
    }
    else
    {
        ArrayRep_init(array, length, size, NULL);
    }
    return array;

_MEM_FAIL:
    free(array);
    free(rep);
    return NULL;
}

/*==========================================================================*
 * @Description:
 *   初始化动态数组array.
 *
 * @Param   array   指向动态数组
 * @Param   length  数组的长度
 * @Param   size    数组元素的长度
 * @Param   ary     指向动态数组用于保存实际数据的空间
 *
 *==========================================================================*/
void ArrayRep_init(T array, int length, int size, void *ary)
{
    assert(array);
    assert( (ary && length>0) || (length==0 && ary==NULL) );
    assert(size > 0);

    array->length = length;
    array->size   = size;
    if (length > 0)
        array->array = ary;
    else
        array->array = NULL;
}

/*==========================================================================*
 * @Description:
 *   释放动态数组所占用的所有空间.
 *
 * @Param   array
 *
 *==========================================================================*/
void Array_free(T *array)
{
    assert(array && *array);

    free((*array)->array);
    free(*array);
    (*array)->array = NULL;
    *array = NULL;
}

/*==========================================================================*
 * @Description:
 *    取下标为i的元素.
 *
 * @Param   array
 * @Param   i
 *
 * @Returns:
 *   返回下标为i的元素的首地址.
 *
 *==========================================================================*/
void *Array_get(T array, int i)
{
    assert(array);
    assert(i >= 0 && i < array->length);

    return array->array + i*array->size;
}

/*==========================================================================*
 * @Description:
 *    设置下标为i的元素的值为*elem, 大小为array->size.
 *
 * @Param   array
 * @Param   i       下标
 * @Param   elem    要被设置为的数据
 *
 * @Returns:
 *    返回elem.
 *
 *==========================================================================*/
void *Array_put(T array, int i, void *elem)
{
    assert(array);
    assert(i >= 0 && i < array->length);
    assert(elem);

    memcpy(array->array + i*array->size, elem, array->size);

    return elem;
}

/*==========================================================================*
 * @Description:
 *    返回数组的当前长度.
 *
 * @Param   array
 *
 * @Returns:
 *    返回数组的当前长度.
 *
 *==========================================================================*/
int Array_length(T array)
{
    assert(array);
    return array->length;
}

/*==========================================================================*
 * @Description:
 *   返回数组的元素大小.
 *
 * @Param   array
 *
 * @Returns:
 *   返回数组的元素大小.
 *
 *==========================================================================*/
int Array_size(T array)
{
    assert(array);
    return array->size;
}

/*==========================================================================*
 * @Description:
 *    重新调整设置array的大小为length.
 *
 * @Param   array
 * @Param   length
 *
 * @Returns:
 *    1. 若重新设置成功, 则返回1;
 *    2. 若重新设置失败, 则返回0, 且原来的array不做任何发动.
 *
 *==========================================================================*/
int Array_resize(T array, int length)
{
    assert(array);
    assert(length >= 0);

    if (length == 0)
    {
        free(array->array);
        array->array = NULL;
    }
    else if (array->length == 0)
    {
        array->array = malloc(length * array->size);
        if ( array->array == NULL )
            return 0;
    }
    else
    {
        void *p = realloc(array->array, length*array->size);
        if ( p == NULL )
            return 0;
        array->array = p;
    }

    array->length = length;

    return 1;
}

/*==========================================================================*
 * @Description:
 *    创建一个大小为length的新的动态数组, 其内容为array的前
 *    Min(length, array->length)个元素.
 *
 * @Param   array
 * @Param   length
 *
 * @Returns:
 *    若Min(length, array->length)等于0,
 *       返回一个零存储空间大小的数组.
 *    若Min(length, array->length)不等于0,
 *       返回一个Min(length, array->length)大小的数组.
 *    若有错误异常发生, 则返回NULL.
 *
 *==========================================================================*/
T Array_copy(T array, int length)
{
    T copy;
    assert(array);
    assert(length >= 0);

    copy = Array_new(length, array->size);
    if ( copy == NULL )
        return NULL;

    int lenMin = ( copy->length <= array->length ) ?
                 copy->length : array->length;

    if ( lenMin == 0 )
        return copy;

    memcpy(copy->array, array->array, lenMin * array->size);

    return copy;
}
