unit uMovLoteLimpo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBCtrls, DBGrids, DBExtCtrls, Buttons, MaskEdit, DBDateTimePicker,
  DateTimePicker, ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfMovLoteLimpo }
  TfMovLoteLimpo = class(TForm)
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    btCancelar: TBitBtn;
    btTransferir: TBitBtn;
    btBuscaParaLoteLimpo: TButton;
    btEntrada: TButton;
    btSaida: TButton;
    btBuscaDoLoteLimpo: TButton;
    btBuscarCliente: TButton;
    dbcParaLoteLimpo: TDBLookupComboBox;
    dbcCliente: TDBLookupComboBox;
    dbeSaldo: TDBEdit;
    dsSaldoLoteLimpo: TDataSource;
    dbcDoLoteLimpo: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    dsMovLoteLimpo: TDataSource;
    dsCliente: TDataSource;
    dsDoLoteLimpo: TDataSource;
    dsParaLoteLimpo: TDataSource;
    dtpData: TDateTimePicker;
    edtHistorico: TEdit;
    edtPeso: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbOperacao: TLabel;
    lbParaLoteLimpo: TLabel;
    pnBotaoEditar: TPanel;
    pnBotaoSalvar: TPanel;
    pnBotao: TPanel;
    pnEditar: TPanel;
    pnFiltrar: TPanel;
    zqClienteIDCliente: TZInt64Field;
    zqClienteNome: TZRawStringField;
    zqClienteRazao: TZRawStringField;
    zqDoLoteLimpo: TZQuery;
    zqDoLoteLimpoIDLoteLimpo: TZInt64Field;
    zqDoLoteLimpoNomeDoLoteLimpo: TZRawStringField;
    zqCliente: TZQuery;
    zqDoLoteLimpoSaldo: TZDoubleField;
    zqDoLoteLimpoStatus: TZRawStringField;
    zqMovLoteLimpoData: TZDateField;
    zqMovLoteLimpoHistorico: TZRawStringField;
    zqMovLoteLimpoIDLoteLimpo: TZIntegerField;
    zqMovLoteLimpoIDMovLoteLimpo: TZIntegerField;
    zqMovLoteLimpoNOME: TZRawStringField;
    zqMovLoteLimpoPesoEntrada: TZDoubleField;
    zqMovLoteLimpoPesoSaida: TZIntegerField;
    zqMovLoteLimpoStatus: TZRawStringField;
    zqNovoIDMovLoteLimpoID: TZInt64Field;
    zqParaLoteLimpo: TZQuery;
    zqParaLoteLimpoIDLoteLimpo: TZInt64Field;
    zqParaLoteLimpoNomeParaLoteLimpo: TZRawStringField;
    zqMovLoteLimpo: TZQuery;
    zqNovoIDMovLoteLimpo: TZQuery;
    zqParaLoteLimpoStatus: TZRawStringField;
    ztMovLoteLimpoPesoEntrada: TZDoubleField;
    ztSaldoLoteLimpo: TZTable;
    ztSaldoLoteLimpoIDLoteLimpo: TZInt64Field;
    ztSaldoLoteLimpoNome: TZRawStringField;
    ztSaldoLoteLimpoSaldo: TZDoubleField;
    ztSaldoLoteLimpoStatus: TZRawStringField;
    ztMovLoteLimpo: TZTable;
    ztMovLoteLimpoData: TZDateField;
    ztMovLoteLimpoHistorico: TZRawStringField;
    ztMovLoteLimpoIDCliente: TZInt64Field;
    ztMovLoteLimpoIDLoteLimpo: TZInt64Field;
    ztMovLoteLimpoIDMovLoteLimpo: TZInt64Field;
    ztMovLoteLimpoPesoSaida: TZDoubleField;
    ztMovLoteLimpoStatus: TZRawStringField;
    procedure btBuscarClienteClick(Sender: TObject);
    procedure btBuscaDoLoteLimpoClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btEntradaClick(Sender: TObject);
    procedure btBuscaParaLoteLimpoClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btTransferirClick(Sender: TObject);
    procedure btSaidaClick(Sender: TObject);
    procedure dbcDoLoteLimpoChange(Sender: TObject);
    procedure AplicaFiltro();
    procedure EditarTrue();
    procedure editarFalse();
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    function SalvarTrue:boolean;
  private

  public

  end;

var
  fMovLoteLimpo: TfMovLoteLimpo;
  Botao:string;

implementation

uses uFuncoes, uCadCliente, uCadLoteLimpo, uPrincipal;

{$R *.lfm}

{ TfMovLoteLimpo }

procedure TfMovLoteLimpo.FormShow(Sender: TObject);
begin
  zqCliente.Active:=True;
  zqDoLoteLimpo.Active:=True;
  zqParaLoteLimpo.Active:=True;
  zqMovLoteLimpo.Active:=True;
  ztSaldoLoteLimpo.Active:=True;
  dbcDoLoteLimpo.KeyValue:=0;
  zqDoLoteLimpo.Filtered:=False;
  zqDoLoteLimpo.Filter:='((Status = '+QuotedStr('Ativo')+') or (Status = ' + QuotedStr('Protegido') + '))';
  zqDoLoteLimpo.Filtered:=True;
  EditarFalse;
  FormSomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
end;

procedure TfMovLoteLimpo.btEntradaClick(Sender: TObject);
begin
  Botao:='Entrada';
  EditarTrue;
end;

procedure TfMovLoteLimpo.btSaidaClick(Sender: TObject);
begin
  Botao:='Saida';
  EditarTrue;
end;

procedure TfMovLoteLimpo.btTransferirClick(Sender: TObject);
begin
  Botao:='Transferir';
  EditarTrue;
  dbcCliente.KeyValue:=0;
end;

procedure TfMovLoteLimpo.btCancelarClick(Sender: TObject);
begin
    EditarFalse;
end;
procedure TfMovLoteLimpo.btSairClick(Sender: TObject);
begin
  Close;
end;
procedure TfMovLoteLimpo.btSalvarClick(Sender: TObject);
begin
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes) then  Exit;
  if not(SalvarTrue) then Exit;
  try
  ztMovLoteLimpo.Active:=True;
  zqNovoIDMovLoteLimpo.Active:=True;
  fPrincipal.zConn.StartTransaction;
  ztMovLoteLimpo.Append;
  ztMovLoteLimpoIDMovLoteLimpo.Value:=zqNovoIDMovLoteLimpoID.Value+1;
  ztMovLoteLimpoIDLoteLimpo.Value:=dbcDoLoteLimpo.KeyValue;
  ztMovLoteLimpoIDCliente.Value:=dbcCliente.KeyValue;
  ztMovLoteLimpoData.Text:=dateToStr(dtpData.Date);
  ztSaldoLoteLimpo.Edit;
  Case Botao of
       'Entrada':Begin
                     ztMovLoteLimpoHistorico.Value:=edtHistorico.Text;
                     ztMovLoteLimpoPesoEntrada.Value:=strToFloat(edtPeso.Text);
                     ztMovLoteLimpoPesoSaida.Value:=0;
                     ztSaldoLoteLimpoSaldo.Value:=ztSaldoLoteLimpoSaldo.Value + strToFloat(edtPeso.Text);
                 end;
       'Saida':begin
                    ztMovLoteLimpoHistorico.Value:=edtHistorico.Text;
                    ztMovLoteLimpoPesoEntrada.Value:=0;
                    ztMovLoteLimpoPesoSaida.Value:=strToFloat(edtPeso.Text);
                    ztSaldoLoteLimpoSaldo.Value:=ztSaldoLoteLimpoSaldo.Value - strToFloat(edtPeso.Text);
               end;
       'Transferir':Begin
                         ztMovLoteLimpoHistorico.Text:='Transferido para o lote Limpo nº '+intToStr(dbcParaLoteLimpo.KeyValue);
                         ztMovLoteLimpoPesoSaida.Value:=strToFloat(edtPeso.Text);
                         ztMovLoteLimpoPesoEntrada.Value:=0;
                         ztSaldoLoteLimpoSaldo.Value:=ztSaldoLoteLimpoSaldo.Value - strToFloat(edtPeso.Text);
                         ztMovLoteLimpoIDCliente.Value:=0;
                    end;
  end;
  ztSaldoLoteLimpo.Post;
  ztMovLoteLimpoStatus.Value:='Ativo';
  ztMovLoteLimpo.Post;
  if Botao='Transferir' then
  begin
       ztMovLoteLimpo.Append;
       zqNovoIDMovLoteLimpo.Refresh;
       ztMovLoteLimpoIDMovLoteLimpo.Value:=zqNovoIDMovLoteLimpoID.Value+1;
       ztMovLoteLimpoIDLoteLimpo.Value:=dbcParaLoteLimpo.KeyValue;
       ztMovLoteLimpoIDCliente.Value:=dbcCliente.KeyValue;
       ztMovLoteLimpoData.Text:=dateToStr(dtpData.Date);
       ztMovLoteLimpoHistorico.Text:='Transferido do lote Limpo nº '+intToStr(dbcDoLoteLimpo.KeyValue);
       ztMovLoteLimpoPesoSaida.Value:=0;
       ztMovLoteLimpoPesoEntrada.Value:=strToFloat(edtPeso.Text);
       ztMovLoteLimpoStatus.Value:='Ativo';
       ztMovLoteLimpo.Post;
       ztSaldoLoteLimpo.Filtered:=False;
       ztSaldoLoteLimpo.Filter:='(IDLoteLimpo = ' + QuotedStr(dbcParaLoteLimpo.KeyValue) +')';
       ztSaldoLoteLimpo.Filtered:=True;
       ztSaldoLoteLimpo.Edit;
       ztSaldoLoteLimpoSaldo.Value:=ztSaldoLoteLimpoSaldo.Value + strToFloat(edtPeso.Text);
       ztSaldoLoteLimpo.Post;
  end;
  fPrincipal.zConn.Commit;
  except
  ztSaldoLoteLimpo.Cancel;
  ztMovLoteLimpo.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar salvar nova transação', mtError,[mbOk], 0);
  end;
  ztMovLoteLimpo.Active:=False;
  zqNovoIDMovLoteLimpo.Active:=False;
  EditarFalse;
  AplicaFiltro;
end;

function TfMovLoteLimpo.SalvarTrue:boolean;
var Erro:string;
begin
  SalvarTrue:=True;
  Erro:='';
  if (dbcCliente.KeyValue=Null) and (not (Botao='Transferir')) then
     Erro:=Erro+'-o valor do campo Cliente não é válido.'+ chr(13);
  if (dbcParaLoteLimpo.KeyValue=Null) and (Botao='Transferir') then
     Erro:=Erro+'-o valor do campo Para lote limpo não é válido.'+ chr(13);
  if (not(Botao='Transferir') and (edtHistorico.Text='')) then
     Erro:=Erro+'-o valor do campo Historico não é válido.'+ chr(13);
  if dtpData.Date=Null then
     Erro:=Erro+'-o valor do campo Historico não é válido.'+ chr(13);
  if (not(FloatTrue(edtPeso.Text,3)) or (strTofloat(edtPeso.Text)<=0) or (edtPeso.Text='')) then
     Erro:=Erro+'-o valor do campo Peso não é válido.'+ chr(13);
  if not(Erro = '') then
  begin
       MessageDlg(Erro, mtError,[mbOk], 0);
       SalvarTrue:=False;
  end;
end;

procedure TfMovLoteLimpo.EditarTrue();
begin
  pnFiltrar.Enabled:=False;
  pnEditar.Enabled:=True;
  if (Botao='Transferir')
  then
    begin
       dbcCliente.Enabled:=False;
       btBuscarCliente.Enabled:=False;
       edtHistorico.Enabled:=False;
       dbcParaLoteLimpo.Enabled:=True;
       btBuscaParaLoteLimpo.Enabled:=True;
  end
  else
  begin
       dbcCliente.Enabled:=True;
       btBuscarCliente.Enabled:=True;
       edtHistorico.Enabled:=True;
       dbcParaLoteLimpo.Enabled:=False;
       btBuscaParaLoteLimpo.Enabled:=False;
  end;
  pnBotaoSalvar.Enabled:=True;
  pnBotaoEditar.Enabled:=False;
  btSair.Enabled:=False;
  lbOperacao.Caption:=Botao;
  dtpData.Date:=Date;
  EditarForm:=True;
end;

procedure TfMovLoteLimpo.editarFalse();
begin
  pnFiltrar.Enabled:=True;
  pnEditar.Enabled:=False;
  pnBotaoSalvar.Enabled:=False;
  pnBotaoEditar.Enabled:=False;
  btSair.Enabled:=True;

  dbcDoLoteLimpo.KeyValue:=0;
  dbcParaLoteLimpo.KeyValue:=0;
  dbcCliente.KeyValue:=0;
  edtHistorico.Text:='';
  edtPeso.Text:='0';
  zqMovLoteLimpo.Filtered:=False;
  zqMovLoteLimpo.Filter:='(IDLoteLimpo = 0)';
  zqMovLoteLimpo.Filtered:=True;
  ztSaldoLoteLimpo.Filtered:=False;
  ztSaldoLoteLimpo.Filter:='(IDLoteLimpo = 0)';
  ztSaldoLoteLimpo.Filtered:=True;
  lbOperacao.Caption:='';
  EditarForm:=False;
end;

procedure TfMovLoteLimpo.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  FormSomenteLeitura:=False;
end;

procedure TfMovLoteLimpo.AplicaFiltro();
var temp:integer;
begin
  zqCliente.Refresh;
  zqDoLoteLimpo.Refresh;
  zqParaLoteLimpo.Refresh;
  zqMovLoteLimpo.Refresh;
  ztSaldoLoteLimpo.Refresh;
  if (dbcDOLoteLimpo.KeyValue = Null)
  then temp:=0
  else temp:=dbcDOLoteLimpo.KeyValue;
  zqMovLoteLimpo.Filtered:=False;
  zqMovLoteLimpo.Filter:='(IDLoteLimpo =' + QuotedStr(intToStr(temp)) +')';
  zqMovLoteLimpo.Filtered:=True;
  ztSaldoLoteLimpo.Filtered:=False;
  ztSaldoLoteLimpo.Filter:='(IDLoteLimpo = ' + QuotedStr(intToStr(temp)) +')';
  ztSaldoLoteLimpo.Filtered:=True;
end;

procedure TfMovLoteLimpo.btBuscaParaLoteLimpoClick(Sender: TObject);
var temp:integer;
begin
  fCadLoteLimpo:=TfCadLoteLimpo.Create(Self);
    temp:=fCadLoteLimpo.ShowModal;
    zqParaLoteLimpo.Refresh;
    fCadLoteLimpo.Destroy;
    dbcParaLoteLimpo.KeyValue:=temp;
end;

procedure TfMovLoteLimpo.btBuscaDoLoteLimpoClick(Sender: TObject);
var temp:integer;
begin
  fCadLoteLimpo:=TfCadLoteLimpo.Create(Self);
    temp:=fCadLoteLimpo.ShowModal;
    zqDoLoteLimpo.Refresh;
    fCadLoteLimpo.Destroy;
    dbcDoLoteLimpo.KeyValue:=temp;
    pnBotaoEditar.Enabled:=True;
    AplicaFiltro;
end;

procedure TfMovLoteLimpo.btBuscarClienteClick(Sender: TObject);
var temp:integer;
begin
  fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    zqCliente.Refresh;
    fCadCliente.Destroy;
    dbcCliente.KeyValue:=temp;
end;

procedure TfMovLoteLimpo.dbcDoLoteLimpoChange(Sender: TObject);
begin
  AplicaFiltro;
  if (dbcDOLoteLimpo.KeyValue = Null) then
  begin
       pnBotaoEditar.Enabled:=False;
       Exit;
  end;
  pnBotaoEditar.Enabled:=True;
  zqParaLoteLimpo.Filtered:=False;
  zqParaLoteLimpo.Filter:='((IDLoteLimpo <>' + QuotedStr(dbcDOLoteLimpo.KeyValue) +') and ((Status = '+QuotedStr('Ativo')+') or (Status = ' + QuotedStr('Protegido') + ')))';
  zqParaLoteLimpo.Filtered:=True;
  zqMovLoteLimpo.Last;
end;

end.

