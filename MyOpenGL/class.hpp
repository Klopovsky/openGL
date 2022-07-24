

#ifndef _CLASS_HPP_
#define	_CLASS_HPP_


//const float  MatrRotate[3][3]={cos}

class Point3f
{
public: 
       
     Point3f(float X=0,float Y=0, float Z=0){setCrd(X,Y,Z);}
     ~Point3f(){}
     void setCrd(float X,float Y, float Z){x=X; y=Y; z=Z;}
     
     
     float x;
     float y;
     float z;

Point3f &  operator += (float value)
  {
    setCrd(x+value,y+value,z+value);
    return *this;
  }
Point3f &  operator += ( Point3f vec)
  {
    setCrd(x+vec.x,y+vec.y,z+vec.z);
    return *this;
  }   
  
  
Point3f &  operator * (float value)
  {
    setCrd(x*value,y*value,z*value);
    return *this;
  } 
  
Point3f &  operator -= (Point3f vec)
  {
    setCrd(x-vec.x,y-vec.y,z-vec.z);
    return *this;
  }     
//Point3f &  operator = (Point3f value)
//  {
//    setCrd(x=value.x,y=value.y,z=value.z);
//    return *this;
//  }   
  
};

class Cube
{
public:
  /*
       Cube(const Point3f* first,const Point3f* sec):// two points
        A1(first->x,first->y,first->z),
        A2(first->x,first->y,sec->z),  
        B1(sec->x,first->y,first->z),
        B2(sec->x,first->y,sec->z),
        C1(sec->x,sec->y,first->z),
        C2(sec->x,sec->y,sec->z),
        D1(first->x,sec->y,first->z),
        D2(first->x,sec->y,sec->z){}
  */      
       Cube(){_angle=0.0f;}
       Cube(const Point3f* centr, float rad)://point and radius 
        center(centr->x,centr->y,centr->z),
        
        A1(centr->x +rad,centr->y -rad,centr->z -rad),
        A2(centr->x +rad,centr->y -rad,centr->z +rad),  
        B1(centr->x -rad,centr->y -rad,centr->z -rad),
        B2(centr->x -rad,centr->y -rad,centr->z +rad),
        C1(centr->x -rad,centr->y +rad,centr->z -rad),
        C2(centr->x -rad,centr->y +rad,centr->z +rad),
        D1(centr->x +rad,centr->y +rad,centr->z -rad),
        D2(centr->x +rad,centr->y +rad,centr->z +rad) 
        {setRadius(rad);_angle=0.0f;setCenter(centr->x,centr->y,centr->z);}
         ~Cube(){}
      void Set(const Point3f* centr, float rad);
      void changeVertex();
      void setRadius(float rad);
      void setCenter(float xc, float yc, float zc);
    //  void VertexRot(float angle, Point3f &p);
      void CubeRot(float angl);
      void draw ();
    
     void MoveTo(Point3f* vec);
      void MoveTo(float vec);

       Point3f A1;
       Point3f A2;  
       Point3f B1;
       Point3f B2;
       Point3f C1;
       Point3f C2;
       Point3f D1;
       Point3f D2;    
       Point3f center;
private:
       float radius;
       float _angle;
       
                  
};


#endif //_CLASS_HPP_ 
