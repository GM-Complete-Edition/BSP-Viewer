unit Editors;

// Utility unit for the advanced Virtual Treeview demo application which contains the implementation of edit link
// interfaces used in other samples of the demo.

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VirtualTrees, ExtDlgs, ImgList, Buttons, ExtCtrls, ComCtrls,
  Mask,BSPLib,BSPCntrLib, PanelX,CheckLst;

type
  // Describes the type of value a property tree node stores in its data property.
  TValueType = (
    vtNone,
    vtString,
    vtPickString,
    vtNumber,
    vtPickNumber,
    vtMemo,
    vtDate
  );

//----------------------------------------------------------------------------------------------------------------------

  // Our own edit link to implement several different node editors.
  TPropertyEditLink = class(TInterfacedObject, IVTEditLink)
  private
    FEdit: TWinControl;        // One of the property editor classes.
    FEdit2: TWinControl;
    FEdit3: TWinControl;
    FEdit4: TWinControl;
    FNumEdit: Integer;
    FCheckList: Boolean;
    FRect: TRect;
    FTree: TVirtualStringTree; // A back reference to the tree calling.
    FNode: PVirtualNode;       // The node being edited.
    FColumn: Integer;          // The column of the node being edited.
  protected
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HexEditKeyPress(Sender: TObject; var Key: Char);
    procedure HexEditChange(Sender: TObject);
    procedure KeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    destructor Destroy; override;

    function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(R: TRect); stdcall;
  end;

//----------------------------------------------------------------------------------------------------------------------

type
  TPropertyTextKind = (
    ptkText,
    ptkHint
  );

//----------------------------------------------------------------------------------------------------------------------

implementation


//----------------- TPropertyEditLink ----------------------------------------------------------------------------------

// This implementation is used in VST3 to make a connection beween the tree
// and the actual edit window which might be a simple edit, a combobox
// or a memo etc.

destructor TPropertyEditLink.Destroy;

begin
  if FEdit is TEditX then
  FEdit.Free;// casues issue #357. Fix:
  if FNumEdit>1 then
    FEdit2.Free;
  if FNumEdit>2 then
    FEdit3.Free;
  if FNumEdit>3 then
    FEdit4.Free;
  if FEdit.HandleAllocated then
    PostMessage(FEdit.Handle, CM_RELEASE, 0, 0);
  inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TPropertyEditLink.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  CanAdvance: Boolean;
begin
  case Key of
    VK_RETURN:
      begin
        FTree.EndEditNode;
        FEdit.Free;
        Key := 0;
      end;
  end;
end;

procedure TPropertyEditLink.HexEditKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (Key in [#3,#27,#22,#127, '0'..'9', 'a'..'f', 'A'..'F']) then
      key := #0;  
end;

procedure TPropertyEditLink.KeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
  #27,#13:  Key:=#0;
  end;
end;

procedure TPropertyEditLink.EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      begin
        FTree.CancelEditNode;
        Key := 0;
      end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TPropertyEditLink.BeginEdit: Boolean;

begin
  Result := True;
  FEdit.Show;
  FEdit.SetFocus;
  if FNumEdit>1 then
    FEdit2.Show;
  if FNumEdit>2 then
    FEdit3.Show;
  if FNumEdit>3 then
    FEdit4.Show;
end;

//----------------------------------------------------------------------------------------------------------------------

function TPropertyEditLink.CancelEdit: Boolean;

begin
  Result := True;
  FEdit.Hide;
  if FNumEdit>1 then
    FEdit2.Hide;
  if FNumEdit>2 then
    FEdit3.Hide;
  if FNumEdit>3 then
    FEdit4.Hide;
end;

//----------------------------------------------------------------------------------------------------------------------
const
ConvertHex: array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);
function HexToByte (S:Pchar):Byte;   
begin
   result := Byte((ConvertHex[S[0]] shl 4) + ConvertHex[S[1]]);
end;

procedure TPropertyEditLink.HexEditChange(Sender: TObject);
var
 i: Integer;
 s: String;
 pz: Integer;
begin
s := TEdit(sender).Text;
 pz:= TMaskEdit(sender).SelStart;
 for i := Length(s) downto 1 do
 begin
   if i=9 then begin  s[i]:=' '; continue; end;
   if not (s[i] in ['0'..'9','A'..'F']) then s[i]:='0';
 end;
 TEdit(sender).Text := s;
 TMaskEdit(sender).SelStart := pz;
end;

function TPropertyEditLink.EndEdit: Boolean;
var
  Data: PPropertyData;
  bytes: array[0..15]of byte;
  i:Integer;
  b:Integer;
  s:string;
  pp:Pchar;
  fp,bp:Cardinal;
  fwInt: Word;
  fsInt: SmallInt; fByte: Byte;
  fInt: integer; fFloat:Single;
  fFlags: Cardinal;
  fFlags64: UInt64;
  function SetFloat(Edit:TWinControl;Offset:Integer):Integer;
  begin
    Result:=0;
    fFloat:=TEditX(Edit).GetFloatVal;
    fp:=Cardinal(Data.PValue);
    if fFloat <> Single(Pointer(fp+Offset)^) then begin
        Single(Pointer(fp+Offset)^) :=fFloat;
        Result:=1;
    end;
  end;
  function SetInteger(Edit:TWinControl;Offset:Integer):Integer;
  begin
    Result:=0;
    fInt:=Round(TEditX(Edit).GetFloatVal);
    fp:=Cardinal(Data.PValue);
    if fInt <> Integer(Pointer(fp+Offset)^) then begin
        Integer(Pointer(fp+Offset)^) :=fInt;
        Result:=1;
    end;
  end;
  function SetWord(Edit:TWinControl;Offset:Integer):Integer;
  begin
    Result:=0;
    fwInt:=Round(TEditX(Edit).GetFloatVal);
    fp:=Cardinal(Data.PValue);
    if fwInt <> Word(Pointer(fp+Offset)^) then begin
        Word(Pointer(fp+Offset)^) :=fwInt;
        Result:=1;
    end;
  end;
  function SetWordQ(Edit:TWinControl;Offset:Integer):Integer;
  begin
    Result:=0;
    fsInt:=Round(TEditX(Edit).GetFloatVal / 0.000030518509 );
    fp:=Cardinal(Data.PValue);
    if fsInt <> SmallInt(Pointer(fp+Offset)^) then begin
        SmallInt(Pointer(fp+Offset)^) :=fsInt;
        Result:=1;
    end;
  end;
  function SetByte(Edit:TWinControl;Offset:Integer):Integer;
  begin
    Result:=0;
    fByte:=Round(TEditX(Edit).GetFloatVal);
    bp:=Cardinal(Data.PValue);
    if fByte <> Byte(Pointer(bp+Offset)^) then begin
        Byte(Pointer(bp+Offset)^) :=fByte;
        Result:=1;
    end;
  end;

  function GetCheckFlags(Edit:TWinControl):Cardinal;
  var
    i,n:integer;
    CheckList:TCheckListBox;
  begin
     Result:=0;
     CheckList:=TCheckListBox(Edit);
     n:=CheckList.Count-1;
     for i:=1 to n do
        if CheckList.Checked[i] then Result:=Result or ($1 shl i);
  end;

  function GetCheckCustomFlags(Edit:TWinControl; EnumFlags: array of Integer):Cardinal;
  var
    i,n:integer;
    CheckList:TCheckListBox;
  begin
     Result:=0;
     CheckList:=TCheckListBox(Edit);
     n:=CheckList.Count-1;
     for i:=0 to n do
        if CheckList.Checked[i] then Result:= Result or EnumFlags[i];
  end;
  
  function GetCheckFlags64(Edit:TWinControl):UInt64;
  var
  i,n:integer;
  Low,High: Cardinal;
  ii: UInt64;
  CheckList:TCheckListBox;
  begin
     Low:= 0;
     High:= 0;
     CheckList:=TCheckListBox(Edit);
     n:=CheckList.Count-1;
     for i:=0 to 30 do
     begin
      if CheckList.Checked[i] then
        begin
           Low:=Low or ($1 shl i);
        end;
      if CheckList.Checked[i+31] then
        begin
           High:=High or ($1 shl i);
        end;
     end;
     Int64Rec(Result).Lo:= Low;
     Int64Rec(Result).Hi:= High;
  end;

begin
  Result := True;

  Data := FTree.GetNodeData(FNode);

  case Data.DBType of
    BSPString:
      begin
        s:=TEdit(FEdit).Text;

        if S <> Data.DValue then
        begin
          Data.DValue := S;
          if length(Pchar(Data.PValue^))>0 then
            StrDispose(Pchar(Data.PValue^));
          PChar(Data.PValue^) :=StrNew(PChar(s));
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPUInt64:
      begin
        s:=TEdit(FEdit).Text;
        if S <> Data.DValue then
        begin
          Data.DValue := S;
          b:=7;
          for i:=0 to 3 do begin
            bytes[i]:=HexToByte(@s[b]);
            Dec(b,2);
          end;
          b:=16;
          for i:=4 to 7 do begin
            bytes[i]:=HexToByte(@s[b]);
            Dec(b,2);
          end;
          Move(bytes[0],Data.PValue^,8);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPWord:
      begin
        s:=TEdit(FEdit).Text;
        if S <> Data.DValue then
        begin
          Data.DValue := S;
          b:=3;
          for i:=0 to 1 do begin
            bytes[i]:=HexToByte(@s[b]);
            Dec(b,2);
          end;
          Move(bytes[0],Data.PValue^,2);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPDword,BSPRefHash,BSPHash:
      begin
        s:=TEdit(FEdit).Text;
        if S <> Data.DValue then
        begin
          Data.DValue := S;
          b:=7;
          for i:=0 to 3 do begin
            bytes[i]:=HexToByte(@s[b]);
            Dec(b,2);
          end;
          Move(bytes[0],Data.PValue^,4);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPInt,BSPUint:
      begin
        fInt:=Round(TEditX(FEdit).GetFloatVal);
        if fInt <> Integer(Data.PValue^) then
        begin
          Data.DValue := IntToStr(fInt);
          Integer(Data.PValue^) :=fInt;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPSint:
      begin
        fsInt:=Round(TEditX(FEdit).GetFloatVal);
        if fsInt <> SmallInt(Data.PValue^) then
        begin
          Data.DValue := IntToStr(fsInt);
          SmallInt(Data.PValue^) :=fsInt;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPSUint16:
      begin
        fsInt:=Round(TEditX(FEdit).GetFloatVal);
        if fsInt <> Word(Data.PValue^) then
        begin
          Data.DValue := IntToStr(fsInt);
          Word(Data.PValue^) :=fsInt;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPByte:
      begin
        fByte:=Round(TEditX(FEdit).GetFloatVal);
        if fByte <> Byte(Data.PValue^) then
        begin
          Data.DValue := IntToStr(fByte);
          Byte(Data.PValue^) :=fByte;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPFloat:
      begin
        fFloat:=TEditX(FEdit).GetFloatVal;
        if fFloat <> Single(Data.PValue^) then
        begin
          Data.DValue := Format('%.2f',[fFloat]);
          Single(Data.PValue^) :=fFloat;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPUVWord:
      begin
        fsInt:=Round(TEditX(FEdit).GetFloatVal*256);
        if fsInt <> Word(Data.PValue^) then
        begin
          Data.DValue := Format('%.2f',[fsInt/256]);
          Word(Data.PValue^) :=fsInt;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPUVCoord:
      begin
        if (SetFloat(FEdit,0) + SetFloat(FEdit2,4)) > 0 then
        begin
          fp:=Cardinal(Data.PValue);
          Data.DValue := Format('<u:%.2f v:%.2f>',
                [Single(Pointer(fp)^), Single(Pointer(fp + 4)^)]);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPVect:
      begin
        if (SetFloat(FEdit,0) + SetFloat(FEdit2,4) + SetFloat(FEdit3,8)) > 0 then
        begin
          fp:=Cardinal(Data.PValue);
          Data.DValue := Format('<x:%.2f y:%.2f z:%.2f>',
                [Single(Pointer(fp)^), Single(Pointer(fp + 4)^), Single(Pointer(fp + 8)^)]);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPVect4:
      begin
        if (SetFloat(FEdit,0) + SetFloat(FEdit2,4) + SetFloat(FEdit3,8) + SetFloat(FEdit4,12)) > 0 then
        begin
          fp:=Cardinal(Data.PValue);
          Data.DValue := Format('[%.2f %.2f %.2f %.2f]',
                [Single(Pointer(fp)^), Single(Pointer(fp + 4)^), Single(Pointer(fp + 8)^), Single(Pointer(fp + 12)^)]);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPRVect:
      begin
        if (SetWordQ(FEdit,0) + SetWordQ(FEdit2,2) + SetWordQ(FEdit3,4) + SetWordQ(FEdit4,6)) > 0 then
        begin
          fp:=Cardinal(Data.PValue);
          Data.DValue := Format('<x:%.2f y:%.2f z:%.2f w:%.2f>',
                [SmallInt(Pointer(fp)^) * 0.000030518509, SmallInt(Pointer(fp + 2)^)* 0.000030518509,
                 SmallInt(Pointer(fp + 4)^)* 0.000030518509, SmallInt(Pointer(fp + 6)^)* 0.000030518509]);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPFace:
      begin
        if (SetWord(FEdit,0) + SetWord(FEdit2,2) + SetWord(FEdit3,4) ) > 0 then
        begin
          bp:=Cardinal(Data.PValue);
          Data.DValue := Format('[%d %d %d]',
                [Word(Pointer(bp)^), Word(Pointer(bp + 2)^),
                Word(Pointer(bp + 4)^)]);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPBox:
      begin
        if (SetInteger(FEdit,0) + SetInteger(FEdit2,4) + SetInteger(FEdit3,8) + SetInteger(FEdit4,12)) > 0 then
        begin
          bp:=Cardinal(Data.PValue);
          Data.DValue := Format('[%d %d %d %d]',
                [Integer(Pointer(bp)^), Integer(Pointer(bp + 4)^),
                Integer(Pointer(bp + 8)^), Integer(Pointer(bp + 12)^)]);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPMatFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPEnumMatF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPEnumMatS, BSPEnumMatF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPMatrixFlag:
      begin
        fFlags:=GetCheckFlags(FEdit);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetEnumStr(fFlags,BSPMatrixFlagS)+format(' [%d]',[fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPMeshFlags:
      begin
        fFlags:=GetCheckFlags(FEdit);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetEnumStr(fFlags, BSPMeshFlagsS) + format(' [%s%x]',['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPNullNodeFlags:
      begin
        fFlags:=GetCheckFlags(FEdit);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetEnumStr(fFlags, BSPNullNodeFlagsS) + format(' [%s%x]',['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPClumpFlag:
      begin
        fFlags64:=GetCheckFlags64(FEdit);
        if fFlags64 <> Uint64(Data.PValue^) then
        begin
          Uint64(Data.PValue^):= fFlags64;
          Data.DValue := SetEnumStr64(Dword(Data.PValue),BSPClumpFlagS ) + format(' [%s%x]', ['0x',fFlags64]);
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPTextureFormat:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPTextureFormatF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPTextureFormatS, BSPTextureFormatF, 'DEFAULT') + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPResourceAccessData:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPResourceAccessDataF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPResourceAccessDataS, BSPResourceAccessDataF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPReadFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPReadFlagsF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPReadFlagsS, BSPReadFlagsF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPHintFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPHintFlagsF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPHintFlagsS, BSPHintFlagsF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPConstantFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPConstantFlagsF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPConstantFlagsS, BSPConstantFlagsF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPMatBlockFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPMatBlockFlagsF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPMatBlockFlagsS, BSPMatBlockFlagsF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPRenderFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPRenderFlagsF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPRenderFlagsS, BSPRenderFlagsF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPFloorFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPFloorFlagsF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPFloorFlagsS, BSPFloorFlagsF, 'DEFAULT') + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPWorldFlags:
      begin
        fFlags:=GetCheckCustomFlags(FEdit, BSPWorldFlagsF);
        if fFlags <> Cardinal(Data.PValue^) then
        begin
          Data.DValue := SetCustomFlagEnumStr(fFlags, BSPWorldFlagsS, BSPWorldFlagsF) + format(' [%s%x]', ['0x',fFlags]);
          Cardinal(Data.PValue^):=fFlags;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPGLParam,BSPGLBool,BSPGLRepeat,BSPGLMigMag,BSPGLFactor,BSPGLShade,
    BSPWpTypes,BSPEntTypes,BSPKeyType,BSPNullBoxType, BSPEnvMapType, BSPSpawnType:
      begin
        fInt:=TComboBox(FEdit).ItemIndex;
        if fInt <> Integer(Data.PValue^) then
        begin
          Data.DValue := TComboBox(FEdit).Text;
          Integer(Data.PValue^) :=fInt;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
    BSPBool:
      begin
        fInt:=TComboBox(FEdit).ItemIndex;
        if Boolean(fInt) <> Boolean(Data.PValue^) then
        begin
          Data.DValue := TComboBox(FEdit).Text;
          Integer(Data.PValue^) :=fInt;
          Data.Changed := True;
          FTree.InvalidateNode(FNode);
        end;
      end;
  end;

  FEdit.Hide;
  if FNumEdit>1 then
    FEdit2.Hide;
  if FNumEdit>2 then
    FEdit3.Hide;
  if FNumEdit>3 then
    FEdit4.Hide;
//  FEdit.Destroy;
  FTree.SetFocus;
end;

//----------------------------------------------------------------------------------------------------------------------

function TPropertyEditLink.GetBounds: TRect;
begin
  Result := FRect;
end;

//----------------------------------------------------------------------------------------------------------------------

function TPropertyEditLink.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;

var
  Data: PPropertyData;

  function MakeCombobox(ss: array of String):TComboBox;
  var
    i: integer;
  begin
      Result := TComboBox.Create(nil);
      with Result as TComboBox do
      begin
        Visible := False;
        Parent := Tree;
        for i:=Low(ss) to High(ss) do   Items.Add(ss[I]);
       // SendMessage(GetWindow(Handle,GW_CHILD), EM_SETREADONLY, 1, 0);
        TComboBox(Result).Style:=csDropDownList;
        OnKeyUp := EditKeyUp;
        OnKeyDown:=EditKeyDown;
      end;
  end;


  function MakeCheckbox(ss: array of String;Enum:Cardinal):TCheckListBox;
  var
    i: integer;
  begin
      Result := TCheckListBox.Create(nil);
      with Result as TCheckListBox do
      begin
        Visible := False;
        Parent := Tree;
        for i:= Low(ss) to High(ss) do begin
          Items.Add(ss[i]);
          Checked[i]:=((($1 shl i) and Enum)>0);
        end;
      //  SendMessage(GetWindow(Handle,GW_CHILD), EM_SETREADONLY, 1, 0);
        OnKeyUp := EditKeyUp;
        OnKeyDown:=EditKeyDown;
      end;
  end;

  function MakeCustomCheckbox(ss: array of String; fv: array of Integer; Enum:Cardinal):TCheckListBox;
  var
    i: integer;
  begin
      Result := TCheckListBox.Create(nil);
      with Result as TCheckListBox do
      begin
        Visible := False;
        Parent := Tree;
        for i:=Low(ss) to High(ss) do begin
          Items.Add(ss[I]);
          //if i=0 then ItemEnabled[i]:=false;
         { if (Enum = 0) and (fv[i] = 0) then
          begin
            Checked[i]:= true;
          end
          else}
          begin
          if (Enum - fv[i] >= 0) then
            Checked[i]:=((Enum and fv[i]) > 0);
          end;
        end;
      //  SendMessage(GetWindow(Handle,GW_CHILD), EM_SETREADONLY, 1, 0);
        OnKeyUp := EditKeyUp;
        OnKeyDown:=EditKeyDown;
      end;
  end;


  function MakeCheckbox64(ss: array of String;Enum:pointer):TCheckListBox;
  var
    i: integer;
    low,high: Cardinal;
  begin
      Result := TCheckListBox.Create(nil);
      with Result as TCheckListBox do
      begin
        Visible := False;
        Parent := Tree;
        low:= Cardinal(Pointer(LongWord(Enum))^);
        high:= Cardinal(Pointer(LongWord(Enum)+4)^);
        for i:=0 to 30 do begin
          Items.Add(ss[i]);
          //if i=0 then ItemEnabled[i]:=false;
          Checked[i]:=((($1 shl i) and low)>0);
        end;
        for i:=0 to 30 do begin
          Items.Add(ss[i+31]);
          Checked[i+31]:=((($1 shl i) and high)>0);
        end;
      //  SendMessage(GetWindow(Handle,GW_CHILD), EM_SETREADONLY, 1, 0);
        OnKeyUp := EditKeyUp;
        OnKeyDown:=EditKeyDown;
      end;
  end;
  function NewEditX(P:Pointer;Offset:Integer=0):TEditX;
  begin
    Result:=TEditX.Create(nil);
     with Result as TEditX do
    begin
      Visible := False;
      Precision:=6;
      FloatDiv:=0.01;
      FloatVal:=Single(Pointer(LongWord(P)+Offset)^);
      Parent := Tree;
      OnKeyUp := EditKeyUp;
    end;
  end;
  function NewEditXW(P:Pointer;Offset:Integer=0):TEditX;
  begin
    Result:=TEditX.Create(nil);
     with Result as TEditX do
    begin
      Visible := False;
      Precision:=6;
      FloatDiv:=0.01;
      MinValue := Low(SmallInt) * 0.000030518509;
      MaxValue := High(SmallInt) * 0.000030518509;
      FloatVal := SmallInt(Pointer(LongWord(P)+Offset)^) * 0.000030518509;
      Parent := Tree;
      OnKeyUp := EditKeyUp;
    end;
  end;
  function NewEditXB(P:Pointer;Offset:Integer=0):TEditX;
  begin
    Result:=TEditX.Create(nil);
     with Result as TEditX do
    begin
      Visible := False;
      Precision:=0;
      FloatDiv:=1;
      MaxValue:=255;
      MinValue:=0;
      FloatVal:=Byte(Pointer(LongWord(P)+Offset)^);
      Parent := Tree;
      OnKeyUp := EditKeyUp;
    end;
  end;
  function NewEditFW(P:Pointer;Offset:Integer=0):TEditX;
  begin
    Result:=TEditX.Create(nil);
     with Result as TEditX do
    begin
      Visible := False;
      Precision:=0;
      FloatDiv:=1;
      MaxValue:=High(Word);
      MinValue:=0;
      FloatVal:=Word(Pointer(LongWord(P)+Offset)^);
      Parent := Tree;
      OnKeyUp := EditKeyUp;
    end;
  end;
  function NewEditXI(P:Pointer;Offset:Integer=0):TEditX;
  begin
    Result:=TEditX.Create(nil);
     with Result as TEditX do
    begin
      Visible := False;
      Precision:=0;
      FloatDiv:=1;
      MaxValue:=High(Integer);
      MinValue:=Low(Integer);
      FloatVal:=Integer(Pointer(LongWord(P)+Offset)^);
      Parent := Tree;
      OnKeyUp := EditKeyUp;
    end;
  end;
begin
  Result := True;
  FTree := Tree as TVirtualStringTree;
  FNode := Node;
  FColumn := Column;
  FNumEdit := 0;
  FCheckList:= False;
  // determine what edit type actually is needed
 // FEdit.Free;
  FEdit := nil;
  Data := FTree.GetNodeData(Node);
  case Data.DBType of
    BSPString:
      begin
        FEdit := TEdit.Create(nil);
        with FEdit as TEdit do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data.DValue;
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
          OnKeyPress:= KeyPress;
        end;
      end;
   BSPInt,BSPUint:
      begin
        FNumEdit := 1;
        FEdit := NewEditXI(Data.PValue);
      end;
   BSPSInt:
      begin
        FNumEdit := 1;
        FEdit := TEditX.Create(nil);
        with FEdit as TEditX do
        begin
          Visible := False;
          Precision:=0;
          FloatDiv:=1;
          MinValue:=Low(SmallInt);
          MaxValue:=High(SmallInt);
          FloatVal:=SmallInt(Data.PValue^);
          Parent := Tree;
          OnKeyUp := EditKeyUp;
        end;
      end;
   BSPSUint16:
      begin
        FNumEdit := 1;
        FEdit := TEditX.Create(nil);
        with FEdit as TEditX do
        begin
          Visible := False;
          Precision:=0;
          FloatDiv:=1;
          MinValue:=Low(Word);
          MaxValue:=High(Word);
          FloatVal:=Word(Data.PValue^);
          Parent := Tree;
          OnKeyUp := EditKeyUp;
        end;
      end;
   BSPByte:
      begin
        FNumEdit := 1;
        FEdit := NewEditXB(Data.PValue);
      end;
   BSPFloat:
      begin
        FNumEdit := 1;
        FEdit := NewEditX(Data.PValue);
      end;
   BSPGLParam:
      begin
        FEdit := MakeCombobox(BSPGLParamS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPGLBool:
      begin
        FEdit := MakeCombobox(BSPGLBoolS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPGLRepeat:
      begin
        FEdit := MakeCombobox(BSPGLRepeatS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPGLMigMag:
      begin
        FEdit := MakeCombobox(BSPGLMigMagS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPNullBoxType:
      begin
        FEdit := MakeCombobox(BSPNullBoxTypeS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPGLFactor:
      begin
        FEdit := MakeCombobox(BSPGLFactorS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPGLShade:
      begin
        FEdit := MakeCombobox(BSPGLShadeS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPEnvMapType:
      begin
        FEdit := MakeCombobox(BSPEnvMapTypeS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPKeyType:
      begin
        FEdit := MakeCombobox(BSPEnumKeyTypeS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPWpTypes:
      begin
        FEdit := MakeCombobox(BSPWpTypesS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPSpawnType:
      begin
        FEdit := MakeCombobox(BSPSpawnTypeS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPEntTypes:
      begin
        FEdit := MakeCombobox(BSPEntTypesS);
        TComboBox(FEdit).ItemIndex:= Integer(Data.PValue^);
      end;
   BSPBool:
      begin
        FEdit := MakeCombobox(BSPBoolS);
        if Boolean(Data.PValue^) then
         TComboBox(FEdit).ItemIndex:= 1 else
        TComboBox(FEdit).ItemIndex:= 0;
      end;
   BSPMatFlags:
      begin
        FCheckList := true;
        FEdit := MakeCustomCheckbox(BSPEnumMatS,BSPEnumMatF, Cardinal(Data.PValue^));
      end;
   BSPClumpFlag:
   begin
      FCheckList := true;
      FEdit := MakeCheckbox64(BSPClumpFlagS,Data.PValue);
     end;
   BSPMatrixFlag:
     begin
      FCheckList := true;
      FEdit := MakeCheckbox(BSPMatrixFlagS,Cardinal(Data.PValue^));
     end;
   BSPMeshFlags:
    begin
      FCheckList := true;
      FEdit := MakeCheckbox(BSPMeshFlagsS, Cardinal(Data.PValue^));
     end;
   BSPNullNodeFlags:
    begin
      FCheckList := true;
      FEdit := MakeCheckbox(BSPNullNodeFlagsS, Cardinal(Data.PValue^));
     end;
   BSPTextureFormat:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPTextureFormatS,BSPTextureFormatF, Cardinal(Data.PValue^));
     end;
   BSPResourceAccessData:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPResourceAccessDataS,BSPResourceAccessDataF, Cardinal(Data.PValue^));
     end;
   BSPReadFlags:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPReadFlagsS,BSPReadFlagsF, Cardinal(Data.PValue^));
     end;
   BSPHintFlags:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPHintFlagsS,BSPHintFlagsF, Cardinal(Data.PValue^));
     end;
   BSPConstantFlags:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPConstantFlagsS,BSPConstantFlagsF, Cardinal(Data.PValue^));
     end;
   BSPMatBlockFlags:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPMatBlockFlagsS,BSPMatBlockFlagsF, Cardinal(Data.PValue^));
     end;
   BSPRenderFlags:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPRenderFlagsS,BSPRenderFlagsF, Cardinal(Data.PValue^));
     end;
   BSPFloorFlags:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPFloorFlagsS, BSPFloorFlagsF, Cardinal(Data.PValue^));
     end;
   BSPWorldFlags:
     begin
      FCheckList := true;
      FEdit := MakeCustomCheckbox(BSPWorldFlagsS,BSPWorldFlagsF, Cardinal(Data.PValue^));
     end;
   BSPUVCoord:
      begin
        FNumEdit:=2;
        FEdit := NewEditX(Data.PValue,0);
        FEdit2 := NewEditX(Data.PValue,4);
      end;
   BSPFace:
      begin
        FNumEdit:=3;
        FEdit := NewEditFW(Data.PValue,0);
        FEdit2 := NewEditFW(Data.PValue,2);
        FEdit3 := NewEditFW(Data.PValue,4);
      end;
   BSPVect:
      begin
        FNumEdit:=3;
        FEdit := NewEditX(Data.PValue,0);
        FEdit2 := NewEditX(Data.PValue,4);
        FEdit3 := NewEditX(Data.PValue,8);
      end;
   BSPRVect:
      begin
        FNumEdit:=4;
        FEdit := NewEditXW(Data.PValue,0);
        FEdit2 := NewEditXW(Data.PValue,2);
        FEdit3 := NewEditXW(Data.PValue,4);
        FEdit4 := NewEditXW(Data.PValue,6);
      end;
   BSPVect4:
      begin
        FNumEdit:=4;
        FEdit := NewEditX(Data.PValue,0);
        FEdit2 := NewEditX(Data.PValue,4);
        FEdit3 := NewEditX(Data.PValue,8);
        FEdit4 := NewEditX(Data.PValue,12);
      end;
   BSPBox:
      begin
        FNumEdit:=4;
        FEdit := NewEditXI(Data.PValue,0);
        FEdit2 := NewEditXI(Data.PValue,4);
        FEdit3 := NewEditXI(Data.PValue,8);
        FEdit4 := NewEditXI(Data.PValue,12);
      end;
   BSPWord:
      begin
        FEdit := TMaskEdit.Create(nil);
        with FEdit as TMaskEdit do
        begin
          Visible := False;
          Parent := Tree;
          EditMask := '>aaaa<;1;0';
          Text := Data.DValue;
          OnKeyPress:= HexEditKeyPress;
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
          OnChange:= HexEditChange;
        end;
      end;
   BSPDword,BSPHash,BSPRefHash:
      begin
        FEdit := TMaskEdit.Create(nil);
        with FEdit as TMaskEdit do
        begin
          Visible := False;
          Parent := Tree;
          EditMask := '>aaaaaaaa<;1;0';
          Text := Data.DValue;
          OnKeyPress:= HexEditKeyPress;
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
          OnChange:= HexEditChange;
        end;
      end;
     BSPUInt64:
       begin
        FEdit := TMaskEdit.Create(nil);
        with FEdit as TMaskEdit do
        begin
          Visible := False;
          Parent := Tree;
          EditMask := '>aaaaaaaa aaaaaaaa<;1;0';
          Text := Data.DValue;
          OnKeyPress:= HexEditKeyPress;
          OnKeyDown := EditKeyDown;
          OnKeyUp := EditKeyUp;
          OnChange:= HexEditChange;
        end;
      end;
    BSPUVWord:
      begin
        FNumEdit := 1;
        FEdit := TEditX.Create(nil);
        with FEdit as TEditX do
        begin
          Visible := False;
          Precision:=3;
          FloatDiv:=0.01;
          MinValue:=0;
          MaxValue:=1;
          FloatVal:=Word(Data.PValue^)/256;
          OnKeyUp := EditKeyUp;
          Parent := Tree;
        end;
      end;
{    BSPStruct,
     BSPArray,
     BSPMesh,
     BSPChunk,
     BSPMeshFlags,
     BSPKeyType
}

  else
    Result := False;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TPropertyEditLink.ProcessMessage(var Message: TMessage);

begin
//  if Message.Msg
  FEdit.WindowProc(Message);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TPropertyEditLink.SetBounds(R: TRect);

var
  Dummy: Integer;
  RTemp: TRect;
begin
  FRect:=R;
  FTree.Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
  if FCheckList then begin R.Bottom:=R.Bottom+42 end;
  case FNumEdit of
    0: begin
    FEdit.BoundsRect := R;
    end;
    1: begin
    R.Right:=R.Right;
    FEdit.BoundsRect := R;
    end;
    2: begin
    RTemp:= R;
    RTemp.Right:=R.Left + ((R.Right-R.Left) div 2);
    FEdit.BoundsRect := RTemp;
    RTemp.Left:=R.Left + ((R.Right-R.Left) div 2);
    RTemp.Right:=R.Right;
    FEdit2.BoundsRect := RTemp;
    end;
    3: begin
    RTemp:= R;
    RTemp.Right:=R.Left + ((R.Right-R.Left) div 3)*1;
    FEdit.BoundsRect := RTemp;
    RTemp.Left:=R.Left + ((R.Right-R.Left) div 3)*1;
    RTemp.Right:=R.Left + ((R.Right-R.Left) div 3)*2;
    FEdit2.BoundsRect := RTemp;
    RTemp.Left:=R.Left + ((R.Right-R.Left) div 3)*2;
    RTemp.Right:=R.Right;
    FEdit3.BoundsRect := RTemp;
    end;
    4: begin
    RTemp:= R;
    RTemp.Right:=R.Left + ((R.Right-R.Left) div 4)*1;
    FEdit.BoundsRect := RTemp;
    RTemp.Left:=R.Left + ((R.Right-R.Left) div 4)*1;
    RTemp.Right:=R.Left + ((R.Right-R.Left) div 4)*2;
    FEdit2.BoundsRect := RTemp;
    RTemp.Left:=R.Left + ((R.Right-R.Left) div 4)*2;
    RTemp.Right:=R.Left + ((R.Right-R.Left) div 4)*3;
    FEdit3.BoundsRect := RTemp;
    RTemp.Left:=R.Left + ((R.Right-R.Left) div 4)*3;
    RTemp.Right:=R.Right;
    FEdit4.BoundsRect := RTemp;
    end;
  end;
end;

end.
