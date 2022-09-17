unit cCadCliente;

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
   TCliente = class //Declaração do tipo da Classe
   private
      ConexaoDB: TZConnection;
      F_idcliente: Integer;
      F_nome: String;
      F_endereco: String;
      F_cidade: String;
      F_bairro: String;
      F_estado: String;
      F_cep: String;
      F_telefone: String;
      F_email: String;
      F_dataNascimento: TDateTime;
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
      property codigo:           Integer   read F_idcliente        write F_idcliente;
      property nome:             String    read F_nome             write F_nome;
      property endereco:         String    read F_endereco         write F_endereco;
      property cidade:           String    read F_cidade           write F_cidade;
      property bairro:           String    read F_bairro           write F_bairro;
      property estado:           String    read F_estado           write F_estado;
      property cep:              String    read F_cep              write F_cep;
      property telefone:         String    read F_telefone         write F_telefone;
      property email:            String    read F_email            write F_email;
      property dataNascimento:   TDateTime read F_dataNascimento   write F_dataNascimento;
      //Variáveis públicas utilizadas para propriedades da classe
      //para fornecer informações em runtime
   end;

implementation


{$region 'CONSTRUCTOR AND DESTRUCTOR'}
constructor TCliente.Create(aConexao: TZConnection);
begin
   ConexaoDB := aConexao;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;

{$endRegion}

{$region 'CRUD'}

function TCliente.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'Código: ' + IntToStr(F_idcliente) + #13 +
                'Descrição: ' + F_nome, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    result := false;
    abort;
  end;
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from tbclientes where idcliente = :pidcliente');
    Qry.ParamByName('pidcliente').AsInteger := F_idcliente;
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

function TCliente.Atualizar: Boolean;
var
  Qry: TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbclientes set nome = :pnome ' +
                ' ,endereco = :pendereco ' +
                ' ,cidade = :pcidade ' +
                ' ,bairro = :pbairro ' +
                ' ,estado = :pestado ' +
                ' ,cep = :pcep ' +
                ' ,telefone = :ptelefone ' +
                ' ,email = :pemail ' +
                ' ,datanascimento = :pdatanascimento ' +
                ' where idcliente = :pidcliente ');
    Qry.ParamByName('pidcliente').AsInteger := Self.F_idcliente;
    Qry.ParamByName('pnome').AsString := Self.F_nome;
    Qry.ParamByName('pendereco').AsString := Self.F_endereco;
    Qry.ParamByName('pcidade').AsString := Self.F_cidade;
    Qry.ParamByName('pbairro').AsString := Self.F_bairro;
    Qry.ParamByName('pestado').AsString := Self.F_estado;
    Qry.ParamByName('pcep').AsString := Self.F_cep;
    Qry.ParamByName('ptelefone').AsString := Self.F_telefone;
    Qry.ParamByName('pemail').AsString := Self.F_email;
    Qry.ParamByName('pdatanascimento').AsDateTime := Self.F_datanascimento;
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

function TCliente.Inserir: Boolean;
var
  Qry: TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into tbclientes (nome, ' +
                ' endereco, ' +
                ' cidade, ' +
                ' bairro, ' +
                ' estado, ' +
                ' cep, ' +
                ' telefone, ' +
                ' email, ' +
                ' datanascimento) ' +
                ' values (:pnome, ' +
                ' :pendereco, ' +
                ' :pcidade, ' +
                ' :pbairro, ' +
                ' :pestado, ' +
                ' :pcep, ' +
                ' :ptelefone, ' +
                ' :pemail, ' +
                ' :pdatanascimento)' );
    Qry.ParamByName('pnome').AsString := Self.F_nome;
    Qry.ParamByName('pendereco').AsString := Self.F_endereco;
    Qry.ParamByName('pcidade').AsString := Self.F_cidade;
    Qry.ParamByName('pbairro').AsString := Self.F_bairro;
    Qry.ParamByName('pestado').AsString := Self.F_estado;
    Qry.ParamByName('pcep').AsString := Self.F_cep;
    Qry.ParamByName('ptelefone').AsString := Self.F_telefone;
    Qry.ParamByName('pemail').AsString := Self.F_email;
    Qry.ParamByName('pdatanascimento').AsDateTime := Self.F_datanascimento;
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

function TCliente.Selecionar(id: Integer): Boolean;
var
   Qry: TZQuery;
begin
   try
      result := true;
      Qry := TZQuery.Create(nil);
      Qry.Connection := ConexaoDB;
      Qry.SQL.Clear;
      Qry.SQL.Add('select idcliente, ' +
                  ' nome, ' +
                  ' endereco, ' +
                  ' cidade, ' +
                  ' bairro, ' +
                  ' estado, ' +
                  ' cep, ' +
                  ' telefone, ' +
                  ' email, ' +
                  ' datanascimento ' +
                  ' from tbclientes where idcliente = :pidcliente');
      Qry.ParamByName('pidcliente').AsInteger := id;
      try
         Qry.open;
         Self.F_idcliente := Qry.FieldByName('idcliente').AsInteger;
         Self.F_nome := Qry.FieldByName('nome').AsString;
         Self.F_endereco := Qry.FieldByName('endereco').AsString;
         Self.F_cidade := Qry.FieldByName('cidade').AsString;
         Self.F_bairro := Qry.FieldByName('bairro').AsString;
         Self.F_estado := Qry.FieldByName('estado').AsString;
         Self.F_cep := Qry.FieldByName('cep').AsString;
         Self.F_telefone := Qry.FieldByName('telefone').AsString;
         Self.F_email := Qry.FieldByName('email').AsString;
         Self.F_datanascimento := Qry.FieldByName('datanascimento').AsDateTime;
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

end.
