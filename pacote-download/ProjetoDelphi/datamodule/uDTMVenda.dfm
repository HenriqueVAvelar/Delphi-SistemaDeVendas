object dtmVendas: TdtmVendas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 296
  Width = 570
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select '
      '   idcliente,'
      '   nome'
      'from tbclientes')
    Params = <>
    Left = 56
    Top = 40
    object QryClienteidcliente: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idcliente'
      ReadOnly = True
    end
    object QryClientenome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 100
    end
  end
  object QryProduto: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select'
      '   idproduto,'
      '   nome,'
      '   valor,'
      '   quantidade'
      'from tbprodutos')
    Params = <>
    Left = 128
    Top = 40
    object QryProdutoidproduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idproduto'
      ReadOnly = True
    end
    object QryProdutonome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryProdutovalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object QryProdutoquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 136
    object cdsItensVendaidProduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idProduto'
    end
    object cdsItensVendanomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'nomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorUnitario'
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Total do Produto'
      FieldName = 'valorTotalProduto'
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 208
    Top = 32
  end
  object dtsProduto: TDataSource
    DataSet = QryProduto
    Left = 264
    Top = 32
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 336
    Top = 32
  end
end
