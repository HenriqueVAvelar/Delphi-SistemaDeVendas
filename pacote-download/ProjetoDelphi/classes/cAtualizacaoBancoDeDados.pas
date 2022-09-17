unit cAtualizacaoBancoDeDados;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     Data.DB,
     System.SysUtils;

Type
  TAtualizaBancoDados = class
  private
  public
    ConexaoDB: TZConnection;
    constructor Create(aConexao: TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
end;

Type
  TAtualizaBancoDadosMSSQL = class
  private
    ConexaoDB: TZConnection;
  public
    function AtualizarBancoDeDadosMSSQL: Boolean;
    constructor Create(aConexao: TZConnection);
end;

implementation

uses cAtualizacaoTabelaMSSQL, cAtualizacaoCamposMSSQL;

{ TAtualizaBancoDados }

constructor TAtualizaBancoDados.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

procedure TAtualizaBancoDados.ExecutaDiretoBancoDeDados(aScript: String);
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(aScript);
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
    end;
  finally
    Qry.Close;
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

{ TAtualizaBancoDadosMSSQL }

function TAtualizaBancoDadosMSSQL.AtualizarBancoDeDadosMSSQL: Boolean;
var
  oAtualizarDB: TAtualizaBancoDados;
  oTabela: TAtualizacaoTabelaMSSQL;
  oCampo: TAtualizacaoCamposMSSQL;
begin
  try
    oAtualizarDB := TAtualizaBancoDados.Create(ConexaoDB);
    oTabela := TAtualizacaoTabelaMSSQL.Create(ConexaoDB);
    oCampo := TAtualizacaoCamposMSSQL.Create(ConexaoDB);
  finally
    if Assigned(oAtualizarDB) then
    begin
      FreeAndNil(oAtualizarDB);
    end;
    if Assigned(oTabela) then
    begin
      FreeAndNil(oTabela);
    end;
    if Assigned(oCampo) then
    begin
      FreeAndNil(oCampo);
    end;
  end;
end;

constructor TAtualizaBancoDadosMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

end.
