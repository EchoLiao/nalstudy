// SphereWorld.cpp
// OpenGL SuperBible
// Demonstrates an immersive 3D environment using actors
// and a camera.
// Program by Richard S. Wright Jr.

#include "../../shared/gltools.h"	// OpenGL toolkit
#include "../../shared/glframe.h"   // Frame Class
#include <math.h>
#include <stdlib.h>
#include <stdio.h>


#define NUM_SPHERES      50
GLFrame    spheres[NUM_SPHERES];
GLFrame    frameCamera;

//////////////////////////////////////////////////////////////////
// This function does any needed initialization on the rendering
// context.
void SetupRC()
{
    int iSphere;

    // Bluish background
    glClearColor(0.0f, 0.0f, .50f, 1.0f );

    // Draw everything as wire frame
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

    // Randomly place the sphere inhabitants
    for(iSphere = 0; iSphere < NUM_SPHERES; iSphere++)
    {
        // Pick a random location between -20 and 20 at .1 increments
        float x = ((float)((rand() % 400) - 200) * 0.1f);
        float z = (float)((rand() % 400) - 200) * 0.1f;
        spheres[iSphere].SetOrigin(x, 0.0f, z);
    }
}


///////////////////////////////////////////////////////////
// Draw a gridded ground
void DrawGround(void)
{
    GLfloat fExtent = 20.0f;
    GLfloat fStep = 1.0f;
    GLfloat y = -0.4f;
    GLfloat iLine;

    glBegin(GL_LINES);
    for(iLine = -fExtent; iLine <= fExtent; iLine += fStep)
    {
        glVertex3f(iLine, y, fExtent);    // Draw Z lines
        glVertex3f(iLine, y, -fExtent);

        glVertex3f(fExtent, y, iLine);
        glVertex3f(-fExtent, y, iLine);
    }

    glEnd();
}


// Called to draw scene
void RenderScene(void)
{
    int i;
    static GLfloat yRot = 0.0f;         // Rotation angle for animation
    yRot += 0.5f;

    // Clear the window with current clearing color
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // 把当前模型视图矩阵压栈, 以免被 frameCamera.ApplyCameraTransform 所污染.
    glPushMatrix(); {
        frameCamera.ApplyCameraTransform();

        // Draw the ground
        DrawGround();

        // Draw the randomly located spheres
        for(i = 0; i < NUM_SPHERES; i++)
        {
            glPushMatrix(); {
                spheres[i].ApplyActorTransform();
                glutSolidSphere(0.1f, 13, 26);
            } glPopMatrix();
        }

        glPushMatrix(); {
            glTranslatef(0.0f, 0.0f, -2.5f);

            glPushMatrix(); {
                glRotatef(-yRot * 2.0f, 0.0f, 1.0f, 0.0f);
                glTranslatef(1.0f, 0.0f, 0.0f);
                glutSolidSphere(0.1f, 13, 26);
            } glPopMatrix();

            glRotatef(yRot, 0.0f, 1.0f, 0.0f);
            gltDrawTorus(0.35, 0.15, 40, 20);
        } glPopMatrix();
    } glPopMatrix();

    // Do the buffer Swap
    glutSwapBuffers();
}



// Respond to arrow keys by moving the camera frame of reference
void SpecialKeys(int key, int x, int y)
{
    if(key == GLUT_KEY_UP)
        frameCamera.MoveForward(0.1f);

    if(key == GLUT_KEY_DOWN)
        frameCamera.MoveForward(-0.1f);

    if(key == GLUT_KEY_LEFT)
        frameCamera.RotateLocalY(0.1f);

    if(key == GLUT_KEY_RIGHT)
        frameCamera.RotateLocalY(-0.1f);

    // Refresh the Window
    glutPostRedisplay();
}


///////////////////////////////////////////////////////////
// Called by GLUT library when idle (window not being
// resized or moved)
void TimerFunction(int value)
{
    // Redraw the scene with new coordinates
    glutPostRedisplay();

    // 每33毫秒刷新一次
    glutTimerFunc(33,TimerFunction, 1);
    //printf("NAL ...\n");
}

void ChangeSize(int w, int h)
{
    GLfloat fAspect;

    // Prevent a divide by zero, when window is too short
    // (you cant make a window of zero width).
    if(h == 0)
        h = 1;

    glViewport(0, 0, w, h);

    fAspect = (GLfloat)w / (GLfloat)h;

    // Reset the coordinate system before modifying
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    // Set the clipping volume
    float theta = 63.0f;
    float n = 1.0f;
    float f = 50.0f;
#if 0
    gluPerspective(theta, fAspect, n, f);
#else
    // [(<<G:2>> P26)]
    const float PI = 3.1415926f;
    float xwmax, xwmin, ywmax, ywmin;
    float theta_div2 = (theta/2.0f) * (PI/180.0f);
    float tan_theta_div2 = tan(theta_div2);

    xwmax = -(-n) * (tan_theta_div2) * fAspect;
    ywmax = -(-n) * (tan_theta_div2);
    xwmin = -xwmax;
    ywmin = -ywmax;

    printf("NAL xwmax=%f xwmin=%f ywmax=%f ywmin=%f\n",
            xwmax, xwmin, ywmax, ywmin);
    printf("NAL fAspect=%f, (xwmax-xwmin)/(ywmax-ywmin)=%f\n",
            fAspect, (xwmax-xwmin)/(ywmax-ywmin));

    glFrustum(xwmin, xwmax, ywmin, ywmax, n, f);
#endif

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

int main(int argc, char* argv[])
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(800,600);
    glutCreateWindow("OpenGL SphereWorld Demo");
    glutReshapeFunc(ChangeSize);
    glutDisplayFunc(RenderScene);
    glutSpecialFunc(SpecialKeys);

    SetupRC();
    glutTimerFunc(33, TimerFunction, 1);

    glutMainLoop();

    return 0;
}
