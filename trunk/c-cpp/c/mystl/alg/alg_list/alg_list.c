/*
 * ===========================================================================
 *
 *       Filename:  alg_list.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年01月15日 10时45分21秒
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

#include <stdlib.h>
#include <stdarg.h>
#include <stddef.h>
#include <assert.h>
#include "alg_list.h"

#define T List_T


/*==========================================================================*
 * @Description:
 *      在链表list头部处增加一个新节点, 该新节点的数据为x.
 *
 * @Param   list
 * @Param   x
 *
 * @Returns:
 *      1. 成功, 则返回该链表头指针;
 *      2. 失败, 则返回NULL.
 *
 *==========================================================================*/
T List_push(T list, void *x)
{
    T p;

    p = malloc(sizeof(*p));
    if ( p == NULL )
        return NULL;

    p->first = x;
    p->rest  = list;

    return p;
}

/*==========================================================================*
 * @Description:
 *      根据可变参数列表(以NULL结束)创建和构建一个新链表.
 *
 * @Param   x
 * @Param   ...
 *
 * @Returns:
 *      1. 成功, 则返回该链表头指针;
 *      2. 失败, 则返回NULL.
 *
 *==========================================================================*/
T List_list(void *x, ...)
{
    va_list ap;
    T list, *p = &list;

    va_start(ap, x);
    for ( ; x != NULL; x = va_arg(ap, void *) )
    {
        if ( (*p=malloc(sizeof(**p))) == NULL )
            goto _NO_ENOUGH_MEMORY;
        (*p)->first = x;
        p = &(*p)->rest;
    }
    *p = NULL;
    va_end(ap);
    return list;

_NO_ENOUGH_MEMORY:
    List_free(&list);
    return NULL;
}

/*==========================================================================*
 * @Description:
 *      把链表tail连接到链表list尾部.
 *
 * @Param   list
 * @Param   tail
 *
 * @Returns:
 *      返回连接后的新链表头的指针.
 *
 *==========================================================================*/
T List_append(T list, T tail)
{
    T *p = &list;

    while (*p)
        p = &(*p)->rest;
    *p = tail;

    return list;
}

/*==========================================================================*
 * @Description:
 *      创建链表list的一个复本.
 *
 * @Param   list
 *
 * @Returns:
 *      1. 成功, 则返回复本的链表头指针;
 *      2. 失败, 则返回NULL.
 *
 *==========================================================================*/
T List_copy(T list)
{
    T head, *p = &head;

    for ( ; list; list = list->rest)
    {
        if ( (*p=malloc(sizeof(**p))) == NULL )
            goto _NO_ENOUGH_MEMORY;
        (*p)->first = list->first;
        p = &(*p)->rest;
    }
    *p = NULL;
    return head;

_NO_ENOUGH_MEMORY:
    List_free(&head);
    return NULL;
}

/*==========================================================================*
 * @Description:
 *      从链表list中删除头节点.
 *
 * @Param   list    被操作链表
 * @Param   x       若x不为NULL, 则*x返回被删除节点的值
 *
 * @Returns:
 *      返回删除头节点后的新链表的头指针.
 *
 * @Notes:
 *      若list为NULL, 则不作几何操作, 并返回NULL
 *
 *==========================================================================*/
T List_pop(T list, void **x)
{
    if ( list == NULL )
        return NULL;

    T head = list->rest;
    if ( x != NULL )
        *x = list->first;
    free(list);
    list = NULL;

    return head;
}

/*==========================================================================*
 * @Description:
 *      反转链表list.
 *
 * @Param   list
 *
 * @Returns:
 *      返回反转的链表的头指针
 *
 *==========================================================================*/
T List_reverse(T list)
{
    T head = NULL, next;
    for ( ; list; list = next )
    {
        next = list->rest;
        list->rest = head;
        head = list;
    }

    return head;
}

/*==========================================================================*
 * @Description:
 *      求链表list的节点个数.
 *
 * @Param   list
 *
 * @Returns:
 *      返回链表list的节点个数.
 *
 *==========================================================================*/
int List_length(T list)
{
    int n;

    for ( n = 0; list; list = list->rest )
        n++;

    return n;
}

/*==========================================================================*
 * @Description:
 *      释放链表list.
 *
 * @Param   list
 *
 *==========================================================================*/
void List_free(T *list)
{
    assert(list);

    T next;
    for ( ; *list; *list = next )
    {
        next = (*list)->rest;
        free(*list);
        *list = NULL;
    }
}

/*==========================================================================*
 * @Description:
 *      对list中的所有节点应用apply函数.
 *
 * @Param   list
 * @Param   apply
 * @Param   cl          传递给apply()的参数
 *
 *==========================================================================*/
void List_map(T list, void apply(void **x, void *cl), void *cl)
{
    assert(apply);

    for ( ; list; list = list->rest )
        apply(&list->first, cl);
}

/*==========================================================================*
 * @Description:
 *      把链表list中所有节点的内容数据保存到数组中, 并返回该数组的首地址;
 *      数组的最后一个元素为end.
 *
 * @Param   list
 * @Param   end
 *
 * @Returns:
 *      成功, 则返回数组的首地址;
 *      失败, 则返回NULL.
 *
 * @Notes:
 *      返回的数组空间由client释放!
 *
 *==========================================================================*/
void **List_toArray(T list, void *end)
{
    int i, n = List_length(list);
    void **array = malloc((n + 1) * sizeof(*array));
    if ( array == NULL )
        return NULL;

    for ( i = 0; i < n; i++ )
    {
        array[i] = list->first;
        list = list->rest;
    }
    array[i] = end;

    return array;
}
