unit uMovLoteSacaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBCtrls, DBGrids, DBExtCtrls, Buttons, DBDateTimePicker, DateTimePicker,
  ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfMovLoteSacaria }
  TfMovLoteSacaria = class(TForm)
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    btCancelar: TBitBtn;
    btEntrada: TButton;
    btSaida: TButton;
    dbeSaldo: TDBEdit;
    dsLoteSacaria: TDataSource;
    dbcDoLoteSacaria: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    dsMovLoteSacaria: TDataSource;
    dsDoLoteSacaria: TDataSource;
    dtpData: TDateTimePicker;
    edtHistorico: TEdit;
    edtQuantidade: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbOperacao: TLabel;
    pnBotaoEditar: TPanel;
    pnBotaoSalvar: TPanel;
    pnBotao: TPanel;
    pnEditar: TPanel;
    pnFiltrar: TPanel;
    zqDoLoteSacaria: TZQuery;
    zqDoLoteSacariaIDLoteSacaria: TZInt64Field;
    zqDoLoteSacariaNomeDoLoteSacaria: TZRawStringField;
    zqDoLoteSacariaSaldo: TZDoubleField;
    zqDoLoteSacariaStatus: TZRawStringField;
    zqMovLoteSacariaData: TZDateField;
    zqMovLoteSacariaHistorico: TZRawStringField;
    zqMovLoteSacariaIDLoteSacaria: TZInt64Field;
    zqMovLoteSacariaIDMovLoteSacaria: TZInt64Field;
    zqMovLoteSacariaNome: TZRawStringField;
    zqMovLoteSacariaQuanEntrada: TZInt64Field;
    zqMovLoteSacariaQuanSaida: TZInt64Field;
    zqMovLoteSacariaStatus: TZRawStringField;
    zqNovoIDMovLoteSacariaID: TZInt64Field;
    zqMovLoteSacaria: TZQuery;
    zqNovoIDMovLoteSacaria: TZQuery;
    ztLoteSacaria: TZTable;
    ztLoteSacariaIDLoteSacaria: TZInt64Field;
    ztLoteSacariaNome: TZRawStringField;
    ztLoteSacariaSaldo: TZDoubleField;
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
    procedure btCancelarClick(Sender: TObject);
    procedure btEntradaClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btSaidaClick(Sender: TObject);
    procedure dbcDoLoteSacariaChange(Sender: TObject);
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
  fMovLoteSacaria: TfMovLoteSacaria;
  Botao:string;


implementation

uses uFuncoes, uCadCliente, uPrincipal;

{$R *.lfm}

{ TfMovLoteSacaria }

procedure TfMovLoteSacaria.FormCreate(Sender: TObject);
begin
  zqDoLoteSacaria.Active:=True;
  zqMovLoteSacaria.Active:=True;
  ztLoteSacaria.Active:=True;
  dbcDoLoteSacaria.DisplayEmpty:='';
  ztLoteSacaria.Locate('IDLoteSacaria',0,[]);
  EditarFalse;
  pnBotaoEditar.Enabled:=False;
  AplicaFiltro;
  SomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
  end;

procedure TfMovLoteSacaria.btEntradaClick(Sender: TObject);
begin
  Botao:='Entrada';
  EditarTrue;
end;

procedure TfMovLoteSacaria.btSaidaClick(Sender: TObject);
begin
  Botao:='Saida';
  EditarTrue;
end;

procedure TfMovLoteSacaria.btCancelarClick(Sender: TObject);
begin
  EditarFalse;
end;

procedure TfMovLoteSacaria.btSairClick(Sender: TObject);
begin
  zqDoLoteSacaria.Active:=False;
  zqMovLoteSacaria.Active:=False;
  Close;
end;

procedure TfMovLoteSacaria.btSalvarClick(Sender: TObject);
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
  ztMovLoteSacariaIDLoteSacaria.Value:=dbcDoLoteSacaria.KeyValue;
  ztMovLoteSacariaIDCliente.Value:=0;
  ztMovLoteSacariaData.Text:=dateToStr(dtpData.Date);
  ztLoteSacaria.Edit;
  Case Botao of
       'Entrada':Begin
                     ztMovLoteSacariaHistorico.Value:=edtHistorico.Text;
                     ztMovLoteSacariaQuanEntrada.Value:=strToInt(edtQuantidade.Text);
                     ztMovLoteSacariaQuanSaida.Value:=0;
                     ztLoteSacariaSaldo.Value:=ztLoteSacariaSaldo.Value + strToInt(edtQuantidade.Text);
                 end;
       'Saida':begin
                    ztMovLoteSacariaHistorico.Value:=edtHistorico.Text;
                    ztMovLoteSacariaQuanEntrada.Value:=0;
                    ztMovLoteSacariaQuanSaida.Value:=strToInt(edtQuantidade.Text);
                    ztLoteSacariaSaldo.Value:=ztLoteSacariaSaldo.Value - strToInt(edtQuantidade.Text);
               end;
  end;
  ztMovLoteSacariaStatus.Value:='Ativo';
  ztMovLoteSacaria.Post;
  ztLoteSacaria.Post;
  fPrincipal.zConn.Commit;
  except
  ztLoteSacaria.Cancel;
  ztMovLoteSacaria.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar salvar nova transação', mtError,[mbOk], 0);
  end;
  EditarFalse;
  AplicaFiltro;
  ztMovLoteSacaria.Active:=False;
  zqNovoIDMovLoteSacaria.Active:=False;
  ztLoteSacaria.Active:=False;
end;

function TfMovLoteSacaria.SalvarTrue:boolean;
Var Erro:string;
begin
  SalvarTrue:=True;
  Erro:='';
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

procedure TfMovLoteSacaria.EditarTrue();
begin
  pnFiltrar.Enabled:=False;
  pnEditar.Enabled:=True;
  pnBotaoSalvar.Enabled:=True;
  pnBotaoEditar.Enabled:=False;
  btSair.Enabled:=False;
  lbOperacao.Caption:=Botao;
  dtpData.Date:=Date;
end;

procedure TfMovLoteSacaria.editarFalse();
begin
  pnFiltrar.Enabled:=True;
  pnEditar.Enabled:=False;
  pnBotaoSalvar.Enabled:=False;
  btSair.Enabled:=True;
  dbcDoLoteSacaria.KeyValue:=0;
  edtHistorico.Text:='';
  edtQuantidade.Text:='0';
  zqMovLoteSacaria.Filtered:=False;
  zqMovLoteSacaria.Filter:='(IDLoteSacaria = 0)';
  zqMovLoteSacaria.Filtered:=True;
  ztLoteSacaria.Locate('IDLoteSacaria',0,[]);
  lbOperacao.Caption:='';
end;

procedure TfMovLoteSacaria.AplicaFiltro();
var temp:integer;
begin
       zqDoloteSacaria.Refresh;
       zqMovLoteSacaria.Refresh;
       ztLoteSacaria.Refresh;
       if (dbcDoLoteSacaria.KeyValue = Null) then temp:= -1
       else  temp:=dbcDoLoteSacaria.KeyValue;
       zqMovLoteSacaria.Filtered:=False;
       zqMovLoteSacaria.Filter:='(IDLoteSacaria =' + QuotedStr(intToStr(temp)) +')';
       zqMovLoteSacaria.Filtered:=True;
       zqMovLoteSacaria.Last;

end;

procedure TfMovLoteSacaria.dbcDoLoteSacariaChange(Sender: TObject);
begin

  if Not(dbcDoLoteSacaria.KeyValue > 0) then
  begin
       pnBotaoEditar.Enabled:=False;
       ztLoteSacaria.Locate('IDLoteSacaria',0,[]);
       AplicaFiltro;
       Exit;
  end;
  pnBotaoEditar.Enabled:=True;
  ztLoteSacaria.Locate('IDLoteSacaria',dbcDoLoteSacaria.KeyValue,[]);
  AplicaFiltro;
end;

procedure TfMovLoteSacaria.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SomenteLeitura:=False;
end;

end.

