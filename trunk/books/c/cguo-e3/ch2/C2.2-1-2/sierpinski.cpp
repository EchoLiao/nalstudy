#include <math.h>
#include <time.h>
#include <stdio.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

struct GLintPoint {
	GLdouble x, y;
};

const int screenWidth = 640;	   // width of the screen window in pixels 
const int screenHeight = 640;	   // height of the screen window in pixels

//<<<<<<<<<<<<<<<<<<<<<<< myInit >>>>>>>>>>>>>>>>>>>>
void myInit(void)
{
    glClearColor(1.0,1.0,1.0,0.0);       // the background color is white
    glColor3f(0.0f, 0.0f, 0.0f);         // the drawing color is black 
    glPointSize(2.0);		           // a 'dot' is 2 by 2 pixels
    glMatrixMode(GL_PROJECTION); 	   
    glLoadIdentity();
    gluOrtho2D(0.0, (GLdouble)screenWidth, 0.0, (GLdouble)screenHeight);
}

static void drawDot(GLdouble x, GLdouble y)
{
    glBegin(GL_POINTS);
    glVertex2d(x, y);
    glEnd();
}

void sierpinski_render()
{
    srand(time(NULL));
    GLintPoint T[3] = { {200, 0}, {600, 10}, {300, 600} };
    int index = rand() % 3;
    GLintPoint point = T[index];
    drawDot(point.x, point.y);
    for ( int i = 0; i < 55000; i++ )
    {
        index = rand() % 3;
        point.x = (point.x + T[index].x) / 2;
        point.y = (point.y + T[index].y) / 2;
        drawDot(point.x, point.y);
    }
}

//<<<<<<<<<<<<<<<<<<<<<<<< myDisplay >>>>>>>>>>>>>>>>>
void myDisplay(void)
{
    glClear(GL_COLOR_BUFFER_BIT);     // clear the screen 

    glColor3f(0.0, 0.0, 0.0);
    sierpinski_render();

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
