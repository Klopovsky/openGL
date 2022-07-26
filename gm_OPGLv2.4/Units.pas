unit Units;

interface

uses SysUtils, Windows, Graphics,Math,OpenGL,Weapons,Bullets,ProthoUnit;





type

 TUserUnit = class(TProthoUnit)                  //����� �������� �����
 Public
    FWeapon : TWeapons;                             //��� ������
 
    constructor Create(X,Y:single);            //��������
    procedure Move(c:char);reintroduce;        //��������
    function Firing(target:TSingPoint; var arrBul:TArrBul):byte;       //��������


 end;


 TEnemy = class(TProthoUnit)                              //����� ����
 Private
    FUnic:single;                                       //������������ ���������
    FEat:boolean;                                       //������� �����
 Public
    constructor Create(X,Y:single);                     //�������� �����
    function IsEat():boolean;                           //�������� �� ����������� ��� �����
    procedure Move(const center:TSingPoint);reintroduce;    //�������� �����
 end;







                     //������ ���������� �� ������
implementation






{UserUnit}
constructor TUserUnit.Create(X,Y:single);
begin
inherited Create(X,Y);
FIndex:=0;
FKolKadr:=1;
FSpeed:=0.01;
FSize:=0.07;
FLife:=100000000;
FWeapon:=TPistol.Create();
FColor:=$00aa5555;
FAngle:=0.0;
InitBmp(1,1);
InitBmp(2,32);
InitBmp(3,1);
InitBmp(4,4);
InitBmp(5,16);
FRefBmp:=@UserBmp;
end;

function TUserUnit.Firing(target:TSingPoint; var arrBul:TArrBul):byte;
begin

result:=FWeapon.Shoot(Location,target,arrBul);
end;



procedure TUserUnit.Move(c:char);
begin

if c='r' then  SetLocation(Location.X+FSpeed,Location.Y);
if c='d' then  SetLocation(Location.X,Location.Y-FSpeed);
if c='u' then  SetLocation(Location.X,Location.Y+FSpeed);
if c='l' then  SetLocation(Location.X-FSpeed,Location.Y);


end;



{Enemy}
constructor TEnemy.Create(X,Y:single);
begin
inherited Create(X,Y);
FIndex:=0;
FUnic:=randg(0.5,0.1)/16;
FKolKadr:=32;
FSpeed:=0.005+random/500;
FSize:=0.06;
FPower:=1;
FLife:=19;
FEat:=false;
FColor:=$0055FF55;
FAngle:=0.0;
FRefBmp:=@EnemyBmp;
end;

Function TEnemy.IsEat():boolean;
begin
result:=FEat;
end;

procedure TEnemy.Move(const center:TSingPoint);
var newX,newY:extended; newAngle:single;
begin
if FDeath then exit;
newAngle:=FindAngle(Location,center);
if (abs(newAngle-Angle)<0.05)or(abs(newAngle-Angle)>6.2) then Angle:=newAngle+FUnic else Angle:=Angle+FUnic;
if (abs(Location.X-center.X)<Size+0.04)
    and
   (abs(Location.Y-center.Y)<Size+0.04)
  then FEat:=true
  else  FEat:=False;

SinCos(angle,newY,newX);
newX:=Location.X + newX*FSpeed;
newY:=Location.Y - newY*FSpeed;
SetLocation(newX,newY);


end;



end.
