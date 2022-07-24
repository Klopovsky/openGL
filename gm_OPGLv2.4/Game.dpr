program Game;

uses
  Forms,
  main in 'main.pas' {frmGL},
  Units in 'Units.pas',
  Effects in 'Effects.pas',
  weapons in 'weapons.pas',
  ProthoUnit in 'ProthoUnit.pas',
  Bullets in 'Bullets.pas',
  global in 'global.pas',
  checkMem in 'checkMem.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmGL, frmGL);
  Application.Run;
end.

