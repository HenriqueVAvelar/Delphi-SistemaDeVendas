unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  uDtmConexao, ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum,
  RxToolEdit, RxCurrEdit, ZAbstractConnection, ZConnection, cUsuarioLogado;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlRodape: TPanel;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    SelectOriginal: String;
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
              btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
              pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;

  public
     { Public declarations }
     EstadoDoCadastro: TEstadoDoCadastro;
     IndiceAtual: String;
     function Apagar: Boolean; virtual;
     function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; virtual;
     procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

uses uPrincipal;

{$region 'OBSERVAÇÕES'}

 // TAG: 1 - Chave Primária - PK
 // TAG: 2 - Campos Obrigatórios

{$endregion}

{$region 'FUNÇÕES E PROCEDURES'}

procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
          btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
          pgcPrincipal: TPageControl; Flag: Boolean);
begin
   btnNovo.Enabled := Flag;
   btnApagar.Enabled := Flag;
   btnAlterar.Enabled := Flag;
   Navegador.Enabled := Flag;
   pgcPrincipal.Pages[0].TabVisible := Flag;
   btnCancelar.Enabled := not(Flag);
   btnGravar.Enabled := not(Flag);
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl;
          Indice: Integer);
begin
   if (pgcPrincipal.Pages[Indice].TabVisible) then
       pgcPrincipal.TabIndex := Indice;
end;

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo: String): String;
var
   i: Integer;
begin
   for I := 0 to QryListagem.Fields.Count - 1 do
   begin
      if lowercase(QryListagem.Fields[i].FieldName) = lowercase(Campo) then
      begin
         Result := QryListagem.Fields[i].DisplayLabel;
         Break;
      end;
   end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo: String; aLabel: TLabel);
begin
   aLabel.Caption := RetornarCampoTraduzido(Campo);
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio: Boolean;
var
   i: Integer;
begin
   result := false;
   for i := 0 to ComponentCount - 1 do
   begin
      if Components[i] is TLabeledEdit then
      begin
         if (TLabeledEdit(Components[i]).Tag = 2) and
            (TLabeledEdit(Components[i]).Text = EmptyStr) then
            begin
               MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
                          ' é campo obrigatório', mtInformation, [mbOK], 0);
               TLabeledEdit(Components[i]).SetFocus;
               result := true;
               break;
            end;
      end;
   end;
end;

procedure TfrmTelaHeranca.DesabilitarEditPK;
var
   i: Integer;
begin
   for i := 0 to ComponentCount - 1 do
   begin
      if Components[i] is TLabeledEdit then
      begin
         if (TLabeledEdit(Components[i]).Tag = 1) then
         begin
            TLabeledEdit(Components[i]).Enabled := false;
            break;
         end;
      end;
   end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var
   i: Integer;
begin
   for i := 0 to ComponentCount - 1 do
   begin
      if Components[i] is TLabeledEdit then
      begin
         TLabeledEdit(Components[i]).Text := EmptyStr;
      end

      else if Components[i] is TEdit then
      begin
         TEdit(Components[i]).Text := EmptyStr;
      end

      else if Components[i] is TMemo then
      begin
         TMemo(Components[i]).Text := EmptyStr;
      end

      else if Components[i] is TDBLookupComboBox then
      begin
         TDBLookupComboBox(Components[i]).KeyValue := null;
      end

      else if Components[i] is TCurrencyEdit then
      begin
         TCurrencyEdit(Components[i]).Value := 0;
      end

      else if Components[i] is TDateEdit then
      begin
         TDateEdit(Components[i]).Date := 0;
      end

      else if Components[i] is TMaskEdit then
      begin
         TMaskEdit(Components[i]).Text := EmptyStr;
      end;
   end;
end;

{$endregion}

{$region 'MÉTODOS VIRTUAIS'}

function TfrmTelaHeranca.Apagar: Boolean;
begin
   showmessage('DELETADO');
   result := true;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
   if EstadoDoCadastro = ecInserir then
   begin
      showmessage('Inserir');
   end
   else if EstadoDoCadastro = ecAlterar then
   begin
      showmessage('Alterar');
   end;
   result := true;
end;

{$endregion}

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome + ', não tem permissão de acesso', mtWarning, [mbok], 0);
    abort;
  end;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                  btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnPesquisarClick(Sender: TObject);
var
  I: Integer;
  TipoCampo: TFieldType;
  NomeCampo, WhereOrAnd, CondicaoSQL: String;
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome + ', não tem permissão de acesso', mtWarning, [mbok], 0);
    abort;
  end;

  if mskPesquisar.Text = '' then
  begin
    QryListagem.Close;
    QryListagem.SQL.Clear;
    QryListagem.SQL.Add(SelectOriginal);
    QryListagem.Open;
    abort;
  end;

  for I := 0 to QryListagem.FieldCount - 1 do
  begin
    if QryListagem.Fields[i].FieldName = IndiceAtual then
    begin
      TipoCampo := QryListagem.Fields[i].DataType;
      if QryListagem.Fields[i].Origin <> '' then
      begin
        if Pos('.', QryListagem.Fields[i].Origin) > 0 then
        begin
          NomeCampo := QryListagem.Fields[i].Origin;
        end
        else
        begin
          NomeCampo := QryListagem.Fields[i].Origin + '.' + QryListagem.Fields[i].FieldName;
        end;
      end
      else
      begin
        NomeCampo := QryListagem.Fields[i].FieldName;
      end;
      break;
    end;
  end;

  if Pos('where', LowerCase(SelectOriginal)) > 1 then
  begin
    WhereOrAnd := ' and ';
  end
  else
  begin
    WhereOrAnd := ' where ';
  end;

  if (TipoCampo = ftString) or (TipoCampo = ftWideString) then
  begin
    CondicaoSQL := WhereOrAnd + ' ' + NomeCampo + ' like ' + QuotedStr('%' + mskPesquisar.Text + '%');
  end
  else if (TipoCampo = ftInteger) or (TipoCampo = ftSmallint) then
  begin
    CondicaoSQL := WhereOrAnd + ' ' + NomeCampo + ' = ' + mskPesquisar.Text;
  end
  else if (TipoCampo = ftDate) or (TipoCampo = ftDateTime) then
  begin
    CondicaoSQL := WhereOrAnd + ' ' + NomeCampo + ' = ' + QuotedStr(mskPesquisar.Text);
  end
  else if (TipoCampo = ftFloat) or (TipoCampo = ftCurrency) then
  begin
    CondicaoSQL := WhereOrAnd + ' ' + NomeCampo + ' = ' + StringReplace(mskPesquisar.Text, ',', '.', [rfReplaceAll]);
  end;

  QryListagem.Close;
  QryListagem.SQL.Clear;
  QryListagem.SQL.Add(SelectOriginal);
  QryListagem.SQL.Add(CondicaoSQL);
  QryListagem.Open;

  mskPesquisar.Text := '';
  mskPesquisar.SetFocus;

end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome + ', não tem permissão de acesso', mtWarning, [mbok], 0);
    abort;
  end;
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                   btnApagar, btnNavigator, pgcPrincipal, false);
   EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome + ', não tem permissão de acesso', mtWarning, [mbok], 0);
    abort;
  end;
  try
    if (Apagar) then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparEdits;
      QryListagem.Refresh;
    end
    else
    begin
      MessageDlg('Erro na Exclusão', mtError, [mbok], 0);
    end;
  finally
    EstadoDoCadastro := ecNenhum;
  end;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                   btnApagar, btnNavigator, pgcPrincipal, true);
   ControlarIndiceTab(pgcPrincipal, 0);
   EstadoDoCadastro := ecNenhum;
   LimparEdits;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome + ', não tem permissão de acesso', mtWarning, [mbok], 0);
    abort;
  end;
  if (ExisteCampoObrigatorio) then
  begin
    abort;
  end;
  try
   if Gravar(EstadoDoCadastro) then   // Método Virtual
   begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      QryListagem.Refresh;
   end
   else
   begin
      MessageDlg('Erro na Gravação', mtError, [mbok], 0);
   end;
  finally
  end;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
   QryListagem.Connection := dtmPrincipal.ConexaoDB;
   dtsListagem.DataSet := QryListagem;
   grdListagem.DataSource := dtsListagem;
   btnNavigator.DataSource := dtsListagem;
   grdListagem.Options := [dgTitles,dgIndicator,dgColumnResize,
                           dgColLines,dgRowLines,dgTabs,
                           dgRowSelect,dgAlwaysShowSelection,dgCancelOnExit,
                           dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
   if QryListagem.SQL.Text <> EmptyStr then
   begin
      QryListagem.IndexFieldNames := IndiceAtual;
      ExibirLabelIndice(IndiceAtual, lblIndice);
      SelectOriginal := QryListagem.SQL.Text;
      QryListagem.Open;
   end;
   ControlarIndiceTab(pgcPrincipal, 0);
   DesabilitarEditPK;
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                   btnApagar, btnNavigator, pgcPrincipal, true);

end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
   btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
   IndiceAtual := Column.FieldName;
   QryListagem.IndexFieldNames := IndiceAtual;
   ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
   QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QryListagem.Close;
end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
   //Bloqueia o CTRL + DEL
   if (Shift = [ssCtrl]) and (Key = 46) then
   begin
      Key := 0;
   end;
end;

end.
