unit uRomEntCoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, Buttons, DBExtCtrls, MaskEdit, ZDataset, ZAbstractRODataset,
  ZConnection, LCLType;

type

  { TfRomEntCoco }

  TfRomEntCoco = class(TForm)
    btCancelar: TBitBtn;
    btCancelarRom: TBitBtn;
    btImprimir: TBitBtn;
    btNovo: TBitBtn;
    btSair: TBitBtn;
    btBuscar: TButton;
    btSalvar: TBitBtn;
    dbeValor: TDBEdit;
    dsLoteCoco: TDataSource;
    dbcLoteCoco: TDBLookupComboBox;
    dsRomCompraCoco: TDataSource;
    dbePesoDepositado: TDBEdit;
    dsRomEntradaCoco: TDataSource;
    dbdData: TDBDateEdit;
    dbeValorBruto: TDBEdit;
    dbeValorFunRural: TDBEdit;
    dbeValorLivre: TDBEdit;
    dbePorcFundoRural: TDBEdit;
    dbeAliquota: TDBEdit;
    dbePesoBruto: TDBEdit;
    dbeRenda: TDBEdit;
    dbeQuanPlastico: TDBEdit;
    dbePesoPlastico: TDBEdit;
    dbeQuanJuta: TDBEdit;
    dbePesoJuta: TDBEdit;
    dbeLegenda1: TDBEdit;
    dbePorcentagem: TDBEdit;
    dbeBeberLimpo: TDBEdit;
    dbeLegenda2: TDBEdit;
    dbeImpureza: TDBEdit;
    dbeTotalPlastico: TDBEdit;
    dbeTotalJuta: TDBEdit;
    dbeDesconto1: TDBEdit;
    dbePesoPorcentagem: TDBEdit;
    dbeBeberCoco: TDBEdit;
    dbeDesconto2: TDBEdit;
    dbeSaldoCoco: TDBEdit;
    dbmObs: TDBMemo;
    dbnRomaneio: TDBNavigator;
    dbrgSacoKg: TDBRadioGroup;
    dsCliente: TDataSource;
    dbeCodRomaneio: TDBEdit;
    dbcCliente: TDBLookupComboBox;
    edtDesconto: TEdit;
    edtPesoComprado: TEdit;
    edtPropriedade: TEdit;
    edtCidade: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    zConn: TZConnection;
    zqCliente: TZQuery;
    zqClienteCidade: TZRawStringField;
    zqClienteEndereco: TZRawStringField;
    zqClienteIDCliente: TZInt64Field;
    zqClienteIDPrincipal: TZInt64Field;
    zqClienteNome: TZRawStringField;
    zqClienteSaldoContaCorrente: TZDoubleField;
    zqLoteCocoIDLoteCoco: TZInt64Field;
    zqLoteCocoNomeLoteCoco: TZRawStringField;
    zqLoteCocoStatus: TZRawStringField;
    zqNovoIDContaCorrenteID: TZInt64Field;
    zqNovoIDEstDepCocoID: TZInt64Field;
    zqNovoIDMovLoteCocoID: TZInt64Field;
    zqNovoIDMovLoteLimpoID: TZInt64Field;
    zqNovoIDRomaneioCoco: TZQuery;
    zqNovoIDRomaneioCocoID: TZInt64Field;
    zqNovoIDRomCompraCoco: TZQuery;
    zqNovoIDRomCompraCocoID: TZInt64Field;
    zqLoteCoco: TZQuery;
    zqNovoIDMovLoteCoco: TZQuery;
    zqNovoIDEstDepCoco: TZQuery;
    zqNovoIDMovLoteLimpo: TZQuery;
    zqNovoIDContaCorrente: TZQuery;
    ztContaCorrente: TZTable;
    ztContaCorrenteData: TZDateField;
    ztContaCorrenteEntrada: TZDoubleField;
    ztContaCorrenteHistorico: TZRawStringField;
    ztContaCorrenteIDAcerto: TZInt64Field;
    ztContaCorrenteIDCliente: TZInt64Field;
    ztContaCorrenteIDContaCorrente: TZInt64Field;
    ztContaCorrenteSaida: TZDoubleField;
    ztContaCorrenteStatus: TZRawStringField;
    ztLoteLimpo: TZTable;
    ztLoteLimpoIDLoteLimpo: TZInt64Field;
    ztLoteLimpoNome: TZRawStringField;
    ztLoteLimpoSaldo: TZDoubleField;
    ztLoteLimpoStatus: TZRawStringField;
    ztMovLoteCocoData: TZDateField;
    ztMovLoteCocoHistorico: TZRawStringField;
    ztMovLoteLimpo: TZTable;
    ztEstoqueDepositoCoco: TZTable;
    ztEstoqueDepositoCocoIDEstoqueDepositoCoco: TZInt64Field;
    ztEstoqueDepositoCocoIDRomEntradaCoco: TZInt64Field;
    ztEstoqueDepositoCocoPesoEntrada: TZDoubleField;
    ztEstoqueDepositoCocoPesoSaida: TZDoubleField;
    ztEstoqueDepositoCocoSaldo: TZDoubleField;
    ztEstoqueDepositoCocoStatus: TZRawStringField;
    ztMovLoteCoco: TZTable;
    ztMovLoteCocoIDCliente: TZInt64Field;
    ztMovLoteCocoIDLoteCoco: TZInt64Field;
    ztMovLoteCocoIDMovLoteCoco: TZInt64Field;
    ztMovLoteCocoIDRomEntradaCoco: TZInt64Field;
    ztMovLoteCocoIDRomSaidaCoco: TZInt64Field;
    ztMovLoteCocoPesoCocoEntrada: TZDoubleField;
    ztMovLoteCocoPesoCocoSaida: TZDoubleField;
    ztMovLoteCocoStatus: TZRawStringField;
    ztMovLoteLimpoData: TZDateField;
    ztMovLoteLimpoHistorico: TZRawStringField;
    ztMovLoteLimpoIDCliente: TZInt64Field;
    ztMovLoteLimpoIDLoteLimpo: TZInt64Field;
    ztMovLoteLimpoIDMovLoteLimpo: TZInt64Field;
    ztMovLoteLimpoPesoEntrada: TZDoubleField;
    ztMovLoteLimpoPesoSaida: TZDoubleField;
    ztMovLoteLimpoStatus: TZRawStringField;
    ztRomCompraCoco: TZTable;
    ztRomCompraCocoAliquota: TZDoubleField;
    ztRomCompraCocoData: TZDateField;
    ztRomCompraCocoHistorico: TZRawStringField;
    ztRomCompraCocoIDContaCorrente: TZInt64Field;
    ztRomCompraCocoIDRomCompraCoco: TZInt64Field;
    ztRomCompraCocoIDRomEntradaCoco: TZInt64Field;
    ztRomCompraCocoPesoCoco: TZDoubleField;
    ztRomCompraCocoPorcFundoRural: TZDoubleField;
    ztRomCompraCocoSacoKg: TZRawStringField;
    ztRomCompraCocoStatus: TZRawStringField;
    ztRomCompraCocoValor: TZDoubleField;
    ztRomCompraCocoValorBruto: TCurrencyField;
    ztRomCompraCocoValorFundoRural: TCurrencyField;
    ztRomCompraCocoValorLivre: TCurrencyField;
    ztRomEntradaCoco: TZTable;
    ztRomEntradaCocoBeberCoco: TZDoubleField;
    ztRomEntradaCocoBeberLimpo: TZDoubleField;
    ztRomEntradaCocoData: TZDateField;
    ztRomEntradaCocoDesconto1: TZDoubleField;
    ztRomEntradaCocoDesconto2: TZDoubleField;
    ztRomEntradaCocoIDCliente: TZInt64Field;
    ztRomEntradaCocoIDLoteCoco: TZInt64Field;
    ztRomEntradaCocoIDRomCompraCoco: TZInt64Field;
    ztRomEntradaCocoIDRomEntradaCoco: TZInt64Field;
    ztRomEntradaCocoImpureza: TZDoubleField;
    ztRomEntradaCocoLegenda1: TZRawStringField;
    ztRomEntradaCocoLegenda2: TZRawStringField;
    ztRomEntradaCocoObs: TZRawStringField;
    ztRomEntradaCocoPesoBruto: TZDoubleField;
    ztRomEntradaCocoPesoDepositado: TZInt64Field;
    ztRomEntradaCocoPesoJuta: TZDoubleField;
    ztRomEntradaCocoPesoPlastico: TZDoubleField;
    ztRomEntradaCocoPesoPorcentagem: TLongintField;
    ztRomEntradaCocoPorcentagem: TZDoubleField;
    ztRomEntradaCocoQuanJuta: TZDoubleField;
    ztRomEntradaCocoQuanPlastico: TZDoubleField;
    ztRomEntradaCocoRenda: TZDoubleField;
    ztRomEntradaCocoSaldoCoco: TLongintField;
    ztRomEntradaCocoStatus: TZRawStringField;
    ztRomEntradaCocoTotalJuta: TLongintField;
    ztRomEntradaCocoTotalPlastico: TLongintField;
    procedure btBuscarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure dbcClienteChange(Sender: TObject);
    procedure dbdDataExit(Sender: TObject);
    procedure dbeBeberCocoChange(Sender: TObject);
    procedure dbeBeberCocoExit(Sender: TObject);
    procedure dbeBeberLimpoExit(Sender: TObject);
    procedure dbeDesconto1Change(Sender: TObject);
    procedure dbeDesconto1Exit(Sender: TObject);
    procedure dbeDesconto2Change(Sender: TObject);
    procedure dbeDesconto2Exit(Sender: TObject);
    procedure dbeImpurezaChange(Sender: TObject);
    procedure dbeImpurezaExit(Sender: TObject);
    procedure dbePesoBrutoChange(Sender: TObject);
    procedure dbePesoBrutoExit(Sender: TObject);
    procedure dbePesoJutaExit(Sender: TObject);
    procedure dbePesoPlasticoExit(Sender: TObject);
    procedure dbePorcentagemExit(Sender: TObject);
    procedure dbePorcFundoRuralExit(Sender: TObject);
    procedure dbeQuanJutaChange(Sender: TObject);
    procedure dbeQuanJutaExit(Sender: TObject);
    procedure dbeQuanPlasticoChange(Sender: TObject);
    procedure dbeQuanPlasticoExit(Sender: TObject);
    procedure dbeRendaExit(Sender: TObject);
    procedure dbeValorExit(Sender: TObject);
    procedure edtPesoCompradoChange(Sender: TObject);
    procedure edtPesoCompradoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EntradaCocoEditarTrue;
    procedure EntradaCocoEditarFalse;
    procedure CompraCocoEditarTrue;
    procedure CompraCocoEditarFalse;
    procedure Leitura;
    procedure Gravacao;
    procedure edtDescontoChange(Sender: TObject);
    procedure edtDescontoExit(Sender: TObject);
    procedure NovoValorRegistro;
    procedure ztRomEntradaCocoAfterScroll(DataSet: TDataSet);
    procedure LocalizaEndereco;
    procedure ztRomCompraCocoCalcFields(DataSet: TDataSet);
    procedure ztRomCompraCocoSacoKgChange(Sender: TField);
    procedure ztRomEntradaCocoCalcFields(DataSet: TDataSet);
    function SalvarTrue:boolean;
    procedure SalvaCafeBeber;
    procedure SalvaMovLoteCoco(PesoCoco:Double);
    procedure CalculaPesoDepositado;
  private

  public

  end;


var
  fRomEntCoco: TfRomEntCoco;
  EntradaCocoModoEdicao:boolean;
  CompraCocoModoEdicao:boolean;
  Renda,
  SaldoCoco,
  BeberCoco,
  PesoComprado,
  BeberLimpo:double;
  IDLoteCoco,
  IDRomCompraCoco,
  IDRomEntradaCoco,
  IDCliente:integer;

implementation

uses uCadCliente, uPrincipal, uFuncoes;
{$R *.lfm}

{ TfRomEntCoco }

procedure TfRomEntCoco.FormShow(Sender: TObject);
begin
     EntradaCocoEditarFalse;
    CompraCocoEditarFalse;
    edtPesoComprado.Text:='0';
    edtDesconto.Text:='15';
    zConn.Disconnect;
    zConn.Database:=uPrincipal.CaminhoDB;
    zConn.Connect;
    zqCliente.Open;
    dbcCliente.KeyValue:=0;
    LocalizaEndereco;

    Renda:=0;
    zqNovoIDRomCompraCoco.Open;
    ztRomCompraCoco.Open;
    ztRomEntradaCoco.Open;
    Renda:=ztRomEntradaCocoRenda.Value;
    CalculaPesoDepositado;

    zqNovoIDRomaneioCoco.Open;
    zqLoteCoco.Open;
    ztLoteLimpo.Open;
    zqNovoIDMovLoteLimpo.Open;
    ztMovLoteLimpo.Open;
    zqNovoIDMovLoteCoco.Open;
    ztMovLoteCoco.Open;
    zqNovoIDEstDepCoco.Open;
    ztEstoqueDepositoCoco.Open;
    zqNovoIDContaCorrente.Open;
    ztContaCorrente.Open;
    ztRomEntradaCoco.Last;
end;

procedure TfRomEntCoco.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    if EntradaCocoModoEdicao then begin
       if CompraCocoModoEdicao then
          ztRomCompraCoco.Cancel;
       ztRomEntradaCoco.Cancel;
       zconn.Rollback;
       ztRomEntradaCoco.Refresh;
    end;
    zqCliente.Close;
    ztRomEntradaCoco.Close;
    zqNovoIDRomaneioCoco.Close;
    ztRomCompraCoco.Close;
    zqNovoIDRomCompraCoco.Close;
    zqLoteCoco.Close;
    ztLoteLimpo.Close;
    zqNovoIDMovLoteLimpo.Close;
    ztMovLoteLimpo.Close;
    zqNovoIDMovLoteCoco.Close;
    ztMovLoteCoco.Close;
    zqNovoIDEstDepCoco.Close;
    ztEstoqueDepositoCoco.Close;
    zqNovoIDContaCorrente.Close;
    ztContaCorrente.Close;
end;

procedure TfRomEntCoco.btBuscarClick(Sender: TObject);
Var temp:integer;
begin
  fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    fCadCliente.Destroy;
    zqCliente.Refresh;
    dbcCliente.KeyValue:=temp;
    LocalizaEndereco;
end;

procedure TfRomEntCoco.btCancelarClick(Sender: TObject);
begin
    if CompraCocoModoEdicao then begin
       ztRomCompraCoco.Cancel;
       CompraCocoEditarFalse;
    end;
  ztRomEntradaCoco.Cancel;
  zConn.Rollback;

  edtPesoComprado.Text:='0';

  ztRomEntradaCoco.Last;
  EntradaCocoEditarFalse;
end;

procedure TfRomEntCoco.btNovoClick(Sender: TObject);
begin
     zConn.StartTransaction;
     EntradaCocoEditarTrue;
     CompraCocoEditarFalse;
     ztRomEntradaCoco.Append;
     dbcCliente.KeyValue:=0;
     LocalizaEndereco;
     NovoValorRegistro;
end;

procedure TfRomEntCoco.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfRomEntCoco.dbcClienteChange(Sender: TObject);
begin
     LocalizaEndereco;
end;

procedure TfRomEntCoco.dbdDataExit(Sender: TObject);
begin
     ztRomEntradaCocoCalcFields(ztRomEntradaCoco);  //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbeBeberCocoChange(Sender: TObject);
begin
  if dbeBeberCoco.Text='-' then dbeBeberCoco.Text:='';
  DBAceitaInteiro(dbeBeberCoco);
end;

procedure TfRomEntCoco.dbeBeberCocoExit(Sender: TObject);
begin
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco);
end;

procedure TfRomEntCoco.dbeBeberLimpoExit(Sender: TObject);
begin
    if ztRomEntradaCocoRenda.Value>0 then begin
       ztRomEntradaCocoBeberCoco.Value:=
       Round(((ztRomEntradaCocoBeberLimpo.Value*40000)/ztRomEntradaCocoRenda.Value)/
       (1-(strToInt(edtDesconto.Text)*0.01)));
       ztRomEntradaCocoCalcFields(ztRomEntradaCoco);  //dispara o método oncalcFields
    end;
end;

procedure TfRomEntCoco.edtDescontoExit(Sender: TObject);
begin
  if (edtDesconto.Text<>'') and
     (strToInt(edtDesconto.Text)>=0) then
     ztRomEntradaCocoBeberCoco.Value:=
     Round(((ztRomEntradaCocoBeberLimpo.Value*40000)/ztRomEntradaCocoRenda.Value)/
     (1-(strToInt(edtDesconto.Text)*0.01)))
  else edtDesconto.Text:='15';
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco);  //dispara o método oncalcFields
end;

procedure TfRomEntCoco.edtDescontoChange(Sender: TObject);
begin
  AceitaInteiro(edtDesconto);
end;

procedure TfRomEntCoco.dbeDesconto1Exit(Sender: TObject);
begin
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbeDesconto1Change(Sender: TObject);
begin
   if dbeDesconto1.Text='-' then dbeDesconto1.Text:='';
   DBAceitaInteiro(dbeDesconto1);
end;

procedure TfRomEntCoco.dbeDesconto2Change(Sender: TObject);
begin
   if dbeDesconto2.Text='-' then dbeDesconto2.Text:='';
   DBAceitaInteiro(dbeDesconto2);
end;

procedure TfRomEntCoco.dbeDesconto2Exit(Sender: TObject);
begin
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbeImpurezaChange(Sender: TObject);
begin
    if dbeImpureza.Text='-' then dbeImpureza.Text:='';
    DBAceitaInteiro(dbeImpureza);
end;

procedure TfRomEntCoco.dbeImpurezaExit(Sender: TObject);
begin
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco);//dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbePesoBrutoChange(Sender: TObject);
begin
     DBAceitaInteiro(dbePesoBruto);
end;

procedure TfRomEntCoco.dbePesoBrutoExit(Sender: TObject);
begin
     ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbePesoJutaExit(Sender: TObject);
begin
    ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbePesoPlasticoExit(Sender: TObject);
begin
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbePorcentagemExit(Sender: TObject);
begin
   ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbePorcFundoRuralExit(Sender: TObject);
begin
     ztRomCompraCocoCalcFields(ztRomCompraCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbeQuanJutaChange(Sender: TObject);
begin
  DBAceitaInteiro(dbeQuanJuta);
end;

procedure TfRomEntCoco.dbeQuanJutaExit(Sender: TObject);
begin
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco);  //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbeQuanPlasticoChange(Sender: TObject);
begin
  DBAceitaInteiro(dbeQuanPlastico);
end;

procedure TfRomEntCoco.dbeQuanPlasticoExit(Sender: TObject);
begin
  ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbeRendaExit(Sender: TObject);
begin
   ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.ztRomCompraCocoSacoKgChange(Sender: TField);
begin
     ztRomCompraCocoCalcFields(ztRomCompraCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.dbeValorExit(Sender: TObject);
begin
     ztRomCompraCocoCalcFields(ztRomCompraCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.edtPesoCompradoChange(Sender: TObject);
begin
  AceitaInteiro(edtPesoComprado);
end;

procedure TfRomEntCoco.edtPesoCompradoExit(Sender: TObject);
begin
     ztRomEntradaCocoCalcFields(ztRomEntradaCoco); //dispara o método oncalcFields
end;

procedure TfRomEntCoco.EntradaCocoEditarTrue;
begin
     btNovo.Enabled:=False;
     btCancelar.Enabled:=True;
     btSalvar.Enabled:=True;
     btImprimir.Enabled:=False;
     btCancelarRom.Enabled:=False;
     btSair.Enabled:=False;
     EntradaCocoModoEdicao:=True;
     Gravacao;
     dbnRomaneio.Enabled:=False;
end;

procedure TfRomEntCoco.EntradaCocoEditarFalse;
begin
     btNovo.Enabled:=True;
     btCancelar.Enabled:=False;
     btSalvar.Enabled:=False;
     btImprimir.Enabled:=True;
     btCancelarRom.Enabled:=True;
     btSair.Enabled:=True;
     EntradaCocoModoEdicao:=False;
     Leitura;
     dbnRomaneio.Enabled:=True;
end;

procedure TfRomEntCoco.CompraCocoEditarTrue;
Begin
     CompraCocoModoEdicao:=True;
     dbrgSacoKg.Enabled:=True;
     dbeValor.Enabled:=True;
     dbeValorBruto.Enabled:=True;
     dbePorcFundoRural.Enabled:=True;
     dbeAliquota.Enabled:=True;
     dbeValorFunRural.Enabled:=True;
     dbeValorLivre.Enabled:=True;
end;
procedure TfRomEntCoco.CompraCocoEditarFalse;
Begin
     CompraCocoModoEdicao:=False;
     dbrgSacoKg.Enabled:=False;
     dbeValor.Enabled:=False;
     dbeValorBruto.Enabled:=False;
     dbePorcFundoRural.Enabled:=False;
     dbeAliquota.Enabled:=False;
     dbeValorFunRural.Enabled:=False;
     dbeValorLivre.Enabled:=False;
end;

procedure TfRomEntCoco.Leitura;
begin
     dbeCodRomaneio.Enabled:=False;
     dbdData.Enabled:=False;
     Panel3.Enabled:=False;
     dbmObs.Enabled:=False;
     dbePesoDepositado.Enabled:=False;
     edtPesoComprado.Enabled:=False;
end;

procedure TfRomEntCoco.Gravacao;
begin
     dbdData.Enabled:=True;
     Panel3.Enabled:=True;
     dbmObs.Enabled:=True;
     edtPesoComprado.Enabled:=True;
end;

procedure TfRomEntCoco.NovoValorRegistro;
begin
     zqNovoIDRomaneioCoco.Refresh;
     ztRomEntradaCocoIDRomEntradaCoco.Value:=zqNovoIDRomaneioCocoID.Value + 1;
     ztRomEntradaCoco.FieldByName('Data').Value:=DATE;
     ztRomEntradaCocoRenda.Value:=0;
     ztRomEntradaCocoPesoBruto.Value:=0;
     ztRomEntradaCocoImpureza.Value:=0;
     ztRomEntradaCocoQuanPlastico.Value:=0;
     ztRomEntradaCocoPesoPlastico.Value:=0.1;
     ztRomEntradaCocoTotalPlastico.Value:=0;
     ztRomEntradaCocoQuanJuta.Value:=0;
     ztRomEntradaCocoPesoJuta.Value:=0.5;
     ztRomEntradaCocoTotalJuta.Value:=0;
     ztRomEntradaCocoLegenda1.Value:='Outro desconto';
     ztRomEntradaCocoDesconto1.Value:=0;
     ztRomEntradaCocoPorcentagem.Value:=0;
     ztRomEntradaCocoBeberLimpo.Value:=0;
     ztRomEntradaCocoBeberCoco.Value:=0;
     edtDesconto.Text:='15';
     ztRomEntradaCocoLegenda2.Value:='Outro desconto';
     ztRomEntradaCocoDesconto2.Value:=0;
     ztRomEntradaCocoSaldoCoco.Value:=0;
     ztRomEntradaCocoIDRomCompraCoco.Value:=0;
     edtPesoComprado.Text:='0';
end;

procedure TfRomEntCoco.ztRomEntradaCocoAfterScroll(DataSet: TDataSet);
begin
     if not(EntradaCocoModoEdicao) then begin
        dbcCliente.KeyValue:=ztRomEntradaCocoIDCliente.Value;
        LocalizaEndereco;
     end;
     CalculaPesoDepositado;
     ztRomCompraCoco.Resync([]);
end;

procedure TfRomEntCoco.LocalizaEndereco;
begin
     zqCliente.Locate('IDCliente',dbcCliente.KeyValue,[]);
     edtPropriedade.Text:=zqClienteEndereco.Text;
     edtCidade.Text:=zqClienteCidade.Text;
end;

procedure TfRomEntCoco.CalculaPesoDepositado;
begin
     ztRomCompraCoco.Locate('IDRomCompraCoco',ztRomEntradaCocoIDRomCompraCoco.Value,[]);
        edtPesoComprado.Text:=ztRomCompraCocoPesoCoco.Text;
     dbePesoDepositado.Text:=intToStr(ztRomEntradaCocoSaldoCoco.Value -
                   strToInt(edtPesoComprado.Text));
     Renda:=ztRomEntradaCocoRenda.Value;
end;

procedure TfRomEntCoco.ztRomCompraCocoCalcFields(DataSet: TDataSet);
begin
     if dbrgSacoKg.Value='Saco' then Begin
        ztRomCompraCocoValorBruto.Value:=
               ((strToInt(edtPesoComprado.Text)*
               ztRomCompraCocoValor.Value)/40);
     end
     else begin
          if CompraCocoModoEdicao then Renda:=ztRomEntradaCocoRenda.Value;
          ztRomCompraCocoValorBruto.Value:=
               ((strToint(edtPesoComprado.Text)*
               ztRomCompraCocoValor.Value*
               Renda)/40000);
     end;
     ztRomCompraCocoValorFundoRural.Value:=
               (ztRomCompraCocoValorBruto.Value*ztRomCompraCocoAliquota.Value*
               ztRomCompraCocoPorcFundoRural.Value*
               0.0001);
     ztRomCompraCocoValorLivre.Value:=
               ztRomCompraCocoValorBruto.Value-ztRomCompraCocoValorFundoRural.Value;

end;

procedure TfRomEntCoco.ztRomEntradaCocoCalcFields(DataSet: TDataSet);
var SubTotal:double;
begin
                    //Data
     if (dbdData.Text='') then
        ztRomEntradaCoco.FieldByName('Data').Value:=DATE;

                    //Renda
     if (ztRomEntradaCocoRenda.Value<1) or
        (ztRomEntradaCocoRenda.Text='') then
        ztRomEntradaCocoRenda.Value:=0;
     if trunc(ztRomEntradaCocoRenda.Value)<>ztRomEntradaCocoRenda.Value then
        ztRomEntradaCocoRenda.Value:=trunc(ztRomEntradaCocoRenda.Value);

                    //PesoBruto
     if (ztRomEntradaCocoPesoBruto.Value<1) or
        (ztRomEntradaCocoPesoBruto.Text='') then
        ztRomEntradaCocoPesoBruto.Value:=0;
     if trunc(ztRomEntradaCocoPesoBruto.Value)<>ztRomEntradaCocoPesoBruto.Value then
        ztRomEntradaCocoPesoBruto.Value:=trunc(ztRomEntradaCocoPesoBruto.Value);

                    //Impureza
     if (ztRomEntradaCocoImpureza.Text='') then
        ztRomEntradaCocoImpureza.Value:=0;
     if trunc(ztRomEntradaCocoImpureza.Value)<>ztRomEntradaCocoImpureza.Value then
        ztRomEntradaCocoImpureza.Value:=trunc(ztRomEntradaCocoImpureza.Value);
     if ztRomEntradaCocoImpureza.Value>0 then ztRomEntradaCocoImpureza.Value:=ztRomEntradaCocoImpureza.Value*(-1);

                    //Saco plastico
     if (ztRomEntradaCocoQuanPlastico.Value<1) or
        (ztRomEntradaCocoQuanPlastico.Text='') then
        ztRomEntradaCocoQuanPlastico.Value:=0;
     if trunc(ztRomEntradaCocoQuanPlastico.Value)<>ztRomEntradaCocoQuanPlastico.Value then
        ztRomEntradaCocoQuanPlastico.Value:=trunc(ztRomEntradaCocoQuanPlastico.Value);
     if (ztRomEntradaCocoPesoPlastico.Value<0) or
        (ztRomEntradaCocoPesoPlastico.Text='') then
        ztRomEntradaCocoPesoPlastico.Value:=0.1;
     ztRomEntradaCocoTotalPlastico.Value:=Trunc(ztRomEntradaCocoQuanPlastico.Value*ztRomEntradaCocoPesoPlastico.Value);
     if ztRomEntradaCocoTotalPlastico.Value>0 then ztRomEntradaCocoTotalPlastico.Value:=ztRomEntradaCocoTotalPlastico.Value*(-1);

                    //Saco Juta
     if (ztRomEntradaCocoQuanJuta.Value<1) or
        (ztRomEntradaCocoQuanJuta.Text='') then
        ztRomEntradaCocoQuanJuta.Value:=0;
     if trunc(ztRomEntradaCocoQuanJuta.Value)<>ztRomEntradaCocoQuanJuta.Value then
        ztRomEntradaCocoQuanJuta.Value:=trunc(ztRomEntradaCocoQuanJuta.Value);
     if (ztRomEntradaCocoPesoJuta.Value<0) or
        (ztRomEntradaCocoPesoJuta.Text='') then
        ztRomEntradaCocoPesoJuta.Value:=0.5;
     ztRomEntradaCocoTotalJuta.Value:=Trunc(ztRomEntradaCocoQuanJuta.Value*ztRomEntradaCocoPesoJuta.Value);
     if ztRomEntradaCocoTotalJuta.Value>0 then ztRomEntradaCocoTotalJuta.Value:=ztRomEntradaCocoTotalJuta.Value*(-1);

                   //Desconto1
     if ztRomEntradaCocoDesconto1.Text='' then ztRomEntradaCocoDesconto1.Text:='0';
     if trunc(ztRomEntradaCocoDesconto1.Value)<>ztRomEntradaCocoDesconto1.Value then
        ztRomEntradaCocoDesconto1.Value:=trunc(ztRomEntradaCocoDesconto1.Value);
     if ztRomEntradaCocoDesconto1.Value>0 then ztRomEntradaCocoDesconto1.Value:=ztRomEntradaCocoDesconto1.Value*(-1);

  SubTotal:= ztRomEntradaCocoPesoBruto.Value+
             ztRomEntradaCocoImpureza.Value+
             ztRomEntradaCocoTotalPlastico.Value+
             ztRomEntradaCocoTotalJuta.Value+
             ztRomEntradaCocoDesconto1.Value;

                    //Porcentagem
     if (ztRomEntradaCocoPorcentagem.Value<0) or
        (ztRomEntradaCocoPorcentagem.Text='') then ztRomEntradaCocoPorcentagem.Value:=0;
  if trunc(ztRomEntradaCocoPorcentagem.Value)<>ztRomEntradaCocoPorcentagem.Value then
        ztRomEntradaCocoPorcentagem.Value:=trunc(ztRomEntradaCocoPorcentagem.Value);
  ztRomEntradaCocoPesoPorcentagem.Value:=round(SubTotal*(0.01*ztRomEntradaCocoPorcentagem.Value));
  if ztRomEntradaCocoPesoPorcentagem.Value>0 then ztRomEntradaCocoPesoPorcentagem.Value:=ztRomEntradaCocoPesoPorcentagem.Value*(-1);

                 //Beber Limpo
  if (ztRomEntradaCocoBeberLimpo.Value<1) or
     (ztRomEntradaCocoBeberLimpo.Text='') then begin
     ztRomEntradaCocoBeberLimpo.Value:=0;
     ztRomEntradaCocoBeberCoco.Value:=0;
  end;
  if trunc(ztRomEntradaCocoBeberLimpo.Value)<>ztRomEntradaCocoBeberLimpo.Value then
        ztRomEntradaCocoBeberLimpo.Value:=trunc(ztRomEntradaCocoBeberLimpo.Value);

                 //Desconto Beber Limpo
  if (edtDesconto.Text<>'') then
     if (strToInt(edtDesconto.Text)<0) then edtDesconto.Text:='15';
  if edtDesconto.Text='' then edtDesconto.Text:='15';

                //Beber Coco
  if ztRomEntradaCocoBeberCoco.Text='' then ztRomEntradaCocoBeberCoco.Text:='0';
  if ztRomEntradaCocoBeberCoco.Value>0 then ztRomEntradaCocoBeberCoco.Value:=Round(ztRomEntradaCocoBeberCoco.Value*(-1));
  if trunc(ztRomEntradaCocoBeberCoco.Value)<>ztRomEntradaCocoBeberCoco.Value then
        ztRomEntradaCocoBeberCoco.Value:=trunc(ztRomEntradaCocoBeberCoco.Value);

                //Desconto2
  if ztRomEntradaCocoDesconto2.Text='' then ztRomEntradaCocoDesconto2.Text:='0';
  if ztRomEntradaCocoDesconto2.Value>0 then ztRomEntradaCocoDesconto2.Value:=ztRomEntradaCocoDesconto2.Value*(-1);
  if trunc(ztRomEntradaCocoDesconto2.Value)<>ztRomEntradaCocoDesconto2.Value then
        ztRomEntradaCocoDesconto2.Value:=trunc(ztRomEntradaCocoDesconto2.Value);
  ztRomEntradaCocoSaldoCoco.Value:=Round(SubTotal+
                            ztRomEntradaCocoPesoPorcentagem.Value+
                            ztRomEntradaCocoBeberCoco.Value+
                            ztRomEntradaCocoDesconto2.Value);

                          //Compra
  if edtPesoComprado.Text = '' then
     edtPesoComprado.Text:='0';
  if strToInt(edtPesoComprado.Text) < 0 then
     edtPesoComprado.Text:='0';
  if ztRomEntradaCocoSaldoCoco.Value < strToInt(edtPesoComprado.Text) then
        edtPesoComprado.Text:='0';

  dbePesoDepositado.Text:=intToStr(ztRomEntradaCocoSaldoCoco.Value -
                            StrToint(edtPesoComprado.Text));

  if (Not EntradaCocoModoEdicao)then Exit;
  if (strToInt(edtPesoComprado.Text)>0) and
        (Not CompraCocoModoEdicao)then begin
         ztRomCompraCoco.AutoCalcFields:=False;
         ztRomCompraCoco.Append;
         CompraCocoEditarTrue;
         zqNovoIDRomCompraCoco.Refresh;
         ztRomCompraCocoIDRomCompraCoco.Value:=
                    zqNovoIDRomCompraCocoID.Value+1;
         ztRomCompraCocoPesoCoco.Value:=0;
         ztRomCompraCocoValor.Value:=0;
         dbrgSacoKg.ItemIndex:=0;
         ztRomCompraCocoPorcFundoRural.Value:=100;
         ztRomCompraCocoAliquota.Value:=1.5;
         ztRomCompraCoco.AutoCalcFields:=True;
         Exit;
     end;
     if (strToInt(edtPesoComprado.Text)<1) and
        CompraCocoModoEdicao then begin
         ztRomCompraCoco.Cancel;
         CompraCocoEditarFalse;
     end;
end;

function TfRomEntCoco.SalvarTrue: boolean;
var Erro:string;
begin
     SalvarTrue:=True;
     Erro:='';
     if  dbcCliente.KeyValue=0 then
         Erro:='-Campo Nome não pode ficar vaziu.'+ chr(13);
     if  (ztRomEntradaCocoRenda.Value=0) or
         (ztRomEntradaCocoRenda.Value=40000) then
         Erro:=Erro+'-Campo Renda é inválido.'+ chr(13);
     if  (ztRomEntradaCocoPesoBruto.Value=0) then
         Erro:=Erro+'-Campo Peso Bruto não pode ser zero.'+ chr(13);
     if  (ztRomEntradaCocoBeBerLimpo.Value>0)and
         (ztRomEntradaCocoBeberCoco.Value=0)then
         Erro:=Erro+'-Campo Peso de café para beber em coco não pode ser zero'+chr(13)+
         '  quando peso de café para beber limpo é maior que zero.'+ chr(13);
     if  (ztRomEntradaCocoSaldoCoco.Value<0) then
         Erro:=Erro+'-Campo Saldo em Coco não pode ser negativo.'+ chr(13);
     if  CompraCocoModoEdicao and (ztRomCompraCocoValor.Value=0) then
         Erro:=Erro+'-Campo Preço não pode ser zero.'+ chr(13);
     if  (dbcLoteCoco.KeyValue<1) then
         Erro:=Erro+'-Campo Lote Coco não pode ficar Vazio.'+ chr(13);
     if not(Erro = '') then
     begin
       MessageDlg(Erro, mtError,[mbOk], 0);
       SalvarTrue:=False;
     end;
end;

procedure TfRomEntCoco.btSalvarClick(Sender: TObject);
var IDPrincipal, IDContaCorrente:Integer;
    Valor:double;
begin
     if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
        [mbYes, mbNO], 0) = mrYes) then Exit;
     if not(SalvarTrue) then Exit;
     try
                  //Romaneio de entrada em coco
     IDRomEntradaCoco:=ztRomEntradaCocoIDRomEntradaCoco.Value;
     IDCliente:=dbcCliente.KeyValue;
     ztRomEntradaCocoIDCliente.Value:=IDCliente;
     IDLoteCoco:=ztRomEntradaCocoIDLoteCoco.Value;
     ztRomEntradaCocoIDRomEntradaCoco.Value:=IDRomEntradaCoco;
     BeberCoco:=ztRomEntradaCocoBeberCoco.Value*(-1);
     BeberLimpo:=ztRomEntradaCocoBeberLimpo.Value;
     SaldoCoco:=ztRomEntradaCocoSaldoCoco.Value;
     PesoComprado:=strToFloat(edtPesoComprado.Text);
     if (PesoComprado=0) then
        ztRomEntradaCocoIDRomCompraCoco.Value:=0
     else Begin
         zqNovoIDRomCompraCoco.Refresh;
         IDRomCompraCoco:=zqNovoIDRomCompraCocoID.Value+1;
         ztRomEntradaCocoIDRomCompraCoco.Value:=IDRomCompraCoco
     end;
     ztRomEntradaCocoStatus.Value:='Ativo';
     PesoComprado:=strToFloat(edtPesoComprado.Text);
     ztRomEntradaCoco.Post;
     edtPesoComprado.Text:=floatToStr(PesoComprado);

                   //café para beber
     if BeberLimpo>0 then SalvaCafeBeber;

                   //SaldoCoco
     if SaldoCoco>0 then SalvaMovLoteCoco(SaldoCoco);

                   //Depósito
     if ztRomEntradaCocoPesoDepositado.Value>0 then begin
        ztEstoqueDepositoCoco.Append;
        zqNovoIDEstDepCoco.Refresh;
        ztEstoqueDepositoCocoIDEstoqueDepositoCoco.Value:=zqNovoIDEstDepCocoID.Value+1;
        ztEstoqueDepositoCocoIDRomEntradaCoco.Value:=IDRomEntradaCoco;
        ztEstoqueDepositoCocoPesoEntrada.Value:=ztRomEntradaCocoPesoDepositado.Value;
        ztEstoqueDepositoCocoPesoSaida.Value:=0;
        ztEstoqueDepositoCocoSaldo.Value:=ztRomEntradaCocoPesoDepositado.Value;
        ztEstoqueDepositoCocoStatus.Value:='Ativo';
        ztEstoqueDepositoCoco.Post;
     end;

                   //Compra
     if (PesoComprado>0) then begin
        ztRomCompraCocoIDRomEntradaCoco.Value:=IDRomEntradaCoco;
        ztRomCompraCoco.FieldByName('Data').Value:=DATE;
        ztRomCompraCocoHistorico.Value:='Compra do romaneio '+intToStr(IDRomEntradaCoco);
        ztRomCompraCocoPesoCoco.Value:=PesoComprado;
        ztRomCompraCocoStatus.Text:='Ativo';
        IDContaCorrente:=zqNovoIDContaCorrenteID.Value+1;
        ztRomCompraCocoIDContaCorrente.Value:=IDContaCorrente;
        Valor:=ztRomCompraCocoValorLivre.Value;
        ztRomCompraCoco.Post;

                    //ContaCorrente
        IDPrincipal:=zqClienteIDPrincipal.Value;
        zqCliente.Locate('IDCliente',IDPrincipal,[]);
        ztContaCorrente.Append;
        ztContaCorrenteIDContaCorrente.Value:=IDContaCorrente;
        ztContaCorrenteIDAcerto.Value:=0;
        ztContaCorrenteIDCliente.Value:=zqClienteIDCliente.Value;
        ztContaCorrente.FieldByName('Data').Value:=DATE;
        ztContaCorrenteHistorico.Value:='Compra:'+intToStr(IDRomCompraCoco)+'- Rom. coco:'+intToStr(IDRomEntradaCoco);
        ztContaCorrenteEntrada.Value:=Valor;
        ztContaCorrenteSaida.Value:=0;
        ztContaCorrenteStatus.Value:='Ativo';
        ztContaCorrente.Post;

                    //Cliente
        zqCliente.Edit;
        zqClienteSaldoContaCorrente.Value:=zqClienteSaldoContaCorrente.Value+Valor;
        zqCliente.Post;

     end;

     zconn.Commit;
     except
     on E: Exception do
        begin
         ztRomEntradaCoco.Cancel;
         ztLoteLimpo.Cancel;
         ztMovLoteLimpo.Cancel;
         ztMovLoteCoco.Cancel;

         zconn.Rollback;
         ShowMessage('Erro ao salvar registro '+E.Message);
        end;
     end;
     CompraCocoEditarFalse;
     EntradaCocoEditarFalse;
     ztRomEntradaCoco.Refresh;
end;

procedure TfRomEntCoco.SalvaCafeBeber;
begin
                                  //beber limpo
        ztLoteLimpo.Locate('IDLoteLimpo',1,[]);
        ztLoteLimpo.Edit;
        ztLoteLimpoSaldo.Value:=ztLoteLimpoSaldo.Value+
                         ztRomEntradaCocoBeberLimpo.Value;
        ztLoteLimpo.Post;

        zqNovoIdMovLoteLimpo.Refresh;
        ztMovLoteLimpo.Append;
        ztMovLoteLimpoIDMovLoteLimpo.Value:=zqNovoIDMovLoteLimpoID.Value+1;
        ztMovLoteLimpoIDLoteLimpo.Value:=1;
        ztMovLoteLimpoIDCliente.Value:=IDCliente;
        ztMovLoteLimpo.FieldByName('Data').Value:=DATE;
        ztMovLoteLimpoHistorico.Value:='Romaneio entrada em coco '+IntToStr(IDRomEntradaCoco) ;
        ztMovLoteLimpoPesoEntrada.Value:=BeberLimpo;
        ztMovLoteLimpoPesoSaida.Value:=0;
        ztMovLoteLimpoStatus.Value:='Ativo';
        ztMovLoteLimpo.Post;

                            //beber coco
        SalvaMovLoteCoco(BeberCoco);
end;

procedure TfRomEntCoco.SalvaMovLoteCoco(PesoCoco: Double);
var temp:integer;
begin
        zqNovoIDMovLoteCoco.Refresh;
        ztMovLoteCoco.Append;
        ztMovLoteCocoIDMovLoteCoco.Value:=zqNovoIDMovLoteCocoID.Value+1;
        ztMovLoteCocoIDLoteCoco.Value:=zqLoteCocoIDLoteCoco.Value;
        ztMovLoteCocoIDRomEntradaCoco.Value:=IDRomEntradaCoco;
        ztMovLoteCocoIDRomSaidaCoco.Value:=0;
        ztMovLoteCocoIDCliente.Value:=IDCliente;
        ztMovLoteCoco.FieldByName('Data').Value:=DATE;
        ztMovLoteCocoHistorico.Value:='Romaneio entrada em coco '+intToStr(IDRomEntradaCoco) ;
        ztMovLoteCocoPesoCocoEntrada.Value:=PesoCoco;
        ztMovLoteCocoPesoCocoSaida.Value:=0;
        ztMovLoteCocoStatus.Value:='Ativo';
        ztMovLoteCoco.Post;
end;

end.

