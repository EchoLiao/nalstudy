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
#ifdef	STATIC_CHAR_PTR
    static char str[100] = {"axdjl\0\0\0\0k\0ffff"};
#elif	STATIC_CHAR_PTR_PTR 
    static char *str[100] = {"axdjl\0\0\0\0k\0ffff", "we"};
#endif
    static char des[sizeof(str)];

    pos = 0;
    memmove((void*)(des + pos), (void*)&str[0], sizeof(char*));

    pos += sizeof(char*);
    memmove((void*)(des + pos), (void*)&str[1], sizeof(char*));

    /* pos += sizeof(char*); */
    /* len = strlen(str[1]) + 1; */
    /* memmove((void*)(des + pos), (void*)&str[1], len); */

    /* pos += len; */
    /* len = strlen(str[0]) + 1; */
    /* memmove((void*)(des + pos), (void*)&str[0], len); */

    char **pp = (char**) des;

    printf("%d ", sizeof(str));
    printf("%d ", strlen(str[0]));
    printf("\n");

    printf("%p ", str);
    printf("%p ", &str[0]);
    printf("0x%x ", *(int*)str);
    printf("%p ", &str[1]);
    printf("0x%x\n", *((int*)str + 1));
    printf("%p ", des);
    printf("%p ", &pp[0]);
    printf("0x%x ", *(int*)des);
    printf("%p ", &pp[1]);
    printf("0x%x ", *((int*)des + 1));
    printf("\n");

    printf("%s ", str[0]);
    printf("%s\t", str[1]);
    printf("%s ", pp[0]);
    printf("%s ", pp[1]);
    printf("0x%x ", pp[0]); /* !!!!! */ /* pp[0]的值 */ 
    printf("0x%x ", pp[1]); /* !!!!! */  
    printf("0x%x ", &pp[0]);/* !!!!! */ /* pp[0]的地址 */
    printf("0x%x ", &pp[1]);
    printf("\n");

    /* * (size_t*) (char*)str = 0x74; */
    /* printf("%x ", *(int*)str); */

#ifdef	STATIC_CHAR_PTR
    printf("%c ", *str);
    printf("%s ", str);
    printf("%s ", &str); /* ????? */
#elif	STATIC_CHAR_PTR_PTR 
    printf("%c ", **str);
    printf("%s ", *str);
    printf("%s ", &*str); /* ????? */
    printf("%s ", str[0]);
    printf("%s ", str[1]);
#endif
    printf("%p ", str);
    printf("%p ", &str[0]); /* ????? */
    printf("%p ", &str[1]);
    printf("%p ", &str[2]);
    printf("0x%x ", str);
    printf("0x%x ", &str[0]);
    printf("0x%x ", &str[1]);
    printf("0x%x ", &str[2]);
    printf("\n");

    printf("%p ", pp[0]);
    printf("%p ", *pp);
    printf("%p ", *pp + 1);
    printf("%p ", *pp + 2);
    printf("\n");

    printf("0x%p ", pp[1]);
    printf("0x%x ", *pp);
    printf("0x%x ", *pp + 1);
    printf("0x%x ", *pp + 2);
    printf("\n");

    printf("%p ", pp[0]);
    printf("%p ", pp[1]);
    printf("%s ", pp[0]);
    printf("%s ", pp[1]);
    printf("\n");

    printf("0x%x ", (int) pp[2]);
    printf("0x%x ", *(pp + 1));
    printf("\n");

    printf("%p ", pp[2]);
    printf("%p ", *(pp + 2));
    printf("\n");

    printf("%p ", pp[3]);
    printf("%p ", *(pp + 3));
    printf("\n");

    printf("\n");
    return 0;
}

