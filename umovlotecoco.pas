unit umovlotecoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, DBCtrls, ZDataset, ZAbstractRODataset;

type

  { TfMovLoteCoco }

  TfMovLoteCoco = class(TForm)
    btEntrada: TButton;
    btSaida: TButton;
    btSair: TButton;
    BuscaNome: TButton;
    btRelatorio: TButton;
    DBNavigator1: TDBNavigator;
    dsCliente: TDataSource;
    DBlcbNome: TDBLookupComboBox;
    dsMovLoteCoco: TDataSource;
    DBGrid1: TDBGrid;
    rgFiltroOperacao: TRadioGroup;
    rgFiltroNome: TRadioGroup;
    zqCliente: TZQuery;
    zqClienteIDCliente: TZInt64Field;
    zqClienteIDPrincipal: TZInt64Field;
    zqClienteRazao: TZRawStringField;
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
    procedure btEntradaClick(Sender: TObject);
    procedure btRelatorioClick(Sender: TObject);
    procedure btSaidaClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure BuscaNomeClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBlcbNomeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AplicaFiltro;
    procedure rgFiltroNomeClick(Sender: TObject);
    procedure rgFiltroOperacaoClick(Sender: TObject);
  private

  public

  end;

var
  fMovLoteCoco: TfMovLoteCoco;
  FormOperacao:string;

implementation

uses uRomEntCoco, uPrincipal, uCadCliente, uRomSaidaCoco, uMovLoteCocoRel;

{$R *.lfm}

{ TfMovLoteCoco }

procedure TfMovLoteCoco.btEntradaClick(Sender: TObject);
var temp:integer;
begin
  FormOperacao:='InserirRegistro';
  fRomEntCoco:=TfRomEntCoco.Create(self);
  temp:=fRomEntCoco.ShowModal;
  fRomEntCoco.Destroy;
  ztMovLoteCoco.Refresh;
  ztMovLoteCoco.Locate('IDMovLoteCoco',temp,[]);
end;

procedure TfMovLoteCoco.btRelatorioClick(Sender: TObject);
begin
  fMovLoteCocoRel:=TfMovLoteCocoRel.Create(self);
  fMovLoteCocoRel.ShowModal;
  fMovLoteCocoRel.Destroy;
end;

procedure TfMovLoteCoco.btSaidaClick(Sender: TObject);
var temp:integer;
begin
     FormOperacao:='InserirRegistro';
     fRomSaidaCoco:=TfRomSaidaCoco.Create(self);
     temp:=fRomSaidaCoco.ShowModal;
     fRomSaidaCoco.Destroy;
     ztMovLoteCoco.Refresh;
     ztMovLoteCoco.Locate('IDMovLoteCoco',temp,[]);
end;

procedure TfMovLoteCoco.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfMovLoteCoco.BuscaNomeClick(Sender: TObject);
var temp:integer;
begin
    fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    fCadCliente.Destroy;
    DBlcbNome.KeyValue:=temp;
    AplicaFiltro;
end;

procedure TfMovLoteCoco.DBGrid1DblClick(Sender: TObject);
var temp:integer;
begin
  FormOperacao:='VisualizarRegistro';
  if (ztMovLoteCoco.RecordCount>0) then begin             //verifica se tem registros
                                                      //na tabela MovCoco.
     if (ztMovLoteCocoIDRomEntradaCoco.Value)>0 then begin // verifica se é entrada
        fRomEntCoco:=TfRomEntCoco.Create(self);
         temp:=fRomEntCoco.ShowModal;
         fRomEntCoco.Destroy;
         ztMovLoteCoco.Refresh;
     ztMovLoteCoco.Locate('IDMovLoteCoco',temp,[]);
     end
     else begin
        fRomSaidaCoco:=TfRomSaidaCoco.Create(self);
        temp:=fRomSaidaCoco.ShowModal;
        fRomSaidaCoco.Destroy;
        ztMovLoteCoco.Refresh;
         ztMovLoteCoco.Locate('IDMovLoteCoco',temp,[]);
     end;

  end;
end;

procedure TfMovLoteCoco.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormCadastroSomenteLeitura:=False;
  ztMovLoteCoco.Close;
  zqCliente.Close;
end;

procedure TfMovLoteCoco.FormShow(Sender: TObject);
begin
  ztMovLoteCoco.Open;
  zqCliente.Open;
  dblcbNome.KeyValue:=0;
  rgFiltroOperacao.ItemIndex:=0;
  rgFiltroNome.ItemIndex:=0;
  FormCadastroSomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
  ztMovLoteCoco.Last;
end;
procedure TfMovLoteCoco.AplicaFiltro;
var NomeInicio, NomeFim, OpEntrada, OpSaida:integer;
begin
     case rgFiltroNome.ItemIndex of
        0: begin
                NomeInicio:=1;               //mostra todos nomes
                NomeFim:=zqCliente.RecordCount-1;
           end;
         1:begin
                NomeInicio:=DBlcbNome.KeyValue;
                NomeFim:=NomeInicio;           //mostra nome selecionado
           end;
     end;
     case rgFiltroOperacao.ItemIndex of
        0: begin
                OpEntrada:=-1;  //mosta todos os registros
                OpSaida:=-1;
           end;
        1: begin
                OpEntrada:=0;  //mostra registros de entrada
                OpSaida:=-1;
            end;
        2: begin
                OpEntrada:=-1;
                OPSaida:=0;   //mostra registros de saida
           end;
     end;
     ztMovLoteCoco.Filtered:=False;
     ztMovLoteCoco.Filter:='IDCliente >=' +intToStr(NomeInicio)+'and IDCliente <='+IntToStr(NomeFim)+
     'and IDRomEntradaCoco <>'+IntToStr(OpEntrada)+'and IDRomSaidaCoco <>'+IntToStr(OpSaida);
     ztMovLoteCoco.Filtered:=True;
end;

procedure TfMovLoteCoco.rgFiltroNomeClick(Sender: TObject);
begin
  AplicaFiltro;
end;

procedure TfMovLoteCoco.rgFiltroOperacaoClick(Sender: TObject);
begin
  AplicaFiltro;
end;

procedure TfMovLoteCoco.DBlcbNomeChange(Sender: TObject);
begin
   AplicaFiltro;
end;

end.

