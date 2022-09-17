unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, cCadCliente, uEnum;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtIdcliente: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCEP: TMaskEdit;
    Label1: TLabel;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtEmail: TLabeledEdit;
    edtDataNascimento: TDateEdit;
    Label4: TLabel;
    edtTelefone: TMaskEdit;
    QryListagemidcliente: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemendereco: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemestado: TWideStringField;
    QryListagemcep: TWideStringField;
    QryListagemtelefone: TWideStringField;
    QryListagememail: TWideStringField;
    QryListagemdatanascimento: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    oCliente: TCliente;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
   frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

uses uDTMConexao;
{ TfrmCadCliente }

{$region 'OVERRIDE'}

function TfrmCadCliente.Apagar: Boolean;
begin
   if oCliente.Selecionar(QryListagem.FieldByName('idcliente').AsInteger) then
   begin
      result := oCliente.Apagar
   end;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
   if edtIdcliente.Text <> EmptyStr then
   begin
      oCliente.codigo := StrToInt(edtIdcliente.Text);
   end
   else
   begin
      oCliente.codigo := 0;
   end;
   oCliente.nome := edtNome.Text;
   oCliente.cep := edtCEP.Text;
   oCliente.endereco := edtEndereco.Text;
   oCliente.bairro := edtBairro.Text;
   oCliente.cidade := edtCidade.Text;
   oCliente.telefone := edtTelefone.Text;
   oCliente.email := edtEmail.Text;
   oCliente.datanascimento := edtDataNascimento.Date;
   if EstadoDoCadastro = ecInserir then
   begin
      result := oCliente.Inserir;
   end
   else if EstadoDoCadastro = ecAlterar then
   begin
      result := oCliente.Atualizar;
   end;
end;

{$endregion}

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
   inherited;
   oCliente := TCliente.Create(dtmPrincipal.ConexaoDB);
   IndiceAtual := 'nome';
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   if Assigned(oCliente) then
   begin
      FreeAndNil(oCliente);
   end;
end;

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
   if oCliente.Selecionar(QryListagem.FieldByName('idcliente').AsInteger) then
   begin
      edtIdcliente.Text := IntToStr(oCliente.codigo);
      edtNome.Text := oCliente.nome;
      edtCEP.Text := oCliente.cep;
      edtEndereco.Text := oCliente.endereco;
      edtBairro.Text := oCliente.bairro;
      edtCidade.Text := oCliente.cidade;
      edtTelefone.Text := oCliente.telefone;
      edtEmail.Text := oCliente.email;
      edtDataNascimento.Date := oCliente.dataNascimento;
   end
   else
   begin
      btnCancelar.Click;
      abort;
   end;
   inherited;
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
   inherited;
   edtDataNascimento.Date := Date;
   edtNome.SetFocus;
end;

end.
