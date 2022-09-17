unit uTelaHerancaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmTelaHerancaConsulta = class(TForm)
    pnlCima: TPanel;
    pnlBaixo: TPanel;
    pnlCentro: TPanel;
    mskPesquisa: TMaskEdit;
    lblIndice: TLabel;
    grdPesquisa: TDBGrid;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    btnFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure grdPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdPesquisaTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure grdPesquisaDblClick(Sender: TObject);
    procedure mskPesquisaChange(Sender: TObject);
  private
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
    function RetornarCampoTraduzido(Campo: String): String;
    { Private declarations }
  public
    { Public declarations }
    aRetornarIdSelecionado: Variant;
    aIniciarIdPesquisa: Variant;
    aIdCampo: String;
    IndiceAtual: String;
  end;

var
  frmTelaHerancaConsulta: TfrmTelaHerancaConsulta;

implementation

{$R *.dfm}

procedure TfrmTelaHerancaConsulta.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHerancaConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if QryListagem.Active then
  begin
    QryListagem.Close;
  end;
end;

procedure TfrmTelaHerancaConsulta.FormCreate(Sender: TObject);
begin
  if QryListagem.Active then
  begin
    QryListagem.Close;
  end;
  ExibirLabelIndice(IndiceAtual, lblIndice);
  QryListagem.Open;
end;

procedure TfrmTelaHerancaConsulta.FormShow(Sender: TObject);
begin
  if (aIniciarIdPesquisa <> Unassigned) then
  begin
    QryListagem.Locate(aIdCampo, aIniciarIdPesquisa, [loPartialKey]);
  end;
end;

procedure TfrmTelaHerancaConsulta.grdPesquisaDblClick(Sender: TObject);
begin
  aRetornarIdSelecionado := QryListagem.FieldByName(aIdCampo).AsVariant;
  Close;
end;

procedure TfrmTelaHerancaConsulta.grdPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 46) then
  begin
    Key := 0;
  end;
end;

procedure TfrmTelaHerancaConsulta.grdPesquisaTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  QryListagem.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHerancaConsulta.mskPesquisaChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey])
end;

procedure TfrmTelaHerancaConsulta.ExibirLabelIndice(Campo: String; aLabel: TLabel);
begin
  aLabel.Caption := RetornarCampoTraduzido(Campo);
end;

function TfrmTelaHerancaConsulta.RetornarCampoTraduzido(Campo: String): String;
var
  i: Integer;
begin
  for I := 0 to QryListagem.FieldCount - 1 do
  begin
    if LowerCase(QryListagem.Fields[i].FieldName) = LowerCase(Campo) then
    begin
      result := QryListagem.Fields[i].DisplayLabel;
      break;
    end;
  end;
end;

end.
