object frmRelVendaPorData: TfrmRelVendaPorData
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas por Data'
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
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dtsVenda
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
        Width = 291
        Height = 24
        Caption = 'Listagem de Venda por Data'
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
      Top = 226
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
      Height = 104
      DataFields = 'datavenda'
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
          Left = 38
          Top = 0
          Width = 62
          Height = 16
          DataField = 'datavenda'
          DataSource = dtsVenda
          Text = ''
        end
        object RLLabel8: TRLLabel
          Left = 0
          Top = 0
          Width = 37
          Height = 16
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
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
            Width = 110
            Height = 16
            Caption = 'Nome do Cliente'
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
            Top = 2
            Width = 103
            Height = 16
            Caption = 'Valor da Venda'
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
          Width = 52
          Height = 16
          DataField = 'idcliente'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 63
          Top = 1
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 656
          Top = 1
          Width = 62
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalvenda'
          DataSource = dtsVenda
          Text = ''
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 64
        Width = 718
        Height = 33
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 617
          Top = 8
          Width = 101
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalvenda'
          DataSource = dtsVenda
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 504
          Top = -1
          Width = 214
          Height = 8
          DrawKind = dkLine
        end
        object RLLabel10: TRLLabel
          Left = 520
          Top = 8
          Width = 98
          Height = 16
          Caption = 'Total por Data:'
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
    object RLBand4: TRLBand
      Left = 38
      Top = 185
      Width = 718
      Height = 41
      BandType = btSummary
      object RLDraw4: TRLDraw
        Left = 504
        Top = 7
        Width = 214
        Height = 8
        DrawKind = dkLine
      end
      object RLLabel6: TRLLabel
        Left = 528
        Top = 16
        Width = 79
        Height = 16
        Caption = 'Total Geral:'
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
      end
    end
  end
  object QryVenda: TZQuery
    Connection = dtmPrincipal.ConexaoDB
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
      'where tbvendas.datavenda between :pdatainicio and :pdatafim'
      'order by tbvendas.datavenda, tbvendas.idcliente')
    Params = <
      item
        DataType = ftDate
        Name = 'pdatainicio'
        ParamType = ptInput
        Value = '01/04/2021'
      end
      item
        DataType = ftDate
        Name = 'pdatafim'
        ParamType = ptInput
        Value = '30/04/2021'
      end>
    Left = 448
    Top = 65528
    ParamData = <
      item
        DataType = ftDate
        Name = 'pdatainicio'
        ParamType = ptInput
        Value = '01/04/2021'
      end
      item
        DataType = ftDate
        Name = 'pdatafim'
        ParamType = ptInput
        Value = '30/04/2021'
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
    end
    object QryVendatotalvenda: TFloatField
      FieldName = 'totalvenda'
      Required = True
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
end
