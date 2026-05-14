unit uCadLoteLimpo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ExtCtrls, DBCtrls, Buttons, ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfCadLoteLimpo }

  TfCadLoteLimpo = class(TForm)
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    btCancelar: TBitBtn;
    btEditar: TBitBtn;
    btNovo: TBitBtn;
    dbgLoteLimpoGrid: TDBGrid;
    dsLoteLimpo: TDataSource;
    dbeID: TDBEdit;
    dbeNome: TDBEdit;
    dbeSaldo: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    rgStatus: TDBRadioGroup;
    edtBuscar: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rgFiltro: TRadioGroup;
    zqNovoIDLoteLimpo: TZQuery;
    zqNovoIDLoteLimpoID: TZInt64Field;
    ztLoteLimpo: TZTable;
    ztLoteLimpoIDLoteLimpo: TZIntegerField;
    ztLoteLimpoNome: TZRawStringField;
    ztLoteLimpoSaldo: TZDoubleField;
    ztLoteLimpoStatus: TZRawStringField;
    procedure btCancelarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure edtBuscarChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rgFiltroClick(Sender: TObject);
    function SalvarTrue:boolean;
    procedure EditarTrue();
    procedure EditarFalse();
    procedure SelecionaFiltro();
    procedure AplicaFiltro();
    procedure ztLoteLimpoAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  fCadLoteLimpo: TfCadLoteLimpo;
  Filtrorg:string;
  Botao:string;
  TempModalResult:integer;
  ModoEdicao:boolean;//não deixa appoend ou edit aberto se sair do form
implementation
uses
  uPrincipal;

{$R *.lfm}

{ TfCadLoteLimpo }

procedure TfCadLoteLimpo.FormShow(Sender: TObject);
begin
  ztLoteLimpo.Open;
  zqNovoIDLoteLimpo.Open;
  ztLoteLimpo.Open;
  SelecionaFiltro;
  AplicaFiltro;
  ztLoteLimpo.Last;
  TempModalResult:= ztLoteLimpoIDLoteLimpo.Value;
  editarFalse;
  if SomenteLeitura then begin
       btNovo.Enabled:=False;
       btEditar.Enabled:=False;
  end;
end;

procedure TfCadLoteLimpo.ztLoteLimpoAfterScroll(DataSet: TDataSet);
begin
  TempModalResult:= ztLoteLimpoIDLoteLimpo.Value;
  if ztLoteLimpoStatus.Value='Protegido' then begin
     btNovo.Enabled:=False;
     btEditar.Enabled:=False;
  end
  else begin
       btNovo.Enabled:=True;
       btEditar.Enabled:=True;
  end;
end;

procedure TfCadLoteLimpo.btNovoClick(Sender: TObject);
begin
  try
  fPrincipal.zConn.StartTransaction;
  ztLoteLimpo.Append;
  zqNovoIDLoteLimpo.Refresh;
  ztLoteLimpoIDLoteLimpo.Value:= zqNovoIDLoteLimpoID.Value + 1;
  ztLoteLimpoSaldo.Value:=0;
  rgStatus.ItemIndex:=0;
  EditarTrue;
  except
  MessageDlg('Erro ao tentar criar nova transação', mtError,[mbOk], 0);
  end;
end;

procedure TfCadLoteLimpo.btEditarClick(Sender: TObject);
begin
  if (ztLoteLimpoStatus.Value='Protegido') then begin
      MessageDLG('Lote Protegido não pode ser editado',mtError,[mbOk],0);
      EditarFalse;
      Exit;
  end;

  try
  fPrincipal.zConn.StartTransaction;
  ztLoteLimpo.Edit;
  EditarTrue;
  except
  MessageDlg('Erro ao tentar editar transação', mtError,[mbOk], 0);
  end;
end;

procedure TfCadLoteLimpo.btCancelarClick(Sender: TObject);
begin
  EditarFalse;
  ztLoteLimpo.Cancel;
  fPrincipal.zConn.Rollback;
end;

procedure TfCadLoteLimpo.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if ModoEdicao then begin
     ztLoteLimpo.Cancel;
     fPrincipal.zConn.Rollback;
  end;
  ztLoteLimpo.Active:=False;
  zqNovoIDLoteLimpo.Active:=False;
  fCadLoteLimpo.ModalResult:=TempModalResult;
end;

procedure TfCadLoteLimpo.btSairClick(Sender: TObject);
begin
    Close;
end;


procedure TfCadLoteLimpo.btSalvarClick(Sender: TObject);
begin
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes) then  Exit;
  if not(SalvarTrue) then Exit;
  try
  ztLoteLimpo.Filtered:=False;
  ztLoteLimpo.Post;
  fPrincipal.zConn.Commit;
  AplicaFiltro;
  except
  ztLoteLimpo.Cancel;
  fPrincipal.zConn.Rollback;
  MessageDlg('Erro ao tentar salvar nova transação', mtError,[mbOk], 0);
  end;
  EditarFalse;
  TempModalResult:=ztLoteLimpoIDLoteLimpo.Value;
end;

function TfCadLoteLimpo.SalvarTrue:boolean;
var Erro:string;
begin
  SalvarTrue:=True;
  Erro:='';
  if  (length(dbeNome.Text))=0 then
     Erro:='-Campo Nome não pode ficar vaziu.'+ chr(13);
  if dbeID.Text='' then
     Erro:=Erro+'-Não ha registro a serem editados.'+ chr(13);
  if (((dbeSaldo.Text<>'0')and(rgStatus.Value='Fechado'))or
      ((dbeSaldo.Text<>'0')and(rgStatus.Value='Protegido')))then
     Erro:=Erro+'-Não pode fechar um lote que seu saldo não é zero.'+ chr(13);
  if rgStatus.Value='Protegido' then
     Erro:=Erro+'-Ocampo Status não pede ser o valor Protegido.'+ chr(13);
  if not(Erro = '') then
  begin
       MessageDlg(Erro, mtError,[mbOk], 0);
       SalvarTrue:=False;
  end;
end;

procedure TfCadLoteLimpo.EditarTrue();
Begin
   edtBuscar.Enabled:=False;
   dbgLoteLimpoGrid.Enabled:=False;
   btEditar.Enabled:=False;
   btNovo.Enabled:=False;
   btSalvar.Enabled:=True;
   btCancelar.Enabled:=True;
   btSair.Enabled:=False;
   rgFiltro.Enabled:=False;
   rgStatus.Enabled:=True;
   dbeNome.ReadOnly:=False;
   ModoEdicao:=True;
end;

procedure TfCadLoteLimpo.EditarFalse();
begin
  dbgLoteLimpoGrid.Enabled:=True;
  edtBuscar.Enabled:=True;
  btEditar.Enabled:=True;
  btNovo.Enabled:=True;
  rgStatus.Enabled:=False;
  rgFiltro.Enabled:=True;
  dbeNome.ReadOnly:=True;
  btSalvar.Enabled:=False;
  btCancelar.Enabled:=False;
  btSair.Enabled:=True;
  ModoEdicao:=False;
end;

procedure TfCadLoteLimpo.AplicaFiltro();
var temp:integer;
begin
  temp:=ztLoteLimpoIDLoteLimpo.Value;
  ztLoteLimpo.Filtered:=False;
  if Filtrorg='Ativo' then
     ztLoteLimpo.Filter:='((Nome LIKE '+ QuotedStr('*'+edtBuscar.Text+'*')+') and ((Status = '+QuotedStr('Ativo')+') or (Status = '+QuotedStr('Protegido')+')))'
  else
     ztLoteLimpo.Filter:='(Nome LIKE '+ QuotedStr('*'+edtBuscar.Text+'*')+')';
  ztLoteLimpo.Filtered:=true;
  ztLoteLimpo.Locate('IDLoteLimpo',temp,[]);
end;

procedure TfCadLoteLimpo.SelecionaFiltro();
begin
  ztLoteLimpo.Last;
   if rgFiltro.ItemIndex=0 then
     Filtrorg:='Fechado'
  else
    Filtrorg:='Ativo';
end;

procedure TfCadLoteLimpo.rgFiltroClick(Sender: TObject);
begin
  SelecionaFiltro;
  AplicaFiltro;
end;

procedure TfCadLoteLimpo.edtBuscarChange(Sender: TObject);
begin
   AplicaFiltro;
end;

end.

