/*
 * ===========================================================================
 *
 *       Filename:  alg_seq.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年01月04日 17时08分08秒
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
#include <stdarg.h>
#include <string.h>
#include <assert.h>

#include <alg/alg_array/alg_array.h>
#include <alg/alg_array/alg_arrayrep.h>

#include "alg_seq.h"



#define T Seq_T

struct T
{
    struct Array_T array;
    int length;
    int head;
};

/*
           /|=======|\   /------------> |----------|
          / |lengthA| \ /               |    0     |
         |  |-------| |/                |----------|
  Array_T|  | size  | /                 |    1     |
         |  |-------|/|                 |----------|
          \ |*array / |Seq_T            |    2     |
           \|=======| |                 |----------|
            |lengthS| |                 |    3     |
            |-------| |                 |----------|
            | head  | /                 |    4     |
            |=======|/                  |----------|
                                        |    5     |
                                        |----------|
                                        |    6     |
                                        |----------|
                                        |    7     |
                                        |----------|

        |---|        |---|        |---|        |---|
  head->| 0 |<-hi    |X0X|<-head  |X0X|        |X0X|          addhi: 0 1 2 3 4 5 6 7 0 1 2 ...
        |---|        |---|        |---|        |---|                 hi = (head + lengthS++) % lengthA
        | 1 |        |X1X|        |X1X|        |X1X|
        |---|        |---|        |---|        |---|          remhi: 0 7 6 5 4 3 2 1 0 7 6 ...
        | 2 | addhi  |X2X|<-hi    |X2X|<-hi    |X2X|                 hi = (head + --lengthS) % lengthA
        |---| addhi  |---|        |---|        |---|
        | 3 | addhi  | 3 |        | 3 | addhi  |X3X|<-hi      addlo: 0 7 6 5 4 3 2 1 0 7 6 ...
        |---|=======>|---|        |---|=======>|---|                 head = (--head) % lengthA
        | 4 |        | 4 | addlo  | 4 |        | 4 |
        |---|        |---|=======>|---|        |---|          remlo: 7 0 1 2 3 4 5 6 7 0 1 ...
        | 5 |        | 5 |        | 5 |        | 5 |                 head = (++head) % lengthA
        |---|        |---|        |---|        |---|
        | 6 |        | 6 |        | 6 |        | 6 |
        |---|        |---|        |---|        |---|
        | 7 |        | 7 |  head->|X7X|  head->|X7X|
        |---|        |---|        |---|        |---|
         (空)       (0 1 2)     (7 0 1 2)    (7 0 1 2 3)

       lo = head

*/




/*==========================================================================*
*  @Description:
*       把Seq的数据存储空间扩大两倍.
*
*         |---|             |---|             |---|
*         |X0X|             |X0X|             |X0X|
*         |---|             |---|             |---|
*     hi->|X1X|         hi->|X1X|         hi->|X1X|
*         |---|             |---|             |---|
*         | 2 |   resize    | 2 |     ...     | 2 |
*         |---| ==========> |---| ==========> |---|
*   head->|X3X|       head->|X3X|             | 3 |
*         |---|             |===|             |---|
*                           | 4 |             | 4 |
*                           |---|             |---|
*                           | 5 |             | 5 |
*                           |---|             |---|
*                           | 6 |             | 6 |
*                           |---|             |---|
*                           | 7 |       head->|X7X|
*                           |---|             |---|
*
*  @Param  seq
*
*  @Returns:
*       1. 成功, 则返回1;
*       2. 失败, 则返回0.
*
*==========================================================================*/
static int expand(T seq)
{
    assert(seq->array.length > 0);

    int n = seq->array.length;
    int ret = Array_resize(&seq->array, 2*n);
    if ( ret == 0 )
        return 0;

    if ( seq->head > 0 )
    {
        void **old = &((void **)seq->array.array)[seq->head];
        memcpy(old+n, old, (n - seq->head) * sizeof(void*));
        seq->head += n;
    }
    return 1;
}


/*==========================================================================*
 * @Description:
 *      新建一个大小为hint的序列, hint只表示期望值,
 *      实现能存入的个数不受其影响.
 *          1. 若hint为0, 则使用默认大小16
 *
 * @Param  hint     期望在Seq中保存元素的个数
 *
 * @Returns:
 *   1. 成功, 则返回新建的Seq的指针;
 *   2. 失败, 则返回NULL
 *
 *==========================================================================*/
T Seq_new(int hint)
{
    assert(hint >= 0);

    // They MUST initialize to NULL!!
    T seq = NULL;
    void *p = NULL;

    // 并把seq初始化为0!!
    seq = (T)calloc(sizeof(*seq), sizeof(char));
    if ( seq == NULL )
        goto _MEM_FAIL;
    if (hint == 0)
        hint = 16;
    p = malloc(hint * sizeof(void *));
    if ( p == NULL )
        goto _MEM_FAIL;

    ArrayRep_init(&seq->array, hint, sizeof (void *), p);

    return seq;

_MEM_FAIL:
    free(seq);
    free(p);
    return NULL;
}


/*==========================================================================*
 * @Description:
 *      新建一个序列, 并把其初始化为 x ... !
 *
 * @Param  x
 * @Param  ...
 *
 * @Returns:
 *   1. 成功, 则返回新建的Seq的指针;
 *   2. 失败, 则返回NULL
 *
 *==========================================================================*/
T Seq_seq(void *x, ...)
{
    va_list ap;
    T seq = Seq_new(0);
    if ( seq == NULL )
        return NULL;

    va_start(ap, x);
    for ( ; x; x = va_arg(ap, void *) )
    {
        if ( Seq_addhi(seq, x) == NULL )
        {
            Seq_free(&seq);
            return NULL;
        }
    }
    va_end(ap);

    return seq;
}


/*==========================================================================*
 * @Description:
 *   释放Seq所占用的所有空间.
 *
 * @Param  seq
 *
 *==========================================================================*/
void Seq_free(T *seq)
{
    assert(seq && *seq);
    assert((void *)*seq == (void *)&(*seq)->array);

    Array_free((Array_T *)seq);
    *seq = NULL;
}


/*==========================================================================*
 * @Description:
 *    返回Seq的当前长度.
 *
 * @Param  seq
 *
 * @Returns:
 *    返回Seq的当前长度.
 *
 *==========================================================================*/
int Seq_length(T seq)
{
    assert(seq);

    return seq->length;
}


/*==========================================================================*
 * @Description:
 *      取下标为i的元素(head的下标为0).
 *
 * @Param  seq
 * @Param  i
 *
 * @Returns:
 *      返回下标为i的元素.
 *
 *==========================================================================*/
void *Seq_get(T seq, int i)
{
    assert(seq);
    assert(i >= 0 && i < seq->length);

    return ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
}


/*==========================================================================*
 * @Description:
 *      修改下标为i的元素(head的下标为0).
 *
 * @Param  seq
 * @Param  i
 * @Param  x
 *
 * @Returns:
 *      返回修改前的值
 *
 *==========================================================================*/
void *Seq_put(T seq, int i, void *x)
{
    void *prev;
    assert(seq);
    assert(i >= 0 && i < seq->length);

    prev = ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
    ((void **)seq->array.array)[(seq->head + i)%seq->array.length] = x;

    return prev;
}


/*==========================================================================*
 * @Description:
 *      从Seq中删除尾部元素.
 *
 * @Param  seq
 *
 * @Returns:
 *      返回被删除的元素.
 *
 *==========================================================================*/
void *Seq_remhi(T seq)
{
    int i;
    assert(seq);
    assert(seq->length > 0);

    i = --seq->length;
    return ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
}


/*==========================================================================*
 * @Description:
 *      从Seq中删除头部元素.
 *
 * @Param  seq
 *
 * @Returns:
 *      返回被删除的元素.
 *
 *==========================================================================*/
void *Seq_remlo(T seq)
{
    int i = 0;
    void *x;
    assert(seq);
    assert(seq->length > 0);

    x = ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
    seq->head = (seq->head + 1)%seq->array.length;
    --seq->length;

    return x;
}


/*==========================================================================*
 * @Description:
 *      把 x 从Seq尾部压入 Seq 中.
 *
 * @Param  seq
 * @Param  x
 *
 * @Returns:
 *      1. 成功, 则返回x;
 *      2. 失败, 则返回NULL
 *
 *==========================================================================*/
void *Seq_addhi(T seq, void *x)
{
    int i;
    assert(seq);
    assert(x != NULL);

    if (seq->length == seq->array.length)
        if ( expand(seq) == 0 )
            return NULL;
    i = seq->length++;
    return ((void **)seq->array.array)[
        (seq->head + i)%seq->array.length] = x;
}


/*==========================================================================*
 * @Description:
 *      把 x 从Seq头部压入 Seq 中.
 *
 * @Param  seq
 * @Param  x
 *
 * @Returns:
 *      1. 成功, 则返回x;
 *      2. 失败, 则返回NULL
 *
 *==========================================================================*/
void *Seq_addlo(T seq, void *x)
{
    int i = 0;
    assert(seq);

    if (seq->length == seq->array.length)
        if ( expand(seq) == 0 )
            return NULL;
    if (--seq->head < 0)
        seq->head = seq->array.length - 1;
    seq->length++;

    return ((void **)seq->array.array)[
        (seq->head + i)%seq->array.length] = x;
}
