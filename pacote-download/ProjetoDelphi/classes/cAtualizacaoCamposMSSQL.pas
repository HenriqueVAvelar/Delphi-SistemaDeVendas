unit cAtualizacaoCamposMSSQL;

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
     System.SysUtils,
     cAtualizacaoBancoDeDados;

Type
  TAtualizacaoCamposMSSQL = class(TAtualizaBancoDados)
  private
    function CampoExisteNaTabela(aNomeTabela, aCampo: String): Boolean;
    procedure Versao1;

  protected

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
end;

implementation

{ TAtualizacaoCamposMSSQL }

function TAtualizacaoCamposMSSQL.CampoExisteNaTabela(aNomeTabela,
  aCampo: String): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := false;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select count(column_name) as qtde from information_schema.columns');
    Qry.SQL.Add('where table_name = :ptabela and column_name = :pcampo ');
    Qry.ParamByName('ptabela').AsString := aNomeTabela;
    Qry.ParamByName('pcampo').AsString := aCampo;
    Qry.Open;

    if Qry.FieldByName('qtde').AsInteger > 0 then
    begin
      Result := true;
    end;
  finally
    Qry.Close;
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

constructor TAtualizacaoCamposMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  Versao1;
end;

destructor TAtualizacaoCamposMSSQL.Destroy;
begin

  inherited;
end;

procedure TAtualizacaoCamposMSSQL.Versao1;
begin
  if not CampoExisteNaTabela('tbprodutos', 'foto') then
  begin
    ExecutaDiretoBancoDeDados('alter table tbprodutos add foto varbinary(max) null ');
  end;

  {
  if CampoExisteNaTabela('tbprodutos', 'foto') then
  begin
    ExecutaDiretoBancoDeDados('alter table tbprodutos drop column foto ');
  end;
  }
end;

end.
