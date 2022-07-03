unit ChangeAnimSpeed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FloatSpinEdit;

type
  TAnimSpeed = class(TForm)
    Label1: TLabel;
    SelectChunkOpt: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    edt1: TFloatSpinEdit;
  private
    { Private declarations }
    procedure WndProc(var Msg: TMessage);message WM_UPDATEUISTATE;
  public
    { Public declarations }
  end;

var
  AnimSpeedForm: TAnimSpeed;

implementation

{$R *.dfm}

{ TSettingsForm }

procedure TAnimSpeed.WndProc(var Msg: TMessage);
begin
 Button1.Refresh;
 Button2.Refresh;
end;

end.
