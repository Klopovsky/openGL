unit Effects;

interface

uses SysUtils, Windows, Graphics,Math,OpenGL,Units,ProthoUnit;

type
 Explos = class(TSprite)
 public
    constructor Create(X,Y,ang:single);
    procedure SetIndex(ind:byte);override;
    procedure Draw();override;
 end;

type
  Death = class(Explos)
  public
    constructor Create(X,Y,ang:single);
    procedure SetIndex(ind:byte);override;
end;
procedure OutText (Litera : PChar);

implementation

{Explos}
constructor Explos.Create(X,Y,ang:single);
begin
inherited Create(X,Y,ang);
FIndex:=0;
FKolKadr:=4;
FSize:=0.015;
FRefBmp:=@EffectBmp;
end;

procedure Explos.SetIndex(ind:byte);
begin
FIndex:=ind;
Size:=Size+0.005*(KolKadr-IndexUnit);
if ind=(2*KolKadr+1) then FDeath:=true;

end;

procedure Explos.Draw();
begin
inherited Draw;
IndexUnit:=IndexUnit+1;
end;


{death}
constructor Death.Create(X,Y,ang:single);
begin
inherited Create(X,Y,ang);
FIndex:=0;
FKolKadr:=16;
FSize:=0.06;
FRefBmp:=@DeathBmp;
end;

procedure Death.SetIndex(ind:byte);
begin
FIndex:=ind;

if ind=KolKadr then FDeath:=true;
end;

{another effects}
procedure OutText (Litera : PChar);
begin
  glListBase(100);
  glCallLists(Length (Litera), GL_UNSIGNED_BYTE, Litera);
end;

end.
