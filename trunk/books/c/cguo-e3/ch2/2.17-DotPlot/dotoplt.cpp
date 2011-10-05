// #include <windows.h> // use proper includes for your system
#include <math.h>
#include <stdio.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

static GLdouble st_func(GLdouble x);

const GLdouble XL = 0.0;
const GLdouble XH = 4.0;
const GLdouble YL = -1.0;
const GLdouble YH =  1.0;

const int screenWidth = 640;	   // width of the screen window in pixels 
const int screenHeight = 480;	   // height of the screen window in pixels
GLdouble A, B, C, D;  // values used for scaling and shifting

static GLdouble st_func(GLdouble x)
{
    return exp(-x) * cos(2 * 3.14159265 * x); 
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

    /* 进行一些必要的缩放, 使得图形能够显示在窗口中间(更通用). [(P50)] */
    A = screenWidth / (XH - XL);
    B = -(screenWidth * XL) / (XH - XL);
    C = screenHeight / (YH - YL);
    D = -(screenHeight * YL) / (YH - YL);
    printf("A=%f, B=%f, C=%f, D=%f\n", A, B, C, D);
}
//<<<<<<<<<<<<<<<<<<<<<<<< myDisplay >>>>>>>>>>>>>>>>>
void myDisplay(void)
{
    glClear(GL_COLOR_BUFFER_BIT);     // clear the screen 
    glBegin(GL_POINTS);
    for(GLdouble x = XL; x < XH ; x += 0.005)
    {	
        glVertex2d(A * x + B, C * st_func(x) + D);
    }
    glEnd();	
    glFlush();		   // send all output to display 
}
//<<<<<<<<<<<<<<<<<<<<<<<< main >>>>>>>>>>>>>>>>>>>>>>
int main(int argc, char** argv)
{
    glutInit(&argc, argv);          // initialize the toolkit
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB); // set the display mode
    glutInitWindowSize(screenWidth, screenHeight); // set the window size
    glutInitWindowPosition(100, 150); // set the window position on screen
    glutCreateWindow("Dot Plot of a Function"); // open the screen window
    glutDisplayFunc(myDisplay);     // register the redraw function
    myInit();                   
    glutMainLoop(); 		     // go into a perpetual loop
}