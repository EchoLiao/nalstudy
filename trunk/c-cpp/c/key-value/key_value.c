/*
 * ===========================================================================
 *
 *       Filename:  key_value.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2011年09月30日 04时41分47秒
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

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef int BOOL;
#define TRUE    1
#define FALSE   0

#define KEY_MAX_LEN 63
#define VAL_MAX_LEN 255

typedef struct tagKVal
{
    char key[KEY_MAX_LEN + 1];
    char val[VAL_MAX_LEN + 1];
} KVal;

typedef struct tagKValS
{
    KVal *pkval;
    int  num;
} KValS;


char *st_strncpy(char *des, const char *src, int desmaxlen)
{
    assert(des != NULL && src != NULL);
    int len = strlen(src);

    len = (len >= desmaxlen) ? desmaxlen : len;
    strncpy(des, src, len);
    des[len] = '\0';

    return des;
}

char *st_remove_agspace(char *str)
{
    assert(str != NULL);
    char *pst = str, *pe;
    int len;

    while ( isspace(*pst) )
        pst++;

    len = strlen(pst);
    if ( len == 0 )
        return pst;

    pe = pst + len - 1;
    while ( (pe - pst) >= 0 && isspace(*pe) )
        pe--;
    *(pe + 1) = '\0';

    return pst;
}

static BOOL st_read_pro(KVal *pk, char *str)
{
    assert(pk != NULL && str != NULL);
    char *pst, *psub = NULL;

    pst = str;
    if ( (psub=strchr(pst, '=')) == NULL )
        return FALSE;

    *psub = '\0';
    psub += 1;
    pst = st_remove_agspace(pst);
    psub = st_remove_agspace(psub);

    st_strncpy(pk->key, pst, KEY_MAX_LEN);
    st_strncpy(pk->val, psub, VAL_MAX_LEN);

    return TRUE;
}

static BOOL st_read_allpros(KValS **pRet, const char *pfile)
{
    assert(*pRet == NULL && pfile != NULL);
    KVal *pKv = NULL, *ptmpKv = NULL;
	FILE *pf = NULL;
    char *pdata = NULL, *pstr = NULL, *psub = NULL;
    int len, i;

    if ( (pf=fopen(pfile, "rb+")) == NULL )
        goto _CANNOT_OPEN;

    fseek(pf, 0, SEEK_END);
    len = ftell(pf);
    fseek(pf, 0, SEEK_SET);
    if ( (pdata=malloc(len + 2)) == NULL )
        goto _NO_MEMORY;

    i = fread(pdata, 1, len, pf);
    assert(i == len);
    pdata[i] = '\n'; pdata[i+1] = '\0';

    if ( (pKv=(KVal*)malloc(sizeof(KVal))) == NULL )
        goto _NO_MEMORY;
    pstr = pdata;
    for ( i = 0; ((psub = strchr(pstr, '\n')) != NULL); pstr = psub + 1 )
    {
        ptmpKv = pKv + i;
        *psub = '\0';
        if ( ! st_read_pro(ptmpKv, pstr) )
            continue;
        i++;
        if ( (pKv=(KVal*)realloc(pKv, sizeof(KVal)*(i+1))) == NULL )
            goto _NO_MEMORY;
    }
    if ( (*pRet=(KValS*)malloc(sizeof(KValS))) == NULL )
        goto _NO_MEMORY;
    (*pRet)->pkval = pKv;
    (*pRet)->num = i;
    free(pdata);
    return TRUE;

_NO_MEMORY:
    fclose(pf);
_CANNOT_OPEN:
    free(pdata); // no memory, pdata is NULL. ok!
    free(*pRet);  // ...
    *pRet = NULL;
    return FALSE;
}


static BOOL st_write_pro(KVal *pKv, const char *pfile, int append)
{
    assert(pKv != NULL && pfile != NULL);
	FILE *pf = NULL;

    if ( ! append )
    {
        if ( (pf=fopen(pfile, "wb+")) == NULL )
            return FALSE;
    }
    else
    {
        if ( (pf=fopen(pfile, "ab+")) == NULL )
            return FALSE;
    }

    fwrite(pKv->key, strlen(pKv->key), 1, pf);
    fwrite("=", 1, 1, pf);
    fwrite(pKv->val, strlen(pKv->val), 1, pf);
    fwrite("\n", 1, 1, pf);
    fclose(pf);

    return TRUE;
}

static BOOL st_write_allpros(KValS *pKvS, const char *pfile, int append)
{
    assert(pKvS != NULL && pfile != NULL);
	FILE *pf = NULL;
    int i;

    if ( ! append )
    {
        if ( (pf=fopen(pfile, "wb+")) == NULL )
            goto _CANNOT_OPEN;
    }
    else
    {
        if ( (pf=fopen(pfile, "ab+")) == NULL )
            goto _CANNOT_OPEN;
    }

    for ( i = 0; i < pKvS->num; i++ )
    {
        fwrite((pKvS->pkval)[i].key, strlen((pKvS->pkval)[i].key), 1, pf);
        fwrite("=", 1, 1, pf);
        fwrite((pKvS->pkval)[i].val, strlen((pKvS->pkval)[i].val), 1, pf);
        fwrite("\n", 1, 1, pf);
    }
    fclose(pf);
    return TRUE;

_CANNOT_OPEN:
    return FALSE;
}

/****************************************************
写入信息到指定的配置文件中
参数1:lpAppName未使用.
参数2:要保存的标志符
参数3:要写入的数据值
参数4:配置文件名.
假如要将IP信息写入 \thunder\thunder.ini 文件中,IP地址为 192.168.1.3 ,
表识信息数据为 localip.
实际调用为TSC_WritePrivateProfileString(0,"localip","192.168.1.3","\thunder\thunder.ini");
*****************************************************/
BOOL TSC_WritePrivateProfileString(char *papp, char *pkey,
        char *pval, char *pfile)
{
    assert(pkey != NULL && pval != NULL && pfile != NULL);
    KValS *pKS = NULL;
    KVal kV;
    int ret, i;

    ret = st_read_allpros(&pKS, pfile);
    if ( ! ret )
        return FALSE;

    for ( i = 0; i < pKS->num; i++ )
    {
        if ( strcmp((pKS->pkval)[i].key, pkey) == 0 )
        {
            st_strncpy((pKS->pkval)[i].val, pval, VAL_MAX_LEN);
            break;
        }
    }

    ret = st_write_allpros(pKS, pfile, 0);
    if ( ret && i == pKS->num )
    {
        st_strncpy(kV.key, pkey, KEY_MAX_LEN);
        st_strncpy(kV.val, pval, VAL_MAX_LEN);
        ret = st_write_pro(&kV, pfile, 1);
    }

    free(pKS);
    return ret;
}

/****************************************************
从指定的配置文件中读出字符串数据
参数1:lpAppName未使用.
参数2:标志符
参数3:默认值,即没有保存的标志符时返回的数据
参数4:配置文件名.
*****************************************************/
int TSC_GetPrivateProfileString(char *papp, char *pkey, char *pdef,
        char *pretval, int nsize, char *pfile)
{
    assert(pkey != NULL && pretval != NULL && pfile != NULL);
    KValS *pKS = NULL;
    int ret, i, len = 0;

    ret = st_read_allpros(&pKS, pfile);
    if ( ! ret )
        return 0;
    for ( i = 0; i < pKS->num; i++ )
    {
        if ( strcmp((pKS->pkval)[i].key, pkey) == 0 )
        {
            st_strncpy(pretval, (pKS->pkval)[i].val, nsize - 1);
            break;
        }
    }
    if ( i == pKS->num && pdef != NULL )
    {
        strcpy(pretval, pdef);
        len = strlen(pdef);
    }

    free(pKS);
    return len;
}


int main (int argc, char *argv[])
{
#if 0
    KValS *pKS = NULL;
    ret = st_read_allpros(&pKS, "./thunder.ini");

    if ( ret )
        for ( i = 0; i < pKS->num; i++ )
        {
            printf("%s=%s\n", (pKS->pkval)[i].key, (pKS->pkval)[i].val);
        }
    free(pKS);
#else
    char str[128];
    TSC_GetPrivateProfileString(NULL, "xMin", "ZZZ", str, 128, "thunder.ini");
    printf("%s\n", str);
    TSC_WritePrivateProfileString(NULL, "goto", "888", "thunder.ini");
#endif
    time_t tim;
    tim = time(NULL);
    char *pt = ctime((const time_t*)&tim);
    *(pt + strlen(pt) - 1) = '\0';
    printf("%s\n", pt);

    return 0;
}

