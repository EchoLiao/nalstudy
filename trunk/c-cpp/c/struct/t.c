/*
 * =====================================================================================
 *
 *       Filename:  t.c
 *
 *    Description:  结构体初始化的各种方法。
 *
 *        Version:  1.0
 *        Created:  2011年02月26日 23时47分23秒
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

#define NULL (void*)0

struct tagST
{
    int a;
    float b;
    void *p;
};

int main (int argc, char *argv[])
{
    int a = 3;
    struct tagST st1 = { 1, 3.3, NULL }; // 能正确初始化
    struct tagST st11 = { 1, 3.3, NULL, }; // 能正确初始化
    struct tagST st2 = { 1, 3.3 }; // 能正确初始化
    // struct tagST st3 = { 1, NULL }; // 不能正确初始化
    struct tagST st4 = {
        a = 1,
        .p = NULL,
    }; // 能正确初始化
    struct tagST st5 = {
        a = 1,
    }; // 能正确初始化
    struct tagST st6 = {
        a = 1
    }; // 能正确初始化
    // struct tagST st6 = {
    //    b = 1.3
    // }; // 不能正确初始化
    struct tagST st7 = {
        .b = 1.3
    }; // 能正确初始化

    a++;

    return 0;
}
