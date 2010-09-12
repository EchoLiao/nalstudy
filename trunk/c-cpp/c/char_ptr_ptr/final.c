/*
 * =====================================================================================
 *
 *       Filename:  char_ptr_ptr.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2010年04月17日 22时58分32秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerll (nuoliu), lcy3636@126.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <string.h>


int main (int argc, char *argv[])
{
    int len = 0, pos = 0;
    /* str[0] 它的意义为一个指针(的值) */
    static char *str[100] = {"axdjl\0\0\0\0k\0ffff", "we"};
    static char des[sizeof(str)];

    pos = 0;
    memmove((void*)(des + pos), (void*)&str[0], sizeof(char*));

    pos += sizeof(char*);
    memmove((void*)(des + pos), (void*)&str[1], sizeof(char*));

    pos += sizeof(char*);
    len = strlen(str[0]) + 1;
    memmove((void*)(des + pos), (void*)str[0], len);

    pos += len;
    len = strlen(str[1]) + 1;
    memmove((void*)(des + pos), (void*)str[1], len);

    /* pp[0] 它的意义为一个指针(的值) */
    char **pp = (char**) des;

    printf("%d ", sizeof(str));
    printf("%d ", strlen(str[0]));
    printf("\n");

/* ============================================================================================== */
/*      |------------|            I       |------|            I      |------------|               */
/*      |            |            I       |      |            I      |            |               */
/*      |------------|            I       |------|            I      |------------|               */
/*      | 0x0        |            I       | 0x04 |            I      | 0x6a647861--->(即axdj的值) */
/* str+2|------------|0x08049ba8  I  des+2|------|0x08049d62  I  pp+2|------------|0x08049d68     */
/*      | 0x080489fa |            I       | 0x89 |            I      | 0x080489fa |               */
/* str+1|------------|0x08049ba4  I  des+1|------|0x08049d61  I  pp+1|------------|0x08049d64     */
/*      | 0x080489ea |            I       | 0xea |            I      | 0x080489ea |               */
/* str  |------------|0x08049ba0  I  des  |------|0x08049d60  I  pp  |------------|0x08049d60     */
/*                                I                           I                                   */
/*           str                  I         des               I           pp                      */
/*                                                                                                */
    printf("%p ", str);
    printf("%p ", str+1);
    printf("%p ", str+2);
    printf("\n");
    printf("%p ", &str[0]);
    printf("%p ", &str[1]);
    printf("%p ", &str[2]);
    printf("%p ",  &pp[0]);
    printf("%p ",  &pp[1]);
    printf("%p ",  &pp[2]);
    printf("%p ", &des[0]);
    printf("%p ", &des[1]);
    printf("%p ", &des[2]);
    printf("\n");

    printf("0x%x ", *str);	    /* 取回4个字节里的值 */
    printf("0x%x ", *(str + 1));
    printf("0x%x ", *(str + 2));
    printf("0x%x ", *des);	    /* 取回1个字节里的值, 存放在4 个字节里
				       (uint), 其高3字节按第一个的最高位进行填
				       充. 如: 0x04 ==> 0x00000004, 0xaa ==> 0xffffffaa */
    printf("0x%x ", *(des + 1));
    printf("0x%x ", *(des + 2));
    printf("0x%x ", *pp);	    /* 取回4个字节里的值 */
    printf("0x%x ", *(pp  + 1));
    printf("0x%x ", *(pp  + 2));
    printf("\n");
/* ============================================================================================== */

    /* 联想一下:
     *	1).  char s[33]; ==> s == &s[0] ==>
     *       printf("%s", s); <==> printf("%s", &s[0])
     *	2).  int s; ==> printf("%d", s); 注意: 是s而不是&s !!!!!
     * */
    printf("%s ", str[0]); /* 把要输出的字符串首地址传递给printf, 即str[0]的值 */
    printf("%s\t", str[1]);
    /* 指针数组不是顺序存储, 所以不能通过计算得到字符串首地址 */
    /* ... */
    printf("%s ", pp[0]);
    printf("%s\t", pp[1]);
    printf("%s ", (des + 4 + 4)); /* ..., 即(des + 4 + 4) */
    printf("%s\n", (des + 4 + 4 + strlen(str[0]) + 1));

    printf("0x%x ", pp[0]); /* !!!!! */ /* pp[0]的值, 不是地址!!!!! */
    printf("0x%x ", pp[1]); /* !!!!! */
    printf("0x%x ", pp[2]); /* !!!!! */
    printf("0x%x ", &pp[0]);/* !!!!! */ /* pp[0]的地址 */
    printf("0x%x ", &pp[1]);
    printf("0x%x ", &pp[2]);
    printf("\n");

    printf("\n");
    return 0;
}

current
