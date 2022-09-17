unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cCadCategoria,
  uDTMConexao, uEnum;

type
   TfrmCadCategoria = class(TfrmTelaHeranca)
   QryListagemidcategoria: TIntegerField;
   QryListagemdescricao: TWideStringField;
    edtIdcategoria: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
     oCategoria: TCategoria;
     function Apagar: Boolean; override;
     function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'OVERRIDE'}

function TfrmCadCategoria.Apagar: Boolean;
begin
   if oCategoria.Selecionar(QryListagem.FieldByName('idcategoria').AsInteger) then
   begin
      result := oCategoria.Apagar;
   end;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
   if edtIdcategoria.Text <> EmptyStr then
   begin
      oCategoria.codigo := StrToInt(edtIdcategoria.Text);
   end
   else
   begin
      oCategoria.codigo := 0;
   end;
   oCategoria.descricao := edtDescricao.Text;
   if EstadoDoCadastro = ecInserir then
   begin
      result := oCategoria.Inserir;
   end
   else if EstadoDoCadastro = ecAlterar then
   begin
      result := oCategoria.Atualizar;
   end;
end;

{$endregion}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
   if oCategoria.Selecionar(QryListagem.FieldByName('idcategoria').AsInteger) then
   begin
      edtIdcategoria.Text := IntToStr(oCategoria.codigo);
      edtDescricao.Text := oCategoria.descricao;
   end
   else
   begin
      btnCancelar.Click;
      Abort;
   end;
   inherited;
end;

procedure TfrmCadCategoria.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   if Assigned(oCategoria) then
   begin
      FreeAndNil(oCategoria);
   end;
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
   inherited;
   oCategoria := TCategoria.Create(dtmPrincipal.ConexaoDB);
   IndiceAtual := 'descricao';
end;



end.
