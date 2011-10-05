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
 * smooth.c
 * This program demonstrates smooth shading.
 * A smooth shaded polygon is drawn in a 2-D projection.
 */

#include <GL/glut.h>
#include <stdlib.h>

static int distance = 11, ztwist = 10, xelevation = 10, yazimuth = 10;

// 对应的正方形模形见: [(P29)]
static float v0[3] = { -1.0, -1.0,  1.0 };
static float v1[3] = {  1.0, -1.0,  1.0 };
static float v2[3] = {  1.0,  1.0,  1.0 };
static float v3[3] = { -1.0,  1.0,  1.0 };
static float v4[3] = {  1.0, -1.0, -1.0 };
static float v5[3] = { -1.0, -1.0, -1.0 };
static float v6[3] = { -1.0,  1.0, -1.0 };
static float v7[3] = {  1.0,  1.0, -1.0 };

// 顶点数组
static float vs[] = {
    -1.0, -1.0,  1.0, // 0
     1.0, -1.0,  1.0, // 1
     1.0,  1.0,  1.0, // 2
    -1.0,  1.0,  1.0, // 3
     1.0, -1.0, -1.0, // 4
    -1.0, -1.0, -1.0, // 5
    -1.0,  1.0, -1.0, // 6
     1.0,  1.0, -1.0, // 7
};

// 颜色数组
static float cs[] = { // colors
    0.0, 0.0, 1.0, // 0
    1.0, 0.0, 1.0, // 1
    1.0, 1.0, 1.0, // 2
    0.0, 1.0, 1.0, // 3
    1.0, 0.0, 0.0, // 4
    0.0, 0.0, 0.0, // 5
    0,0, 1.0, 0.0, // 6
    1.0, 1.0, 0.0, // 7
};



/* 相机绕着原点转观察原点(用极坐标), 即: 先把画笔移动到(0.0, 0.0, -distance), 
 * 并把所要画的物体作一定的旋转再作画 */
void polarView(GLdouble distance, GLdouble twist,
        GLdouble elevation, GLdouble azimuth)
{
    glTranslated(0.0, 0.0, -distance);
    glRotated(elevation, 1.0, 0.0, 0.0);
    glRotated(azimuth,   0.0, 1.0, 0.0);
    glRotated(twist,     0.0, 0.0, 1.0);
}

void setupLookAt()
{
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    polarView(distance, ztwist, xelevation, yazimuth);
}

void setupPointer(void)
{
    // 指定数组数据
    glEnableClientState (GL_VERTEX_ARRAY);
    glVertexPointer (3, GL_FLOAT, 0, vs);
    glEnableClientState (GL_COLOR_ARRAY); 
    glColorPointer (3, GL_FLOAT, 0, cs);
}

void init(void)
{
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glShadeModel (GL_SMOOTH);
    /* glShadeModel (GL_FLAT); */
    /* glEnable(GL_DEPTH_TEST); */

    setupPointer();
}

// 用 glDrawElements 画正方体
void cube4(void)
{
    glColor3f (1.0, 0.0, 0.0);
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); /* [(P36)] */

    static GLubyte frontIndices[]  = { 0, 1, 2, 3 };
    static GLubyte rightIndices[]  = { 1, 4, 7, 2 };
    static GLubyte backIndices[]   = { 4, 5, 6, 7 };
    static GLubyte leftIndices[]   = { 5, 0, 3, 6 };
    static GLubyte bottomIndices[] = { 0, 5, 4, 1 };
    static GLubyte topIndices[]    = { 3, 2, 7, 6 };

    // [(P48)]
    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, frontIndices);
    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, rightIndices);
    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, bottomIndices);
    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, backIndices);
    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, leftIndices);
    glDrawElements(GL_QUADS, 4, GL_UNSIGNED_BYTE, topIndices);
}

// 用 glDrawElements 画正方体
void cube3(void)
{
    glColor3f (1.0, 0.0, 0.0);
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); /* [(P36)] */

    static GLubyte allIndices[] = {
        0, 1, 2, 3, // front
        1, 4, 7, 2, // right
        4, 5, 6, 7, // back
        5, 0, 3, 6, // left
        0, 5, 4, 1, // bottom 
        3, 2, 7, 6, // top
    }; 
    glDrawElements(GL_QUADS, 24, GL_UNSIGNED_BYTE, allIndices); /* [(P49)] */ 
}

// 用 glVertex3fv; (GL_TRIANGLE_STRIP) 画正方体
void cube2(void)
{
    glColor3f (1.0, 0.0, 0.0);
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); /* [(P36)] */

    // 侧面
    glBegin(GL_TRIANGLE_STRIP);
        glColor3f (1.0, 0.0, 0.0);
        glVertex3fv(v3);
        glColor3f (0.0, 1.0, 0.0);
        glVertex3fv(v0);
        glColor3f (0.0, 0.0, 1.0);
        glVertex3fv(v2);
        glColor3f (1.0, 1.0, 0.0);
        glVertex3fv(v1);
        glColor3f (1.0, 0.0, 1.0);
        glVertex3fv(v7);
        glColor3f (0.0, 1.0, 1.0);
        glVertex3fv(v4);
        glColor3f (0.5, 0.5, 1.0);
        glVertex3fv(v6);
        glColor3f (0.5, 0.0, 0.0);
        glVertex3fv(v5);
        glColor3f (0.0, 0.5, 0.0);
        glVertex3fv(v3);
        glColor3f (0.0, 0.0, 0.5);
        glVertex3fv(v0);
    glEnd();

    // 底面
    glBegin(GL_TRIANGLE_STRIP); 
        glColor3f (1.0, 1.0, 1.0);
        glVertex3fv(v0);
        glVertex3fv(v1);
        glVertex3fv(v5);
        glVertex3fv(v4);
    glEnd();

    // 顶面
    glBegin(GL_TRIANGLE_STRIP); 
        glColor3f (0.2, 0.2, 0.2);
        glVertex3fv(v3);
        glVertex3fv(v2);
        glVertex3fv(v6);
        glVertex3fv(v7);
    glEnd();
}

// 用 glVertex3fv; (GL_QUADS) 画正方体
void cube(void)
{
    glColor3f (1.0, 0.0, 0.0);
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); /* [(P36)] */

    glBegin (GL_QUADS);
        glColor3f (1.0, 0.0, 0.0);
        glVertex3fv(v0); 
        glVertex3fv(v1); 
        glVertex3fv(v2); 
        glVertex3fv(v3); 

        glColor3f (0.0, 1.0, 0.0);
        glVertex3fv(v2);
        glVertex3fv(v1);
        glVertex3fv(v4);
        glVertex3fv(v7);

        glColor3f (0.0, 0.0, 1.0);
        glVertex3fv(v7);
        glVertex3fv(v4);
        glVertex3fv(v5);
        glVertex3fv(v6);

        glColor3f (0.0, 1.0, 1.0);
        glVertex3fv(v6);
        glVertex3fv(v5);
        glVertex3fv(v0);
        glVertex3fv(v3);

        glColor3f (1.0, 0.0, 1.0);
        glVertex3fv(v5);
        glVertex3fv(v4);
        glVertex3fv(v1);
        glVertex3fv(v0);

        glColor3f (1.0, 1.0, 0.0);
        glVertex3fv(v6);
        glVertex3fv(v3);
        glVertex3fv(v2);
        glVertex3fv(v7);
    glEnd();
}

// 着色正方体 [(P115)]
void colorCube(void)
{
    /* cube3(); [>错误!<]   */
    /* return;              */


    /* glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); [>[(P36)]<] */

    glBegin (GL_QUADS);
        glColor3f (0.0, 0.0, 1.0);
        glVertex3fv(v0); 
        glColor3f (1.0, 0.0, 1.0);
        glVertex3fv(v1); 
        glColor3f (1.0, 1.0, 1.0);
        glVertex3fv(v2); 
        glColor3f (0.0, 1.0, 1.0);
        glVertex3fv(v3); 

        glColor3f (1.0, 1.0, 1.0);
        glVertex3fv(v2);
        glColor3f (1.0, 0.0, 1.0);
        glVertex3fv(v1);
        glColor3f (1.0, 0.0, 0.0);
        glVertex3fv(v4);
        glColor3f (1.0, 1.0, 0.0);
        glVertex3fv(v7);

        glColor3f (1.0, 1.0, 0.0);
        glVertex3fv(v7);
        glColor3f (1.0, 0.0, 0.0);
        glVertex3fv(v4);
        glColor3f (0.0, 0.0, 0.0);
        glVertex3fv(v5);
        glColor3f (0.0, 1.0, 0.0);
        glVertex3fv(v6);

        glColor3f (0.0, 1.0, 0.0);
        glVertex3fv(v6);
        glColor3f (0.0, 0.0, 0.0);
        glVertex3fv(v5);
        glColor3f (0.0, 0.0, 1.0);
        glVertex3fv(v0);
        glColor3f (0.0, 1.0, 1.0);
        glVertex3fv(v3);

        glColor3f (0.0, 0.0, 0.0);
        glVertex3fv(v5);
        glColor3f (1.0, 0.0, 0.0);
        glVertex3fv(v4);
        glColor3f (1.0, 0.0, 1.0);
        glVertex3fv(v1);
        glColor3f (0.0, 0.0, 1.0);
        glVertex3fv(v0);

        glColor3f (0.0, 1.0, 0.0);
        glVertex3fv(v6);
        glColor3f (0.0, 1.0, 1.0);
        glVertex3fv(v3);
        glColor3f (1.0, 1.0, 1.0);
        glVertex3fv(v2);
        glColor3f (1.0, 1.0, 0.0);
        glVertex3fv(v7);
    glEnd();
}

void display(void)
{
    setupLookAt();

    glClear (GL_COLOR_BUFFER_BIT);
    /* glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); */
    
    /* cube(); */
    /* cube2(); */
    /* cube3(); */
    /* cube4(); */
    colorCube();
    glFlush ();
}

void reshape (int w, int h)
{
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    glOrtho (-3.0, 3.0, -3.0, 3.0, 1.0, 50.0);

    /* glMatrixMode(GL_MODELVIEW); */
    /* glLoadIdentity(); */
    /* gluLookAt (2.0, 3.0, 10.0,  0.0, 0.0, 0.0,  0.0, 1.0, 0.0); */
    setupLookAt();
}

void keyboard(unsigned char key, int x, int y)
{
    switch (key) {
        case 'x':
            xelevation = (xelevation + 10) % 360;
            break;
        case 'y':
            yazimuth = (yazimuth + 10) % 360;
            break;
        case 'z':
            ztwist = (ztwist + 10) % 360;
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
    glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize (500, 500);
    glutInitWindowPosition (100, 100);
    glutCreateWindow (argv[0]);
    init ();
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc (keyboard);
    glutMainLoop();
    return 0;
}
