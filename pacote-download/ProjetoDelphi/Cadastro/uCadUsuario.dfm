inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 355
  ClientWidth = 729
  Position = poScreenCenter
  ExplicitWidth = 735
  ExplicitHeight = 384
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 729
    Height = 304
    ExplicitWidth = 729
    ExplicitHeight = 304
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 721
      ExplicitHeight = 276
      inherited pnlListagemTopo: TPanel
        Width = 721
        ExplicitWidth = 721
      end
      inherited grdListagem: TDBGrid
        Width = 721
        Height = 211
        Columns = <
          item
            Expanded = False
            FieldName = 'idusuario'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 618
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      Tag = 2
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 721
      ExplicitHeight = 276
      object edtIdusuario: TLabeledEdit
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
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Usu'#225'rio'
        MaxLength = 50
        TabOrder = 1
      end
      object edtSenha: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 136
        Width = 462
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 304
    Width = 729
    ExplicitTop = 304
    ExplicitWidth = 729
    inherited btnFechar: TBitBtn
      Left = 650
      ExplicitLeft = 650
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select'
      '  idusuario,'
      '  nome,'
      '  senha'
      'from tbusuarios')
    object QryListagemidusuario: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idusuario'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryListagemsenha: TWideStringField
      DisplayLabel = 'Senha'
      FieldName = 'senha'
      Required = True
      Size = 40
    end
  end
end
