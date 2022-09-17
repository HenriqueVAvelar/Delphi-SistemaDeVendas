inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 391
  Position = poScreenCenter
  ExplicitHeight = 420
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [0]
    Left = 492
    Top = 189
    Width = 19
    Height = 13
    Caption = 'CEP'
  end
  inherited pgcPrincipal: TPageControl
    Height = 340
    ExplicitHeight = 340
    inherited tabListagem: TTabSheet
      ExplicitHeight = 312
      inherited grdListagem: TDBGrid
        Height = 247
        Columns = <
          item
            Expanded = False
            FieldName = 'idcliente'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 372
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Width = 278
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitHeight = 312
      object Label1: TLabel
        Left = 488
        Top = 69
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label3: TLabel
        Left = 488
        Top = 165
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label4: TLabel
        Left = 3
        Top = 259
        Width = 81
        Height = 13
        Caption = 'Data Nascimento'
      end
      object edtIdcliente: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 32
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 88
        Width = 462
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 100
        TabOrder = 1
      end
      object edtCEP: TMaskEdit
        Left = 488
        Top = 88
        Width = 65
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 3
        Top = 138
        Width = 462
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 100
        TabOrder = 3
      end
      object edtBairro: TLabeledEdit
        Left = 488
        Top = 138
        Width = 185
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 100
        TabOrder = 4
      end
      object edtCidade: TLabeledEdit
        Left = 3
        Top = 184
        Width = 462
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 100
        TabOrder = 5
      end
      object edtEmail: TLabeledEdit
        Left = 3
        Top = 232
        Width = 462
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        MaxLength = 100
        TabOrder = 7
      end
      object edtDataNascimento: TDateEdit
        Left = 3
        Top = 278
        Width = 121
        Height = 21
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 8
      end
      object edtTelefone: TMaskEdit
        Left = 488
        Top = 184
        Width = 97
        Height = 21
        EditMask = '(99)9 9999 - 9999;1;_'
        MaxLength = 17
        TabOrder = 6
        Text = '(  )       -     '
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 340
    ExplicitTop = 340
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select'
      '  idcliente,'
      '  nome,'
      '  endereco,'
      '  cidade,'
      '  bairro,'
      '  estado,'
      '  cep,'
      '  telefone,'
      '  email,'
      '  datanascimento'
      'from tbclientes')
    object QryListagemidcliente: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idcliente'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 100
    end
    object QryListagemendereco: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'endereco'
      Size = 100
    end
    object QryListagemcidade: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Size = 100
    end
    object QryListagembairro: TWideStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Size = 100
    end
    object QryListagemestado: TWideStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Size = 2
    end
    object QryListagemcep: TWideStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
    object QryListagemtelefone: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
    end
    object QryListagememail: TWideStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
      Size = 100
    end
    object QryListagemdatanascimento: TDateTimeField
      DisplayLabel = 'Data Nascimento'
      FieldName = 'datanascimento'
    end
  end
end
