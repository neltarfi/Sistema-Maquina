unit umovlotecoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, DBCtrls, Buttons, DateTimePicker, ZDataset, ZAbstractRODataset;

type

  { TfMovLoteCoco }

  TfMovLoteCoco = class(TForm)
    btAtualiza: TBitBtn;
    btEntrada: TButton;
    btSaida: TButton;
    btSair: TBitBtn;
    BuscaNome: TButton;
    dbeCliente: TDBEdit;
    dbeIDCliente: TDBEdit;
    DBNavigator1: TDBNavigator;
    dsCliente: TDataSource;
    DBlcbNome: TDBLookupComboBox;
    dsMovLoteCoco: TDataSource;
    DBGrid1: TDBGrid;
    dtpFim: TDateTimePicker;
    dtpInicio: TDateTimePicker;
    edtPosicao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblRegistros: TLabel;
    rgFiltroPeriodo: TRadioGroup;
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
    ztMovLoteCocoRAZAO: TStringField;
    procedure btAtualizaClick(Sender: TObject);
    procedure btEntradaClick(Sender: TObject);
    procedure btSaidaClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure BuscaNomeClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBlcbNomeChange(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure edtPosicaoChange(Sender: TObject);
    procedure edtPosicaoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AplicaFiltro(Evento:string);
    procedure rgFiltroNomeClick(Sender: TObject);
    procedure rgFiltroOperacaoClick(Sender: TObject);
    procedure rgFiltroPeriodoClick(Sender: TObject);
  private

  public

  end;

var
  fMovLoteCoco: TfMovLoteCoco;
  FormOperacao:string;

implementation

uses uRomEntCoco, uPrincipal, uCadCliente, uRomSaidaCoco, uFuncoes;

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

procedure TfMovLoteCoco.btAtualizaClick(Sender: TObject);
begin
  AplicaFiltro('Navigator');
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
    AplicaFiltro('Navigator');
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
  rgFiltroPeriodo.ItemIndex:=0;
  FormCadastroSomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
  ztMovLoteCoco.Last;
  edtPosicao.Text:=intToStr(ztMovLoteCoco.RecNo);
end;
procedure TfMovLoteCoco.AplicaFiltro(Evento:string);
var NomeInicio, NomeFim, OpEntrada, OpSaida:integer;
    DataInicio, DataFim:string;
    Ponteiro:integer;
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
     case rgFiltroPeriodo.ItemIndex of
        0:begin
              DataInicio:='01/01/0000';
              DataFim:='31/12/9999';     //mostra todos os registros
          end;
        1:begin
              DataInicio:=dateToStr(dtpInicio.Date);
              DataFim:=dateToStr(dtpFim.DATE);   //mostra os registros do periodo
          end;

     end;
     ztMovLoteCoco.Filtered:=False;
     ztMovLoteCoco.Filter:='IDCliente >=' +intToStr(NomeInicio)+'and IDCliente <='+IntToStr(NomeFim)+
     'and IDRomEntradaCoco <>'+IntToStr(OpEntrada)+'and IDRomSaidaCoco <>'+IntToStr(OpSaida)+
     'and Data >= '+QuotedStr(DataInicio)+' and Data <= '+QuotedStr(DataFim);
     ztMovLoteCoco.Filtered:=True;

     lblRegistros.Caption:=IntToStr(ztMovLoteCoco.RecordCount);
     case Evento of
            //Coloca a posição do registro atual no edtPosicao
           'Navigator':edtPosicao.Text:=intToStr(ztMovLoteCoco.RecNo);

           //Encontra o registro em ztmovLoteCoco equivalente ao edtPosicao
           'ExitEdit':begin
                      if (strToInt(edtPosicao.Text) > ztMovLoteCoco.RecordCount) or
                         (strToInt(edtPosicao.Text) = 0) then begin
                         edtPosicao.Text:='';
                         Exit;
                      end;
                      ztMovLoteCoco.RecNo:=strToInt(edtPosicao.Text);
                      ztMovLoteCoco.Refresh;
                      end;
     end;
end;

procedure TfMovLoteCoco.rgFiltroNomeClick(Sender: TObject);
begin
  AplicaFiltro('Navigator');
end;

procedure TfMovLoteCoco.rgFiltroOperacaoClick(Sender: TObject);
begin
  AplicaFiltro('Navigator');
end;

procedure TfMovLoteCoco.rgFiltroPeriodoClick(Sender: TObject);
begin
  AplicaFiltro('Navigator');
end;

procedure TfMovLoteCoco.DBlcbNomeChange(Sender: TObject);
begin
   AplicaFiltro('Navigator');
end;

procedure TfMovLoteCoco.DBNavigator1Click(Sender: TObject;
  Button: TDBNavButtonType);
begin
    AplicaFiltro('Navigator');
end;

procedure TfMovLoteCoco.edtPosicaoChange(Sender: TObject);
begin
  AceitaInteiro(edtPosicao);
end;

procedure TfMovLoteCoco.edtPosicaoExit(Sender: TObject);
begin
  AplicaFiltro('ExitEdit');
end;

end.

