unit cCadUsuario;

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
  uFuncaoCriptografia;

type
  TUsuario = class
  private
    ConexaoDB: TZConnection;
    F_idusuario: Integer;
    F_nome: String;
    F_senha: String;
    function getSenha: String;
    procedure setSenha(const Value: String);

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
    function Logar(aUsuario, aSenha: String): Boolean;
    function UsuarioExiste(aUsuario: String): Boolean;
    function AlterarSenha: Boolean;

  published
    property codigo:  Integer   read F_idusuario  write F_idusuario;
    property nome:    String    read F_nome       write F_nome;
    property senha:   String    read getSenha   write setSenha;
  end;

implementation

{$region 'Constructor and Destructor'}

constructor TUsuario.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TUsuario.Destroy;
begin
  inherited;
end;

{$endRegion}

{$region 'CRUD'}

function TUsuario.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  if MessageDlg('Apagar o registro: ' + #13 + #13 +
                'Código: ' + IntToStr(F_idusuario) + #13 +
                'Nome: ' + F_nome, mtConfirmation, [mbYes, mbNo] , 0) = mrNo then
  begin
    Result := false;
    abort;
  end;
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from tbusuarios ' +
                ' where idusuario = :pidusuario ');
    Qry.ParamByName('pidusuario').AsInteger := F_idusuario;
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

function TUsuario.Atualizar: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbusuarios ' +
                ' set nome = :pnome ' +
                ', senha = :psenha ' +
                ' where idusuario = :pidusuario');
    Qry.ParamByName('pidusuario').AsInteger := Self.F_idusuario;
    Qry.ParamByName('pnome').AsString := Self.F_nome;
    Qry.ParamByName('psenha').AsString := Self.F_senha;

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

function TUsuario.Inserir: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into tbusuarios (nome, ' +
                ' senha) values (:pnome, :psenha)' );
    Qry.ParamByName('pnome').AsString := Self.F_nome;
    Qry.ParamByName('psenha').AsString := Self.F_senha;

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

function TUsuario.Selecionar(id: Integer): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select idusuario, nome, senha from tbusuarios ' +
                ' where idusuario = :pidusuario');
    Qry.ParamByName('pidusuario').AsInteger := id;
    try
      Qry.Open;
      Self.F_idusuario := Qry.FieldByName('idusuario').AsInteger;
      Self.F_nome := Qry.FieldByName('nome').AsString;
      Self.F_senha := Qry.FieldByName('senha').AsString;
    Except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;

end;

function TUsuario.UsuarioExiste(aUsuario: String): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select count(idusuario) as qtde from tbusuarios where nome = :pnome ');
    Qry.ParamByName('pnome').AsString := aUsuario;
    try
      Qry.Open;
      if Qry.FieldByName('qtde').AsInteger >0 then
      begin
        Result := true;
      end
      else
      Result := false;
    Except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

{$endRegion}

{$region 'GET e Set'}

function TUsuario.getSenha: String;
begin
  Result := Descriptografar(Self.F_senha);
end;

procedure TUsuario.setSenha(const Value: String);
begin
  Self.F_senha := Criptografar(Value);
end;

{$endRegion}

{$region 'Login'}

function TUsuario.Logar(aUsuario: String; aSenha: String): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select idusuario, nome, senha from tbusuarios where nome = :pnome and senha = :psenha');
    Qry.ParamByName('pnome').AsString := aUsuario;
    Qry.ParamByName('psenha').AsString := Criptografar(aSenha);
    try
      Qry.Open;
      if Qry.FieldByName('idusuario').AsInteger > 0 then
      begin
        F_idusuario := Qry.FieldByName('idusuario').AsInteger;
        F_nome := Qry.FieldByName('nome').AsString;
        F_senha := Qry.FieldByName('senha').AsString;
        Result := true;
      end
      else
      begin
        Result := false;
      end;
    Except
      if Assigned(Qry) then
      begin
        FreeAndNil(Qry);
      end;
    end;
  finally

  end;
end;

{$endregion}

{$region 'Alteração de senha'}

function TUsuario.AlterarSenha: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbusuarios set senha = :psenha where idusuario = :pidusuario');
    Qry.ParamByName('pidusuario').AsInteger := Self.F_idusuario;
    Qry.ParamByName('psenha').AsString := Self.F_senha;
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

{$endregion}

end.
