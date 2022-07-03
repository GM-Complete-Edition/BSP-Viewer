unit AddEntities;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CheckComboBox;

type
  TAddEntities = class(TForm)
    Label1: TLabel;
    SelectChunkOpt: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    cbb1: TCheckComboBox;
  private
    { Private declarations }
    procedure WndProc(var Msg: TMessage);message WM_UPDATEUISTATE;
  public
    { Public declarations }
  end;

var
  AddEntitiesForm: TAddEntities;

implementation

{$R *.dfm}

{ TSettingsForm }

procedure TAddEntities.WndProc(var Msg: TMessage);
begin
 Button1.Refresh;
 Button2.Refresh;
end;

end.
