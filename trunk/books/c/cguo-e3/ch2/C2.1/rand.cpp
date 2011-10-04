#include <math.h>
#include <time.h>
#include <stdio.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

#define USE_MINE

static const GLuint g_A = 1103515245;
static const GLuint g_B = 12345;
static const GLuint g_N = 327678997;
static GLuint g_rand;

static GLint st_rand();
static void st_srand(GLuint seed);


const int screenWidth = 640;	   // width of the screen window in pixels 
const int screenHeight = 640;	   // height of the screen window in pixels

static GLint st_rand()
{
    return g_rand = (g_rand * g_A + g_B) % g_N;
}

static void st_srand(GLuint seed)
{
    g_rand = seed % g_N;
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
}

void randfloor(int num)
{
    int i;

#ifdef USE_MINE
    st_srand(time(NULL));
#else
    srand(time(NULL));
#endif

    glBegin(GL_POINTS);
    for ( i = 0; i < num; i++ )
    {
#ifdef USE_MINE
        glVertex2f( (GLfloat) st_rand() * screenWidth / g_N,
                (GLfloat) st_rand() * screenHeight / g_N );
#else
        glVertex2f( (GLfloat) rand() * screenWidth / RAND_MAX,
                (GLfloat) rand() * screenHeight / RAND_MAX );
        // printf("rand=%f\n", (GLfloat) rand() * screenWidth / RAND_MAX);
#endif
    }
    printf("i=%d\n", i);
    glEnd();
}

//<<<<<<<<<<<<<<<<<<<<<<<< myDisplay >>>>>>>>>>>>>>>>>
void myDisplay(void)
{
    glClear(GL_COLOR_BUFFER_BIT);     // clear the screen 

    glColor3f(0.0, 0.0, 0.0);
    // glTranslatef(49, 49, 0.0);
    randfloor(30000);

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
