#include <math.h>
#include <time.h>
#include <stdio.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

static void initHayes(GLuint x);
static GLuint st_func(GLuint x);

static GLuint    XL;
static GLuint    XH;
static GLuint    YL;
static GLuint    YH;
static GLuint    initX;
static GLdouble  A, B, C, D;

const int screenWidth = 640;	   // width of the screen window in pixels 
const int screenHeight = 640;	   // height of the screen window in pixels

static void initHayes(GLuint x)
{
    int i;
    initX = x;
    XL = 0;
    YL = 1;
    YH = 1;

    for ( i = 0; x != 1; i++ )
    {
        x = st_func(x);
        if ( YH < x )
            YH = x;
        printf("%u ", x);
    }
    printf("\n");
    XH = i;
    printf("XH = %u\n", XH);

    A = (GLdouble) screenWidth / (XH - XL);
    B = -(GLdouble) (screenWidth * XL) / (XH - XL);
    C = (GLdouble) screenHeight / (YH - YL);
    D = - (GLdouble) (screenHeight * YL) / (YH - YL);
}

//<<<<<<<<<<<<<<<<<<<<<<< myInit >>>>>>>>>>>>>>>>>>>>
void myInit(void)
{
    glClearColor(1.0,1.0,1.0,0.0);       // the background color is white
    glColor3f(0.0f, 0.0f, 0.0f);         // the drawing color is black 
    glPointSize(2.0);		           // a 'dot' is 2 by 2 pixels
    glMatrixMode(GL_PROJECTION); 	   
    glLoadIdentity();
    gluOrtho2D(0.0, (GLdouble)screenWidth, 0.0, (GLdouble)screenHeight);

    initHayes(1024*1024*1024+1);
}

static GLuint st_func(GLuint x)
{
    if ( x % 2 == 0 )
        return x / 2;
    return 3 * x + 1;
}

void hayes()
{
    GLuint x = initX;
    glBegin(GL_POINTS);
    for(GLuint i = 0; i < XH ; i++ )
    {	
        x = st_func(x);
        glVertex2d(A * i + B, C * x + D);
        // printf("(x, y) = (%f, %f)\n", A * i + B, C * x + D);
    }
    glEnd();	
}

//<<<<<<<<<<<<<<<<<<<<<<<< myDisplay >>>>>>>>>>>>>>>>>
void myDisplay(void)
{
    glClear(GL_COLOR_BUFFER_BIT);     // clear the screen 

    glColor3f(0.0, 0.0, 0.0);
    hayes();

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
