/*
 * ===========================================================================
 *
 *       Filename:  amapb.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月13日 09时55分49秒
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
#include <string.h>
#include <assert.h>
#include <ctype.h>

#include <slib/slib.h>
#include <alg/alg_table/alg_table.h>
#include "amapb.h"


#define LINEBUFSIZE     1024




/*==========================================================================*
 * @Description:
 *      把新的一行加入到映射表中.
 *
 * @Param  Abuf
 * @Param  Asize
 * @Param  Bbuf
 * @Param  Bsize
 * @Param  AtoB
 * @Param  BtoA
 * @Param  lbuf
 *
 * @Returns:
 *
 *==========================================================================*/
static int mt_doline(char *Abuf, int *Asize, char *Bbuf, int *Bsize,
        Table_T AtoB, Table_T BtoA, char *lbuf)
{
    assert(Abuf != NULL && Bbuf != NULL);
    assert(AtoB != NULL && BtoA != NULL);
    assert(lbuf != NULL);

    void *ret;
    char *pcur = lbuf;
    char *pA, *pB;

    while ( *pcur && isspace(*pcur) ) pcur++;
    pA = pcur;
    while ( *pcur && (! isspace(*pcur)) ) pcur++;
    *pcur++ = '\0';
    while ( *pcur && isspace(*pcur) ) pcur++;
    pB = pcur;
    while ( *pcur && (! isspace(*pcur)) ) pcur++;
    *pcur = '\0';

    if ( *pA == '\0' || *pB == '\0' )
    {
        *Asize = *Bsize = 0;
        return 0;
    }

    sl_strncpy(Abuf, pA, Asize);
    sl_strncpy(Bbuf, pB, Bsize);

    ret = Table_put(AtoB, Abuf, Bbuf);
    assert(ret == TABLE_OK);
    ret = Table_put(BtoA, Bbuf, Abuf);
    assert(ret == TABLE_OK);

    return 1;
}

/*==========================================================================*
 * @Description:
 *      从文件 fn 中读取原始信息来初始化映射表.
 *
 * @Param  Agbuf
 * @Param  Agsize
 * @Param  Bgbuf
 * @Param  Bgsize
 * @Param  AtoB
 * @Param  BtoA
 * @Param  fn
 *
 * @Returns:
 *
 *==========================================================================*/
int mt_readtab(char *Agbuf, int *Agsize, char *Bgbuf, int *Bgsize,
        Table_T AtoB, Table_T BtoA, const char *fn)
{
    assert(Agbuf != NULL && Bgbuf != NULL);
    assert(*Agsize > 0 && *Bgsize > 0 );
    assert(AtoB != NULL && BtoA != NULL);
    assert(fn != NULL);

    char buffer[LINEBUFSIZE];
    long total = 0;
    char *Abuf = Agbuf;
    char *Bbuf = Bgbuf;
    int  Aorisize, Borisize, Asize, Bsize;
    FILE *fp = fopen(fn, "r");

    if ( fp == NULL )
    {
        fprintf(stderr, "can't open table file: %s\n", fn);
        return(-1);
    }

    Aorisize = Asize = *Agsize;
    Borisize = Bsize = *Bgsize;
    for ( ; ; )
    {
        if ( ! (Asize > 0 && Bsize > 0) )
            break;
        if ( fgets(buffer, LINEBUFSIZE, fp) == NULL )
            break;
        total += mt_doline(Abuf, &Asize, Bbuf, &Bsize, AtoB, BtoA, buffer);
        Abuf += Asize;
        Bbuf += Bsize;
        Asize = Aorisize = Aorisize - Asize;
        Bsize = Aorisize = Aorisize - Bsize;
    }
    *Agsize -= Aorisize;
    *Bgsize -= Borisize;
    fclose(fp);

    return(total);
}

/*==========================================================================*
 * @Description:
 *      从映射表中搜索转换.
 *
 * @Param  AtoB
 * @Param  BtoA
 * @Param  mode
 * @Param  pkey
 * @Param  pres
 *
 * @Returns:
 *
 *==========================================================================*/
static int mt_doconvert(Table_T AtoB, Table_T BtoA, int mode,
        char *pkey, char **pres)
{
    assert(AtoB != NULL && BtoA != NULL);
    assert(pkey != NULL && pres != NULL);

    *pres = NULL;
    if ( mode == MT_AtoB )
    {
        *pres = Table_get(AtoB, (void*)pkey);
        if ( *pres == TABLE_NO_KEY )
            return 0;
    }
    else if ( mode == MT_BtoA )
    {
        *pres = Table_get(BtoA, (void*)pkey);
        if ( *pres == TABLE_NO_KEY )
            return 0;
    }
    else
        return 0;

    return 1;
}

/*==========================================================================*
 * @Description:
 *      从映射表中搜索转换.
 *
 * @Param  AtoB
 * @Param  BtoA
 * @Param  mode
 * @Param  ifp
 * @Param  ofp
 *
 * @Returns:
 *
 *==========================================================================*/
int mt_convert(Table_T AtoB, Table_T BtoA, int mode,
        FILE *ifp, FILE *ofp)
{
    assert(ifp != NULL && ofp != NULL);
    assert(mode == MT_AtoB || mode == MT_BtoA);

    char buffer[LINEBUFSIZE];
    char *pbuf, *prn, *pres = NULL;

    while ( fgets(buffer, LINEBUFSIZE, ifp) != NULL )
    {
        pbuf = buffer;
        prn = strchr(buffer, '\n');
        *prn = '\0';
        pbuf = sl_remove_agspace(pbuf);

        if ( mt_doconvert(AtoB, BtoA, mode, pbuf, &pres) != 0 )
        {
            fprintf(ofp, "%s\t", pbuf);
            fprintf(ofp, "%s\n", (pres==NULL)?"":pres);
        }
        else
        {
            fprintf(ofp, "%s\n", pbuf);
        }
    }

    return 1;
}
