/*
 * ===========================================================================
 *
 *       Filename:  slib.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年02月13日 10时20分46秒
 *        Created:
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

#ifndef SLIB_H_H
#define SLIB_H_H

#include "commdef.h"


char *sl_strncpy(char *dst, const char *src, int *dstsize);

char *sl_remove_agspace(char *str);

#endif
