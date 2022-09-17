unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  RxToolEdit;

type
  TfrmSelecionarData = class(TForm)
    edtDataInicio: TDateEdit;
    Label4: TLabel;
    edtDataFinal: TDateEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

uses System.DateUtils;

{$R *.dfm}

procedure TfrmSelecionarData.BitBtn1Click(Sender: TObject);
begin
  if edtDataFinal.Date < edtDataInicio.Date then
  begin
    MessageDlg('Data final não pode ser maior que a da inicial', mtInformation, [mbok], 0);
    edtDataFinal.SetFocus;
    abort;
  end;
  if (edtDataFinal.Date = 0) or (edtDataInicio.Date = 0) then
  begin
    MessageDlg('Data inicial ou final é campo obrigatório', mtInformation, [mbok], 0);
    edtDataInicio.SetFocus;
    abort;
  end;
  Close;
end;

procedure TfrmSelecionarData.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  close;
end;

procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  edtDataInicio.Date := StartOfTheMonth(Date);
  edtDataFinal.Date := EndOfTheMonth(Date);
end;

end.
