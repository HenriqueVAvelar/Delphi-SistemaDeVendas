unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter,
  uFrmAtualizaDB, ShellApi, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, uUsuariosVsAcoes,
  VclTee.TeeGDIPlus, Data.DB, VclTee.Series, VclTee.TeEngine, VclTee.TeeProcs,
  VclTee.Chart, VclTee.DbChart, cUsuarioLogado, ZDbcIntfs, cAcaoAcesso, RLReport,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
   TfrmPrincipal = class(TForm)
   mainPrincipal: TMainMenu;
   Cadastro1: TMenuItem;
   Movimentao1: TMenuItem;
   Relatrio1: TMenuItem;
   Cliente1: TMenuItem;
   N1: TMenuItem;
   Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
   menuFechar: TMenuItem;
   Vendas1: TMenuItem;
   Cliente2: TMenuItem;
   N3: TMenuItem;
   Produto2: TMenuItem;
   N4: TMenuItem;
   Vendapordata1: TMenuItem;
    Categoria2: TMenuItem;
    Fichadecliente1: TMenuItem;
    Produtoporcategoria1: TMenuItem;
    Usuario1: TMenuItem;
    N5: TMenuItem;
    AlterarSenha1: TMenuItem;
    stbPrincipal: TStatusBar;
    AoAcesso1: TMenuItem;
    N6: TMenuItem;
    UsuriosVsAcoes1: TMenuItem;
    N7: TMenuItem;
    pnlCima: TPanel;
    pnlEsquerda: TPanel;
    pnlProdutoEstoque: TPanel;
    DBChart1: TDBChart;
    Series1: TBarSeries;
    pnlDireita: TPanel;
    pnlVendaPorClienteUltimaSemana: TPanel;
    pnl10ProdutosMaisVendidos: TPanel;
    pnlVendasDaUltimaSemana: TPanel;
    DBChart2: TDBChart;
    Series2: TPieSeries;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    DBChart3: TDBChart;
    PieSeries1: TPieSeries;
    DBChart4: TDBChart;
    Series3: TFastLineSeries;
    Timer1: TTimer;
   procedure menuFecharClick(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure Categoria1Click(Sender: TObject);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure Cliente1Click(Sender: TObject);
   procedure Produto1Click(Sender: TObject);
   procedure Vendas1Click(Sender: TObject);
   procedure Categoria2Click(Sender: TObject);
   procedure Cliente2Click(Sender: TObject);
    procedure Fichadecliente1Click(Sender: TObject);
    procedure Produto2Click(Sender: TObject);
    procedure Produtoporcategoria1Click(Sender: TObject);
    procedure Vendapordata1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AlterarSenha1Click(Sender: TObject);
    procedure AoAcesso1Click(Sender: TObject);
    procedure UsuriosVsAcoes1Click(Sender: TObject);
    procedure pnlCimaClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure AtualizarDashBoard;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  oUsuarioLogado: TUsuarioLogado;

implementation

{$R *.dfm}

uses uCadCategoria, uCadCliente, uCadProduto, uProVenda, uRelCategoria,
  uRelProduto, uRelCadProdutoComGrupoCategoria, uRelCadCliente,
  uRelCadClienteFicha, uRelVendaPorData, uSelecionarData, uCadUsuario,
  uLogin, uAlterarSenha, cAtualizacaoBancoDeDados, cArquivoIni, uCadAcaoAcesso, cCadUsuario, uTelaHeranca,
  uDTMGrafico, cFuncao;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Categoria2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
   TFuncao.CriarForm(TfrmCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Fichadecliente1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadClienteFicha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //FreeAndNil(TeclaEnter);

   if Assigned(dtmPrincipal) then
   begin
     FreeAndNil(dtmPrincipal);
   end;

   //FreeAndNil(dtmPrincipal);

   if Assigned(dtmGrafico) then
   begin
     FreeAndNil(dtmGrafico);
   end;

   //FreeAndNil(dtmGrafico);

   if Assigned(oUsuarioLogado) then
   begin
     FreeAndNil(oUsuarioLogado);
   end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if not FileExists(TArquivoIni.ArquivoIni) then
  begin
    TArquivoIni.AtualizarIni('SERVER', 'TipoDataBase', 'MSSQL');
    TArquivoIni.AtualizarIni('SERVER', 'HostName', '.\');
    TArquivoIni.AtualizarIni('SERVER', 'Port', '1433');
    TArquivoIni.AtualizarIni('SERVER', 'User', 'sa');
    TArquivoIni.AtualizarIni('SERVER', 'Password', 'mudar@123');
    TArquivoIni.AtualizarIni('SERVER', 'DataBase', 'vendas');

    MessageDlg('Arquivo ' + TArquivoIni.ArquivoIni + ' Criado com Sucesso.' + #13 +
               'Configure o arquivo antes de inicializar a aplicação.', mtInformation, [mbok], 0);
    Application.Terminate;
  end
  else
  begin
    frmAtualizaDB := TfrmAtualizaDB.Create(Self);
    frmAtualizaDB.Show;
    frmAtualizaDB.Refresh;
    dtmPrincipal := TdtmPrincipal.Create(Self);
    with dtmPrincipal.ConexaoDB do
    begin
      Connected := false;
      SQLHourGlass := False;
      //LibraryLocation := ExtractFilePath(Application.ExeName) + 'ntwdblib.dll';
      if TArquivoIni.LerIni('SERVER', 'TipoDataBase') = 'MSSQL' then
      begin
        Protocol := 'mssql';
      end;
      LibraryLocation := 'C:\ProjetoDelphi\ntwdblib.dll';
      HostName := TArquivoIni.LerIni('SERVER', 'HostName');
      Port := StrToInt(TArquivoIni.LerIni('SERVER', 'Port'));
      User := TArquivoIni.LerIni('SERVER', 'User');
      Password := TArquivoIni.LerIni('SERVER', 'Password');
      Database := TArquivoIni.LerIni('SERVER', 'DataBase');
      AutoCommit := true;
      TransactIsolationLevel := tiReadCommitted;
      Connected := true;
    end;
    AtualizacaoBancoDados(frmAtualizaDB);

    TAcaoAcesso.CriarAcoes(TfrmCadCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadCliente, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadProduto, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadUsuario, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmAlterarSenha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmProVenda, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelVendaPorData, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadClienteFicha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadCliente, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProdutoComGrupoCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelProduto, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmUsuariosVsAcoes, dtmPrincipal.ConexaoDB);

    TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);

    dtmGrafico := TdtmGrafico.Create(Self);
    AtualizarDashBoard;
    frmAtualizaDB.Free;

    TeclaEnter := TMREnter.Create(Self);
    TeclaEnter.FocusEnabled := true;
    TeclaEnter.FocusColor := clInfoBk;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  try
    oUsuarioLogado := TUsuarioLogado.Create;
    frmLogin := TfrmLogin.Create(Self);
    frmLogin.ShowModal;
  finally
    frmLogin.Release;
    stbPrincipal.Panels[0].Text := 'Usuário: ' + oUsuarioLogado.nome;
  end;
end;

procedure TfrmPrincipal.menuFecharClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TfrmPrincipal.pnlCimaClick(Sender: TObject);
begin
  AtualizarDashBoard;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
   TFuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Produtoporcategoria1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadProdutoComGrupoCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  AtualizarDashBoard;
end;

procedure TfrmPrincipal.Usuario1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadUsuario, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.UsuriosVsAcoes1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmUsuariosVsAcoes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Vendapordata1Click(Sender: TObject);
begin
  try
   frmSelecionarData := TfrmSelecionarData.Create(Self);
   //if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, frmSelecionarData.Name, dtmPrincipal.ConexaoDB) then
   //begin
   frmSelecionarData.ShowModal;
   frmRelVendaPorData := TfrmRelVendaPorData.Create(Self);
   frmRelVendaPorData.QryVenda.Close;
   frmRelVendaPorData.QryVenda.ParamByName('pdatainicio').AsDate := frmSelecionarData.edtDataInicio.Date;
   frmRelVendaPorData.QryVenda.ParamByName('pdatafim').AsDate := frmSelecionarData.edtDataFinal.Date;
   frmRelVendaPorData.QryVenda.Open;
   frmRelVendaPorData.Relatorio.PreviewModal;
   {end
   else
   begin
     MessageDlg('Usuário: ' + oUsuarioLogado.nome + ' não tem permissão de acesso.', mtWarning, [mbok], 0);
   end;}
  finally
    {if Assigned(frmSelecionarData) then
    begin}
    frmSelecionarData.Release;
    {end;
    if Assigned(frmRelVendaPorData) then
    begin}
    frmRelVendaPorData.Release;
    //end;
  end;
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmProVenda, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AlterarSenha1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmAlterarSenha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AoAcesso1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadAcaoAcesso, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
var
  oAtualizarMSSQL: TAtualizaBancoDadosMSSQL;
begin
  aForm.Refresh;
  try
    oAtualizarMSSQL := TAtualizaBancoDadosMSSQL.Create(DtmPrincipal.ConexaoDB);
    oAtualizarMSSQL.AtualizarBancoDeDadosMSSQL;
  finally
    if Assigned(oAtualizarMSSQL) then
    begin
      FreeAndNil(oAtualizarMSSQL);
    end;
  end;

end;

procedure TfrmPrincipal.AtualizarDashBoard;
begin
  try
    Screen.Cursor := crSQLWait;
    if dtmGrafico.QryProdutoEstoque.Active then
    begin
      dtmGrafico.QryProdutoEstoque.Close;
    end;
    if dtmGrafico.QryValorVendaPorCliente.Active then
    begin
      dtmGrafico.QryValorVendaPorCliente.Close;
    end;
    if dtmGrafico.Qry10ProdutosMaisVendidos.Active then
    begin
      dtmGrafico.Qry10ProdutosMaisVendidos.Close;
    end;
    if dtmGrafico.QryVendasDaUltimaSemana.Active then
    begin
      dtmGrafico.QryVendasDaUltimaSemana.Close;
    end;
    dtmGrafico.QryProdutoEstoque.Open;
    dtmGrafico.QryValorVendaPorCliente.Open;
    dtmGrafico.Qry10ProdutosMaisVendidos.Open;
    dtmGrafico.QryVendasDaUltimaSemana.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
