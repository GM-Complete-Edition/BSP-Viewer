unit DAEExportF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FloatSpinEdit;

type
  TDAEExportForm = class(TForm)
    Button1: TButton;
    grpPresets: TGroupBox;
    CBExportOptions: TComboBox;
    lbl1: TLabel;
    grp1: TGroupBox;
    ExportClips: TCheckBox;
    CGopt: TCheckBox;
    lbl2: TLabel;
    CBAxis: TComboBox;
    lbl3: TLabel;
    edtScale: TFloatSpinEdit;
    ConvertDummies: TCheckBox;
    procedure CBExportOptionsChange(Sender: TObject);
  private
    { Private declarations }
    procedure WndProc(var Msg: TMessage);message WM_UPDATEUISTATE;
  public
    { Public declarations }
  end;

var
  DAEExportForm: TDAEExportForm;

implementation

{$R *.dfm}

{ TDAEExportForm }

procedure TDAEExportForm.WndProc(var Msg: TMessage);
begin
 Button1.Refresh;
end;

procedure TDAEExportForm.CBExportOptionsChange(Sender: TObject);
begin
 case CBExportOptions.ItemIndex of
   0:
   begin
     CBAxis.ItemIndex:= 1;
     edtScale.Value:= 0.0254;
     ConvertDummies.State:= cbUnchecked;
   end;
   1:
   begin
     CBAxis.ItemIndex:= 0;
     edtScale.Value:= 1.0;
     ConvertDummies.State:= cbChecked;
   end;
  end;
end;

end.
