unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ZConnection;

type

  { TfPrincipal }

  TfPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro: TMenuItem;
    CadCliente: TMenuItem;
    CadLoteLimpo: TMenuItem;
    CadLoteCoco: TMenuItem;
    mnMovCoco: TMenuItem;
    mnAcerto: TMenuItem;
    mnFinanceiro: TMenuItem;
    mnCafeEmprestado: TMenuItem;
    MovCliSacaria: TMenuItem;
    MovSacaLote: TMenuItem;
    MovLoteSacaria: TMenuItem;
    Sair: TMenuItem;
    MovLoteLimpo: TMenuItem;
    Movimrnto: TMenuItem;
    zConn: TZConnection;
    procedure CadClienteClick(Sender: TObject);
    procedure CadLoteCocoClick(Sender: TObject);
    procedure CadLoteLimpoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnMovCocoClick(Sender: TObject);
    procedure mnAcertoClick(Sender: TObject);
    procedure mnCafeEmprestadoClick(Sender: TObject);
    procedure MovCliSacariaClick(Sender: TObject);
    procedure MovSacaLoteClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure MovLoteLimpoClick(Sender: TObject);
  private

  public

  end;

var
  fPrincipal: TfPrincipal;
  CaminhoDB:string;
  FormSomenteLeitura:Boolean;//não deixa editar o segundo formulario aberto

implementation

uses uCadCliente, uCadLoteLimpo, uCadLoteCoco, uMovLoteLimpo, uMovCoco,
  uMovLoteSacaria, uMovCliSacaria, uMovCafeEmprestado, uAcerto, uRomEntCoco;

{$R *.lfm}

{ TfPrincipal }

procedure TfPrincipal.FormShow(Sender: TObject);
begin
  if ((Copy(GetCurrentDir,2,1)=':')or (Copy(GetCurrentDir,2,1)='\')) then
     CaminhoDB:=GetCurrentDir+'\Base De Dados\DBSistemaMaquina.db'
  else
     CaminhoDB:=GetCurrentDir+'/Base De Dados/DBSistemaMaquina.db';
     zConn.Disconnect;
     zConn.Database:=CaminhoDB;
     zConn.Connect;
     FormSomenteLeitura:=False;
end;

procedure TfPrincipal.mnMovCocoClick(Sender: TObject);
begin
    fMovCoco:=TfMovCoco.Create(Self);
    fMovCoco.ShowModal;
    fMovCoco.Destroy;
end;

procedure TfPrincipal.CadClienteClick(Sender: TObject);
begin
    fCadCliente:=TfCadCliente.Create(Self);
    fCadCliente.ShowModal;
    fCadCliente.Destroy;
end;

procedure TfPrincipal.CadLoteCocoClick(Sender: TObject);
begin
    fCadLoteCoco:=TfCadLoteCoco.Create(Self);
    fCadLoteCoco.ShowModal;
    fCadLoteCoco.Destroy;
end;

procedure TfPrincipal.CadLoteLimpoClick(Sender: TObject);
begin
    fCadLoteLimpo:=TfCadLoteLimpo.Create(Self);
    fCadLoteLimpo.ShowModal;
    fCadLoteLimpo.Destroy;
end;

procedure TfPrincipal.mnAcertoClick(Sender: TObject);
begin
  fAcerto:=TfAcerto.Create(Self);
  fAcerto.ShowModal;
  fAcerto.Destroy;
end;

procedure TfPrincipal.mnCafeEmprestadoClick(Sender: TObject);
begin
  fMovCafeEmprestado:=TfMovCafeEmprestado.Create(Self);
  fMovCafeEmprestado.ShowModal;
  fMovCafeEmprestado.Destroy;
end;

procedure TfPrincipal.MovCliSacariaClick(Sender: TObject);
begin
  fMovCliSacaria:=TfMovCliSacaria.Create(Self);
  fMovCliSacaria.ShowModal;
  fMovCliSacaria.Destroy;
end;

procedure TfPrincipal.MovSacaLoteClick(Sender: TObject);
begin
  fMovLoteSacaria:=TfMovLoteSacaria.Create(Self);
  fMovLoteSacaria.ShowModal;
  fMovLoteSacaria.Destroy;
end;

procedure TfPrincipal.SairClick(Sender: TObject);
begin

   Close;
end;

procedure TfPrincipal.MovLoteLimpoClick(Sender: TObject);
begin
  fMovLoteLimpo:=TfMovLoteLimpo.Create(Self);
  fMovLoteLimpo.ShowModal;
  fMovLoteLimpo.Destroy;
end;

end.

