/*
 * ===========================================================================
 *
 *       Filename:  amapb.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月13日 09时55分57秒
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

#ifndef AMAPB_H_
#define AMAPB_H_

#include <alg/alg_table/alg_table.h>
#include "commdef.h"



#define MT_AtoB         0x01
#define MT_BtoA         0x02


int mt_readtab(char *Agbuf, int *Agsize, char *Bgbuf, int *Bgsize,
        Table_T AtoB, Table_T BtoA, const char *fn);

int mt_convert(Table_T AtoB, Table_T BtoA, int mode,
        FILE *ifp, FILE *ofp);

#endif
