/** Test.C **/

#include <GLUT/glut.h>
const float PI = 3.1415;
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

void drawLine() {
	float t;
	float x, y, z;
	float a=2,b=3,c=18;
	glColor3f(1.0,0.5,0.5);
	glBegin(GL_LINE_STRIP);
		for(t=0.0;t<=2*PI;t+=0.0002)
		{
			x=a*t*cos(c*t)+b;
			y=a*t*sin(c*t)+b;
			z=c*t;
			glVertex3f(x,y,z);
		}
	glEnd();

	glColor3f(1.0,1.0,0);
	glBegin(GL_LINE_STRIP);
		for(t=0.0;t<=2*PI;t+=0.0002)
		{
			x=(a*sin(c*t) + b) * cos(t);
			y=(a*sin(c*t) + b ) * sin(t);
			z=a * cos(c*t);
			glVertex3f(x,y,z);
		}
	glEnd();

	glColor3f(1.0,1.0,1.0);
	glBegin(GL_LINES);  //建立坐标轴
		glVertex3f(0,0,0);
		glVertex3f(12,0,0);
	glEnd();
	glBegin(GL_LINES);  //建立坐标轴
         glVertex3f(0,0,0);
		glVertex3f(0,0,12);
	glEnd();
	glBegin(GL_LINES);  //建立坐标轴
		glVertex3f(0,0,0);
		glVertex3f(0,12,0);
	glEnd();
}

void display()
{
	glClear(GL_COLOR_BUFFER_BIT);

	drawLine();

	glFlush();
}

void init()
{
	glClearColor(0.0,0.0,0.0,0.0);

	glColor3f(1.0,1.0,1.0);

	gluLookAt(
		1, 1, 1,   //更改视角
		3, 3, 3,
		-1,-1,1
	);

	glMatrixMode(GL_PROJECTION);  //设置投影模式
	glLoadIdentity();            //设置单位矩形
	glOrtho(-12.0,12.0,-12.0,12.0,-12,12);

}

