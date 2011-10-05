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
 *  unproject.c
 *  When the left mouse button is pressed, this program
 *  reads the mouse position and determines two 3D points
 *  from which it was transformed.  Very little is displayed.
 */
#include <GL/glut.h>
#include <stdlib.h>
#include <stdio.h>

void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT);
    glFlush();
}

/* Change these values for a different transformation  */
void reshape(int w, int h)
{
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    /* 透视投影. */
    gluPerspective (45.0, (GLfloat)w / (GLfloat)h, 1.0, 100.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void mouse(int button, int state, int x, int y)
{
    GLint viewport[4];
    GLdouble mvmatrix[16], projmatrix[16];
    GLint realy;  /*  OpenGL y coordinate position  */
    GLdouble wx, wy, wz;  /*  returned world x, y, z coords  */
    GLdouble winx, winy, winz;  /*  returned window x, y, z coords  */

    switch (button) {
        case GLUT_LEFT_BUTTON:
            if (state == GLUT_DOWN) {
                glGetIntegerv (GL_VIEWPORT, viewport);
                glGetDoublev (GL_MODELVIEW_MATRIX, mvmatrix);
                glGetDoublev (GL_PROJECTION_MATRIX, projmatrix);
                /*  note viewport is height of window in pixels  */
                realy = viewport[3] - (GLint) y - 1;
                printf ("Coordinates at (X, Y) are (%4d, %4d)\n", x, y);
                printf ("Coordinates at cursor are (%4d, %4d)\n", x, realy);
                /* 从世界坐标转换到窗口坐标 */
                gluUnProject ((GLdouble) x, (GLdouble) realy, 0.0,
                        mvmatrix, projmatrix, viewport, &wx, &wy, &wz);
                printf ("World coords at z=0.0 are (%f, %f, %f)\n", wx, wy, wz);
                /* 从窗口坐标转换到世界坐标 */
                gluProject(wx, wy, wz, mvmatrix, projmatrix, viewport,
                        &winx, &winy, &winz);
                printf ("Window coords are (%f, %f, %f)\n", winx, winy, winz);
                gluUnProject ((GLdouble) x, (GLdouble) realy, 1.0,
                        mvmatrix, projmatrix, viewport, &wx, &wy, &wz);
                printf ("World coords at z=1.0 are (%f, %f, %f)\n", wx, wy, wz);
                printf ("\n");
            }
            break;
        case GLUT_RIGHT_BUTTON:
            if (state == GLUT_DOWN)
                exit(0);
            break;
        default:
            break;
    }
}

void keyboard(unsigned char key, int x, int y)
{
    switch (key) {
        case 27:
            exit(0);
            break;
    }
}

/*
 *  Open window, register input callback functions
 */
int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize (500, 500);
    glutInitWindowPosition (500, 100);
    glutCreateWindow (argv[0]);
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc (keyboard);
    glutMouseFunc(mouse);
    glutMainLoop();
    return 0;
}
