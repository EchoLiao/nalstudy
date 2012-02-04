/*
 * ===========================================================================
 *
 *       Filename:  alg_rand.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月04日 14时39分59秒
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
#include <time.h>
#include <assert.h>
#include "alg_rand.h"



/*==========================================================================*
 * @Description:
 *      返回一个整形随机数, 值介于a和b之间, 包括a和b;
 *      return a random number, it's value is in [a, b].
 *
 * @Param   a
 * @Param   b
 *
 * @Returns:
 *      return a random number, it's value is in [a, b].
 *
 *==========================================================================*/
unsigned int Rand_int(unsigned int a, unsigned int b)
{
    assert( a <= b);

    return a + rand() % (b + 1 - a);
}


/*==========================================================================*
 * @Description:
 *      返回一个整形随机数组, 大小为n, 元素是唯一的, 且其元素值介于0和n-1之间.
 *
 * @Param   n
 *
 * @Returns:
 *      成功, 则返回该数组;
 *      失败, 则返回NULL.
 *
 *==========================================================================*/
int* Rand_randN(int n)
{
    assert(n >= 1);

    int *X = NULL, i, a, t;

    X = malloc(n * sizeof(int));
    if ( X == NULL )
        return NULL;

    for ( i = 0; i < n; i++ )
        X[i] = i;

    srand((unsigned int)time(NULL));
    for ( i = 0; i < n; i++ )
    {
        a = Rand_int(i, n - 1);
        t = X[a];
        X[a] = X[i];
        X[i] = a;
    }

    return X;
}
