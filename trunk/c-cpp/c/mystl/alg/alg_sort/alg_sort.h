/*
 * ===========================================================================
 *
 *       Filename:  alg_sort.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月04日 15时21分16秒
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

#ifndef ALG_SORT_H_
#define ALG_SORT_H_

#include "commdef.h"



/*
* 插入排序
 */
void Sort_insertSort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *));


/*
 * 快快排序
 * */
void Sort_quicklySort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *));


/*
 * 选择排序
 * */
void Sort_selectSort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *));


/*
 * 冒泡排序
 * */
void Sort_bubbleSort(void *base, size_t nmemb, size_t size,
        int(*compar)(const void *, const void *));

#endif
