unit uCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cCadUsuario,
  uEnum, uDTMConexao, cAcaoAcesso;

type
  TfrmCadUsuario = class(TfrmTelaHeranca)
    QryListagemidusuario: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemsenha: TWideStringField;
    edtIdusuario: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    oUsuario: TUsuario;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadUsuario: TfrmCadUsuario;

implementation

{$R *.dfm}

{ TfrmCadUsuario }

function TfrmCadUsuario.Apagar: Boolean;
begin
  if oUsuario.Selecionar(QryListagem.FieldByName('idusuario').AsInteger) then
  begin
    Result := oUsuario.Apagar;
  end;
end;


procedure TfrmCadUsuario.btnAlterarClick(Sender: TObject);
begin
  if oUsuario.Selecionar(QryListagem.FieldByName('idusuario').AsInteger) then
  begin
    edtIdusuario.Text := IntToStr(oUsuario.codigo);
    edtNome.Text := oUsuario.nome;
    edtSenha.Text := oUsuario.senha;
  end
  else
  begin
    btnCancelar.Click;
    abort;
  end;

  inherited;
end;

procedure TfrmCadUsuario.btnGravarClick(Sender: TObject);
begin
  if oUsuario.UsuarioExiste(edtNome.Text) then
  begin
    MessageDlg('Usuário já cadastrado', mtInformation, [mbok], 0);
    edtNome.SetFocus;
    abort;
  end;
  if edtIdusuario.Text <> EmptyStr then
  begin
    oUsuario.codigo := StrToInt(edtIdusuario.Text);
  end
  else
  begin
    oUsuario.codigo := 0;
  end;
  oUsuario.nome := edtNome.Text;
  oUsuario.senha := edtSenha.Text;

  inherited;
end;

procedure TfrmCadUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oUsuario) then
  begin
    FreeAndNil(oUsuario);
  end;
end;

procedure TfrmCadUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  oUsuario := TUsuario.Create(DtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

function TfrmCadUsuario.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
  begin
    Result := oUsuario.Inserir;
  end
  else if EstadoDoCadastro = ecAlterar then
  begin
    Result := oUsuario.Atualizar;
  end;

  TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);
end;

end.
