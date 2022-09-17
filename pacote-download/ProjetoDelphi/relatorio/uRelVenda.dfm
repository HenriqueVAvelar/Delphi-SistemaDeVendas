object frmRelVenda: TfrmRelVenda
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas'
  ClientHeight = 572
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 0
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dtsVenda
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Transparent = False
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 43
      BandType = btHeader
      Transparent = False
      object RLLabel1: TRLLabel
        Left = -1
        Top = 4
        Width = 69
        Height = 24
        Caption = 'Venda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 34
        Width = 718
        Height = 9
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 229
      Width = 718
      Height = 24
      BandType = btFooter
      Color = clWhite
      ParentColor = False
      Transparent = False
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 9
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = -1
        Top = 6
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
        Transparent = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 669
        Top = 6
        Width = 20
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
        Transparent = False
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 695
        Top = 6
        Width = 20
        Height = 16
        Alignment = taRightJustify
        Info = itLastPageNumber
        Text = ''
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 688
        Top = 6
        Width = 8
        Height = 16
        Caption = '/'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 615
        Top = 6
        Width = 53
        Height = 16
        Caption = 'P'#225'gina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 81
      Width = 718
      Height = 104
      DataFields = 'idvenda'
      Transparent = False
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 21
        BandType = btHeader
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        object RLDBText5: TRLDBText
          Left = 54
          Top = 1
          Width = 47
          Height = 16
          DataField = 'idvenda'
          DataSource = dtsVenda
          Text = ''
        end
        object RLLabel8: TRLLabel
          Left = -1
          Top = 1
          Width = 49
          Height = 16
          Caption = 'Venda:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object Detalhe: TRLBand
        Left = 0
        Top = 21
        Width = 718
        Height = 19
        Color = clWhite
        ParentColor = False
        Transparent = False
        object RLDBText1: TRLDBText
          Left = 54
          Top = 3
          Width = 27
          Height = 16
          Alignment = taRightJustify
          DataField = 'idcliente'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLDBText2: TRLDBText
          Left = 91
          Top = 3
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 656
          Top = 1
          Width = 62
          Height = 16
          Alignment = taRightJustify
          DataField = 'datavenda'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLLabel5: TRLLabel
          Left = -1
          Top = 3
          Width = 49
          Height = 16
          Caption = 'Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel11: TRLLabel
          Left = 81
          Top = 2
          Width = 8
          Height = 16
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 615
          Top = 1
          Width = 33
          Height = 16
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLSubDetail1: TRLSubDetail
        Left = 0
        Top = 40
        Width = 718
        Height = 57
        Color = clWhite
        DataSource = dtsVendasItens
        ParentColor = False
        Transparent = False
        object RLBand1: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 25
          BandType = btHeader
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel9: TRLLabel
            Left = 6
            Top = 4
            Width = 62
            Height = 14
            Caption = 'Produtos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel10: TRLLabel
            Left = 366
            Top = 4
            Width = 78
            Height = 16
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel12: TRLLabel
            Left = 484
            Top = 4
            Width = 92
            Height = 16
            Caption = 'Valor Unit'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel13: TRLLabel
            Left = 630
            Top = 4
            Width = 74
            Height = 16
            Caption = 'Valor Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLBand3: TRLBand
          Left = 0
          Top = 25
          Width = 718
          Height = 16
          Transparent = False
          object RLDBText3: TRLDBText
            Left = -6
            Top = 0
            Width = 57
            Height = 16
            Alignment = taRightJustify
            DataField = 'idproduto'
            DataSource = dtsVendasItens
            Text = ''
            Transparent = False
          end
          object RLLabel4: TRLLabel
            Left = 51
            Top = 0
            Width = 8
            Height = 16
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLDBText6: TRLDBText
            Left = 57
            Top = 0
            Width = 36
            Height = 16
            DataField = 'nome'
            DataSource = dtsVendasItens
            Text = ''
            Transparent = False
          end
          object RLDBText7: TRLDBText
            Left = 377
            Top = 0
            Width = 67
            Height = 16
            Alignment = taRightJustify
            DataField = 'quantidade'
            DataSource = dtsVendasItens
            Text = ''
            Transparent = False
          end
          object RLDBText8: TRLDBText
            Left = 504
            Top = 0
            Width = 72
            Height = 16
            Alignment = taRightJustify
            DataField = 'valorunitario'
            DataSource = dtsVendasItens
            Text = ''
            Transparent = False
          end
          object RLDBText9: TRLDBText
            Left = 632
            Top = 0
            Width = 72
            Height = 16
            Alignment = taRightJustify
            DataField = 'totalproduto'
            DataSource = dtsVendasItens
            Text = ''
            Transparent = False
          end
        end
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 185
      Width = 718
      Height = 44
      BandType = btSummary
      Color = clWhite
      ParentColor = False
      Transparent = False
      object RLDraw4: TRLDraw
        Left = 504
        Top = 7
        Width = 214
        Height = 8
        DrawKind = dkLine
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 528
        Top = 16
        Width = 105
        Height = 16
        Caption = 'Total da Venda:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBResult2: TRLDBResult
        Left = 617
        Top = 16
        Width = 101
        Height = 16
        Alignment = taRightJustify
        DataField = 'totalvenda'
        DataSource = dtsVenda
        Info = riSum
        Text = ''
        Transparent = False
      end
    end
  end
  object QryVenda: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select'
      '  tbvendas.idvenda,'
      '  tbvendas.idcliente,'
      '  tbclientes.nome,'
      '  tbvendas.datavenda,'
      '  tbvendas.totalvenda'
      'from tbvendas'
      
        'inner join tbclientes on tbclientes.idcliente = tbvendas.idclien' +
        'te'
      'where tbvendas.idvenda = :pidvenda')
    Params = <
      item
        DataType = ftInteger
        Name = 'pidvenda'
        ParamType = ptInput
        Value = '5'
      end>
    Left = 448
    Top = 65528
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pidvenda'
        ParamType = ptInput
        Value = '5'
      end>
    object QryVendaidvenda: TIntegerField
      FieldName = 'idvenda'
      ReadOnly = True
    end
    object QryVendaidcliente: TIntegerField
      FieldName = 'idcliente'
      Required = True
    end
    object QryVendanome: TWideStringField
      FieldName = 'nome'
      Size = 100
    end
    object QryVendadatavenda: TDateTimeField
      FieldName = 'datavenda'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QryVendatotalvenda: TFloatField
      FieldName = 'totalvenda'
      Required = True
      DisplayFormat = '#0.00'
    end
  end
  object dtsVenda: TDataSource
    DataSet = QryVenda
    Left = 504
    Top = 65528
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 560
    Top = 65528
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 608
    Top = 65528
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 656
    Top = 65528
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'P'#225'gina da Web'
    Left = 704
    Top = 65527
  end
  object QryVendasItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select'
      '  tbvendasitens.idvenda,'
      '  tbvendasitens.idproduto,'
      '  tbprodutos.nome,'
      '  tbvendasitens.quantidade,'
      '  tbvendasitens.valorunitario,'
      '  tbvendasitens.totalproduto'
      'from tbvendasitens'
      
        'inner join tbprodutos on tbprodutos.idproduto = tbvendasitens.id' +
        'produto'
      'where tbvendasitens.idvenda = :pidvenda'
      'order by tbvendasitens.idproduto')
    Params = <
      item
        DataType = ftInteger
        Name = 'pidvenda'
        ParamType = ptInput
        Value = 5
      end>
    Left = 104
    Top = 65528
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pidvenda'
        ParamType = ptInput
        Value = 5
      end>
    object QryVendasItensidvenda: TIntegerField
      FieldName = 'idvenda'
      Required = True
    end
    object QryVendasItensidproduto: TIntegerField
      FieldName = 'idproduto'
      Required = True
    end
    object QryVendasItensnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryVendasItensquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object QryVendasItensvalorunitario: TFloatField
      FieldName = 'valorunitario'
    end
    object QryVendasItenstotalproduto: TFloatField
      FieldName = 'totalproduto'
    end
  end
  object dtsVendasItens: TDataSource
    DataSet = QryVendasItens
    Left = 184
    Top = 65528
  end
end
