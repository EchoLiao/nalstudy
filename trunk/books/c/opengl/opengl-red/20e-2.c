#include <GL/glut.h>
#include <stdlib.h>
#include <math.h>

#define X .525731112119133606
#define Z .850650808352039932

static GLfloat distance = 3, ztwist = 8.0, xelevation = 10.0, yazimuth = 30.0;

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

void normcrossprod(float v1 [3],float v2 [3] ,float out [3])
{
    out [0] = v1[1]*v2[2] - v1[2]*v2[1];
    out [1] = v1[2]*v2[0] - v1[0]*v2[2];
    out [2] = v1[0]*v2[1] - v1[1]*v2[0];
    normalize(out);
}

void display(void)
{
    setupLookAt();

    glClear (GL_COLOR_BUFFER_BIT);
    /* glColor3f (1.0, 1.0, 1.0); */
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); /* [(P36)] */

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
    // glRotatef(30, 0.0, 0.0, 1.0);
    glBegin(GL_TRIANGLES);
    for ( i = 0; i < 20; i++ )
    {
        GLfloat d1[3], d2[3], norm[3];
        for ( j = 0; j < 3; j++ )
        {
            d1[j] = vdata[tindices[i][0]][j] - vdata[tindices[i][1]][j];
            d2[j] = vdata[tindices[i][1]][j] - vdata[tindices[i][2]][j];
        }
        normcrossprod(d1,d2,norm);
        glNormal3fv(norm); /*  设置各个面的法向量 */

        /* glColor4f(0.01 * i, 0.00 * i, 0.00 * i, 0.3); */
        glVertex3fv(&vdata[tindices[i][0]][0]);
        /* glColor4f(0.00 * i, 0.05 * i, 0.00 * i, 0.3); */
        glVertex3fv(&vdata[tindices[i][1]][0]);
        glColor3f(0.04 * i, 0.00 * i, 0.00 * i);
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
    static GLfloat fat = 2.5;

    glViewport (0, 0, (GLsizei) w, (GLsizei) h);

    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    /* gluOrtho2D (0.0, (GLdouble) w, 0.0, (GLdouble) h); */
    /* 为了使得场景画到视口后是1:1的比例, 而不被拉申或压缩, 必须得根据视口的宽
     * 与高(在这是 w 和 h, 由 glViewport 设定)作一些调整: 使得视景体的截面与视
     * 口相似(相似四边形) */
    glOrtho (-fat * (GLfloat)w / (GLfloat)h,
         fat * (GLfloat)w / (GLfloat)h, -fat, fat, -10.0, 10.0);

    setupLookAt();
}

void keyboard(unsigned char key, int x, int y)
{
    switch (key) {
        case 'x':
            xelevation = (int)(xelevation + 10) % 360;
            break;
        case 'y':
            yazimuth = (int)(yazimuth + 10) % 360;
            break;
        case 'z':
            ztwist = (int)(ztwist + 10) % 360;
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
    glutInitWindowSize (850, 450);
    glutCreateWindow (argv[0]);
    init ();
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc (keyboard);
    glutMainLoop();
    return 0;
}
