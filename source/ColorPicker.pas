unit ColorPicker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls, Math, Buttons,BSPCntrLib;

type
  PRGB = ^TRGB;
  TRGB = record b, g, r: Byte;
  end;
  PRGBA = ^TRGBA;
  TRGBA = record b, g, r, a: Byte;
  end;
  PRGBArray = ^TRGBArray;
  TRGBARRAY = array[0..0] of TRGB;
  THSB = record h, s, b: Word;
  end;
  TRGB24 = record R, G, B: Byte end;
  
  TColorPickerForm = class(TForm)
    ilMain: TImageList;
    editColor2: TEdit;
    editColor3: TEdit;
    editColor1: TEdit;
    editColor: TEdit;
    labHex: TLabel;
    Panel1: TPanel;
    imgColorBox: TImage;
    imgZBar: TImage;
    imgColor: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    imgAlpha: TImage;
    Button1: TButton;
    Label5: TLabel;
    editColor4: TEdit;
    procedure PaintColorPnl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgColorBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgColorBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgColorBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgColorBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgColorBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgColorBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgAlphaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgAlphaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgAlphaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure editColor1KeyPress(Sender: TObject; var Key: Char);
    procedure editColor1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editColor1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editColor4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure PaintAlphaBar;
    procedure PaintAlphaColor;
    { Private declarations }
  public
    { Public declarations }
    function GetColor: TUColor;
    procedure SetColor(Color: TRGB; Alpha: Byte); overload;
    procedure SetColor(Color: TUColor); overload;
    procedure PaintColorHue;
    procedure PaintHueBar;
  end;



var
  ColorPickerForm: TColorPickerForm;
  RGBColor: TRGB;
  RGBAlpha: Byte;

implementation

const
  AniStep = 4;

var
  HBoxBmp, HBarBmp, ABarBmp, ColorBmp: TBitmap;
  CB_X, CB_Y:integer;
  HSBColor: THSB;
  ColorMode, CellMul, CellDiv: Byte;
  DoColor, DoBar, DoVar, DoLive, DoAlpha: Boolean;
  CTab: array[0..255] of TRGB;
  WebSafeColorLut: array[0..255] of Byte;
  VarIdx: Integer;
  AniCount: Integer;
  BoxX, BoxY, BarX, BarA: Integer;
  LastHue: Integer;
  TextEnter: Boolean;

{$R *.dfm}

function Blend(Color1, Color2: TColor; A: Byte): TColor;
var
  c1, c2: LongInt;
  r, g, b, v1, v2: byte;
begin
  A:= Round(2.55 * A);
  c1 := ColorToRGB(Color1);
  c2 := ColorToRGB(Color2);
  v1:= Byte(c1);
  v2:= Byte(c2);
  r:= A * (v1 - v2) shr 8 + v2;
  v1:= Byte(c1 shr 8);
  v2:= Byte(c2 shr 8);
  g:= A * (v1 - v2) shr 8 + v2;
  v1:= Byte(c1 shr 16);
  v2:= Byte(c2 shr 16);
  b:= A * (v1 - v2) shr 8 + v2;
  Result := (b shl 16) + (g shl 8) + r;
end;

function Max3(const A, B, C: Integer): Integer;
asm
  CMP EDX,EAX
  CMOVG EAX,EDX
  CMP ECX,EAX
  CMOVG EAX,ECX
end;

function Min3(const A, B, C: Integer): Integer;
asm
  CMP EDX,EAX
  CMOVL EAX,EDX
  CMP ECX,EAX
  CMOVL EAX,ECX
end;

procedure MinMax(const i,j,k: Byte; var min: Integer; var max: Word); 
begin
  if i > j then begin
    if i > k then max := i else max := k;
    if j < k then min := j else min := k
  end else begin
    if j > k then max := j else max := k;
    if i < k then min := i else min := k
  end;
end;

procedure RGBtoHSB (const cRed, cGreen, cBlue: Byte; var H, S, B: Word);
var
  Delta, MinValue, tmpH: Integer;
begin
  tmpH:= 0;
  MinMax(cRed, cGreen, cBlue, MinValue, B);
  Delta := B - MinValue;
  if B = 0 then S := 0 else S := (255 * Delta) div B;
  if S = 0 then tmpH := 0
  else begin
    if cRed = B then tmpH := (60 * (cGreen - cBlue)) div Delta
      else
    if cGreen = B then tmpH := 120 + (60 * (cBlue - cRed)) div Delta
      else
    if cBlue = B then tmpH := 240 + (60 * (cRed - cGreen)) div Delta;
    if tmpH < 0 then tmpH := tmpH + 360;
  end;
  H := tmpH;
end;

procedure HSBtoRGB (const H, S, B: Word; var cRed, cGreen, cBlue : Byte);
const
  divisor:  Integer = 255*60;
var
  f    :  Integer;
  hTemp:  Integer;
  p,q,t:  Integer;
  VS   :  Integer;
begin
  if s = 0 then begin
    cRed:= B;
    cGreen:= B;
    cBlue:= B;
  end else begin
    if H = 360 then hTemp:= 0 else hTemp:= H;
    f:= hTemp mod 60;
    VS:= B*S;
    p:= B - VS div 255;
    q:= B - (VS*f) div divisor;
    t:= B - (VS*(60 - f)) div divisor;
    hTemp:= hTemp div 60;
    case hTemp of
      0:  begin  cRed := B;   cGreen := t;   cBlue := p  end;
      1:  begin  cRed := q;   cGreen := B;   cBlue := p  end;
      2:  begin  cRed := p;   cGreen := B;   cBlue := t  end;
      3:  begin  cRed := p;   cGreen := q;   cBlue := B  end;
      4:  begin  cRed := t;   cGreen := p;   cBlue := B  end;
      5:  begin  cRed := B;   cGreen := p;   cBlue := q  end;
    end;
  end;
end;

procedure RGBtoHSL(R, G, B: Integer; out H, S, L: Byte);
var
  D, Cmax, Cmin, HL: Integer;
begin
  Cmax := Max3(R, G, B);
  Cmin := Min3(R, G, B);
  L := (Cmax + Cmin) div 2;
  if Cmax = Cmin then begin
    H := 0;
    S := 0;
  end else begin
    D := (Cmax - Cmin) * 255;
    if L <= $7F then S := D div (Cmax + Cmin)
    else             S := D div (255 * 2 - Cmax - Cmin);
    D := D * 6;
    if R = Cmax then
      HL := (G - B) * 255 * 255 div D
    else if G = Cmax then
      HL := 255 * 2 div 6 + (B - R) * 255 * 255 div D
    else
      HL := 255 * 4 div 6 + (R - G) * 255 * 255 div D;
    if HL < 0 then HL := HL + 255 * 2;
    H := HL;
  end;
end;

procedure HSLtoRGB(H, S, L: Integer; var R, G, B: Byte);
var
  V, M, M1, M2, VSF: Integer;
begin
  if L <= $7F then V := L * (256 + S) shr 8
  else             V := L + S - L * S div 255;
  if V <= 0 then begin
    r:= 0; g:= 0; b:= 0;
  end else begin
    M := L * 2 - V;
    H := H * 6;
    VSF := (V - M) * (H and $ff) shr 8;
    M1 := M + VSF;
    M2 := V - VSF;
    case H shr 8 of
      0: begin R:= v; g:= m1; b:= m; end;
      1: begin R:= m2; g:= v; b:= m; end;
      2: begin R:= m; g:= v; b:= m1; end;
      3: begin R:= m; g:= m2; b:= v; end;
      4: begin R:= m1; g:= m; b:= v; end;
      5: begin R:= v; g:= m; b:= m2; end;
    end;
  end;
end;

function TColorPickerForm.GetColor: TUColor;
begin
  Result[0] := RGBColor.r;
  Result[1] := RGBColor.g;
  Result[2] := RGBColor.b;
  Result[3] := RGBAlpha;
end;

procedure SetRGBColor;
begin
  HSBtoRGB(MulDiv(360, BarX, CB_X), MulDiv(255, BoxX, CB_X),
   255 - MulDiv(255, BoxY, CB_Y),  RGBColor.r, RGBColor.g, RGBColor.b);
end;

procedure TColorPickerForm.SetColor(Color: TRGB; Alpha: Byte);
var
  c: Integer;
  h, s, b: Word;
begin
  RGBColor:= Color;
  RGBAlpha:= Alpha;
  RGBtoHSB(RGBColor.r, RGBColor.g, RGBColor.b, h, s, b);
  BoxX := MulDiv(CB_X, s, 255);
  BoxY := CB_Y - MulDiv(CB_Y, b, 255);
  BarX := MulDiv(CB_X, h, 360);
  BarA := MulDiv(CB_X, RGBAlpha, 255);
  LastHue := -1;
  PaintColorPnl;
end;

procedure TColorPickerForm.SetColor(Color: TUColor);
var
  TempColor: TRGB;
begin
  TempColor.r:=Color[0];
  TempColor.g:=Color[1];
  TempColor.b:=Color[2];
  SetColor(TempColor,Color[3]);
end;

procedure TColorPickerForm.PaintColorPnl;
begin
  PaintHueBar;
  PaintAlphaBar;
  PaintColorHue;

  PaintAlphaColor;
  imgColor.Canvas.Pen.Color := clBlack;
  imgColor.Canvas.Brush.Style := bsClear;

  if not TextEnter then
  begin
    editColor1.Text := IntToStr(RGBColor.r);
    editColor2.Text := IntToStr(RGBColor.g);
    editColor3.Text := IntToStr(RGBColor.b);
    editColor.Text := IntToStr(RGBAlpha);
    editColor4.Text := IntToHex(RGBColor.r,2) + IntToHex(RGBColor.g,2) + IntToHex(RGBColor.b,2) + IntToHex(RGBAlpha,2);
  end;
end;


procedure TColorPickerForm.editColor1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  idx, i: Integer;
begin
  TextEnter := True;
  if Key = 13 then
  begin
    idx := (Sender as TEdit).Tag;
    case idx of
      0:
        begin
          i := StrToIntDef(editColor1.Text, -1);
          if (i >= 0) and (i <= 255) then
            RGBColor.r := i;
        end;
      1:
        begin
          i := StrToIntDef(editColor2.Text, -1);
          if (i >= 0) and (i <= 255) then
            RGBColor.g := i;
        end;
      2:
        begin
          i := StrToIntDef(editColor3.Text, -1);
          if (i >= 0) and (i <= 255) then
            RGBColor.b := i;
        end;
      3:
        begin
          i := StrToIntDef(editColor.Text, -1);
          if (i >= 0) and (i <= 255) then
          begin
            RGBAlpha := i;
            BarA := MulDiv(CB_X, i, 255);
          end;
        end;
    end;
    SetColor(RGBColor, RGBAlpha);
  end;
end;

procedure TColorPickerForm.editColor1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #27) then
    Key := #0;
end;

procedure TColorPickerForm.editColor1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TextEnter := False;
end;

procedure TColorPickerForm.FormCreate(Sender: TObject);
const
  Colors: array[0..15] of TColor = (clBlack, clWhite, clGray, clSilver,
    clMaroon, clRed, clGreen, clLime, clOlive, clYellow, clNavy, clBlue,
    clPurple, clFuchsia, clTeal, clAqua);
var
  i, j: Integer;
begin
  HBoxBmp := TBitmap.Create;
  HBoxBmp.PixelFormat := pf24bit;
  HBoxBmp.Width := imgColorBox.Width;
  CB_X:=HBoxBmp.Width-1;
  HBoxBmp.Height := imgColorBox.Height;
  CB_Y:=HBoxBmp.Height-1;
  HBarBmp := TBitmap.Create;
  HBarBmp.PixelFormat := pf24bit;
  HBarBmp.Width := imgZBar.Width;
  HBarBmp.Height := 1;
  ABarBmp := TBitmap.Create;
  ABarBmp.PixelFormat := pf24bit;
  ABarBmp.Width := imgAlpha.Width;
  ABarBmp.Height := imgAlpha.Height;
  ColorBmp := TBitmap.Create;
  ColorBmp.PixelFormat := pf24bit;
  ColorBmp.Width := imgColor.Width;
  ColorBmp.Height := imgColor.Height;
  Randomize;
  RGBColor.r := Random(255);
  RGBColor.g := Random(255);
  RGBColor.b := Random(255);
  RGBAlpha := Random(255);
  SetColor(RGBColor, RGBAlpha);
  for i := 0 to 255 do
    WebSafeColorLut[I] := ((I + $19) div $33) * $33;
  DoColor := False;
  DoBar := False;
  DoVar := False;
  DoLive := False;
  VarIdx := -1;
  LastHue := -1;
  PaintColorPnl;
end;

procedure TColorPickerForm.FormDestroy(Sender: TObject);
begin
  ColorBmp.Free;
  ABarBmp.Free;
  HBarBmp.Free;
  HBoxBmp.Free;

end;

procedure TColorPickerForm.imgAlphaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DoAlpha := True;
  if x < 0 then
    x := 0;
  if x > imgAlpha.Width - 1 then
    x := imgAlpha.Width - 1;
  BarA := x;
  RGBAlpha := MulDiv(255, BarA, CB_X);
  PaintColorPnl;
end;

procedure TColorPickerForm.imgAlphaMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if not DoAlpha then
    Exit;
  if x < 0 then
    x := 0;
  if x > imgAlpha.Width - 1 then
    x := imgAlpha.Width - 1;
  BarA := x;
  RGBAlpha := MulDiv(255, BarA, CB_X);
  PaintColorPnl;
end;

procedure TColorPickerForm.imgAlphaMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DoAlpha := False;
end;

procedure TColorPickerForm.imgColorBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DoBar := True;
  if x < 0 then
    x := 0;
  if x > imgZBar.Width - 1 then
    x := imgZBar.Width - 1;
  BarX := x;
  SetRGBColor;
  PaintcolorPnl;
end;

procedure TColorPickerForm.imgColorBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not DoBar then
    Exit;
  if x < 0 then
    x := 0;
  if x > imgZBar.Width - 1 then
    x := imgZBar.Width - 1;
  BarX := x;
  SetRGBColor;
  PaintcolorPnl;
end;

procedure TColorPickerForm.imgColorBarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DoBar := False;
end;

procedure TColorPickerForm.imgColorBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DoColor := True;
  if x < 0 then
    x := 0;
  if x > imgColorBox.Width - 1 then
    x := imgColorBox.Width - 1;
  if y < 0 then
    y := 0;
  if y > imgColorBox.Height - 1 then
    y := imgColorBox.Height - 1;
  BoxX := x;
  BoxY := y;
  SetRGBColor;
  PaintcolorPnl;
end;

procedure TColorPickerForm.imgColorBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not DoColor then
    Exit;
  if x < 0 then
    x := 0;
  if x > imgColorBox.Width - 1 then
    x := imgColorBox.Width - 1;
  if y < 0 then
    y := 0;
  if y > imgColorBox.Height - 1 then
    y := imgColorBox.Height - 1;
  BoxX := x;
  BoxY := y;
  SetRGBColor;
  PaintColorPnl;
end;

procedure TColorPickerForm.imgColorBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DoColor := False;
end;

procedure TColorPickerForm.PaintColorHue;
var
  Row: PRGBArray;
  slMain, slSize, slPtr: Integer;
  x, y, w, h: Integer;
  m1, q1, q2, q3, s1, s2: Integer;
  r, g, b: Byte;
begin
  h := MulDiv(360, BarX, CB_X);
  if h <> LastHue then
  begin // Only update if needed
    LastHue := h;
    HSBtoRGB(h, 255, 255, r, g, b);
    h := HBoxBmp.Height - 1;
    w := HBoxBmp.Width - 1;
    slMain := Integer(HBoxBmp.ScanLine[0]);
    slSize := Integer(HBoxBmp.ScanLine[1]) - slMain;
    slPtr := slMain;
    for y := 0 to h do
    begin
      s1 := MulDiv(255, y, h);
      m1 := s1 * -255 shr 8 + 255;
      q1 := (s1 * -r shr 8 + r) - m1; // Red
      q2 := (s1 * -g shr 8 + g) - m1; // Green
      q3 := (s1 * -b shr 8 + b) - m1; // Blue
      for x := 0 to w do
      begin
        s2 := MulDiv(255, x, w);
        Row := PRGBArray(slPtr);
        Row[x].r := Byte(s2 * q1 shr 8 + m1);
        Row[x].g := Byte(s2 * q2 shr 8 + m1);
        Row[x].b := Byte(s2 * q3 shr 8 + m1);
      end;
      slPtr := slPtr + slSize;
    end;
  end;
  imgColorBox.Canvas.Draw(0, 0, HBoxBmp);
  ilMain.Draw(imgColorBox.Canvas, BoxX - 7, BoxY - 7, 0, True); // Paint Marker
end;

procedure TColorPickerForm.PaintHueBar;
var
  Row: PRGBArray;
  x: Integer;
begin
  Row := PRGBArray(HBarBmp.ScanLine[0]);
  for x := 0 to HBarBmp.Width - 1 do
    HSBToRGB(MulDiv(360, x, CB_X), 255, 255, Row[x].r, Row[x].g, Row[x].b);
  imgZBar.Canvas.StretchDraw(Rect(0, 0, HBarBmp.Width, imgZBar.Height), HBarBmp);
  ilMain.Draw(imgZBar.Canvas, BarX - 7, 1, 0, True); // Paint Marker
end;

procedure TColorPickerForm.PaintAlphaColor;
var
  Row: PRGBArray;
  RowOff: Integer;
  x, y, a: Integer;
  bool: Boolean;
  c1, c2: TRGB;
begin
  Row := PRGBArray(ColorBmp.ScanLine[0]);
  RowOff := Integer(ColorBmp.ScanLine[1]) - Integer(ColorBmp.ScanLine[0]);
  a := 255 - RGBAlpha;
  c1.R := a * (192 - RGBColor.r) shr 8 + RGBColor.r;
  c1.G := a * (192 - RGBColor.g) shr 8 + RGBColor.g;
  c1.B := a * (192 - RGBColor.b) shr 8 + RGBColor.b;
  c2.R := a * (255 - RGBColor.r) shr 8 + RGBColor.r;
  c2.G := a * (255 - RGBColor.g) shr 8 + RGBColor.g;
  c2.B := a * (255 - RGBColor.b) shr 8 + RGBColor.b;
  for y := 0 to ColorBmp.Height - 1 do
  begin
    bool := (y and 8 = 0);
    for x := 0 to ColorBmp.Width - 1 do
    begin
      if ((x + 1) mod 8 = 0) then
        bool := not bool;
      if bool then
        Row[x] := c1
      else
        Row[x] := c2;
    end;
    Row := PRGBArray(Integer(Row) + RowOff);
  end;
  imgColor.Canvas.Draw(0, 0, ColorBmp);
end;

procedure TColorPickerForm.PaintAlphaBar;
var
  Row: PRGBArray;
  RowOff: Integer;
  x, y, a: Integer;
  bool: Boolean;
  c1, c2: TRGB;
begin
  Row := PRGBArray(ABarBmp.ScanLine[0]);
  RowOff := Integer(ABarBmp.ScanLine[1]) - Integer(ABarBmp.ScanLine[0]);
  for y := 0 to ABarBmp.Height - 1 do
  begin
    bool := (y and 8 = 0);
    for x := 0 to ABarBmp.Width - 1 do
    begin
    a := 255 - MulDiv(255, x, CB_X);
      if ((x + 1) mod 8 = 0) then
        bool := not bool;
      if bool then begin
        c1.R := a * (192 - RGBColor.r) shr 8 + RGBColor.r;
        c1.G := a * (192 - RGBColor.g) shr 8 + RGBColor.g;
        c1.B := a * (192 - RGBColor.b) shr 8 + RGBColor.b;
        Row[x] := c1
      end
      else begin
        c2.R := a * (255 - RGBColor.r) shr 8 + RGBColor.r;
        c2.G := a * (255 - RGBColor.g) shr 8 + RGBColor.g;
        c2.B := a * (255 - RGBColor.b) shr 8 + RGBColor.b;
        Row[x] := c2;
      end;
    end;
    Row := PRGBArray(Integer(Row) + RowOff);
  end;
  imgAlpha.Canvas.Draw(0, 0, ABarBmp);
  ilMain.Draw(imgAlpha.Canvas, BarA - 7, 9 - 8, 0, True); // Paint Marker
end;

procedure TColorPickerForm.editColor4KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  idx, i,str_len: Integer;
begin
  TextEnter := True;
  if Key = 13 then
  begin
    str_len:= Length(editColor4.Text);
    case str_len of
      2: editColor4.Text:= editColor4.Text + 'FFFFFF';
      4: editColor4.Text:= editColor4.Text + 'FFFF';
      6: editColor4.Text:= editColor4.Text + 'FF';
    end;
    editColor4.Text:= AnsiUpperCase(editColor4.Text);
    i := StrToIntDef('$' + editColor4.Text, -1);
    RGBColor.r := (i shr 24) and $FF;
    RGBColor.g := (i shr 16) and $FF;
    RGBColor.b := (i shr 8) and $FF;
    RGBAlpha := i and $FF;
    BarA := MulDiv(CB_X, RGBAlpha, 255);
    editColor1.Text := IntToStr(RGBColor.r);
    editColor2.Text := IntToStr(RGBColor.g);
    editColor3.Text := IntToStr(RGBColor.b);
    editColor.Text := IntToStr(RGBAlpha);
    SetColor(RGBColor, RGBAlpha);
  end;
end;

end.

