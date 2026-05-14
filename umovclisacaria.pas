unit uMovCliSacaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBCtrls, DBGrids, DBExtCtrls, Buttons, DBDateTimePicker, DateTimePicker,
  ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfMovCliSacaria }
  TfMovCliSacaria = class(TForm)
    btCancelar: TBitBtn;
    btEntrada: TButton;
    btSaida: TButton;
    btBuscaCliente: TButton;
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    dbeSaldoJuta: TDBEdit;
    dsCliente: TDataSource;
    dbcParaLoteSacaria: TDBLookupComboBox;
    dbeSaldoPlastico: TDBEdit;
    dsLoteSacaria: TDataSource;
    dbcCliente: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    dsMovLoteSacaria: TDataSource;
    dsParaLoteSacaria: TDataSource;
    dtpData: TDateTimePicker;
    edtHistorico: TEdit;
    edtQuantidade: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbOperacao: TLabel;
    lbParaLoteSacaria: TLabel;
    pnBotaoEditar: TPanel;
    pnBotaoSalvar: TPanel;
    pnBotao: TPanel;
    pnEditar: TPanel;
    pnFiltrar: TPanel;
    zqClienteIDPrincipal: TZInt64Field;
    zqClienteRazao: TZRawStringField;
    zqClienteSaldoJuta: TZInt64Field;
    zqClienteSaldoPlastico: TZInt64Field;
    zqMovLoteSacariaData: TZRawStringField;
    zqMovLoteSacariaHistorico: TZRawStringField;
    zqMovLoteSacariaIDCliente: TZIntegerField;
    zqMovLoteSacariaIDLoteSacaria: TZIntegerField;
    zqMovLoteSacariaIDMovLoteSacaria: TZIntegerField;
    zqMovLoteSacariaNOME: TZRawStringField;
    zqMovLoteSacariaQuanEntrada: TZIntegerField;
    zqMovLoteSacariaQuanSaida: TZIntegerField;
    zqMovLoteSacariaStatus: TZRawStringField;
    zqNovoIDMovLoteSacariaID: TZInt64Field;
    zqParaLoteSacaria: TZQuery;
    zqMovLoteSacaria: TZQuery;
    zqNovoIDMovLoteSacaria: TZQuery;
    zqParaLoteSacariaIDLoteSacaria: TZInt64Field;
    zqParaLoteSacariaNomeParaLoteSacaria: TZRawStringField;
    zqParaLoteSacariaStatus: TZRawStringField;
    zqCliente: TZQuery;
    ztLoteSacaria: TZTable;
    ztCliente: TZTable;
    ztClienteIDCliente: TZInt64Field;
    ztClienteSaldoSacariaJuta: TZUInt64Field;
    ztClienteSaldoSacariaPlastico: TZInt64Field;
    ztLoteSacariaIDLoteSacaria: TZInt64Field;
    ztLoteSacariaNome: TZRawStringField;
    ztLoteSacariaSaldo: TZInt64Field;
    ztLoteSacariaStatus: TZRawStringField;
    ztMovLoteSacaria: TZTable;
    ztMovLoteSacariaData: TZDateField;
    ztMovLoteSacariaHistorico: TZRawStringField;
    ztMovLoteSacariaIDCliente: TZInt64Field;
    ztMovLoteSacariaIDLoteSacaria: TZInt64Field;
    ztMovLoteSacariaIDMovLoteSacaria: TZInt64Field;
    ztMovLoteSacariaQuanEntrada: TZInt64Field;
    ztMovLoteSacariaQuanSaida: TZInt64Field;
    ztMovLoteSacariaStatus: TZRawStringField;
    procedure btBuscaClienteClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btEntradaClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btSaidaClick(Sender: TObject);
    procedure dbcClienteChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure AplicaFiltro();
    procedure EditarTrue();
    procedure editarFalse();
    function SalvarTrue:boolean;

  private

  public

  end;

var
  fMovCliSacaria: TfMovCliSacaria;
  Botao:string;

implementation

uses uFuncoes, uCadCliente, uPrincipal;

{$R *.lfm}

{ TfMovCliSacaria }

procedure TfMovCliSacaria.FormCreate(Sender: TObject);
begin
  ztCliente.Active:=True;
  zqCliente.Active:=True;
  zqParaLoteSacaria.Active:=True;
  zqMovLoteSacaria.Active:=True;
  ztLoteSacaria.Active:=True;
  zqCliente.Locate('IDPrincipal',0,[]);
  EditarFalse;
  pnBotaoEditar.Enabled:=False;
  AplicaFiltro;
  SomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
  end;

procedure TfMovCliSacaria.btEntradaClick(Sender: TObject);
begin
  Botao:='Entrada';
  EditarTrue;
end;

procedure TfMovCliSacaria.btSaidaClick(Sender: TObject);
begin
  Botao:='Saida';
  EditarTrue;
end;

procedure TfMovCliSacaria.btCancelarClick(Sender: TObject);
begin
  EditarFalse;
end;

procedure TfMovCliSacaria.btSairClick(Sender: TObject);
begin
  zqCliente.Active:=False;
  zqParaLoteSacaria.Active:=False;
  zqMovLoteSacaria.Active:=False;
  Close;
end;

procedure TfMovCliSacaria.btSalvarClick(Sender: TObject);
begin
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes) then  Exit;
  if not(SalvarTrue) then Exit;
  try
  ztMovLoteSacaria.Active:=True;
  zqNovoIDMovLoteSacaria.Active:=True;
  fPrincipal.zConn.StartTransaction;
  zqNovoIDMovLoteSacaria.Refresh;
  ztMovLoteSacaria.Append;
  ztMovLoteSacariaIDMovLoteSacaria.Value:=zqNovoIDMovLoteSacariaID.Value+1;
  ztMovLoteSacariaIDLoteSacaria.Value:=dbcParaLoteSacaria.KeyValue;
  ztMovLoteSacariaIDCliente.Value:=dbcCliente.KeyValue;
  ztMovLoteSacariaData.Text:=dateToStr(dtpData.Date);
  ztCliente.Refresh;
  ztLoteSacaria.Locate('IDLoteSacaria',dbcParaLoteSacaria.KeyValue,[]);
  ztCliente.Locate('IDCliente',dbcCliente.KeyValue,[]);
  ztCliente.Edit;
  ztLoteSacaria.Edit;
  Case Botao of
       'Entrada':Begin
                     ztMovLoteSacariaHistorico.Value:=edtHistorico.Text;
                     ztMovLoteSacariaQuanEntrada.Value:=strToInt(edtQuantidade.Text);
                     ztMovLoteSacariaQuanSaida.Value:=0;
                     ztLoteSacariaSaldo.Value:=ztLoteSacariaSaldo.Value + strToInt(edtQuantidade.Text);
                     if dbcParaLoteSacaria.KeyValue = 1 then
                        ztClienteSaldoSacariaPlastico.Value:=
                           ztClienteSaldoSacariaPlastico.Value + strToInt(edtQuantidade.Text)
                     else ztClienteSaldoSacariaJuta.Value:=
                           ztClienteSaldoSacariaJuta.Value + strToInt(edtQuantidade.Text);
                 end;
       'Saida':begin
                    ztMovLoteSacariaHistorico.Value:=edtHistorico.Text;
                    ztMovLoteSacariaQuanEntrada.Value:=0;
                    ztMovLoteSacariaQuanSaida.Value:=strToInt(edtQuantidade.Text);
                    ztLoteSacariaSaldo.Value:=ztLoteSacariaSaldo.Value - strToInt(edtQuantidade.Text);
                    if dbcParaLoteSacaria.KeyValue = 1 then
                        ztClienteSaldoSacariaPlastico.Value:=
                           ztClienteSaldoSacariaPlastico.Value - strToInt(edtQuantidade.Text)
                     else ztClienteSaldoSacariaJuta.Value:=
                           ztClienteSaldoSacariaJuta.Value - strToInt(edtQuantidade.Text);
               end;
  end;
  ztMovLoteSacariaStatus.Value:='Ativo';
  ztMovLoteSacaria.Post;
  ztLoteSacaria.Post;
  ztCliente.Post;
  fPrincipal.zConn.Commit;
  except
  ztCliente.Cancel;
  ztLoteSacaria.Cancel;
  ztMovLoteSacaria.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar salvar nova transação', mtError,[mbOk], 0);
  end;
  ztCliente.Active:=False;
  ztLoteSacaria.Active:=False;
  ztMovLoteSacaria.Active:=False;
  zqNovoIDMovLoteSacaria.Active:=False;
  EditarFalse;
  AplicaFiltro;
end;

function TfMovCliSacaria.SalvarTrue:boolean;
var Erro:string;
begin
  SalvarTrue:=True;
  Erro:='';
  if (dbcParaLoteSacaria.KeyValue=0) then
     Erro:=Erro+'-o valor do campo Para lote limpo não é válido.'+ chr(13);
  if (edtHistorico.Text='') then
     Erro:=Erro+'-o valor do campo Historico não é válido.'+ chr(13);
  if dtpData.Date=Null then
     Erro:=Erro+'-o valor do campo Data não é válido.'+ chr(13);
  if (not(IntegerTrue(edtQuantidade.Text)) or
     (strToInt(edtQuantidade.Text)<=0) or (edtQuantidade.Text='')) then
     Erro:=Erro+'-o valor do Quantidade não é válido.'+ chr(13);
  if not(Erro = '') then
  begin
       MessageDlg(Erro, mtError,[mbOk], 0);
       SalvarTrue:=False;
  end;
end;

procedure TfMovCliSacaria.EditarTrue();
begin
  pnFiltrar.Enabled:=False;
  pnEditar.Enabled:=True;
  pnBotaoSalvar.Enabled:=True;
  pnBotaoEditar.Enabled:=False;
  btSair.Enabled:=False;
  lbOperacao.Caption:=Botao;
  dtpData.Date:=Date;
end;

procedure TfMovCliSacaria.editarFalse();
begin
  pnFiltrar.Enabled:=True;
  pnEditar.Enabled:=False;
  pnBotaoSalvar.Enabled:=False;
  btSair.Enabled:=True;
  dbeSaldoPlastico.Enabled:=True;
  dbeSaldoJuta.Enabled:=True;
  dbcCliente.KeyValue:= 0;
  dbcParaLoteSacaria.KeyValue:=0;
  edtHistorico.Text:='';
  edtQuantidade.Text:='0';
  zqMovLoteSacaria.Filtered:=False;
  zqMovLoteSacaria.Filter:='(IDCliente = -1)';
  zqMovLoteSacaria.Filtered:=True;
  ztLoteSacaria.Filtered:=False;
  ztLoteSacaria.Filtered:=True;
  lbOperacao.Caption:='';
end;

procedure TfMovCliSacaria.AplicaFiltro();
var temp:integer;
begin
       zqParaLoteSacaria.Refresh;
       zqCliente.Refresh;
       zqMovLoteSacaria.Refresh;
       if Not(dbcCliente.KeyValue > 0)
       then temp:= 0
       else  temp:=dbcCliente.KeyValue;
       zqMovLoteSacaria.Filtered:=False;
       zqMovLoteSacaria.Filter:='((IDCliente =' + QuotedStr(intToStr(temp)) +') and (IDCliente <> 0) and (Status = '+QuotedStr('Ativo')+'))';
       zqMovLoteSacaria.Filtered:=True;
       zqMovLoteSacaria.Last;
end;

procedure TfMovCliSacaria.btBuscaClienteClick(Sender: TObject);
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

procedure TfMovCliSacaria.dbcClienteChange(Sender: TObject);
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
end;

procedure TfMovCliSacaria.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SomenteLeitura:=False;
end;

end.

