/* Copyright (C) 1999 Lucent Technologies */
/* From 'Programming Pearls' by Jon Bentley */

/* bitsortgen.c -- gen $1 distinct integers from U[0,$2) */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int *x;

/* 
 * return random number, it's value is in [a, b].
 * */
int randint(int a, int b)
{
    // return a + (RAND_MAX * rand() + rand()) % (b + 1 - a);
    return a + rand() % (b + 1 - a);
}

int main(int argc, char *argv[])
{
    int i, n, t, p;
    if ( argc != 2 )
    {
        fprintf(stderr, "Usage: %s N\n", argv[0]);
        exit(1);
    }

    srand((unsigned) time(NULL));
    n = atoi(argv[1]);
    if ( (x=malloc(n * sizeof(int))) == NULL )
    {
        fprintf(stderr, "malloc error!\n");
        exit(1);
    }

    for (i = 0; i < n; i++)
        x[i] = i;

    /* 随机打乱数列的顺序 */
    for (i = 0; i < n; i++) {
        p = randint(i, n-1);
        t = x[p];
        x[p] = x[i];
        x[i] = t;
        printf("%d\n", x[i]);
    }

    return 0;
}
