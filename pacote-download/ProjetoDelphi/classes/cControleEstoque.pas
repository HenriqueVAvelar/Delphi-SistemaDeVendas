unit cControleEstoque;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
  ZAbstractConnection,
  ZConnection,
  ZAbstractRODataset,
  ZAbstractDataset,
  ZDataset,
  System.SysUtils,
  Data.DB,
  Datasnap.DBClient;

type
  TControleEstoque = class
  private
    ConexaoDB: TZConnection;
    F_IdProduto: Integer;
    F_Quantidade: Double;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function BaixarEstoque: Boolean;
    function RetornarEstoque: Boolean;
  published
    property IdProduto: Integer read F_IdProduto write F_IdProduto;
    property Quantidade: Double read F_Quantidade write F_Quantidade;
  end;

implementation

{$region 'Constructor and Destructor'}

constructor TControleEstoque.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TControleEstoque.Destroy;
begin

  inherited;
end;

{$endregion}

function TControleEstoque.BaixarEstoque: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbprodutos ' +
                '   set quantidade = quantidade - :pqtdebaixa ' +
                ' where idproduto = :pidproduto ');
    Qry.ParamByName('pidproduto').AsInteger := IdProduto;
    Qry.ParamByName('pqtdebaixa').AsFloat := Quantidade;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TControleEstoque.RetornarEstoque: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbprodutos ' +
                '   set quantidade = quantidade + :pqtdebaixa ' +
                ' where idproduto = :pidproduto ');
    Qry.ParamByName('pidproduto').AsInteger := IdProduto;
    Qry.ParamByName('pqtdebaixa').AsFloat := Quantidade;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

end.
