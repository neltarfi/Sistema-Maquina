unit uRomSaidaCoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, memds, fpjsondataset, Forms, Controls,
  Graphics, Dialogs, DBCtrls, DBExtCtrls, StdCtrls, DBGrids, ExtCtrls, MaskEdit,
  ZDataset, ZAbstractRODataset;

type

  { TfRomSaidaCoco }

  TfRomSaidaCoco = class(TForm)
    btAdicionar: TButton;
    btBuscaNome: TButton;
    btCancelar: TButton;
    btCancelarReg: TButton;
    btSair: TButton;
    btEscluir: TButton;
    btSalvar: TButton;
    btTransfereSaldo: TButton;
    edtPreco: TEdit;
    edtPesoComValor: TEdit;
    edtPesoSemValor: TEdit;
    edtRenda: TEdit;
    dsmItensLoteCoco: TDataSource;
    dbcCliente: TDBLookupComboBox;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    dsLoteCoco: TDataSource;
    dsCliente: TDataSource;
    dsRomSaidaCoco: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    edtPesoCoco: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label25: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtValorTotal: TMaskEdit;
    mItensLoteCoco: TMemDataset;
    mItensLoteCocoIDLoteCoco: TLongintField;
    mItensLoteCocoPesoComValor: TLongintField;
    mItensLoteCocoPesoSemValor: TLongintField;
    mItensLoteCocoPreco: TCurrencyField;
    mItensLoteCocoRenda: TLongintField;
    mItensLoteCocoSacoKg: TStringField;
    mItensLoteCocoValorTotal: TCurrencyField;
    Panel1: TPanel;
    PanelAdicionaItens: TPanel;
    Panel3: TPanel;
    PanelAdicionaValor: TPanel;
    rgSacoKg: TRadioGroup;
    ztCliente: TZTable;
    ztLoteCoco: TZTable;
    ztClienteIDCliente: TZInt64Field;
    ztClienteRazao: TZRawStringField;
    ztLoteCocoIDLoteCoco: TZInt64Field;
    ztLoteCocoNomeLoteCoco: TZRawStringField;
    ztLoteCocoSafra: TZRawStringField;
    ztLoteCocoSaldoCoco: TZDoubleField;
    ztLoteCocoStatus: TZRawStringField;
    ztLoteCocoTulha: TZRawStringField;
    ztRomSaidaCoco: TZTable;
    ztRomSaidaCocoData: TZDateField;
    ztRomSaidaCocoIDCliente: TZInt64Field;
    ztRomSaidaCocoIDRomSaidaCoco: TZInt64Field;
    ztRomSaidaCocoObs: TZRawCLobField;
    ztRomSaidaCocoPesoComValor: TZInt64Field;
    ztRomSaidaCocoPesoSemValor: TZInt64Field;
    ztRomSaidaCocoValor: TZDoubleField;
    procedure btAdicionarClick(Sender: TObject);
    procedure btBuscaNomeClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btTransfereSaldoClick(Sender: TObject);
    procedure edtPesoComValorChange(Sender: TObject);
    procedure edtPesoComValorExit(Sender: TObject);
    procedure edtPesoSemValorChange(Sender: TObject);
    procedure edtPesoSemValorExit(Sender: TObject);
    procedure edtPrecoChange(Sender: TObject);
    procedure edtPrecoExit(Sender: TObject);
    procedure edtRendaChange(Sender: TObject);
    procedure edtRendaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EditarTrue;
    procedure EditarFalse;
    procedure AtualizaStatusBotao;
    procedure CalculaItens;
    procedure LimpaItens;
    procedure LimpaValor;
    procedure rgSacoKgSelectionChanged(Sender: TObject);
  private

  public

  end;

var
  fRomSaidaCoco: TfRomSaidaCoco;
  SaidaCocoModoEdicao:boolean;
  PesoCoco:integer;

implementation

uses uPrincipal, uCadCliente, uMovCoco, uFuncoes;

{$R *.lfm}

{ TfRomSaidaCoco }

procedure TfRomSaidaCoco.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfRomSaidaCoco.btTransfereSaldoClick(Sender: TObject);
begin
  PanelAdicionaItens.Enabled:=True;
  PesoCoco:=strToInt(ztLoteCocoSaldoCoco.Text);
  edtPesoCoco.Text:=floatToStr(PesoCoco);
  Panel1.Enabled:=False;
  btTransfereSaldo.Enabled:=False;
  LimpaValor;

end;

procedure TfRomSaidaCoco.edtPesoComValorChange(Sender: TObject);
begin
  AceitaInteiro(edtPesoComValor);
end;

procedure TfRomSaidaCoco.edtPesoComValorExit(Sender: TObject);
begin
  CalculaItens;
end;

procedure TfRomSaidaCoco.edtPesoSemValorChange(Sender: TObject);
begin
  AceitaInteiro(edtPesoSemValor);
end;

procedure TfRomSaidaCoco.edtPesoSemValorExit(Sender: TObject);
begin
  CalculaItens;
end;

procedure TfRomSaidaCoco.edtPrecoChange(Sender: TObject);
begin
  AceitaDecimal(edtPreco);
end;

procedure TfRomSaidaCoco.edtPrecoExit(Sender: TObject);
begin
  CalculaItens;
end;

procedure TfRomSaidaCoco.edtRendaChange(Sender: TObject);
begin
  AceitaInteiro(edtRenda);
end;

procedure TfRomSaidaCoco.edtRendaExit(Sender: TObject);
begin
  CalculaItens;
end;

procedure TfRomSaidaCoco.btBuscaNomeClick(Sender: TObject);
Var temp:integer;
begin
  fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    fCadCliente.Destroy;
    ztCliente.Refresh;
    dbcCliente.KeyValue:=temp;
end;

procedure TfRomSaidaCoco.btAdicionarClick(Sender: TObject);
var Erro:string;
begin
  Erro:='';
  if strToInt(edtRenda.Text)<1 then
     Erro:='-O campo da Renda não pode ficar vazio' + chr(13);
  if (strToInt(edtPesoSemValor.Text)<1) and (strToInt(edtPesoComValor.Text)<1) then
     Erro:= Erro+'-Os campos Peso sem valor e Peso com valor não podem ficar zerados ao menmo tempo'+chr(13);
  if (strToInt(edtPesoComValor.Text)>0) and (strToInt(edtPreco.Text)=0) then
     Erro:= Erro+'-O campo Preço não pode ser zero';
  if not (Erro ='') then begin
     showMessage(Erro);
     Exit;
  end;
  Panel1.Enabled:=True;
  btTransfereSaldo.Enabled:=True;
  AtualizaStatusBotao;
  mItensLoteCoco.Append;
  mItensLoteCocoIDLoteCoco.Value:=ztLoteCocoIDLoteCoco.Value;

  mItensLoteCoco.Post;
  AtualizaStatusBotao;
  PanelAdicionaItens.Enabled:=False;
  LimpaItens;
  edtPesoCoco.Text:='0';
end;

procedure TfRomSaidaCoco.btCancelarClick(Sender: TObject);
begin
  Panel1.Enabled:=True;
  PanelAdicionaItens.Enabled:=False;
  btTransfereSaldo.Enabled:=True;
  AtualizaStatusBotao;
  Limpaitens;
  edtPesoCoco.Text:='0';
end;

procedure TfRomSaidaCoco.FormClose(Sender: TObject;
var CloseAction: TCloseAction);
begin
      ztCliente.Close;
      ztLoteCoco.Close;
      ztRomSaidaCoco.Close;
      mItensLoteCoco.Close;
end;

procedure TfRomSaidaCoco.FormShow(Sender: TObject);
begin
  ztCliente.Open;
  ztLoteCoco.Open;
  ztRomSaidaCoco.Open;
  mItensLoteCoco.Open;
  case FormOperacao of
       'InserirRegistro': begin
                               AtualizaStatusBotao;
                               PanelAdicionaItens.Enabled:=False;
                               LimpaItens;
                               PanelAdicionaValor.Enabled:=False;
                               //fPrincipal.zConn.StartTransaction;
                               //ztRomSaidaCoco.Append;
                               EditarTrue;
                          end;

       'VisualizarRegistro': begin
                                   ztRomSaidaCoco.Locate('IDRomSaidaCoco',
                                   fMovCoco.ztMovCocoIDRomSaidaCoco.Value,[]);
                                   EditarFalse;
                               end;

  end;
end;

procedure TfRomSaidaCoco.EditarTrue;
begin
  SaidaCocoModoEdicao:=True;

end;

procedure TfRomSaidaCoco.EditarFalse;
begin
  SaidaCocoModoEdicao:=False;
end;

procedure TfRomSaidaCoco.AtualizaStatusBotao;
begin
  if ztLoteCoco.RecordCount>0 then
     btTransfereSaldo.Enabled:=True
  else
     btTransfereSaldo.Enabled:=False;
end;

procedure TfRomSaidaCoco.CalculaItens;
begin
     if edtPesoSemValor.Text='' then edtPesoSemValor.Text:='0';
     if edtRenda.Text='' then edtRenda.Text:='0';
     if edtPesoComValor.Text='' then edtPesoComValor.Text:='0';
     if edtPreco.Text='' then edtPreco.Text:='0';
     edtPesoCoco.Text := IntToStr(PesoCoco-strToInt(edtPesoSemValor.Text)
                                   - strToInt(edtPesoComValor.Text));
     if strToInt(edtPesoCoco.Text)<0 then begin
        LimpaItens;
        edtPesoCoco.Text:=intToStr(PesoCoco);
     end;
     if (strToInt(edtPesoComValor.Text)>0) then begin
        PanelAdicionaValor.Enabled:=True;
        if rgSacoKg.ItemIndex=0 then
           edtValorTotal.Text:= floatTostr(Decimal(strToInt(edtPesoComValor.Text)*
                                (strToFloat(edtPreco.Text)/40),2))
        else
           edtValorTotal.Text:= floatTostr(Decimal(strToInt(edtPesoComValor.Text)*
                                strToFloat(edtPreco.Text)*(strToFloat(edtRenda.Text)/40000),2));
     end
     else begin
        PanelAdicionaValor.Enabled:=False;
        LimpaValor;
     end;
     if strToFloat(edtPreco.Text)<0 then
        edtPreco.Text:=FloatToStr(strToFloat(edtPreco.Text)*(-1));

end;

procedure TfRomSaidaCoco.LimpaItens;
begin
  edtPesoCoco.Text:='0';
  edtRenda.Text:='0';
  edtPesoSemValor.Text:='0';
  LimpaValor;
end;

procedure TfRomSaidaCoco.LimpaValor;
begin
  edtPesoComValor.Text:='0';
  rgSacoKg.ItemIndex:=0;
  edtPreco.Text:='0';
  edtValorTotal.Text:='0';
end;

procedure TfRomSaidaCoco.rgSacoKgSelectionChanged(Sender: TObject);
begin
  CalculaItens;
end;

end.

