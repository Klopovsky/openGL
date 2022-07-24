/**************************
 * Includes
 *
 **************************/

#include <windows.h>
#include <gl/gl.h>
#include <math.h>
#include "XYZ.hpp"

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
float t=1.0,j=1.0,k=0.0;float alfa=0.0;bool carcase=true,color=true,pause=false;
float steepx=0.1, steepy=0.1; int grad=1;
/////////////////////////////////////////

/////////////////////////////////////////
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
      0, 0, 756, 756,
      NULL, NULL, hInstance, NULL);

    /* enable OpenGL for the window */
    EnableOpenGL (hWnd, &hDC, &hRC);


/////////////////////ini

float ox=-1.0, oy=-1.0, oz=-1.0;
float UMin=0.000000,
UMax=6.280000,
VMin=0.000000,
VMax=6.280000;
/////////////////////
 
 
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

             glClearColor (1.0f, 1.0f, 1.0f, 0.0f);
            glClear (GL_COLOR_BUFFER_BIT);




            glPushMatrix ();
            
          
            glRotatef (alfa, 1.0f, 1.0f, 1.0f);
            glScalef( j*k*0.01, t*k*0.01, k*0.01);
            glTranslatef( (k)*0.01, (k)*0.01, (k)*0.01);
        
          
   //          setXYZmy(ox, oy, oz);
if (color)
{            
 
for(float u=UMin;u<=UMax;u+=steepx)
           {
      
           glBegin (GL_QUAD_STRIP);
             for(float v=VMin-steepx;v<=VMax;v+=steepy)
             {
                    glVertex3f (x_uv(u,v)+ox, y_uv(u,v) +oy, z_uv(u,v)  +oz);
                    
           u+=steepx;
        

              glVertex3f (x_uv(u,v)+ox, y_uv(u,v) +oy, z_uv(u,v)  +oz);
              
            glColor3f ((sin(v)), (sin(u)),(cos(v))); 
            u-=steepx; 
 
             }
             //u+=steepx;
             glEnd(); 
            
            
        }
 
}           
if (carcase)
{    glLineWidth(0.5);     
  glColor3f (0.0f, 0.0f, 0.0f);
           for(float u=UMin;u<=UMax;u+=steepx)
           {
             glBegin (GL_LINE_STRIP);
             for(float v=VMin;v<=VMax;v+=steepy)
             {
  
                  glVertex3f (x_uv(u,v)+ox, y_uv(u,v) +oy, z_uv(u,v)  +oz);
      ////
       u+=steepx;
        

              glVertex3f (x_uv(u,v)+ox, y_uv(u,v) +oy, z_uv(u,v)  +oz);
              u-=steepx;
      ////    
             }
             glEnd(); 
             if (pause)
             { 
             Sleep (100);
             SwapBuffers (hDC);   
             }  
           }
 if (pause) {pause=false;}
 
           
}

            
            glEnd ();
            glPopMatrix ();

            SwapBuffers (hDC);

            
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

    switch (message)
    {
    case WM_CREATE:
        return 0;
    case WM_CLOSE:
        PostQuitMessage (0);
        return 0;

    case WM_DESTROY:
        return 0;

    case WM_KEYDOWN:
        switch (wParam)
        {
        case VK_ESCAPE:
            PostQuitMessage(0);
            return 0;
             ///////////////////////////////
        case VK_SPACE:
         if(carcase){carcase=false;}else{carcase=true;};
         return 0;
        case VK_F9:
         if(color){color=false;}else{color=true;};
         return 0;
        case VK_F5:
         if(pause){pause=false;}else{pause=true;};
         return 0;
        case VK_LEFT:
         alfa+=5.0;
         return 0;
        case VK_RIGHT:
         alfa-=5.0;
         return 0;
        case VK_UP:
         k+=5.0;
         return 0;
        case VK_DOWN:
         k-=5.0;
         return 0;
         case VK_HOME:
         j+=5.0/k;
         return 0;
         case VK_END:
         j-=5.0/k;
         return 0;
          case VK_PRIOR:
         t+=5.0/k;
         return 0;
         case VK_NEXT:
         t-=5.0/k;
         return 0;
         case VK_F1:
         steepx+=0.1;
         return 0;
         case VK_F2:
         steepy+=0.1;
         return 0;
         case VK_F3:
         if(steepx > 0.2){steepx-=0.1;}
         return 0;
         case VK_F4:
         if(steepy > 0.2){steepy-=0.1;}
         return 0;
         case VK_F12:
         grad++;
         return 0;
         ///////////////////////////////////
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
