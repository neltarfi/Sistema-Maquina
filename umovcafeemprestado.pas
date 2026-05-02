unit uMovCafeEmprestado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBCtrls, DBGrids, DBExtCtrls, Buttons, DBDateTimePicker, DateTimePicker,
  ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfMovCafeEmprestado }
  TfMovCafeEmprestado = class(TForm)
    btCancelar: TBitBtn;
    btEmprestar: TButton;
    btDevolver: TButton;
    btBuscaCliente: TButton;
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    btBuscaLoteLimpo: TButton;
    dsClienteSaldo: TDataSource;
    dsCliente: TDataSource;
    dbcParaLoteLimpo: TDBLookupComboBox;
    dbeSaldoCafeEmprestado: TDBEdit;
    dsLoteSacaria: TDataSource;
    dbcCliente: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    dsMovCafeEmprestado: TDataSource;
    dsParaLoteLimpo: TDataSource;
    dtpData: TDateTimePicker;
    edtHistorico: TEdit;
    edtPeso: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbOperacao: TLabel;
    lbParaLoteSacaria: TLabel;
    pnBotaoEditar: TPanel;
    pnBotaoSalvar: TPanel;
    pnBotao: TPanel;
    pnEditar: TPanel;
    pnFiltrar: TPanel;
    zConn: TZConnection;
    zqClienteIDPrincipal: TZInt64Field;
    zqClienteRazao: TZRawStringField;
    zqClienteSaldo1: TZUInt64Field;
    zqClienteSaldoIDCliente: TZInt64Field;
    zqClienteSaldoSaldoCafeEmprestado: TZInt64Field;
    zqMovCafeEmprestadoData: TZDateField;
    zqMovCafeEmprestadoHistorico: TZRawStringField;
    zqMovCafeEmprestadoIDCliente: TZInt64Field;
    zqMovCafeEmprestadoIDLoteLimpo: TZInt64Field;
    zqMovCafeEmprestadoNome: TZRawStringField;
    zqMovCafeEmprestadoPesoDevolver: TZDoubleField;
    zqMovCafeEmprestadoPesoEmprestar: TZDoubleField;
    zqMovCafeEmprestadoStatus: TZRawStringField;
    zqNovoIDCafeEmprestadoID: TZInt64Field;
    zqParaLoteLimpo: TZQuery;
    zqMovCafeEmprestado: TZQuery;
    zqNovoIDCafeEmprestado: TZQuery;
    zqCliente: TZQuery;
    zqClienteSaldo: TZQuery;
    zqParaLoteLimpoIDLoteLimpo: TZInt64Field;
    zqParaLoteLimpoNomeParaLoteLimpo: TZRawStringField;
    zqParaLoteLimpoStatus: TZRawStringField;
    zqNovoIDMovLoteLimpo: TZQuery;
    zqNovoIDMovLoteLimpoID: TZInt64Field;
    ztCafeEmprestadoPesoDevolver: TZDoubleField;
    ztCafeEmprestadoPesoEmprestar: TZDoubleField;
    ztMovLoteLimpo: TZTable;
    ztClienteIDCliente: TZUInt64Field;
    ztClienteSaldoCafeEmprestado: TZInt64Field;
    ztLoteLimpo: TZTable;
    ztCafeEmprestadoIDCafeEmprestado: TZInt64Field;
    ztCliente: TZTable;
    ztCafeEmprestado: TZTable;
    ztCafeEmprestadoData: TZDateField;
    ztCafeEmprestadoHistorico: TZRawStringField;
    ztCafeEmprestadoIDCliente: TZInt64Field;
    ztCafeEmprestadoIDLoteLimpo: TZInt64Field;
    ztCafeEmprestadoStatus: TZRawStringField;
    ztLoteLimpoIDLoteLimpo: TZInt64Field;
    ztLoteLimpoNome: TZRawStringField;
    ztLoteLimpoSaldo: TZDoubleField;
    ztLoteLimpoStatus: TZRawStringField;
    ztMovLoteLimpoData: TZDateField;
    ztMovLoteLimpoHistorico: TZRawStringField;
    ztMovLoteLimpoIDCliente: TZInt64Field;
    ztMovLoteLimpoIDLoteLimpo: TZInt64Field;
    ztMovLoteLimpoIDMovLoteLimpo: TZInt64Field;
    ztMovLoteLimpoPesoEntrada: TZDoubleField;
    ztMovLoteLimpoPesoSaida: TZDoubleField;
    ztMovLoteLimpoStatus: TZRawStringField;
    procedure btBuscaLoteLimpoClick(Sender: TObject);
    procedure btBuscaClienteClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btEmprestarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btDevolverClick(Sender: TObject);
    procedure dbcClienteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AplicaFiltro();
    procedure EditarTrue();
    procedure editarFalse();
    function SalvarTrue:boolean;
  private

  public

  end;

var
  fMovCafeEmprestado: TfMovCafeEmprestado;
  Botao:string;

implementation

uses uFuncoes, uCadCliente, uPrincipal, uCadLoteLimpo;

{$R *.lfm}

{ TfMovCafeEmprestado }

procedure TfMovCafeEmprestado.FormCreate(Sender: TObject);
begin
  zConn.Disconnect;
  zConn.Database:=uPrincipal.CaminhoDB;
  zConn.Connect;
  zqCliente.Active:=True;
  zqParaLoteLimpo.Active:=True;
  zqMovCafeEmprestado.Active:=True;
  zqCliente.Locate('IDPrincipal',0,[]);
  EditarFalse;
  pnBotaoEditar.Enabled:=False;
  AplicaFiltro;
end;

procedure TfMovCafeEmprestado.btEmprestarClick(Sender: TObject);
begin
  Botao:='Emprestar';
  EditarTrue;
end;

procedure TfMovCafeEmprestado.btDevolverClick(Sender: TObject);
begin
  Botao:='Devolver';
  EditarTrue;
end;

procedure TfMovCafeEmprestado.btCancelarClick(Sender: TObject);
begin
  EditarFalse;
end;

procedure TfMovCafeEmprestado.btSairClick(Sender: TObject);
begin
  zqCliente.Active:=False;
  zqParaLoteLimpo.Active:=False;
  zqMovCafeEmprestado.Active:=False;
  Close;
end;

procedure TfMovCafeEmprestado.btSalvarClick(Sender: TObject);
begin
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes) then  Exit;
  if not(SalvarTrue) then Exit;
  try
  ztCafeEmprestado.Active:=True;
  zqNovoIDCafeEmprestado.Active:=True;
  ztCliente.Active:=True;
  ztLoteLimpo.Active:=True;
  zConn.StartTransaction;
  zqNovoIDCafeEmprestado.Refresh;
  ztCafeEmprestado.Append;
  ztCafeEmprestadoIDCafeEmprestado.Value:=zqNovoIDCafeEmprestadoID.Value+1;
  ztCafeEmprestadoIDLoteLimpo.Value:=dbcParaLoteLimpo.KeyValue;
  ztCafeEmprestadoIDCliente.Value:=dbcCliente.KeyValue;
  ztCafeEmprestadoData.Text:=dateToStr(dtpData.Date);
  ztCliente.Refresh;
  ztLoteLimpo.Locate('IDLoteLimpo',dbcParaLoteLimpo.KeyValue,[]);
  ztCliente.Locate('IDCliente',dbcCliente.KeyValue,[]);
  ztCliente.Edit;
  ztLoteLimpo.Edit;
  ztMovLoteLimpo.Active:=True;
  zqNovoIDMovLoteLimpo.Active:=True;
  zqNovoIDMovLoteLimpo.Refresh;
  ztMovLoteLimpo.Append;
  ztMovLoteLimpoIDMovLoteLimpo.Value:=zqNovoIDMovLoteLimpoID.Value+1;
  ztMovLoteLimpoIDLoteLimpo.Value:=dbcParaLoteLimpo.KeyValue;
  ztMovLoteLimpoIDCliente.Value:=dbcCliente.KeyValue;
  ztMovLoteLimpoData.Text:=dateToStr(dtpData.Date);
  ztMovLoteLimpoStatus.Value:='Ativo';
  Case Botao of
       'Emprestar':Begin
                     ztCafeEmprestadoHistorico.Value:=edtHistorico.Text;
                     ztCafeEmprestadoPesoEmprestar.Value:=strToInt(edtPeso.Text);
                     ztCafeEmprestadoPesoDevolver.Value:=0;
                     ztLoteLimpoSaldo.Value:=ztLoteLimpoSaldo.Value - strToInt(edtPeso.Text);
                     ztClienteSaldoCafeEmprestado.Value:=ztClienteSaldoCafeEmprestado.Value + strToInt(edtPeso.Text);
                     ztMovLoteLimpoHistorico.Value:='Emprestimo do cliente '+IntToStr(dbcCliente.KeyValue);
                     ztMovLoteLimpoPesoEntrada.Value:=0;
                     ztMovLoteLimpoPesoSaida.Value:=strToInt(edtPeso.Text);
                 end;
       'Devolver':begin
                    ztCafeEmprestadoHistorico.Value:=edtHistorico.Text;
                    ztCafeEmprestadoPesoEmprestar.Value:=0;
                    ztCafeEmprestadoPesoDevolver.Value:=strToInt(edtPeso.Text);
                    ztLoteLimpoSaldo.Value:=ztLoteLimpoSaldo.Value + strToInt(edtPeso.Text);
                    ztClienteSaldoCafeEmprestado.Value:=ztClienteSaldoCafeEmprestado.Value - strToInt(edtPeso.Text);
                    ztMovLOteLimpoHistorico.Value:='Devolução do cliente '+IntToStr(dbcCliente.KeyValue);
                    ztMovLoteLimpoPesoEntrada.Value:=strToInt(edtPeso.Text);;
                    ztMovLoteLimpoPesoSaida.Value:=0
               end;
  end;
  ztCliente.Post;
  ztLoteLimpo.Post;
  ztCafeEmprestadoStatus.Value:='Ativo';
  ztCafeEmprestado.Post;
  ztMovLoteLimpo.Post;
  zConn.Commit;
  except
  ztCliente.Cancel;
  ztLoteLimpo.Cancel;
  ztCafeEmprestado.Cancel;
  ztMovLoteLimpo.Cancel;
  zConn.Rollback;
  MessageDlg('Erro ao tentar salvar nova transação', mtError,[mbOk], 0);
  end;
  ztCliente.Active:=False;
  ztLoteLimpo.Active:=False;
  ztCafeEmprestado.Active:=False;
  zqNovoIDCafeEmprestado.Active:=False;
  ztMovLoteLimpo.Active:=False;
  zqNovoIDMovLoteLimpo.Active:=False;
  EditarFalse;
  AplicaFiltro;
end;

function TfMovCafeEmprestado.SalvarTrue:boolean;
var Erro:string;
begin
  SalvarTrue:=True;
  Erro:='';
  if (dbcParaLoteLimpo.KeyValue=Null) then
     Erro:=Erro+'-o valor do campo Para lote limpo não é válido.'+ chr(13);
  if (edtHistorico.Text='') then
     Erro:=Erro+'-o valor do campo Historico não é válido.'+ chr(13);
  if dtpData.Date=Null then
     Erro:=Erro+'-o valor do campo Data não é válido.'+ chr(13);
  if (not(FloatTrue(edtPeso.Text,3)) or
     (strToInt(edtPeso.Text)<=0) or (edtPeso.Text='')) then
     Erro:=Erro+'-o valor do Quantidade não é válido.'+ chr(13);
  if not(Erro = '') then
  begin
       MessageDlg(Erro, mtError,[mbOk], 0);
       SalvarTrue:=False;
  end;
end;

procedure TfMovCafeEmprestado.EditarTrue();
begin
  pnFiltrar.Enabled:=False;
  pnEditar.Enabled:=True;
  pnBotaoSalvar.Enabled:=True;
  pnBotaoEditar.Enabled:=False;
  btSair.Enabled:=False;
  lbOperacao.Caption:=Botao;
  dtpData.Date:=Date;
  EditarForm:=True;
end;

procedure TfMovCafeEmprestado.editarFalse();
begin
  pnFiltrar.Enabled:=True;
  pnEditar.Enabled:=False;
  pnBotaoSalvar.Enabled:=False;
  btSair.Enabled:=True;
  dbeSaldoCafeEmprestado.Enabled:=True;
  dbcCliente.KeyValue:= 0;
  dbcParaLoteLimpo.KeyValue:=0;
  edtHistorico.Text:='';
  edtPeso.Text:='0';
  zqMovCafeEmprestado.Filtered:=False;
  zqMovCafeEmprestado.Filter:='(IDCliente = -1)';
  zqMovCafeEmprestado.Filtered:=True;
  ztLoteLimpo.Filtered:=False;
  ztLoteLimpo.Filtered:=True;
  lbOperacao.Caption:='';
  EditarForm:=False;
end;

procedure TfMovCafeEmprestado.AplicaFiltro();
var temp:integer;
begin
       zqParaLoteLimpo.Refresh;
       zqCliente.Refresh;
       zqMovCafeEmprestado.Refresh;
       if Not(dbcCliente.KeyValue > 0)
       then temp:= 0
       else temp:=dbcCliente.KeyValue;
       zqMovCafeEmprestado.Filtered:=False;
       zqMovCafeEmprestado.Filter:='((IDCliente =' + QuotedStr(intToStr(temp)) +') and (IDCliente <> 0) and (Status = '+QuotedStr('Ativo')+'))';
       zqMovCafeEmprestado.Filtered:=True;
end;

procedure TfMovCafeEmprestado.btBuscaClienteClick(Sender: TObject);
var temp:integer;
begin
  fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    fCadCliente.Destroy;
    zqCliente.Refresh;
    dbcCliente.KeyValue:=temp;
    pnBotaoEditar.Enabled:=True;
    AplicaFiltro;
end;

procedure TfMovCafeEmprestado.btBuscaLoteLimpoClick(Sender: TObject);
var temp:integer;
begin
  fCadLoteLimpo:=TfCadLoteLimpo.Create(Self);
    temp:=fCadLoteLimpo.ShowModal;
    fCadLoteLimpo.Destroy;
    zqParaLoteLimpo.Refresh;
    dbcParaLoteLimpo.KeyValue:=temp;
end;

procedure TfMovCafeEmprestado.dbcClienteChange(Sender: TObject);
begin
  if not(dbcCliente.KeyValue > 0)
  then
  begin
       pnBotaoEditar.Enabled:=False;
       zqCliente.Locate('IDPrincipal',0,[]);
       AplicaFiltro;
       Exit;
  end;
  zqCliente.Locate('IDPrincipal',dbcCliente.KeyValue,[]);
  AplicaFiltro;
  pnBotaoEditar.Enabled:=True;
  zqMovCafeEmprestado.Last;
end;

end.

