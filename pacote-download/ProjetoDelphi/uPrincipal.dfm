object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 641
  ClientWidth = 922
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mainPrincipal
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 681
    Top = 41
    Width = 2
    Height = 581
    ExplicitLeft = 289
    ExplicitTop = -35
    ExplicitHeight = 547
  end
  object stbPrincipal: TStatusBar
    Left = 0
    Top = 622
    Width = 922
    Height = 19
    Panels = <
      item
        Width = 150
      end>
  end
  object pnlCima: TPanel
    Left = 0
    Top = 0
    Width = 922
    Height = 41
    Align = alTop
    TabOrder = 1
    OnClick = pnlCimaClick
  end
  object pnlEsquerda: TPanel
    Left = 0
    Top = 41
    Width = 681
    Height = 581
    Align = alLeft
    TabOrder = 2
    object Splitter3: TSplitter
      Left = 1
      Top = 331
      Width = 679
      Height = 2
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 226
      ExplicitWidth = 421
    end
    object pnlProdutoEstoque: TPanel
      Left = 1
      Top = 1
      Width = 679
      Height = 330
      Align = alTop
      TabOrder = 0
      object DBChart1: TDBChart
        Left = 1
        Top = 1
        Width = 677
        Height = 328
        Title.Text.Strings = (
          'Produto em Estoque')
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series1: TBarSeries
          Marks.Visible = False
          DataSource = dtmGrafico.QryProdutoEstoque
          Title = 'ProdutoEstoque'
          XLabelsSource = 'Label'
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
        end
      end
    end
    object pnlVendasDaUltimaSemana: TPanel
      Left = 1
      Top = 333
      Width = 679
      Height = 247
      Align = alClient
      TabOrder = 1
      object DBChart4: TDBChart
        Left = 1
        Top = 1
        Width = 677
        Height = 245
        Title.Text.Strings = (
          'Vendas da '#218'ltima Semana')
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series3: TFastLineSeries
          DataSource = dtmGrafico.QryVendasDaUltimaSemana
          Title = 'VendasDaUltimaSemana'
          XLabelsSource = 'Label'
          LinePen.Color = 10708548
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
        end
      end
    end
  end
  object pnlDireita: TPanel
    Left = 683
    Top = 41
    Width = 239
    Height = 581
    Align = alClient
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 1
      Top = 331
      Width = 237
      Height = 2
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 226
      ExplicitWidth = 78
    end
    object pnlVendaPorClienteUltimaSemana: TPanel
      Left = 1
      Top = 1
      Width = 237
      Height = 330
      Align = alTop
      TabOrder = 0
      object DBChart2: TDBChart
        Left = 1
        Top = 1
        Width = 235
        Height = 328
        Title.Text.Strings = (
          'Valor de Venda por Cliente na '#218'ltima Semana')
        Legend.TextStyle = ltsLeftPercent
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series2: TPieSeries
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          Marks.Style = smsLabelPercentTotal
          Marks.Callout.Length = 20
          DataSource = dtmGrafico.QryValorVendaPorCliente
          Title = 'ValorDeVendaPorClienteNaUltimaSemana'
          XLabelsSource = 'Label'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          OtherSlice.Legend.TextStyle = ltsPercent
          OtherSlice.Legend.Visible = False
        end
      end
    end
    object pnl10ProdutosMaisVendidos: TPanel
      Left = 1
      Top = 333
      Width = 237
      Height = 247
      Align = alClient
      TabOrder = 1
      object DBChart3: TDBChart
        Left = 1
        Top = 1
        Width = 235
        Height = 245
        Title.Text.Strings = (
          'Os 10 Produtos Mais Vendidos')
        Legend.TextStyle = ltsLeftPercent
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object PieSeries1: TPieSeries
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          Marks.Style = smsLabelPercentTotal
          Marks.Callout.Length = 20
          DataSource = dtmGrafico.Qry10ProdutosMaisVendidos
          Title = '10ProdutosMaisVendidos'
          XLabelsSource = 'Label'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          OtherSlice.Legend.TextStyle = ltsPercent
          OtherSlice.Legend.Visible = False
        end
      end
    end
  end
  object mainPrincipal: TMainMenu
    Left = 672
    Top = 8
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        ShortCut = 16451
        OnClick = Cliente1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Categoria1: TMenuItem
        Caption = 'Categoria'
        OnClick = Categoria1Click
      end
      object Produto1: TMenuItem
        Caption = 'Produto'
        ShortCut = 16464
        OnClick = Produto1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Usuario1: TMenuItem
        Caption = 'Usu'#225'rio'
        OnClick = Usuario1Click
      end
      object AoAcesso1: TMenuItem
        Caption = 'A'#231#227'o Acesso'
        OnClick = AoAcesso1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object UsuriosVsAcoes1: TMenuItem
        Caption = 'Usu'#225'rios Vs A'#231#245'es'
        OnClick = UsuriosVsAcoes1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object AlterarSenha1: TMenuItem
        Caption = 'Alterar Senha'
        OnClick = AlterarSenha1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object menuFechar: TMenuItem
        Caption = 'Fechar'
        OnClick = menuFecharClick
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Vendas1: TMenuItem
        Caption = 'Vendas'
        ShortCut = 120
        OnClick = Vendas1Click
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rio'
      object Categoria2: TMenuItem
        Caption = 'Categoria'
        OnClick = Categoria2Click
      end
      object Cliente2: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente2Click
      end
      object Fichadecliente1: TMenuItem
        Caption = 'Ficha de cliente'
        OnClick = Fichadecliente1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Produto2: TMenuItem
        Caption = 'Produto'
        OnClick = Produto2Click
      end
      object Produtoporcategoria1: TMenuItem
        Caption = 'Produtos por categoria'
        OnClick = Produtoporcategoria1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Vendapordata1: TMenuItem
        Caption = 'Venda por data'
        OnClick = Vendapordata1Click
      end
    end
  end
  object Timer1: TTimer
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 600
    Top = 8
  end
end
