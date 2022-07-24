unit weapons;

interface

uses SysUtils, Windows, Graphics,Math,OpenGL,Bullets,ProthoUnit,global;

type TArrBul = array[0..30] of TBullet;        //������ ���� �� ���� �������

type
TWeapons = class
  private
    function GetDelay: integer;
    procedure SetDelay(const Value: integer);
    function GetMagazine: integer;
    function GetReloadDelay: integer;
    procedure SetMagazine(const Value: integer);
    procedure SetReloadDelay(const Value: integer);
    function GetCountShot: integer;
    procedure SetCountShot(const Value: integer);
    function GetTackt: longint;
    procedure SetTackt(const Value: longint);
    function GetDisperse: byte;
    procedure SetDispers(const Value: byte);
Protected
  FDelay:integer;           //�������� ����� ����������
  FMagazine:integer;        //���-�� �������� � ������
  FReloadDelay:integer;     //�������� ��� �����������
  FCountShot:integer;       //������� ���������
  FTackt:longint;           //����������� �������� �����
  FDispers: byte;           //���������� ��������
  FReadyFire:boolean;       //������� ���������� � ��������
Public
  constructor Create();
  function Shoot(const gunner,target:TSingPoint;var arrBul:TArrBul): byte;virtual;abstract;   //�������
  procedure AddCountShot;
  function IsEmptyGun:boolean;
  property Delay:integer read GetDelay write SetDelay;
  property Magazine:integer read GetMagazine write SetMagazine;
  property ReloadDelay:integer read GetReloadDelay write SetReloadDelay;
  property CountShot:integer read GetCountShot write SetCountShot;
  property Tackt:longint read GetTackt write SetTackt;
  property Dispers:byte read GetDisperse write SetDispers;
end;

TPistol = class(TWeapons)
Public
  constructor Create();
  function Shoot(const gunner,target:TSingPoint;var arrBul:TArrBul): byte;override;


end;

implementation



{ TWeapons }

procedure TWeapons.AddCountShot;
begin
if FCountShot < FMagazine then
inc(FCountShot)
else FCountShot:=0;
end;

constructor TWeapons.Create;
begin
FTackt:=globalFrameCount;
FReadyFire:=true;
end;

function TWeapons.GetCountShot: integer;
begin
result:=FCountShot;
end;

function TWeapons.GetDelay: integer;
begin
result:=FDelay;
end;

function TWeapons.GetDisperse: byte;
begin
Result:=FDispers;
end;

function TWeapons.GetMagazine: integer;
begin
result:=FMagazine;
end;

function TWeapons.GetReloadDelay: integer;
begin
result:=FReloadDelay;
end;

function TWeapons.GetTackt: longint;
begin
result:=FTackt;
end;

function TWeapons.IsEmptyGun: boolean;
begin
if (FCountShot<FMagazine) then result:=false
else
  begin
    if FReadyFire then
      begin
        FTackt:=globalFrameCount;
        FReadyFire:=false;
      end
    else if (globalFrameCount-FTackt)>=FReloadDelay
         then
          begin
            FCountShot:=0;
            FReadyFire:=true;
            result:=false;
            exit;
          end;
    result:=true;
  end;
end;

procedure TWeapons.SetCountShot(const Value: integer);
begin
FCountShot:=Value;
end;

procedure TWeapons.SetDelay(const Value: integer);
begin
FDelay:=value;
end;

procedure TWeapons.SetDispers(const Value: byte);
begin

end;

procedure TWeapons.SetMagazine(const Value: integer);
begin
FMagazine:=Value;
end;

procedure TWeapons.SetReloadDelay(const Value: integer);
begin
FReloadDelay:=Value;
end;



procedure TWeapons.SetTackt(const Value: longint);
begin
FTackt:=value;
end;

{ TPistol }

constructor TPistol.Create;
begin
inherited Create;
FDelay:=8;
FMagazine:=12;
FReloadDelay:=72;
FDispers:=3;
FCountShot:=0;
end;

function TPistol.Shoot(const gunner,target: TSingPoint;var arrBul: TArrBul ): byte;
var diffTackt:longint;k:extended;
begin
if IsEmptyGun then result:=0
else
BEGIN
  diffTackt:=globalFrameCount-FTackt;
  if diffTackt<FDelay then
    begin
      result:=0;
    end
  else begin
        result:=1;
        k:=max(abs(gunner.X-target.X),abs(gunner.Y-target.Y));
        arrBul[0]:=TBullet.Create(gunner.X,
                                  gunner.Y,
                                  target.X+(arctan(randg(0.0,5)))*k*(Dispers/diffTackt)*0.1,
                                  target.Y+(arctan(randg(0.0,5)))*k*(dispers/diffTackt)*0.1);
        AddCountShot;
        FTackt:=globalFrameCount;
      end;
END;
end;

end.
