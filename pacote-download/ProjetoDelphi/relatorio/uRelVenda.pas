unit uRelVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, RLReport, RLFilters, RLPDFFilter,
  RLHTMLFilter, RLXLSFilter, RLXLSXFilter;

type
  TfrmRelVenda = class(TForm)
    QryVenda: TZQuery;
    dtsVenda: TDataSource;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    Rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLXLSXFilter1: TRLXLSXFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    BandaDoGrupo: TRLGroup;
    RLBand2: TRLBand;
    Detalhe: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLLabel8: TRLLabel;
    RLBand4: TRLBand;
    RLDraw4: TRLDraw;
    RLLabel6: TRLLabel;
    RLDBResult2: TRLDBResult;
    QryVendasItens: TZQuery;
    dtsVendasItens: TDataSource;
    QryVendaidvenda: TIntegerField;
    QryVendaidcliente: TIntegerField;
    QryVendanome: TWideStringField;
    QryVendadatavenda: TDateTimeField;
    QryVendatotalvenda: TFloatField;
    QryVendasItensidvenda: TIntegerField;
    QryVendasItensidproduto: TIntegerField;
    QryVendasItensnome: TWideStringField;
    QryVendasItensquantidade: TFloatField;
    QryVendasItensvalorunitario: TFloatField;
    QryVendasItenstotalproduto: TFloatField;
    RLLabel5: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel7: TRLLabel;
    RLSubDetail1: TRLSubDetail;
    RLBand1: TRLBand;
    RLBand3: TRLBand;
    RLDBText3: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel9: TRLLabel;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel10: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVenda: TfrmRelVenda;

implementation

{$R *.dfm}


procedure TfrmRelVenda.FormDestroy(Sender: TObject);
begin
  QryVenda.Close;
  QryVendasItens.Close;
end;


end.
