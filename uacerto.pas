unit uAcerto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, Variants, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  DBCtrls, StdCtrls, Buttons, DBDateTimePicker, ZDataset, ZAbstractRODataset,
  ZConnection;

type

  { TfAcerto }

  TfAcerto = class(TForm)
    btAbrirAcerto: TBitBtn;
    btBuscarClienteCC: TButton;
    btNovoAcerto: TBitBtn;
    btSair: TBitBtn;
    btFecharAcerto: TBitBtn;
    btCancelarCC: TBitBtn;
    btEditarCC: TBitBtn;
    btTransAcerto: TBitBtn;
    btNovoCC: TBitBtn;
    btSalvarCC: TBitBtn;
    btTransCC: TButton;
    dbcCliente: TDBLookupComboBox;
    dsClienteSaldo: TDataSource;
    dbnAcerto: TDBNavigator;
    dbStatus: TDBText;
    dsCCAcerto: TDataSource;
    dsClienteBox: TDataSource;
    dsAcertoSaldo: TDataSource;
    dbDataCC: TDBDateTimePicker;
    dbeSaldoAcerto: TDBEdit;
    dbeSaldoCC: TDBEdit;
    DBEdit3: TDBEdit;
    dbeEntrada: TDBEdit;
    dbeHistorico: TDBEdit;
    dbeSaida: TDBEdit;
    dbgAcerto: TDBGrid;
    dbgContaCorrente: TDBGrid;
    dbnCC: TDBNavigator;
    dbnAcertoGrid: TDBNavigator;
    Label1: TLabel;
    pnFiltroCliente: TPanel;
    pnTitulo: TPanel;
    pnTrans: TPanel;
    pnAcertoBotao: TPanel;
    rgFiltroAcerto: TRadioGroup;
    rgFiltroCliente: TRadioGroup;
    rgStatusCC: TDBRadioGroup;
    dsCC: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnAcerto: TPanel;
    pnAcertoEditar: TPanel;
    pnAcertoGrid: TPanel;
    pnAcertoGridSaldo: TPanel;
    pnAcertoTitulo: TPanel;
    pnCCBotaoEditar: TPanel;
    pnCCBotaoSalvar: TPanel;
    pnCCEditarComponentes: TPanel;
    pnContaCorrente: TPanel;
    pnContaCorrenteEditar: TPanel;
    pnContaCorrenteGrid: TPanel;
    pnContaCorrenteGridRodape: TPanel;
    pnContaCorrenteTitulo: TPanel;
    pnTela: TPanel;
    zqCCAcertoData: TZDateField;
    zqCCAcertoEntrada: TZDoubleField;
    zqCCAcertoHistorico: TZRawStringField;
    zqCCAcertoIDAcerto: TZInt64Field;
    zqCCAcertoIDCliente: TZInt64Field;
    zqCCAcertoIDContaCorrente: TZInt64Field;
    zqCCAcertoSaida: TZDoubleField;
    zqCCAcertoStatus: TZRawStringField;
    zqCC: TZQuery;
    zqCCData: TZDateField;
    zqCCEntrada: TZDoubleField;
    zqCCHistorico: TZRawStringField;
    zqCCIDAcerto: TZInt64Field;
    zqCCIDCliente: TZInt64Field;
    zqCCIDContaCorrente: TZInt64Field;
    zqCCSaida: TZDoubleField;
    zqCCStatus: TZRawStringField;
    zqClienteBoxIDPrincipal: TZIntegerField;
    zqClienteBoxRazao: TZRawStringField;
    zqClienteBoxSALDOCC: TZDoubleField;
    zqNovoIDAcertoID: TZInt64Field;
    zqNovoIDCC: TZQuery;
    zqNovoIDCCID: TZInt64Field;
    zqCCAcerto: TZQuery;
    zqNovoIDAcerto: TZQuery;
    zqClienteBox: TZQuery;
    zqAcertoSaldo: TZQuery;
    zqAcertoSaldoIDAcerto: TZIntegerField;
    zqAcertoSaldoIDCliente: TZIntegerField;
    zqAcertoSaldoSaldoAcerto: TZDoubleField;
    zqAcertoSaldoStatus: TZRawStringField;
    ztClienteSaldo: TZTable;
    ztClienteSaldoIDCliente: TLongintField;
    ztClienteSaldoSaldoContaCorrente: TFloatField;
    procedure btAbrirAcertoClick(Sender: TObject);
    procedure btBuscarClienteCCClick(Sender: TObject);
    procedure btCancelarCCClick(Sender: TObject);
    procedure btEditarCCClick(Sender: TObject);
    procedure btFecharAcertoClick(Sender: TObject);
    procedure btNovoAcertoClick(Sender: TObject);
    procedure btNovoCCClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarCCClick(Sender: TObject);
    procedure btTransAcertoClick(Sender: TObject);
    procedure btTransCCClick(Sender: TObject);
    procedure dbcClienteChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rgFiltroAcertoClick(Sender: TObject);
    procedure rgFiltroClienteClick(Sender: TObject);
    procedure AplicaFiltroGrid;
    procedure AplicaFiltroClienteBox;
    procedure EditarTrueCC;
    procedure EditarFalseCC;
    function SalvarTrueCC:Boolean;
    procedure StatusBotoesAcertoAberto;
    procedure AbreTabelas;

    procedure zqAcertoSaldoAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  fAcerto: TfAcerto;

implementation

uses uCadCliente, UPrincipal, uFuncoes;

{$R *.lfm}

{ TfAcerto }

procedure TfAcerto.zqAcertoSaldoAfterScroll(DataSet: TDataSet);
begin
      if (zqAcertoSaldo.RecordCount>1) then                 // só atribui IDCliente se
         dbcCliente.KeyValue:=zqAcertoSaldoIDCliente.Value; //existir pelo menos um Acerto
      ztClienteSaldo.Locate('IDCliente',zqAcertoSaldoIDCliente.Value,[]);
      AplicaFiltroGrid;
      if zqAcertoSaldoStatus.Value='Fechado' then begin
           btTransAcerto.Enabled:=False;
           btTransCC.Enabled:=False;
           btAbrirAcerto.Enabled:=True;
           btFecharAcerto.Enabled:=False;
      end;
      if zqAcertoSaldoStatus.Value='Aberto' then begin
           StatusBotoesAcertoAberto;
      end;
      if zqAcertoSaldoStatus.Value='Protegido' then begin
           btTransAcerto.Enabled:=False;
           btTransCC.Enabled:=False;
           btAbrirAcerto.Enabled:=False;
           btFecharAcerto.Enabled:=False;
      end;
end;

procedure TfAcerto.AbreTabelas;
begin
  ztClienteSaldo.Open;
   zqClienteBox.Open;
   zqCC.Open;
   zqCCAcerto.Open;
   zqAcertoSaldo.Open;
   zqNovoIDAcerto.Active:=True;
end;

procedure TfAcerto.FormShow(Sender: TObject);
begin
   AbreTabelas;
   EditarFalseCC;
   AplicaFiltroClienteBox;
   ztClienteSaldo.Locate('IDCliente',0,[]);
   rgFiltroCliente.ItemIndex:=1;
   rgFiltroAcerto.ItemIndex:=0;
   zqAcertoSaldo.Last;
   pnAcertoBotao.Enabled:=False;
   pnCCBotaoEditar.Enabled:=False;
   SomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
end;

procedure TfAcerto.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     ztClienteSaldo.Close;
     zqClienteBox.Close;
     zqCC.Close;
     zqCCAcerto.Close;
     zqAcertoSaldo.Close;
end;

procedure TfAcerto.rgFiltroClienteClick(Sender: TObject);
begin
  if rgFiltroCliente.ItemIndex=0 then
     btBuscarClienteCC.Enabled:=False
  else
     btBuscarClienteCC.Enabled:=True;
  EditarFalseCC;
    AplicaFiltroClienteBox;
  dbcCliente.KeyValue:=0;
  dbcClienteChange(dbcCliente);
end;

procedure TfAcerto.rgFiltroAcertoClick(Sender: TObject);
begin
   zqAcertoSaldo.Filtered:=False;
   if (rgFiltroAcerto.ItemIndex=0)then begin
       pnFiltroCliente.Enabled:=True;
       zqAcertoSaldo.Filter:='(IDCliente = '+QuotedStr(intTostr(dbcCliente.KeyValue))+')';
       zqAcertoSaldo.Filtered:=True;
   end else begin
       pnFiltroCliente.Enabled:=False;
       rgFiltroCliente.ItemIndex:=1;
       zqAcertoSaldo.Filter:='IDCliente > 0';
       zqAcertoSaldo.Filtered:=True;
   end;
   zqAcertoSaldo.Last;
   dbcCliente.KeyValue:=zqAcertoSaldoIDCliente.Value;
   if dbcCliente.KeyValue<1 then begin  //não permite criar acerto com cliente 0
      pnAcertoBotao.Enabled:=False;
      pnCCBotaoEditar.Enabled:=False;
   end
   else begin
      pnAcertoBotao.Enabled:=True;
      pnCCBotaoEditar.Enabled:=True;
   end;
   AplicaFiltroGrid;
end;

procedure TfAcerto.btBuscarClienteCCClick(Sender: TObject);
Var temp:integer;
begin
  fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    fCadCliente.Destroy;
    dbcCliente.KeyValue:=temp;
    ztClienteSaldo.Locate('IDCliente',dbcCliente.KeyValue,[]);
    AplicaFiltroGrid;
    pnCCBotaoEditar.Enabled:=True;
    pnAcertoBotao.Enabled:=True;
    zqAcertoSaldo.Last;

end;
 
procedure TfAcerto.btNovoAcertoClick(Sender: TObject);
var temp:array of variant;
    IDCliente:integer;
begin

   if not(MessageDlg('Você deseja realmente adicionar novo Acerto?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes)
  then  Exit;
  IDCliente:=dbcCliente.KeyValue;
  SetLength(temp, 2);
  temp[0]:= IDCliente;
  temp[1]:= 'Aberto';
  if (zqAcertoSaldo.Locate('IDCliente;Status',temp,[]))
  then begin
    MessageDlg('Já existe um acerto aberto para esse Cliente.', mtError,[mbOk], 0);
    exit;
  end;
  try
  fPrincipal.zConn.StartTransaction;
  zqAcertoSaldo.Append;
  zqAcertoSaldoIDAcerto.Value:=zqNovoIDAcertoID.Value+1;
  zqAcertoSaldoIDCliente.Value:=IDCliente;
  zqAcertoSaldoSaldoAcerto.Value:=0;
  zqAcertoSaldoStatus.Value:='Aberto';
  zqAcertoSaldo.Post;
  fPrincipal.zConn.Commit;
  zqNovoIDAcerto.Refresh;
  except
  zqAcertoSaldo.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar criar Acerto.', mtError,[mbOk], 0);
  end;
  dbcCliente.KeyValue:=IDCliente;
  AplicaFiltroGrid;
  zqAcertoSaldo.Last;
  StatusBotoesAcertoAberto;
end;

procedure TfAcerto.btAbrirAcertoClick(Sender: TObject);
var Cliente:integer;
begin
  try
  fPrincipal.zConn.StartTransaction;
  zqAcertoSaldo.Edit;
  zqAcertoSaldoStatus.Value:='Aberto';
  zqAcertoSaldo.Post;
  fPrincipal.zConn.Commit;
  AplicaFiltroGrid;
  statusBotoesAcertoAberto;
  Except
  zqAcertoSaldo.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar abrir o Acerto', mtError,[mbOk], 0);
  end;
end;

procedure TfAcerto.btFecharAcertoClick(Sender: TObject);
begin
  if (zqAcertoSaldoSaldoAcerto.Value<>0) and (zqAcertoSaldoSaldoAcerto.Value<>(-0.0)) then begin
     MessageDlg('Erro ao tentar fechar o Acerto, o saldo tem que ser zero.', mtError,[mbOk], 0);
     exit;
  end;
  try
  fPrincipal.zConn.StartTransaction;
  zqAcertoSaldo.Edit;
  zqAcertoSaldoStatus.Value:='Fechado';
  zqAcertoSaldo.Post;
  fPrincipal.zConn.Commit;
  btAbrirAcerto.Enabled:=True;
  btFecharAcerto.Enabled:=False;
  btTransAcerto.Enabled:=False;
  btTransCC.Enabled:=False;
  AplicaFiltroGrid;
  statusBotoesAcertoAberto;
  Except
  zqAcertoSaldo.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar fechar o Acerto.', mtError,[mbOk], 0);
  end;
end;

procedure TfAcerto.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfAcerto.btNovoCCClick(Sender: TObject);
begin
  EditarTrueCC;
  zqCC.Active:=True;
  ztClienteSaldo.Active:=True;
  zqNovoIDCC.Active:=True;
  fPrincipal.zConn.StartTransaction;
  zqCC.Append;
  ztClienteSaldo.Locate('IDCliente',dbcCliente.KeyValue,[]);
  ztClienteSaldo.Edit;
  zqCCIDContaCorrente.Value:=zqNovoIDCCID.Value+1;
  zqNovoIDCC.Active:=False;
  zqCCIDAcerto.Value:=0;
  zqCCIDCliente.Value:=dbcCliente.KeyValue;
  zqCCData.Text:=DateToStr(Date);
  zqCCEntrada.Value:=0;
  zqCCSaida.Value:=0;
  rgStatusCC.ItemIndex:=0;
end;

procedure TfAcerto.btEditarCCClick(Sender: TObject);
begin
  fPrincipal.zConn.StartTransaction;
  EditarTrueCC;
  zqCC.Edit;
  ztClienteSaldo.Edit;
  ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value-zqCCEntrada.Value;
  ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value+zqCCSaida.Value;
end;

procedure TfAcerto.btCancelarCCClick(Sender: TObject);
begin
   EditarFalseCC;
   zqClienteBox.Cancel;
   zqCC.Cancel;
   fPrincipal.zConn.Rollback;
end;

procedure TfAcerto.btSalvarCCClick(Sender: TObject);
var IDCliente:integer;
    temp:array of variant;
begin
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes)
  then  Exit;
  if Not(SalvarTrueCC)
  then Exit;
  try
  if Not(zqCCStatus.Value='Cancelado')
  then begin
            ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value+zqCCEntrada.Value;
            ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value-zqCCSaida.Value;
       end;
  zqCC.Post;
  ztClienteSaldo.Post;
  fPrincipal.zConn.Commit;
  IDCliente:=dbcCliente.KeyValue;
  AbreTabelas;
  AplicaFiltroClienteBox;
  dbcCliente.KeyValue:=IDCliente;
  zqClienteBox.Locate('IDPrincipal',dbcCliente.KeyValue,[]);
  AplicaFiltroGrid;
  SetLength(temp, 2);
  temp[0]:= IDCliente;
  temp[1]:= 'Aberto';
  if not(zqAcertoSaldo.Locate('IDCliente;Status',temp,[])) then
     zqAcertoSaldo.Last;
  StatusBotoesAcertoAberto;
  except
  zqClienteBox.Cancel;
  zqCC.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar salvar nova transação.', mtError,[mbOk], 0);
  end;
  EditarFalseCC;
end;

procedure TfAcerto.btTransAcertoClick(Sender: TObject);
var temp:array of variant;
begin
  try
  fPrincipal.zConn.StartTransaction;
  ztClienteSaldo.Edit;
  ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value-zqCCEntrada.Value;
  ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value+zqCCSaida.Value;
  ztClienteSaldo.Post;
  zqAcertoSaldo.Edit;
  zqAcertoSaldoSaldoAcerto.Value:=zqAcertoSaldoSaldoAcerto.Value+zqCCEntrada.Value;
  zqAcertoSaldoSaldoAcerto.Value:=zqAcertoSaldoSaldoAcerto.Value-zqCCSaida.Value;
  zqAcertoSaldo.Post;
  zqCC.Edit;
  zqCCIDAcerto.Value:=zqAcertoSaldoIDAcerto.Value;
  zqCC.Post;
  fPrincipal.zConn.Commit;
  AplicaFiltroGrid;
  SetLength(temp, 2);
  temp[0]:= dbcCliente.KeyValue;
  temp[1]:= 'Aberto';
  if not(zqAcertoSaldo.Locate('IDCliente;Status',temp,[])) then
     zqAcertoSaldo.Last;
  except
  zqAcertoSaldo.Cancel;
  ztClienteSaldo.Cancel;
  zqCc.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar transferir registro.', mtError,[mbOk], 0);
  end;
  ztClienteSaldo.Refresh;
  zqAcertoSaldo.Refresh;
  zqCC.Refresh;
  zqCCAcerto.Refresh;
  StatusBotoesAcertoAberto;
end;

procedure TfAcerto.btTransCCClick(Sender: TObject);
var Cliente:integer;
    temp:array of variant;
begin
  try
  fPrincipal.zConn.StartTransaction;
  ztClienteSaldo.Edit;
  ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value+zqCCAcertoEntrada.Value;
  ztClienteSaldoSaldoContaCorrente.Value:=ztClienteSaldoSaldoContaCorrente.Value-zqCCAcertoSaida.Value;
  ztClienteSaldo.Post;
  zqAcertoSaldo.Edit;
  zqAcertoSaldoSaldoAcerto.Value:=zqAcertoSaldoSaldoAcerto.Value-zqCCAcertoEntrada.Value;
  zqAcertoSaldoSaldoAcerto.Value:=zqAcertoSaldoSaldoAcerto.Value+zqCCAcertoSaida.Value;
  zqAcertoSaldo.Post;
  zqCCAcerto.Edit;
  zqCCAcertoIDAcerto.Value:=0;
  zqCCAcerto.Post;
  fPrincipal.zConn.Commit;
  Cliente:=dbcCliente.KeyValue;
  dbcCliente.KeyValue:=Cliente;
  AplicaFiltroGrid;
  SetLength(temp, 2);
  temp[0]:= Cliente;
  temp[1]:= 'Aberto';
  if not(zqAcertoSaldo.Locate('IDCliente;Status',temp,[])) then
     zqAcertoSaldo.Last;
  except
  zqAcertoSaldo.Cancel;
  ztClienteSaldo.Cancel;
  zqCCAcerto.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar transferir registro.', mtError,[mbOk], 0);
  end;
  ztClienteSaldo.Refresh;
  zqAcertoSaldo.Refresh;
  zqCC.Refresh;
  zqCCAcerto.Refresh;
  StatusBotoesAcertoAberto;
end;

function TfAcerto.SalvarTrueCC:Boolean;
var Erro:string;
begin
  SalvarTrueCC:=True;
  Erro:='';
  if dbeHistorico.Text=''
  then Erro:=Erro+'-Ocampo Histórico não pode ficar vazio.'+chr(13);
  if not(FloatTrue(dbeEntrada.Text,2)) or(dbeEntrada.Text='') or (zqCCEntrada.Value<0)
  then Erro:=Erro+'-O Campo entrada é inválido.'+chr(13);
  if not(FloatTrue(dbeSaida.Text,2)) or(dbeSaida.Text='') or (zqCCSaida.Value<0)
  then Erro:=Erro+'-O Campo Saída é inválido.'+chr(13);
  if (zqCCEntrada.Value=0) and (zqCCSaida.Value=0)
  then Erro:=Erro+'-O campo Entrada e o campo Saída não podem ter o valor zero ao mesmo tempo.'+chr(13);
  if (zqCCEntrada.Value>0) and (zqCCSaida.Value>0)
  then Erro:=Erro+'-O campo Entrada e o campo Saída não podem ter o valor maior que zero ao mesmo tempo.'+chr(13);
  if not(Erro = '')
  then begin
           MessageDlg(Erro, mtError,[mbOk], 0);
           SalvarTrueCC:=False;
       end;
end;

procedure TfAcerto.dbcClienteChange(Sender: TObject);
begin
    if (dbcCliente.KeyValue<1) then begin
       zqAcertoSaldo.Filtered:=False;
       zqAcertoSaldo.Filter:='(IDCliente = 0)';  // Se cliente for zero, fica
       zqAcertoSaldo.Filtered:=True;             //somente o acerto zero .
       EditarFalseCC;
       pnCCBotaoEditar.Enabled:=False;
       pnAcertoBotao.Enabled:=False;
    end else begin
       zqAcertoSaldo.Filtered:=False;
       if (rgFiltroAcerto.ItemIndex=1)then begin
           rgFiltroCliente.ItemIndex:=1;         // Não filtra, fica todos os
           zqAcertoSaldo.Filter:='(IDCliente > 0)';   //acertos menos o zero.
           zqAcertoSaldo.Filtered:=True;
       end else begin
           zqAcertoSaldo.Filter:='(IDCliente = '+QuotedStr(intToStr(dbcCliente.KeyValue))+')';
           zqAcertoSaldo.Filtered:=True     // Fica apenas os acertos do cliente celecionado.
       end;
       zqAcertoSaldo.Last;
       pnCCBotaoEditar.Enabled:=True;
       pnAcertoBotao.Enabled:=True;
    end;
    ztClienteSaldo.Locate('IDCliente',dbcCliente.KeyValue,[]);
    AplicaFiltroGrid;
    StatusBotoesAcertoAberto;
end;

procedure TfAcerto.AplicaFiltroClienteBox;
begin
     zqClienteBox.Refresh;
     zqClienteBox.Filtered:=False;
     if (rgFiltroCliente.ItemIndex = 0)
     then zqClienteBox.Filter:='(SaldoCC <> 0) or ((SaldoCC = 0) and (IDPrincipal = 0))'
     else zqClienteBox.Filter:='';
     zqClienteBox.Filtered:=True;
end;

procedure TfAcerto.AplicaFiltroGrid;
var TempClientebox:integer;
begin
  if dbcCliente.KeyValue=null then
     dbcCliente.KeyValue:=0;
  zqCC.Filtered:=false;
  zqCCAcerto.Filtered:=False;
  if (dbcCliente.KeyValue < 1)then begin
       zqCC.Filter:='(IDCliente = 0)';
       zqCCAcerto.Filter:='(IDCliente = 0)';
  end else begin
       zqCC.Filter:='((IDAcerto = 0) and (Status <> '+QuotedStr('Cancelado')+
          ') and (IDCliente = '+QuotedStr(intTostr(dbcCliente.KeyValue))+'))';
       zqCCAcerto.Filter:='(IDAcerto <> 0) and ((IDAcerto = '+ QuotedStr(intToStr(zqAcertoSaldoIDAcerto.Value)) +
          ') and (Status <> '+QuotedStr('Cancelado')+') and (IDCliente = '+
          QuotedStr(intTostr(dbcCliente.KeyValue))+'))';
  end;
  zqCCAcerto.Filtered:=True;
  zqCC.Filtered:=True;
  ztClienteSaldo.Locate('IDCliente',dbcCliente.KeyValue,[]);
  zqCCAcerto.Last;
  zqCC.Last;
end;

procedure TfAcerto.EditarTrueCC;
begin
  pnTitulo.Enabled:=False;
  pnCCEditarComponentes.Enabled:=True;
  pnCCBotaoEditar.Enabled:=False;
  pnCCBotaoSalvar.Enabled:=True;
  pnAcertoBotao.Enabled:=False;
  dbnCC.Enabled:=False;
end;

procedure TfAcerto.EditarFalseCC;
begin
  pnTitulo.Enabled:=True;
  pnCCEditarComponentes.Enabled:=False;
  pnCCBotaoEditar.Enabled:=True;
  pnCCBotaoSalvar.Enabled:=False;
  pnAcertoBotao.Enabled:=True;
  dbnCC.Enabled:=True;
end;

procedure TfAcerto.StatusBotoesAcertoAberto;
begin
  if not(zqAcertoSaldoStatus.Value='Aberto') then begin
     btTransAcerto.Enabled:=False;
     btTransCC.Enabled:=False;
     btAbrirAcerto.Enabled:=True;
     btFecharAcerto.Enabled:=False;
     exit;
  end;

  //Acerto aberto
  btAbrirAcerto.Enabled:=False;
  btFecharAcerto.Enabled:=True;
  if (zqCCAcertoIDAcerto.Value>0)then
        btFecharAcerto.Enabled:=True
  else
  btFecharAcerto.Enabled:=False;
  if zqCC.RecordCount>0 then begin
     btEditarCC.Enabled:=True;
     btTransAcerto.Enabled:=True;
  end
  else begin
       btTransAcerto.Enabled:=False;
       btEditarCC.Enabled:=False;
  end;
  if (zqCCAcerto.RecordCount>0)then
     btTransCC.Enabled:=True
  else
      btTransCC.Enabled:=False;
end;
end.

