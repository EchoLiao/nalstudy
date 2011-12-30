/*
 * ===========================================================================
 *
 *       Filename:  table.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2011年12月29日 10时45分13秒
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
#include <limits.h>
#include <assert.h>
#include <stdio.h>
#include "alg_table.h"

#define T Table_T

struct T
{
    int size;
    int (*cmp)(const void *x, const void *y);
    unsigned (*hash)(const void *key);
    int length;
    unsigned timestamp;
    struct binding
    {
        struct binding *link;
        const void *key;
        void *value;
    } **buckets;
};


#define TABLE_HASH(table, key)  \
    ( (*((table)->hash))((key)) % ((table)->size) )




/*==========================================================================*
 * @Description:
 *      默认的key比较函数.
 *      对于atom, 我们需要比较其地址即知其是否相同.
 *
 * @Param   x
 * @Param   y
 *
 * @Returns:
 *      相等, 则返回1;
 *      不相等, 则返回0.
 *
 *==========================================================================*/
static int cmpatom(const void *x, const void *y)
{
    return x != y;
}

/*==========================================================================*
 * @Description:
 *      计算key对应的hash值.
 *      对于atom, 我们直接取其地址值作为hash值.
 *
 * @Param   key
 *
 * @Returns:
 *      返回key对应的hash值.
 *
 *==========================================================================*/
static unsigned hashatom(const void *key)
{
    // 内存地一般以4字节对齐, 所以其低2位一般为0, 所以...
    return (unsigned long)key>>2;
}

/*==========================================================================*
 * @Description:
 *      创建一个新Table.
 *
 * @Param   hint    期望在Table中保存元素的个数
 * @Param   cmp     用于判断key1和key2的大小关系
 * @Param   hash
 *
 * @Returns:
 *      成功, 则返回新Table指针;
 *      失败, 则返回TABLE_ERROR.
 *
 *==========================================================================*/
T Table_new(int hint,
        int cmp(const void *x, const void *y),
        unsigned hash(const void *key))
{
    T table;
    int i;
    static int primes[] =
    { 509, 509, 1021, 2053, 4093,
        8191, 16381, 32771, 65521, INT_MAX };

    assert(hint >= 0);

    for (i = 1; primes[i] < hint; i++) { }
    table = malloc(sizeof(*table) + primes[i-1] * sizeof(table->buckets[0]));
    if ( table == NULL )
        return TABLE_ERROR;

    table->size = primes[i-1];
    table->cmp  = cmp  ?  cmp : cmpatom;
    table->hash = hash ? hash : hashatom;
    table->buckets = (struct binding **)(table + 1);
    for (i = 0; i < table->size; i++)
        table->buckets[i] = NULL;
    table->length = 0;
    table->timestamp = 0;

    return table;
}

/*==========================================================================*
 * @Description:
 *      查找并返回key对应的value.
 *
 * @Param   table
 * @Param   key
 *
 * @Returns:
 *      若Table中找到key, 则返回对应的value, value可能为NULL;
 *      若Table没有找到key, 则返回TABLE_NO_KEY.
 *
 *==========================================================================*/
void *Table_get(T table, const void *key)
{
    int i;
    struct binding *p;
    assert(table);
    assert(key);

    i = TABLE_HASH(table, key);
    for ( p = table->buckets[i]; p; p = p->link )
        if ((*table->cmp)(key, p->key) == 0)
            break;

    if ( p == NULL )
        return TABLE_NO_KEY;

    return p->value;
}

/*==========================================================================*
 * @Description:
 *      往Table里存入新的(key,value)对, 若修改已有key的value值.
 *
 * @Param   table
 * @Param   key
 * @Param   value
 *
 * @Returns:
 *      若Table中还没有该key, 则创建一个新(key,value)对存入Table中;
 *          1. 若创建并存入成功, 则返回TABLE_OK;
 *          2. 若失败, 则返回TABLE_ERROR.
 *      若Table中已有该key, 则把其对应的value修改, 并返回旧value.
 *
 *==========================================================================*/
void *Table_put(T table, const void *key, void *value)
{
    int i;
    struct binding *p;
    void *prev;
    assert(table);
    assert(key);
    i = TABLE_HASH(table, key);
    for (p = table->buckets[i]; p; p = p->link)
        if ((*table->cmp)(key, p->key) == 0)
            break;
    if (p == NULL)
    {
        p = malloc(sizeof(*p));
        if ( p == NULL )
            return TABLE_ERROR;
        p->key = key;
        p->link = table->buckets[i];
        table->buckets[i] = p;
        table->length++;
        prev = TABLE_OK;
    } else
        prev = p->value;
    p->value = value;
    table->timestamp++;
    return prev;
}

/*==========================================================================*
 * @Description:
 *      返回Table当前的元素的个数.
 *
 * @Param   table
 *
 * @Returns:
 *
 *==========================================================================*/
int Table_length(T table)
{
    assert(table);
    return table->length;
}

/*==========================================================================*
 * @Description:
 *      对Table中的所有(key, value)对应用apply函数.
 *
 * @Param   table
 * @Param   apply
 * @Param   cl          传递给apply()的参数
 *
 *==========================================================================*/
void Table_map(T table,
        void apply(const void *key, void **value, void *cl),
        void *cl)
{
    int i;
    unsigned stamp;
    struct binding *p;
    assert(table);
    assert(apply);

    if ( table->length == 0 )
        return;

    stamp = table->timestamp;
    for (i = 0; i < table->size; i++)
        for (p = table->buckets[i]; p; p = p->link)
        {
            apply(p->key, &p->value, cl);
            // 确保在该函数执行期间Table没有发生任何改动!
            assert(table->timestamp == stamp);
        }
}

/*==========================================================================*
 * @Description:
 *      从Table中删除关键字为key的(key, value)对.
 *
 * @Param   table
 * @Param   key
 *
 * @Returns:
 *      若Table中, 没有key, 则不做任何操作, 并返回TABLE_OK;
 *      若有, 则把其删除, 并返回该key对应的value.
 *
 *==========================================================================*/
void *Table_remove(T table, const void *key)
{
    int i;
    struct binding **pp;
    assert(table);
    assert(key);
    table->timestamp++;
    i = TABLE_HASH(table, key);
    for (pp = &table->buckets[i]; *pp; pp = &(*pp)->link)
        if ((*table->cmp)(key, (*pp)->key) == 0)
        {
            struct binding *p = *pp;
            void *value = p->value;
            *pp = p->link;
            free(p);
            table->length--;
            return value;
        }
    return TABLE_OK;
}

/*==========================================================================*
 * @Description:
 *      对Table中所有的(key, value)对保存到数组中, 并返回该数组的首地址;
 *      其中, key和value是交替地保存在数组中的, key对应于数组索引为偶数的
 *      位置, value对应数组索引为奇数的位置.
 *      数组的最后一个元数为end.
 *
 * @Param   table
 * @Param   end
 *
 * @Returns:
 *      成功, 则返回数组的首地址;
 *      失败, 则返回TABLE_ERROR.
 *
 * @Notes:
 *      返回的数组空间由client释放!
 *
 *==========================================================================*/
void **Table_toArray(T table, void *end)
{
    int i, j = 0;
    void **array;
    struct binding *p;
    assert(table);

    array = malloc((2*table->length + 1)*sizeof (*array));
    if ( array == NULL )
        return TABLE_ERROR;

    for (i = 0; i < table->size; i++)
        for (p = table->buckets[i]; p; p = p->link)
        {
            array[j++] = (void *)p->key;
            array[j++] = p->value;
        }
    array[j] = end;
    return array;
}

/*==========================================================================*
 * @Description:
 *      释放Table中的所有元素和Table本身.
 *
 * @Param   table
 *
 *==========================================================================*/
void Table_free(T *table)
{
    assert(table && *table);
    if ((*table)->length > 0)
    {
        int i;
        struct binding *p, *q;
        for (i = 0; i < (*table)->size; i++)
            for (p = (*table)->buckets[i]; p; p = q)
            {
                q = p->link;
                free(p);
            }
    }
    free(*table);
    *table = NULL;
}

#ifdef ALG_TABLE_DEBUG
/*==========================================================================*
 * @Description:
 *      找出table中所以的bucket中最长的一个, 并求出其长度.
 *      我们可以用这一个返回值来选择合适的hash函数.
 *
 * @Param   table
 *
 * @Returns:
 *      返回table中所以的bucket中最长的一个的长度.
 *
 *==========================================================================*/
int Table_debug_maxlen_bucket(T table)
{
    assert(table != NULL);

    int i, bucket_maxlen = 0;
    struct binding *p;

    for (i = 0; i < table->size; i++)
    {
        int cur_bucket_len = 0;
        for (p = table->buckets[i]; p; p = p->link)
        {
            cur_bucket_len++;
        }
        if ( cur_bucket_len > bucket_maxlen )
            bucket_maxlen = cur_bucket_len;
    }

    return bucket_maxlen;
}
#endif
