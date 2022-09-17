unit cUsuarioLogado;

interface

uses
  System.Classes, ZAbstractConnection, ZConnection, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  System.SysUtils;

type
  TUsuarioLogado = class
  private
    F_idusuario: Integer;
    F_nome: String;
    F_senha: String;
  public
  class function TenhoAcesso(aIdUsuario: Integer; aChave: String; aConexao: TZConnection): Boolean; Static;

  published
  property codigo:  Integer   read F_idusuario  write F_idusuario;
  property nome:    String    read F_nome       write F_nome;
  property senha:   String    read F_senha      write F_senha;

  end;
implementation

{ TUsuarioLogado }

class function TUsuarioLogado.TenhoAcesso(aIdUsuario: Integer; aChave: String;
  aConexao: TZConnection): Boolean;
var
  Qry: TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('select idusuario from tbusuariosacaoacesso where idusuario = :pidusuario ' +
                ' and idacaoacesso = (select top 1 idacaoacesso from tbacaoacesso where chave = :pchave) ' +
                ' and ativo = 1');
    Qry.ParamByName('pidusuario').AsInteger := aIdUsuario;
    Qry.ParamByName('pchave').AsString := aChave;
    Qry.Open;

    if Qry.IsEmpty then
    begin
      result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

end.
