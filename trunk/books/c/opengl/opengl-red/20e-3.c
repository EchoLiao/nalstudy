#include <GL/glut.h>
#include <stdlib.h>
#include <math.h>

#define X .525731112119133606
#define Z .850650808352039932


void normalize(float v [3])
{
    GLfloat d =sqrt(v [0]*v [0]+v [1]*v [1]+v [2]*v [2]);
    if (d ==0.0){
        error("zero length vector ");
        return;
    }
    v [0] /=d;
    v [1] /=d;
    v [2] /=d;
}

void display(void)
{
    glClear (GL_COLOR_BUFFER_BIT);
    /* glColor3f (1.0, 1.0, 1.0); */

    static GLfloat vdata[12][3] = {
        {-X, 0.0, Z}, {X, 0.0, Z},  {-X, 0.0, -Z}, {X, 0.0, -Z},
        {0.0, Z, X},  {0.0, Z, -X}, {0.0, -Z, X},  {0.0, -Z, -X},
        {Z, X, 0.0},  {-Z, X, 0.0}, {Z, -X, 0.0},  {-Z, -X, 0.0},
    };
    static GLuint tindices[20][3] = {
        {1, 4, 0},  {4, 9, 0},  {4, 5, 9}, {8, 5, 4}, {1, 8, 4},
        {1, 10, 8}, {10, 3, 8}, {8, 3, 5}, {3, 2, 5}, {3, 7, 2},
        {3, 10, 7}, {10, 6, 7}, {6, 11, 7}, {6, 0, 11}, {6, 1, 0},
        {10, 1, 6}, {11, 0, 9}, {2, 11, 9}, {5, 2, 9}, {11, 2, 7},
    };

    int i, j;
    glRotatef(30, 0.0, 0.0, 1.0);
    glBegin(GL_TRIANGLES);
    for ( i = 0; i < 20; i++ )
    {
        /* 模拟着色球体.
         * 需要使用垂直于球体真正表面的法线向量, 而不是垂直于各个面的法线向量
         * ; 对于球体而言, 法线向量是非常简单的, 每个点上法线向量的方向就是从
         * 原点到对应顶点的那条向量的方向 */
        glNormal3fv(&vdata[tindices[i][0]][0]);
        glVertex3fv(&vdata[tindices[i][0]][0]);
        glNormal3fv(&vdata[tindices[i][1]][0]);
        glVertex3fv(&vdata[tindices[i][1]][0]);
        glColor3f(0.04 * i, 0.00 * i, 0.00 * i);
        glNormal3fv(&vdata[tindices[i][2]][0]);
        glVertex3fv(&vdata[tindices[i][2]][0]);
    }
    glEnd();

    glFlush ();
}

void init (void)
{
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glShadeModel (GL_FLAT);
    /* glOrtho(0.0, 1.0, 0.0,  1.0, -1.0, 1.0); */
}

void reshape (int w, int h)
{
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    /* gluOrtho2D (0.0, (GLdouble) w, 0.0, (GLdouble) h); */
    glOrtho (-1.5*(GLfloat)w/(GLfloat)h,
         1.5*(GLfloat)w/(GLfloat)h, -1.5, 1.5, -10.0, 10.0);

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
