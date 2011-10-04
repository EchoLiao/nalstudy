static char rcsid[] =
        "$Id: H:/drh/idioms/book/RCS/inter.doc,v 1.11 1997/02/21 19:42:15 drh Exp $";

#include <stddef.h>
#include "assert.h"
#include "mem.h"
#include "stack.h"

/* 在头文件中有: typedef struct T *T; 
 * 所以: T 即是 struct Stack_T* !
 * */
#define T Stack_T

struct T
{
    int      count;
    struct elem
    {
        void    *x;
        struct elem *link;
    }       *head;              // 永远指向栈顶
};

T Stack_new(void)
{
    T        stk;

    NEW(stk);                   // size is sizeof(*stk)
    stk->count = 0;
    stk->head = NULL;
    return stk;
}

/* 注意 const T stk 与 const struct T *stk 的区别!
 * 在这不用 const 的原因: [(P29)] 
 * */
int Stack_empty(T stk)
{
    assert(stk);                // checked runtime error
    return stk->count == 0;
}

void Stack_push(T stk, void *x)
{
    struct elem *t;

    assert(stk);
    NEW(t);
    t->x = x;
    /* 在链表头插入 */
    t->link = stk->head;
    stk->head = t;
    stk->count++;
}

void    *Stack_pop(T stk)
{
    void    *x;
    struct elem *t;

    assert(stk);
    assert(stk->count > 0);
    t = stk->head;
    stk->head = t->link;
    stk->count--;
    x = t->x;
    FREE(t);
    return x;
}

void Stack_free(T * stk)
{
    struct elem *t, *u;

    assert(stk && *stk);
    for (t = (*stk)->head; t; t = u)
    {
        u = t->link;
        FREE(t);                // 释放栈元素
    }
    FREE(*stk);                 // 释放栈自己
}
