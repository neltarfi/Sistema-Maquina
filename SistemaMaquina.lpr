program SistemaMaquina;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, memdslaz, zcomponent, ucadCliente, ueditaCliente,
  uPrincipal, uCadLoteLimpo, uCadLoteCoco, uAcerto, uMovLoteLimpo, uRomEntCoco,
  uMovCafeEmprestado, uMovCliSacaria, uMovLoteSacaria, uFuncoes, uMovCoco,
  uRomSaidaCoco;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.CreateForm(TfMovCoco, fMovCoco);
  Application.CreateForm(TfRomSaidaCoco, fRomSaidaCoco);
  Application.Run;
end.

