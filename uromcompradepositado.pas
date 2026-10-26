unit uRomCompraDepositado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, Buttons,
  DBCtrls, ZDataset, ZAbstractRODataset;

type

  { TfRomCompraDepositado }

  TfRomCompraDepositado = class(TForm)
    btSair: TBitBtn;
    dsClienteSaldo: TDataSource;
    DBlcbNome: TDBLookupComboBox;
    dsEstoqueDepositoCoco: TDataSource;
    DBGrid1: TDBGrid;
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
    procedure btSairClick(Sender: TObject);
    procedure DBlcbNomeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fRomCompraDepositado: TfRomCompraDepositado;

implementation

{$R *.lfm}

{ TfRomCompraDepositado }

procedure TfRomCompraDepositado.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfRomCompraDepositado.DBlcbNomeChange(Sender: TObject);
begin
  zqEstoqueDepositoCoco.Filtered:=False;
  if DBlcbNome.KeyValue>0 then
  zqEstoqueDepositoCoco.Filter:='(IDCliente = '+QuotedStr(intToStr(DBlcbNome.KeyValue))+
                                     'and Saldo > 0 and Status ='+QuotedStr('Ativo')+')'
  else
     zqEstoqueDepositoCoco.Filter:='(IDCliente=0)';
  zqEstoqueDepositoCoco.Filtered:=True;
end;

procedure TfRomCompraDepositado.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  zqEstoqueDepositoCoco.Close;
  zqClienteSaldo.Close;
end;

procedure TfRomCompraDepositado.FormShow(Sender: TObject);
begin
  zqEstoqueDepositoCoco.Open;
  zqClienteSaldo.Open;
  zqEstoqueDepositoCoco.Filtered:=False;
  zqEstoqueDepositoCoco.Filter:='(IDCliente=0)';
  zqEstoqueDepositoCoco.Filtered:=True;
end;

end.

