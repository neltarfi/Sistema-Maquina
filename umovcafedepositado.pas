unit uMovCafeDepositado;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  DBCtrls, StdCtrls, Buttons, DateTimePicker, ZDataset, ZAbstractRODataset;

type

  { TfMovCafeDepositado }

  TfMovCafeDepositado = class(TForm)
    btAtualiza: TBitBtn;
    btSair: TBitBtn;
    BuscaNome: TButton;
    DBGrid1: TDBGrid;
    dsRomCompraCoco: TDataSource;
    DBlcbNome: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    dsCliente: TDataSource;
    dtpFim: TDateTimePicker;
    dtpInicio: TDateTimePicker;
    edtPosicao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblRegistros: TLabel;
    rgFiltroNome: TRadioGroup;
    rgFiltroPeriodo: TRadioGroup;
    zqCliente: TZQuery;
    zqClienteIDCLIENTE: TZIntegerField;
    zqClienteIDPRINCIPAL: TZIntegerField;
    zqClienteRAZAO: TZRawStringField;
    zqRomCompraCoco: TZQuery;
    zqRomCompraCocoALIQUOTA: TZBCDField;
    zqRomCompraCocoDATA: TZDateField;
    zqRomCompraCocoHISTORICO: TZRawStringField;
    zqRomCompraCocoIDCLIENTE: TZIntegerField;
    zqRomCompraCocoIDCONTACORRENTE: TZIntegerField;
    zqRomCompraCocoIDROMCOMPRACOCO: TZIntegerField;
    zqRomCompraCocoIDROMENTRADACOCO: TZIntegerField;
    zqRomCompraCocoPESOCOCO: TZIntegerField;
    zqRomCompraCocoPORCFUNDORURAL: TZIntegerField;
    zqRomCompraCocoSACOKG: TZRawStringField;
    zqRomCompraCocoSTATUS: TZRawStringField;
    zqRomCompraCocoVALOR: TZBCDField;
    procedure btAtualizaClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AplicaFiltro(Evento:string);
    procedure rgFiltroNomeClick(Sender: TObject);
    procedure rgFiltroPeriodoClick(Sender: TObject);
  private

  public

  end;

var
  fMovCafeDepositado: TfMovCafeDepositado;

implementation

{$R *.lfm}

{ TfMovCafeDepositado }

procedure TfMovCafeDepositado.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfMovCafeDepositado.btAtualizaClick(Sender: TObject);
begin
  AplicaFiltro('Navigator');
end;

procedure TfMovCafeDepositado.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  zqCliente.Close;
  zqRomCompraCoco.Close;
end;

procedure TfMovCafeDepositado.FormShow(Sender: TObject);
begin
  zqCliente.Open;
  zqRomCompraCoco.Open;
  dblcbNome.KeyValue:=0;
  rgFiltroNome.ItemIndex:=0;
  rgFiltroPeriodo.ItemIndex:=0;
  zqRomCompraCoco.Last;
  edtPosicao.Text:=intToStr(zqRomCompraCoco.RecNo);
end;
procedure TfMovCafeDepositado.AplicaFiltro(Evento:string);
var NomeInicio, NomeFim:integer;
    DataInicio, DataFim:string;
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
     zqRomCompraCoco.Filtered:=False;
     zqRomCompraCoco.Filter:='IDCLIENTE >='+IntToStr(NomeInicio)+'and IDCLIENTE <='+intToStr(NomeFim)+
     'and DATA >= '+QuotedStr(DataInicio)+' and DATA <= '+QuotedStr(DataFim);
     zqRomCompraCoco.Filtered:=True;

     lblRegistros.Caption:=IntToStr(zqRomCompraCoco.RecordCount);
     case Evento of
            //Coloca a posição do registro atual no edtPosicao
           'Navigator':edtPosicao.Text:=intToStr(zqRomCompraCoco.RecNo);

           //Encontra o registro em ztmovLoteCoco equivalente ao edtPosicao
           'ExitEdit':begin
                      if (strToInt(edtPosicao.Text) > zqRomCompraCoco.RecordCount) or
                         (strToInt(edtPosicao.Text) = 0) then begin
                         edtPosicao.Text:='';
                         Exit;
                      end;
                      zqRomCompraCoco.RecNo:=strToInt(edtPosicao.Text);
                      zqRomCompraCoco.Refresh;
                      end;
     end;
end;

procedure TfMovCafeDepositado.rgFiltroNomeClick(Sender: TObject);
begin
   AplicaFiltro('Navigator');
end;

procedure TfMovCafeDepositado.rgFiltroPeriodoClick(Sender: TObject);
begin
  AplicaFiltro('Navigator');
end;

end.

