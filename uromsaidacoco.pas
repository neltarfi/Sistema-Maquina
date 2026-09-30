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
    dsRomSaidaCocoItens: TDataSource;
    edtPreco: TEdit;
    edtPesoComValor: TEdit;
    edtPesoSemValor: TEdit;
    edtRenda: TEdit;
    dsmLoteCocoItens: TDataSource;
    dbcCliente: TDBLookupComboBox;
    DBDateEdit1: TDBDateEdit;
    dbeIDRomSaidaCoco: TDBEdit;
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
    mLoteCocoItens: TMemDataset;
    mLoteCocoItensIDLoteCoco: TLongintField;
    mLoteCocoItensPesoComValor: TLongintField;
    mLoteCocoItensPesoSemValor: TLongintField;
    mLoteCocoItensPreco: TCurrencyField;
    mLoteCocoItensRenda: TLongintField;
    mLoteCocoItensSacoKg: TStringField;
    mLoteCocoItensValorTotal: TCurrencyField;
    PanelLoteCoco: TPanel;
    PanelAdicionaItens: TPanel;
    PanelRomSaidaCoco: TPanel;
    PanelAdicionaValor: TPanel;
    rgSacoKg: TRadioGroup;
    zqNovoIDMovCocoID: TZIntegerField;
    zqNovoIDMovLoteCocoID: TZIntegerField;
    zqNovoIDRomSaidaCoco: TZQuery;
    zqNovoIDRomSaidaCocoID: TZIntegerField;
    zqNovoIDRomSaidaCocoItens: TZQuery;
    zqNovoIDRomSaidaCocoItensID: TZIntegerField;
    zqNovoIDMovCoco: TZQuery;
    zqNovoIDMovLoteCoco: TZQuery;
    ztMovLoteCoco: TZTable;
    ztMovCoco: TZTable;
    ztMovCocoDATA: TZDateField;
    ztMovCocoIDCLIENTE: TZIntegerField;
    ztMovCocoIDMOVCOCO: TZIntegerField;
    ztMovCocoIDROMENTRADACOCO: TZIntegerField;
    ztMovCocoIDROMSAIDACOCO: TZIntegerField;
    ztMovLoteCocoDATA: TZDateField;
    ztMovLoteCocoHISTORICO: TZRawStringField;
    ztMovLoteCocoIDCLIENTE: TZIntegerField;
    ztMovLoteCocoIDLOTECOCO: TZIntegerField;
    ztMovLoteCocoIDMOVLOTECOCO: TZIntegerField;
    ztMovLoteCocoIDROMENTRADACOCO: TZIntegerField;
    ztMovLoteCocoIDROMSAIDACOCO: TZIntegerField;
    ztMovLoteCocoPESOCOCOENTRADA: TZIntegerField;
    ztMovLoteCocoPESOCOCOSAIDA: TZIntegerField;
    ztMovLoteCocoSTATUS: TZRawStringField;
    ztRomSaidaCocoItens: TZTable;
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
    ztRomSaidaCocoItensIDROMSAIDACOCO: TZIntegerField;
    ztRomSaidaCocoItensIDROMSAIDACOCOITENS: TZIntegerField;
    ztRomSaidaCocoItensPESOCOMVALOR: TZIntegerField;
    ztRomSaidaCocoItensPESOSEMVALOR: TZIntegerField;
    ztRomSaidaCocoItensPRECO: TZBCDField;
    ztRomSaidaCocoItensRENDA: TZIntegerField;
    ztRomSaidaCocoItensSACOKG: TZRawStringField;
    ztRomSaidaCocoItensVALORTOTAL: TZBCDField;
    ztRomSaidaCocoObs: TZRawCLobField;
    ztRomSaidaCocoPesoComValor: TZInt64Field;
    ztRomSaidaCocoPesoSemValor: TZInt64Field;
    ztRomSaidaCocoValor: TZDoubleField;
    procedure btAdicionarClick(Sender: TObject);
    procedure btBuscaNomeClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btCancelarRegClick(Sender: TObject);
    procedure btEscluirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
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

procedure TfRomSaidaCoco.FormShow(Sender: TObject);
begin
  ztCliente.Open;
  ztRomSaidaCoco.Open;
  ztRomSaidaCocoItens.Open;
  case FormOperacao of
       'InserirRegistro': begin
                               ztLoteCoco.Open;
                               ztMovLoteCoco.Open;
                               ztMovCoco.Open;
                               zqNovoIDMovCoco.Open;
                               zqNovoIDMovLoteCoco.Open;
                               zqNovoIDRomSaidaCoco.Open;
                               zqNovoIDRomSaidaCocoItens.Open;
                               zqNovoIDRomSaidaCocoItens.Open;
                               mLoteCocoItens.Open;
                               AtualizaStatusBotao;
                               PanelAdicionaItens.Enabled:=False;
                               PanelRomSaidaCoco.Enabled:=False;
                               LimpaItens;
                               PanelAdicionaValor.Enabled:=False;
                               fPrincipal.zConn.StartTransaction;
                          end;

       'VisualizarRegistro': begin
                                  PanelRomSaidaCoco.Enabled:=False;
                                  PanelLoteCoco.Enabled:=False;
                                  PanelAdicionaItens.Enabled:=False;
                                  btCancelarReg.Enabled:=False;
                                  btSalvar.Enabled:=False;
                                  ztRomSaidaCoco.Locate('IDRomSaidaCoco',
                                  fMovCoco.ztMovCocoIDRomSaidaCoco.Value,[]);
                                  dbcCliente.KeyValue:=ztRomSaidaCocoIDCliente.Value;
                                  ztRomSaidaCocoItens.Close;
                                  DBGrid2.DataSource:=dsRomSaidaCocoItens;
                                  ztRomSaidaCocoItens.Open;
                                  ztRomSaidaCocoItens.Filtered:=False;
                                  ztRomSaidaCocoItens.Filter:='(IDRomSaidaCoco='+dbeIDRomSaidaCoco.Text+')';
                                  ztRomSaidaCocoItens.Filtered:=True;
                               end;

  end;
end;

procedure TfRomSaidaCoco.FormClose(Sender: TObject;
var CloseAction: TCloseAction);
begin
      ztCliente.Close;
      ztLoteCoco.Close;
      ztRomSaidaCoco.Close;
      ztRomSaidaCocoItens.Close;
      ztMovCoco.Close;
      zqNovoIDMovCoco.Close;
      zqNovoIDMovLoteCoco.Close;
      ztMovLoteCoco.Close;
      zqNovoIDRomSaidaCoco.Close;
      zqNovoIDRomSaidaCocoItens.Close;
      zqNovoIDRomSaidaCocoItens.Close;
      mLoteCocoItens.Close;
end;

procedure TfRomSaidaCoco.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfRomSaidaCoco.btSalvarClick(Sender: TObject);
var Erro:string;
begin
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
        [mbYes, mbNO], 0) = mrYes) then Exit;
  Erro:='';
  if ztRomSaidaCocoData.Text='' then
     Erro:='-O campo data não pode ficar vazio' + chr(13);
  if dbcCliente.KeyValue<1 then
     Erro:= Erro+'-O campo Cliente não pode ficar vazio'+chr(13);
  if not (Erro ='') then begin
     showMessage(Erro);
     Exit;
  end;
  try
  //RomSaidaCocoItens
  mLoteCocoItens.First;
  while Not(mLoteCocoItens.EOF) do begin
     zqNovoIDRomSaidaCocoItens.Refresh;
     ztRomSaidaCocoItens.Append;
     ztRomSaidaCocoItensIDRomSaidaCocoItens.Value:=zqNovoIDRomSaidaCocoItensID.Value+1;
     ztRomSaidaCocoItensIDRomSaidaCoco.Value:=ztRomSaidaCocoIDRomSaidaCoco.Value;
     ztRomSaidaCocoItensPesoSemValor.Value:=mLoteCocoItensPesoSemValor.Value;
     ztRomSaidaCocoItensPesoComValor.Value:=mLoteCocoItensPesoComValor.Value;
     ztRomSaidaCocoItensRenda.Value:=mLoteCocoItensRenda.Value;
     ztRomSaidaCocoItensSacoKg.Value:=mLoteCocoItensSacoKg.Value;
     ztRomSaidaCocoItensPreco.Value:=mLoteCocoItensPreco.Value;
     ztRomSaidaCocoItensValorTotal.Value:=mLoteCocoItensValorTotal.Value;
     ztRomSaidaCocoItens.Post;

    //MovLoteCoco
    zqNovoIDMovLoteCoco.Refresh;
    ztMovLoteCoco.Append;
    ztMovLoteCocoIDMovLoteCoco.Value:=zqNovoIDMovLoteCocoID.Value+1;
    ztMovLoteCocoIDLoteCoco.Value:=mLoteCocoItensIDLoteCoco.Value;
    ztMovLoteCocoIDRomEntradaCoco.Value:=0;
    ztMovLoteCocoIDRomSaidaCoco.Value:=ztRomSaidaCocoIDRomSaidaCoco.Value;
    ztMovLoteCocoIDCliente.Value:=dbcCliente.KeyValue;
    ztMovLoteCocoData.Value:=ztRomSaidaCocoData.Value;
    ztMovLoteCocoHistorico.Value:='Romaneio saída em coco '+IntToStr(ztRomSaidaCocoIDRomSaidaCoco.Value);
    ztMovLoteCocoPesoCocoEntrada.Value:=0;
    ztMovLoteCocoPesoCocoSaida.Value:=ztRomSaidaCocoItensPesoSemValor.Value+
                                      ztRomSaidaCocoItensPesoComValor.Value;
    ztMovLoteCocoStatus.Value:='Ativo';
    ztMovLoteCoco.Post;

    mLoteCocoItens.Next;
  end;

  //RomSaidaCoco
  ztRomSaidaCocoIDCliente.Value:=dbcCliente.KeyValue;
  ztRomSaidaCoco.Post;

  //MovCoco
  zqNovoIdMovCoco.Refresh;
  ztMovCoco.Append;
  ztMovCocoIDMovCoco.Value :=zqNovoIdMovCocoID.Value+1;
  ztMovCocoData.Value:=ztRomSaidaCocoData.Value;
  ztMovCocoIDCliente.Value:=dbcCliente.KeyValue;
  ztMovCocoIDRomEntradaCoco.Value:=0;
  ztMovCocoIDRomSaidaCoco.Value:=ztRomSaidaCocoIDRomSaidaCoco.Value;
  ztMovCoco.Post;

  fPrincipal.zConn.Commit;
  except
  fPrincipal.zConn.Rollback;
  ShowMessage('Algo deu errado com o banco de dados');
  end;
  fPrincipal.zConn.StartTransaction;
  mLoteCocoItens.First;
  while Not(mLoteCocoItens.EOF) do
     mLoteCocoItens.Delete;
  mLoteCocoItens.Refresh;
  ztLoteCoco.Refresh;
  AtualizaStatusBotao;
end;

procedure TfRomSaidaCoco.btTransfereSaldoClick(Sender: TObject);
begin
  PanelAdicionaItens.Enabled:=True;
  PesoCoco:=strToInt(ztLoteCocoSaldoCoco.Text);
  edtPesoCoco.Text:=floatToStr(PesoCoco);
  PanelLoteCoco.Enabled:=False;
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
  PanelLoteCoco.Enabled:=True;
  btTransfereSaldo.Enabled:=True;
  AtualizaStatusBotao;

  if mLoteCocoItens.RecordCount=0 then begin
     ztRomSaidaCoco.Append;
     zqNovoIDRomSaidaCoco.Refresh;
     ztRomSaidaCocoIDRomSaidaCoco.Value:=zqNovoIDRomSaidaCocoID.Value+1;
     ztRomSaidaCoco.FieldByName('Data').Value:=DATE;
  end;

  mLoteCocoItens.Append;
  mLoteCocoItensIDLoteCoco.Value:=ztLoteCocoIDLoteCoco.Value;
  mLoteCocoItensPesoSemValor.Value:=strToInt(edtPesoSemValor.Text);
  mLoteCocoItensPesoComValor.Value:=strToInt(edtPesoComValor.Text);
  mLoteCocoItensRenda.Value:=strToInt(edtRenda.Text);
  if rgSacoKg.ItemIndex=0 then
     mLoteCocoItensSacoKg.Text:='Saco'
  else
     mLoteCocoItensSacoKg.Text:='Kg';
  mLoteCocoItensPreco.Value:=strToFloat(edtPreco.Text);
  mLoteCocoItensValorTotal.Value:=strToFloat(edtValorTotal.Text);
  ztLoteCoco.Edit;
  ztLoteCocoSaldoCoco.Value:=ztLoteCocoSaldoCoco.Value-strToInt(edtPesoSemValor.Text)-
                             strToInt(edtPesoComValor.Text);
  mLoteCocoItens.Post;
  ztLoteCoco.Post;
  ztLoteCoco.Refresh;
  AtualizaStatusBotao;
  PanelAdicionaItens.Enabled:=False;
  LimpaItens;
  edtPesoCoco.Text:='0';
end;

procedure TfRomSaidaCoco.btCancelarClick(Sender: TObject);
begin
  PanelLoteCoco.Enabled:=True;
  PanelAdicionaItens.Enabled:=False;
  btTransfereSaldo.Enabled:=True;
  AtualizaStatusBotao;
  Limpaitens;
  edtPesoCoco.Text:='0';
end;

procedure TfRomSaidaCoco.btCancelarRegClick(Sender: TObject);
begin
  ztRomSaidaCoco.Cancel;
  fPrincipal.zConn.Rollback;
  fPrincipal.zConn.StartTransaction;
  ztLoteCoco.Refresh;

  while not(mLoteCocoItens.EOF) do
  begin
       mLoteCocoItens.Delete;
  end;
  AtualizaStatusBotao;
end;

procedure TfRomSaidaCoco.btEscluirClick(Sender: TObject);
begin
  if mLoteCocoItens.RecordCount>0 then begin
      ztLoteCoco.Filtered:=False;
      ztLoteCoco.Filter:='(Status = '+QuotedStr('Ativo')+')';
      ztLoteCoco.Filtered:=True;
      ztLoteCoco.Locate('IDLoteCoco',mLoteCocoItensIDLoteCoco.Value,[]);
      ztLoteCoco.Edit;
      ztLoteCocoSaldoCoco.Value:=ztLoteCocoSaldoCoco.Value+mLoteCocoItensPesoSemValor.Value+
                                 mLoteCocoItensPesoComValor.Value;
      ztLoteCoco.Post;
      ztLoteCoco.Filtered:=False;
      ztLoteCoco.Filter:='(Status='+QuotedStr('Ativo')+' and SaldoCoco>0)';
      ztLoteCoco.Filtered:=True;
      mLoteCocoItens.Delete;
      AtualizaStatusBotao;
  end;
  if mLoteCocoItens.RecordCount=0 then
     ztRomSaidaCoco.Cancel;
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

  if mLoteCocoItens.RecordCount>0 then begin
     PanelRomSaidaCoco.Enabled:=True;
     btSalvar.Enabled:=True;
     btCancelarReg.Enabled:=True;
  end
  else begin
     PanelRomSaidaCoco.Enabled:=False;
     btSalvar.Enabled:=False;
     btCancelarReg.Enabled:=False;
  end;
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

