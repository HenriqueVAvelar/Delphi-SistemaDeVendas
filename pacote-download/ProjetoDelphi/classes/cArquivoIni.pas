unit cArquivoIni;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
  System.SysUtils,
  System.IniFiles,
  Vcl.Forms;

Type
  TArquivoIni = class
  private

  public
    class function ArquivoIni: String; Static;
    class function LerIni(aSecao: String; aEntrada: String): String; Static;
    class procedure AtualizarIni(aSecao, aEntrada, aValor: String); Static;
  end;

implementation

{ TArquivoIni }

class function TArquivoIni.ArquivoIni: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

class procedure TArquivoIni.AtualizarIni(aSecao, aEntrada, aValor: String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    Ini.WriteString(aSecao, aEntrada, aValor);
  finally
    Ini.Free;
  end;
end;

class function TArquivoIni.LerIni(aSecao, aEntrada: String): String;
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    Result := Ini.ReadString(aSecao, aEntrada, 'NAO ENCONTRADO');
  finally
    Ini.Free;
  end;
end;

end.
