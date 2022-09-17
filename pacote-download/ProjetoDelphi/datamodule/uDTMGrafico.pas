unit uDTMGrafico;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TdtmGrafico = class(TDataModule)
    QryProdutoEstoque: TZQuery;
    QryProdutoEstoqueLabel: TWideStringField;
    QryProdutoEstoqueValue: TFloatField;
    dtsProdutoEstoque: TDataSource;
    QryValorVendaPorCliente: TZQuery;
    QryValorVendaPorClienteLabel: TWideStringField;
    QryValorVendaPorClienteValue: TFloatField;
    Qry10ProdutosMaisVendidos: TZQuery;
    Qry10ProdutosMaisVendidosLabel: TWideStringField;
    Qry10ProdutosMaisVendidosValue: TFloatField;
    QryVendasDaUltimaSemana: TZQuery;
    QryVendasDaUltimaSemanaLabel: TDateTimeField;
    QryVendasDaUltimaSemanaValue: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmGrafico: TdtmGrafico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
