object dtmGrafico: TdtmGrafico
  OldCreateOrder = False
  Height = 400
  Width = 649
  object QryProdutoEstoque: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select'
      
        '  convert(varchar, idproduto) + '#39' - '#39' + nome as Label, quantidad' +
        'e as Value'
      'from tbprodutos')
    Params = <>
    Left = 39
    Top = 22
    object QryProdutoEstoqueLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object QryProdutoEstoqueValue: TFloatField
      FieldName = 'Value'
    end
  end
  object dtsProdutoEstoque: TDataSource
    DataSet = QryProdutoEstoque
    Left = 111
    Top = 33
  end
  object QryValorVendaPorCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'select convert(varchar, tbvendas.idcliente) + '#39' - '#39' + tbclientes' +
        '.nome as Label,'
      '  sum(tbvendas.totalvenda) as Value'
      'from tbvendas'
      'inner join tbclientes on'
      '  tbclientes.idcliente = tbvendas.idcliente'
      
        'where tbvendas.datavenda between convert(date, getdate() - 7) an' +
        'd convert(date, getdate())'
      'group by tbvendas.idcliente, tbclientes.nome')
    Params = <>
    Left = 303
    Top = 22
    object QryValorVendaPorClienteLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 133
    end
    object QryValorVendaPorClienteValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
  object Qry10ProdutosMaisVendidos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'select top 10 convert(varchar, tbvendasitens.idproduto) + '#39' - '#39' ' +
        '+ tbprodutos.nome as Label,'
      '  sum(tbvendasitens.totalproduto) as Value'
      'from tbvendasitens'
      'inner join tbprodutos on'
      '  tbprodutos.idproduto = tbvendasitens.idproduto'
      'group by tbvendasitens.idproduto, tbprodutos.nome'
      'order by Label desc')
    Params = <>
    Left = 415
    Top = 38
    object Qry10ProdutosMaisVendidosLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object Qry10ProdutosMaisVendidosValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
  object QryVendasDaUltimaSemana: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select tbvendas.datavenda as Label,'
      '  sum(tbvendas.totalvenda) as Value'
      'from tbvendas'
      
        'where tbvendas.datavenda between convert(date, getdate() - 7) an' +
        'd convert(date, getdate())'
      'group by tbvendas.datavenda')
    Params = <>
    Left = 223
    Top = 129
    object QryVendasDaUltimaSemanaLabel: TDateTimeField
      FieldName = 'Label'
      Required = True
    end
    object QryVendasDaUltimaSemanaValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
end
