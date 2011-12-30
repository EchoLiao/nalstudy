/*
 * ===========================================================================
 *
 *       Filename:  table.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年12月29日 10时45分21秒
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

#ifndef TABLE_H_
#define TABLE_H_

#define TABLE_OK        ((void*)(0))
#define TABLE_ERROR     ((void*)(~0))
#define TABLE_NO_KEY    ((void*)(~0))

#define T Table_T

typedef struct T *T;


extern T    Table_new (int hint,
	int cmp(const void *x, const void *y),
	unsigned hash(const void *key));

extern void Table_free(T *table);

extern int  Table_length(T table);

extern void *Table_put   (T table, const void *key, void *value);

extern void *Table_get   (T table, const void *key);

extern void *Table_remove(T table, const void *key);

extern void Table_map    (T table,
	void apply(const void *key, void **value, void *cl),
	void *cl);

extern void **Table_toArray(T table, void *end);

#undef T

#endif
