#include <GL/glut.h>
#include <stdlib.h>

#define X .525731112119133606
#define Z .850650808352039932


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
        {1, 4, 0}, {4, 9, 0},   {4, 5, 9}, {8, 5, 4}, {1, 8, 4},
        {1, 10, 8}, {10, 3, 8}, {8, 3, 5}, {3, 2, 5}, {3, 7, 2},
        {3, 10, 7}, {10, 6, 7}, {6, 11, 7}, {6, 0, 11}, {6, 1, 0},
        {10, 1, 6}, {11, 0, 9}, {2, 11, 9}, {5, 2, 9}, {11, 2, 7},
    };

    int i;
    /* glRotatef(10, 1.0, 0.0, 0.0); */
    glBegin(GL_TRIANGLES);
    for ( i = 0; i < 20; i++ )
    {
        /* glColor4f(0.01 * i, 0.00 * i, 0.00 * i, 0.3); */
        glVertex3fv(&vdata[tindices[i][0]][0]);
        /* glColor4f(0.00 * i, 0.05 * i, 0.00 * i, 0.3); */
        glVertex3fv(&vdata[tindices[i][1]][0]);
        glColor3f(0.04 * i, 0.00 * i, 0.00 * i);
        glVertex3fv(&vdata[tindices[i][2]][0]);
    } glEnd();

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
