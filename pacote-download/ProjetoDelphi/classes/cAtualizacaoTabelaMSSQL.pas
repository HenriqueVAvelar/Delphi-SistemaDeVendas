unit cAtualizacaoTabelaMSSQL;

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
     cAtualizacaoBancoDeDados,
     cCadUsuario;

Type
  TAtualizacaoTabelaMSSQL = class(TAtualizaBancoDados)
  private
    function TabelaExiste(aNomeTabela: String): Boolean;
  protected

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    procedure Categoria;
    procedure Cliente;
    procedure Produto;
    procedure Venda;
    procedure VendaItens;
    procedure Usuario;
    procedure AcaoAcesso;
    procedure UsuariosAcaoAcesso;
end;

implementation

{ TAtualizacaoTabelaMSSQL }

constructor TAtualizacaoTabelaMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  Categoria;
  Cliente;
  Produto;
  Venda;
  VendaItens;
  Usuario;
  AcaoAcesso;
  UsuariosAcaoAcesso;
end;

destructor TAtualizacaoTabelaMSSQL.Destroy;
begin

  inherited;
end;

function TAtualizacaoTabelaMSSQL.TabelaExiste(aNomeTabela: String): Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := false;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('select object_id (:pnometabela) as id ');
    Qry.ParamByName('pnometabela').AsString := aNomeTabela;
    Qry.Open;
    if Qry.FieldByName('id').AsInteger > 0 then
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

procedure TAtualizacaoTabelaMSSQL.AcaoAcesso;
begin
  if not TabelaExiste('tbacaoacesso') then
  begin
    ExecutaDiretoBancoDeDados(
    'create table tbacaoacesso( ' +
    'idacaoacesso int identity (1, 1) not null, ' +
    'descricao varchar(100) not null, ' +
    'chave varchar(60) not null, ' +
    'primary key (idacaoacesso) ' +
    ' ) ' );
  end;
end;

procedure TAtualizacaoTabelaMSSQL.Categoria;
begin
  if not TabelaExiste('tbcategorias') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE tbcategorias( ' +
	    'idcategoria int IDENTITY(1, 1) NOT NULL, ' +
	    'descricao  varchar(100) NULL, ' +
	    'PRIMARY KEY (idcategoria) ' +
      ' ) ' );
  end;
end;

procedure TAtualizacaoTabelaMSSQL.Cliente;
begin
  if not TabelaExiste('tbclientes') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE tbclientes( ' +
		  'idcliente int IDENTITY(1,1) NOT NULL, ' +
      'nome varchar(100) NULL, ' +
      'endereco varchar(100) null, ' +
      'cidade varchar(100) null, ' +
      'bairro varchar(100) null, ' +
      'estado varchar(2) null, ' +
      'cep varchar(10) null, ' +
      'telefone varchar(20) null, ' +
      'email varchar(100) null, ' +
      'dataNascimento datetime null ' +
      'PRIMARY KEY (idcliente) ' +
	    ') ' );
  end;
end;

procedure TAtualizacaoTabelaMSSQL.Produto;
begin
  if not TabelaExiste('tbprodutos') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE tbprodutos( ' +
      'idproduto int IDENTITY(1,1) NOT NULL, ' +
      'nome varchar(60) NULL, ' +
      'descricao varchar(255) null, ' +
      'valor decimal(18,5) default 0.00000 null, ' +
      'quantidade decimal(8,5) default 0.00000 null, ' +
      'idcategoria int null, ' +
      'PRIMARY KEY (idproduto), ' +
      'CONSTRAINT FK_ProdutosCategorias ' +
      'FOREIGN KEY (idcategoria) references tbcategorias(idcategoria) ' +
	    ') ' );
  end;
end;

procedure TAtualizacaoTabelaMSSQL.Venda;
begin
  if not TabelaExiste('tbvendas') then
  begin
    ExecutaDiretoBancoDeDados(
      'Create table tbvendas ( ' +
	    'idvenda int identity(1,1) not null, ' +
      'idcliente int not null, ' +
      'datavenda datetime default getdate(), ' +
      'totalvenda decimal(18,5) default 0.00000, ' +
      'PRIMARY KEY (idvenda), ' +
      'CONSTRAINT FK_VendasClientes FOREIGN KEY (idcliente) ' +
      'REFERENCES tbclientes(idcliente) ' +
	    ') ' );
  end;
end;

procedure TAtualizacaoTabelaMSSQL.VendaItens;
begin
  if not TabelaExiste('tbvendasItens') then
  begin
    ExecutaDiretoBancoDeDados(
      'Create table tbvendasItens ( ' +
      'idvenda int not null, ' +
      'idproduto int not null, ' +
      'valorunitario decimal (18,5) default 0.00000, ' +
      'quantidade decimal (18,5) default 0.00000, ' +
      'totalproduto decimal (18,5) default 0.00000, ' +
      'PRIMARY KEY (idvenda, idproduto), ' +
      'CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (idproduto) ' +
      'REFERENCES tbprodutos(idproduto) ' +
      ') ' );
  end;
end;

procedure TAtualizacaoTabelaMSSQL.Usuario;
var
  oUsuario: TUsuario;
begin
  if not TabelaExiste('tbusuarios') then
  begin
    ExecutaDiretoBancoDeDados(
      'create table tbusuarios ( ' +
      'idusuario int identity(1, 1) not null, ' +
      'nome varchar(50) not null, ' +
      'senha varchar(40) not null, ' +
      'primary key (idusuario), ' +
    	') ' );
  end;
  try
    oUsuario := TUsuario.Create(ConexaoDB);
    oUsuario.nome := 'ADMIN';
    oUsuario.senha := 'mudar@123';
    if not oUsuario.UsuarioExiste(oUsuario.nome) then
    begin
      oUsuario.Inserir;
    end;
  finally
    if Assigned(oUsuario) then
    begin
      FreeAndNil(oUsuario);
    end;
  end;
end;

procedure TAtualizacaoTabelaMSSQL.UsuariosAcaoAcesso;
begin
  if not TabelaExiste('tbusuariosacaoacesso') then
  begin
    ExecutaDiretoBancoDeDados(
    'create table tbusuariosacaoacesso( ' +
    'idusuario int not null, ' +
    'idacaoacesso int not null, ' +
    'ativo bit not null default 1, ' +
    'primary key (idusuario, idacaoacesso), ' +
    'constraint FK_UsuarioAcaoAcessoUsuario ' +
    'foreign key (idusuario) references tbusuarios(idusuario), ' +
    'constraint FK_UsuarioAcaoAcessoAcaoAcesso ' +
    'foreign key (idacaoacesso) references tbacaoacesso(idacaoacesso), ' +
    ' ) ' );
  end;
end;

end.
