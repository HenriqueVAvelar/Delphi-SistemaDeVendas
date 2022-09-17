unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit, RxCurrEdit, uDtmVenda, uEnum, cProVenda;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    edtIdVenda: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label1: TLabel;
    edtDataVenda: TDateEdit;
    Label3: TLabel;
    pnlItemVenda: TPanel;
    pnlItens: TPanel;
    pnlTotalizador: TPanel;
    Label2: TLabel;
    edtValorTotal: TCurrencyEdit;
    Panel2: TPanel;
    lkpProduto: TDBLookupComboBox;
    Label4: TLabel;
    edtQuantidade: TCurrencyEdit;
    Label5: TLabel;
    edtValorUnitario: TCurrencyEdit;
    Label6: TLabel;
    edtTotalProduto: TCurrencyEdit;
    Label7: TLabel;
    btnAdicionarItem: TBitBtn;
    btnApagarItem: TBitBtn;
    dbGridItensVenda: TDBGrid;
    QryListagemidVenda: TIntegerField;
    QryListagemidCliente: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdataVenda: TDateTimeField;
    QryListagemtotalVenda: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure dbGridItensVendaDblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    dtmVendas: TdtmVendas;
    oVenda: TVenda;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): boolean; override;
    function Apagar:Boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}

uses uDTMConexao, uRelVenda;

{$region 'Override'}
function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(QryListagem.FieldByName('idvenda').AsInteger, dtmVendas.cdsItensVenda) then
  begin
    Result := oVenda.Apagar;
  end;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): boolean;
begin
  if edtIdVenda.Text <> EmptyStr then
  begin
    oVenda.IdVenda := StrToInt(edtIdVenda.Text)
  end
  else
  begin
    oVenda.IdVenda := 0;
  end;

  oVenda.IdCliente  := lkpCliente.KeyValue;
  oVenda.DataVenda  := edtDataVenda.Date;
  oVenda.TotalVenda := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
  begin
    oVenda.IdVenda := oVenda.Inserir(dtmVendas.cdsItensVenda);
  end
  else if (EstadoDoCadastro = ecAlterar) then
  begin
    oVenda.Atualizar(dtmVendas.cdsItensVenda);
  end;

  frmRelVenda := TfrmRelVenda.Create(Self);
  frmRelVenda.QryVenda.Close;
  frmRelVenda.QryVenda.ParamByName('pidvenda').AsInteger := oVenda.IdVenda;
  frmRelVenda.QryVenda.Open;

  frmRelVenda.QryVendasItens.Close;
  frmRelVenda.QryVendasItens.ParamByName('pidvenda').AsInteger := oVenda.IdVenda;
  frmRelVenda.QryVendasItens.Open;

  frmRelVenda.Relatorio.PreviewModal;
  frmRelVenda.Release;

  Result := true;
end;

procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
  if TDBLookupComboBox(Sender).KeyValue <> null then
  begin
    edtValorUnitario.Value := dtmVendas.QryProduto.FieldByName('valor').AsFloat;
    edtQuantidade.Value := 1;
    edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  end;
end;

{$endregion}

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = null then
  begin
    MessageDlg('Produto é um campo obrigatório', mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    abort;
  end;

  if edtValorUnitario.Value <= 0 then
  begin
    MessageDlg('Valor Unitário não pode ser zero', mtInformation, [mbOK], 0);
    edtValorUnitario.SetFocus;
    abort;
  end;

  if edtQuantidade.Value <= 0 then
  begin
    MessageDlg('Quantidade não pode ser zero', mtInformation, [mbOK], 0);
    edtQuantidade.SetFocus;
    abort;
  end;

  if dtmVendas.cdsItensVenda.Locate('idproduto', lkpProduto.KeyValue, []) then
  begin
    MessageDlg('Este produto já foi selecionado', mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    abort;
  end;

  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  dtmVendas.cdsItensVenda.Append;
  dtmVendas.cdsItensVenda.FieldByName('idproduto').AsString := lkpProduto.KeyValue;
  dtmVendas.cdsItensVenda.FieldByName('nomeproduto').AsString := dtmVendas.QryProduto.FieldByName('nome').AsString;
  dtmVendas.cdsItensVenda.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
  dtmVendas.cdsItensVenda.FieldByName('valorunitario').AsFloat := edtValorUnitario.Value;
  dtmVendas.cdsItensVenda.FieldByName('valortotalproduto').AsFloat := edtTotalProduto.Value;
  dtmVendas.cdsItensVenda.Post;

  edtValorTotal.Value := TotalizarVenda;

  LimparComponenteItem;

  lkpProduto.SetFocus;

end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.KeyValue := null;
  edtQuantidade.Value := 0;
  edtValorUnitario.Value := 0;
  edtTotalProduto.Value := 0;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade: Double): Double;
begin
  Result := valorUnitario * Quantidade;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVendas.cdsItensVenda.First;
  while not dtmVendas.cdsItensVenda.Eof do
  begin
    dtmVendas.cdsItensVenda.Delete;
  end;
end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('idvenda').AsInteger, dtmVendas.cdsItensVenda) then
  begin
     edtIdVenda.Text     := IntToStr(oVenda.idVenda);
     lkpCliente.KeyValue := oVenda.idCliente;
     edtDataVenda.Date   := oVenda.DataVenda;
     edtValorTotal.Value := oVenda.TotalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmProVenda.btnApagarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = Null then
  begin
    MessageDlg('Selecione o Produto a ser excluído', mtInformation, [mbOK], 0);
    dbGridItensVenda.SetFocus;
    abort;
  end;

  if dtmVendas.cdsItensVenda.Locate('idproduto', lkpProduto.KeyValue, []) then
  begin
    dtmVendas.cdsItensVenda.Delete;
    edtValorTotal.Value := TotalizarVenda;
    LimparComponenteItem;
  end;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.dbGridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVendas) then
  begin
    FreeAndNil(dtmVendas);
  end;
  if Assigned(oVenda) then
  begin
    FreeAndNil(oVenda);
  end;
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVendas := TdtmVendas.Create(Self);
  oVenda := TVenda.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual := 'idcliente';
end;

procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue := dtmVendas.cdsItensVenda.FieldByName('idproduto').AsString;
  edtQuantidade.Value := dtmVendas.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value := dtmVendas.cdsItensVenda.FieldByName('valorunitario').AsFloat;
  edtTotalProduto.Value := dtmVendas.cdsItensVenda.FieldByName('valortotalproduto').AsFloat;
end;

function TfrmProVenda.TotalizarVenda: Double;
begin
  Result := 0;
  dtmVendas.cdsItensVenda.First;
  while not dtmVendas.cdsItensVenda.Eof do
  begin
    Result := Result + dtmVendas.cdsItensVenda.FieldByName('valortotalproduto').AsFloat;
    dtmVendas.cdsItensVenda.Next;
  end;
end;

end.
