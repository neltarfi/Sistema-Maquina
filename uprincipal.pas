unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ZConnection, IniFiles;

type

  { TfPrincipal }

  TfPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro: TMenuItem;
    CadCliente: TMenuItem;
    CadLoteLimpo: TMenuItem;
    CadLoteCoco: TMenuItem;
    Configuracoes: TMenuItem;
    mnVariaveis: TMenuItem;
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
    procedure mnVariaveisClick(Sender: TObject);
    procedure MovCliSacariaClick(Sender: TObject);
    procedure MovSacaLoteClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure MovLoteLimpoClick(Sender: TObject);
  private

  public

  end;

var
  SistemaIni: TIniFile;
  Caminho: String;
  fPrincipal: TfPrincipal;
  CaminhoDB:string;
  FormCadastroSomenteLeitura:Boolean;//não deixa editar o segundo formulario aberto

implementation

uses uCadCliente, uCadLoteLimpo, uCadLoteCoco, uMovLoteLimpo, uMovCoco,
  uMovLoteSacaria, uMovCliSacaria, uMovCafeEmprestado, uAcerto, uRomEntCoco,
  uSistema;

{$R *.lfm}

{ TfPrincipal }

procedure TfPrincipal.FormShow(Sender: TObject);
begin
  if ((Copy(GetCurrentDir,2,1)=':')or (Copy(GetCurrentDir,2,1)='\'))and
     not(FileExists(GetCurrentDir+'\BaseDeDados\Sistema.ini')) then begin
        SistemaIni := TIniFile.Create(GetCurrentDir+'\BaseDeDados\Sistema.ini');
        Caminho :=GetCurrentDir+'\BaseDeDados\DBSistemaMaquina.fdb';
        SistemaIni.WriteString('ConexaoBD', 'Servidor', 'localhost');
        SistemaIni.WriteString('ConexaoBD', 'Path', Caminho);
        SistemaIni.WriteFloat('Variaveis', 'AliquotaFundoRural', 0);
        SistemaIni.Free;
  end;
  if not((Copy(GetCurrentDir,2,1)=':')or (Copy(GetCurrentDir,2,1)='\'))and
     not(FileExists(GetCurrentDir+'/BaseDeDados/Sistema.ini')) then begin
        SistemaIni := TIniFile.Create(GetCurrentDir+'/BaseDeDados/Sistema.ini');
        Caminho :=GetCurrentDir+'/BaseDeDados/DBSistemaMaquina.fdb';
        SistemaIni.WriteString('ConexaoBD', 'Servidor', 'localhost');
        SistemaIni.WriteString('ConexaoBD', 'Path', Caminho);
        SistemaIni.WriteFloat('Variaveis', 'AliquotaFundoRural', 0);
        SistemaIni.Free;
   end;

  zConn.Disconnect;
  if ((Copy(GetCurrentDir,2,1)=':')or (Copy(GetCurrentDir,2,1)='\')) then
     SistemaIni := TIniFile.Create(GetCurrentDir+'\BaseDeDados\Sistema.ini')
  else
     SistemaIni := TIniFile.Create(GetCurrentDir+'/BaseDeDados/Sistema.ini');

  zConn.Database:=SistemaIni.ReadString('ConexaoBD','Path','');
  zConn.HostName:= SistemaIni.ReadString('ConexaoBD', 'Servidor', '');
  zConn.Connect;
  SistemaIni.Free;
  FormCadastroSomenteLeitura:=False;
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

procedure TfPrincipal.mnVariaveisClick(Sender: TObject);
begin
  fSistema:=TfSistema.Create(Self);
  fSistema.ShowModal;
  fSistema.Destroy;
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

