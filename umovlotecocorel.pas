unit uMovLoteCocoRel;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, Buttons,
  ExtCtrls, StdCtrls, DateTimePicker, ZDataset, ZAbstractRODataset;

type

  { TfMovLoteCocoRel }

  TfMovLoteCocoRel = class(TForm)
    btSair: TBitBtn;
    dtpFim: TDateTimePicker;
    dtpInicio: TDateTimePicker;
    dsMovLoteCoco: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    rgFiltro: TRadioGroup;
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
    ztMovLoteCocoVALOR: TZBCDField;
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rgFiltroClick(Sender: TObject);
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
  rgFiltro.ItemIndex:=0;
end;

procedure TfMovLoteCocoRel.rgFiltroClick(Sender: TObject);
begin
  ztMovLoteCoco.Filtered:=False;
  if rgFiltro.ItemIndex=0 then
     ztMovLoteCoco.Filter:=''
  else
      ztMovLoteCoco.Filter:='(Status='+QuotedStr('Ativo')+'and Data>='+
                             QuotedStr(dateToStr(dtpInicio.Date))+
                             'and Data<='+QuotedStr(dateToStr(dtpFim.Date))+')';
  ztMovLoteCoco.Filtered:=True;
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

