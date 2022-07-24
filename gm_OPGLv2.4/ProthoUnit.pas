unit ProthoUnit;

interface

uses SysUtils, Windows, Graphics,Math,OpenGL,global;

type
 TSingPoint = record  //��� "�����"
   X : single;
   Y : single;
 end;

type TBmp = Array [0..63, 0..63, 0..3] of GLubyte;       //��� ������ �������� � ������
type TArrBmp= array of TBmp;

 TSprite = class         //����� �������
 Protected
    FKolKadr:byte;      //���-�� ������ �������
    FIndex : byte;      //����� ����� ��� ����������
    FDeath : boolean;   //��������� ������
    FLocation: TSingPoint;  //�������������� ������� (X,Y)
    FSize : single;     //���������� ������ �������
    FColor : integer;   //���� ��� ������� ������������
    FAngle : single;    //���������� �����
    FTackt : longint;
    FRefBmp: ^TArrBmp;
 Public
    constructor Create (X,Y,ang:single);            //�������� �������
    procedure InitBmp(porNom,kKadr:byte);           //�������� ������� � ������
    function GetKolKadr():byte;                     //���������-�� ������ �������
    function GetIndex():byte;                       //�������� ������
    Procedure SetIndex(ind:byte);virtual;           //���������� ������
    function GetLocation():TSingPoint;              //�������� ���������� �������
    procedure SetLocation(X,Y:Single);              //���������� ����-�� �������
    function GetSize():Single;                      //�������� ������ �������
    procedure SetSize(s:Single);                    //���������� ����� �������
    function GetColor():Tcolor;                     //������ ����
    procedure SetColor(color:TColor);               //���������� ����
    function GetAngle():single;                     //������ �����������
    procedure SetAngle(Ang:single);                 //�������� �����������
    procedure Draw();virtual;                       //���������� �������
    function IsDeath():boolean;                     //�������� ������
    property IndexUnit: byte read GetIndex write SetIndex; //��-�� ������
    property KolKadr:byte read GetKolKadr;                 //��-�� ���-�� ������
    property Location: TSingPoint read GetLocation;        //��-�� ��������������
    property Size:Single read GetSize write SetSize;       //��-�� �����
    property Color:TColor read GetColor write SetColor;    //��-�� ����
    property Angle:single read GetAngle write SetAngle;    //��-�� �����������
 end;

 TProthoUnit = class(TSprite)     //�������� ������������ ����� ������
  Protected
    FSpeed : single;    //�������� ����������� �������
    FLife : integer;    //���-�� ����� �����
    FPower : Byte;      //���� �����
  Public
    constructor Create (X,Y:single);            //�������� �������
    procedure Move();virtual;abstract;          //�������� �������
    Function GetLife():integer;                 //�������� ���-�� �����
    procedure SetLife(heal:integer);            //���������� ���-�� �����
    Function GetPower():byte;                   //�������� ���-�� ����
    procedure LifeDown(DMG: integer);           //�����
    property Life:integer read GetLife write SetLife;      //��-�� �����
    property Power:byte read GetPower;                     //��-�� ����
 end;


function FindAngle(const Center, P: TSingPoint): single;    //���������� ���� ������

var EnemyBmp,BulBmp,UserBmp,EffectBmp,DeathBmp: TArrBmp;

implementation

{Sprite}
constructor TSprite.Create(X,Y,ang:single);   //���������� ������������
begin
inherited Create;
FTackt:=globalFrameCount;
FLocation.X:=X;
FLocation.Y:=Y;
FAngle:=ang;
FDeath:=false;
end;

function TSprite.GetKolKadr():byte;
begin
Result:=FKolKadr;
end;

function TSprite.GetIndex():byte;
begin
result:=FIndex;
end;

procedure TSprite.SetIndex(ind:byte);
begin
FIndex:=ind;
end;

function TSprite.GetAngle():single;
begin
Result:=FAngle;
end;

procedure TSprite.SetAngle(ang:single);
begin
FAngle:=ang;
end;

function TSprite.GetLocation():TSingPoint;
begin
result.X:=FLocation.X;
result.Y:=FLocation.Y;
end;

procedure TSprite.SetLocation(X,Y:Single);
begin
if (X>-1.0)and(X<1.0) then
 FLocation.X:=X;
if (Y>-1.0)and(Y<1.0) then
FLocation.Y:=Y;
IndexUnit:=IndexUnit+1;

end;

function TSprite.GetSize():Single;
begin
Result:=FSize;
end;

procedure TSprite.SetSize(s:Single);
begin
FSize:=s;

end;

function TSprite.GetColor():TColor;
begin
result:=FColor;
end;

procedure TSprite.SetColor(color:TColor);
begin
FColor:=color;
end;

function TSprite.IsDeath():boolean;
begin
if FDeath then result:=true
else Result:=false;
end;

procedure TSprite.Draw();
var k:byte;
begin
     k:=IndexUnit;

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA,
                 64, 64,
                 0, GL_RGBA, GL_UNSIGNED_BYTE, @FRefBmp^[k mod kolKadr]);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEnable(GL_TEXTURE_2D);

glPushMatrix;
glTranslatef(Location.X,Location.Y,0.0);
glRotatef(180-Angle*180/pi,0.0,0.0,1.0);
glColor4f (1.0, 1.0, 1.0,1.0);

glBegin (GL_QUADS);
   glTexCoord2d (0.0, 1.0);
   glVertex2f (-FSize,-FSize);
   glTexCoord2d (1.0, 1.0);
   glVertex2f (-FSize, +FSize);
   glTexCoord2d (1.0, 0.0);
   glVertex2f (FSize, FSize);
   glTexCoord2d (0.0, 0.0);
   glVertex2f (FSize, -FSize);
 glEnd;


glPopMatrix;
glDisable(GL_TEXTURE_2D);

end;

procedure TSprite.InitBmp(porNom,kKadr:byte);
var i,j,k:integer;Bitmap:Tbitmap;bufBmp:array of TBmp;
begin
 bitmap := TBitmap.Create;
 SetLength(bufBmp,kKadr);
 for k:=0 to kKadr-1 do
 BEGIN
   bitmap.LoadFromFile('img/'+inttostr(porNom)+'/'+inttostr(k)+'.bmp');
    For i := 0 to 63 do
      For j := 0 to 63 do begin
        bufBmp[k] [i, j, 0] := GetRValue(bitmap.Canvas.Pixels[i,j]);
        bufBmp[k] [i, j, 1] := GetGValue(bitmap.Canvas.Pixels[i,j]);
        bufBmp[k] [i, j, 2] := GetBValue(bitmap.Canvas.Pixels[i,j]);
        if   (  (bufBmp[k][i,j,0]<=10)
            and(bufBmp[k][i,j,1]<=10)
            and(bufBmp[k][i,j,2]<=10) )
        then bufBmp[k] [i, j, 3] := 0
        else bufBmp[k] [i, j, 3] := 255;
    end;
    Bitmap.FreeImage;
  END;
case porNom of
1:begin
   SetLength(UserBmp,kKadr);
   for k:=0 to kKadr-1 do
   UserBmp[k]:=bufBmp[k];
  end;
2:begin
   SetLength(EnemyBmp,kKadr);
   for k:=0 to kKadr-1 do
   EnemyBmp[k]:=bufBmp[k];
  end;
3:begin
   SetLength(BulBmp,kKadr);
   for k:=0 to kKadr-1 do
   BulBmp[k]:=bufBmp[k];
  end;
4:begin
   SetLength(EffectBmp,kKadr);
   for k:=0 to kKadr-1 do
   EffectBmp[k]:=bufBmp[k];
  end;
5:begin
   SetLength(DeathBmp,kKadr);
   for k:=0 to kKadr-1 do
   DeathBmp[k]:=bufBmp[k];
  end;
end;
Bitmap.Free;
end;


{ProthoUnit}

constructor TProthoUnit.Create(X,Y:single);
begin
inherited Create(X,Y,0.0);
end;

Function TProthoUnit.GetLife():integer;
begin
result:=FLife;
end;

procedure TProthoUnit.SetLife(heal:integer);
begin
if heal<0 then heal:=0;
FLife:=heal;
end;

procedure TProthoUnit.LifeDown(DMG:integer);
begin
if DMG<1 then Exit;
Life:=Life-DMG;
if (Life<1) then FDeath:=true
else ;
end;

function TProthoUnit.GetPower():byte;
begin
result:=FPower;
end;

{another function}
function FindAngle(const Center, P: TSingPoint): single;
begin
  result:= arcTan2(Center.y - P.y, P.x - Center.x);
end;


end.
