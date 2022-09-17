inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  ClientHeight = 395
  ClientWidth = 732
  Position = poScreenCenter
  ExplicitWidth = 738
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 732
    Height = 344
    ExplicitHeight = 344
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 724
      ExplicitHeight = 316
      inherited pnlListagemTopo: TPanel
        Width = 724
        ExplicitWidth = 724
      end
      inherited grdListagem: TDBGrid
        Width = 724
        Height = 251
        Columns = <
          item
            Expanded = False
            FieldName = 'idcategoria'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 815
      ExplicitHeight = 316
      object edtIdcategoria: TLabeledEdit
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
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 88
        Width = 462
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 1
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 344
    Width = 732
    ExplicitTop = 344
    inherited btnFechar: TBitBtn
      Left = 653
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    Active = True
    SQL.Strings = (
      'select idcategoria, descricao from tbcategorias')
    object QryListagemidcategoria: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idcategoria'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
  end
end
