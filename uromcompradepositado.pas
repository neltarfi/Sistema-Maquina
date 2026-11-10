unit uRomCompraDepositado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, Buttons,
  DBCtrls, StdCtrls, ExtCtrls, DBDateTimePicker, ZDataset, ZAbstractRODataset,
  IniFiles;

type

  { TfRomCompraDepositado }

  TfRomCompraDepositado = class(TForm)
    btCancelar: TBitBtn;
    btImprimir: TBitBtn;
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    btTrans: TButton;
    dbdtpData: TDBDateTimePicker;
    dbeAliquota: TDBEdit;
    dbeObs: TDBEdit;
    dbeRenda: TDBEdit;
    dbeIDRomCompraDeposito: TDBEdit;
    dbePorcFundoRural: TDBEdit;
    dbePreco: TDBEdit;
    dbeValorBruto: TDBEdit;
    dbeValorFunRural: TDBEdit;
    dbeValorLivre: TDBEdit;
    dbrgSacoKg: TDBRadioGroup;
    dsRomCompraCoco: TDataSource;
    dsClienteSaldo: TDataSource;
    DBlcbNome: TDBLookupComboBox;
    dsEstoqueDepositoCoco: TDataSource;
    DBGrid1: TDBGrid;
    edtPesoComprado: TEdit;
    edtPesoDepositado: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label33: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    zqClienteSaldoIDCLIENTE: TZIntegerField;
    zqClienteSaldoRAZAO2: TZRawStringField;
    zqClienteSaldoSALDO2: TZInt64Field;
    zqEstoqueDepositoCocoIDCLIENTE: TZIntegerField;
    zqEstoqueDepositoCocoIDROMENTRADACOCO: TZIntegerField;
    zqEstoqueDepositoCocoPESOENTRADA: TZIntegerField;
    zqEstoqueDepositoCocoPESOSAIDA: TZIntegerField;
    zqEstoqueDepositoCocoRENDA: TZIntegerField;
    zqEstoqueDepositoCocoSALDO: TZIntegerField;
    zqEstoqueDepositoCocoSTATUS: TZRawStringField;
    zqNovoIDRomCompraCocoID: TZIntegerField;
    zqNovoIDContaCorrenteID: TZIntegerField;
    zqClienteSaldo: TZQuery;
    zqEstoqueDepositoCoco: TZQuery;
    zqNovoIDContaCorrente: TZQuery;
    zqNovoIDRomCompraDeposito: TZQuery;
    zqNovoIDRomCompraDepositoID: TZIntegerField;
    zqNovoIDRomCompraCoco: TZQuery;
    ztRomCompraCoco: TZTable;
    ztContaCorrenteDATA: TZDateField;
    ztContaCorrenteENTRADA: TZBCDField;
    ztContaCorrenteHISTORICO: TZRawStringField;
    ztContaCorrenteIDACERTO: TZIntegerField;
    ztContaCorrenteIDCLIENTE: TZIntegerField;
    ztContaCorrenteIDCONTACORRENTE: TZIntegerField;
    ztContaCorrenteSAIDA: TZBCDField;
    ztContaCorrenteSTATUS: TZRawStringField;
    ztContaCorrente: TZTable;
    ztRomCompraCocoALIQUOTA: TZBCDField;
    ztRomCompraCocoDATA: TZDateField;
    ztRomCompraCocoIDCONTACORRENTE: TZIntegerField;
    ztRomCompraCocoIDROMCOMPRACOCO: TZIntegerField;
    ztRomCompraCocoIDROMCOMPRADEPOSITO: TZIntegerField;
    ztRomCompraCocoIDROMENTRADACOCO: TZIntegerField;
    ztRomCompraCocoOBS: TZRawStringField;
    ztRomCompraCocoPESOCOCO: TZIntegerField;
    ztRomCompraCocoPORCFUNDORURAL: TZIntegerField;
    ztRomCompraCocoSACOKG: TZRawStringField;
    ztRomCompraCocoSTATUS: TZRawStringField;
    ztRomCompraCocoVALOR: TZBCDField;
    ztRomCompraCocoValorBruto: TCurrencyField;
    ztRomCompraCocoValorFundoRural: TCurrencyField;
    ztRomCompraCocoValorLivre: TCurrencyField;
    procedure btCancelarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btTransClick(Sender: TObject);
    procedure dbeAliquotaChange(Sender: TObject);
    procedure dbePorcFundoRuralChange(Sender: TObject);
    procedure dbePorcFundoRuralExit(Sender: TObject);
    procedure dbePrecoChange(Sender: TObject);
    procedure dbePrecoExit(Sender: TObject);
    procedure DBlcbNomeChange(Sender: TObject);
    procedure dbrgSacoKgClick(Sender: TObject);
    procedure edtPesoCompradoChange(Sender: TObject);
    procedure edtPesoCompradoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EditarTrue;
    procedure EditarFalse;
    procedure NovoRegistro;
    procedure ztRomCompraCocoCalcFields(DataSet: TDataSet);
  private

  public

  end;

var
  fRomCompraDepositado: TfRomCompraDepositado;
  AliquotaFundoRural:double;

implementation

uses uPrincipal, uFuncoes;

{$R *.lfm}

{ TfRomCompraDepositado }

procedure TfRomCompraDepositado.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfRomCompraDepositado.btSalvarClick(Sender: TObject);
var erro:string;
begin
  erro:='';
  if edtPesoComprado.Text='0' then
     erro:='-O campo Peso comprado tem que ser maior que zero'+chr(13);
  if ztRomCompraCocoValor.Value=0 then
     erro:=erro+'-O campo Preço tem que ser maior que zero'+chr(13);
  if ztRomCompraCocoPorcFundoRural.Value=0 then
     erro:=erro+'-O campo PorcFundoRural tem que ser maior que zero';
  if erro<>'' then begin
     showMessage(erro);
     exit;
  end;
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes) then  Exit;
  try
  ztRomCompraCocoIDRomEntradaCoco.Value:=zqEstoqueDepositoCocoIDRomEntradaCoco.Value;
  ztRomCompraCocoPesoCoco.Value:=strToInt(edtPesoComprado.Text);
  ztRomCompraCocoIDContaCorrente.Value:=ztContaCorrenteIDContaCorrente.Value;
  ztRomCompraCocoStatus.Value:='Ativo';
  ztRomCompraCoco.Post;

  ztContaCorrente.Post;

  fPrincipal.zConn.Commit;
  except
     on E: Exception do
        begin
         ztRomCompraCoco.Cancel;
         ztContaCorrente.Cancel;
         fPrincipal.zConn.Rollback;
         ShowMessage('Erro ao salvar registro '+E.Message);
        end;
  end;

  EditarFalse;
  if zqEstoqueDepositoCoco.RecordCount>0 then
     btTrans.Enabled:=True;
end;

procedure TfRomCompraDepositado.btTransClick(Sender: TObject);
begin
  btTrans.Enabled:=False;
  EditarTrue;
  dbeRenda.DataField:='RENDA';
  fPrincipal.zConn.StartTransaction;
  ztRomCompraCoco.Append;
  zqNovoIDRomCompraDeposito.Refresh;
  zqNovoIDRomCompraCoco.Refresh;
  ztRomCompraCocoIDRomCompraCoco.Value:=zqNovoIDRomCompraCocoID.Value+1;
  ztRomCompraCocoIDRomCompraDeposito.Value:=zqNovoIDRomCompraDepositoID.Value+1;
  zqNovoIDContaCorrente.Refresh;
  ztContaCorrente.Append;
  ztContaCorrenteIDContaCorrente.Value:=zqNovoIDContaCorrenteID.Value+1;
  edtPesoDepositado.Text:=intToStr(zqEstoqueDepositoCocoSaldo.Value);
  NovoRegistro;
end;

procedure TfRomCompraDepositado.dbeAliquotaChange(Sender: TObject);
begin
  DBAceitaDecimal(dbeAliquota);
end;

procedure TfRomCompraDepositado.dbePorcFundoRuralChange(Sender: TObject);
begin
  DBAceitaInteiro(dbePorcFundoRural);
end;

procedure TfRomCompraDepositado.dbePorcFundoRuralExit(Sender: TObject);
begin
  ztRomCompraCocoCalcFields(ztRomCompraCoco);  //dispara o método oncalcFields
end;

procedure TfRomCompraDepositado.dbePrecoChange(Sender: TObject);
begin
  DBAceitaDecimal(dbePreco);
end;

procedure TfRomCompraDepositado.dbePrecoExit(Sender: TObject);
begin
  ztRomCompraCocoValor.Value:=(Decimal(ztRomCompraCocoValor.Value,2));
  ztRomCompraCocoCalcFields(ztRomCompraCoco);  //dispara o método oncalcFields
end;

procedure TfRomCompraDepositado.btCancelarClick(Sender: TObject);
begin
  ztRomCompraCoco.Cancel;
  ztContaCorrente.Cancel;
  fPrincipal.zConn.Rollback;
  EditarFalse;
  btTrans.Enabled:=True;
  edtPesoDepositado.Text:='0';
  dbeRenda.DataField:='';
end;

procedure TfRomCompraDepositado.DBlcbNomeChange(Sender: TObject);
begin
  zqEstoqueDepositoCoco.Filtered:=False;
  if DBlcbNome.KeyValue>0 then begin
     zqEstoqueDepositoCoco.Filter:='(IDCliente = '+QuotedStr(intToStr(DBlcbNome.KeyValue))+
                                     'and Saldo > 0 and Status ='+QuotedStr('Ativo')+')';
     btTrans.Enabled:=True;
  end
  else begin
     zqEstoqueDepositoCoco.Filter:='(IDCliente=0)';
     btTrans.Enabled:=False;
  end;
  zqEstoqueDepositoCoco.Filtered:=True;
end;

procedure TfRomCompraDepositado.dbrgSacoKgClick(Sender: TObject);
begin
  if ztRomCompraCoco.State = dsInsert then
     ztRomCompraCocoCalcFields(ztRomCompraCoco);  //dispara o método oncalcFields
end;

procedure TfRomCompraDepositado.edtPesoCompradoChange(Sender: TObject);
begin
  AceitaInteiro(edtPesoComprado);
end;

procedure TfRomCompraDepositado.edtPesoCompradoExit(Sender: TObject);
begin
  ztRomCompraCocoCalcFields(ztRomCompraCoco);  //dispara o método oncalcFields
end;

procedure TfRomCompraDepositado.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if ztRomCompraCoco.State = dsInsert then begin
     ztRomCompraCoco.Cancel;
     ztContaCorrente.Cancel;
     fPrincipal.zConn.Rollback;
  end;
  zqEstoqueDepositoCoco.Close;
  zqClienteSaldo.Close;
  ztRomCompraCoco.Close;
  ztContaCorrente.Close;
  zqNovoIDRomCompraCoco.Close;
  zqNovoIDRomCompraDeposito.Close;
  zqNovoIDContaCorrente.Close;
end;

procedure TfRomCompraDepositado.FormShow(Sender: TObject);
begin
  if ((Copy(GetCurrentDir,2,1)=':')or (Copy(GetCurrentDir,2,1)='\')) then
     SistemaIni := TIniFile.Create(GetCurrentDir+'\BaseDeDados\Sistema.ini')
  else
     SistemaIni := TIniFile.Create(GetCurrentDir+'/BaseDeDados/Sistema.ini');
     AliquotaFundoRural:=SistemaIni.ReadFloat('Variaveis', 'AliquotaFundoRural', 0);
  SistemaIni.Free;
  zqEstoqueDepositoCoco.Open;
  zqClienteSaldo.Open;
  ztRomCompraCoco.Open;
  ztContaCorrente.Open;
  zqNovoIDRomCompraCoco.Open;
  zqNovoIDRomCompraDeposito.Open;
  zqNovoIDContaCorrente.Open;
  zqEstoqueDepositoCoco.Filtered:=False;
  zqEstoqueDepositoCoco.Filter:='(IDCliente=0)';
  zqEstoqueDepositoCoco.Filtered:=True;
  EditarFalse;
  btTrans.Enabled:=False;
  edtPesoDepositado.Text:='0';
end;

procedure TfRomCompraDepositado.EditarTrue;
begin
   Panel1.Enabled:=True;
   DBlcbNome.Enabled:=False;
   DBGrid1.Enabled:=False;
   btCancelar.Enabled:=True;
   btSalvar.Enabled:=True;
   btImprimir.Enabled:=False;
   btSair.Enabled:=False;
end;

procedure TfRomCompraDepositado.EditarFalse;
begin
  Panel1.Enabled:=False;
  btCancelar.Enabled:=False;
  btSalvar.Enabled:=False;
  DBlcbNome.Enabled:=True;
  DBGrid1.Enabled:=True;
  btImprimir.Enabled:=True;
  btSair.Enabled:=True;
end;

procedure TfRomCompraDepositado.NovoRegistro;
begin
  ztRomCompraCocoPesoCoco.Value:=0;
  edtPesoComprado.Text:='0';
  dbrgSacoKg.Value:='Saco';;
  ztRomCompraCoco.FieldByName('Data').Value:=DATE;
  ztRomCompraCocoValor.Value:=0;
  ztRomCompraCocoPorcFundoRural.Value:=100;
  ztRomCompraCocoAliquota.Value:=AliquotaFundoRural;
  ztRomCompraCocoValorBruto.Value:=0;
  ztRomCompraCocoValorFundoRural.Value:=0;
  ztRomCompraCocoValorLivre.Value:=0;
end;

procedure TfRomCompraDepositado.ztRomCompraCocoCalcFields(DataSet: TDataSet);
begin
     if edtPesoComprado.Text='' then
        edtPesoComprado.Text:='0';
     if ztRomCompraCocoValor.Text='' then
        ztRomCompraCocoValor.Value:=0;
     if (ztRomCompraCocoPorcFundoRural.Text='')or(strToInt(ztRomCompraCocoPorcFundoRural.Text)>100) then
        ztRomCompraCocoPorcFundoRural.Value:=100;
     if ((zqEstoqueDepositoCocoSaldo.Value)-strToInt(edtPesoComprado.Text))<0 then begin
         edtPesoDepositado.Text:=intTostr(zqEstoqueDepositoCocoSaldo.Value);
         edtPesoComprado.Text:='0';
     end;
     edtPesoDepositado.Text:=intToStr(zqEstoqueDepositoCocoSaldo.Value-strToInt(edtPesoComprado.Text));
     if dbrgSacoKg.Value='Saco' then
           ztRomCompraCocoValorBruto.Value:=
            ((strToInt(edtPesoComprado.Text)*
            ztRomCompraCocoValor.Value)/40)
     else
          ztRomCompraCocoValorBruto.Value:=
            ((strToInt(edtPesoComprado.Text)*
            ztRomCompraCocoValor.Value*
            zqEstoqueDepositoCocoRenda.Value)/40000);

     ztRomCompraCocoValorFundoRural.Value:=
            (ztRomCompraCocoValorBruto.Value*ztRomCompraCocoAliquota.Value*
            ztRomCompraCocoPorcFundoRural.Value*0.0001);
     ztRomCompraCocoValorLivre.Value:=
     ztRomCompraCocoValorBruto.Value-ztRomCompraCocoValorFundoRural.Value;
end;

end.

