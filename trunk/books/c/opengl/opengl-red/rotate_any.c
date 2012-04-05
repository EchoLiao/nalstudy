/*
 * ===========================================================================
 *
 *       Filename:  rotate_any.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2012年04月05日 20时27分48秒
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

/*
 *  绕任意轴旋转:
 *      1. 平移对象, 使得旋转轴通过坐标原点;
 *      2. 旋转对象, 使得旋转轴与某一坐标轴重合;
 *      3. 绕坐标轴完成指定的旋转;
 *      4. 利用逆旋转使旋转回到其原始方向;
 *      5. 利用逆平移使平移回到原始位置.
 * */


#include <GL/glut.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>



#define drawOnePoint(x, y)           do { \
    glBegin(GL_POINTS);  \
    glVertex2f ((x), (y)); glEnd(); \
} while ( 0 );

#define drawOneLine(x1, y1, x2, y2)    do { \
    glBegin(GL_LINES);  \
    glVertex2f ((x1),(y1)); glVertex2f ((x2),(y2)); glEnd(); \
} while ( 0 );



static float    fAY  = 0.3;
static float    fTX  = 0.9;
static float    fTY  = 0.2;
static float    fRX  = 56.0;
static float    fRZ  = 36.0;
static float    fAng = 0.0;


void init(void)
{
    GLfloat values[2];
    glGetFloatv (GL_LINE_WIDTH_GRANULARITY, values);
    printf ("GL_LINE_WIDTH_GRANULARITY value is %3.1f\n", values[0]);
    glGetFloatv (GL_LINE_WIDTH_RANGE, values);
    printf ("GL_LINE_WIDTH_RANGE values are %3.1f %3.1f\n", values[0],
            values[1]);

    glEnable (GL_LINE_SMOOTH);
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glHint (GL_LINE_SMOOTH_HINT, GL_DONT_CARE);
    glLineWidth (0.5);

    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

    glClearColor (0.0, 0.0, 0.0, 0.0);
    glShadeModel (GL_FLAT);
}

void drawOriObj(void)
{
    glRectf(-0.2, -fAY, 0.4, fAY);
}

void drawObj1(void)
{
    glRotatef(fRZ, 0.0, 0.0, 1.0);
    glTranslatef(0.0, fAY, 0.0);
    drawOriObj();
}

void drawObj2(void)
{
    glTranslatef(fTX, fTY, 0.0);
    glRotatef(fRX, 1.0, 0.0, 0.0);
    glRotatef(fRZ, 0.0, 0.0, 1.0);
    glTranslatef(0.0, fAY, 0.0);
    drawOriObj();
}

void display(void)
{
    int i;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glLoadIdentity();
    glTranslatef(0.0, 0.0, -2.0);
    glLineWidth(4.0);

    /* 绕通过原点的轴旋转 */
    glPushMatrix(); {
        glPushMatrix(); {   // 物体最原始位置
            glColor3f(0.0, 1.0, 0.0);
            drawOriObj();
        } glPopMatrix();

        glPushMatrix(); {   // 通过原点的旋转轴
            glColor3f(1.0, 1.0, 0.0);
            glRotatef(fRZ, 0.0, 0.0, 1.0);
            drawOneLine(-0.9, 0.0, 0.9, -0.0);
        } glPopMatrix();

        glPushMatrix(); {   // 一边与旋转轴重合的矩形(物体)
            glColor3f(0.0, 0.0, 1.0);
            drawObj1();
        } glPopMatrix();
        glPushMatrix(); {   // 实现绕通过原点的轴旋转
            glRotatef( fRZ, 0.0, 0.0, 1.0);
            glRotatef(fAng, 1.0, 0.0, 0.0);
            glRotatef(-fRZ, 0.0, 0.0, 1.0);
            glPushMatrix(); {
                glColor3f(0.0, 0.0, 0.5);
                drawObj1();
            } glPopMatrix();
        } glPopMatrix();
    } glPopMatrix();


    /* 绕不通过原点的轴旋转 */
    glPushMatrix(); {
        glPushMatrix(); {   // 不通过原点的任意旋转轴
            glColor3f(1.0, 0.0, 1.0);
            glTranslatef(fTX, fTY, 0.0);
            glRotatef(fRX, 1.0, 0.0, 0.0);
            glRotatef(fRZ, 0.0, 0.0, 1.0);
            drawOneLine(-0.9, 0.0, 0.9, -0.0);
        } glPopMatrix();

        glPushMatrix(); {   // 一边与旋转轴重合的矩形(物体)
            glColor3f(0.0, 1.0, 1.0);
            drawObj2();
        } glPopMatrix();
        glPushMatrix(); {   // 实现绕不通过原点的轴旋转
            glTranslatef( fTX, fTY, 0.0);
            glRotatef( fRX, 1.0, 0.0, 0.0);
            glRotatef( fRZ, 0.0, 0.0, 1.0);
            glRotatef(fAng, 1.0, 0.0, 0.0);
            glRotatef(-fRZ, 0.0, 0.0, 1.0);
            glRotatef(-fRX, 1.0, 0.0, 0.0);
            glTranslatef(-fTX, -fTY, 0.0);
            glPushMatrix(); {
                glColor3f(0.0, 1.0, 0.5);
                drawObj2();
           } glPopMatrix();
        } glPopMatrix();

        glPushMatrix(); {
        } glPopMatrix();
    } glPopMatrix();


    // 画出最开始的坐标系
    glLineWidth(0.5);
    glPushMatrix(); {
        glColor3f(1.0, 0.0, 0.0);
        drawOneLine(-8.0, 0.0, 8.0, 0.0);
        drawOneLine(0.0, -8.0, 0.0, 8.0);

        glColor3f(1.0, 1.0, 1.0);
        glPointSize(10.0);
        drawOnePoint(0.0, 0.0); // 原点

        glPointSize(4.0);
        for ( i = -8; i <= 9; i++ ) // X scale
            drawOnePoint(0.2 * i, 0.0);
        for ( i = -8; i <= 9; i++ ) // Y scale
            drawOnePoint(0.0, 0.2 * i);
    } glPopMatrix();


    glFlush();
    glutSwapBuffers();

    if ( (fAng += 0.5) > 360.0 )
        fAng = 0.0;

    printf("NALL ## %f\n", fAng);
}

void reshape (int w, int h)
{
    float ratio = (float)w / h;

    glViewport (0, 0, (GLsizei)w, (GLsizei)h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    glFrustum(-ratio/2.0, ratio/2.0, -0.5, 0.5, 1.0, 100.0);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

void keyboard (unsigned char key, int x, int y)
{
    switch (key) {
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
    glutInitDisplayMode (GLUT_DOUBLE | GLUT_RGBA);
    glutInitWindowSize (1280/1.5, 720/1.5);
    glutInitWindowPosition (0, 0);
    glutCreateWindow (argv[0]);
    init();
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard);
    glutIdleFunc(display);

    glutMainLoop();

    return 0;
}

