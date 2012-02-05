/*
 * ===========================================================================
 *
 *       Filename:  alg_rand.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月04日 14时39分54秒
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

#ifndef ALG_RAND_H_
#define ALG_RAND_H_

#include "commdef.h"



/*
 * return a random number, it's value is in [a, b].
 */
unsigned int Rand_int(unsigned int a, unsigned int b);


/*
 * 返回一个整形随机数组, 大小为n, 元素是唯一的, 且其元素值介于0和n-1之间.
 */
int* Rand_randN(int n);


#endif
