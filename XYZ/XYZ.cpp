

//#include "XYZ.hpp"
#include <windows.h>
#include <gl/gl.h>
#include <math.h>

float c1,c2,c3,c4,c5,c6,c7,c8;
const float pi=3.141592;

int sign(float x)
{
if (x<0) {return -1;}
return 1;
}

void cc(float u,float v)
{
c1=sign(u-pi);
c2=1;
c3=4*(1-cos(u)/2);
c4=max(-c1,0);
c5=max(c1,0);
c6=1;
c7=1;
c8=1;      
}


void setXYZmy(float x,float y,float z)
{glLineWidth(3.0);
glBegin (GL_LINES);
            glColor3f (0.0f, 0.0f, 0.0f);   glVertex3f (x, y, z);// oX
            glVertex3f (2.0, y, z);
            
            glColor3f (0.0f, 0.0f, 0.0f);   glVertex3f (x, y, z);//oY
            glVertex3f (x, 2.0, z);
            
            glColor3f (0.0f, 0.0f, 0.0f);   glVertex3f (x, y, z);//oZ
            glVertex3f (x, y, 2.0);
glEnd ();     glLineWidth( 0.2 );
}


/////-----------------------------------
float x_uv(float u,float v)
{ 
//cc(u,v);
//return cos(u)*cos(v);      
return 6*cos(u)*(1+sin(u))+c4*c3*cos(u)*cos(v)+c5*c3*cos(v+pi);      
      

}
/////-----------------------------------
float y_uv(float u,float v)
{

//return sin(v)*cos(u); 
//cc(u,v);     
return 16*sin(u)+c4*c3*sin(u)*cos(v);      

}
/////-----------------------------------
float z_uv(float u,float v)
{
//return sin(u);
cc(u,v);      
return c3*sin(v);
}
