/*
 * =====================================================================================
 *
 *       Filename:  hexs2char.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2010年03月23日 21时58分40秒
 *       Revision:  none
 *       Compiler:  cl.exe
 *
 *         Author:  nuoerll (nuoliu), lcy3636@126.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <math.h>

/* static const int MAX_LINE = 1024; */
#define MAX_LINE	4096

static int transline(char *pline);
static int hex2dec(const char *pbg, int len);

int readword(char *pch, FILE *fpin)
{
	int len = 0;
	int s;
	int flag = 1;
	while ((s = fread(pch, sizeof(char), 1, fpin)) == 1)
	{
		if (*pch == '\n')
			break;
		else if (isspace(*pch))
		{
			if (flag == 2)
				break;
			continue;
		}
		flag = 2;
		pch++;
		len++;
	}
	return *pch == '\n' ? len+1 : len;
}

int readline(char *pch, FILE *fpin)
{
	int len = 0;
	int s;
	while ((s = readword(pch, fpin)) > 0)
	{
		pch += s;
		len += s;
		if (*(pch - 1) == '\n')
			break;
		*(pch++) = ' ';
		len++;
	}
	*pch = '\0';
	return len;
}

int transline(char *pline)
{
	assert(pline != NULL);
	char *ppre,*pascii,*pch = pline;
	int chnum, len;

	len = strlen(pline);
	while (isspace(*(pch + len -1))) /* 去除行未空格 */
		len--;
	while (isspace(*pch)) /* 跳过行前空格 */
		pch++;
	while (!isspace(*pch)) /* 跳过第一个单词 */
		pch++;

	pascii = pline + len + 1;
	*(pline + len) = '\t';
	while (pch < pline + len)
	{
		if (pascii == pline + MAX_LINE - 1)
			break;
		while (isspace(*pch))
			pch++;
		ppre = pch;
		while (!isspace(*pch) && pch <= pline + len)
			pch++;
		chnum = hex2dec(ppre, pch - ppre);
		if (32 <= chnum && chnum <= 126)
			*pascii++ = (char)chnum;
		else
			*pascii++ = (char)(0x82);
	}
	*pascii = '\n';
	*(pascii + 1) = '\0';

	return 0;
}

int hex2dec(const char *pbg, int len)
{
	assert(pbg != NULL && len > 0);
	int pows;
	int res = 0;
	char cn[1];
	const char *p = pbg;
	while (len > 0)
	{
		pows = (int)powl(16, len - 1);
		cn[0] = *p;
		if (cn[0] >= '0' && cn[0] <= '9')
			res += atoi(cn) * pows;
		else if ((cn[0] >= 'a' && cn[0] <= 'f') || (cn[0] >= 'A' && cn[0] <= 'F'))
		{
			if (cn[0] == 'a' || cn[0] == 'A')
				res += 10 * pows;
			if (cn[0] == 'b' || cn[0] == 'B')
				res += 11 * pows;
			if (cn[0] == 'c' || cn[0] == 'C')
				res += 12 * pows;
			if (cn[0] == 'd' || cn[0] == 'D')
				res += 13 * pows;
			if (cn[0] == 'e' || cn[0] == 'E')
				res += 14 * pows;
			if (cn[0] == 'f' || cn[0] == 'F')
				res += 15 * pows;
		}
		else
			return 0; /* 无效字符 */
		p++;
		len--;
	}
	return res;
}

static void help(char *name)
{
	printf("Func:	把十六进制数转换为对应的ascii字符.\n");
	printf("Usage:	%s inputfilename\n", name);
	printf("文件输入格式:\n");
	printf("0x000: EB 48 90 00 02 8E D7 BC 00 7A BB A0\n");
	printf("0x001: 80 08 80 03 02 8E e7 BC 00 eA 8B 20\n");
	printf("... ...\n\n");
	printf("源文件:	/home/scr/lang/cpp/c/hexs2char/hexs2char.c\n");
	printf("\n");
}

int main (int argc, char *argv[])
{
	/* char rline[MAX_LINE] = " 0x33:   33   82 29 30	8 333	 "; */
	char rline[MAX_LINE];
	char *pch = rline;
	int s;
	FILE *fpin;
	char name[256];
	if ( argc < 2 || strcmp(argv[1], "-h") == 0 ||
		strcmp(argv[1], "--help")== 0 )
	{
		help(argv[0]);
		exit(1);
	}
	if ((fpin = fopen(argv[1], "r")) == NULL)
	{
		printf("error: File %s not found!\n", argv[1]);
		exit(1);
	}
	while ((s = readline(rline, fpin)) > 0)
	{
		transline(rline);
		printf("%s", rline);
	}
	return 0;
}
