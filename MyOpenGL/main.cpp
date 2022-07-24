/**************************
 * Includes
 *
 **************************/

#include <windows.h>
#include <gl/gl.h>
#include <math.h>
#include "class.hpp"


/**************************
 * Function Declarations
 *
 **************************/

LRESULT CALLBACK WndProc (HWND hWnd, UINT message,
WPARAM wParam, LPARAM lParam);
void EnableOpenGL (HWND hWnd, HDC *hDC, HGLRC *hRC);
void DisableOpenGL (HWND hWnd, HDC hDC, HGLRC hRC);


/**************************
 * WinMain
 *
 **************************/
float j=0.0,k=0.0;float alfa=0.0;
int WINAPI WinMain (HINSTANCE hInstance,
                    HINSTANCE hPrevInstance,
                    LPSTR lpCmdLine,
                    int iCmdShow)
{
    WNDCLASS wc;
    HWND hWnd;
    HDC hDC;
    HGLRC hRC;        
    MSG msg;
    BOOL bQuit = FALSE;
    float theta = 0.0f;
    

    /* register window class */
    wc.style = CS_OWNDC;
    wc.lpfnWndProc = WndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hInstance;
    wc.hIcon = LoadIcon (NULL, IDI_APPLICATION);
    wc.hCursor = LoadCursor (NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH) GetStockObject (BLACK_BRUSH);
    wc.lpszMenuName = NULL;
    wc.lpszClassName = "GLSample";
    RegisterClass (&wc);

    /* create main window */
    hWnd = CreateWindow (
      "GLSample", "OpenGL Sample", 
      WS_CAPTION | WS_POPUPWINDOW | WS_VISIBLE,
      0, 0, 556, 556,
      NULL, NULL, hInstance, NULL);
/////////////////////////

////////////////////////
    /* enable OpenGL for the window */
    EnableOpenGL (hWnd, &hDC, &hRC);
  
///////////////////////////////  
const int n=1000;

  Point3f A(0.5,0.5,0.5);
  Cube cub(&A,0.1f);
  Point3f c1(0.0,0.0,0.0);
  Point3f c2(-0.005,-0.005,-0.005);
  Point3f c3(0.005,-0.005,-0.005);
  Cube cubcc(&c1,0.05f),cubcc2(&c2,0.07f);

//Cube cub,cubcc,cubcc2;
//cub.Set(&A,0.1f);
//cubcc.Set(&c1,0.05f);
//cubcc2.Set(&c2,0.07f);

///////////////////////////////  

Point3f* p = new Point3f[n];

Cube* cu = new Cube[n];

float px,py,pz;

for(int i=0;i<=n-1;i++)
{
px=static_cast<float>(0.001*i);
py=px;
pz=px;

p[i].setCrd(px,py,pz);
cu[i].Set(&p[i],static_cast<float>(0.005*(rand() % 200)/100.0));    
}  

///////////////////////////////  

  
    /* program main loop */
    while (!bQuit)
    {
        /* check for messages */
        if (PeekMessage (&msg, NULL, 0, 0, PM_REMOVE))
        {
            /* handle or dispatch messages */
            if (msg.message == WM_QUIT)
            {
                bQuit = TRUE;
            }
            else
            {
                TranslateMessage (&msg);
                DispatchMessage (&msg);
            }
        }
        else
        {
            /* OpenGL animation code goes here */

            glClearColor (0.0f, 0.0f, 0.0f, 0.0f);
            glClear (GL_COLOR_BUFFER_BIT);

            glPushMatrix ();
            
          //    glRotatef (theta*0.005, 1.0f, 1.0f, 1.0f);
            glRotatef (alfa, 1.0f, 1.0f, 1.0f);
            glScalef( k*0.01, k*0.01, k*0.01);
           // glRotatef (50.0, 0.0f, 0.0f, 0.0f);
        

/*  
cub.draw();
cubcc.draw();
cubcc2.draw();




//cub.MoveTo(0.005f);
//cub.setRadius(sin((theta/100)/4.0)/4.0);
cub.setCenter(sin(theta/120)*0.7,cos(theta/120)*0.7,sin(theta/120)*0.7);
cub.CubeRot(0.1);
//cubcc.MoveTo(c3);
cubcc.setCenter(sin(-theta/100)*0.4,cos(-theta/100)*0.4,sin(-theta/100)*0.4);
cubcc.CubeRot(-0.15);
cubcc2.setCenter(sin(theta/70)*0.2,cos(theta/70)*0.2,sin(theta/70)*0.7);
cubcc2.CubeRot(0.05);


     */


//cub.draw();
//cub.setCenter(sin(theta/120)*0.7,cos(theta/120)*0.7,sin(theta/120)*0.7);

float cx,cy,cz;
    
for(int i=0;i<=n-1;i++)  
{
i++;
cx=sin(theta/(120.0+i*10))*(static_cast<float>(0.001*i));
cy=cos(theta/(120.0+i*10))*(static_cast<float>(0.001*i));
cz=cx;
i--;

if (i % 2) 
{cu[i].setCenter(cx,cy,cz);}
else {cu[i].setCenter(-cx,-cy,-cz);}        
//cu[i].setCenter((cx-k)*j,(cy-k)*j,(cz-k)*j);
//cu[i].setCenter(sin(theta/120)*0.7,cos(theta/120)*0.7,sin(theta/120)*0.7);
cu[i].CubeRot(0.01*(i+1));
cu[i].draw();
}   
     
     
            glEnd ();
            glPopMatrix ();

            SwapBuffers (hDC);

            theta +=j+10.0f;
            Sleep (1);
        }
    }


    /* shutdown OpenGL */
    DisableOpenGL (hWnd, hDC, hRC);

    /* destroy the window explicitly */
    DestroyWindow (hWnd);

    return msg.wParam;
}


/********************
 * Window Procedure
 *
 ********************/

LRESULT CALLBACK WndProc (HWND hWnd, UINT message,
                          WPARAM wParam, LPARAM lParam)
{
HDC hDC;
PAINTSTRUCT PaintStruct;
RECT Rect;      

    switch (message)
    {
    case WM_CREATE:
        return 0;
    case WM_CLOSE:
        PostQuitMessage (0);
        return 0;

//////////////
    case WM_LBUTTONDOWN:
         j+=5.0;
         return 0;
//////////////

//////////////
   case WM_RBUTTONDOWN:
         j-=5.0;
         return 0;
//////////////
   
//////////////
    case WM_DESTROY:
        return 0;

    case WM_KEYDOWN:
        switch (wParam)
        {
        case VK_ESCAPE:
            PostQuitMessage(0);
            return 0;
 ///////////////////////////////
        case VK_LEFT:
         alfa+=5.0;
         return 0;
        case VK_RIGHT:
         alfa-=5.0;
         return 0;
        case VK_UP:
         k+=5.0;
     /*   ///
        hDC=BeginPaint(hWnd,&PaintStruct);
         GetClientRect(hWnd,&Rect);
         DrawText(hDC,"shdfhkad",-1,&Rect,
                 DT_SINGLELINE | DT_UP | DT_VUP);
         EndPaint(hWnd, &PaintStruct);
         return 0;
        ///                                       */
         return 0;
        case VK_DOWN:
         k-=5.0;
         return 0;
        case VK_INSERT:
         j+=10.0;
         return 0;
        case VK_DELETE:
         j-=10.0;
         return 0;  
////////////////////////////////
        }
        return 0;

    default:
        return DefWindowProc (hWnd, message, wParam, lParam);
    }
}


/*******************
 * Enable OpenGL
 *
 *******************/

void EnableOpenGL (HWND hWnd, HDC *hDC, HGLRC *hRC)
{
    PIXELFORMATDESCRIPTOR pfd;
    int iFormat;

    /* get the device context (DC) */
    *hDC = GetDC (hWnd);

    /* set the pixel format for the DC */
    ZeroMemory (&pfd, sizeof (pfd));
    pfd.nSize = sizeof (pfd);
    pfd.nVersion = 1;
    pfd.dwFlags = PFD_DRAW_TO_WINDOW | 
      PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER;
    pfd.iPixelType = PFD_TYPE_RGBA;
    pfd.cColorBits = 24;
    pfd.cDepthBits = 16;
    pfd.iLayerType = PFD_MAIN_PLANE;
    iFormat = ChoosePixelFormat (*hDC, &pfd);
    SetPixelFormat (*hDC, iFormat, &pfd);

    /* create and enable the render context (RC) */
    *hRC = wglCreateContext( *hDC );
    wglMakeCurrent( *hDC, *hRC );

}


/******************
 * Disable OpenGL
 *
 ******************/

void DisableOpenGL (HWND hWnd, HDC hDC, HGLRC hRC)
{
    wglMakeCurrent (NULL, NULL);
    wglDeleteContext (hRC);
    ReleaseDC (hWnd, hDC);
}
