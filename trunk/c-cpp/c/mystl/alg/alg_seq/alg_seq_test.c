/*
 * ===========================================================================
 *
 *       Filename:  alg_seq_test.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月14日 15时21分36秒
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
#include <assert.h>
#include <stdlib.h>

#include <debug/memwatch/memwatch.h>
#include <alg/alg_seq/alg_seq.h>



// #define NUM 10484000 // 栈溢出(X[])!
#define NUM 1048400


int main (int argc, char *argv[])
{
    Seq_T seq = NULL;
    int i;
    int X[NUM];
    void *se;

    for ( i = 0; i < NUM; i++ )
        X[i] = i;

    seq = Seq_new(0);
    assert(seq != NULL);

    for ( i = 0; i < NUM; i++ )
    {
        se = Seq_addhi(seq, (void*)&X[i]);
        assert(se != NULL);
    }

    for ( i = NUM - 1; i >= 0; i-- )
    {
        se = Seq_remhi(seq);
        assert(*(int*)se == i);
    }

    Seq_free(&seq);

    return 0;
}
