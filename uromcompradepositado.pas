unit uRomCompraDepositado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, Buttons,
  DBCtrls, StdCtrls, ExtCtrls, ZDataset, ZAbstractRODataset;

type

  { TfRomCompraDepositado }

  TfRomCompraDepositado = class(TForm)
    btCancelar: TBitBtn;
    btImprimir: TBitBtn;
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    btTrans: TButton;
    dbeAliquota: TDBEdit;
    dbeRomCompraDeosito: TDBEdit;
    dbePesoComprado: TDBEdit;
    dbePorcFundoRural: TDBEdit;
    dbePreco: TDBEdit;
    dbeValorFunRural: TDBEdit;
    dbeValorLivre: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    dsRomCompraCoco: TDataSource;
    dsClienteSaldo: TDataSource;
    DBlcbNome: TDBLookupComboBox;
    dsEstoqueDepositoCoco: TDataSource;
    DBGrid1: TDBGrid;
    edtPesoDepositado: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    zqClienteSaldo: TZQuery;
    zqClienteSaldoIDCLIENTE: TZIntegerField;
    zqClienteSaldoRAZAO2: TZRawStringField;
    zqClienteSaldoSALDO2: TZInt64Field;
    zqEstoqueDepositoCoco: TZQuery;
    zqEstoqueDepositoCocoIDCLIENTE: TZIntegerField;
    zqEstoqueDepositoCocoIDROMENTRADACOCO: TZIntegerField;
    zqEstoqueDepositoCocoPESOENTRADA: TZIntegerField;
    zqEstoqueDepositoCocoPESOSAIDA: TZIntegerField;
    zqEstoqueDepositoCocoSALDO: TZIntegerField;
    zqEstoqueDepositoCocoSTATUS: TZRawStringField;
    zqNovoIDRomCompraCocoID: TZIntegerField;
    zqNovoIDRomCompraDeposito: TZQuery;
    zqNovoIDRomCompraDepositoID: TZIntegerField;
    zqNovoIDRomCompraCoco: TZQuery;
    ztRomCompraCoco: TZTable;
    ztRomCompraCocoALIQUOTA: TZBCDField;
    ztRomCompraCocoDATA: TZDateField;
    ztRomCompraCocoHISTORICO: TZRawStringField;
    ztRomCompraCocoIDCONTACORRENTE: TZIntegerField;
    ztRomCompraCocoIDROMCOMPRACOCO: TZIntegerField;
    ztRomCompraCocoIDROMCOMPRADEPOSITO: TZIntegerField;
    ztRomCompraCocoIDROMENTRADACOCO: TZIntegerField;
    ztRomCompraCocoPESOCOCO: TZIntegerField;
    ztRomCompraCocoPORCFUNDORURAL: TZIntegerField;
    ztRomCompraCocoSACOKG: TZRawStringField;
    ztRomCompraCocoSTATUS: TZRawStringField;
    ztRomCompraCocoVALOR: TZBCDField;
    ztRomCompraCocoValorFundoRural: TCurrencyField;
    ztRomCompraCocoValorLivre: TCurrencyField;
    procedure btCancelarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btTransClick(Sender: TObject);
    procedure DBlcbNomeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EditarTrue;
    procedure EditarFalse;
  private

  public

  end;

var
  fRomCompraDepositado: TfRomCompraDepositado;

implementation

uses uPrincipal;

{$R *.lfm}

{ TfRomCompraDepositado }

procedure TfRomCompraDepositado.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfRomCompraDepositado.btSalvarClick(Sender: TObject);
begin
  EditarFalse;
  if zqEstoqueDepositoCoco.RecordCount>0 then
     btTrans.Enabled:=True;
end;

procedure TfRomCompraDepositado.btTransClick(Sender: TObject);
begin
  btTrans.Enabled:=False;
  EditarTrue;
  ztRomCompraCoco.Append;
  zqNovoIDRomCompraDeposito.Refresh;
  zqNovoIDRomCompraCoco.Refresh;
  ztRomCompraCocoIDRomCompraCoco.Value:=zqNovoIDRomCompraCocoID.Value+1;
  ztRomCompraCocoIDRomCompraDeposito.Value:=zqNovoIDRomCompraDepositoID.Value+1;
  edtPesoDepositado.Text:=intToStr(zqEstoqueDepositoCocoSaldo.Value);

end;

procedure TfRomCompraDepositado.btCancelarClick(Sender: TObject);
begin
  EditarFalse;
  btTrans.Enabled:=True;
  ztRomCompraCoco.Cancel;
  zqNovoIDRomCompraCoco.Cancel;
  zqNovoIDRomCompraDeposito.Cancel;
  fPrincipal.zConn.Rollback;
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

procedure TfRomCompraDepositado.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  zqEstoqueDepositoCoco.Close;
  zqClienteSaldo.Close;
  ztRomCompraCoco.Close;
  zqNovoIDRomCompraCoco.Close;
  zqNovoIDRomCompraDeposito.Close;
end;

procedure TfRomCompraDepositado.FormShow(Sender: TObject);
begin
  zqEstoqueDepositoCoco.Open;
  zqClienteSaldo.Open;
  ztRomCompraCoco.Open;
  zqNovoIDRomCompraCoco.Open;
  zqNovoIDRomCompraDeposito.Open;
  zqEstoqueDepositoCoco.Filtered:=False;
  zqEstoqueDepositoCoco.Filter:='(IDCliente=0)';
  zqEstoqueDepositoCoco.Filtered:=True;
  EditarFalse;
  btTrans.Enabled:=False;
end;

procedure TfRomCompraDepositado.EditarTrue;
begin
   Panel1.Enabled:=True;
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
  btImprimir.Enabled:=True;
  btSair.Enabled:=True;
end;

end.

