/*
 * =====================================================================================
 *
 *       Filename:  es.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2011年05月18日 15时58分38秒
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


/* 在所有的文件中都能访问到该变量, 在其它文件中要引用该变量时要加上"extern"显
 * 示声明其已定义在此. */
int gTa = 33;


/* static 把该变量的作用限制在该文件内, 在其它文件即使显示加上"extern"也链接不
 * 到! */
/* static int gTa = 33; */


