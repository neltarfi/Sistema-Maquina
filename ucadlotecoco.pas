unit uCadLoteCoco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ExtCtrls, DBCtrls, Buttons, ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfCadLoteCoco }
  TfCadLoteCoco = class(TForm)
    btSair: TBitBtn;
    btSalvar: TBitBtn;
    btCancelar: TBitBtn;
    btEditar: TBitBtn;
    btNovo: TBitBtn;
    btApurarBeneficio: TButton;
    btBuscaLoteBica: TButton;
    btBuscaLoteCafeBom: TButton;
    btBuscaLoteEscolha: TButton;
    dbcLoteLimpoBica: TDBLookupComboBox;
    dbcLoteLimpoCafeBom: TDBLookupComboBox;
    dbcLoteLimpoEscolha: TDBLookupComboBox;
    dbeBica: TDBEdit;
    dbeCafeBom: TDBEdit;
    dbeEscolha: TDBEdit;
    dsLoteLimpo: TDataSource;
    dbcTulha: TDBComboBox;
    dbeID: TDBEdit;
    dbeNome: TDBEdit;
    dbeObs: TDBEdit;
    dbeSafra: TDBEdit;
    dsLoteCoco: TDataSource;
    dbgLoteCoco: TDBGrid;
    edtBuscar: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    pnFiltro: TPanel;
    pnApurar: TPanel;
    pnBotaoEditar: TPanel;
    pnBotaoSalvar: TPanel;
    pnBotao: TPanel;
    pnEditar: TPanel;
    rgFiltro: TRadioGroup;
    rgStatus: TDBRadioGroup;
    zqNovoIDLoteCoco: TZQuery;
    zqNovoIDLoteCocoID: TZInt64Field;
    zqLoteLimpoIDLoteLimpo: TZInt64Field;
    zqLoteLimpoNomeDoLoteLimpo: TZRawStringField;
    zqLoteLimpoSaldo: TZDoubleField;
    zqLoteLimpoStatus: TZRawStringField;
    zqNovoIDMovLoteLimpo: TZQuery;
    zqLoteLimpo: TZQuery;
    zqNovoIDMovLoteLimpoID: TZIntegerField;
    ztLoteCocoBica: TZDoubleField;
    ztLoteCocoCafeBom: TZDoubleField;
    ztLoteCocoEscolha: TZDoubleField;
    ztLoteCocoIDLoteCoco: TZIntegerField;
    ztLoteCocoNomeLoteCoco: TZRawStringField;
    ztLoteCocoObs: TZRawStringField;
    ztLoteCocoSafra: TZRawStringField;
    ztLoteCocoStatus: TStringField;
    ztLoteCocoTulha: TZRawStringField;
    ztLoteLimpo: TZTable;
    ztLoteLimpoIDLoteLimpo: TZInt64Field;
    ztLoteLimpoSaldo: TZDoubleField;
    ztMovLoteLimpo: TZTable;
    ztLoteCoco: TZTable;
    ztMovLoteLimpoData: TZDateField;
    ztMovLoteLimpoHistorico: TZRawStringField;
    ztMovLoteLimpoIDCliente: TZInt64Field;
    ztMovLoteLimpoIDLoteLimpo: TZInt64Field;
    ztMovLoteLimpoIDMovLoteLimpo: TZInt64Field;
    ztMovLoteLimpoPesoEntrada: TZDoubleField;
    ztMovLoteLimpoPesoSaida: TZDoubleField;
    ztMovLoteLimpoStatus: TZRawStringField;
    procedure btApurarBeneficioClick(Sender: TObject);
    procedure btBuscaLoteBicaClick(Sender: TObject);
    procedure btBuscaLoteCafeBomClick(Sender: TObject);
    procedure btBuscaLoteEscolhaClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure dbgLoteCocoCellClick(Column: TColumn);
    procedure dbgLoteCocoDblClick(Sender: TObject);
    procedure dbgLoteCocoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBuscarChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rgFiltroClick(Sender: TObject);
    function SalvarTrue:boolean;
    procedure EditarTrue();
    procedure EditarFalse();
    procedure SelecionaFiltro();
    procedure AplicaFiltro();
    procedure IncluiRegistro(ID:integer;PesoCafe:string);
    procedure AbreDB;
    procedure FechaDB;
  private

  public

  end;

var
  fCadLoteCoco: TfCadLoteCoco;
  Filtrorg:string;
  Botao:String;
  ModoEdicao:boolean;//não deixa sair do form se estiver em modo de edição ou adição
                     //de registro sem cancelar os datasets.

implementation
uses uFuncoes, uCadLoteLimpo, uPrincipal;

{$R *.lfm}

{ TfCadLoteCoco }

procedure TfCadLoteCoco.FormShow(Sender: TObject);
begin
  AbreDB;
  SelecionaFiltro;
  AplicaFiltro;
  EditarFalse;
  ztLoteCoco.Last;
  SomenteLeitura:=True;//desabilita botoes de edição do seguendo Form Aberto
end;


procedure TfCadLoteCoco.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
    if ModoEdicao then begin
       ztLoteCoco.Cancel;
       FechaDB;
       fPrincipal.zConn.Rollback;
    end;
    SomenteLeitura:=False;
end;

procedure TfCadLoteCoco.AbreDB;
begin
     zqNovoIDLoteCoco.Open;
     zqLoteLimpo.Open;
     ztLoteLimpo.Open;
     ztMovLoteLimpo.Open;
     zqNovoIDMovLoteLimpo.Open;
     ztLoteCoco.Open;
end;

procedure TfCadLoteCoco.FechaDB;
begin
     zqNovoIDLoteCoco.Active:=False;
     zqLoteLimpo.Active:=False;
     ztLoteLimpo.Active:=False;
     ztMovLoteLimpo.Active:=False;
     zqNovoIDMovLoteLimpo.Active:=False;
     ztLoteCoco.Active:=False;
end;

procedure TfCadLoteCoco.btNovoClick(Sender: TObject);
begin
  try
  fPrincipal.zConn.StartTransaction;
  ztLoteCoco.Append;
  zqNovoIDLoteCoco.Refresh;
  ztLoteCocoIDLoteCoco.Value:= zqNovoIDLoteCocoID.Value + 1;
  rgStatus.ItemIndex:=0;
  dbeCafeBom.Text:='0';
  dbeBica.Text:='0';
  dbeEscolha.Text:='0';
  Botao:='Novo';
  EditarTrue;
  except
  MessageDlg('Erro ao tentar criar nova transação', mtError,[mbOk], 0);
  end;
end;

procedure TfCadLoteCoco.btEditarClick(Sender: TObject);
begin
  try
  fPrincipal.zConn.StartTransaction;
  ztLoteCoco.Edit;
  Botao:='Editar';
  EditarTrue;
  except
  MessageDlg('Erro ao tentar editar transação', mtError,[mbOk], 0);
  end;
end;

procedure TfCadLoteCoco.btCancelarClick(Sender: TObject);
begin
    EditarFalse;
    ztLoteCoco.Cancel;
    fPrincipal.zConn.Rollback;
    AplicaFiltro;
end;

procedure TfCadLoteCoco.btSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfCadLoteCoco.btApurarBeneficioClick(Sender: TObject);
begin
  Botao:='ApurarBeneficio';
  pnApurar.Enabled:=True;
  btCancelar.SetFocus;
  pnEditar.Enabled:=False;
end;

procedure TfCadLoteCoco.dbgLoteCocoCellClick(Column: TColumn);
begin
  EditarFalse;
end;

procedure TfCadLoteCoco.dbgLoteCocoDblClick(Sender: TObject);
begin
  EditarFalse;
end;

procedure TfCadLoteCoco.dbgLoteCocoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EditarFalse;
end;

procedure TfCadLoteCoco.edtBuscarChange(Sender: TObject);
begin
   AplicaFiltro;
   EditarFalse;
end;

procedure TfCadLoteCoco.btSalvarClick(Sender: TObject);
begin
     if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
        [mbYes, mbNO], 0) = mrYes) then  Exit;
     if not(SalvarTrue) then Exit;
     try
     ztLoteCoco.Filtered:=False;
     if Botao='ApurarBeneficio' then
     begin
          rgStatus.ItemIndex:=1;
          ztLoteLimpo.Active:=True;
          ztMovLoteLimpo.Active:=True;
          zqNovoIDMovLoteLimpo.Active:=True;
          if strToFloat(dbeCafeBom.Text)>0 then
             IncluiRegistro(dbcLoteLimpoCafeBom.KeyValue,dbeCafeBom.Text);
          if strToFloat(dbeBica.Text)>0 then
             IncluiRegistro(dbcLoteLimpoBica.KeyValue,dbeBica.Text);
          if strToFloat(dbeEscolha.Text)>0 then
             IncluiRegistro(dbcLoteLimpoEscolha.KeyValue,dbeEscolha.Text);
          ztLoteLimpo.Active:=False;
          ztMovLoteLimpo.Active:=False;
          zqNovoIDMovLoteLimpo.Active:=False;
     end;
     ztLoteCoco.Post;
     fPrincipal.zConn.Commit;
     AplicaFiltro;
     except
     ztLoteLimpo.Cancel;
     ztLoteCoco.Cancel;
     ztMovLoteLimpo.Cancel;
     fPrincipal.zConn.Rollback;
     MessageDlg('Erro ao tentar salvar nova transação', mtError,[mbOk], 0);
     end;
     EditarFalse;
end;

procedure TfCadLoteCoco.IncluiRegistro(ID:integer;PesoCafe:string);
begin
     ztMovLoteLimpo.Append;
     zqNovoIDMovLoteLimpo.Refresh;
     ztMovLoteLimpoIDMovLoteLimpo.Value:=zqNovoIDMovLoteLimpoID.Value+1;
     ztMovLoteLimpoIDLoteLimpo.Value:=ID;
     ztMovLoteLimpoIDCliente.Value:=0;
     ztMovLoteLimpoData.Text:=dateToStr(Date);
     ztMovLoteLimpoHistorico.Value:='Benef.lote coco nº '+ dbeID.Text;
     ztMovLoteLimpoPesoEntrada.Value:=strToFloat(PesoCafe);
     ztMovLoteLimpoPesoSaida.Value:=0;
     ztMovLoteLimpoStatus.Value:='Ativo';
     ztMovLoteLimpo.Post;

//**********************************
//* Atualiza o saldo no Lote Limpo *
//**********************************
     ztLoteLimpo.Filtered:=False;
     ztLoteLimpo.Filter:='(IDLoteLimpo = ' + QuotedStr(floatToStr(ID)) +')';
     ztLoteLimpo.Filtered:=True;
     ztLoteLimpo.Edit;
     ztLoteLimpoSaldo.Value:=ztLoteLimpoSaldo.Value + StrToFloat(PesoCafe);
     ztLoteLimpo.Post;
end;

function TfCadLoteCoco.SalvarTrue:boolean;
var erro:string;
begin
  SalvarTrue:=True;
  Erro:='';
  if  (length(dbeNome.Text))=0 then
     Erro:='-Campo Nome não pode ficar vaziu.'+ chr(13);
  if dbeID.Text='' then
     Erro:=Erro+'-Não ha registro a serem editados.'+ chr(13);
  if dbeSafra.Text='' then
     Erro:=Erro+'-O Campo Safra não pode ser vazio.'+ chr(13);
  if dbcTulha.Text='' then
     Erro:=Erro+'-O Campo Tulha não pode ser vazio.'+ chr(13);
  if Botao='ApurarBeneficio' then
  begin
       if (not (FloatTrue(dbeCafeBom.Text,3))) or
          (strTofloat(dbeCafeBom.Text)<0) or
          (dbeCafeBom.Text='') then
          Erro:=Erro+'-o valor do campo Café Bom não é válido.'+ chr(13);
       if (not (FloatTrue(dbeBica.Text,3))) or
          (strTofloat(dbeBica.Text)<0) or (dbeBica.Text='') then
          Erro:=Erro+'-o valor do campo Bica não é válido.'+ chr(13);
       if (not (FloatTrue(dbeEscolha.Text,3))) or
          (strTofloat(dbeEscolha.Text)<0) or (dbeEscolha.Text='') then
          Erro:=Erro+'-o valor do campo Escolha não é válido.'+ chr(13);
       if (SalvarTrue) and
          ((strToFloat(dbeCafeBom.Text))+(strToFloat(dbeBica.Text))+(strToFloat(dbeEscolha.Text))=0) then
          Erro:=Erro+'-A soma dos Campos Café bom, Bica e Escolha não pode ser menor que um.'+ chr(13);
      if  (strToFloat(dbeCafeBom.Text)>0)and
         (dbcLoteLimpoCafeBom.KeyValue=Null) then
         Erro:=Erro+'-O Valor do Lote Café bom não é válido.'+ chr(13);
      if (strToFloat(dbeBica.Text)>0)and
         (dbcLoteLimpoBica.KeyValue=Null) then
         Erro:=Erro+'-O Valor do Lote Bica não é válido.'+ chr(13);
      if (strToFloat(dbeEscolha.Text)>0)and
         (dbcLoteLimpoEscolha.KeyValue=Null) then
         Erro:=Erro+'-O Valor do Lote Escolha não é válido.'+ chr(13);
      if  (strToFloat(dbeCafeBom.Text)=0)and
         (dbcLoteLimpoCafeBom.KeyValue<>Null) then
         Erro:=Erro+'-O Valor do campo Café Bom não pode ser zero quando tem um lote selecionado para ele.'+ chr(13);
      if (strToFloat(dbeBica.Text)=0)and
         (dbcLoteLimpoBica.KeyValue<>Null) then
         Erro:=Erro+'-O Valor do campo Bica não pode ser zero quando tem um lote selecionado para ele.'+ chr(13);
      if (strToFloat(dbeEscolha.Text)=0)and
         (dbcLoteLimpoEscolha.KeyValue<>Null) then
         Erro:=Erro+'-O Valor do campo Escolha não pode ser zero quando tem um lote selecionado para ele.'+ chr(13);
      if (strToFloat(dbeCafeBom.Text)>0)and
         (strToFloat(dbeBica.Text)>0)and
         (dbcLoteLimpoCafeBom.KeyValue<>Null)and
         (dbcLoteLimpoBica.KeyValue<>Null)and
         (dbcLoteLimpoCafeBom.KeyValue=dbcLoteLimpoBica.KeyValue) then
         Erro:=Erro+'-O Valor do Lote Bica não pode ser igual o Lote Café Bom.'+ chr(13);
      if (strToFloat(dbeCafeBom.Text)>0)and
         (strToFloat(dbeEscolha.Text)>0)and
         (dbcLoteLimpoCafeBom.KeyValue<>Null)and
         (dbcLoteLimpoEscolha.KeyValue<>Null)and
        dbcLoteLimpoCafebom.KeyValue=dbcLoteLimpoEscolha.KeyValue then
        Erro:=Erro+'-O Valor do Lote Escolha não pode ser igual o Lote Café Bom.'+ chr(13);
      if
         (strToFloat(dbeBica.Text)>0)and
         (strToFloat(dbeEscolha.Text)>0)and
         (dbcLoteLimpoBica.KeyValue<>Null)and
         (dbcLoteLimpoEscolha.KeyValue<>Null)and
         (dbcLoteLimpoBica.KeyValue=dbcLoteLimpoEscolha.KeyValue) then
         Erro:=Erro+'-O Valor do Lote Escolha não pode ser igual o Lote Bica.'+ chr(13);
  end;
  if not(Erro = '') then
  begin
       MessageDlg(Erro, mtError,[mbOk], 0);
       SalvarTrue:=False;
  end;
end;

procedure TfCadLoteCoco.EditarTrue();
Begin
  dbgLoteCoco.Enabled:=False;
  pnEditar.Enabled:=True;
  pnBotaoSalvar.Enabled:=True;
  pnBotaoEditar.Enabled:=False;
  btSair.Enabled:=False;
  pnFiltro.Enabled:=False;
  ModoEdicao:=True;
  if (Botao='Novo') then
     btApurarBeneficio.Enabled:=False
  else
  btApurarBeneficio.Enabled:=True;
end;

procedure TfCadLoteCoco.EditarFalse();
begin
  dbgLoteCoco.Enabled:=True;
  dbeID.ReadOnly:=True;
  pnFiltro.Enabled:=True;
  pnEditar.Enabled:=False;
  rgStatus.Enabled:=False;
  pnApurar.Enabled:=False;
  dbcLoteLimpoEscolha.KeyValue:=Null;
  pnBotaoEditar.Enabled:=True;
  btSair.Enabled:=True;
  pnBotaoSalvar.Enabled:=False;
  ModoEdicao:=False;
  if ztLoteCocoStatus.Value='Ativo' then
  begin
     btEditar.Enabled:=True;
     if (ztLoteCoco.RecordCount < 1) then btEditar.Enabled:=False;
  end
  else
    btEditar.Enabled:=False;
  end;

procedure TfCadLoteCoco.rgFiltroClick(Sender: TObject);
begin
  SelecionaFiltro;
  AplicaFiltro;
  EditarFalse;
  ztLoteCoco.Cancel;
end;

procedure TfCadLoteCoco.SelecionaFiltro();
begin
  if rgFiltro.ItemIndex=0 then
     Filtrorg:='Fechado'
  else
    Filtrorg:='Ativo';
end;

procedure TfCadLoteCoco.AplicaFiltro();
var temp:integer;
begin
  temp:=ztLoteCocoIDLoteCoco.Value;
  ztLoteCoco.Filtered:=False;
  if Filtrorg='Ativo' then
     ztLoteCoco.Filter:='((NomeLoteCoco LIKE '+ QuotedStr('*'+edtBuscar.Text+'*')+') and (Status = '+QuotedStr('Ativo')+'))'
  else
     ztLoteCoco.Filter:='((NomeLoteCoco LIKE '+ QuotedStr('*'+edtBuscar.Text+'*')+') and ((Status = '+QuotedStr('Ativo')+') or (Status = '+QuotedStr('Fechado')+')))';
  ztLoteCoco.Filtered:=true;
  ztLoteCoco.Locate('IDLoteCoco',temp,[]);
 end;

procedure TfCadLoteCoco.btBuscaLoteBicaClick(Sender: TObject);
var temp:integer;
begin
  fCadLoteLimpo:=TfCadLoteLimpo.Create(Self);
    temp:=fCadLoteLimpo.ShowModal;
    zqLoteLimpo.Refresh;
    fCadLoteLimpo.Destroy;
    dbcLoteLimpoBica.KeyValue:=temp;
end;

procedure TfCadLoteCoco.btBuscaLoteCafeBomClick(Sender: TObject);
var temp:integer;
begin
  fCadLoteLimpo:=TfCadLoteLimpo.Create(Self);
    temp:=fCadLoteLimpo.ShowModal;
    zqLoteLimpo.Refresh;
    fCadLoteLimpo.Destroy;
    dbcLoteLimpoCafeBom.KeyValue:=temp;
end;

procedure TfCadLoteCoco.btBuscaLoteEscolhaClick(Sender: TObject);
var temp:integer;
begin
  fCadLoteLimpo:=TfCadLoteLimpo.Create(Self);
    temp:=fCadLoteLimpo.ShowModal;
    zqLoteLimpo.Refresh;
    fCadLoteLimpo.Destroy;
    dbcLoteLimpoEscolha.KeyValue:=temp;
end;

end.

