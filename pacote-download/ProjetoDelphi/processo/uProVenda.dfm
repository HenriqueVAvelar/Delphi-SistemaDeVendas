inherited frmProVenda: TfrmProVenda
  Caption = 'Vendas'
  ClientHeight = 462
  Position = poScreenCenter
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Height = 411
    ActivePage = tabManutencao
    ExplicitHeight = 411
    inherited tabListagem: TTabSheet
      ExplicitHeight = 383
      inherited grdListagem: TDBGrid
        Height = 318
        Columns = <
          item
            Expanded = False
            FieldName = 'idvenda'
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'idcliente'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 460
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'datavenda'
            Width = 93
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'totalvenda'
            Width = 82
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 815
      ExplicitHeight = 383
      object Label5: TLabel
        Left = 148
        Top = 21
        Width = 33
        Height = 13
        Caption = 'Cliente'
      end
      object Label4: TLabel
        Left = 563
        Top = 21
        Width = 56
        Height = 13
        Caption = 'Data Venda'
      end
      object edtIdVenda: TLabeledEdit
        Tag = 1
        Left = 2
        Top = 36
        Width = 121
        Height = 21
        EditLabel.Width = 70
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Venda'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object lkpCliente: TDBLookupComboBox
        Left = 148
        Top = 36
        Width = 392
        Height = 21
        KeyField = 'idcliente'
        ListField = 'nome'
        ListSource = dtmVendas.dtsCliente
        TabOrder = 1
      end
      object edtDataVenda: TDateEdit
        Left = 563
        Top = 36
        Width = 121
        Height = 21
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 2
      end
      object Panel2: TPanel
        Left = 0
        Top = 63
        Width = 815
        Height = 320
        Align = alBottom
        TabOrder = 3
        object pnlItens: TPanel
          Left = 1
          Top = 1
          Width = 813
          Height = 50
          Align = alTop
          TabOrder = 0
          object Label1: TLabel
            Left = 2
            Top = 3
            Width = 38
            Height = 13
            Caption = 'Produto'
          end
          object Label2: TLabel
            Left = 329
            Top = 3
            Width = 64
            Height = 13
            Caption = 'Valor Unit'#225'rio'
          end
          object Label6: TLabel
            Left = 432
            Top = 3
            Width = 56
            Height = 13
            Caption = 'Quantidade'
          end
          object Label7: TLabel
            Left = 532
            Top = 3
            Width = 80
            Height = 13
            Caption = 'Total do Produto'
          end
          object lkpProduto: TDBLookupComboBox
            Left = 2
            Top = 22
            Width = 321
            Height = 21
            KeyField = 'idproduto'
            ListField = 'nome'
            ListSource = dtmVendas.dtsProduto
            TabOrder = 0
            OnExit = lkpProdutoExit
          end
          object edtValorUnitario: TCurrencyEdit
            Left = 332
            Top = 22
            Width = 90
            Height = 21
            DisplayFormat = ',0.00;-R$,0.00'
            TabOrder = 1
          end
          object edtQuantidade: TCurrencyEdit
            Left = 432
            Top = 22
            Width = 90
            Height = 21
            DisplayFormat = ',0.00;-R$,0.00'
            TabOrder = 2
            OnEnter = edtQuantidadeEnter
            OnExit = edtQuantidadeExit
          end
          object edtTotalProduto: TCurrencyEdit
            Left = 532
            Top = 22
            Width = 90
            Height = 21
            TabStop = False
            DisplayFormat = ',0.00;-R$,0.00'
            ParentColor = True
            ReadOnly = True
            TabOrder = 3
          end
          object btnAdicionarItem: TBitBtn
            Left = 635
            Top = 18
            Width = 81
            Height = 25
            Caption = 'A&dicionar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FF0A6B0A0A6B0A0A6B0A0A6B0AFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFB25D130A6B0A42D37331B85A0A6B0AA8
              4E0FA54A0EA4480DA1440DA0420C9F3F0C9D3E0BFF00FFFF00FFFF00FFFF00FF
              B561140A6B0A78F3A440D1710A6B0AFBF0DEFBEFDAFBEDD5FBEBD1FBE9CDFBE7
              C89E400BFF00FFFF00FF0A6B0A0A6B0A0A6B0A0A6B0A78F3A444D5740A6B0A0A
              6B0A0A6B0A0A6B0AFCEDD6FBEBD1FBEACEA1430CFF00FFFF00FF0A6B0A78F3A4
              53E4844FE1804CDD7C48D97845D67541D27231B85A0A6B0AFBEFDBFCEDD6FBEB
              D1A3470DFF00FFFF00FF0A6B0A78F3A478F3A478F3A478F3A44DDE7D78F3A478
              F3A442D3730A6B0AFCF1E0FBEFDBFBEDD7A64B0EFF00FFFF00FF0A6B0A0A6B0A
              0A6B0A0A6B0A78F3A450E2810A6B0A0A6B0A0A6B0A0A6B0AFCF4E4FBF1E1FCEF
              DCA94F0FFF00FFFF00FFFF00FFFF00FFC375190A6B0A78F3A454E5850A6B0AFC
              F9F5FCF7F1FCF7EEFCF5E9FBF3E4FCF2E2AC5110FF00FFFF00FFFF00FFFF00FF
              C579190A6B0A78F3A478F3A40A6B0AFCFAF7FCF9F5FCF7F2FCF7EEFBF6E9FBF3
              E5AD5611FF00FFFF00FFFF00FFFF00FFC77C1A0A6B0A0A6B0A0A6B0A0A6B0AFC
              FBFBFCFAF8FCF9F5FBF8F2FCF7EEFBF6EAB05A12FF00FFFF00FFFF00FFFF00FF
              C97F1CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFAFCFBF8FCF9F6FCF8F2FCF7
              EFB35E13FF00FFFF00FFFF00FFFF00FFCC821CFCFCFCFCFCFCFCFCFCFCFCFCFC
              FCFCFCFCFCFCFCFAFCFBF9FCFAF6FCF8F3B66214FF00FFFF00FFFF00FFFF00FF
              CE851DFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFCFBF9FCFA
              F7B96615FF00FFFF00FFFF00FFFF00FFCF861DFCFCFCFCFCFCFCFCFCFCFCFCFC
              FCFCFCFCFCFCFCFCFCFCFCFCFCFBFCFBF8BC6A16FF00FFFF00FFFF00FFFF00FF
              CF871DCF871DCE861DCC831CCC821CCA801BC87D1BC67A1AC47719C37419C172
              17BF6F17FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 4
            OnClick = btnAdicionarItemClick
          end
          object btnApagarItem: TBitBtn
            Left = 722
            Top = 18
            Width = 81
            Height = 25
            Caption = 'Re&mover'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
              FF00FFBDA79BB17B5BA95C2FA44B199B3B0A9B3B0A9D400FA8592DB17B5EBEA8
              9EFF00FFFF00FFFF00FFFF00FFFF00FFAB6945A44A12BF6E21D89D5AE6BF8BEE
              CC97EFCB91EDC486E1AE71C6844AA65020AF7556FF00FFFF00FFFF00FFFF00FF
              A14818E9BA7CF6DCBBF7E4CCF7ECDBF7E6CBF8E0BAF9DAAAF9D9A9F9D7A8F0C8
              95A44E22FF00FFFF00FFFF00FFFF00FFA3491AF4D1A6F5DAB6F6E3C7F7E9D4F7
              E4C6F7DEB5F8D9A7F8D8A7F9D6A7F9D4A5A34818FF00FFFF00FFFF00FFC3B8B2
              AE5E2DF3D0A1F4D8B1F5E1C2F6E6CFF7E2C0F7DCB0F7D7A5F8D7A5F8D6A6F9D4
              A5B36132C3BBB6FF00FFFF00FFBEA89EBB723EF2CE9DF3D6AEF4DEBFF5E4C8F6
              DFBBF7D9ACF7D6A3F7D5A3F8D5A4F8D4A4C27B4DBEAAA0FF00FFFF00FFB89787
              C7824BF1CC99F2D4AAF3DCBAF4E1C2F5DCB6F6D8A9F7D4A0F7D4A2F7D4A3F8D4
              A4CF9163B99A89FF00FFFF00FFB48973CF9054F0CA96F2D2A6F2DAB6F3DEBDF4
              DAB1F5D6A6F6D39EF7D3A0F7D3A1F7D2A2DDA877B58A73FF00FFFF00FFAF7658
              D89C5DEFC891F1D0A2F2D8B1F3DBB8F4D8ADF5D4A2F6D29CF6D29EF7D2A0F7D2
              A2E6B485B1795BFF00FFFF00FFAA643CE0A768EFC68EF0CE9EF1D6AEF2D9B3F3
              D6A9F4D29FF5D19AF6D19DF7D29FF7D2A1EDC091AC6844FF00FFFF00FFA55426
              E5B172F0D0A2F2D8B3F5E3C7F5E4CBF6E5CBF6E5CBF7E6CDF7E7D0F7E1C0F8DD
              B9F3CA9AAA5A2FFF00FFFF00FFBE805FEBCB9CE4B162E1A64ADD9A34DFA141E1
              A84FE3AE5CE5B569E7BB76ECCA95F1D8B2F4E3CDC79073FF00FFFF00FF9E4211
              B45D0FC57315CF8322D79431DFA242E1A84FE4AE5DE5B56AE1B16FDAA76CCF97
              62B97344A24B1FFF00FFFF00FFC3B8B2B2836AAB6238A653239F44139B3B0A9B
              3B0A9B3B0A9B3B0AA14415A7562AAE6C48B48A75C5BEBBFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 5
            TabStop = False
            OnClick = btnApagarItemClick
          end
        end
        object pnlTotalizador: TPanel
          Left = 1
          Top = 269
          Width = 813
          Height = 50
          Align = alBottom
          TabOrder = 1
          object Label3: TLabel
            Left = 593
            Top = 18
            Width = 84
            Height = 13
            Caption = 'Valor da Venda'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtValorTotal: TCurrencyEdit
            Left = 683
            Top = 14
            Width = 121
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
        end
        object pnlItemVenda: TPanel
          Left = 1
          Top = 51
          Width = 813
          Height = 218
          Align = alClient
          TabOrder = 2
          object dbGridItensVenda: TDBGrid
            Left = 1
            Top = 1
            Width = 811
            Height = 216
            Align = alClient
            DataSource = dtmVendas.dtsItensVenda
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDblClick = dbGridItensVendaDblClick
            Columns = <
              item
                Expanded = False
                FieldName = 'idProduto'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'nomeProduto'
                Width = 440
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'quantidade'
                Width = 77
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'valorUnitario'
                Width = 79
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'valorTotalProduto'
                Width = 103
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 411
    ExplicitTop = 411
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select '
      '   tbvendas.idvenda,'
      '   tbvendas.idcliente,'
      '   tbclientes.nome,'
      '   tbvendas.datavenda,'
      '   tbvendas.totalvenda'
      'from tbvendas'
      
        'inner join tbclientes on tbclientes.idcliente = tbvendas.idclien' +
        'te')
    Left = 364
    Top = 16
    object QryListagemidvenda: TIntegerField
      DisplayLabel = 'N'#250'mero Venda'
      FieldName = 'idvenda'
      Origin = 'tbvendas'
      ReadOnly = True
    end
    object QryListagemidcliente: TIntegerField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'idcliente'
      Origin = 'tbvendas'
      Required = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome do Cliente'
      FieldName = 'nome'
      Origin = 'tbclientes'
      Size = 100
    end
    object QryListagemdatavenda: TDateTimeField
      DisplayLabel = 'Data Venda'
      FieldName = 'datavenda'
      Origin = 'tbvendas'
      Required = True
    end
    object QryListagemtotalvenda: TFloatField
      DisplayLabel = 'Total da Venda'
      FieldName = 'totalvenda'
      Origin = 'tbvendas'
      Required = True
    end
  end
  inherited dtsListagem: TDataSource
    Left = 436
    Top = 16
  end
end
