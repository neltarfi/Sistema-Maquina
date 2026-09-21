unit uSistema;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  IniFiles;

type

  { TfSistema }

  TfSistema = class(TForm)
    btEditar: TButton;
    btSalvar: TButton;
    btSair: TButton;
    btPath: TButton;
    edtPorta: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    edtSafra: TEdit;
    edtAliquota: TEdit;
    edtPath: TEdit;
    edtServidor: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    odPath: TOpenDialog;
    PageControl1: TPageControl;
    Firebird: TTabSheet;
    Sistema: TTabSheet;
    procedure btEditarClick(Sender: TObject);
    procedure btPathClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fSistema: TfSistema;
  SistemaIni:TIniFile;

implementation

{$R *.lfm}

{ TfSistema }

procedure TfSistema.FormShow(Sender: TObject);
begin
  if ((Copy(GetCurrentDir,2,1)=':')or (Copy(GetCurrentDir,2,1)='\')) then
     SistemaIni := TIniFile.Create(GetCurrentDir+'\BaseDeDados\Sistema.ini')
  else
     SistemaIni := TIniFile.Create(GetCurrentDir+'/BaseDeDados/Sistema.ini');

  edtPath.Text    :=SistemaIni.ReadString('ConexaoBD','Path','');
  edtServidor.Text:=SistemaIni.ReadString('ConexaoBD', 'Servidor', '');
  edtPorta.Text   :=SistemaIni.ReadString('ConexaoBD', 'Porta', '');
  edtUsuario.Text :=SistemaIni.ReadString('ConexaoBD', 'Usuario', '');
  edtSenha.Text   :=SistemaIni.ReadString('ConexaoBD', 'Senha', '');
  edtSafra.Text   :=SistemaIni.ReadString('Variaveis', 'Safra','');
  edtAliquota.Text:=SistemaIni.ReadString('Variaveis', 'AliquotaFundoRural', '');
  SistemaIni.Free;
  edtServidor.Enabled:=False;
  edtPath.Enabled:=False;
  btPath.Enabled:=False;
  edtPorta.Enabled:=False;
  edtUsuario.Enabled:=False;
  edtSenha.Enabled:=False;
  edtSafra.Enabled:=False;
  edtAliquota.Enabled:=False;
  btSalvar.Enabled:=False;
end;

procedure TfSistema.btEditarClick(Sender: TObject);
begin
  edtServidor.Enabled:=True;
  edtPath.Enabled:=True;
  btPath.Enabled:=True;
  edtPorta.Enabled:=True;
  edtUsuario.Enabled:=True;
  edtSenha.Enabled:=True;
  edtSafra.Enabled:=True;
  edtAliquota.Enabled:=True;
  btSalvar.Enabled:=True;
  btEditar.Enabled:=False;
end;

procedure TfSistema.btPathClick(Sender: TObject);
begin
  odPath.Execute;
  edtPath.Text:=odPath.FileName;
end;

procedure TfSistema.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfSistema.btSalvarClick(Sender: TObject);
begin
  if ((Copy(GetCurrentDir,2,1)=':')or (Copy(GetCurrentDir,2,1)='\')) then
     SistemaIni := TIniFile.Create(GetCurrentDir+'\BaseDeDados\Sistema.ini')
  else
     SistemaIni := TIniFile.Create(GetCurrentDir+'/BaseDeDados/Sistema.ini');

  SistemaIni.WriteString('ConexaoBD','Path',edtPath.Text);
  SistemaIni.WriteString('ConexaoBD', 'Servidor', edtServidor.Text);
  SistemaIni.WriteString('ConexaoBD', 'Porta', edtPorta.Text);
  SistemaIni.WriteString('ConexaoBD', 'Usuario', edtUsuario.Text);
  SistemaIni.WriteString('ConexaoBD', 'Senha', edtSenha.Text);
  SistemaIni.WriteString('Variaveis', 'Safra', edtSafra.Text);
  SistemaIni.WriteString('Variaveis', 'AliquotaFundoRural', edtAliquota.Text);
  SistemaIni.Free;
  edtServidor.Enabled:=False;
  edtPath.Enabled:=False;
  btPath.Enabled:=False;
  edtPorta.Enabled:=False;
  edtUsuario.Enabled:=False;
  edtSenha.Enabled:=False;
  edtSafra.Enabled:=False;
  edtAliquota.Enabled:=False;
  btSalvar.Enabled:=False;
  btEditar.Enabled:=True;

end;

end.

