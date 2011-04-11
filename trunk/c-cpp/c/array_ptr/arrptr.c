/*
 * =====================================================================================
 *
 *       Filename:  arrptr.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2011年03月24日 11时33分37秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerlz (nuoliu), nuoerlz@gmail.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#define IDXNUM 10

int main (int argc, char *argv[])
{
	int i;
	/* int *pge[2]; */
	/* int (*pge)[3]; */
	int (*pge)[2];
	int ge[IDXNUM][2];

	int ix = 3;
	int aaa[ix][ix];
	int bbb[ix]; /* 编译能够通过! */

	bbb[0] = 4;
	bbb[10000] = 4; /* 运行出错！ */

	for ( i = 0; i < IDXNUM; i++ )
	{
		ge[i][0] = 0;
		ge[i][1] = 1;
	}

	pge = ge;

	return 0;
}
