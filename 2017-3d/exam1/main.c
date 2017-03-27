/** Test.C **/

#include <GLUT/glut.h>

void display();
void init();

int main(int argc, char ** argv)
{
	glutInit(&argc, argv);

	glutCreateWindow("Simple");

	glutDisplayFunc(display);

	init();

	glutMainLoop();
}

void display()
{  
	glClear(GL_COLOR_BUFFER_BIT);

	glBegin(GL_POLYGON);
	glVertex2f(-0.5, -0.5);
	glVertex2f(-0.5, 0.5);
	glVertex2f(0.5, 0.5);
	glVertex2f(0.5, -0.5);
	glEnd();

	glFlush();
}

void init()
{
  glClearColor(0.0,0.0,0.0,0.0);
}

