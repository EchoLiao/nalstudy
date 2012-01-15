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

/*==========================================================================*
 * @Description:
 *      判断链表list是否是"有环单向链表".
 *      有环单向链表: 一个单向链表中可能有一个环, 也就是某个节点的next指向的是
 *                    链表中在它之前的节点, 这样在链表的尾部形成一个环, 这样的
 *                    链表称之为"有环单向链表".
 *
 * @Param   list        被操作链表
 * @Param   tailNote    若其不为NULL且list有环, 则*tailNote用于保存
 *                      链表list尾节点指针; 显然, 环的入口节点是
 *                      (*tailNote)->rest .
 *
 * @Returns:
 *      若是"有环单向链表", 则返回1; 否则, 返回0.
 *
 * http://keep.iteye.com/blog/293454
 *==========================================================================*/
int List_hasCircle(T list, T *tailNote)
{
    int hasCircle;
    T slow = list, fast = list;

    while ( fast && fast->rest )
    {
        slow = slow->rest;
        fast = fast->rest->rest;
        if ( slow == fast )
            break;
    }
    hasCircle = !(fast == NULL || fast->rest == NULL);
    if ( hasCircle == 0 || tailNote == NULL )
        return hasCircle;

    assert(hasCircle == 1);
    assert(list != NULL);
    slow = list;
    while ( slow != fast )
    {
        slow = slow->rest;
        fast = fast->rest;
    }
    // 至此, slow和fast都指向环入口节点!

    int c = 0;
    slow = list;
    while ( 1 )
    {
        while ( slow->rest != fast )
            slow = slow->rest;
        if ( ++c == 2 )
            break;
        slow = slow->rest;
    }
    *tailNote = slow;

    return hasCircle;
}

/*==========================================================================*
 * @Description:
 *      判断两个非空无环单向链表是否相交.
 *
 * @Param   alist   非空无环单向链表A
 * @Param   blist   非空无环单向链表B
 * @Param   alen    用于返回alist的长度(节点个数)
 * @Param   blen    用于返回blist的长度(节点个数)
 *
 * @Returns:
 *      若A与B相交, 则返回1; 否则, 返回0.
 *
 *==========================================================================*/
static int List_hasCross_Len_pri(T alist, T blist, int *alen, int *blen)
{
    assert(alist != NULL && blist != NULL);
    assert(alen != NULL && blen != NULL);

    T pa = alist, pb = blist;
    *alen = 1;
    *blen = 1;

    while ( pa->rest != NULL )
    {
        (*alen)++;
        pa = pa->rest;
    }
    while ( pb->rest != NULL )
    {
        (*blen)++;
        pb = pb->rest;
    }

    return (pa == pb);
}

/*==========================================================================*
 * @Description:
 *      判断两个无环单向链表是否相交.
 *
 * @Param   alist       无环单向链表A
 * @Param   blist       无环单向链表B
 * @Param   crsNote     若其不为NULL且A与B相交, 则*crsNote用于保存
 *                      相交节点指针.
 *
 * @Returns:
 *      若A与B相交, 则返回1; 否则, 返回0.
 *
 *==========================================================================*/
static int List_hasCross_pri(T alist, T blist, T *crsNote)
{
    if ( alist == NULL || blist == NULL )
        return 0;

    int alen, blen, hasCross, i;
    T pa, pb;

    hasCross = List_hasCross_Len_pri(alist, blist, &alen, &blen);
    if ( hasCross == 0 || crsNote == NULL )
        return hasCross;

    assert(hasCross == 1);
    pa = alist;
    pb = blist;
    if ( alen > blen )
    {
        for ( i = 0; i < alen - blen; i++ )
            pa = pa->rest;
    }
    else if ( alen < blen )
    {
        for ( i = 0; i < blen - alen; i++ )
            pb = pb->rest;
    }
    while ( pa != pb )
    {
        pa = pa->rest;
        pb = pb->rest;
    }
    *crsNote = pa;

    return 1;
}

/*==========================================================================*
 * @Description:
 *      判断两个单向链表是否相交.
 *
 * @Param   alist       单向链表A
 * @Param   blist       单向链表A
 * @Param   crsNote     若其不为NULL且A与B相交, 则*crsNote用于保存
 *                      相交节点指针.
 *
 * @Returns:
 *      若A与B相交, 则返回1; 否则, 返回0.
 *
 *==========================================================================*/
int List_hasCross(T alist, T blist, T *crsNote)
{
    int aHasCircle, bHasCircle, ret;
    T aTail = NULL, bTail = NULL, aCle, bCle;

    if ( alist == NULL || blist == NULL )
        return 0;

    aHasCircle = List_hasCircle(alist, &aTail);
    bHasCircle = List_hasCircle(blist, &bTail);
    if ( aHasCircle )
    {
        assert(aTail != NULL);
        aCle = aTail->rest;
        aTail->rest = NULL;
    }
    if ( bHasCircle )
    {
        assert(bTail != NULL);
        bCle = bTail->rest;
        bTail->rest = NULL;
    }

    ret = List_hasCross_pri(alist, blist, crsNote);

    if ( aHasCircle )
        aTail->rest = aCle;
    if ( bHasCircle )
        bTail->rest = bCle;

    return ret;
}
