unit uRelCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, RLReport, RLFilters, RLPDFFilter,
  RLHTMLFilter, RLXLSFilter, RLXLSXFilter;

type
  TfrmRelCadCliente = class(TForm)
    QryClientes: TZQuery;
    dtsClientes: TDataSource;
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
    Detalhe: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand1: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLXLSXFilter1: TRLXLSXFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    QryClientesidcliente: TIntegerField;
    QryClientesnome: TWideStringField;
    QryClientesemail: TWideStringField;
    QryClientestelefone: TWideStringField;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadCliente: TfrmRelCadCliente;

implementation

{$R *.dfm}


procedure TfrmRelCadCliente.FormCreate(Sender: TObject);
begin
  QryClientes.Open;
end;

procedure TfrmRelCadCliente.FormDestroy(Sender: TObject);
begin
  QryClientes.Close;
end;

end.
