/*
 * Copyright (c) 1993-2003, Silicon Graphics, Inc.
 * All Rights Reserved
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose and without fee is hereby granted, provided that the above
 * copyright notice appear in all copies and that both the copyright
 * notice and this permission notice appear in supporting documentation,
 * and that the name of Silicon Graphics, Inc. not be used in
 * advertising or publicity pertaining to distribution of the software
 * without specific, written prior permission.
 *
 * THE MATERIAL EMBODIED ON THIS SOFTWARE IS PROVIDED TO YOU "AS-IS" AND
 * WITHOUT WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR OTHERWISE,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY OR
 * FITNESS FOR A PARTICULAR PURPOSE.  IN NO EVENT SHALL SILICON
 * GRAPHICS, INC.  BE LIABLE TO YOU OR ANYONE ELSE FOR ANY DIRECT,
 * SPECIAL, INCIDENTAL, INDIRECT OR CONSEQUENTIAL DAMAGES OF ANY KIND,
 * OR ANY DAMAGES WHATSOEVER, INCLUDING WITHOUT LIMITATION, LOSS OF
 * PROFIT, LOSS OF USE, SAVINGS OR REVENUE, OR THE CLAIMS OF THIRD
 * PARTIES, WHETHER OR NOT SILICON GRAPHICS, INC.  HAS BEEN ADVISED OF
 * THE POSSIBILITY OF SUCH LOSS, HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE POSSESSION, USE
 * OR PERFORMANCE OF THIS SOFTWARE.
 *
 * US Government Users Restricted Rights
 * Use, duplication, or disclosure by the Government is subject to
 * restrictions set forth in FAR 52.227.19(c)(2) or subparagraph
 * (c)(1)(ii) of the Rights in Technical Data and Computer Software
 * clause at DFARS 252.227-7013 and/or in similar or successor clauses
 * in the FAR or the DOD or NASA FAR Supplement.  Unpublished - rights
 * reserved under the copyright laws of the United States.
 *
 * Contractor/manufacturer is:
 *	Silicon Graphics, Inc.
 *	1500 Crittenden Lane
 *	Mountain View, CA  94043
 *	United State of America
 *
 * OpenGL(R) is a registered trademark of Silicon Graphics, Inc.
 */

/*
 *  alpha.c
 *  This program draws several overlapping filled polygons
 *  to demonstrate the effect order has on alpha blending results.
 *  Use the 't' key to toggle the order of drawing polygons.
 */
#include <GL/glut.h>
#include <stdlib.h>

static int leftFirst = GL_TRUE;
static GLfloat clR = 1.0, clG = 0.2, clB = 0.3, clA = 0.0;
static GLfloat lfR = 1.0, lfG = 1.0, lfB = 0.0, lfA = 0.35;
static GLfloat rtR = 0.0, rtG = 1.0, rtB = 1.0, rtA = 0.45;

/*  Initialize alpha blending function.
 */
static void init(void)
{
   glEnable (GL_BLEND);
   glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
   glShadeModel (GL_FLAT);
   glClearColor (clR, clG, clB, clA);
}

static void drawLeftTriangle(void)
{
   /* draw yellow triangle on LHS of screen */

   glBegin (GL_TRIANGLES);
      glColor4f(lfR, lfG, lfB, lfA);
      glVertex3f(0.1, 0.9, 0.0);
      glVertex3f(0.1, 0.1, 0.0);
      glVertex3f(0.7, 0.5, 0.0);
   glEnd();
}


/* 
 * Des:
 *     验证 glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA) 在该场景所产生
 *     的混合效果. 
 *
 *     本程序的场景等价于三张图(background, leftTriangle, rightTriangle)的混合
 *     [(P157 E)].
 *
 *     绘图顺序: background -> leftTriangle -> rightTriangle
 */
static void drawCheckTriangle_BLR(void)
{
   glDisable(GL_BLEND);
   glPushMatrix ();

   glScalef(0.5, 0.5, 0.5);
   glTranslated(0.4, 0.2, 0.0);
   /* leftTriangle 和 background 混合等到 left-back */
   GLfloat lR = lfR * lfA + clR * (1.0 - lfA);
   GLfloat lG = lfG * lfA + clG * (1.0 - lfA);
   GLfloat lB = lfB * lfA + clB * (1.0 - lfA);
   GLfloat lA = lfA * lfA + clA * (1.0 - lfA);
   /* 然后: rightTriangle 和 left-back 混合 */
   GLfloat tR = rtR * rtA + lR * (1.0 - rtA);
   GLfloat tG = rtG * rtA + lG * (1.0 - rtA);
   GLfloat tB = rtB * rtA + lB * (1.0 - rtA);
   GLfloat tA = rtA * rtA + lA * (1.0 - rtA);
   glBegin (GL_TRIANGLES);
      glColor4f(tR, tG, tB, tA);
      glVertex3f(0.45, 0.9, 0.0);
      glVertex3f(-0.15, 0.5, 0.0);
      glVertex3f(0.45, 0.1, 0.0);
   glEnd();

   glPopMatrix ();
   glEnable(GL_BLEND);
}

/* 绘图顺序: background -> rightTriangle -> leftTriangle
 */
static void drawCheckTriangle_BRL(void)
{
   glDisable(GL_BLEND);
   glPushMatrix ();

   glScalef(0.5, 0.5, 0.5);
   glTranslated(0.4, 0.2, 0.0);
   glRotatef(-90.0, 0.0, 0.0, 1.0);
   GLfloat rR = rtR * rtA + clR * (1.0 - rtA);
   GLfloat rG = rtG * rtA + clG * (1.0 - rtA);
   GLfloat rB = rtB * rtA + clB * (1.0 - rtA);
   GLfloat rA = rtA * rtA + clA * (1.0 - rtA);
   GLfloat tR = lfR * lfA + rR * (1.0 - lfA);
   GLfloat tG = lfG * lfA + rG * (1.0 - lfA);
   GLfloat tB = lfB * lfA + rB * (1.0 - lfA);
   GLfloat tA = lfA * lfA + rA * (1.0 - lfA);
   glBegin (GL_TRIANGLES);
      glColor4f(tR, tG, tB, tA);
      glVertex3f(0.3, 0.5, 0.0);
      glVertex3f(-0.3, 0.1, 0.0);
      glVertex3f(0.3, -0.3, 0.0);
   glEnd();

   glPopMatrix ();
   glEnable(GL_BLEND);
}

static void drawRightTriangle(void)
{
   /* draw cyan triangle on RHS of screen */

   glBegin (GL_TRIANGLES);
      glColor4f(rtR, rtG, rtB, rtA);
      glVertex3f(0.9, 0.9, 0.0);
      glVertex3f(0.3, 0.5, 0.0);
      glVertex3f(0.9, 0.1, 0.0);
   glEnd();
}

void display(void)
{
   glClear(GL_COLOR_BUFFER_BIT);

   glPushMatrix ();
   glScalef(0.5, 0.5, 0.5);
   if (leftFirst) {
      drawLeftTriangle();
      drawRightTriangle();
   }
   else {
      drawRightTriangle();
      drawLeftTriangle();
   }
   glPopMatrix ();

   drawCheckTriangle_BLR();
   drawCheckTriangle_BRL();

   glFlush();
}

void reshape(int w, int h)
{
   glViewport(0, 0, (GLsizei) w, (GLsizei) h);
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   if (w <= h)
      gluOrtho2D (0.0, 1.0, 0.0, 1.0*(GLfloat)h/(GLfloat)w);
   else
      gluOrtho2D (0.0, 1.0*(GLfloat)w/(GLfloat)h, 0.0, 1.0);

   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity();
   glTranslatef(0.0, 0.3, 0.0);
}

void keyboard(unsigned char key, int x, int y)
{
   switch (key) {
      case 't':
      case 'T':
         leftFirst = !leftFirst;
         glutPostRedisplay();
         break;
      case 27:  /*  Escape key  */
         exit(0);
         break;
      default:
         break;
   }
}

/*  Main Loop
 *  Open window with initial window size, title bar,
 *  RGBA display mode, and handle input events.
 */
int main(int argc, char** argv)
{
   glutInit(&argc, argv);
   glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);
   glutInitWindowSize (600, 600);
   glutInitWindowPosition (500, 10);
   glutCreateWindow (argv[0]);
   init();
   glutReshapeFunc (reshape);
   glutKeyboardFunc (keyboard);
   glutDisplayFunc (display);
   glutMainLoop();
   return 0;
}
