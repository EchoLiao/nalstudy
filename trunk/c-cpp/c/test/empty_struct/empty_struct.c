/*
 * ===========================================================================
 *
 *       Filename:  empty_struct.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月04日 15时42分08秒
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



struct A
{
} a1, a2;

struct B
{
};


int main(int argc, char *argv[])
{
    int sizeA = sizeof(struct A);
    int sizeB = sizeof(struct B);

    printf("%d %d\n", sizeA, sizeB);
    printf("%p %p\n", &a1, &a2);

    return 0;
}

/*
   空结构体的大小取决于所用的编译器:

   1. gcc
     用gcc, 结果是0:

       [scr empty_struct]$ gcc -Wall -g empty_struct.c
       [scr empty_struct]$ ./a.out
        0 0
        0x6008d0 0x6008d0


   2. g++
     用g++, 结果是0:

       [scr empty_struct]$ g++ -Wall -g empty_struct.c
       [scr empty_struct]$ ./a.out
        1 1
        0x600938 0x600939
*/
