/* $Id: H:/drh/idioms/book/RCS/inter.doc,v 1.11 1997/02/21 19:42:15 drh Exp $ */
#ifndef STACK_INCLUDED
#define STACK_INCLUDED

/* 不提倡在接口文件中导入其它接口文件, 因为: [(P22)] */

/* 1. 用T代替Stack_T使得接口更容易读懂;
 * 2. #undef T 使得client只能使用Stack_T而T无效. */
#define T Stack_T

/* opaque pointer type: 在接口中只给出了结构体指针, 但不会揭示其内部结构, 实现
 * 了内部细节的隐藏. */
typedef struct T *T;

extern T     Stack_new  (void);
/* 若栈为空则返回1, 否则返回0. */
extern int   Stack_empty(T stk);
extern void  Stack_push (T stk, void *x);
extern void *Stack_pop  (T stk);
extern void  Stack_free (T *stk);

#undef T

#endif
