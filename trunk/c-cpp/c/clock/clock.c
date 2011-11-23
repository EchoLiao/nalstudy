/*
 * ===========================================================================
 *
 *       Filename:  clock.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2011年11月23日 15时24分39秒
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
#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <string.h>

/*
 * time_t  为 long int
 * clock_t 为 long int
 */

void print_curtime()
{
    time_t tim;
    tim = time(NULL);
    char *pt = ctime((const time_t*)&tim);
    *(pt + strlen(pt) - 1) = '\0';
    printf("\t\t%ld(%s)\n", tim, pt);
}

/*
 * clock() 返回的是从程序启动开始所使用的cpu的时钟数.
 * 但在C标准中, 规定第一次调用 clock() 所返回的数据是不确定的!
 **/

int main (int argc, char *argv[])
{
    int i, j, x;
    clock_t ck1, ck2, ck3, ck4, ck5;


    ck1 = clock();

#if 0
    // ck1, ck2, ck3 的值都会是0, 因为没有使用cpu.
    sleep(1);
#else
    for ( i = 0; i < 5000; i++ )
    {
        for ( j = 0; j < 50000; j++ )
        {
            // do something
            x = i * j;
        }
    }
#endif

    ck2 = clock();
    ck3 = clock();

    for ( i = 0; i< 5000; i++)
        for ( j = 0; j < 50000; j++ )
            ;
    ck4 = clock();
    ck5 = clock();

    printf("ck1=%ld, ck2=%ld, ck3=%ld, ck4=%ld, ck5=%ld,\tcps=%ld\n",
            ck1, ck2, ck3, ck4, ck5, CLOCKS_PER_SEC);
    print_curtime();

    for ( i = 0; i< 5000000000; i++)
    {
        for ( j = 0; j < 800000000; j++ )
        {
            x = i * j;
        }
        // clock() 有可能返回负数! 并且会发生轮回.
        // 0 --> +max --> -max --> 0
        ck5 = clock();
        printf("ck1=%ld, ck2=%ld, ck3=%ld, ck4=%ld, ck5=%ld,\tcps=%ld\n",
                ck1, ck2, ck3, ck4, ck5, CLOCKS_PER_SEC);
        print_curtime();
        fflush(stdout);
    }

    return 0;
}
