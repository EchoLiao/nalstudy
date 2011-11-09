#include <GL/glut.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#define drawOnePoint(x,y)           do { \
    glBegin(GL_POINTS);  \
    glVertex2f ((x), (y)); glEnd(); \
} while ( 0 );

#define drawOneLine(x1,y1,x2,y2)    do { \
    glBegin(GL_LINES);  \
    glVertex2f ((x1),(y1)); glVertex2f ((x2),(y2)); glEnd(); \
} while ( 0 );

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

void display2(void)
{
    int i;

    glLoadIdentity();               // M{i}
    glTranslatef(0.0, 0.0, -6.0);   // M{t0}
    glClear (GL_COLOR_BUFFER_BIT);

    // 画出最开始的坐标系
    glColor3f(1.0, 0.0, 0.0);
    glPushMatrix(); {
        drawOneLine(0.0, 0.0, 20.0, 0.0);
        drawOneLine(0.0, 0.0, 0.0, 20.0);
        glPointSize(4.0);
        drawOnePoint(0.0, 0.0); // 原点

        // X scale
        for ( i = 1; i <= 9; i++ )
            drawOnePoint(1.0 * i, 0.0);

        // Y scale
        for ( i = 1; i <= 9; i++ )
            drawOnePoint(0.0, 1.0 * i);
    } glPopMatrix();


    glColor3f(0.0, 1.0, 0.0);
    glPushMatrix(); {
        // 物体的原始位置
        glTranslatef(4.0, 0.0, 0.0);
        glTranslatef(0.0, 1.0, 0.0);

        // Z 为 0.0 使得画出的是一个真正的2D矩形
        glScalef (1.0, 0.2, 0.0);
        glutWireCube (1.0);
    } glPopMatrix();

    //
    // 注意: [(P84 <red>)]    -- MMMMM
    //       在 OpenGL 中, 所有的矩阵乘法都是按照下面这种方式进行的: 假设当前
    //       矩阵是 C , glMultMatrix*() 或其它任何变换函数的矩阵是 M , 在相乘
    //       之后, 最终的矩阵总是 CM .
    //
    //
    // P' = ((((((M{i} * M{t0}) * M{t1}) * M{t2}) * M{t3}) * M{r}) * M{s}) * P    // (A)
    //    = (M{t0} * (M{t1} * (M{t2} * (M{t3} * (M{r} * (M{s} * M{i})))))) * P    // (B)
    //    = (M{t0} * M{t1} * M{t2} * M{t3} * M{r} * M{s} * M{i}) * P
    //
    // 按 (A) 或 (B) 的方式去理解都可以:
    //     A. 按局部坐标系去理解. 每一次变换(矩阵相乘)都会改变该局部坐标系, 因
    //        此无论之前发生了什么变换, 到画图渲染时, 都相对于该局部坐标系, 且
    //        物体永远在该局部坐标系的原点. 比如: 不论之前发生了什么变换, 若当
    //        前变换是旋转, 则该旋转的"基准点"是该局部坐标系的原点, 所以旋转的
    //        结果是绕该局部坐标系的原点进行自转.
    //     B. 按全局坐标系去理解. 每一次变换都会改变物体在该全局坐标系中坐标,
    //        因此无论之前发生了什么变换, 到画图渲染时, 都相对于该全局坐标系,
    //        且物体的坐标是不断地改变的. 比如: 如果之前发生了移动变换, 而当前
    //        的变换是旋转, 则该旋转的"基准点"是该全局坐标系的原点, 所以旋转的
    //        结果是以原点为圆心, 以物体的当前位置到原点的距离为半径画弧. 数学
    //        上, 一般是以该种方式进行推导的.
    //
    //     <OpenGL中, 对于移动, 旋转, 缩放等基本变换, 没有提供通用的变换方法,
    //     只提供了最基本的变换方法(如: 对于旋转和缩放OpenGL把原点作为这些变换
    //     操作的基准点). 如: 对于旋转, 并没有提供一个通用的方法(函数)去对任意
    //     的基准点进行旋转操作, 但我们可以结合其提供的最基本的变换方法来实现
    //     这种需求.>
    //
    // <矩阵相乘不遵循交换律, 但遵循结合律>
    //
    glColor3f(0.0, 0.0, 1.0);
    glPushMatrix(); {
        // 物体的原始位置
        glTranslatef(4.0, 0.0, 0.0);  // M{t1}
        glTranslatef(0.0, 1.0, 0.0);  // M{t2}

        // 移动到新的位置, 并旋转
        glTranslatef(0.0, 4.0, 0.0);  // M{t3}
        glRotatef(90, 0.0, 0.0, 1.0); // M{r}
        glScalef (1.0, 0.2, 0.0);     // M{s}
        glutWireCube (1.0);
    } glPopMatrix();
    //
    // 从渲染的结果可知: glTranslatef() 等函数会构造一个新的矩阵(M(t)), 把它
    //                   左乘当前矩阵(M(c)), 并把当前矩阵更新为相乘后的结果.
    //               即:
    //                   M(c) = M(t) * M(c)
    //
    // 注意: glRotatef, glScalef 等函数的效果的都是产生于"基准点是原点"这一前提
    //

    glutSwapBuffers();
}

void reshape (int w, int h)
{
    glViewport (0, 0, (GLsizei)w, (GLsizei)h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    glFrustum(-1.0, 1.0, -1.0, 1.0, 1, 10);

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
