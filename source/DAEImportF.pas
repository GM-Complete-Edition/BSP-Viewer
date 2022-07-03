unit DAEImportF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDAEImportForm = class(TForm)
    AnimOpt: TGroupBox;
    ClipLabel: TLabel;
    ClipOpt: TComboBox;
    ClipName: TEdit;
    Button1: TButton;
    OutAnimDictionary: TComboBox;
    Label1: TLabel;
  private
    { Private declarations }
    procedure WndProc(var Msg: TMessage);message WM_UPDATEUISTATE;
  public
    { Public declarations }
  end;

var
  DAEImportForm: TDAEImportForm;

implementation

{$R *.dfm}

{ TDAEImportForm }

procedure TDAEImportForm.WndProc(var Msg: TMessage);
begin
 Button1.Refresh;
end;

end.
