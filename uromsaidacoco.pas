unit uRomSaidaCoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, memds, fpjsondataset, Forms, Controls,
  Graphics, Dialogs, DBCtrls, DBExtCtrls, StdCtrls, DBGrids, ExtCtrls, ZDataset,
  ZAbstractRODataset;

type

  { TfRomSaidaCoco }

  TfRomSaidaCoco = class(TForm)
    btAdicionar: TButton;
    btBuscaNome: TButton;
    btCancelar: TButton;
    btCancelarReg: TButton;
    btSair: TButton;
    btEscluir: TButton;
    btSalvar: TButton;
    Button2: TButton;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    dsMemLoteCoco: TDataSource;
    dbcCliente: TDBLookupComboBox;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    dsLoteCoco: TDataSource;
    dsCliente: TDataSource;
    dsRomSaidaCoco: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label25: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ZMemLoteCoco: TZMemTable;
    ZMemLoteCocoIDItensRomSaidaCoco: TLongintField;
    ZMemLoteCocoPesoComValor: TLongintField;
    ZMemLoteCocoPesoSemValor: TLongintField;
    ZMemLoteCocoPreco: TCurrencyField;
    ZMemLoteCocoRenda: TLongintField;
    ZMemLoteCocoSacoKg: TStringField;
    ZMemLoteCocoValorTotal: TCurrencyField;
    ztCliente: TZTable;
    ztLoteCoco: TZTable;
    ztClienteIDCliente: TZInt64Field;
    ztClienteRazao: TZRawStringField;
    ztLoteCocoIDLoteCoco: TZInt64Field;
    ztLoteCocoNomeLoteCoco: TZRawStringField;
    ztLoteCocoSafra: TZRawStringField;
    ztLoteCocoSaldoCoco: TZDoubleField;
    ztLoteCocoStatus: TZRawStringField;
    ztLoteCocoTulha: TZRawStringField;
    ztRomSaidaCoco: TZTable;
    ztRomSaidaCocoData: TZDateField;
    ztRomSaidaCocoIDCliente: TZInt64Field;
    ztRomSaidaCocoIDRomSaidaCoco: TZInt64Field;
    ztRomSaidaCocoObs: TZRawCLobField;
    ztRomSaidaCocoPesoComValor: TZInt64Field;
    ztRomSaidaCocoPesoSemValor: TZInt64Field;
    ztRomSaidaCocoValor: TZDoubleField;
    procedure btBuscaNomeClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EditarTrue;
    procedure EditarFalse;
  private

  public

  end;

var
  fRomSaidaCoco: TfRomSaidaCoco;
  SaidaCocoModoEdicao:boolean;

implementation

uses uPrincipal, uCadCliente, uMovCoco;

{$R *.lfm}

{ TfRomSaidaCoco }

procedure TfRomSaidaCoco.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfRomSaidaCoco.btBuscaNomeClick(Sender: TObject);
Var temp:integer;
begin
  fCadCliente:=TfCadCliente.Create(Self);
    temp:=fCadCliente.ShowModal;
    fCadCliente.Destroy;
    ztCliente.Refresh;
    dbcCliente.KeyValue:=temp;
end;

procedure TfRomSaidaCoco.btCancelarClick(Sender: TObject);
begin
  Close;

end;

procedure TfRomSaidaCoco.FormClose(Sender: TObject;
var CloseAction: TCloseAction);
begin
      if SaidaCocoModoEdicao then begin
         ztRomSaidaCoco.Cancel;
         fPrincipal.zConn.Rollback;
      end;
      ztCliente.Close;
      ztLoteCoco.Close;
      ztRomSaidaCoco.Close;
end;

procedure TfRomSaidaCoco.FormShow(Sender: TObject);
begin
  ztCliente.Open;
  ztLoteCoco.Open;
  ztRomSaidaCoco.Open;
  case FormOperacao of
       'InserirRegistro': begin
                               fPrincipal.zConn.StartTransaction;
                               ztRomSaidaCoco.Append;
                               EditarTrue;
                          end;

       'VisualizarRegistro': begin
                                   ztRomSaidaCoco.Locate('IDRomSaidaCoco',
                                   fMovCoco.ztMovCocoIDRomSaidaCoco.Value,[]);
                                   EditarFalse;
                               end;

  end;
end;

procedure TfRomSaidaCoco.EditarTrue;
begin
  SaidaCocoModoEdicao:=True;

end;

procedure TfRomSaidaCoco.EditarFalse;
begin
  SaidaCocoModoEdicao:=False;
end;

end.

