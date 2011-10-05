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
 *  planet.c
 *  This program shows how to composite modeling transformations
 *  to draw translated and rotated models.
 *  Interaction:  pressing the d and y keys (day and year)
 *  alters the rotation of the planet around the sun.
 */
#include <GL/glut.h>
#include <stdlib.h>

static int year = 0, day = 0;
static int distance = 8, ztwist = 0, xelevation = 0, yazimuth = 0;


/* 相机绕着原点转观察原点(用极坐标), 即: 先把画笔移动到(0.0, 0.0, -distance), 
 * 并把所要画的物体作一定的旋转 */
void polarView(GLdouble distance, GLdouble twist,
        GLdouble elevation, GLdouble azimuth)
{
    glTranslated(0.0, 0.0, -distance);
    glRotated(-elevation, 1.0, 0.0, 0.0);
    glRotated(azimuth,    0.0, 1.0, 0.0);
    glRotated(-twist,     0.0, 0.0, 1.0);
}

/* 模拟飞机驾驶员观察飞机外的景象 */
void pilotView(GLdouble planex, GLdouble planey,
        GLdouble planez, GLdouble roll,
        GLdouble pitch, GLdouble heading)
{
    glRotated(heading, 1.0, 0.0, 0.0);
    glRotated(pitch,   0.0, 1.0, 0.0);
    glRotated(roll,    0.0, 0.0, 1.0);
    glTranslated(-planex, -planey, -planez);
}

void setupLookAt()
{
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    /* gluLookAt (0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0); */
    polarView(distance, ztwist, xelevation, yazimuth);
}

void init(void)
{
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glShadeModel (GL_FLAT);
}

void display(void)
{
    setupLookAt();

    glClear (GL_COLOR_BUFFER_BIT);
    glColor3f (1.0, 1.0, 1.0);

    glPushMatrix();
    {
        glutWireSphere(1.0, 20, 16);   /* draw sun */

        glPushMatrix();
        /* glRotatef ((GLfloat) year, 0.0, 1.0, 0.0); */
        /* 注意: 两个 glRotatef 和 glTranslatef 之间的顺序!! */
        glRotatef ((GLfloat) year, 0.0, 10.0, 3.0); /* 倾斜公转轴 */
        glTranslatef (1.5, 0.0, 0.0);
        glRotatef ((GLfloat) day, 0.0, 1.0, 0.0);
        glutWireSphere(0.2, 10, 8);    /* draw smaller planet */
        glPopMatrix();

        glPushMatrix();
        glRotatef ((GLfloat) year * 2.0, 0.0, 3.0, 3.0); /* 倾斜公转轴 */
        glTranslatef (2.3, 0.0, 0.0);
        glRotatef ((GLfloat) day * 8.0, 0.0, 1.0, 0.0);
        glutWireSphere(0.2, 10, 8);    /* draw smaller planet */
        glPopMatrix();
    }
    glPopMatrix();

    glutSwapBuffers();
}

void reshape (int w, int h)
{
    static GLboolean isFirst = 1;
    if ( isFirst )
    {
        glViewport (0, 0, (GLsizei) w / 2, (GLsizei) h/2);
        isFirst = 0;
    }
    else
    {
        glViewport (w/2, 0, (GLsizei) w / 2, (GLsizei) h);
    }

    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    gluPerspective(60.0, (GLfloat) w/(GLfloat) h, 1.0, 20.0);

    setupLookAt();
}

void keyboard (unsigned char key, int x, int y)
{
    switch (key) {
        case 'c':
            break;
        case 'd':
            distance += 1;
            break;
        case 'D':
            distance -= 1;
            break;
        case 'x':
            xelevation = (xelevation + 10) % 360;
            break;
        case 'y':
            yazimuth = (yazimuth + 10) % 360;
            break;
        case 'z':
            ztwist = (ztwist + 10) % 360;
            break;
        case 'a':
            day = (day + 10) % 360;
            break;
        case 'A':
            day = (day - 10) % 360;
            break;
        case 'b':
            year = (year + 5) % 360;
            break;
        case 'B':
            year = (year - 5) % 360;
            break;
        case 'r':
            day = (day + 4) % 360;
            year = (year + 2) % 360;
            break;
        case 27:
            exit(0);
            break;
        default:
            break;
    }
    glutPostRedisplay();
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode (GLUT_DOUBLE | GLUT_RGB);
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
