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
 *  light.c
 *  This program demonstrates the use of the OpenGL lighting
 *  model.  A sphere is drawn using a grey material characteristic.
 *  A single light source illuminates the object.
 */
#include <GL/glut.h>
#include <stdlib.h>

/*  Initialize material property, light source, lighting model,
 *  and depth buffer.
 */
void init(void)
{
   GLfloat mat_specular[] = { 1.0, 1.0, 1.0, 1.0 };
   GLfloat mat_shininess[] = { 28.0 }; // 值越大亮点就越小越亮
   GLfloat light_position[] = { 0.0, 22.0, 22.0, 1.0 }; // 位置性光源 [(P131)]

   // 第二个光源
   /* 环境光主要影响整个场景物体的颜色; 而散射光很容易受到环境光影响, 只有在没
    * 有环境光时才能明显感受到它的影响; 镜面光主要影响最亮点的颜色. 
    * */
   GLfloat light1_ambient[] = { 1.0, 0.0, 0.0, 1.0 };  // 环境光
   GLfloat light1_diffuse[] = { 1.0, 1.0, 1.0, 1.0 };  // 散射光
   GLfloat light1_specular[] = { 1.0, 1.0, 1.0, 1.0 }; // 镜面光
   GLfloat light1_position[] = { 0.0, -0.3, 3.0, 1.0 }; // 位置性光源
   // GLfloat light1_position[] = { 0.0, 0.0, 6.0, 0.0 }; // 方向性光源
   GLfloat spot_direction[] = { 0.0, -0.7, -1.0 };     // 聚光灯方向

   glClearColor (0.0, 0.0, 0.0, 0.0);
   // glShadeModel (GL_FLAT); // 会出现明显的边痕
   glShadeModel (GL_SMOOTH);

   // [(P140)]
   glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);   // 材料的境面颜色
   glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess); // 境面指数
   glLightfv(GL_LIGHT0, GL_POSITION, light_position);

   // 第二个光源
   glLightfv(GL_LIGHT1, GL_AMBIENT, light1_ambient);
   glLightfv(GL_LIGHT1, GL_DIFFUSE, light1_diffuse);
   glLightfv(GL_LIGHT1, GL_SPECULAR, light1_specular);
   glLightfv(GL_LIGHT1, GL_POSITION, light1_position);
   // 把第个光源设为聚光灯类型(GL_SPOT_CUTOFF != 180)
   glLightf(GL_LIGHT1, GL_LINEAR_ATTENUATION, 0.8);     // 线性衰减因子
   glLightf(GL_LIGHT1, GL_QUADRATIC_ATTENUATION, 0.2);  // 二次衰减因子
   glLightf(GL_LIGHT1, GL_SPOT_CUTOFF, 45.0);           // 聚光灯切角
   glLightfv(GL_LIGHT1, GL_SPOT_DIRECTION, spot_direction); // 聚光灯方向
   glLightf(GL_LIGHT1, GL_SPOT_EXPONENT, 2.0); // 聚光灯指数, 值越小越聚 


   // 开启光照
   glEnable(GL_LIGHTING);
   glEnable(GL_LIGHT0);
   glEnable(GL_LIGHT1);
   glEnable(GL_DEPTH_TEST); // 开启深度测试 
}

void display(void)
{
   glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
   glutSolidSphere (1.0, 20, 16); // 其已计算顶点法向量
   glFlush ();
}

void reshape (int w, int h)
{
   glViewport (0, 0, (GLsizei) w, (GLsizei) h);
   glMatrixMode (GL_PROJECTION);
   glLoadIdentity();
   if (w <= h)
      glOrtho (-1.5, 1.5, -1.5*(GLfloat)h/(GLfloat)w,
         1.5*(GLfloat)h/(GLfloat)w, -10.0, 10.0);
   else
      glOrtho (-1.5*(GLfloat)w/(GLfloat)h,
         1.5*(GLfloat)w/(GLfloat)h, -1.5, 1.5, -10.0, 10.0);

   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity();
}

void keyboard(unsigned char key, int x, int y)
{
   switch (key) {
      case 27:
         exit(0);
         break;
   }
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
   glutKeyboardFunc(keyboard);
   glutMainLoop();
   return 0;
}
