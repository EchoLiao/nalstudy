/*
 * ===========================================================================
 *
 *       Filename:  alg_seq.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年01月04日 17时08分01秒
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



#ifndef ALG_SEQ_H_
#define ALG_SEQ_H_

#include "commdef.h"




#define T Seq_T

typedef struct T *T;



extern T Seq_new(int hint);

extern T Seq_seq(void *x, ...);

extern void Seq_free(T *seq);

extern int Seq_length(T seq);

extern void *Seq_get(T seq, int i);

extern void *Seq_put(T seq, int i, void *x);

extern void *Seq_addlo(T seq, void *x);

extern void *Seq_addhi(T seq, void *x);

extern void *Seq_remlo(T seq);

extern void *Seq_remhi(T seq);


#undef T


#endif
