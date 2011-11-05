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
 * robot.c
 * This program shows how to composite modeling transformations
 * to draw translated and rotated hierarchical models.
 * Interaction:  pressing the s and e keys (shoulder and elbow)
 * alters the rotation of the robot arm.
 */
#include <GL/glut.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

static int shoulder = 0, elbow = 0;

void init(void)
{
    GLfloat values[2];
    glGetFloatv (GL_LINE_WIDTH_GRANULARITY, values); // 线条的精确度
    printf ("GL_LINE_WIDTH_GRANULARITY value is %3.1f\n", values[0]);
    glGetFloatv (GL_LINE_WIDTH_RANGE, values);
    printf ("GL_LINE_WIDTH_RANGE values are %3.1f %3.1f\n", values[0],
            values[1]);

    /* 可通过注释以下两行代码来观察抗锯齿的效果 */
    glEnable (GL_LINE_SMOOTH);   // 启用线条抗锯齿功能
    glEnable (GL_BLEND);         // 抗锯齿是通过混合实现的
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glHint (GL_LINE_SMOOTH_HINT, GL_DONT_CARE); // 设置线条采样质量提示
    glLineWidth (0.5);


    glClearColor (0.0, 0.0, 0.0, 0.0);
    glShadeModel (GL_FLAT);
}

struct nalobject
{
    float x;
    float y;
    float z;
    float r; // 旋转角度
    float l; // 长
    float w; // 宽
    float h; // 高
};

struct nalobject g_objs[3];

void st_init_obj_pos(struct nalobject *obj, int num)
{
    /* (x, y, z) 是物体所处的位置的坐标(对应的是起始的坐标系).
     * */
    obj[0].x =  0.0;
    obj[0].y =  0.0;
    obj[0].z =  0.0;
    obj[0].r =  (float)shoulder;
    obj[0].l =  1.0;
    obj[0].w =  0.2;
    obj[0].h =  0.2;

    obj[1].x = -1.0; // 使紧邻 obj[0]
    obj[1].y =  0.0;
    obj[1].z =  0.0;
    obj[1].r =  (float)shoulder;
    obj[1].l =  1.0;
    obj[1].w =  0.2;
    obj[1].h =  0.2;

    obj[2].x = -2.0; // 使紧邻 obj[1]
    obj[2].y =  0.0;
    obj[2].z =  0.0;
    obj[2].r =  (float)shoulder;
    obj[2].l =  1.0;
    obj[2].w =  0.2;
    obj[2].h =  0.2;

    assert(2 < num);
}

void st_display2(struct nalobject *pobj)
{
    glPushMatrix(); { // 使得各个物体的位置不相互受影响.
        glTranslatef (pobj->x, pobj->y, pobj->z);
        glPushMatrix(); {
            glScalef (pobj->l, pobj->w, pobj->h);
            glutWireCube (1.0);
        } glPopMatrix();
    } glPopMatrix();
}

void st_set_pos_for_rotate(struct nalobject *pobj)
{
    glTranslatef(pobj->l / 2, 0.0, 0.0);
}

void st_set_pos_after_rotate(struct nalobject *pobj)
{
    glTranslatef(-pobj->l / 2, 0.0, 0.0);
}

void st_set_rotate(struct nalobject *pobj)
{
    glRotatef (pobj->r, 0.0, 0.0, 1.0);
}

void st_draw_objs(struct nalobject *objs, int num)
{
    int i;

    for ( i = 0; i < num; i++ )
    {
        glPushMatrix(); {
            // 安置旋转点(即: 设置原点位置)
            st_set_pos_for_rotate(&objs[i]);
            // 作些旋转
            st_set_rotate(&objs[i]);
            // 旋转后重新调整原点位置, 为后面画物体作准备
            st_set_pos_after_rotate(&objs[i]);

            st_display2(&objs[i]);
        } glPopMatrix();
    }
}

void display2(void)
{
    int i, num;

    glLoadIdentity();
    glTranslatef (0.0, 0.0, -5.0);
    glClear (GL_COLOR_BUFFER_BIT);

    // 画出最开始的坐标系的原点
    glPushMatrix(); {
        glScalef (0.08, 0.08, 0.08);
        glutWireCube (1.0);
    } glPopMatrix();


    num = sizeof(g_objs) / sizeof(struct nalobject);
    st_init_obj_pos(g_objs, num);

    st_draw_objs(g_objs, num);

    glutSwapBuffers();
}

void display(void)
{
    glClear (GL_COLOR_BUFFER_BIT);
    glPushMatrix();
    {
        /* (1)和(2)的顺序不能打乱! */
        glTranslatef (-1.0, 0.0, 0.0); /* (1) */
        glRotatef ((GLfloat) shoulder, 0.0, 0.0, 1.0); /* (2) */
        glTranslatef (1.0, 0.0, 0.0);
        glPushMatrix();
        {
            glScalef (1.6, 0.4, 1.0); /* 会改变局部坐标系统标尺 */
            glutWireCube (1.0);
        }
        glPopMatrix();

        glTranslatef (1.0, 0.0, 0.0); /* 把局部坐标系统移动到下一个节点 */
        glRotatef ((GLfloat) elbow, 0.0, 0.0, 1.0);
        glTranslatef (1.0, 0.0, 0.0);
        glPushMatrix();
        {
            glScalef (1.6, 0.4, 1.0);
            glutWireCube (1.0);
        }
        glPopMatrix();

        glTranslatef (1.0, 0.0, 0.0);
        glRotatef ((GLfloat) elbow, 0.0, 0.0, 1.0);
        glTranslatef (1.0, 0.0, 0.0);
        glPushMatrix();
        {
            glScalef (1.6, 0.4, 1.0);
            glutWireCube (1.0);
        }
        glPopMatrix();
    }
    glPopMatrix();
    glutSwapBuffers();
}

void reshape (int w, int h)
{
    glViewport (0, 0, (GLsizei)w, (GLsizei)h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    gluPerspective(75.0, (GLfloat) w/(GLfloat) h, 1.0, 20.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    /* 模形视图坐标系统原点变为: (0.0, 0.0, -5.0) */
    glTranslatef (0.0, 0.0, -5.0);
    // glScalef (1.0, 1.0, 1.0); // 不进行任何放缩
}

void keyboard (unsigned char key, int x, int y)
{
    switch (key) {
        case 's':
            shoulder = (shoulder + 5) % 360;
            printf("KKK %d\n", shoulder);
            glutPostRedisplay();
            break;
        case 'S':
            shoulder = (shoulder - 5) % 360;
            glutPostRedisplay();
            break;
        case 'e':
            elbow = (elbow + 5) % 360;
            glutPostRedisplay();
            break;
        case 'E':
            elbow = (elbow - 5) % 360;
            glutPostRedisplay();
            break;
        case 27:
            exit(0);
            break;
        default:
            break;
    }
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode (GLUT_DOUBLE | GLUT_RGB);
    glutInitWindowSize (500, 500);
    glutInitWindowPosition (100, 100);
    glutCreateWindow (argv[0]);
    init ();
    glutDisplayFunc(display2);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard);
    glutMainLoop();
    return 0;
}


