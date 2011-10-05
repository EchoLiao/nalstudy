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
 *  movelight.c
 *  This program demonstrates when to issue lighting and
 *  transformation commands to render a model with a light
 *  which is moved by a modeling transformation (rotate or
 *  translate).  The light position is reset after the modeling
 *  transformation is called.  The eye position does not change.
 *
 *  A sphere is drawn using a grey material characteristic.
 *  A single light source illuminates the object.
 *
 *  Interaction:  pressing the left mouse button alters
 *  the modeling transformation (x rotation) by 30 degrees.
 *  The scene is then redrawn with the light in a new position.
 */

/* 光源和观察点一起移动
 * */

#include <GL/glut.h>
#include <stdlib.h>

static GLdouble ex = 0.0, ey = 0.0, ez = 5.0, upx = 0.0, upy = 1.0, upz = 0.0; 

/* 光源的位置, 与观察点重合; 即使不是重合的两者也是永远保持着一样的距离 */
static GLfloat light_position[] = { 0.0, 0.0, 0.0, 1.0 };

/*  Initialize material property, light source, lighting model,
 *  and depth buffer.
 */
void init(void)
{
   glClearColor (0.0, 0.0, 0.0, 0.0);
   glShadeModel (GL_SMOOTH);
   glEnable(GL_LIGHTING);
   glEnable(GL_LIGHT0);
   glEnable(GL_DEPTH_TEST);
}

void display(void)
{
   glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
   glPushMatrix ();
       glMatrixMode(GL_MODELVIEW);
       glLoadIdentity();
       /* 改变观察点的位置, 即移动画笔; (光源的位置是视觉坐标的形式存储的, 所
        * 以 gluLookAt 也会影响到光源的位置). 
        * 也可以理解为: [(P137)] . 
        * (gluLookAt的本质是 glTranslated, glRotated 等)
        * */
       gluLookAt(ex, ey, ez, 0.0, 0.0, 0.0, upx, upy, upz);

       glutSolidTorus (0.275, 0.85, 8, 15);
   glPopMatrix ();
   glFlush ();
}

void reshape (int w, int h)
{
   glViewport (0, 0, (GLsizei) w, (GLsizei) h);

   glMatrixMode (GL_PROJECTION);
   glLoadIdentity();
   gluPerspective(40.0, (GLfloat) w/(GLfloat) h, 1.0, 20.0);

   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity();
   glLightfv(GL_LIGHT0, GL_POSITION, light_position);
}

void mouse(int button, int state, int x, int y)
{
   switch (button) {
      default:
         break;
   }
}

void keyboard(unsigned char key, int x, int y)
{
   switch (key) {
      case 'x':
          ex += 0.1;
         break;
      case 'y':
         ey += 0.1;
         break;
      case 'z':
         ez += 0.1;
         break;
      case 'X':
         ex -= 0.1;
         break;
      case 'Y':
         ey -= 0.1;
         break;
      case 'Z':
         ez -= 0.1;
         break;
      case 27:
         exit(0);
         break;
   }
   glutPostRedisplay();
}

int main(int argc, char** argv)
{
   glutInit(&argc, argv);
   glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB | GLUT_DEPTH);
   glutInitWindowSize (500, 500);
   glutInitWindowPosition (100, 100);
   glutCreateWindow (argv[0]);
   init ();
   glutDisplayFunc(display);
   glutReshapeFunc(reshape);
   glutMouseFunc(mouse);
   glutKeyboardFunc(keyboard);
   glutMainLoop();
   return 0;
}
