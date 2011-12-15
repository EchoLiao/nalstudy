#include <GL/glut.h>
#include <stdlib.h>
#include <math.h>



void display(void)
{
    glClear (GL_COLOR_BUFFER_BIT);
    glTranslatef(0.0, 0.0, -1.6);

    glFrontFace(GL_CCW);
    glCullFace(GL_BACK);
    glEnable(GL_CULL_FACE);
    glPolygonMode(GL_FRONT, GL_LINE); /* [(P36)] */
    glPolygonMode(GL_BACK, GL_FILL); /* [(P36)] */

    /*
     * 如果是 glFrontFace(GL_CCW), 对于物体<A2>, 视点能看到的是其背面, 但背面
     * 被剔除, 所以<A2>不会被渲染. (对于<A2>的正面, 视点看不到, 显然不用渲染!)
     *
     * 如果是 glFrontFace(GL_CW), 对于物体<A1>, 视点能看到的是其背面, 但背面
     * 被剔除, 所以<A1>不会被渲染!
     *
     * 注意, 剔除操作是在顶点着色阶段执行的!!!!! 所以这些被剔除的顶点没有机会
     * 进入片段着色阶段.
     *
     * */


    // <A1> 顶点顺序是以逆时针指定的
    //    c
    //    |\
    //    | \
    //    |__\
    //    a  b
    //
    glBegin(GL_TRIANGLES);
        glVertex3f(-1.0, -1.0, 1.0); // a
        glVertex3f( 1.0, -1.0, 1.0); // b
        glVertex3f(-1.0,  1.0, 1.0); // c
    glEnd();

    // <A2> 顶点顺序是以顺时针指定的
    //
    //   f___________g
    //   |           |
    //   |___________|
    //   e           h
    //
    glBegin(GL_QUADS);
        glVertex3f(-1.0, -1.0, -0.2); // e
        glVertex3f(-1.0,  1.0, -0.2); // f
        glVertex3f( 1.0,  1.0, -0.2); // g
        glVertex3f( 1.0, -1.0, -0.2); // h
    glEnd();

    glFlush ();
}

void init (void)
{
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glShadeModel (GL_FLAT);
}

void reshape (int w, int h)
{
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);

    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();

    glFrustum (-5.0, 5.0, -5.0, 5.0, 0.5, 10.0);
}

void keyboard(unsigned char key, int x, int y)
{
    switch (key) {
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
    glutInitWindowSize (850, 450);
    glutCreateWindow (argv[0]);
    init ();
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc (keyboard);
    glutMainLoop();
    return 0;
}
