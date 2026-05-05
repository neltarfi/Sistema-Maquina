unit ucadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, Buttons, ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfCadCliente }

  TfCadCliente = class(TForm)
    btSelecionar: TBitBtn;
    btNovoCliAdicional: TBitBtn;
    btNovo: TBitBtn;
    btEditar: TBitBtn;
    btSair: TBitBtn;
    dbgCliente: TDBGrid;
    dsCliente: TDataSource;
    edtBuscar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    zqCliente: TZQuery;
    zqClienteBairro: TZRawStringField;
    zqClienteCelular: TZRawStringField;
    zqClienteCidade: TZRawStringField;
    zqClienteCNPJ: TZRawStringField;
    zqClienteComplemento: TZRawStringField;
    zqClienteCPF: TZRawStringField;
    zqClienteDataReg: TZDateField;
    zqClienteEndereco: TZRawStringField;
    zqClienteEstado: TZRawStringField;
    zqClienteIDCliente: TZIntegerField;
    zqClienteIDPrincipal: TZIntegerField;
    zqClienteInsEstadual: TZRawStringField;
    zqClienteObs: TZRawStringField;
    zqClienteRazao: TZRawStringField;
    zqClienteSaldoCafeEmprestado: TZDoubleField;
    zqClienteSaldoContaCorrente: TZDoubleField;
    zqClienteSaldoSacariaJuta: TZIntegerField;
    zqClienteSaldoSacariaPlastico: TZIntegerField;
    zqClienteSerie: TZRawStringField;
    zqClienteStatus: TZRawStringField;
    zqClienteTelefone: TZRawStringField;
    zqNovoIDCliente: TZQuery;
    zqNovoIDClienteID: TZIntegerField;
    procedure btEditarClick(Sender: TObject);
    procedure btNovoCliAdicionalClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSelecionarClick(Sender: TObject);
    procedure edtBuscarChange(Sender: TObject);
    procedure AplicaFiltro;
    procedure AbreEditaCliente;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  fCadCliente: TfCadCliente;
  Botao:string;
  EditarForm:boolean;//Usada para se o form estive em modo de edição ou adição
                     //de registro, consiga desbloquear db no evento onclose

implementation

uses ueditaCliente, uPrincipal;

{$R *.lfm}

{ TfCadCliente }

procedure TfCadCliente.AbreEditaCliente;
var temp:integer;
begin
  fEditaCliente:= TfEditaCliente.Create(Self);
   temp:=fEditaCliente.ShowModal;
   fEditaCliente.Destroy;
   AplicaFiltro;
end;

procedure TfCadCliente.btEditarClick(Sender: TObject);
begin
  Botao:='Editar';
   AbreEditaCliente;
end;

procedure TfCadCliente.btNovoCliAdicionalClick(Sender: TObject);
begin
   if zqClienteSerie.Value='Adicional' then
      MessageDlg('-Cliente Adicional não pode receber novo cliente adicional.',mtError,[mbOk],0)
   else
   begin
   Botao:='NovoAdicional';
   AbreEditaCliente;
   end;
end;

procedure TfCadCliente.btNovoClick(Sender: TObject);
begin
   Botao:='Novo';
   AbreEditaCliente;
end;

procedure TfCadCliente.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfCadCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
     if zqClienteIDCliente.Value >= 1 then
        fCadCliente.ModalResult:=zqClienteIDCliente.Value;
     SomenteLeitura:=False;
end;

procedure TfCadCliente.FormShow(Sender: TObject);
begin
  if SomenteLeitura then Begin
     btNovo.Enabled:=False;
     btNovoCliAdicional.Enabled:=False;
     btEditar.Enabled:=False;
  end;

  zqCliente.Open;
  AplicaFiltro;
end;

procedure TfCadCliente.AplicaFiltro;
var temp:integer;
begin
   temp:=zqClienteIDCliente.Value;
   zqCliente.Filtered:=False;
   zqCliente.Filter := '(Razao LIKE '+QuotedStr('*'+edtBuscar.Text+'*')+')';
   zqCliente.Filtered:=True;
   zqCliente.Locate('IDCliente',temp,[]);
end;

procedure TfCadCliente.edtBuscarChange(Sender: TObject);
begin
  AplicaFiltro;
end;

procedure TfCadCliente.btSelecionarClick(Sender: TObject);
begin
  Close;
end;
end.

