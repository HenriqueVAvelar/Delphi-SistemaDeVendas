object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 328
  Width = 453
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    TransactIsolationLevel = tiReadCommitted
    SQLHourGlass = True
    HostName = '.\SQLEXPRESS'
    Port = 1433
    Database = 'vendas'
    User = ''
    Password = ''
    Protocol = 'mssql'
    LibraryLocation = 'C:\ProjetoDelphi\ntwdblib.dll'
    Left = 64
    Top = 24
  end
end
