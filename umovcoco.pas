unit uMovCoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls;

type

  { TfMovCoco }

  TfMovCoco = class(TForm)
    btEntrada: TButton;
    btSaida: TButton;
    btSair: TButton;
    cgFiltro: TCheckGroup;
    DBGrid1: TDBGrid;
    rgFiltroNome: TRadioGroup;
    procedure btEntradaClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fMovCoco: TfMovCoco;

implementation

uses uRomEntCoco;

{$R *.lfm}

{ TfMovCoco }

procedure TfMovCoco.btEntradaClick(Sender: TObject);
begin
  fRomEntCoco:=TfRomEntCoco.Create(self);
    fRomEntCoco.ShowModal;
    fRomEntCoco.Destroy;
end;

procedure TfMovCoco.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfMovCoco.FormShow(Sender: TObject);
begin
  cgFiltro.Checked[0]:=True;
  cgFiltro.Checked[1]:=True;
  rgFiltroNome.ItemIndex:=0;
end;

end.

