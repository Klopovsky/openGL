

#include <gl/gl.h>
#include <math.h>
#include "class.hpp"



void PointRot(float angle, Point3f &p)
{
     float x,y;
x=p.x;
y=p.y;     
p.x= x*cos(angle)-y*sin(angle);
p.y= x*sin(angle)+y*cos(angle);   


}


 void Cube::draw()
{
      /////////////// A1_B1_C1_D1
            glBegin (GL_QUADS);
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (A1.x,A1.y,A1.z);
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (B1.x,B1.y,B1.z);
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (C1.x,C1.y,C1.z); 
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (D1.x,D1.y,D1.z);        
          //A2_B2_C2_D2          
           glBegin (GL_QUADS);
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (A2.x,A2.y,A2.z);
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (B2.x,B2.y,B2.z);
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (C2.x,C2.y,C2.z); 
            glColor3f (1.0f, 0.0f, 0.0f);   glVertex3f (D2.x,D2.y,D2.z); 
         //////////////// D2_C2_C1_D1 
           glBegin (GL_QUADS);
            glColor3f (0.0f, 0.0f, 1.0f);   glVertex3f (D2.x,D2.y,D2.z);
            glColor3f (0.0f, 0.0f, 1.0f);   glVertex3f (C2.x,C2.y,C2.z);
            glColor3f (0.0f, 0.0f, 1.0f);   glVertex3f (C1.x,C1.y,C1.z); 
            glColor3f (0.0f, 0.0f, 1.0f);   glVertex3f (D1.x,D1.y,D1.z);
          //A2_B2_B1_A1 
           glBegin (GL_QUADS);
            glColor3f (1.0f, 0.0f, 1.0f);   glVertex3f (A2.x,A2.y,A2.z);
            glColor3f (1.0f, 0.0f, 1.0f);   glVertex3f (B2.x,B2.y,B2.z);
            glColor3f (1.0f, 0.0f, 1.0f);   glVertex3f (B1.x,B1.y,B1.z); 
            glColor3f (1.0f, 0.0f, 1.0f);   glVertex3f (A1.x,A1.y,A1.z);
         ///////////////A2_D2_D1_A1  
           
           glBegin (GL_QUADS);
            glColor3f (1.0f, 1.0f, 0.0f);   glVertex3f (A2.x,A2.y,A2.z);
            glColor3f (1.0f, 1.0f, 0.0f);   glVertex3f (D2.x,D2.y,D2.z);
            glColor3f (1.0f, 1.0f, 0.0f);   glVertex3f (D1.x,D1.y,D1.z); 
            glColor3f (1.0f, 1.0f, 0.0f);   glVertex3f (A1.x,A1.y,A1.z);
         //B2_C2_C1_B1  
           glBegin (GL_QUADS);
            glColor3f (0.0f, 1.0f, 1.0f);   glVertex3f (B2.x,B2.y,B2.z);
            glColor3f (0.0f, 1.0f, 1.0f);   glVertex3f (C2.x,C2.y,C2.z);
            glColor3f (0.0f, 1.0f, 1.0f);   glVertex3f (C1.x,C1.y,C1.z); 
            glColor3f (0.0f, 1.0f, 1.0f);   glVertex3f (B1.x,B1.y,B1.z);
}

void Cube::changeVertex()
{
    
    
     
A1.x=center.x +radius; A1.y=center.y -radius; A1.z=center.z -radius;
A2.x=center.x +radius; A2.y=center.y -radius; A2.z=center.z +radius;  
B1.x=center.x -radius; B1.y=center.y -radius; B1.z=center.z -radius;
B2.x=center.x -radius; B2.y=center.y -radius; B2.z=center.z +radius;
C1.x=center.x -radius; C1.y=center.y +radius; C1.z=center.z -radius;
C2.x=center.x -radius; C2.y=center.y +radius; C2.z=center.z +radius;
D1.x=center.x +radius; D1.y=center.y +radius; D1.z=center.z -radius;
D2.x=center.x +radius; D2.y=center.y +radius; D2.z=center.z +radius;     
/*    PointRot(_angle,A1); 
    PointRot(_angle,A2);
    PointRot(_angle,B1);
    PointRot(_angle,B2);
    PointRot(_angle,C1);
    PointRot(_angle,C2);
    PointRot(_angle,D1);
    PointRot(_angle,D2);        */
}

void Cube::Set(const Point3f* centr, float rad=0)
{
        setCenter(centr->x,centr->y,centr->z);
        A1.setCrd(centr->x +rad,centr->y -rad,centr->z -rad);
        A2.setCrd(centr->x +rad,centr->y -rad,centr->z +rad);  
        B1.setCrd(centr->x -rad,centr->y -rad,centr->z -rad);
        B2.setCrd(centr->x -rad,centr->y -rad,centr->z +rad);
        C1.setCrd(centr->x -rad,centr->y +rad,centr->z -rad);
        C2.setCrd(centr->x -rad,centr->y +rad,centr->z +rad);
        D1.setCrd(centr->x +rad,centr->y +rad,centr->z -rad);
        D2.setCrd(centr->x +rad,centr->y +rad,centr->z +rad); 
        setRadius(rad);
        _angle=0.0f;
             
}

void Cube::setRadius(float rad)
{
if (rad < 0) {rad *=-1.0f;}
radius=rad;
//changeVertex();        
//CubeRot(_angle);                            
}

void Cube::setCenter(float xc, float yc, float zc)
{
   
Point3f vec(xc-center.x,yc-center.y,zc-center.z);
A1+=vec;  
A2+=vec; 
B1+=vec; 
B2+=vec; 
C1+=vec; 
C2+=vec; 
D1+=vec; 
D2+=vec;              
center.x=xc; center.y=yc; center.z = zc;
    
}

void Cube::MoveTo(Point3f* vec)
{
setCenter(vec->x,vec->y,vec->z);
}

void Cube::MoveTo(float vec)
{
A1+=vec;  
A2+=vec; 
B1+=vec; 
B2+=vec; 
C1+=vec; 
C2+=vec; 
D1+=vec; 
D2+=vec;     
center+=vec;  
}



void Cube::CubeRot(float angle)
{
A1-=center;  
A2-=center; 
B1-=center; 
B2-=center; 
C1-=center; 
C2-=center; 
D1-=center; 
D2-=center;   
 _angle+=angle; 
    PointRot(angle,A1); 
    PointRot(angle,A2);
    PointRot(angle,B1);
    PointRot(angle,B2);
    PointRot(angle,C1);
    PointRot(angle,C2);
    PointRot(angle,D1);
    PointRot(angle,D2);
A1+=center;  
A2+=center; 
B1+=center; 
B2+=center; 
C1+=center; 
C2+=center; 
D1+=center; 
D2+=center;
}
