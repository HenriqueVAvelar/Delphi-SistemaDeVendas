inherited frmConCategoria: TfrmConCategoria
  Caption = 'Consulta de Categorias'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCima: TPanel
    inherited mskPesquisa: TMaskEdit
      ExplicitTop = 24
    end
  end
  inherited pnlBaixo: TPanel
    ExplicitLeft = 0
    ExplicitTop = 342
    ExplicitWidth = 723
  end
  inherited pnlCentro: TPanel
    ExplicitLeft = 0
    ExplicitTop = 49
    ExplicitWidth = 723
    ExplicitHeight = 293
    inherited grdPesquisa: TDBGrid
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
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select idcategoria,'
      '  descricao'
      'from tbcategorias')
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
