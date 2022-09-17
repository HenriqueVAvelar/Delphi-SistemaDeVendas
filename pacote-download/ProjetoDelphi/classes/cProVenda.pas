unit cProVenda;

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
     Datasnap.DBClient,
     uEnum,
     cControleEstoque,
     System.SysUtils;

type
  TVenda = class
  private
    ConexaoDB: TZConnection;
    F_idVenda: Integer;
    F_idCliente: Integer;
    F_dataVenda: TDateTime;
    F_totalVenda: Double;
    function InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
    function ApagaItens(cds: TClientDataSet): Boolean;
    function InNot(cds: TClientDataSet): String;
    function EsteItemExiste(idvenda, idproduto: Integer): Boolean;
    function AtualizarItens(cds: TClientDataSet): Boolean;
    procedure RetornarEstoque(sCodigo: String; Acao: TAcaoExcluirEstoque);
    procedure BaixarEstoque(idproduto: Integer; quantidade: Double);

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir(cds: TClientDataSet): Integer;
    function Atualizar(cds: TClientDataSet): Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer; var cds: TClientDataSet): Boolean;
  published
    property IdVenda: Integer     read F_idVenda    write F_idVenda;
    property IdCliente: Integer   read F_idCliente  write F_idCliente;
    property DataVenda: TDateTime read F_dataVenda  write F_dataVenda;
    property TotalVenda: Double   read F_totalVenda write F_totalVenda;
  end;

implementation


{ TCategoria }

{$region 'Constructor and Destructor'}

constructor TVenda.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TVenda.Destroy;
begin

  inherited;
end;
{$endRegion}

{$region 'CRUD'}

function TVenda.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 +
                'Venda Nro: ' + IntToStr(F_idVenda), mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
     Result := false;
     abort;
  end;

  try
    Result := true;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    //Apaga os Itens Primeiro
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM tbvendasitens ' +
                ' WHERE idvenda = :pidvenda ');
    Qry.ParamByName('pidvenda').AsInteger := F_idVenda;
    Try
      Qry.ExecSQL;
      //Apaga a Tabela Master
      Qry.SQL.Clear;
      Qry.SQL.Add('DELETE FROM tbvendas ' +
                  ' WHERE idvenda = :pidvenda ');
      Qry.ParamByName('pidvenda').AsInteger := F_idVenda;
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

function TVenda.Atualizar(cds: TClientDataSet): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE tbvendas ' +
                '   SET idcliente = :pidcliente ' +
                '      ,dataVenda = :pdatavenda ' +
                '      ,totalVenda = :ptotalvenda ' +
                ' WHERE idvenda = :pidvenda ');
    Qry.ParamByName('pidvenda').AsInteger    := Self.F_idVenda;
    Qry.ParamByName('pidcliente').AsInteger  := Self.F_idcliente;
    Qry.ParamByName('pdatavenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('ptotalvenda').AsFloat   := Self.F_totalVenda;

    Try
      //Update tbvendas
      Qry.ExecSQL;

      //Apagar itens no banco de dados que foram apagados na tela
      ApagaItens(cds);

      cds.First;
      while not cds.Eof do
      begin
        if EsteItemExiste(Self.F_idVenda, cds.FieldByName('idproduto').AsInteger) then
        begin
          AtualizarItens(cds);
        end
        else
        begin
          InserirItens(cds, Self.F_idVenda);
        end;
        cds.Next;
      end;
      ConexaoDB.Commit;
    Except
      Result := false;
      ConexaoDB.Rollback;
    End;
  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function Tvenda.AtualizarItens(cds: TClientDataSet): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    RetornarEstoque(cds.FieldByName('idproduto').AsString, aeeAlterar);
    Qry := TZQuery.Create(Nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('update tbvendasitens ' +
                '   set valorunitario = :pvalorunitario ' +
                '      ,quantidade = :pquantidade ' +
                '      ,totalproduto = :ptotalproduto ' +
                ' where idvenda = :pidvenda and idproduto = :pidproduto ');
    Qry.ParamByName('pidvenda').AsInteger := Self.F_idVenda;
    Qry.ParamByName('pidproduto').AsInteger := cds.FieldByName('idproduto').AsInteger;
    Qry.ParamByName('pvalorunitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('pquantidade').AsFloat := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('ptotalproduto').AsFloat := cds.FieldByName('valorTotalProduto').AsFloat;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      BaixarEstoque(cds.FieldByName('idproduto').AsInteger, cds.FieldByName('quantidade').AsFloat);
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

function Tvenda.EsteItemExiste(idvenda: Integer; idproduto: Integer): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(Nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select count(idvenda) as qtde ' +
                '  from tbvendasitens ' +
                ' where idvenda = :pidvenda and idproduto = :pidproduto ');
    Qry.ParamByName('pidvenda').AsInteger := idvenda;
    Qry.ParamByName('pidproduto').AsInteger := idproduto;
    try
      Qry.Open;

      if Qry.FieldByName('qtde').AsInteger > 0 then
      begin
        Result := true;
      end
      else
      begin
        Result := false;
      end;

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

function Tvenda.ApagaItens(cds: TClientDataSet): Boolean;
var
  Qry: TZQuery;
  sCodNoCds:String;
begin
  try
    Result := true;
    sCodNoCds := InNot(cds);
    RetornarEstoque(sCodNoCds, aeeApagar);
    Qry := TZQuery.Create(Nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('  delete ' +
                '  from tbvendasitens ' +
                ' where idvenda = :pidvenda ' +
                '   and idproduto not in (' + sCodNoCds + ') ');
    Qry.ParamByName('pidvenda').AsInteger := Self.F_idVenda;
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

function TVenda.InNot(cds: TClientDataSet): String;
var
  sInNot: String;
begin
  sInNot := EmptyStr;
  cds.First;
  while not cds.Eof do
  begin
    if sInNot = EmptyStr then
    begin
      sInNot := cds.FieldByName('idproduto').AsString
    end
    else
    begin
      sInNot := sInNot + ', ' + cds.FieldByName('idproduto').AsString;
    end;
    Result := sInNot;
  end;
end;

function TVenda.Inserir(cds: TClientDataSet): Integer;
var
  Qry: TZQuery;
  IdVendaGerado: Integer;
begin
  try
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    //Faz a Inclusão no Banco de Dados
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO tbvendas (idcliente, datavenda, totalvenda)  '+
                '            VALUES (:pidcliente, :pdatavenda, :ptotalvenda )');
    Qry.ParamByName('pidcliente').AsInteger  := Self.F_idCliente;
    Qry.ParamByName('pdatavenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('ptotalvenda').AsFloat   := Self.F_totalVenda;

    Try
      Qry.ExecSQL;
      //Recupera o ID Gerado no Insert
      Qry.SQL.Clear;
      Qry.SQL.Add('SELECT SCOPE_IDENTITY() AS ID');
      Qry.Open;

      //Id da tabela Master (Venda)
      IdVendaGerado := Qry.FieldByName('ID').AsInteger;

      {$region 'Gravar na tabela VendasItens'}
      cds.First;
      while not cds.Eof do
      begin
        InserirItens(cds, IdVendaGerado);
        cds.Next;
      end;
      {$endregion}

      ConexaoDB.Commit;
      Result := IdVendaGerado
    Except
      ConexaoDB.Rollback;
      Result := -1;
    End;

  finally
    if Assigned(Qry) then
    begin
      FreeAndNil(Qry);
    end;
  end;
end;

function TVenda.InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('Insert into tbvendasitens (idvenda, idproduto, valorunitario, quantidade, totalproduto) ' +
                '                   values (:pidvenda, :pidproduto, :pvalorunitario, :pquantidade, :ptotalproduto) ');
    Qry.ParamByName('pidvenda').AsInteger := IdVenda;
    Qry.ParamByName('pidproduto').AsInteger := cds.FieldByName('idproduto').AsInteger;
    Qry.ParamByName('pvalorunitario').AsFloat := cds.FieldByName('valorunitario').AsFloat;
    Qry.ParamByName('pquantidade').AsFloat := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('ptotalproduto').AsFloat := cds.FieldByName('valortotalproduto').AsFloat;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      BaixarEstoque(cds.FieldByName('idproduto').AsInteger, cds.FieldByName('quantidade').AsFloat);
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

function TVenda.Selecionar(id: Integer; var cds: TClientDataSet): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT idvenda ' +
                '      ,idcliente ' +
                '      ,datavenda ' +
                '      ,totalvenda ' +
                '  FROM tbvendas ' +
                ' WHERE idvenda = :pidvenda');
    Qry.ParamByName('pidvenda').AsInteger := id;
    Try
      Qry.Open;

      Self.F_idVenda    := Qry.FieldByName('idvenda').AsInteger;
      Self.F_idCliente  := Qry.FieldByName('idcliente').AsInteger;
      Self.F_dataVenda  := Qry.FieldByName('datavenda').AsDateTime;
      Self.F_totalVenda := Qry.FieldByName('totalvenda').AsFloat;

      {$region 'Selecionar na tabela tbvendasitens'}
      //Apaga o ClientDataSet caso esteja com registro
      cds.First;
      while not cds.Eof do
      begin
        cds.Delete;
      end;

      //Seleciona os itens do banco de dados com a propriedade F_idVenda
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('select tbvendasitens.idproduto, ' +
                  '       tbprodutos.nome,' +
                  '       tbvendasitens.valorunitario,' +
                  '       tbvendasitens.quantidade,' +
                  '       tbvendasitens.totalproduto' +
                  '  from tbvendasitens ' +
                  '       inner join tbprodutos on tbprodutos.idproduto = tbvendasitens.idproduto '+
                  ' where tbvendasitens.idvenda = :pidvenda ');
      Qry.ParamByName('pidvenda').AsInteger := Self.F_idVenda;
      Qry.Open;

      //Pega da query e coloca no ClientDataSet
      Qry.First;
      while not Qry.Eof do
      begin
        cds.Append;
        cds.FieldByName('idproduto').AsInteger := Qry.FieldByName('idproduto').AsInteger;
        cds.FieldByName('nomeproduto').AsString := Qry.FieldByName('nome').AsString;
        cds.FieldByName('valorunitario').AsFloat := Qry.FieldByName('valorunitario').AsFloat;
        cds.FieldByName('quantidade').AsFloat := Qry.FieldByName('quantidade').AsFloat;
        cds.FieldByName('valortotalproduto').AsFloat := Qry.FieldByName('totalproduto').AsFloat;
        cds.Post;
        Qry.Next;
      end;
      cds.First;
      {$endregion}

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

{$endRegion}

{$region 'Controle de Estoque'}

procedure TVenda.RetornarEstoque(sCodigo: String; Acao: TAcaoExcluirEstoque);
var
  Qry: TZQuery;
  oControleEstoque: TControleEstoque;
begin
  Qry := TZQuery.Create(nil);
  Qry.Connection := ConexaoDB;
  Qry.SQL.Clear;
  Qry.SQL.Add(' select idproduto, quantidade, ' +
              '   from tbvendasitens ' +
              '  where idvenda = :pidvenda ');
  if Acao = aeeApagar then
  begin
    Qry.SQL.Add(' and idproduto not in (' + sCodigo + ') ');
  end
  else
  begin
    Qry.SQL.Add(' and idproduto = (' + sCodigo + ') ');
  end;
  Qry.ParamByName('pidvenda').AsInteger := Self.F_idVenda;
  try
    oControleEstoque := TControleEstoque.Create(ConexaoDB);
    Qry.Open;
    Qry.First;
    while not Qry.Eof do
    begin
      oControleEstoque.IdProduto := Qry.FieldByName('idproduto').AsInteger;
      oControleEstoque.Quantidade := Qry.FieldByName('quantidade').AsFloat;
      oControleEstoque.RetornarEstoque;
      Qry.Next;
    end;
  finally
    if Assigned(oControleEstoque) then
    begin
      FreeAndNil(oControleEstoque);
    end;
  end;
end;

procedure TVenda.BaixarEstoque(idproduto: Integer; quantidade: Double);
var
  oControleEstoque: TControleEstoque;
begin
  try
    oControleEstoque := TControleEstoque.Create(ConexaoDB);
    oControleEstoque.IdProduto := idproduto;
    oControleEstoque.Quantidade := quantidade;
    oControleEstoque.BaixarEstoque;
  finally
    if Assigned(oControleEstoque) then
    begin
      FreeAndNil(oControleEstoque);
    end;
  end;
end;

{$endRegion}

end.
