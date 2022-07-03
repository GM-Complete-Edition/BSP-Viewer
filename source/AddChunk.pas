unit AddChunk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAddChunk = class(TForm)
    Label1: TLabel;
    SelectChunkOpt: TGroupBox;
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
  AddChunkForm: TAddChunk;

implementation

{$R *.dfm}

{ TSettingsForm }

procedure TAddChunk.WndProc(var Msg: TMessage);
begin
 Button1.Refresh;
 Button2.Refresh;
end;

end.
