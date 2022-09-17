unit uAlterarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmAlterarSenha = class(TForm)
    btnAlterar: TBitBtn;
    btnFechar: TBitBtn;
    edtNovaSenhaDois: TEdit;
    edtNovaSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtSenhaAtual: TEdit;
    lblUsuarioLogado: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    procedure LimparEdits;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlterarSenha: TfrmAlterarSenha;

implementation

{$R *.dfm}

uses cCadUsuario, uPrincipal, uDTMConexao;

procedure TfrmAlterarSenha.btnAlterarClick(Sender: TObject);
var
  oUsuario: TUsuario;
begin
  if edtSenhaAtual.Text = oUsuarioLogado.senha then
  begin
    if edtNovaSenha.Text = edtNovaSenhaDois.Text then
    begin
      try
        oUsuario := TUsuario.Create(DtmPrincipal.ConexaoDB);
        oUsuario.codigo := oUsuarioLogado.codigo;
        oUsuario.senha := edtNovaSenha.Text;
        oUsuario.AlterarSenha;
        oUsuarioLogado.senha := edtNovaSenha.Text;
        MessageDlg('Senha Alterada.', mtInformation, [mbok], 0);
        LimparEdits;
      finally
        FreeAndNil(oUsuario);
      end;
    end
    else
    begin
      MessageDlg('Senhas digitadas não coincidem.', mtInformation, [mbok], 0);
      edtNovaSenha.SetFocus;
    end;
  end
  else
  begin
    MessageDlg('Senha atual inválida.', mtInformation, [mbok], 0);
  end;

end;

procedure TfrmAlterarSenha.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAlterarSenha.FormShow(Sender: TObject);
begin
  LimparEdits;
end;

procedure TfrmAlterarSenha.LimparEdits;
begin
  edtSenhaAtual.Clear;
  edtNovaSenha.Clear;
  edtNovaSenhaDois.Clear;
  lblUsuarioLogado.Caption := oUsuarioLogado.nome;
end;

end.
