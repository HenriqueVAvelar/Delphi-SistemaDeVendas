object frmRelCadProdutoComGrupoCategoria: TfrmRelCadProdutoComGrupoCategoria
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Produto por Categoria'
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dtsProdutos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 43
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = -1
        Top = 4
        Width = 373
        Height = 24
        Caption = 'Listagem de Produtos Por Categoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 34
        Width = 718
        Height = 9
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 225
      Width = 718
      Height = 24
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 9
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = -1
        Top = 6
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 669
        Top = 6
        Width = 20
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 695
        Top = 6
        Width = 20
        Height = 16
        Alignment = taRightJustify
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 688
        Top = 6
        Width = 8
        Height = 16
        Caption = '/'
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
      end
    end
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 81
      Width = 718
      Height = 144
      DataFields = 'idcategoria'
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
          Left = 90
          Top = 0
          Width = 23
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'idcategoria'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLLabel8: TRLLabel
          Left = 0
          Top = 0
          Width = 84
          Height = 16
          Caption = 'CATEGORIA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText6: TRLDBText
          Left = 124
          Top = 0
          Width = 117
          Height = 16
          DataField = 'DescricaoCategoria'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLLabel9: TRLLabel
          Left = 116
          Top = -2
          Width = 8
          Height = 16
          Alignment = taRightJustify
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 21
        Width = 718
        Height = 24
        BandType = btColumnHeader
        object RLPanel1: TRLPanel
          Left = 0
          Top = 0
          Width = 718
          Height = 24
          Align = faClient
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel4: TRLLabel
            Left = -1
            Top = 2
            Width = 49
            Height = 16
            Caption = 'C'#243'digo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel5: TRLLabel
            Left = 63
            Top = 2
            Width = 115
            Height = 16
            Caption = 'Nome do Produto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel6: TRLLabel
            Left = 351
            Top = 2
            Width = 152
            Height = 16
            Caption = 'Quantidade de Estoque'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel7: TRLLabel
            Left = 680
            Top = 2
            Width = 38
            Height = 16
            Caption = 'Valor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
      end
      object Detalhe: TRLBand
        Left = 0
        Top = 45
        Width = 718
        Height = 19
        object RLDBText1: TRLDBText
          Left = -1
          Top = 1
          Width = 57
          Height = 16
          DataField = 'idproduto'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 63
          Top = 1
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 436
          Top = 1
          Width = 67
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 688
          Top = 1
          Width = 30
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProdutos
          Text = ''
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 64
        Width = 718
        Height = 49
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 612
          Top = 8
          Width = 106
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProdutos
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 320
          Top = -1
          Width = 398
          Height = 8
          DrawKind = dkLine
        end
        object RLDBResult2: TRLDBResult
          Left = 630
          Top = 29
          Width = 88
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProdutos
          Info = riAverage
          Text = ''
        end
        object RLLabel10: TRLLabel
          Left = 352
          Top = 8
          Width = 248
          Height = 16
          Caption = 'Quantidade de Estoque Por Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel11: TRLLabel
          Left = 423
          Top = 29
          Width = 177
          Height = 16
          Caption = 'Valor M'#233'dio Por Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select'
      '   tbprodutos.idproduto,'
      '   tbprodutos.nome,'
      '   tbprodutos.descricao,'
      '   tbprodutos.valor,'
      '   tbprodutos.quantidade,'
      '   tbprodutos.idcategoria,'
      '   tbcategorias.descricao as DescricaoCategoria'
      'from tbprodutos'
      
        'left join tbcategorias on tbcategorias.idcategoria = tbprodutos.' +
        'idcategoria'
      'order by tbprodutos.idcategoria, tbprodutos.idproduto')
    Params = <>
    Left = 448
    Top = 65528
    object QryProdutosidproduto: TIntegerField
      FieldName = 'idproduto'
      ReadOnly = True
    end
    object QryProdutosnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryProdutosdescricao: TWideStringField
      FieldName = 'descricao'
      Size = 255
    end
    object QryProdutosvalor: TFloatField
      FieldName = 'valor'
    end
    object QryProdutosquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object QryProdutosidcategoria: TIntegerField
      FieldName = 'idcategoria'
    end
    object QryProdutosDescricaoCategoria: TWideStringField
      FieldName = 'DescricaoCategoria'
      Required = True
      Size = 100
    end
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
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
end
