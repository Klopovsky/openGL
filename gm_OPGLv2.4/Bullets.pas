unit Bullets;

interface

uses SysUtils, Windows, Graphics,Math,OpenGL,ProthoUnit;

type
TBullet = class(TProthoUnit)                             //����� ����
 Private

 Public
    constructor Create(X,Y,X2,Y2:single);               //�������� ����

    procedure Move(); override;                         //������� ����
 end;

implementation

{Bullet}
constructor TBullet.Create(X,Y,X2,Y2:single);
var  center:TSingPoint;
begin
center.X:=X2;
center.Y:=Y2;
inherited Create(X,Y);
FIndex:=0;
FKolKadr:=1;
FSpeed:=0.08;
FSize:=0.02;
FLife:=171;
FColor:=15;
FPower:=207;
FAngle:=FindAngle(location,center);
FRefBmp:=@BulBmp;
end;


procedure TBullet.Move();
var newX,newY:single;
begin
if FDeath then exit;
newX:=Location.X + cos(angle)*FSpeed;
newY:=Location.Y - sin(angle)*FSpeed;
if (newX<=-1.0) or (newY<=-1.0) or (newX>=1.0) or (newY>=1.0)
then FDeath:=true
else SetLocation(newX,newY);
end;

end.
