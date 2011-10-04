#include <math.h>
#include <stdio.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

const int screenWidth = 640;	   // width of the screen window in pixels 
const int screenHeight = 480;	   // height of the screen window in pixels

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

void checkerboard(int size)
{
    int i, j;
    for ( i = 0; i < 8; i++ )
    {
        for ( j = 0; j < 8; j++ )
        {
            if ( (i + j) % 2 == 0 )
                glColor3f(0.6, 0.6, 0.6);
            else
                glColor3f(0.2, 0.2, 0.2);
            glRecti(j*size, i*size, (j+1)*size, (i+1)*size); 
        }
    }
}

//<<<<<<<<<<<<<<<<<<<<<<<< myDisplay >>>>>>>>>>>>>>>>>
void myDisplay(void)
{
    glClear(GL_COLOR_BUFFER_BIT);     // clear the screen 

    // glTranslatef(49, 49, 0.0);
    checkerboard(40);

    glFlush();		   // send all output to display 
}
//<<<<<<<<<<<<<<<<<<<<<<<< main >>>>>>>>>>>>>>>>>>>>>>
int main(int argc, char** argv)
{
    glutInit(&argc, argv);          // initialize the toolkit
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB); // set the display mode
    glutInitWindowSize(screenWidth, screenHeight); // set the window size
    glutInitWindowPosition(100, 150); // set the window position on screen
    glutCreateWindow("checkerboard"); // open the screen window
    glutDisplayFunc(myDisplay);     // register the redraw function
    myInit();                   
    glutMainLoop(); 		     // go into a perpetual loop
}
