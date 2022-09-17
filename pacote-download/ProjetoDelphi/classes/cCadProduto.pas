unit cCadProduto;

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
     System.StrUtils,
     Vcl.Imaging.jpeg,
     Vcl.Graphics;

type
  TProduto = class
  private
    ConexaoDB:TZConnection;
    F_idProduto:Integer;  //Int
    F_nome:String; //VarChar
    F_descricao: string;
    F_valor:Double;
    F_quantidade: Double;
    F_idCategoria: Integer;
    F_foto: TBitmap;

  public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
  published
    property codigo        :Integer    read F_idProduto      write F_idProduto;
    property nome          :String     read F_nome           write F_nome;
    property descricao     :String     read F_descricao      write F_descricao;
    property valor         :Double     read F_valor          write F_valor;
    property quantidade    :Double     read F_quantidade     write F_quantidade;
    property idcategoria   :Integer    read F_idCategoria    write F_idCategoria;
    property foto          :TBitmap    read F_foto           write F_foto;
  end;

implementation

{$region 'Constructor and Destructor'}

constructor TProduto.Create(aConexao:TZConnection);
begin
  ConexaoDB := aConexao;
  F_foto := TBitmap.Create;
  F_foto.Assign(nil);
end;

destructor TProduto.Destroy;
begin
  if Assigned(F_foto) then
  begin
    F_foto.Assign(nil);
    F_foto.Free;
  end;
  inherited;
end;
{$endRegion}

{$region 'CRUD'}

function TProduto.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'Código: ' + IntToStr(F_idProduto) + #13 +
                'Descrição: ' + F_nome, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := false;
    abort;
  end;

  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from tbprodutos ' +
                ' where idproduto = :pidproduto ');
    Qry.ParamByName('pidproduto').AsInteger := F_idProduto;
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

function TProduto.Atualizar: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbprodutos '+
                '   set nome           = :pnome ' +
                '       ,descricao     = :pdescricao ' +
                '       ,valor         = :pvalor ' +
                '       ,quantidade    = :pquantidade ' +
                '       ,idcategoria   = :pidcategoria ' +
                '       ,foto          = :pfoto ' +
                ' where idproduto = :pidproduto ');
    Qry.ParamByName('pidproduto').AsInteger       := Self.F_idProduto;
    Qry.ParamByName('pnome').AsString             := Self.F_nome;
    Qry.ParamByName('pdescricao').AsString        := Self.F_descricao;
    Qry.ParamByName('pvalor').AsFloat             := Self.F_valor;
    Qry.ParamByName('pquantidade').AsFloat        := Self.F_quantidade;
    Qry.ParamByName('pidcategoria').AsInteger     := Self.F_idCategoria;

    if Self.F_foto.Empty then
    begin
      Qry.ParamByName('pfoto').Clear;
    end
    else
    begin
      Qry.ParamByName('pfoto').Assign(Self.F_foto);
    end;
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

function TProduto.Inserir: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('insert into tbprodutos (nome, ' +
                '                      descricao, ' +
                '                      valor,  ' +
                '                      quantidade,  ' +
                '                      idcategoria, ' +
                '                      foto ) ' +
                ' values              (:pnome, ' +
                '                      :pdescricao, ' +
                '                      :pvalor,  ' +
                '                      :pquantidade,  ' +
                '                      :pidcategoria, ' +
                '                      :pfoto) ' );

    Qry.ParamByName('pnome').AsString             := Self.F_nome;
    Qry.ParamByName('pdescricao').AsString        := Self.F_descricao;
    Qry.ParamByName('pvalor').AsFloat             := Self.F_valor;
    Qry.ParamByName('pquantidade').AsFloat        := Self.F_quantidade;
    Qry.ParamByName('pidcategoria').AsInteger     := Self.F_idCategoria;

    if Self.F_foto.Empty then
    begin
      Qry.ParamByName('pfoto').Clear;
    end
    else
    begin
      Qry.ParamByName('pfoto').Assign(Self.F_foto);
    end;

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

function TProduto.Selecionar(id: Integer): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select idproduto,' +
                '       nome, ' +
                '       descricao, ' +
                '       valor, ' +
                '       quantidade, ' +
                '       idcategoria, ' +
                '       foto ' +
                '  from tbprodutos ' +
                ' where idproduto = :pidproduto');
    Qry.ParamByName('pidproduto').AsInteger := id;
    Try
      Qry.Open;

      Self.F_idProduto     := Qry.FieldByName('idproduto').AsInteger;
      Self.F_nome          := Qry.FieldByName('nome').AsString;
      Self.F_descricao     := Qry.FieldByName('descricao').AsString;
      Self.F_valor         := Qry.FieldByName('valor').AsFloat;
      Self.F_quantidade    := Qry.FieldByName('quantidade').AsFloat;
      Self.F_idcategoria   := Qry.FieldByName('idcategoria').AsInteger;
      Self.F_foto.Assign(Qry.FieldByName('foto'));
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

end.
