unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, cCadProduto, uEnum, uDTMConexao, uCadCategoria, cFuncao, uConCategoria,
  Vcl.Menus;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    QryListagemidproduto: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdescricao: TWideStringField;
    QryListagemvalor: TFloatField;
    QryListagemquantidade: TFloatField;
    QryListagemidcategoria: TIntegerField;
    QryListagemDescricaoCategoria: TWideStringField;
    edtIdproduto: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    Label2: TLabel;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    Label3: TLabel;
    Label4: TLabel;
    lkpCategoria: TDBLookupComboBox;
    QryCategoria: TZQuery;
    dtsCategoria: TDataSource;
    QryCategoriaidcategoria: TIntegerField;
    QryCategoriadescricao: TWideStringField;
    Label5: TLabel;
    btnAdicionarCategoria: TSpeedButton;
    btnPesquisarCategoria: TSpeedButton;
    pnlImagem: TPanel;
    imgImagem: TImage;
    ppmImagem: TPopupMenu;
    CarregarImagem1: TMenuItem;
    LimparImagem1: TMenuItem;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarCategoriaClick(Sender: TObject);
    procedure btnPesquisarCategoriaClick(Sender: TObject);
    procedure LimparImagem1Click(Sender: TObject);
    procedure CarregarImagem1Click(Sender: TObject);
  private
    { Private declarations }
    oProduto:TProduto;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

uses uPrincipal;

{$R *.dfm}

{$region 'Override'}

function TfrmCadProduto.Apagar: Boolean;
begin
  if oProduto.Selecionar(QryListagem.FieldByName('idproduto').AsInteger) then
  begin
    Result := oProduto.Apagar;
  end;
end;

function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtIdproduto.Text <> EmptyStr then
  begin
    oProduto.codigo := StrToInt(edtIdproduto.Text)
  end
  else
  begin
    oProduto.codigo := 0;
  end;

  oProduto.nome           := edtNome.Text;
  oProduto.descricao      := edtDescricao.Text;
  oProduto.idcategoria    := lkpCategoria.KeyValue;
  oProduto.valor          := edtValor.Value;
  oProduto.quantidade     := edtQuantidade.Value;

  if imgImagem.Picture.Bitmap.Empty then
  begin
    oProduto.foto.Assign(nil);
  end
  else
  begin
    oProduto.foto.Assign(imgImagem.Picture);
  end;

  if (EstadoDoCadastro = ecInserir) then
  begin
    Result := oProduto.Inserir
  end
  else if (EstadoDoCadastro = ecAlterar) then
  begin
    Result := oProduto.Atualizar;
  end;
end;

procedure TfrmCadProduto.LimparImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.LimparImagem(imgImagem);
end;

procedure TfrmCadProduto.btnAdicionarCategoriaClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
  QryCategoria.Refresh;
end;

{$endregion}

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if oProduto.Selecionar(QryListagem.FieldByName('idproduto').AsInteger) then
  begin
    edtIdproduto.Text     := IntToStr(oProduto.codigo);
    edtNome.Text          := oProduto.nome;
    edtDescricao.Text     := oProduto.descricao;
    lkpCategoria.KeyValue := oProduto.idcategoria;
    edtValor.value        := oProduto.valor;
    edtQuantidade.value   := oProduto.quantidade;
    imgImagem.Picture.Assign(oProduto.foto);
  end
  else begin
  begin
    btnCancelar.Click;
    Abort;
  end;
  end;
  inherited;
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadProduto.btnPesquisarCategoriaClick(Sender: TObject);
begin
  inherited;
  try
    frmConCategoria := TfrmConCategoria.Create(Self);
    if lkpCategoria.KeyValue <> null then
    begin
      frmConCategoria.aIniciarIdPesquisa := lkpCategoria.KeyValue;
    end;
    frmConCategoria.ShowModal;
    if frmConCategoria.aRetornarIdSelecionado <> Unassigned then
    begin
      lkpCategoria.KeyValue := frmConCategoria.aRetornarIdSelecionado;
    end;
  finally
    frmConCategoria.Release;
  end;
end;

procedure TfrmCadProduto.CarregarImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.CarregarImage(imgImagem);
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  QryCategoria.Close;
  if Assigned(oProduto) then
  begin
    FreeAndNil(oProduto);
  end;
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual := 'nome';
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  QryCategoria.Open;
end;

end.
