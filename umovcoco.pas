unit uMovCoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, DBCtrls, ZDataset, ZAbstractRODataset;

type

  { TfMovCoco }

  TfMovCoco = class(TForm)
    btEntrada: TButton;
    btSaida: TButton;
    btSair: TButton;
    BuscaNome: TButton;
    dsCliente: TDataSource;
    DBlcbNome: TDBLookupComboBox;
    dsMovCoco: TDataSource;
    DBGrid1: TDBGrid;
    rgFiltroOperacao: TRadioGroup;
    rgFiltroNome: TRadioGroup;
    zqCliente: TZQuery;
    zqClienteIDCliente: TZInt64Field;
    zqClienteIDPrincipal: TZInt64Field;
    zqClienteRazao: TZRawStringField;
    ztMovCoco: TZTable;
    ztMovCocoData: TZDateField;
    ztMovCocoIDCliente: TZInt64Field;
    ztMovCocoIDMovCoco: TZInt64Field;
    ztMovCocoIDRomEntradaCoco: TZInt64Field;
    ztMovCocoIDRomSaidaCoco: TZInt64Field;
    ztMovCocoRazao:TStringField;
    procedure btEntradaClick(Sender: TObject);
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
  fMovCoco: TfMovCoco;
  FormOperacao:string;

implementation

uses uRomEntCoco, uPrincipal, uCadCliente;

{$R *.lfm}

{ TfMovCoco }

procedure TfMovCoco.btEntradaClick(Sender: TObject);
var temp:integer;
begin
  FormOperacao:='InserirRegistro';
  fRomEntCoco:=TfRomEntCoco.Create(self);
  temp:=fRomEntCoco.ShowModal;
  fRomEntCoco.Destroy;
  ztMovCoco.Refresh;
  ztMovCoco.Locate('IDMovCoco',temp,[]);
end;

procedure TfMovCoco.btSaidaClick(Sender: TObject);
begin
   FormOperacao:='InserirRegistro';

end;

procedure TfMovCoco.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfMovCoco.BuscaNomeClick(Sender: TObject);
var temp:integer;
begin
  fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    fCadCliente.Destroy;
    DBlcbNome.KeyValue:=temp;
end;

procedure TfMovCoco.DBGrid1DblClick(Sender: TObject);
begin
  FormOperacao:='VisualizarRegistro';
  if (ztMovCoco.RecordCount>0) then begin             //verifica se tem registros
                                                      //na tabela MovCoco.
     if (ztMovCocoIDRomEntradaCoco.Value)>0 then begin // verifica se é entrada
        fRomEntCoco:=TfRomEntCoco.Create(self);        //ou saída.
        fRomEntCoco.ShowModal;
        fRomEntCoco.Destroy;
     end
     else begin
        {fRomSaidaCoco:=TfRomSaidaCoco.Create(self);
        fRomSaidaCoco.ShowModal;
        fRomSaidaCoco.Destroy;}
     end;

  end;
end;

procedure TfMovCoco.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FormCadastroSomenteLeitura:=False;
  ztMovCoco.Close;
  zqCliente.Close;
end;

procedure TfMovCoco.FormShow(Sender: TObject);
begin
  ztMovCoco.Open;
  zqCliente.Open;
  dblcbNome.KeyValue:=0;
  rgFiltroOperacao.ItemIndex:=0;
  rgFiltroNome.ItemIndex:=0;
  FormCadastroSomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
  ztMovCoco.Last;
end;
procedure TfMovCoco.AplicaFiltro;
var NomeInicio, NomeFim, OpEntrada, OpSaida:integer;
begin
     if rgFiltroNome.ItemIndex=0 then begin
        NomeInicio:=1;
        NomeFim:=zqCliente.RecordCount-1;
     end
     else begin
         NomeInicio:=DBlcbNome.KeyValue;
         NomeFim:=NomeInicio;
     end;
     case rgFiltroOperacao.ItemIndex of
        0: begin
                OpEntrada:=-1;  //mosta todos os registros
                OpSaida:=-1;
           end;
        1: OpEntrada:=0;  //mostra registros de entrada

        2: OPSaida:=0;   //mostra registros de saida
     end;
     ztMovCoco.Filtered:=False;
     ztMovCoco.Filter:='IDCliente >=' +intToStr(NomeInicio)+'and IDCliente <='+IntToStr(NomeFim)+
     'and IDRomEntradaCoco <>'+IntToStr(OpEntrada)+'and IDRomSaidaCoco <>'+IntToStr(OpSaida);
     ztMovCoco.Filtered:=True;
end;

procedure TfMovCoco.rgFiltroNomeClick(Sender: TObject);
begin
  AplicaFiltro;
end;

procedure TfMovCoco.rgFiltroOperacaoClick(Sender: TObject);
begin
  AplicaFiltro;
end;

procedure TfMovCoco.DBlcbNomeChange(Sender: TObject);
begin
   AplicaFiltro;
end;

end.

