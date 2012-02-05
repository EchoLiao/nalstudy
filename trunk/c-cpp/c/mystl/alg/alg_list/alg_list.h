/*
 * ===========================================================================
 *
 *       Filename:  alg_list.h
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


#ifndef ALG_LIST_H_
#define ALG_LIST_H_

#include "commdef.h"


#define T List_T

typedef struct T *T;


/*==========================================================================*
 * @Description:
 *      把定义写在头文件是为了提供效率, 因为链表操作是极多的,
 *      使client能够直接访问其结构成员, 能够很好地提高效率.
 *
 *==========================================================================*/
struct T
{
    T rest;
    void *first;
};


extern T      List_append (T list, T tail);
extern T      List_copy   (T list);
extern T      List_list   (void *x, ...);
extern T      List_pop    (T list, void **x);
extern T      List_push   (T list, void *x);
extern T      List_reverse(T list);
extern int    List_length (T list);
extern void   List_free   (T *list);

extern void   List_map    (T list,
        void apply(void **x, void *cl), void *cl);

extern void **List_toArray(T list, void *end);

extern int List_hasCircle(T list, T *cleNote);
extern int List_hasCross(T alist, T blist, T *crsNote);

#undef T

#endif
