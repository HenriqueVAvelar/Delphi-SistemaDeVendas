unit uCadAcaoAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cAcaoAcesso, uEnum,
  uDTMConexao;

type
  TfrmCadAcaoAcesso = class(TfrmTelaHeranca)
    QryListagemidacaoacesso: TIntegerField;
    QryListagemdescricao: TWideStringField;
    QryListagemchave: TWideStringField;
    edtDescricao: TLabeledEdit;
    edtIdAcaoAcesso: TLabeledEdit;
    edtChave: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    oAcaoAcesso: tAcaoAcesso;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
  end;

var
  frmCadAcaoAcesso: TfrmCadAcaoAcesso;

implementation

{$R *.dfm}

{ TfrmCadAcaoAcesso }

function TfrmCadAcaoAcesso.Apagar: Boolean;
begin
  if oAcaoAcesso.Selecionar(QryListagem.FieldByName('idacaoacesso').AsInteger) then
  begin
    result := oAcaoAcesso.Apagar;
  end;
end;

procedure TfrmCadAcaoAcesso.btnAlterarClick(Sender: TObject);
begin
  if oAcaoAcesso.Selecionar(QryListagem.FieldByName('idacaoacesso').AsInteger) then
  begin
    edtIdAcaoAcesso.Text := IntToStr(oAcaoAcesso.codigo);
    edtDescricao.Text := oAcaoAcesso.descricao;
    edtChave.Text := oAcaoAcesso.chave;
  end
  else
  begin
    btnCancelar.Click;
    abort;
  end;
  inherited;
end;

procedure TfrmCadAcaoAcesso.btnGravarClick(Sender: TObject);
begin
  if edtIdAcaoAcesso.Text <> EmptyStr then
  begin
    oAcaoAcesso.codigo := StrToInt(edtIdAcaoAcesso.Text);
  end
  else
  begin
    oAcaoAcesso.codigo := 0;
  end;
  oAcaoAcesso.descricao := edtDescricao.Text;
  oAcaoAcesso.chave := edtChave.Text;

  if oAcaoAcesso.ChaveExiste(edtChave.Text, oAcaoAcesso.codigo) then
  begin
    MessageDlg('Chave já cadastrada', mtInformation, [mbok], 0);
    edtChave.SetFocus;
    abort;
  end;
  inherited;
end;

procedure TfrmCadAcaoAcesso.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmCadAcaoAcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(oAcaoAcesso) then
  begin
    FreeAndNil(oAcaoAcesso);
  end;
end;

procedure TfrmCadAcaoAcesso.FormCreate(Sender: TObject);
begin
  inherited;
  oAcaoAcesso := TAcaoAcesso.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'descricao';
end;

function TfrmCadAcaoAcesso.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
  begin
    result := oAcaoAcesso.Inserir;
  end
  else if EstadoDoCadastro = ecAlterar then
  begin
    result := oAcaoAcesso.Atualizar;
  end;
end;

end.
