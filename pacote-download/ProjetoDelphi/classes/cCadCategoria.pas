unit cCadCategoria;

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
     System.SysUtils; //lista de Units

Type
   TCategoria = class //Declaração do tipo da Classe
   private
      ConexaoDB: TZConnection;
      F_idcategoria: Integer;
      F_descricao: String;
      function getCodigo: Integer;
      function getDescricao: String;
      procedure setCodigo(const Value: Integer);
      procedure setDescricao(const Value: String);
      //Variáveis Privadas somente dentro da classe
   public
      constructor Create(aConexao: TZConnection); //Construtor da classe
      destructor Destroy; override; //Destroi a classe usar o override por causa
                                    //de sobrescrever
      function Inserir: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer): Boolean;
      //Variáveis públicas que podem ser trabalhadas fora da classe
   published
      property codigo: Integer   read getCodigo    write setCodigo;
      property descricao: String read getDescricao write setDescricao;
      //Variáveis públicas utilizadas para propriedades da classe
      //para fornecer informações em runtime
   end;

implementation

{ TCategoria }

{$region 'CONSTRUCTOR AND DESTRUCTOR'}
constructor TCategoria.Create(aConexao: TZConnection);
begin
   ConexaoDB := aConexao;
end;

destructor TCategoria.Destroy;
begin

  inherited;
end;

{$endRegion}

{$region 'CRUD'}

function TCategoria.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'Código: ' + IntToStr(F_idcategoria) + #13 +
                'Descrição: ' + F_descricao, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    result := false;
    abort;
  end;
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from tbcategorias where idcategoria = :pidcategoria');
    Qry.ParamByName('pidcategoria').AsInteger := F_idcategoria;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TCategoria.Atualizar: Boolean;
var
  Qry: TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbcategorias set descricao = :pdescricao where ' +
                ' idcategoria = :pidcategoria');
    Qry.ParamByName('pidcategoria').AsInteger := Self.F_idcategoria;
    Qry.ParamByName('pdescricao').AsString := Self.F_descricao;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TCategoria.Inserir: Boolean;
var
  Qry: TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into tbcategorias (descricao) values (:pdescricao)');
    Qry.ParamByName('pdescricao').AsString := Self.F_descricao;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      result := false;
    end;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var
   Qry: TZQuery;
begin
   try
      result := true;
      Qry := TZQuery.Create(nil);
      Qry.Connection := ConexaoDB;
      Qry.SQL.Clear;
      Qry.SQL.Add('select idcategoria, descricao from tbcategorias where idcategoria = :pidcategoria');
      Qry.ParamByName('pidcategoria').AsInteger := id;
      try
         Qry.open;
         Self.F_idcategoria := Qry.FieldByName('idcategoria').AsInteger;
         Self.F_descricao := Qry.FieldByName('descricao').AsString;
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

{$endRegion}

{$region 'GETS'}

function TCategoria.getCodigo: Integer;
begin
   result := Self.F_idcategoria;
end;

function TCategoria.getDescricao: String;
begin
   result := Self.F_descricao;
end;

{$endRegion}

{$region 'SETS'}

procedure TCategoria.setCodigo(const Value: Integer);
begin
   Self.F_idcategoria := Value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
   Self.F_descricao := Value;
end;

{$endRegion}

end.
