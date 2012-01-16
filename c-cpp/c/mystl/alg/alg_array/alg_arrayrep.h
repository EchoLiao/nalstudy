/*
 * ===========================================================================
 *
 *       Filename:  alg_arrayrep.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年01月05日 09时18分07秒
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

#ifndef ARRAYREP_INCLUDED
#define ARRAYREP_INCLUDED

#define T Array_T

struct T
{
	int length;
	int size;
	char *array;
};

extern void ArrayRep_init(struct T *array, int length, int size, void *ary);

#undef T

#endif
