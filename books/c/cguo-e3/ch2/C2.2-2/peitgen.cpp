#include <math.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

struct NalPoint {
	GLdouble x, y;
};

static void initPeitgen(GLuint xl, GLuint xh);
static void st_func(const NalPoint *p, NalPoint *q);


static GLdouble    XL;
static GLdouble    XH;
static GLdouble    YL;
static GLdouble    YH;
static GLdouble    A, B, C, D;
static const GLdouble M = 40.0;
static const GLdouble L = 3;

const int screenWidth = 640;	   // width of the screen window in pixels 
const int screenHeight = 480;	   // height of the screen window in pixels

//<<<<<<<<<<<<<<<<<<<<<<< myInit >>>>>>>>>>>>>>>>>>>>
void myInit(void)
{
    glClearColor(1.0,1.0,1.0,0.0);       // the background color is white
    glColor3f(0.0f, 0.0f, 0.0f);         // the drawing color is black 
    glPointSize(2.0);		             // a 'dot' is 2 by 2 pixels
    glMatrixMode(GL_PROJECTION); 	   
    glLoadIdentity();
    gluOrtho2D(0.0, (GLdouble)screenWidth, 0.0, (GLdouble)screenHeight);

    initPeitgen(0, screenWidth);
}

static void initPeitgen(GLuint xl, GLuint xh)
{
    NalPoint p, q;
    XL =  9999999999.0;
    XH = -9999999999.0;
    YL =  9999999999.0;
    YH = -9999999999.0;
    p.x = M;
    p.y = L;

    for ( GLdouble a = xl; a < xh; a += 0.05 )
    {
        st_func(&p, &q);
        if ( q.x > XH )
            XH = q.x;
        if ( q.x < XL )
            XL = q.x;
        if ( q.y > YH )
            YH = q.y;
        if ( q.y < YL )
            YL = q.y;
        p = q;
    }

    A = (GLdouble) screenWidth / (XH - XL);
    B = -(GLdouble) (screenWidth * XL) / (XH - XL);
    C = (GLdouble) screenHeight / (YH - YL);
    D = - (GLdouble) (screenHeight * YL) / (YH - YL);
}

static void st_func(const NalPoint *p, NalPoint *q)
{
    q->x = (GLdouble) M * (1 + 2 * L) - p->y + abs(p->x - L * M);
    q->y = (GLdouble) p->x;
}

void peitgen()
{
    NalPoint p, q;
    p.x = M;
    p.y = L;

    glBegin(GL_POINTS);
    for(GLdouble a = 0; a < screenWidth; a += 0.05 )
    {	
        st_func(&p, &q);
        glVertex2d(A * q.x + B, C * q.y + D);
        p = q;
    }
    glEnd();	
}

//<<<<<<<<<<<<<<<<<<<<<<<< myDisplay >>>>>>>>>>>>>>>>>
void myDisplay(void)
{
    glClear(GL_COLOR_BUFFER_BIT);     // clear the screen 

    glColor3f(0.0, 0.0, 0.0);
    peitgen();

	glutSwapBuffers();
    glFlush();		   // send all output to display 
}
//<<<<<<<<<<<<<<<<<<<<<<<< main >>>>>>>>>>>>>>>>>>>>>>
int main(int argc, char** argv)
{
    glutInit(&argc, argv);          // initialize the toolkit
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB); // set the display mode
    glutInitWindowSize(screenWidth, screenHeight); // set the window size
    glutInitWindowPosition(100, 150); // set the window position on screen
    glutCreateWindow("checkerboard"); // open the screen window
    glutDisplayFunc(myDisplay);     // register the redraw function
    myInit();                   
    glutMainLoop(); 		     // go into a perpetual loop
}
