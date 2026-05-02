unit ueditaCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  Buttons, ZDataset, ZAbstractRODataset, ZConnection;

type

  { TfEditaCliente }
  TfEditaCliente = class(TForm)
    btCancelar: TBitBtn;
    btSalvar: TBitBtn;
    dbeID: TDBEdit;
    dbeCidade: TDBEdit;
    dbeEstado: TDBEdit;
    dbeTelefone: TDBEdit;
    dbeCelular: TDBEdit;
    dbeDataReg: TDBEdit;
    dbeRazao: TDBEdit;
    dbeCPF: TDBEdit;
    dbeCNPJ: TDBEdit;
    dbeEndereco: TDBEdit;
    dbeInsEstadual: TDBEdit;
    dbeComplemento: TDBEdit;
    dbeBairro: TDBEdit;
    dbeObs: TDBMemo;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    zqCliente2: TZQuery;
    zqCliente2Razao: TZRawStringField;
    procedure btCancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    function SalvarTrue:boolean;
  private

  public

  end;

var
  fEditaCliente: TfEditaCliente;
  TempModalResult:integer;
  ModoEdicao:boolean;

implementation

uses ucadCliente, uFuncoes, uPrincipal;

{$R *.lfm}

{ TfEditaCliente }

procedure TfEditaCliente.FormShow(Sender: TObject);
var ClientePrincipal:integer;
      Razao:string;

  begin
    fCadCliente.zqCliente.Active:=true;
    fCadCliente.zqNovoIDCliente.Active:=True;
    if ((uCadCliente.botao='Editar')and
       (fCadCliente.zqClienteSerie.Value='Principal'))or
       (uCadCliente.Botao='Novo') then  dbeRazao.Enabled:=True
    else dbeRazao.Enabled:=False;
      Razao:=fCadCliente.zqClienteRazao.Value;
      ClientePrincipal:=fCadCliente.zqClienteIDPrincipal.Value;
      fCadCliente.zqNovoIDCliente.Refresh;
      fCadCliente.zqCliente.Filtered:=False;
      try
      fCadCliente.zConn.StartTransaction;
      case uCadCliente.Botao of
           'Novo':Begin
                       fCadCliente.zqCliente.Append;
                       fCadCliente.zqClienteSerie.Value:='Principal';
                       fCadCliente.zqClienteIDCliente.Value:=(fCadCliente.zqNovoIDClienteID.Value)+1;
                       fCadCliente.zqClienteIDPrincipal.Value:=(fCadCliente.zqNovoIDClienteID.Value)+1;
                       fCadCliente.zqCliente.FieldByName('DataReg').Value:= DATE;
                       fCadCliente.zqClienteStatus.Value:='Ativo';
                  end;
           'NovoAdicional':Begin
                                fCadCliente.zqCliente.Append;
                                fCadCliente.zqClienteSerie.Value:='Adicional';
                                fCadCliente.zqClienteRazao.Value:=Razao;
                                fCadCliente.zqClienteIDCliente.Value:=(fCadCliente.zqNovoIDClienteID.Value)+1;
                                fCadCliente.zqClienteIDPrincipal.Value:=ClientePrincipal;
                                fCadCliente.zqCliente.FieldByName('DataReg').Value:= DATE;
                                fCadCliente.zqClienteStatus.Value:='Ativo';
                           end;
           'Editar':begin

                         fCadCliente.zqCliente.Edit;
                    end;
      end;
      except
      if uCadCliente.Botao='Editar' then
         MessageDlg('Erro ao tentar editar transação', mtError,[mbOk], 0)
      else MessageDlg('Erro ao tentar Adicionar nova transação', mtError,[mbOk], 0);
      btCancelar.Enabled:=False;
      fCadCliente.zqCliente.Cancel;
      fCadCliente.zConn.Rollback;
      ModoEdicao:=True;
      Close
      end;
end;
 
procedure TfEditaCliente.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if ModoEdicao then begin
     fCadCliente.zqCliente.Cancel;
     fCadCliente.zConn.Rollback;
  end;
     zqCliente2.Active:=False;
   fEditaCliente.ModalResult:=TempModalResult;
end;

procedure TfEditaCliente.btCancelarClick(Sender: TObject);
begin
  TempModalResult:=  fCadCliente.zqClienteIDCliente.Value;
  Close;
end;

procedure TfEditaCliente.btSalvarClick(Sender: TObject);
var
  Principal, Cliente:integer;
  Razao:string;
begin
  if not(MessageDlg('Você deseja realmente salvar?', mtConfirmation,
     [mbYes, mbNO], 0) = mrYes) then  Exit;
  zqCliente2.Active:=True;
  if not(SalvarTrue) then Exit;
  Razao:=fCadCliente.zqClienteRazao.Value;
  Cliente:=fCadCliente.zqClienteIDCliente.Value;
  Principal:=fCadCliente.zqClienteIDprincipal.Value;
  try
  fCadCliente.zqCliente.Post;
  btCancelar.Enabled:=False;
  if (uCadCliente.Botao='Editar')and(fCadCliente.zqClienteSerie.Value='Principal') then
     begin
          fCadCliente.zqCliente.Filtered:=false;
          fCadCliente.zqCliente.Filter:='(IdPrincipal = '+QuotedStr(intToStr(Principal))+')';
          fCadCliente.zqCliente.Filtered:=True;
          fCadCliente.zqCliente.First;
          while not(fCadCliente.zqCliente.EOF) do
          begin
               if not(fCadCliente.zqCliente.EOF)and
               (fCadCliente.zqClienteSerie.Value='Adicional') then
               begin
                    fCadCliente.zqCliente.Edit;
                    fCadCliente.zqClienteRazao.Value:=Razao;
                    fCadCliente.zqCliente.Post;
               end;
               fCadCliente.zqCliente.Next;
          end;
     end;
  fCadCliente.zConn.Commit;
  except
  fCadCliente.zqCliente.Cancel;
  fCadCliente.zConn.Rollback;
  MessageDlg('Erro ao tentar salvar nova transação', mtError,[mbOk], 0);
  end;
  TempModalResult:=  fCadCliente.zqClienteIDCliente.Value;
  fCadCliente.edtBuscar.Text:='';
  ModoEdicao:=False;
  Close;
end;

function TfEditaCliente.SalvarTrue:boolean;
var Erro:string;
begin
  SalvarTrue:=True;
  Erro:='';
  if (length(dbeRazao.Text))=0 then
     Erro:='-Campo Razão Social não pode ficar vazio.'+ chr(13);
  if (zqCliente2.Locate('Razao', dbeRazao.Text,[])) and
     (uCadCliente.Botao='Novo') then
     Erro:=Erro+'-O valor do Campo Razão Social já existe.'+ chr(13);
  if (length(dbeEndereco.Text))=0 then
     Erro:=Erro+'-Campo Endereço não pode ficar vazio.'+ chr(13);
  if (length(dbeCPF.Text)>0) and
     (not(IntegerTrue(dbeCPF.Text))) or
     (not(cpf(dbeCPF.Text))and(length(dbeCPF.Text)>0)) then
     Erro:=Erro+'-Campo CPF é inválido.'+ chr(13);
  if (length(dbeCNPJ.Text)>0) and
     (not(IntegerTrue(dbeCNPJ.Text))) or
     (not(cnpj(dbeCNPJ.Text))and(length(dbeCNPJ.Text)>0)) then
     Erro:=Erro+'-Campo CNPJ é inválido.'+ chr(13);
  if ((length(dbeInsEstadual.Text)>0) and
     (not(IntegerTrue(dbeInsEstadual.Text)))) then
     Erro:=Erro+'-Campo Inscrição Estadual é inválido.'+ chr(13);
  if (length(dbeTelefone.Text)>0) and
     (not(IntegerTrue(dbeTelefone.Text))) then
     Erro:=Erro+'-Campo Telefone é inválido.'+ chr(13);
  if (length(dbeCelular.Text)>0) and
     (not(IntegerTrue(dbeCelular.Text))) then
     Erro:=Erro+'-Campo Celular é inválido.'+ chr(13);
  if dbeID.Text='' then
     Erro:=Erro+'-Não ha registro a serem editados.'+ chr(13);
  if not(Erro = '') then
  begin
       MessageDlg(Erro, mtError,[mbOk], 0);
       SalvarTrue:=False;
  end;
end;

end.

