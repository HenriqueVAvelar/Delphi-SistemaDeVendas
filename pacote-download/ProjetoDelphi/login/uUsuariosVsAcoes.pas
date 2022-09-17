unit uUsuariosVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmUsuariosVsAcoes = class(TForm)
    pnlEsquerda: TPanel;
    pnlDireita: TPanel;
    pnlBaixo: TPanel;
    Splitter1: TSplitter;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    QryUsuarios: TZQuery;
    QryAcoes: TZQuery;
    dtsUsuarios: TDataSource;
    dtsAcoes: TDataSource;
    QryUsuariosidusuario: TIntegerField;
    QryUsuariosnome: TWideStringField;
    QryAcoesidusuario: TIntegerField;
    QryAcoesidacaoacesso: TIntegerField;
    QryAcoesdescricao: TWideStringField;
    QryAcoesativo: TBooleanField;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure QryUsuariosAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmUsuariosVsAcoes: TfrmUsuariosVsAcoes;

implementation

{$R *.dfm}

uses uDTMConexao;

procedure TfrmUsuariosVsAcoes.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuariosVsAcoes.grdAcoesDblClick(Sender: TObject);
var
  Qry: TZQuery;
  bmRegistroAtua: TBookmark;
begin
  try
    bmRegistroAtua := QryAcoes.GetBookmark;
    Qry := TZQuery.Create(nil);
    Qry.Connection := dtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbusuariosacaoacesso set ativo = :pativo ' +
                ' where idusuario = :pidusuario and idacaoacesso = :pidacaoacesso ');
    Qry.ParamByName('pidusuario').AsInteger := QryAcoes.FieldByName('idusuario').AsInteger;
    Qry.ParamByName('pidacaoacesso').AsInteger := QryAcoes.FieldByName('idacaoacesso').AsInteger;
    Qry.ParamByName('pativo').AsBoolean := not QryAcoes.FieldByName('ativo').AsBoolean;
    try
      dtmPrincipal.ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      dtmPrincipal.ConexaoDB.Commit;
    Except
      dtmPrincipal.ConexaoDB.Rollback;
    end;
  finally
    SelecionarAcoesAcessoPorUsuario;
    QryAcoes.GotoBookmark(bmRegistroAtua);
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

procedure TfrmUsuariosVsAcoes.grdAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not QryAcoes.FieldByName('ativo').AsBoolean then
  begin
    TDBGrid(Sender).Canvas.Font.Color := clWhite;
    TDBGrid(Sender).Canvas.Brush.Color := clRed;
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).Columns[DataCol].Field, State);
end;

procedure TfrmUsuariosVsAcoes.FormShow(Sender: TObject);
begin
  try
    QryUsuarios.DisableControls;
    QryUsuarios.Open;
    SelecionarAcoesAcessoPorUsuario;
  finally
    QryUsuarios.EnableControls;
  end;
end;

procedure TfrmUsuariosVsAcoes.QryUsuariosAfterScroll(DataSet: TDataSet);
begin
  SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuariosVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
  QryAcoes.Close;
  QryAcoes.ParamByName('pidusuario').AsInteger := QryUsuarios.FieldByName('idusuario').AsInteger;
  QryAcoes.Open;
end;

end.
