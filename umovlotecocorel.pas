unit uMovLoteCocoRel;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, Buttons,
  ZDataset, ZAbstractRODataset;

type

  { TfMovLoteCocoRel }

  TfMovLoteCocoRel = class(TForm)
    btSair: TBitBtn;
    dsMovLoteCoco: TDataSource;
    DBGrid1: TDBGrid;
    ztMovLoteCoco: TZTable;
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
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fMovLoteCocoRel: TfMovLoteCocoRel;

implementation

{$R *.lfm}

{ TfMovLoteCocoRel }

procedure TfMovLoteCocoRel.FormShow(Sender: TObject);
begin
  ztMovLoteCoco.Open;
end;

procedure TfMovLoteCocoRel.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   ztMovLoteCoco.Close;
end;

procedure TfMovLoteCocoRel.btSairClick(Sender: TObject);
begin
  Close;
end;

end.

