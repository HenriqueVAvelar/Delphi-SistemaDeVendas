unit cAcaoAcesso;

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
     Vcl.Forms,
     Vcl.Buttons;

Type
  TAcaoAcesso = class
  private
    ConexaoDB: TZConnection;
    F_IdAcaoAcesso: Integer;
    F_descricao: String;
    F_chave: String;
    class procedure PreencherAcoes(aForm: TForm; aConexao: TZConnection); Static;
    class procedure VerificarUsuarioAcao(aIdUsuario, aIdAcaoAcesso: Integer; aConexao: TZConnection); Static;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
    function ChaveExiste(aChave: String; aId: Integer = 0): Boolean;
    class procedure CriarAcoes(aNomeForm: TFormClass; aConexao: TZConnection); Static;
    class procedure PreencherUsuariosVsAcoes(aConexao: TZConnection); Static;

  published
    property codigo: Integer read F_IdAcaoAcesso write F_IdAcaoAcesso;
    property descricao: String read F_descricao write F_descricao;
    property chave: String read F_chave write F_chave;
  end;

implementation

{ TAcaoAcesso }

{$region 'Constructor and Destructor'}

constructor TAcaoAcesso.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TAcaoAcesso.Destroy;
begin

  inherited;
end;

{$endregion}

{$region 'CRUD'}

function TAcaoAcesso.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'Código: ' + IntToStr(F_IdAcaoAcesso) + #13 +
                'Nome: '   + F_descricao, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := false;
    abort;
  end;

  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from tbacaoacesso '+
                ' where idacaoacesso = :pidacaoacesso ');
    Qry.ParamByName('pidacaoacesso').AsInteger := F_IdAcaoAcesso;
    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := false;
    End;

  finally
    if Assigned(Qry) then
    begin
       FreeAndNil(Qry);
    end;
  end;
end;

function TAcaoAcesso.Atualizar: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbacaoacesso ' +
                '   set descricao     = :pdescricao ' +
                '      ,chave         = :pchave ' +
                ' where idacaoacesso = :pidacaoacesso ');
    Qry.ParamByName('pidacaoacesso').AsInteger    := Self.F_IdAcaoAcesso;
    Qry.ParamByName('pdescricao').AsString        := Self.F_descricao;
    Qry.ParamByName('pchave').AsString            := Self.F_chave;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := false;
    End;

  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TAcaoAcesso.Inserir: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into tbacaoacesso (descricao, ' +
                '                        chave )' +
                ' values                (:pdescricao, ' +
                '                        :pchave )' );

    Qry.ParamByName('pdescricao').AsString    := Self.F_descricao;
    Qry.ParamByName('pchave').AsString        := Self.F_chave;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TAcaoAcesso.Selecionar(id: Integer): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select idacaoacesso, ' +
                '       descricao, ' +
                '       chave ' +
                '  from tbacaoacesso ' +
                ' where idacaoacesso = :pidacaoacesso');
    Qry.ParamByName('pidacaoacesso').AsInteger := id;
    Try
      Qry.Open;

      Self.F_IdAcaoAcesso  := Qry.FieldByName('idacaoacesso').AsInteger;
      Self.F_descricao     := Qry.FieldByName('descricao').AsString;
      Self.F_chave         := Qry.FieldByName('chave').AsString;;
    Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

{$endregion}

class procedure TAcaoAcesso.PreencherAcoes(aForm: TForm;
  aConexao: TZConnection);
var
  i: Integer;
  oAcaoAcesso: TAcaoAcesso;
begin
  try
    oAcaoAcesso := TAcaoAcesso.Create(aConexao);
    oAcaoAcesso.descricao := aForm.Caption;
    oAcaoAcesso.chave := aForm.Name;
    if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.chave) then
    begin
      oAcaoAcesso.Inserir;
    end;
    for I := 0 to aForm.ComponentCount - 1 do
    begin
      if aForm.Components[i] is TBitBtn then
      begin
        if TBitBtn(aForm.Components[i]).Tag = 99 then
        begin
          oAcaoAcesso.descricao := '    - BOTÃO ' + StringReplace(TBitBtn(aForm.Components[i]).Caption, '&', '', [rfReplaceAll]);
          oAcaoAcesso.chave := aForm.Name + '_' + TBitBtn(aForm.Components[i]).Name;
          if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.chave) then
          begin
            oAcaoAcesso.Inserir;
          end;
        end;
      end;
    end;
  finally
    if Assigned(oAcaoAcesso) then
    begin
      FreeAndNil(oAcaoAcesso);
    end;
  end;
end;

class procedure TAcaoAcesso.PreencherUsuariosVsAcoes(aConexao: TZConnection);
var
  Qry: TZQuery;
  QryAcaoAcesso: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('select idusuario from tbusuarios ');
    Qry.Open;

    QryAcaoAcesso := TZQuery.Create(nil);
    QryAcaoAcesso.Connection := aConexao;
    QryAcaoAcesso.SQL.Clear;
    QryAcaoAcesso.SQL.Add('select idacaoacesso from tbacaoacesso ');
    QryAcaoAcesso.Open;

    Qry.First;
    while not Qry.Eof do
    begin
      QryAcaoAcesso.First;
      while not QryAcaoAcesso.Eof do
      begin
        VerificarUsuarioAcao(Qry.FieldByName('idusuario').AsInteger,
                                              QryAcaoAcesso.FieldByName('idacaoacesso').AsInteger,
                                              aConexao);
        QryAcaoAcesso.Next;
      end;
      Qry.Next;
    end;

  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
    if Assigned(QryAcaoAcesso) then
    begin
      FreeAndNil(QryAcaoAcesso);
    end;
  end;
end;

class procedure TAcaoAcesso.CriarAcoes(aNomeForm: TFormClass;
  aConexao: TZConnection);
var
  form: TForm;
begin
  try
    form := aNomeForm.Create(Application);
    PreencherAcoes(form, aConexao);
  finally
    if Assigned(form) then
    begin
      form.Release;
    end;
  end;
end;

class procedure TAcaoAcesso.VerificarUsuarioAcao(aIdUsuario,
  aIdAcaoAcesso: Integer; aConexao: TZConnection);
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('select idusuario from tbusuariosacaoacesso where idusuario = :pidusuario ' +
                ' and idacaoacesso = :pidacaoacesso ');
    Qry.ParamByName('pidusuario').AsInteger := aIdUsuario;
    Qry.ParamByName('pidacaoacesso').AsInteger := aIdAcaoAcesso;
    Qry.Open;
    if Qry.IsEmpty then
    begin
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('insert into tbusuariosacaoacesso (idusuario, idacaoacesso, ativo) ' +
                  ' values (:pidusuario, :pidacaoacesso, :pativo) ');
      Qry.ParamByName('pidusuario').AsInteger := aIdUsuario;
      Qry.ParamByName('pidacaoacesso').AsInteger := aIdAcaoAcesso;
      Qry.ParamByName('pativo').AsBoolean := true;
      try
        aConexao.StartTransaction;
        Qry.ExecSQL;
        aConexao.Commit;
      Except
        aConexao.Rollback;
      end;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TAcaoAcesso.ChaveExiste(aChave: String; aId: Integer): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select count(idacaoacesso) as qtde from tbacaoacesso where chave = :pchave ');
    if aId > 0 then
    begin
      Qry.SQL.Add(' and idacaoacesso <> :pidacaoacesso');
      Qry.ParamByName('pidacaoacesso').AsInteger := aId;
    end;
    Qry.ParamByName('pchave').AsString := aChave;
    try
      Qry.Open;
      if Qry.FieldByName('qtde').AsInteger > 0 then
      begin
        result := true;
      end
      else
      begin
        result := false;
      end;
    Except
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
