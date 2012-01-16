/*
 * ===========================================================================
 *
 *       Filename:  alg_array.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年01月04日 17时19分46秒
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


#ifndef ALG_ARRAY_H_
#define ALG_ARRAY_H_

#define T Array_T

typedef struct T *T;

extern T    Array_new (int length, int size);
extern void Array_free(T *array);
extern int Array_length(T array);
extern int Array_size  (T array);
extern void *Array_get(T array, int i);
extern void *Array_put(T array, int i, void *elem);
extern int Array_resize(T array, int length);
extern T    Array_copy  (T array, int length);

#undef T

#endif
