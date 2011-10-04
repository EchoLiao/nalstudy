static char rcsid[] =
	"$Id: H:/drh/idioms/book/RCS/inter.doc,v 1.11 1997/02/21 19:42:15 drh Exp $";

#include "arith.h"

int Arith_max(int x, int y)
{
    return x > y ? x : y;
}

int Arith_min(int x, int y)
{
    return x > y ? y : x;
}

/*==========================================================================*
 * @Description: Arith_div() is the maximum integer that does not exceed the
 *   real number z such that z*y=x.
 *               it always truncate toward the left on the number line.
 * 
 * @Param x
 * @Param y
 * 
 * @Returns:   
 * 
 *==========================================================================*/
int Arith_div(int x, int y)
{
    const int a = -13; 
    const int b = 5;
    /* 在编译期间, "-13 / 5 == -2" 已被求出真假, 若为真则说明编译器对"x / y"的
     * 取舍所采用的原则是: 向0方向截断, 故返回值应该是"x / y - 1" */
    if (a / b == -2 && (x < 0) != (y < 0) && x % y != 0)
	return x / y - 1;
    else
	return x / y;
}

/*==========================================================================*
 * @Description:    Arith_mod() is defined to be equal to x-y*Arith_div(x,y).
 *      In if statement: 
 *      Arith_mod(x, y) = x - y * Arith_div(x, y)
 *                      = x - y * (x / y - 1)
 *                      = x - y * (x / y) + y
 *                      = x % y + y
 *
 * @Param x
 * @Param y
 *
 * @Returns:    
 *
 *==========================================================================*/
int Arith_mod(int x, int y)
{
    const int a = -13; 
    const int b = 5;
    if (a / b == -2 && (x < 0) != (y < 0) && x % y != 0)
	return x % y + y;
    else
	return x % y;
}

/*==========================================================================*
 * @Description:    Arith_floor() returns the greatest integer not exceeding 
 *      the real quotient of x/y.
 *
 * @Param x
 * @Param y
 *
 * @Returns:    
 *
 *==========================================================================*/
int Arith_floor(int x, int y)
{
    return Arith_div(x, y);
}

/*==========================================================================*
 * @Description:    Arith_ceiling() returns the least integer not less than 
 *      the real quotient of x/y.
 *
 * @Param x
 * @Param y
 *
 * @Returns:    
 *
 *==========================================================================*/
int Arith_ceiling(int x, int y)
{
    return Arith_div(x, y) + (x % y != 0);
}
