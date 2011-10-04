
/*
 * =====================================================================================
 *
 *       Filename:  testStack.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年05月29日 12时18分56秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerlz (nuoliu), nuoerlz@gmail.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "assert.h"
#include "stack.h"

int main(int argc, char *argv[])
{
    int      a;
    Stack_T  st = NULL;

    a = 3;
    printf("sizeof(st) = %d\n", sizeof(st));
    /* sizeof(*st) 在这不可能编译通过, 因为 struct Stack_T
     * 的内部实现是隐藏的 , 编译器看不到,
     * 因此也无法得知其大小! */
    // st = (Stack_T) calloc(1, sizeof (*st));
    st = Stack_new();
    assert(Stack_empty(st));
    Stack_push(st, &a);
    assert(!Stack_empty(st));
    printf("%d\n", *((int*)Stack_pop(st)));
    assert(Stack_empty(st));
    Stack_free(&st);

    return 0;
}
