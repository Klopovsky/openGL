
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OpenGL, ExtCtrls, StdCtrls,math,Units,Effects, Menus,Bullets,ProthoUnit,Weapons,global;

type
  TfrmGL = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    Start1: TMenuItem;
    Close1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Close1Click(Sender: TObject);
    procedure Fire;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    DC : HDC;
    hrc: HGLRC;
    newCount, frameCount, lastCount : LongInt; // переменные дл€ счетчика кадров
    fpsRate : GLfloat; // кол-во кадров в сек.
  protected

  end;

var
  frmGL: TfrmGL;//  главна€ форма
  User: TUserUnit; //
   BulletsList,EnemysList,ExplosList: TList;
  quantKill,quTact:integer;
  BackGr : Array [0..511, 0..511, 0..2] of GLubyte;
  shiftCoordMouseX,shiftCoordMouseY:integer;
implementation

{$R *.DFM}



{=======================================================================


{=======================================================================
‘ормат пиксел€}
procedure SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);
end;

{=======================================================================
—оздание формы}
procedure TfrmGL.FormCreate(Sender: TObject);
begin
 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnable(GL_BLEND);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
 wglUseFontBitmaps (Canvas.Handle, 0, 255, 100);

 lastCount := GetTickCount;
 frameCount := 0;
 globalFrameCount:=0;
 randomize;


end;

{=======================================================================
 онец работы приложени€}
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
 wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);
end;

procedure TfrmGL.Timer1Timer(Sender: TObject);
var i,j:integer;BufBul,Bul:TBullet;BufEnem:TEnemy; Expls:Explos; s:string;
begin
glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA,
                 512, 512,
                 0, GL_RGB, GL_UNSIGNED_BYTE, @BackGr);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEnable(GL_TEXTURE_2D);

glColor3f (1.0, 1.0, 1.0);

glBegin (GL_QUADS);
   glTexCoord2d (0.0, 1.0);
   glVertex2f (-1.0,-1.0);
   glTexCoord2d (1.0, 1.0);
   glVertex2f (-1.0, 1.0);
   glTexCoord2d (1.0, 0.0);
   glVertex2f (1.0, 1.0);
   glTexCoord2d (0.0, 0.0);
   glVertex2f (1.0, -1.0);
 glEnd;
glDisable(GL_TEXTURE_2D);
 s:='Heal-->'+inttostr(user.GetLife);
 glRasterPos2f (0.65,0.95);
 OutText (PChar(s));

 s:='Kill monsters-->'+inttostr(quantKill);
 glRasterPos2f (0.55,0.9);
 OutText (PChar(s));

 s:='Ammo--> '+inttostr(user.FWeapon.Magazine-user.FWeapon.CountShot);
 glRasterPos2f (-0.95,0.95);
 OutText (PChar(s));

 // определ€ем и выводим количество кадров в секунду
 newCount := GetTickCount;
 Inc(globalFrameCount);                        //глобальный счетчик
 Inc(frameCount);
 If (newCount - lastCount) > 1000 then  begin // прошла секунда
    fpsRate := frameCount * 1000 / (newCount - lastCount);
    Caption := 'FPS - ' + FloatToStr (fpsRate);
    frmGL.Caption:=  frmGL.Caption+'    '+ floattostr(radToDeg(User.Angle));
    lastCount := newCount;
    frameCount := 0;
 end;
//---------------------------------------------------------------


if HiWord(GetKeyState(VK_RIGHT)) <> 0  then
  begin
User.Move('r');
  end;
if HiWord(GetKeyState(VK_DOWN)) <> 0 then
  begin
User.Move ('d');
  end;
if HiWord(GetKeyState(VK_UP)) <> 0 then
  begin
User.Move ('u');
  end;
if HiWord(GetKeyState(VK_LEFT)) <> 0 then
  begin
User.Move ('l');
  end;
if HiWord(GetKeyState(VK_LBUTTON)) <> 0 then
  begin
Fire;
  end;
User.Draw();
user.FWeapon.IsEmptyGun ;
/////////////////////////////////////////
for i:=0 to BulletsList.Count-1 do
  begin
    BufBul:=BulletsList.Items[i];
    
    if not(BufBul.IsDeath()) then
      begin

        BufBul.Move;
        if not(BufBul.IsDeath) then BufBul.Draw();
      end;
  end ;
//////////////////////////////////////////

i:=0;
if BulletsList<>nil then
while i<=(BulletsList.Count-1) do
  begin
    BufBul:=BulletsList.Items[i];
    if BufBul.IsDeath
    then
      begin
        BufBul.Free;
        BulletsList.Delete(i);
      end;
    i:=i+1;
    end;
BulletsList.Pack;
if EnemysList.Count>0 then
begin
i:=0;
if EnemysList<>nil then
while i<=(EnemysList.Count-1) do
  begin
    BufEnem:=EnemysList.Items[i];
    if BufEnem.IsDeath
    then
      begin
        expls:=Death.Create(BufEnem.Location.X, BufEnem.Location.Y,BufEnem.Angle);
        Expls.Draw;
        ExplosList.Add(Expls);
        EnemysList.Delete(i);
        quantKill:=quantKill+1;

        BufEnem.Free;
      end;

    i:=i+1;
   end;
EnemysList.Pack;
end;
//////////////////////////////////////////////
if User.IsDeath then
       Timer1.Enabled:=false;
if EnemysList.Count< 1000 then
i:=random(30-26*round(sin(quTact/1000)))
else i:=5;
case i of
0:BufEnem:=TEnemy.Create(-1.0,(random(200)-100)/100);
1:BufEnem:=TEnemy.Create((random(200)-100)/100,-1.0);
2:BufEnem:=TEnemy.Create(1.0,(random(200)-100)/100);
3:BufEnem:=TEnemy.Create((random(200)-100)/100,1.0);
else BufEnem:=nil;
end;
if i<4 then EnemysList.Add(BufEnem);

for i:=0 to EnemysList.Count-1 do
  begin
    BufEnem:=EnemysList.Items[i];

    if not(BufEnem.IsDeath()) then
    for j:=0 to BulletsList.Count-1 do
      begin
        bul:=BulletsList.Items[j];
        if (not(bul.IsDeath))
          and
           (abs(bul.Location.X-BufEnem.Location.X)<BufEnem.Size)  //
          and                                                     //  HIT!!
           (abs(bul.Location.Y-BufEnem.Location.Y)<BufEnem.Size)  //
        then
          begin
            Bul.LifeDown(BufEnem.Power);
            Expls:=Explos.Create(bul.Location.X,bul.Location.Y,bul.GetAngle);
            ExplosList.Add(Expls);
            BufEnem.LifeDown(Bul.Power);
          end;
      end;
    if not(BufEnem.IsDeath()) then
      begin
        if BufEnem.IsEat then User.LifeDown(BufEnem.GetPower);
        BufEnem.Move(User.Location);
        if not(BufEnem.IsDeath) then BufEnem.Draw();

      end;
   end;


i:=0;
if ExplosList<>nil then
begin
  while i<=(ExplosList.Count-1) do
    begin
      Expls:=ExplosList.Items[i];
      if Expls.IsDeath
      then
        begin
          Expls.Free;
          ExplosList.Delete(i);
          i:=i-1;
        end
      else
        Expls.Draw();
      i:=i+1;
     end;
  ExplosList.Pack;
end;
quTact:=quTact+1;

  SwapBuffers(DC);

end;

procedure TfrmGL.Start1Click(Sender: TObject);
var i,j:integer; Bitmap:TBitmap;
begin
canvas.Font.Color:=clPurple;
canvas.Font.Size:= 18;
canvas.TextOut((ClientWidth div 2)-50, ClientHeight div 2,'Loading.');
Sleep(500);
bitmap := TBitmap.Create;
bitmap.LoadFromFile('BackGround.bmp');
canvas.TextOut((ClientWidth div 2)-50, ClientHeight div 2,'Loading..');
    For i := 0 to 511 do
      For j := 0 to 511 do begin
        BackGr [i, j, 0] := GetRValue(bitmap.Canvas.Pixels[i,j]);
        BackGr [i, j, 1] := GetGValue(bitmap.Canvas.Pixels[i,j]);
        BackGr [i, j, 2] := GetBValue(bitmap.Canvas.Pixels[i,j]);
                           end;
canvas.TextOut((ClientWidth div 2)-50, ClientHeight div 2,'Loading...');
Bitmap.Free;
User:=TUserUnit.Create(0.0,0.0);
canvas.TextOut((ClientWidth div 2)-50, ClientHeight div 2,'Loading....');

quantKill:=0;
BulletsList:=TList.Create;
EnemysList:=TList.Create;
ExplosList:=TList.Create;
KeyPreview:=true;

quTact:=0;
Screen.Cursors[1]:=LoadCursorFromFile('cursor/1.cur');
Screen.Cursors[2]:=LoadCursorFromFile('cursor/2.cur');
Cursor:=1;
//Cursor:=crCross;
Timer1.Enabled:=true;
end;



procedure TfrmGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var p:TSingPoint;
begin
if User=nil then exit;
p.X := 2 * X / ClientWidth - 1;
p.Y := 2 * (ClientHeight - Y) / ClientHeight - 1;
User.Angle:=FindAngle(User.Location,p);

end;

procedure TfrmGL.Close1Click(Sender: TObject);
begin
glDeleteLists (100, 256);
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC (DC);
  EnemysList.Free;
  BulletsList.Free;
  ExplosList.Free;
  User.Free;
  Close;

end;

procedure TfrmGL.Fire;
var pB:TPoint;target:TSingPoint; arrayBullets : TArrBul;
i:integer;
begin
GetCursorPos(pB);
if User=nil then exit;
  target.X := 2 * (pb.X-shiftCoordMouseX) / ClientWidth - 1;
  target.Y := 2 * (ClientHeight - (pb.Y-shiftCoordMouseY)) / ClientHeight - 1;
  for i:=0 to User.Firing(target,arrayBullets)-1 do
  BulletsList.Add(arrayBullets[i]);
end;

procedure TfrmGL.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p:TPoint;
begin
GetCursorPos(p);
shiftCoordMouseX:=p.X-X;
shiftCoordMouseY:=p.Y-Y;
end;

end.

