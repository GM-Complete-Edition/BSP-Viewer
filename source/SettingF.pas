unit SettingF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSettingsForm = class(TForm)
    Label1: TLabel;
    SaveBSPOpt: TGroupBox;
    ComprOpt: TComboBox;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
    procedure WndProc(var Msg: TMessage);message WM_UPDATEUISTATE;
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

{ TSettingsForm }

procedure TSettingsForm.WndProc(var Msg: TMessage);
begin
 Button1.Refresh;
 Button2.Refresh;
end;

end.
