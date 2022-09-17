inherited frmCadAcaoAcesso: TfrmCadAcaoAcesso
  Caption = 'Cadastro de A'#231#227'o de Acesso'
  ClientHeight = 446
  ClientWidth = 731
  Position = poScreenCenter
  ExplicitWidth = 737
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 731
    Height = 395
    ExplicitWidth = 731
    ExplicitHeight = 395
    inherited tabListagem: TTabSheet
      ExplicitWidth = 723
      ExplicitHeight = 367
      inherited pnlListagemTopo: TPanel
        Width = 723
        ExplicitWidth = 723
      end
      inherited grdListagem: TDBGrid
        Width = 723
        Height = 302
        Columns = <
          item
            Expanded = False
            FieldName = 'idacaoacesso'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 383
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'chave'
            Width = 239
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 88
        Width = 641
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 0
      end
      object edtIdAcaoAcesso: TLabeledEdit
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
        TabOrder = 1
      end
      object edtChave: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 142
        Width = 334
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Chave'
        MaxLength = 60
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 395
    Width = 731
    ExplicitTop = 395
    ExplicitWidth = 731
    inherited btnFechar: TBitBtn
      Left = 652
      ExplicitLeft = 652
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select idacaoacesso, descricao, chave from tbacaoacesso')
    object QryListagemidacaoacesso: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idacaoacesso'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object QryListagemchave: TWideStringField
      DisplayLabel = 'Chave'
      FieldName = 'chave'
      Required = True
      Size = 60
    end
  end
end
