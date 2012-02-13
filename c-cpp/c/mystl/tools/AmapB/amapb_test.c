/*
 * ===========================================================================
 *
 *       Filename:  amapb_test.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月13日 11时28分59秒
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
#include <string.h>

#include <tools/AmapB/amapb.h>
#include <alg/alg_table/alg_table.h>
#include <debug/memwatch/memwatch.h>


#define BUFSIZE     (1024 * 1024)


static Table_T tab_AtoB = NULL;
static Table_T tab_BtoA = NULL;
static char    Agbuf[BUFSIZE] = { 0 };
static char    Bgbuf[BUFSIZE] = { 0 };
static int     Agsize = BUFSIZE;
static int     Bgsize = BUFSIZE;


static void usage(char *prog)
{
    fprintf(stderr,"Usage: %s -m mode [-t t1 t2 ...] < file\n", prog);
    fprintf(stderr, "\tmode\tis a2b or b2a\n");
    fprintf(stderr, "\tti\tis a conversion table filename\n");
    fprintf(stderr, "\n");
    fprintf(stderr, "&[lang/c-cpp/c/enc/hc3]&\n");
    fprintf(stderr, "\n");

    if ( tab_AtoB != NULL )
        Table_free(&tab_AtoB);
    if ( tab_BtoA != NULL )
        Table_free(&tab_BtoA);

    exit(1);
}

/*==========================================================================*
 * @Description:
 *      该hash函数不能保证对所有的输入文件有效, 即不能保证生成的关键字是唯一.
 *      在此种情况下, 程序无法运行!
 *
 * @Param  key
 *
 * @Returns:
 *
 *==========================================================================*/
static unsigned int ab_hash(const void *key)
{
    const unsigned char *pkey = key;
    int  len = strlen((const char*)pkey);
    int  i;
    unsigned int ret = 0;

    len = (len < 4) ? len : 4;
    for ( i = 0; i < len; i++ )
    {
        ret <<= (i * 8);
        ret |= *(pkey + i);
    }

    return ret;
}

/*==========================================================================*
 * @Description:
 *
 * @Param  x
 * @Param  y
 *
 * @Returns:
 *
 *==========================================================================*/
static int ab_cmp(const void *x, const void *y)
{
    unsigned int xh = ab_hash(x);
    unsigned int yh = ab_hash(y);

    return xh != yh;
}


int main (int argc, char *argv[])
{

    int	mode = 0, i, ret;
    char *pname;

    tab_AtoB = Table_new(791, ab_cmp, ab_hash);
    if ( tab_AtoB == TABLE_ERROR )
    {
        tab_AtoB = NULL;
        return 1;
    }
    tab_BtoA = Table_new(791, ab_cmp, ab_hash);
    if ( tab_BtoA == TABLE_ERROR )
    {
        tab_BtoA = NULL;
        return 1;
    }

    pname = argv[0];
    for( i=1; i<argc; i++ )
    {
        if ((!strcmp(argv[i], "-mode")) || (!strcmp(argv[i], "-m")))
        {
            i++;
            if (!strcmp(argv[i], "a2b"))
                mode = MT_AtoB;
            else if (!strcmp(argv[i], "b2a"))
                mode = MT_BtoA;
            else usage(pname);
        }
        else if (!strcmp(argv[i], "-t"))
        {
            while (1)
            {
                if (++i >= argc) break;
                if (argv[i][0]=='-') /* other option, put it back */
                {
                    i--;
                    break;
                }
                else
                {
                    ret = mt_readtab(Agbuf, &Agsize, Bgbuf, &Bgsize,
                            tab_AtoB, tab_BtoA, argv[i]);
                    if ( ret > 0 )
                    {
                        goto _READ_TAB_OK;
                    }
                }
            }
        }
        else usage(pname);
    }

_READ_TAB_OK:
    if ( (mode != MT_AtoB) && (mode != MT_BtoA) )
        usage(pname);
    mt_convert(tab_AtoB, tab_BtoA, mode, stdin, stdout);

    if ( tab_AtoB != NULL )
        Table_free(&tab_AtoB);
    if ( tab_BtoA != NULL )
        Table_free(&tab_BtoA);
    return 0;
}


