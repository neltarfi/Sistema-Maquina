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
  uMovCafeEmprestado, uMovCliSacaria, uMovLoteSacaria, uFuncoes, umovlotecoco,
  uRomSaidaCoco, uSistema, uMovCafeDepositado, uRomCompraDepositado;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.CreateForm(TfMovLoteCoco, fMovLoteCoco);
  Application.CreateForm(TfRomSaidaCoco, fRomSaidaCoco);
  Application.CreateForm(TfSistema, fSistema);
  Application.CreateForm(TfMovCafeDepositado, fMovCafeDepositado);
  Application.CreateForm(TfRomCompraDepositado, fRomCompraDepositado);
  Application.Run;
end.

