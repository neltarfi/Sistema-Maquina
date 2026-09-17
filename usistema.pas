unit uSistema;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, IniFiles;

type

  { TfSistema }

  TfSistema = class(TForm)
    btEditar: TButton;
    btSalvar: TButton;
    btSair: TButton;
    edtServidor: TEdit;
    edtPath: TEdit;
    edtAliquota: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btEditarClick(Sender: TObject);
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

  edtPath.Text:=SistemaIni.ReadString('ConexaoBD','Path','');
  edtServidor.Text:= SistemaIni.ReadString('ConexaoBD', 'Servidor', '');
  edtAliquota.Text:=SistemaIni.ReadString('Variaveis', 'AliquotaFundoRural', '');
  SistemaIni.Free;
  edtServidor.Enabled:=False;
  edtPath.Enabled:=False;
  edtAliquota.Enabled:=False;
  btSalvar.Enabled:=False;
end;

procedure TfSistema.btEditarClick(Sender: TObject);
begin
  edtServidor.Enabled:=True;
  edtPath.Enabled:=True;
  edtAliquota.Enabled:=True;
  btSalvar.Enabled:=True;
  btEditar.Enabled:=False;
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
  SistemaIni.WriteString('Variaveis', 'AliquotaFundoRural', edtAliquota.Text);
  SistemaIni.Free;
  edtServidor.Enabled:=False;
  edtPath.Enabled:=False;
  edtAliquota.Enabled:=False;
  btSalvar.Enabled:=False;
  btEditar.Enabled:=True;

end;

end.

