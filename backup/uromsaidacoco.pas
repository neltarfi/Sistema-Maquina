unit uRomSaidaCoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls,
  DBExtCtrls, StdCtrls, DBGrids, ExtCtrls, ZDataset, ZAbstractRODataset;

type

  { TfRomSaidaCoco }

  TfRomSaidaCoco = class(TForm)
    btBuscaNome: TButton;
    Button2: TButton;
    btCancelar: TButton;
    btSalvar: TButton;
    btSair: TButton;
    dsLoteCoco: TDataSource;
    dsCliente: TDataSource;
    dsRomSaidaCoco: TDataSource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBGrid1: TDBGrid;
    dbcCliente: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
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
    ztRomSaidaCocoIDRomSaidaCoco: TZInt64Field;
    ztRomSaidaCocoObs: TZRawCLobField;
    ztRomSaidaCocoPesoSaidaSimples: TZInt64Field;
    ztRomSaidaCocoPesoVendido: TZInt64Field;
    ztRomSaidaCocoRenda: TZInt64Field;
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

