unit BSPMeshLib;

interface

uses OpenGLx, IdGlobal, SysUtils, Classes, Windows, ComCtrls, Graphics,
        OpenGLLib, Math, Menus, BSPCntrLib,XMLIntf, XMLDoc,FMX.DAE.Schema,Dialogs;

{$DEFINE NOMULTI}
//{$DEFINE NOGLARRAY}

type

  TDrawType = (DrMesh, DrBlend, DrBone, DrGenAnim,DrSelect,DrBoxes);

  TMaterial = record
    Name: string;
    use: Boolean;
    Abi, Dif, Spe, Emi: Color4d;
    Shi: Single;
  end;

  TAttribute = record
    light: Color4d;
    Material: TMaterial;
    Texture: Integer;
    TextureId: Integer;
    TextureClamp:Boolean;
    Texture2D: Boolean;
    T2DMatrix:TMatrix;
    ZBufferFuncVal: Integer;
    CullFace: Boolean;
    ZBuffer: Boolean;
    Multi: Boolean;
    AlphaTest: Boolean;
    AlphaFunc: Integer;
    AlphaFuncVal: Single;
    Blend: Boolean;
    Polygon: Integer;
    MultiT1: Integer;
    MultiT2: Integer;
    MultiT3: Integer;
    BlendVal1: Integer;
    BlendVal2: Integer;
    Hide: Boolean;
  end;

  PQuat = ^Quat;
  Quat = record
      x,y,z,w:single;
     end;

  TTransTypes = (TTNone, TTMatrix, TTVector, TTJoint);

  TTrans = record
    TransType: TTransTypes;
    Pos: Tver;
    Rot: Tver;
    RotOrient: Tver;
    JointOrient: Tver;
    Size: Tver;
    TrMatrix: TMatrix;
  end;

  TKeyFrame = array [0..5] of GLfloat;
  PKeyFrame = ^TKeyFrame;

  TGrafKey = record
        Frame:PKeyFrame;
        Rect:TRect;
        end;

  TTypeKey = record
    objname: string;
//    fullname: string;
//    NoAddOp: Boolean;
    hash: Cardinal;
    ktype: Integer;
  end;

  TKeyData = record
    keytype: TTypeKey;
    Accel: Single;
    Data: array of TKeyFrame;
    TCoord: array of ATCoord;
    Visible: array of Boolean;
    mesh_id: Integer;
  end;

  PKeyData = ^TKeyData;

  TMenuItem = class (Menus.TMenuItem)
    public
    KeyType: TTypeKey;
    CntrIdx:Integer;
    end;

  TAnimInfo = record
    Tm:TMatrix;
    Tr:TMatrix;
    mesh_id: Integer;
    TCoord: ATCoord;
    isVisible:Boolean;
    Visible:Boolean;
  end;
  TBoneData = record
    boneHash: Cardinal;
    Rot: TVer4f;
    Pos: Tver;
    RotKey: Integer;
    PosKey: Integer;
    TexKey: Integer;
    VisKey: Integer;
  end;
  ABoneData = array of TBoneData;
  AAnimInfo = array of TAnimInfo;

{ TAnimClip }

  TAnimClip = class
{  private
    FAnimInfo:AAnimInfo;
    FNamesObj:TStringList;  }
    constructor Create;
    destructor Destroy;override;
  public
    Name: string;
    Time: Single;
    Acceleration: Single;
    Keys: array of TKeyData;
    Bones: ABoneData;
    function GenAnimFrame(Hash: Cardinal; T: TTrans):TAnimInfo;
    procedure GenAnimMatrix(BoneIndex: Integer;var FrameCount: Integer; var TimeText:String; var MatrixText:String);
    procedure SetKey(boneHash:Cardinal;KeyType:Integer;Num:Integer);
    function  FindKey(KData:PKeyData;SelKey:PKeyFrame):integer;
    function  FindTimeKey(KData:PKeyData;FTime:Single):integer;
    function  FindKeyNameType(FName:String;Atype:integer):PKeyData;
    procedure Copy(Source:TAnimClip);
    procedure SortKeys;
    procedure SortKeyData(KData:PKeyData);
    procedure DeleteKey(Key:PKeyFrame);
    procedure Clear;
  end;

  AAnimClip = array of TAnimClip;

{ TAnimClips }


    TAnimClips = class
    constructor Create;
    destructor Destroy; override;
  private
    FAnimClips:AAnimClip;
  //  FKeyList:TStringList;
  protected
    function GetItem(Index: String): TAnimClip;
    function GetCount:Integer;
    procedure SetItem(Index: String; Value: TAnimClip);
  public
    FStrings:TStringList;
    cIndx:integer;
    Name:String;
    procedure SetRootBone(BoneHash: Cardinal);
    procedure ClearClips;
    function AddClip(Clip:TAnimClip):Integer;
    function BuildAnim(AnimObj:TObject; AnimHash:Cardinal):Integer;
    procedure SaveAnimToBSP();
    function GetItemID(Index: Integer): TAnimClip;
    property Items[Index:String]:TAnimClip read GetItem write SetItem;
    property Count: Integer read GetCount;
//    property KeyList:TStringList read FKeyList write FKeyList;
  end;

{ THRTimer }

  THRTimer = class(TObject)
    constructor Create;
    function StartTimer: Boolean;
    procedure ReadTimer;
  private
    StartTime: Single;
    ClockRate: Single;
  public
    Value: Single;
    MaxTime: Single;
    Exists: Boolean;
  end;

{ TMesh }

  TMesh = class;

  AMesh = array of TMesh;

  TMesh = class
  //  AnimClips: AAnimClip;
    Indx: Integer;
    Hash: Cardinal;
   // CNode: Cardinal;
    ColorIndx:Integer;
    Name: string;
    ChName:string;                                                   
    XType: string;
    Hide: Boolean;
    Vert: AVer;
    RVert: AVer;
    Weight: AAVal;
    Normal: AVer;
    Face: AFace;
    floors: Cardinal;
 //   DPos: AVer;

//   FacesMat:Integer;
//    MaxFace:Dword;
//   ObjBlockLen,
//   TrimeshLen,
//   NameLen,
   VertsLen,
   FacesLen,
//   TextCoordlen,
   MaxVert: Dword;
 //  Materials: array of ATexures;
 //  MaterialsName: array of String;

    Color: AUColor;
    ColorF:AFColor;
    TextCoord: ATCoord;
    TextCoord2: ATCoord;
    TextCoordN: ATCoord;
    AnimTCoord: ATCoord;
    isAnimT: Boolean;
    Transform: TTrans;
    Attribute: TAttribute;
//    TextData: array of TRGBA;
    BoneName: string;
 //   BoneNoInv: Boolean;
    BoneMatrix: TMatrix;
    InvBoneMatrix: TMatrix;
    AnimMatrix: TMatrix;
    SizeBox: TBox;
    IsLink:Boolean;
    Bones: AMesh;
    Childs: AMesh;
 //   CntrArr: TContainers;
    constructor Create;
    procedure InitSizeBox;
    procedure SetSizeBox(val:Single);
    procedure CalcBox(var Box:TBox; const Ver:TVer);
    procedure CalcSizeBox(Const Ver:TVer);
    procedure Draw(DrawType: TDrawType);
    procedure GetBox(var Box: TBox);
    function CheckFloor:Boolean;
    function CheckFloorHeight(Height:Single):Boolean;

    procedure glLoad2DMipmaps(target: GLenum; Components, Width, Height: GLint;
      Format, atype: GLenum; Data: Pointer);
    procedure DrawSelectBox(SelectBox: TBox);
    procedure DrawCamera();
    procedure DrawSpawn();
    procedure ReadVCFile(FileName: string);
    procedure TestApplyVC(VCMesh:TMesh);

    procedure GetTextureGL(matobj:TObject);
    function GetMeshOfName(ObjName:String):TMesh;
    function GetMeshOfID(Id:Integer):TMesh;
    function GetMeshAtomic:TMesh;
    function GetMeshGroupId(mesh_id:Integer):TMesh;
    procedure ResetChilds(Num:integer);
    procedure Clear;
    procedure SetEntMatrix(EntMatrix:TEntMatrix);
    procedure SetBound(bbox: TBBox);
    destructor Destroy;override;

  end;

//
procedure VertAdd(var Ver:TVer; Norm:Tver);
function CreateVector(A, B: TVer): TVer;
function VectorProduct(A, B: TVer): TVer;
function GetLength(pn:Tver):Real;
procedure Normalise(var pn: Tver);
function GenNormal(idx:integer;Face:AFace;Vert:AVer):Tver;

function GetMatrix2(Pos, Rot1, Rot2, Rot3, Size: Tver): TMatrix;
function GetMatrix(Pos, Rot, Size: Tver): TMatrix;
procedure MatrixDecompose(XMatrix: TMatrix; var XPos: Tver;
  var XRot: Tver; var XSize: Tver);
function MatrixInvertPrecise(const m: TMatrix): TMatrix;
function MatrixInvert(const m: TMatrix): TMatrix;
function MatrxMatrPrecise(const m1, m2: TMatrix): TMatrix;
function MatrXMatr(M1, M2: TMatrix): TMatrix;
function MatrXVert(Matrix: TMatrix; V0, V1, V2: Single): Tver;
function ValXVert(Val: Single; vect: TVer): TVer;
function VertAddVert(v1, v2: TVer): TVer;
function MatrixToQuat(mat:TMatrix):TVer4f;
procedure glxDrawBitmapText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; bitPoint2: Pointer;
  Name: string; select: Boolean);
procedure glxDrawText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; Name: string);
procedure GetProjectVert(X,Y:real;axis:TAxis;var p:TXYZ);
function QuatAverage(var rq:Quat;q1, q2:Quat; divTime:Single):boolean;
procedure QuatNormalize(var a:Quat);
function EqualPos(value1,value2:single):Boolean;
function SameRotMatrix(Mat1,Mat2:TMatrix):Boolean;
function SamePos(v1,v2:PVer):Boolean;
function SameWRot(w1,w2:TKeyRot):Boolean;

implementation

uses BSPLib;

procedure glColorPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid); stdcall; external opengl32;

procedure glTexCoordPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid); stdcall; external opengl32;
//procedure glColorTable(target: TGLint; internalformat: TGLenum; width: TGLsizei;format:TGLenum;_type: TGLenum; const _pointer: PGLvoid);stdcall;external opengl32;

procedure glDisableClientState(_array: TGLenum); stdcall; external opengl32;

function EqualPos(value1,value2:single):Boolean;
begin
  result:= Abs(value1 - value2) < 0.000001;
end;

function SamePos(v1,v2:PVer):Boolean;
begin
  Result:=False;
  if EqualPos(v1[0],v2[0]) and EqualPos(v1[1],v2[1]) and EqualPos(v1[2],v2[2]) then
  Result:=true;
end;

function SameWRot(w1,w2:TKeyRot):Boolean;
begin
  Result:=false;
    if (w1.RotX=w2.RotX) and
       (w1.RotY=w2.RotY) and
       (w1.RotZ=w2.RotZ) and
       (w1.RotW=w2.RotW) then Result:=true;
end;

function SameRotMatrix(Mat1,Mat2:TMatrix):Boolean;
var i,j:integer;
begin
   Result:=False;
   for i:=1 to 3 do
    for j:=1 to 3 do if Mat1[i][j]<>Mat2[i][j] then Exit;
   Result:=true;
end;

{ TAnimClip }

constructor TAnimClip.Create;
begin
end;

procedure TAnimClip.Copy(Source:TAnimClip);
var
 i,n,ii,nn:integer;
begin
 self.Name:=Source.Name;
 self.Time:=Source.Time;
 n:=Length(Source.Keys);
 SetLength(self.Keys,n);
 for i:=0 to n-1 do
        begin
        self.Keys[i].keytype:=Source.Keys[i].keytype;
        nn:=Length(Source.Keys[i].Data);
        SetLength(self.Keys[i].Data,nn);
        for ii:=0 to nn-1 do
                self.Keys[i].Data[ii]:=Source.Keys[i].Data[ii];
        end;
end;

procedure TAnimClip.Clear;
var
  j,t: Integer;
begin
  for j := 0 to High(Keys) do begin
    Keys[j].Data := nil;
    Keys[j].Visible := nil;
    if Keys[j].TCoord<>nil then
       for t:=0 to High(Keys[j].TCoord) do
          Keys[j].TCoord[t]:=nil;
  end;
  Keys := nil;
  Bones:= nil;
end;

destructor TAnimClip.Destroy;
begin
  Clear;
{  SetLength(FAnimInfo,0);
  FAnimInfo:=nil;
  FNamesObj.Free   }
end;

constructor THRTimer.Create;
var
  QW: Int64;
begin
  inherited Create;
  Exists := QueryPerformanceFrequency(QW);
  ClockRate := QW//.QuadPart;
end;

function THRTimer.StartTimer: Boolean;
var
  QW: Int64;
begin
  Result := QueryPerformanceCounter(QW);
  StartTime := QW;//.QuadPart;
  Value := 0.0;
end;

procedure THRTimer.ReadTimer;
var
  ET: Int64;
begin
  QueryPerformanceCounter(ET);
  // Result := 1000.0 * (ET.QuadPart - StartTime) / ClockRate;
  Value := (ET - StartTime) / ClockRate;
  if Value > MaxTime then
    StartTimer;
end;

procedure TAnimClip.SetKey(boneHash: Cardinal; KeyType, Num: Integer);
var
  i,n:Integer;
begin
  n:=Length(Bones);
  for i:=0 to n-1 do begin
      if Bones[i].boneHash = boneHash then begin
        case KeyType of
          K_Rot: Bones[i].RotKey:=Num;
          K_Pos: Bones[i].PosKey:=Num;
          K_UV: Bones[i].TexKey:=Num;
          K_Vis: Bones[i].VisKey:=Num;
        end;
        Break;
      end;
  end;
end;

{ TAnimClips}

constructor TAnimClips.Create;
begin
  FStrings:=TStringList.Create;
//  FKeyList:=TStringList.Create;
end;

destructor TAnimClips.Destroy;
begin
  ClearClips;
  FAnimClips:=nil;
//  FKeyList.Free;
  FStrings.Free;
end;

procedure TAnimClips.ClearClips;
  var
  i:integer;
begin
  for i := 0 to Length(FAnimClips) - 1 do
    FAnimClips[i].Destroy;
  FAnimClips := nil;
  FStrings.Clear;
//  FKeyList.Clear;
end;

procedure TAnimClips.SaveAnimToBSP();
var
  inx, i, j, inx2, x, k, k2, k3: Integer;
  NumKeys,Zero,xSize:integer;
  VirtualBufer :TMemoryStream;
  KeyTypes: array of TTypeKey;

        function GetID(const KType:TTypeKey):Integer;
        var ik,nk:integer;
        begin
              nk:=Length(KeyTypes)-1;
              for ik:=0 to nk do
                if (KeyTypes[ik].ktype=KType.ktype) and
                 (KeyTypes[ik].objname=KType.objname)then
                 begin Result:=ik; exit; end;
         Result:=-1;
        end;

        procedure TestKeyType(const kType:TTypeKey);
        begin
          if GetID(KType)=-1 then
             begin
             Inc(NumKeys);
             SetLength(KeyTypes,NumKeys);
             KeyTypes[NumKeys-1]:=kType;
             end;
        end;


procedure  SortKeyTypes;
// сортировка ключей по дереву
var
i,j,n,test:integer;
X:TTypeKey;
begin
n:=Length(KeyTypes)-1;
for i:=1 to n do
  for j:=n downto i do
        begin
        test:=CompareStr(KeyTypes[j-1].objname,KeyTypes[j].objname);
        if (test>0)or ((test=0) and (
        (Word(KeyTypes[j-1].ktype)>Word(KeyTypes[j].ktype))
        or
        ((Word(KeyTypes[j-1].ktype)=Word(KeyTypes[j].ktype))
        and
        (KeyTypes[j-1].ktype>KeyTypes[j].ktype))))
                then begin
                X:=KeyTypes[j-1];
                KeyTypes[j-1]:=KeyTypes[j];
                KeyTypes[j]:=X;
                end;
        end;
end;


begin
  Zero:=0;
    VirtualBufer := TMemoryStream.Create;

   // BSP.WriteXName(VirtualBufer, Name);  // Name
    // собрать все ключи по всем клипам
    NumKeys:=0;
    SetLength(KeyTypes,NumKeys);    

   j:=Length(FAnimClips)-1;

   for i:=0 to j do
   begin
      x:=Length(FAnimClips[i].Keys)-1;
      for inx:=0 to x do
        TestKeyType(FAnimClips[i].Keys[inx].keytype);
   end;

   // отсортировать ключи.
   SortKeyTypes;

   VirtualBufer.Write(NumKeys, 4);     // NumKeys
  for x := 0 to NumKeys - 1 do
  begin   // Keys
    VirtualBufer.Write(KeyTypes[x].ktype, 4);  //AnimType
    // выделить полные имена ключей
   // BSP.WriteXName(VirtualBufer, KeyTypes[x].objname); //Object
  end;

   inx2:=Length(FAnimClips); // NumClips
   VirtualBufer.Write(inx2, 4);
  for j := 0 to inx2 - 1 do
  begin
    VirtualBufer.Write(FAnimClips[j].Time, 4); // time
   // BSP.WriteXName(VirtualBufer, FAnimClips[j].Name); // name

    inx:=Length(FAnimClips[j].Keys); // NumAnimKeys
    VirtualBufer.Write(inx, 4);

    //    if inx = integer($0101) then inx := 1 else
    for x := 0 to inx - 1 do
    begin   // AnimKeys

      k2 := 257;
      VirtualBufer.Write(k2, 4); // 1 1 0 0
      // ключи должны быть уже отсортированы !!!
      k2:=GetID(FAnimClips[j].Keys[x].keytype);// KeyTypes[k2];
      VirtualBufer.Write(k2, 2);

      k3 := 0;
    //  If FAnimClips[j].Keys[x].keytype.NoAddOp then k3:= 2;
      VirtualBufer.Write(k3, 2);

      VirtualBufer.Write(Zero, 2);
      VirtualBufer.Write(Zero, 4);

      k := Length(FAnimClips[j].Keys[x].Data);
      VirtualBufer.Write(k, 4);
      for i := 0 to k - 1 do
        VirtualBufer.Write(FAnimClips[j].Keys[x].Data[i][0], 6*4);
    end;
  end;
  //  BSP.CntrArr[CIndx].WriteBuf(VirtualBufer);
    VirtualBufer.Free;
end;

procedure TAnimClips.SetRootBone(BoneHash: Cardinal);
var
 num: Integer;
 AnimClip:TAnimClip;
 KeyType:TTypeKey;
begin
  if Length(FAnimClips)>0 then begin
   AnimClip:=FAnimClips[0];
   KeyType:=AnimClip.Keys[0].keytype;
   if KeyType.hash=0 then
    AnimClip.SetKey(BoneHash,KeyType.ktype,0);
  end;
end;

Function TAnimClips.BuildAnim(AnimObj:TObject; AnimHash:Cardinal):Integer;
var
//  AB: TComboBox;
  n: Integer;
  Num:Integer;
  p2: Pointer;
  s, s1: string;
  KeyFrame: TKeyFrame;
  AnimType: Cardinal;
  AnimClip: TAnimClip;
  AnimLib: TAnimDictionary;
  ExpAnim: Boolean;
//  StrList:TStringList;
  KeyType:TTypeKey;
  AnimKeyBlock:TAnimKeyBlock;

procedure CreateAnimClip(j:integer);
var
  inx, inx1, i, inx2, x, k, t, k2, k3: Integer;
  accel: single;
  begin
    AnimClip      := TAnimClip.Create;
    AnimClip.Time := AnimLib.Clips[j].maxTime;
    AnimClip.Name := AnimLib.Clips[j].name;
    AddClip(AnimClip);
    inx := AnimLib.Clips[j].bone_num;
    SetLength(AnimClip.Bones,inx);
    for x := 0 to inx - 1 do
    begin
      AnimClip.Bones[x].boneHash:=AnimLib.Clips[j].bone_block[x].boneHash;
      AnimClip.Bones[x].Rot[0]:=AnimLib.Clips[j].bone_block[x].frame^.RotX * 0.000030518509;
      AnimClip.Bones[x].Rot[1]:=AnimLib.Clips[j].bone_block[x].frame^.RotY * 0.000030518509;
      AnimClip.Bones[x].Rot[2]:=AnimLib.Clips[j].bone_block[x].frame^.RotZ * 0.000030518509;
      AnimClip.Bones[x].Rot[3]:=AnimLib.Clips[j].bone_block[x].frame^.RotW * 0.000030518509;
      AnimClip.Bones[x].Pos[0]:=AnimLib.Clips[j].bone_block[x].frame^.PosX;
      AnimClip.Bones[x].Pos[1]:=AnimLib.Clips[j].bone_block[x].frame^.PosY;
      AnimClip.Bones[x].Pos[2]:=AnimLib.Clips[j].bone_block[x].frame^.PosZ;
      AnimClip.Bones[x].RotKey:=-1;
      AnimClip.Bones[x].PosKey:=-1;
      AnimClip.Bones[x].TexKey:=-1;
      AnimClip.Bones[x].VisKey:=-1;
    end;

    inx     := AnimLib.Clips[j].keys_num;  // NumAnimKeys
    SetLength(AnimClip.Keys, inx);
    accel:=100;
    for x := 0 to inx - 1 do
    begin   // AnimKeys
      AnimKeyBlock:=AnimLib.Clips[j].Keys[x];
      AnimClip.SetKey(AnimKeyBlock.bone_hash,AnimKeyBlock.key_type,x);
      KeyType.ktype:=AnimKeyBlock.key_type;
      //KeyType.NoAddOp:=False;
      KeyType.hash:= AnimKeyBlock.bone_hash;
      AnimClip.Keys[x].keytype :=KeyType;
      if AnimKeyBlock.mesh_id<>-1 then AnimClip.Keys[x].mesh_id :=AnimKeyBlock.mesh_id;
      AnimClip.Keys[x].Accel:=AnimKeyBlock.acceleration;
      if (AnimKeyBlock.acceleration>0) and (AnimKeyBlock.acceleration<accel) then accel:=AnimKeyBlock.acceleration;
      k:=AnimKeyBlock.key_num;
      SetLength(AnimClip.Keys[x].Data, k);
      if KeyType.ktype=K_UV then SetLength(AnimClip.Keys[x].TCoord, k);
      if KeyType.ktype=K_Vis then SetLength(AnimClip.Keys[x].Visible, k);
      for i := 0 to k - 1 do
      begin
        case KeyType.ktype of
        K_Rot: begin
           KeyFrame[0]:= AnimKeyBlock.rot_keys[i].RotX * 0.000030518509;
           KeyFrame[1]:= AnimKeyBlock.rot_keys[i].RotY * 0.000030518509;
           KeyFrame[2]:= AnimKeyBlock.rot_keys[i].RotZ * 0.000030518509;
           KeyFrame[3]:= AnimKeyBlock.rot_keys[i].RotW * 0.000030518509;
        end;
        K_Pos:begin
           KeyFrame[0]:= AnimKeyBlock.pos_keys[i][0];
           KeyFrame[1]:= AnimKeyBlock.pos_keys[i][1];
           KeyFrame[2]:= AnimKeyBlock.pos_keys[i][2];
        end;
        K_Vect:begin
           // todo
        end;
        K_UV:begin
           k3:= AnimKeyBlock.UV_keys[i].num;
           SetLength(AnimClip.Keys[x].TCoord[i],k3);
           for t:=0 to k3-1 do begin
             AnimClip.Keys[x].TCoord[i][t][0]:=AnimKeyBlock.UV_keys[i].U_keys[t]/256;
             AnimClip.Keys[x].TCoord[i][t][1]:=AnimKeyBlock.UV_keys[i].V_keys[t]/256;
           end;
        end;
        K_Vis:begin
          AnimClip.Keys[x].Visible[i]:=(AnimKeyBlock.vis_keys[i]>0);
        end;
        end;
        Move(AnimLib.Clips[j].Keys[x].time_keys[i],KeyFrame[4],4);
        AnimClip.Keys[x].Data[i] := KeyFrame;
      end;
    end;
    if accel<100 then AnimClip.Time:=AnimClip.Time/accel;
  end;
begin
  AnimLib:= TAnimDictionary(AnimObj);
  // clear buffer

//  ClearClips;
  //------
 // NumKeys

// NumClips
 Result:=0;
  Num:= AnimLib.NumClips;
  if AnimHash=0 then  begin     
    for n := 0 to Num - 1 do
    begin
     CreateAnimClip(n);
    end;
    Result:=Num;
  end else
  begin
    for n := 0 to Num - 1 do
    if AnimLib.Clips[n].hash=AnimHash then begin
     CreateAnimClip(n);
     Result:=1;
     Break;
    end;
  end;;
end;

function TAnimClips.GetItem(Index:String):TAnimClip;
begin
  Result := FAnimClips[FStrings.IndexOf(Index)];
end;

function TAnimClips.GetItemID(Index: Integer): TAnimClip;
begin
  Result := FAnimClips[Index];
end;

function TAnimClips.AddClip(Clip:TAnimClip):Integer;
var l:Integer;
begin
  l:=Length(FAnimClips);
  SetLength(FAnimClips, l+1);
  FStrings.Add(Clip.Name);
  FAnimClips[l]:=Clip;
  Result:=l;
end;

procedure TAnimClips.SetItem(Index:String;Value:TAnimClip);
var i:integer;
begin
// сначало ищем индекс, если не находим то изменяем.
  i:=FStrings.IndexOf(Index);
  if (i>-1) then FAnimClips[i]:=Value;
end;


function GetAngle(x,y,x1,y1:single):single;
var z,z1,dir:single;
begin
if (y<0) then dir:=pi else dir:=0;
z:=dir+ArcTan(x/y);
if (y1<0) then dir:=pi else dir:=0;
z1:=dir+ArcTan(x1/y1);
//if z>z1 then dir:=pi else dir:=0;
result:=radtodeg(z-z1);
end;

function RotVectMat(Vect:TVer4f):TMatrix;
var
 t0,t1,u,t2,RotX,RotY,RotZ,RotW:Single;
 RotX2,RotY2,RotZ2,X2W,Y2W,Z2W,X2X,X2Y,Y2Y,X2Z,Y2Z,Z2Z,NX2X: Single;
 sy:Single;
 mat:TMatrix;
begin

  RotX:=Vect[0];
  RotY:=Vect[1];
  RotZ:=Vect[2];
  RotW:=Vect[3];

  ZeroMemory(@mat[1][1],SizeOf(mat));
  RotX2 := RotX *2;
  RotY2 := RotY *2;
  RotZ2 := RotZ *2;
  X2W := RotX2 * RotW;
  Y2W := RotY2 * RotW;
  Z2W := RotZ2 * RotW;
  X2X := RotX2 * RotX;
  X2Y := RotX2 * RotY;
  Y2Y := RotY2 * RotY;
  X2Z := RotX2 * RotZ;
  Y2Z := RotY2 * RotZ;
  Z2Z := RotZ2 * RotZ;
  mat[1][1] := 1.0 - Y2Y - Z2Z;  // 1- 2*q.y^2 - 2*q.z^2
  mat[2][1] := X2Y - Z2W;   // 2*q.x*q.y - 2*q.z*q.w
  mat[3][1] := X2Z + Y2W;   // 2*q.x*q.z + 2*q.y*q.w
  mat[1][2] := X2Y + Z2W;   // 2*q.x*q.y + 2*q.z*q.w
  NX2X := 1.0 - X2X;
  mat[2][2] := NX2X - Z2Z;  //  1 - 2*q.x^2 - 2*q.z^2
  mat[3][2] := Y2Z - X2W;   // 2*q.y*q.z - 2*q.x*q.w
  mat[1][3] := X2Z - Y2W;   // 2*q.x*q.z - 2*q.y*q.w
  mat[2][3] := Y2Z + X2W;   // 2*q.y*q.z + 2*q.x*q.w
  mat[3][3] := NX2X - Y2Y;  // 1 - 2*q.x^2 - 2*q.y^2
  mat[4][4]:=1;
 result:=Mat;

end;

function MatrixToQuat(mat:TMatrix):TVer4f;
var trace,s:single;
q:Quat;
a: array [0..2,0..2] of Single;
begin
  a[0][0]:=mat[1][1];  a[0][1]:=mat[2][1];  a[0][2]:=mat[3][1];
  a[1][0]:=mat[1][2];  a[1][1]:=mat[2][2];  a[1][2]:=mat[3][2];
  a[2][0]:=mat[1][3];  a[2][1]:=mat[2][3];  a[2][2]:=mat[3][3];

  trace := a[0][0] + a[1][1] + a[2][2]; // I removed + 1.0f; see discussion with Ethan
  if  trace > 0 then begin // I changed M_EPSILON to 0
    s := 0.5 / sqrt(trace+ 1.0);
    q.w := 0.25 / s;
    q.x := ( a[2][1] - a[1][2] ) * s;
    q.y := ( a[0][2] - a[2][0] ) * s;
    q.z := ( a[1][0] - a[0][1] ) * s;
  end else begin
    if ( a[0][0] > a[1][1]) and (a[0][0] > a[2][2] ) then begin
      s := 2.0 * sqrt( 1.0 + a[0][0] - a[1][1] - a[2][2]);
      q.w := (a[2][1] - a[1][2] ) / s;
      q.x := 0.25 * s;
      q.y := (a[0][1] + a[1][0] ) / s;
      q.z := (a[0][2] + a[2][0] ) / s;
    end else if (a[1][1] > a[2][2]) then begin
      s := 2.0 * sqrt( 1.0 + a[1][1] - a[0][0] - a[2][2]);
      q.w := (a[0][2] - a[2][0] ) / s;
      q.x := (a[0][1] + a[1][0] ) / s;
      q.y := 0.25 * s;
      q.z := (a[1][2] + a[2][1] ) / s;
    end else begin
      s := 2.0 * sqrt( 1.0 + a[2][2] - a[0][0] - a[1][1] );
      q.w := (a[1][0] - a[0][1] ) / s;
      q.x := (a[0][2] + a[2][0] ) / s;
      q.y := (a[1][2] + a[2][1] ) / s;
      q.z := 0.25 * s;
    end;
  end;
  Result[0]:=q.x;
  Result[1]:=q.y;
  Result[2]:=q.z;
  Result[3]:=q.w;
end;

type
   PGLMatrixf = ^GLMatrixf;
   GlMatrixf = array[1..4,1..4]of single;

function Q_norm(a:Quat):single;      // result:=norm(a);
begin
 result:=sqr(a.w)+sqr(a.x)+sqr(a.y)+sqr(a.z);
end;

procedure Q_normed(var a:Quat);          // normalize(a);
var u:single;
begin
 u:=Q_norm(a);
 a.w:=a.w/u; a.x:=a.x/u; a.y:=a.y/u; a.z:=a.z/u;
end;

procedure QuatNormalize(var a:Quat);
var u:single;
begin
 u:=Q_norm(a);
 if u<>0 then begin
  u:=1/Sqrt(u);
   a.w:=a.w*u;
   a.x:=a.x*u;
   a.y:=a.y*u;
   a.z:=a.z*u;
 end;
end;

function InverseQuat(q:Quat):Quat;
begin
  Result.x:=-q.x;
  Result.y:=-q.y;
  Result.z:=-q.z;
  Result.w:=-q.w;
end;

function DotQuat(q1,q2:Quat):Single;
begin
  result:=q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w;
end;

function QuaternionsClose(q1, q2:Quat):boolean;
var dot:single;
begin
	dot := DotQuat(q1, q2);
	if dot < 0.0 then
		Result:= false
	else
		Result:= true;
end;

function MidQuat(var rq:Quat;q1, q2:Quat; dtime:Single):boolean;
var
  dot,det:Single;
  acos_dot,nsin_acos,acos_dtime,sin_dot,sin_dtime:Extended;
begin
  dot := DotQuat(q1,q2);
  det := 1.0 - 0.000001;
  if dot < det then
  begin
    acos_dot := arccos(dot);
    nsin_acos := 1.0 / sin(acos_dot);
    acos_dtime := dtime * acos_dot;
    sin_dot := sin(acos_dot - acos_dtime);
    sin_dtime := sin(acos_dtime);
    rq.w := (q2.w * sin_dtime + q1.w * sin_dot) * nsin_acos;
    rq.x := (q2.x * sin_dtime + q1.x * sin_dot) * nsin_acos;
    rq.y := (q2.y * sin_dtime + q1.y * sin_dot) * nsin_acos;
    rq.z := (q2.z * sin_dtime + q1.z * sin_dot) * nsin_acos;
    result := true;
  end
  else
  begin
    rq := q1;
    result := false;
  end;
end;

function QuatAverage(var rq:Quat;q1, q2:Quat; divTime:Single):boolean;
var
 dot:Double;
  q, nq2:Quat;
begin
  q.W := q1.w - q2.w;
  q.X := q1.x - q2.x;
  q.Y := q1.y - q2.y;
  q.Z := q1.z - q2.z;
  nq2.w := q1.w + q2.w;
  nq2.x := q1.x + q2.x;
  nq2.y := q1.y + q2.y;
  nq2.z := q1.z + q2.z;
  dot := Q_norm(q);
  if  dot >= Q_norm(nq2) then
  begin
    nq2:=InverseQuat(q2);
    result := MidQuat(rq, q1, nq2, divTime);
  end
  else
  begin
    if  dot < 0.000001  then
    begin
      rq := q1;
      result := false;
    end
    else
      result := MidQuat(rq, q1, q2, divTime);
  end;
end;

function NotQuat(q:Quat):boolean;
begin
  result:=false;
  if (q.x>1) or (q.y>1) or (q.z>1) or (q.w>1) then result:=true;
end;

function TAnimClip.GenAnimFrame(Hash: Cardinal; T: TTrans):TAnimInfo;
var
  i, j, m, n,m1,i1, k1, k2, inx: Integer;
  Value:Single;
  Key,KeyN: TKeyData;
  AType: Cardinal;
  RotTmp: ^TVer;
  RotQ: TVer4f;
  Mat: TMatrix;
  function GetMidPos(Key:TKeyData; k1:integer; k2:integer): TVer;
  var
    divTime:Single;
    Key1, Key2: TKeyFrame;
    speed: Single;
  begin
    speed:=1;
    if Key.Accel>0 then speed:=1/Key.Accel;
    Key1:=Key.Data[k1];
    Key2:=Key.Data[k2];
    divTime := (AnimTimer.Value - Key1[4]*speed) / (Key2[4]*speed - Key1[4]*speed);
    if (Key2[4] = Key1[4]) then
    begin
      Result[0] := Key1[0];
      Result[1] := Key1[1];
      Result[2] := Key1[2];
    end
    else
     begin
      Result[0] := Key1[0] + (Key2[0] - Key1[0]) * divTime;
      Result[1] := Key1[1] + (Key2[1] - Key1[1]) * divTime;
      Result[2] := Key1[2] + (Key2[2] - Key1[2]) * divTime;
     end;
  end;

  function GetMidRot(Key:TKeyData; k1:integer; k2:integer): TVer4f;
  var
    divTime,u:Single;
    q1,q2,a:Quat;
    Key1, Key2: TKeyFrame;
    speed: Single;
  begin
    speed:=1;
    if Key.Accel>0 then speed:=1/Key.Accel;
    Key1:=Key.Data[k1];
    Key2:=Key.Data[k2];
    divTime := (AnimTimer.Value - Key1[4]*speed) / (Key2[4]*speed - Key1[4]*speed);
    if (Key2[4] = Key1[4]) then
    begin
      Result[0] := Key1[0];
      Result[1] := Key1[1];
      Result[2] := Key1[2];
      Result[3] := Key1[3];
    end
    else
    begin

      Move(Key1[0],q1,4*4);
      Move(Key2[0],q2,4*4);

      if QuatAverage(a,q1,q2,divTime) then
      else
      begin
        QuatNormalize(q1);
        QuatNormalize(q2);
        QuatAverage(a,q1,q2,divTime);
      end;
        Result[0] := a.x;
        Result[1] := a.y;
        Result[2] := a.z;
        Result[3] := a.w;

     end;
  end;


  function GetMidValueInt(Key:TKeyData; k1:integer; k2:integer): Single;
  var
    divTime: Single;
    Key1, Key2: TKeyFrame;
    speed: Single;
  begin
    Key1:=Key.Data[k1];
    Key2:=Key.Data[k2];
    divTime := AnimTimer.Value - Key1[4];
    if (Key2[4] = Key1[4]) then
      Result := Key1[5]
    else if divTime / (Key2[4] - Key1[4]) > 0.5 then
      Result := Key2[5]
    else
      Result := Key1[5];
  end;

  procedure GetKeyIndex(Key:TKeyData;var k1:integer;var k2:integer);
  var n,j:integer;
  speed: Single;
  begin
    speed:=1;
  if Key.Accel>0 then speed:=1/Key.Accel;
  n := Length(Key.Data) - 1;
      k1 := 0;
      k2 := 0;
      for j := 0 to n do
      begin
        if (j = 0) and (Key.Data[j][4]*speed > AnimTimer.Value) then
        begin
          k1 := j;
          k2 := j;
          Break;
        end;
        if (j = n) then
        begin
          k1 := n;
          k2 := n;
          Break;
        end
        else if (Key.Data[j][4]*speed <= AnimTimer.Value) and
          (AnimTimer.Value < Key.Data[j + 1][4]*speed) then
        begin
          k1 := j;
          k2 := j + 1;
          Break;
        end;
      end;
  end;
// Mat:=RotVectMat(GetMidRot(Key,k1,k2));
// RotQ:=MatrixToQuat(Mat);
begin
  if (Hash=0) then exit;

  m := Length(Bones) - 1;
  for i := 0 to m do
    if (Bones[i].boneHash = Hash) then
    begin
      T.Pos:=Bones[i].Pos;
      Result.Tr:=RotVectMat(Bones[i].Rot);
      if Bones[i].RotKey>-1 then begin
          Key := Keys[Bones[i].RotKey];
          GetKeyIndex(Key,k1,k2);
          Result.Tr:=RotVectMat(GetMidRot(Key,k1,k2));
      end;
      if Bones[i].PosKey>-1 then begin
          Key := Keys[Bones[i].PosKey];
          GetKeyIndex(Key,k1,k2);
          T.Pos:=GetMidPos(Key,k1,k2);
      end;
      if Bones[i].TexKey>-1 then begin
          Key := Keys[Bones[i].TexKey];
          GetKeyIndex(Key,k1,k2);
          Result.mesh_id:=Key.mesh_id;
          Result.TCoord:=Key.TCoord[k1];
      end;
      if Bones[i].VisKey>-1 then begin
          Key := Keys[Bones[i].VisKey];
          GetKeyIndex(Key,k1,k2);
          Result.isVisible:=true;
          Result.Visible:=Key.Visible[k1];
      end;
      Result.Tr[4][1]:=T.Pos[0];
      Result.Tr[4][2]:=T.Pos[1];
      Result.Tr[4][3]:=T.Pos[2];
      Result.Tm:=Result.Tr;
      break;
     end;
end;

procedure TAnimClip.GenAnimMatrix(BoneIndex: Integer; var FrameCount: Integer;
  var TimeText, MatrixText: String);
var
  i, j, m,f, n,m1,i1, k1, k2, inx: Integer;
  Value:Single;
  Key,KeyN: TKeyData;
  AType: Cardinal;
  RotTmp: ^TVer;
  TimeFrame: Single;
//  TimeArray: Aval;
  FrameMatrix: TMatrix;
  FramePos: TVer;
  PosKeyOnly:boolean;
  OneFrame:Boolean;
  MinTime:Single;
  function GetMidPos(Key1, Key2: TKeyFrame): TVer;
  var
    divTime:Single;
  begin
    divTime := (TimeFrame - Key1[4]) / (Key2[4] - Key1[4]);
    if (Key2[4] = Key1[4]) then
    begin
      Result[0] := Key1[0];
      Result[1] := Key1[1];
      Result[2] := Key1[2];
    end
    else
     begin
      Result[0] := Key1[0] + (Key2[0] - Key1[0]) * divTime;
      Result[1] := Key1[1] + (Key2[1] - Key1[1]) * divTime;
      Result[2] := Key1[2] + (Key2[2] - Key1[2]) * divTime;
     end;
  end;

  function GetMidRot(Key1, Key2: TKeyFrame): TVer4f;
  var
    divTime,u:Single;
    q1,q2,a:Quat;
  begin
    divTime := (TimeFrame - Key1[4]) / (Key2[4] - Key1[4]);
    if (Key2[4] = Key1[4]) then
    begin
      Result[0] := Key1[0];
      Result[1] := Key1[1];
      Result[2] := Key1[2];
      Result[3] := Key1[3];
    end
    else 
    begin

      Move(Key1[0],q1,4*4);
      Move(Key2[0],q2,4*4);

      if QuatAverage(a,q1,q2,divTime) then
      begin
        Result[0] := a.x;
        Result[1] := a.y;
        Result[2] := a.z;
        Result[3] := a.w;
      end else
      begin
        QuatNormalize(q1);
        QuatNormalize(q2);
        QuatAverage(a,q1,q2,divTime);
        Result[0] := a.x;
        Result[1] := a.y;
        Result[2] := a.z;
        Result[3] := a.w;
      end;

     end;
  end;


  function GetMidValueInt(Key1, Key2: TKeyFrame): Single;
  var
    divTime: Single;
  begin
    divTime := TimeFrame - Key1[4];
    if (Key2[4] = Key1[4]) then
      Result := Key1[5]
    else if divTime / (Key2[4] - Key1[4]) > 0.5 then
      Result := Key2[5]
    else
      Result := Key1[5];
  end;

  procedure GetKeyIndex(Key:TKeyData;var k1:integer;var k2:integer);
  var n,j:integer;
  begin
  n := Length(Key.Data) - 1;
      k1 := 0;
      k2 := 0;
      for j := 0 to n do
      begin
        if (j = 0) and (Key.Data[j][4] > TimeFrame) then
        begin
          k1 := j;
          k2 := j;
          Break;
        end;
        if (j = n) then
        begin
          k1 := n;
          k2 := n;
          Break;
        end
        else if (Key.Data[j][4] <= TimeFrame) and
          (TimeFrame < Key.Data[j + 1][4]) then
        begin
          k1 := j;
          k2 := j + 1;
          Break;
        end;
      end;
  end;
  function MatrixToText(Matrix:TMatrix):string;
  var i,j:integer;
  s:string;
  begin
    s:='';
     for j:=1 to 4 do
      for i:=1 to 4 do
        s:=Format('%s%.6f ',[s,Matrix[i][j]]);
    Result:=StringReplace(Trim(s),'.000000','',[rfReplaceAll]);
  end;

begin
  if Bones[BoneIndex].boneHash=0 then exit;
  OneFrame:=(FrameCount=-1);
  FrameCount:=Round(Time*30);
  PosKeyOnly:=False;
  if (Bones[BoneIndex].RotKey=-1) and (Bones[BoneIndex].PosKey>-1) then
  begin
    FrameCount:=Length(Keys[Bones[BoneIndex].PosKey].Data)+1;
    PosKeyOnly:=true;
  end;

  MinTime:=Time;
  if (Bones[BoneIndex].RotKey>-1) and (Keys[Bones[BoneIndex].RotKey].Data[0][4]<MinTime)
  then MinTime:=Keys[Bones[BoneIndex].RotKey].Data[0][4];

  if (Bones[BoneIndex].PosKey>-1) and (Keys[Bones[BoneIndex].PosKey].Data[0][4]<MinTime)
  then MinTime:=Keys[Bones[BoneIndex].PosKey].Data[0][4];

  if OneFrame or ((Bones[BoneIndex].RotKey=-1) and (Bones[BoneIndex].PosKey=-1)) then
    FrameCount:=1;

  TimeFrame:=0.0;
//  if (FrameCount>1) and PosKeyOnly then
//    TimeFrame:=MinTime;

  TimeText:='';
  MatrixText:='';
  f:=0;
  for i:=0 to FrameCount-1 do
    begin
      
      if i>0 then begin
        if PosKeyOnly then
          TimeFrame:=Keys[Bones[BoneIndex].PosKey].Data[i-1][4]
        else
          TimeFrame:=i/(FrameCount-1)*Time;

        if TimeFrame<MinTime then begin
         if ((i+1)/(FrameCount-1)*Time)>MinTime then
           TimeFrame:=MinTime
         else
          Continue;
        end;
      end;
      TimeText:=Format('%s%.6f ',[TimeText,TimeFrame]);
      FramePos:=Bones[BoneIndex].Pos;
      FrameMatrix:=RotVectMat(Bones[BoneIndex].Rot);
      if Bones[BoneIndex].RotKey>-1 then begin
        Key := Keys[Bones[BoneIndex].RotKey];
        GetKeyIndex(Key,k1,k2);
        FrameMatrix:=RotVectMat(GetMidRot(Key.Data[k1], Key.Data[k2]));
      end;
      if Bones[BoneIndex].PosKey>-1 then begin
        Key := Keys[Bones[BoneIndex].PosKey];
        GetKeyIndex(Key,k1,k2);
        FramePos:=GetMidPos(Key.Data[k1], Key.Data[k2]);
      end;
      FrameMatrix[4][1]:=FramePos[0];
      FrameMatrix[4][2]:=FramePos[1];
      FrameMatrix[4][3]:=FramePos[2];
      MatrixText:=MatrixText+' '+MatrixToText(FrameMatrix);
      Inc(f);
     // Result.Tm:=Result.Tr;
    end;
  FrameCount:=f;
  TimeText:=Trim(TimeText);
  MatrixText:=Trim(MatrixText);
end;

procedure  TAnimClip.SortKeys;
// сортировка ключей по дереву
var
i,j,n,test:integer;
X:TKeyData;
begin
n:=Length(Keys)-1;
for i:=1 to n do
  for j:=n downto i do
        begin
        test:=CompareStr(Keys[j-1].keytype.objname,Keys[j].keytype.objname);
        if (test>0)or ((test=0) and (
        (Word(Keys[j-1].keytype.ktype)>Word(Keys[j].keytype.ktype))
        or
        ((Word(Keys[j-1].keytype.ktype)=Word(Keys[j].keytype.ktype))
        and
        (Keys[j-1].keytype.ktype>Keys[j].keytype.ktype))))
                then begin
                X:=Keys[j-1];
                Keys[j-1]:=Keys[j];
                Keys[j]:=X;
                end;
        end;
end;

procedure  TAnimClip.SortKeyData(KData:PKeyData);
var
i,j,n:integer;
X:TKeyFrame;
begin
n:=Length(KData.Data)-1;
for i:=1 to n do
  for j:=n downto i do
        if KData.Data[j-1][4]>KData.Data[j][4] then begin
                X:=KData.Data[j-1];
                KData.Data[j-1]:=KData.Data[j];
                KData.Data[j]:=X;
        end;
end;

procedure TAnimClip.DeleteKey(Key:PKeyFrame);
var
i,ii,n,nn,inx:integer;
begin
n:=Length(Keys)-1;
for i:=0 to n do begin
        inx:=FindKey(@Keys[i],Key);
        if inx<>-1 then
         begin
         nn:=Length(Keys[i].Data);
         if nn=2 then exit;
         for ii:=inx to nn-2 do
                Keys[i].Data[ii]:=Keys[i].Data[ii+1];
         SetLength(Keys[i].Data,nn-1);
         exit;
         end;
        end;
end;

function TAnimClip.FindKey(KData:PKeyData;SelKey:PKeyFrame):integer;
var
  ii,num:integer;
begin
   Result:=-1;
   num:=Length(KData.Data);
   for ii:=0 to num-1 do
     if @KData.Data[ii]=SelKey then begin Result:=ii; Exit; end;
end;

function TAnimClip.FindTimeKey(KData:PKeyData;FTime:Single):integer;
var
  ii,num:integer;
begin
   Result:=-1;
   num:=Length(KData.Data);
   for ii:=0 to num-1 do
     if KData.Data[ii][4]=FTime then begin Result:=ii; Exit; end;
end;

function TAnimClip.FindKeyNameType(FName:String;AType:integer):PKeyData;
var
i,j:integer;
begin
Result:=nil;
      j:=Length(Keys);
      for i:=0 to j-1 do
        if  (Keys[i].keytype.ktype=AType)and(Keys[i].keytype.objname=FName) then
                begin Result:=@Keys[i]; exit; end;
end;

function TAnimClips.GetCount: Integer;
begin
 Result:=Length(FAnimClips);
end;

{TMesh}

constructor TMesh.Create;
var
  n: Integer;
begin
  inherited Create;
//  CntrArr:=Arr;
  Name := 'dummy';
  Attribute.ZBufferFuncVal := 1;
  Attribute.AlphaFunc:= 6;
  Attribute.Polygon := 2;
  Attribute.ZBuffer := true;
  Attribute.CullFace := true;
  Transform.TransType := TTNone;
  for n := 0 to 2 do
    Transform.Size[n] := 1.0;
  for n := 1 to 4 do
    Transform.TrMatrix[n][n] := 1.0;
end;

type
  TVector4 = array[1..4] of Single;

function VertAddVert(v1, v2: TVer): TVer;
begin
  Result[0] := v1[0] + v2[0];
  Result[1] := v1[1] + v2[1];
  Result[2] := v1[2] + v2[2];
end;

function ValXVert(Val: Single; vect: TVer): TVer;
begin
  Result[0] := Val * vect[0];
  Result[1] := Val * vect[1];
  Result[2] := Val * vect[2];
end;

function MatrixInvertPrecise(const m: TMatrix): TMatrix;
var
  tM,mat: TMatrixD;
  row,column,big,j,i,k: integer;
  coeff,divisor,mult: Double;
  p: integer;
  procedure swap(var v1: double; var v2: double);
  var
    temp: double;
  begin
   temp:= v1;
   v1:= v2;
   v2:= temp;
  end;

  procedure swap_rows(var dmat: TMatrix; row1,row2: integer);
  var
    col: integer;
    temp: TVect4;
  begin
    for col:= 1 to 4 do
    begin
     temp[col]:= dmat[row1][col];
     dmat[row1][col]:= dmat[row2][col];
     dmat[row2][col]:= temp[col];
    end;
  end;

begin
  //Gauss-Jordan method
  //copy matrix
  for i:= 1 to 4 do
  begin
    for j:=1 to 4 do
    begin
      tM[i][j]:= m[i][j];
      if i = j then
        mat[i][j]:= 1.0
      else
        mat[i][j]:= 0.0;
    end;
  end;
  for column:=1 to 4 do //for each column
  begin
   if tM[column][column] = 0 then
   begin
    big:= column;
    for row:=1 to 4 do
    begin
      if Abs(tM[row][column]) > Abs(tM[big][column]) then
      begin
        big:= row;
      end;
    end;
   if big <> column then
   begin //swap rows
    for j:= 1 to 4 do
    begin
      swap(tM[column][j], tM[big][j]);
      swap(mat[column][j], mat[big][j]);
    end;
   end
   else
    begin
      //Indentity Matrix, singular.
    end;
   end;
   //Set each row in the column to 0
   for row:= 1 to 4 do
    if row <> column then
    begin
      coeff:= tM[row][column] / tM[column][column];
      if coeff <> 0 then
      begin
        for j:=1 to 4 do
        begin
          tM[row][j]:= tM[row][j] - (coeff * tM[column][j]);
          mat[row][j]:= mat[row][j] - (coeff * mat[column][j]);
        end;
        tM[row][column]:= 0;
      end;
    end;
  end;
  for row:= 1 to 4 do
   for column:= 1 to 4 do
      Result[row][column]:= mat[row][column] / tM[row][row];

end;


function MatrixInvert(const m: TMatrix): TMatrix;
var
  i: Integer;
  l: array [1..3] of GlFloat;  //GLDouble bigger precission.
begin
  for i := 1 to 3 do
  begin
    l[i] := 1.0 / (Sqr(m[i, 1]) + Sqr(m[i, 2]) + Sqr(m[i, 3]));
    Result[1, i] := m[i, 1] * l[i];
    Result[2, i] := m[i, 2] * l[i];
    Result[3, i] := m[i, 3] * l[i];
    Result[i, 4] := 0.0;
  end;
  Result[4, 4] := 1.0;

  for i := 1 to 3 do
    Result[4, i] := -(m[4, 1] * m[i, 1] * l[i] + m[4,
      2] * m[i, 2] * l[i] + m[4, 3] * m[i, 3] * l[1]);
end;

function MatrxMatrPrecise(const m1, m2: TMatrix): TMatrix;
var
  vect1x,vect1y,vect1z,vect1w,vect2x,vect2y,vect2z,vect2w,vect3x,vect3y,vect3z,vect3w,vect4x,vect4y,vect4z,vect4w: double;
begin
  vect1x:= m1[1, 1];
  vect1y:= m1[1, 2];
  vect1z:= m1[1, 3];
  vect1w:= m1[1, 4];
  Result[1, 1]:= vect1w * m2[4, 1] + vect1y * m2[2, 1] + vect1x * m2[1, 1] + vect1z * m2[3, 1];
  Result[1, 2]:= vect1z * m2[3, 2] + vect1x * m2[1, 2] + vect1w * m2[4, 2] + vect1y * m2[2, 2];
  Result[1, 3]:= vect1w * m2[4, 3] + vect1y * m2[2, 3] + vect1z * m2[3, 3] + vect1x * m2[1, 3];
  Result[1, 4]:= vect1y * m2[2, 4] + vect1z * m2[3, 4] + vect1x * m2[1, 4] + vect1w * m2[4, 4];
  vect2x:= m1[2, 1];
  vect2y:= m1[2, 2];
  vect2z:= m1[2, 3];
  vect2w:= m1[2, 4];
  Result[2, 1]:= vect2w * m2[4, 1] + vect2y * m2[2, 1] + vect2x * m2[1, 1] + vect2z * m2[3, 1];
  Result[2, 2]:= vect2z * m2[3, 2] + vect2x * m2[1, 2] + vect2w * m2[4, 2] + vect2y * m2[2, 2];
  Result[2, 3]:= vect2w * m2[4, 3] + vect2y * m2[2, 3] + vect2z * m2[3, 3] + vect2x * m2[1, 3];
  Result[2, 4]:= vect2y * m2[2, 4] + vect2z * m2[3, 4] + vect2x * m2[1, 4] + vect2w * m2[4, 4];
  vect3x:= m1[3, 1];
  vect3y:= m1[3, 2];
  vect3z:= m1[3, 3];
  vect3w:= m1[3, 4];
  Result[3, 1]:= vect3w * m2[4, 1] + vect3y * m2[2, 1] + vect3x * m2[1, 1] + vect3z * m2[3, 1];
  Result[3, 2]:= vect3z * m2[3, 2] + vect3x * m2[1, 2] + vect3w * m2[4, 2] + vect3y * m2[2, 2];
  Result[3, 3]:= vect3w * m2[4, 3] + vect3y * m2[2, 3] + vect3z * m2[3, 3] + vect3x * m2[1, 3];
  Result[3, 4]:= vect3y * m2[2, 4] + vect3z * m2[3, 4] + vect3x * m2[1, 4] + vect3w * m2[4, 4];
  vect4x:= m1[4, 1];
  vect4y:= m1[4, 2];
  vect4z:= m1[4, 3];
  vect4w:= m1[4, 4];
  Result[4, 1]:= vect4w * m2[4, 1] + vect4y * m2[2, 1]+ vect4x * m2[1, 1]+ vect4z * m2[3, 1];
  Result[4, 2]:= vect4z * m2[3, 2] + vect4x * m2[1, 2] + vect4w * m2[4, 2] + vect4y * m2[2, 2];
  Result[4, 3]:= vect4w * m2[4, 3] + vect4y * m2[2, 3] + vect4z * m2[3, 3] + vect4x * m2[1, 3];
  Result[4, 4]:= vect4y * m2[2, 4]+ vect4z * m2[3, 4] + vect4x * m2[1, 4] + vect4w * m2[4, 4];
end;

function MatrXMatr(M1, M2: TMatrix): TMatrix;
var
  i, j, k: Integer;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      Result[i, j] := 0;
      for k := 1 to 4 do
        Result[i, j] := Result[i, j] + m1[i, k] * m2[k, j];
    end;
end;

function MatrXVert(Matrix: TMatrix; V0, V1, V2: Single): Tver;
var
  i, j: Integer;
  b, c: TVector4;
begin
  b[1] := V0;
  b[2] := V1;
  b[3] := V2;
  b[4] := 1;
  //SetLEngth(c,Length(b));
  for i := 1 to 4 do
  begin
    c[i] := 0;
    for j := 1 to 4 do 
      c[i] := c[i] + Matrix[j, i] * b[j];
  end;
  Result[0] := c[1];
  Result[1] := c[2];
  Result[2] := c[3];
end;

procedure TMesh.GetBox(var Box: TBox);
var
  i: Integer;
  //TempBox:Tbox;
  vector: Tver;
  Matrix: TMatrix;
begin
  glPushMatrix();
  glMultMatrixf(@Transform.TrMatrix);
  if not ((SizeBox.Xmax = 0) and (SizeBox.Xmin = 0) and
    (SizeBox.Ymax = 0) and (SizeBox.Ymin = 0) and
    (SizeBox.Zmax = 0) and (SizeBox.Zmin = 0)) then
  begin
    glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);

    with SizeBox do
    begin
      Vector := MatrXVert(Matrix, Xmin, Ymin, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymax, Zmax);
      CalcBox(Box,Vector);
  {    Vector := MatrXVert(Matrix, Xmin, Ymax, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymin, Zmax);
      CalcBox(Box,Vector);

      Vector := MatrXVert(Matrix, Xmin, Ymin, Zmax);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymax, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymin, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmin, Ymax, Zmax);
      CalcBox(Box,Vector);     }
    end;
  end;

  for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      Childs[i].GetBox(Box);
  glPopMatrix();
end;


procedure TMesh.DrawSelectBox(SelectBox: TBox);
var
  Xsize, Ysize, Zsize: Single;
  Border, BordOffset: Single;
  TempSelectBox: TBox;
  procedure DrawTetra(X, Y, Z, Xs, Ys, Zs: Single);
  begin
    glVertex3f(X, Y, Z);
    glVertex3f(X + Xs, Y, Z);
    glVertex3f(X, Y, Z);
    glVertex3f(X, Y + Ys, Z);
    glVertex3f(X, Y, Z);
    glVertex3f(X, Y, Z + Zs);
  end;
begin
  Border := 0.3;
  BordOffset := 0.1;

  Xsize := (SelectBox.Xmax - SelectBox.Xmin) * Border;
  Ysize := (SelectBox.Ymax - SelectBox.Ymin) * Border;
  Zsize := (SelectBox.Zmax - SelectBox.Zmin) * Border;
  //  end;
  TempSelectBox.Xmin := SelectBox.Xmin - Xsize * BordOffset;
  TempSelectBox.Ymin := SelectBox.Ymin - Ysize * BordOffset;
  TempSelectBox.Zmin := SelectBox.Zmin - Zsize * BordOffset;
  TempSelectBox.Xmax := SelectBox.Xmax + Xsize * BordOffset;
  TempSelectBox.Ymax := SelectBox.Ymax + Ysize * BordOffset;
  TempSelectBox.Zmax := SelectBox.Zmax + Zsize * BordOffset;
  //  glPushMatrix;
  //  glScalef(Size.X, Size.Y, Size.Z);
  glPushAttrib(GL_COLOR_MATERIAL);
  glDisable(GL_LIGHTING);
  with TempSelectBox do
  begin
    glColor3f(1, 1, 1);
    glBegin(GL_LINES);
    DrawTetra(Xmin, Ymin, Zmin, Xsize, Ysize, Zsize);
    DrawTetra(Xmax, Ymax, Zmax, - Xsize, - Ysize, - Zsize);

    DrawTetra(Xmin, Ymax, Zmin, Xsize, - Ysize, Zsize);
    DrawTetra(Xmax, Ymin, Zmax, - Xsize, Ysize, - Zsize);

    DrawTetra(Xmin, Ymin, Zmax, Xsize, Ysize, - Zsize);
    DrawTetra(Xmax, Ymax, Zmin, - Xsize, - Ysize, Zsize);

    DrawTetra(Xmax, Ymin, Zmin, - Xsize, Ysize, Zsize);
    DrawTetra(Xmin, Ymax, Zmax, Xsize, - Ysize, - Zsize);
    glEnd;
  end;
  glEnable(GL_LIGHTING);
  glPopAttrib;
  //  glPopMatrix;
end;



procedure TMesh.DrawCamera();
const
  camera_vertex: array[0..23] of GlFloat = (-0.40200000,0.34220000,0.0000000e+0,0.0000000e+0,0.57620000,0.0000000e+0,0.40200000,0.34220000,0.0000000e+0,-0.40200000,0.34220000,0.0000000e+0,0.40200000,0.34220000,0.0000000e+0,0.0000000e+0,0.0000000e+0,-0.80410000,0.40200000,-0.30150000,0.0000000e+0,-0.40200000,-0.30150000,0.0000000e+0);
  camera_indices: array[0..23] of Word = (1,2,0,3,7,4,4,5,3,4,6,5,4,7,6,5,7,3,6,7,5,1,2,0);
begin
  glPushAttrib(GL_COLOR_MATERIAL);
  glDisable(GL_LIGHTING);
  glColor3f(1, 0.5, 0);
  glVertexPointer(3, GL_FLOAT, 0, @camera_vertex);
  glDrawElements(GL_LINE_LOOP, Length(camera_indices), GL_UNSIGNED_SHORT, @camera_indices);
  glEnable(GL_LIGHTING);
  glPopAttrib;
end;

procedure TMesh.DrawSpawn();
const
  spawn_vertex: array[0..47] of GLfloat = (9.2550000e-2,0.26811800,7.5000000e-5,-9.2550000e-2,0.26811800,7.5000000e-5,0.0000000e+0,0.39021100,7.5000000e-5,0.0000000e+0,0.15433000,0.22306000,7.8350000e-2,7.4206000e-2,-2.0750000e-3,7.8350000e-2,0.23445500,-2.0750000e-3,-7.8350000e-2,7.4206000e-2,-2.0750000e-3,-7.8350000e-2,0.23445500,-2.0750000e-3,3.4025000e-2,0.11953500,-9.2450000e-3,3.4025000e-2,0.18912600,-9.2450000e-3,-3.4025000e-2,0.11953500,-9.2450000e-3,-3.4025000e-2,0.18912600,-9.2450000e-3,3.4025000e-2,0.11953500,-0.19326200,3.4025000e-2,0.18912600,-0.19326200,-3.4025000e-2,0.11953500,-0.19326200,-3.4025000e-2,0.18912600,-0.19326200);
  spawn_indices: array[0..68] of GLushort = (0,2,1,3,6,4,3,7,6,4,5,3,4,9,5,4,10,8,5,7,3,5,9,7,6,10,4,7,9,11,7,10,6,8,9,4,8,12,9,9,12,13,9,15,11,10,12,8,10,15,14,11,10,7,11,15,10,12,14,13,13,15,9,14,12,10,14,15,13);
begin
    glPushAttrib(GL_COLOR_MATERIAL);
    glDisable(GL_LIGHTING);
    glColor3f(0.0, 1.0, 0.0);
    glVertexPointer(3, GL_FLOAT, 0, @spawn_vertex);
    glDrawElements(GL_LINE_LOOP, Length(spawn_indices), GL_UNSIGNED_SHORT, @spawn_indices);
    glEnable(GL_LIGHTING);
    glPopAttrib;
end;

function TMesh.GetMeshOfName(ObjName:String):TMesh;
var i:integer;
begin
Result:=nil;
If Name=ObjName then begin
 Result :=Self; exit;
 end;
  for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      begin
      Result:=Childs[i].GetMeshOfName(ObjName);
      if Result<>nil then exit;
      end;
end;

function TMesh.GetMeshAtomic: TMesh;
var i:integer;
begin
Result:=nil;
  for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      if Childs[i].ChName='AM' then begin
       Result :=Childs[i]; break;
      end;
end;

function TMesh.GetMeshGroupId(mesh_id: Integer): TMesh;
var i:integer;
Atomic:TMesh;
begin
  Result:=nil;
  Atomic:=GetMeshAtomic;
  if (Atomic<>nil) and
    (Length(Atomic.Childs)>0) and
    (Atomic.Childs[0]<>nil) then
    begin
      if (mesh_id<Length(Atomic.Childs[0].Childs)) and
        (Atomic.Childs[0].Childs[mesh_id] <> nil) then
        Result:=Atomic.Childs[0].Childs[mesh_id];
    end;
end;

function TMesh.GetMeshOfID(Id:Integer):TMesh;
var i:integer;
begin
Result:=nil;
If Indx=Id then begin
 Result :=Self; exit;
 end;
  for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      begin
      Result:=Childs[i].GetMeshOfID(Id);
      if Result<>nil then exit;
      end;
end;

//
procedure VertAdd(var Ver:TVer; Norm:Tver);
  begin
    Ver[0]:=Ver[0]+Norm[0];
    Ver[1]:=Ver[1]+Norm[1];
    Ver[2]:=Ver[2]+Norm[2];
  end;

function CreateVector(A, B: TVer): TVer;
  begin
    Result[0] := B[0] - A[0];
    Result[1] := B[1] - A[1];
    Result[2] := B[2] - A[2];
  end;

function VectorProduct(A, B: TVer): TVer;
  begin
    Result[0] := A[1] * B[2] - B[1] * A[2];
    Result[1] := A[2] * B[0] - B[2] * A[0];
    Result[2] := A[0] * B[1] - B[0] * A[1];
  end;

function GetLength(pn:Tver):Real;
  begin
    Result:=Sqrt(pn[0] * pn[0] + pn[1] * pn[1] + pn[2] * pn[2]);
  end;

procedure Normalise(var pn: Tver);
  var
  Length: Real;
  begin
    Length := GetLength(pn);
    pn[0] := pn[0] / Length;
    pn[1] := pn[1] / Length;
    pn[2] := pn[2] / Length;
  end;


function GenNormal(idx:integer;Face:AFace;Vert:AVer):Tver;
  var
  new_normal,n,axis_x,axis_y,axis_z,pa,pb,pc:Tver;
  m,object_to_world: TMatrix;
  begin
    pa:=Vert[Face[idx][0]];
    pb:=Vert[Face[idx][1]];
    pc:=Vert[Face[idx][2]];
    axis_x:= CreateVector(pa,pb);
    axis_y:= CreateVector(pa,pc);
    n:= VectorProduct(axis_x,axis_y);
    Normalise(n);
    result:=n;
  end;
//

function GetMatrix(Pos, Rot, Size: Tver): TMatrix;
begin
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glTranslatef(Pos[0], Pos[1], Pos[2]);
  glRotatef(Rot[2], 0, 0, 1);//Z
  glRotatef(Rot[1], 0, 1, 0);//y
  glRotatef(Rot[0], 1, 0, 0);//x
  glScalef(Size[0], Size[1], Size[2]);
  glGetFloatv(GL_MODELVIEW_MATRIX, @Result);
end;

function GetMatrix2(Pos, Rot1, Rot2, Rot3, Size: Tver): TMatrix;
begin
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glTranslatef(Pos[0], Pos[1], Pos[2]);

  glRotatef(RadToDeg(Rot1[2]), 0, 0, 1); //Z
  glRotatef(RadToDeg(Rot1[1]), 0, 1, 0); //y
  glRotatef(RadToDeg(Rot1[0]), 1, 0, 0); //X

  glRotatef(RadToDeg(Rot2[2]), 0, 0, 1);//Z
  glRotatef(RadToDeg(Rot2[1]), 0, 1, 0);//y
  glRotatef(RadToDeg(Rot2[0]), 1, 0, 0);//X

  glRotatef(RadToDeg(Rot3[2]), 0, 0, 1);//Z
  glRotatef(RadToDeg(Rot3[1]), 0, 1, 0);//y
  glRotatef(RadToDeg(Rot3[0]), 1, 0, 0);//X
  glScalef(Size[0], Size[1], Size[2]);  //??????
  glGetFloatv(GL_MODELVIEW_MATRIX, @Result);

end;

procedure MatrixDecompose(XMatrix: TMatrix; var XPos: Tver;
  var XRot: Tver; var XSize: Tver);
var
  angle_x, angle_y, angle_z, D, C, trx, tr_y: Real;
  mat: array [0..15] of Real;
begin
  XPos[0] := XMatrix[4][1];
  XPos[1] := XMatrix[4][2];
  XPos[2] := XMatrix[4][3];
  XSize[0] := Sqrt(Sqr(XMatrix[1][1]) + Sqr(XMatrix[1][2]) + Sqr(XMatrix[1][3]));
  XSize[1] := Sqrt(Sqr(XMatrix[2][1]) + Sqr(XMatrix[2][2]) + Sqr(XMatrix[2][3]));
  XSize[2] := Sqrt(Sqr(XMatrix[3][1]) + Sqr(XMatrix[3][2]) + Sqr(XMatrix[3][3]));

  mat[0] := XMatrix[1][1] / XSize[0];
  mat[1] := XMatrix[1][2] / XSize[0];
  mat[2] := XMatrix[1][3] / XSize[0];

  mat[4] := XMatrix[2][1] / XSize[1];
  mat[5] := XMatrix[2][2] / XSize[1];

  mat[6] := XMatrix[2][3] / XSize[1];
  mat[10] := XMatrix[3][3] / XSize[2];
  D := -arcsin(mat[2]);
  angle_y := D;   //     /* Calculate Y-axis angle */
  C := Cos(angle_y);
  angle_y := angle_y * RADIANS;

  if (Abs(C) > 0.005) then         //   /* Gimball lock? */
  begin
    trx  := mat[10] / C;           //* No, so get X-axis angle */
    tr_y := -mat[6] / C;

    angle_x := ArcTan2(tr_y, trx) * RADIANS;

    trx  := mat[0] / C;            //* Get Z-axis angle */
    tr_y := -mat[1] / C;

    angle_z := ArcTan2(tr_y, trx) * RADIANS;
  end
  else                                 //* Gimball lock has occurred */
  begin
    angle_x := 0;                      //* Set X-axis angle to zero */

    trx  := mat[5];                 //* And calculate Z-axis angle */
    tr_y := mat[4];

    angle_z := ArcTan2(tr_y, trx) * RADIANS;
  end;
  //--------------
  XRot[0] := -angle_x;
  XRot[1] := angle_y;
  XRot[2] := -angle_z;
end;

procedure glLoadCombine;
begin
glPushAttrib(GL_TEXTURE_BIT or GL_EVAL_BIT);

{$IFDEF NOMULTI}
  glActiveTextureARB(GL_TEXTURE0);
  glEnable(GL_TEXTURE_2D);
  // Simply sample the texture
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
  // --------------------
  glActiveTextureARB(GL_TEXTURE1);
  glEnable(GL_TEXTURE_2D);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
{$ENDIF}
end;

Procedure glLoadMulti;
begin
glPushAttrib(GL_TEXTURE_BIT or GL_EVAL_BIT);

{$IFDEF NOMULTI}
   glActiveTextureARB(GL_TEXTURE1    );
   glEnable          (GL_TEXTURE_2D      );

   glTexEnvi         (GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE ,GL_COMBINE    );
   glTexEnvi         (GL_TEXTURE_ENV,GL_COMBINE_RGB  ,GL_REPLACE        );

   glActiveTextureARB(GL_TEXTURE0    );
   glEnable          (GL_TEXTURE_2D      );

   glTexEnvi         (GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE ,GL_COMBINE    );
   glTexEnvi         (GL_TEXTURE_ENV,GL_COMBINE_RGB  ,GL_INTERPOLATE);

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE0_RGB,  GL_TEXTURE1      );
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND0_RGB, GL_SRC_COLOR    );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE1_RGB,  GL_TEXTURE);
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND1_RGB, GL_SRC_COLOR );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE2_RGB,  GL_PRIMARY_COLOR);
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND2_RGB, GL_SRC_ALPHA    );

   glActiveTextureARB(GL_TEXTURE1   );
   glEnable          (GL_TEXTURE_2D      );

   glTexEnvi         (GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE ,GL_COMBINE    );
   glTexEnvi         (GL_TEXTURE_ENV,GL_COMBINE_RGB  ,GL_MODULATE        );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE0_RGB,  GL_PREVIOUS      );
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND0_RGB, GL_SRC_COLOR    );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE1_RGB,   GL_PRIMARY_COLOR);
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND1_RGB, GL_SRC_COLOR );
{$ENDIF}
end;

Procedure glUnLoadMulti(TextNum:integer);
var i:integer;
begin
TextNum:=1;
for i:=0 to TextNum-1 do begin
{$IFDEF NOMULTI}
      glClientActiveTextureARB (GL_TEXTURE0 + i);
{$ENDIF}
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
end;
glPopAttrib;
end;

procedure TMesh.Draw(DrawType: TDrawType);
label
  ToChilds,
  normal2,
  DrawMesh;
var
  i, j, ActChild, NormalLen, FaceNum, VCount, BCount: Integer;
  Matrix, invMatrix: TMatrix;
  point31, point32, BVert: Tver;
  AnimInfo: TAnimInfo;
    PushMatrix,VMatrix: TMatrix; MaxZoom:Single;
  TextNum: integer;
  Model:TMesh;
{  procedure glPushAttrib(mask: GLbitfield);
  begin

  end;
  procedure glPopAttrib;
  begin

  end;}
begin     // кидаем в стек текущую матрицу
  if GLError or Hide then exit;
  if (floors and $8000)>0 then begin
   if (CurrentFloor=0) then goto DrawMesh
   else exit;
  end;
  if (floors>0) and ((XType = 'SK') or (XType = 'SH') or (XType = 'SS')
  or (XType = 'CL')or (XType = 'ZN')) and (CurrentFloor>-1) then begin
    if not CheckFloor then Exit;
  end;
  DrawMesh:
//  if not But.Zones^ and (XType='ZS') then exit;
   glGetFloatv(GL_MODELVIEW_MATRIX,@PushMatrix);

  if (DrawType = DrGenAnim) then
   begin
      AnimInfo.isVisible:=False;
      AnimInfo.TCoord:=nil;
      AnimInfo.mesh_id:=0;
      AnimInfo.Tm:=Transform.TrMatrix;
       if AnimReady and ((XType = 'BG') or (XType = 'GR')) and (But.AnimButton^) then
       AnimInfo:=CurAnimClip.GenAnimFrame(Hash, Transform);
       if AnimInfo.isVisible then begin
         Model:=GetMeshAtomic;
         if Model<>nil then Model.Hide:=AnimInfo.Visible;
       end;
       if AnimInfo.TCoord<>nil then begin
           Model:=GetMeshGroupID(AnimInfo.mesh_id);
           if (Model<>nil) then begin
              Model.AnimTCoord:=AnimInfo.TCoord;
              Model.isAnimT:=true;
           end;
       end;
       AnimMatrix:=AnimInfo.Tm;
       glMultMatrixf(@AnimInfo.Tm);
       if (XType = 'BG') then  glGetFloatv(GL_MODELVIEW_MATRIX, @BoneMatrix);
       goto ToChilds;
   end;

//  if AnimReady and (But.AnimButton^ or But.EditAnimBut^) then
 //       AnimInfo:=CurAnimClip.GenAnimFrame(Hash, Transform, XType = 'BG',SelectObj = Indx);

  if (DrawType = DrBone) then
  begin
    if (XType = 'BO') then
      glCallList(objAxes);
    if (XType = 'BG') then
    begin
      glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);
      point31 := MatrXVert(Matrix, 0, 0, 0);
      //  glDepthMask(GL_FALSE);
    end;
  end;
  glMultMatrixf(@AnimMatrix);

    if (XType = 'WP') and (CurrentFloor>-1) then
    begin
       glGetFloatv(GL_MODELVIEW_MATRIX, @VMatrix);
        if (not CheckFloorHeight(VMatrix[4][2])) then
            goto ToChilds;
    end;

  if (DrawType = DrBone) then
  begin
    if (XType = 'BG') then
    begin
      //  glColor3f(0.1, 0.8, 0.1);
      glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);
      point32 := MatrXVert(Matrix, 0, 0, 0);
      glDisable(GL_LIGHTING);
      glColor3f(1, 1, 1);
      glPointSize(6);
      glBegin(GL_POINTS);
      glVertex3f(0, 0, 0);
      glEnd;
      glPushMatrix();
      glLoadIdentity();
      glBegin(GL_Lines);
      glVertex3f(point31[0], point31[1], point31[2]);
      glVertex3f(point32[0], point32[1], point32[2]);
      glEnd;
      glPopMatrix();
    end;
  end;

  //if (XType = 'BO') then goto
  if (SelectObj = Indx) and (Indx<>0) then
   begin
     ActiveMesh:= Self;
     glPushMatrix;
     with SizeBox do
      begin
        glTranslatef((Xmin+(Xmax - Xmin)/2),(Ymin+(Ymax - Ymin)/2),(Zmin+(Zmax - Zmin)/2));
        glGetFloatv(GL_MODELVIEW_MATRIX, @VMatrix);
        //glPopMatrix;

        TVModel.Xpos := -VMatrix[4][1];
        TVModel.Ypos := -VMatrix[4][2];
        TVModel.Zpos := -VMatrix[4][3];

          MaxZoom := Max((Xmax - Xmin), (Ymax - Ymin));
          MaxZoom := Max(MaxZoom, (Zmax - Zmin));
          TVModel.zoom := MaxZoom * 3;
        //  TVModel.xrot := -20.0;
        //  TVModel.Per := 35.0;
      end;
     glPopMatrix;
 end;

  if (DrawType = DrBoxes) and (Transform.TransType <> TTNone) then
  begin
      glDisable(GL_LIGHTING);
      glColor3f(0.0, 1.0, 0.0);
      if ActiveMesh=Self  then
      glColor3f(1.0, 0.0, 0.0);
      glPointSize(8);
      glBegin(GL_POINTS);
      glVertex3f(0, 0, 0);
      glEnd;
  end;

  if (DrawType = DrSelect) and (Attribute.ZBuffer)   then
  begin
      glDisable(GL_LIGHTING);
    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);
    glDepthFunc(GL_NEVER + Attribute.ZBufferFuncVal);
      glDepthMask(GL_TRUE);
    if Attribute.CullFace then
      glEnable(GL_CULL_FACE)
    else
      glDisable(GL_CULL_FACE);
      glColor4_256(Indx);
    if (XType = 'WP') or  (XType = 'LT') or (XType = 'EM') then
       glCallList(objLight);

    if (Length(Face) <> 0) and (Length(Vert)<>0) and (XType<>'NM') then begin
      
      glDisableClientState(GL_EDGE_FLAG_ARRAY);
      glDisableClientState(GL_INDEX_ARRAY);
      glClientActiveTextureARB (GL_TEXTURE0);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glClientActiveTextureARB (GL_TEXTURE1);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glClientActiveTextureARB (GL_TEXTURE2);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glDisableClientState(GL_COLOR_ARRAY);
      glDisableClientState(GL_NORMAL_ARRAY);
      glEnableClientState(GL_VERTEX_ARRAY);
      if (XType = 'SS') and (Weight <> nil) and (Length(Bones)>0) then
      begin
        glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);
        invMatrix:=MatrixInvert(Matrix);
        VCount := Length(Vert);
        for i := 0 to VCount - 1 do
        begin
          RVert[i] := ZereVector;
          BCount := Length(Bones);
          for j := 0 to BCount - 1 do
          begin
            BVert := MatrXVert(MatrXMatr(Bones[j].InvBoneMatrix,
              MatrXMatr(Bones[j].BoneMatrix,invMatrix)),
               Vert[i][0], Vert[i][1], Vert[i][2]);
            //  BVert:= MatrXVert(Bones[j].BoneMatrix, Vert[i][0],Vert[i][1],Vert[i][2]);
            RVert[i] := VertAddVert(RVert[i],
              ValXVert(Weight[i][j], BVert));
          end;
        end;

        glVertexPointer(3, GL_FLOAT, 0, RVert);
      end

      else
        glVertexPointer(3, GL_FLOAT, 0, Vert);
      FaceNum := Length(Face);
      for j := 0 to FaceNum - 1 do
          glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, @Face[j]);
      end;
  end;

  if ((DrawType = DrBlend) and not Attribute.ZBuffer) or
    ((DrawType = DrMesh) and (Attribute.ZBuffer))then
  begin
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_LIGHTING);
    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);
    if ((But.DrawBoxes^) or ((SelectObj = Indx) and (Indx<>0)))
    and ((XType = 'SH') or (XType = 'SS')) then
      DrawSelectBox(SizeBox);

    glEnable(GL_LIGHTING);

    glDepthFunc(GL_NEVER + Attribute.ZBufferFuncVal);

    if Attribute.ZBuffer then
      glDepthMask(GL_TRUE)
    else
      glDepthMask(GL_FALSE);

    if Attribute.CullFace then
      glEnable(GL_CULL_FACE)
    else
      glDisable(GL_CULL_FACE);

 //   if not Attribute.Multi then
   //  glEnable(GL_BLEND);

    if Attribute.AlphaTest then
    begin
      glEnable(GL_ALPHA_TEST);
  //    glDisable(GL_BLEND);
      glAlphaFunc(GL_NEVER + Attribute.AlphaFunc, Attribute.AlphaFuncVal);
    end
    else
      glDisable(GL_ALPHA_TEST);

    if Attribute.Blend then
    begin
           glEnable(GL_BLEND);
      glBlendFunc(BlendVal[Attribute.BlendVal1], BlendVal[Attribute.BlendVal2]);
    end
    else begin glDisable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    end;

    glColor3f(1.0, 1.0, 1.0);
    if Attribute.Polygon=2 then glShadeModel(GL_SMOOTH)
    else glShadeModel(GL_FLAT);

    glPushAttrib(GL_COLOR_MATERIAL);
    if Attribute.Material.use then
      with Attribute.Material do
      begin  glDisable(GL_COLOR_MATERIAL); // ???
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, @Dif);
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @Dif);
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @Spe);
     //   glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, @Emi);
        glMaterialf(GL_FRONT_AND_BACK,GL_SHININESS,Shi);
      end;

    if (XType = 'WP') then begin
       if But.WpNames^ then
       begin
        if ColorIndx = 19  then// CAM_TARGET
          DrawCamera()
        else
          DrawSpawn();
        glxDrawBitmapText(But.Canvas, 0, 0, 0, BbitPoint2, Name, false);
       end
       else
       begin
        glxDrawBitmapText(But.Canvas, 0, 0, 0, BbitPoint2, '', false);
       end;
    end;

    if (XType = 'EM') then
    begin
      DrawSelectBox(SizeBox);
      glxDrawBitmapText(But.Canvas, 0, 0, 0, EmittPoint, '', false);
    end;

  if (XType = 'NM') then
  begin

      glLineWidth(2);
      glDisable(GL_LIGHTING);
     // glDisable(GL_DEPTH_TEST);
      glColor3f(1, 0, 0);
      i:=0;
      While i<Length(Face)-1 do begin
        while Face[i][0]<>$ffff do begin
         if (CheckFloorHeight(Vert[Face[i][0]][1]) or
            CheckFloorHeight(Vert[Face[i][1]][1])) then begin
           glBegin(GL_LINE_STRIP);
           glVertex3fv(@Vert[Face[i][0]][0]);
           glVertex3fv(@Vert[Face[i][1]][0]);
           glEnd;
         end;
         Inc(i);
        end;
         Inc(i);
      end;
      glLineWidth(1);
      glEnable(GL_LIGHTING);
      glColor3f(0.8, 0.8, 1);
       for i:=0 to Length(Vert)-1 do begin
         if not CheckFloorHeight(Vert[i][1]) then Continue;
         glPushMatrix;
         glTranslate(Vert[i][0], Vert[i][1], Vert[i][2]);
         glCallList(objBox);
       // glxDrawBitmapText(But.Canvas, Vert[i][0], Vert[i][1], Vert[i][2], BbitPoint2, Format('%d',[i]), false);
         glPopMatrix;
      end;


  end;

    if (XType = 'LT') then
    begin
       glDisable(GL_LIGHTING);
       glColor4fv(@Attribute.Light);
       glCallList(objLight);
    end;

    if (Length(Face) <> 0) and (Length(Vert)<>0) and (XType<>'NM') then
    begin
      NormalLen := Length(Normal);
      FaceNum := Length(Face);

      if NormalLen = 0 then
        glDisable(GL_LIGHTING);

    glDisableClientState(GL_EDGE_FLAG_ARRAY);
    glDisableClientState(GL_INDEX_ARRAY);
    TextNum:=0;
    AnimInfo.TCoord:=TextCoord;
    if AnimReady and (But.AnimButton^) and
        isAnimT and (AnimTCoord<>nil) then
           AnimInfo.TCoord:=AnimTCoord;
    if ((Attribute.Texture <> 0) and true) then
    begin

      glClientActiveTextureARB (GL_TEXTURE0);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glClientActiveTextureARB (GL_TEXTURE1);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glClientActiveTextureARB (GL_TEXTURE2);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);

      glEnable(GL_TEXTURE_2D);
      if Attribute.Multi then begin
        glPushAttrib(GL_TEXTURE_BIT or GL_EVAL_BIT);
    {$IFDEF NOMULTI}

        glActiveTextureARB(GL_TEXTURE0);
        glEnable(GL_TEXTURE_2D);
        glBindTexture     (GL_TEXTURE_2D, Attribute.MultiT1);
        glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);

     if (Attribute.MultiT2>0)  then begin
        glActiveTextureARB(GL_TEXTURE1);
        glEnable(GL_TEXTURE_2D);
        glBindTexture     (GL_TEXTURE_2D, Attribute.MultiT2);
        glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
        glTexEnvi(GL_TEXTURE_ENV, GL_COMBINE_RGB, GL_INTERPOLATE);    // Interpolate RGB with RGB
        glTexEnvi(GL_TEXTURE_ENV, GL_SOURCE0_RGB, GL_TEXTURE);
        glTexEnvi(GL_TEXTURE_ENV, GL_SOURCE1_RGB, GL_PREVIOUS);
        glTexEnvi(GL_TEXTURE_ENV, GL_SOURCE2_RGB, GL_TEXTURE);
        glTexEnvi(GL_TEXTURE_ENV, GL_OPERAND0_RGB, GL_SRC_COLOR);
        glTexEnvi(GL_TEXTURE_ENV, GL_OPERAND1_RGB, GL_SRC_COLOR);
        glTexEnvi(GL_TEXTURE_ENV, GL_OPERAND2_RGB, GL_SRC_ALPHA);
        // --------------------
        glTexEnvi(GL_TEXTURE_ENV, GL_COMBINE_ALPHA, GL_INTERPOLATE);    // Interpolate ALPHA with ALPHA
        glTexEnvi(GL_TEXTURE_ENV, GL_SOURCE0_ALPHA, GL_TEXTURE);
        glTexEnvi(GL_TEXTURE_ENV, GL_SOURCE1_ALPHA, GL_PREVIOUS);
        glTexEnvi(GL_TEXTURE_ENV, GL_SOURCE2_ALPHA, GL_TEXTURE);
        glTexEnvi(GL_TEXTURE_ENV, GL_OPERAND0_ALPHA, GL_SRC_ALPHA);
        glTexEnvi(GL_TEXTURE_ENV, GL_OPERAND1_ALPHA, GL_SRC_ALPHA);
        glTexEnvi(GL_TEXTURE_ENV, GL_OPERAND2_ALPHA, GL_SRC_ALPHA);
       end;

       if (Attribute.MultiT3>0) and But.ShowLight^  then begin
        glActiveTextureARB(GL_TEXTURE2);
        glEnable(GL_TEXTURE_2D);
        glBindTexture     (GL_TEXTURE_2D, Attribute.MultiT3);
        glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
       end;
        // enableArray
        glClientActiveTextureARB (GL_TEXTURE0);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glTexCoordPointer(2, GL_FLOAT, 0, AnimInfo.TCoord);
        Inc(TextNum);

        if (Attribute.MultiT2>0) then begin
        glClientActiveTextureARB (GL_TEXTURE1);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glTexCoordPointer(2, GL_FLOAT, 0, TextCoord2);
        Inc(TextNum);
        end;


        if (Attribute.MultiT3>0) and But.ShowLight^  then begin
        glClientActiveTextureARB (GL_TEXTURE2);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        if TextCoordN<>nil then
        glTexCoordPointer(2, GL_FLOAT, 0, TextCoordN)
        else
        glTexCoordPointer(2, GL_FLOAT, 0, TextCoord2);
        Inc(TextNum);
        end;

      end
      else  begin
        glClientActiveTextureARB (GL_TEXTURE0);
    {$ENDIF}
        glBindTexture(GL_TEXTURE_2D, Attribute.Texture);
        Inc(TextNum);
        if TextCoord<>nil then begin
          glEnableClientState(GL_TEXTURE_COORD_ARRAY);
          glTexCoordPointer(2, GL_FLOAT, 0, AnimInfo.TCoord);
        end;
      end;

    end
    else begin
     {$IFDEF NOMULTI}
      glClientActiveTextureARB (GL_TEXTURE0);
     {$ENDIF}
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glClientActiveTextureARB (GL_TEXTURE1);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glClientActiveTextureARB (GL_TEXTURE2);
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      end;

      if (Length(Color) <> 0) and
        (Cardinal(Pointer(@Color[0])^) <> $FF000000) then
      begin
        glEnableClientState(GL_COLOR_ARRAY);
        glColorPointer(4, GL_UNSIGNED_BYTE, 0, Color);
      end else
      if (Length(ColorF) <> 0)and
        ((ColorF[0][0]<>0.0)and (ColorF[0][1]<>0.0)and (ColorF[0][2]<>0.0)) then
      begin
        glEnableClientState(GL_COLOR_ARRAY);
        glColorPointer(4, GL_FLOAT, 0, ColorF);
      end
        else
      glDisableClientState(GL_COLOR_ARRAY);

      if NormalLen <> 0 then
      begin
        glEnableClientState(GL_NORMAL_ARRAY);
        glNormalPointer(GL_FLOAT, 0, Normal);
      end
      else
        glDisableClientState(GL_NORMAL_ARRAY);

      if Length(Vert)<>0 then begin
      glEnableClientState(GL_VERTEX_ARRAY);

      if (XType = 'SS') and (Weight <> nil) and (Length(Bones)>0) then
      begin
        glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);
        invMatrix:=MatrixInvert(Matrix);
        VCount := Length(Vert);
        for i := 0 to VCount - 1 do
        begin
          RVert[i] := ZereVector;
          BCount := Length(Bones);
          for j := 0 to BCount - 1 do
          begin
            BVert := MatrXVert(MatrXMatr(Bones[j].InvBoneMatrix,
              MatrXMatr(Bones[j].BoneMatrix,invMatrix)),
               Vert[i][0], Vert[i][1], Vert[i][2]);
            //  BVert:= MatrXVert(Bones[j].BoneMatrix, Vert[i][0],Vert[i][1],Vert[i][2]);
            RVert[i] := VertAddVert(RVert[i],
              ValXVert(Weight[i][j], BVert));
          end;
        end;

        glVertexPointer(3, GL_FLOAT, 0, RVert);
      end

      else
        glVertexPointer(3, GL_FLOAT, 0, Vert);

      end;
      if (XType='CL') then begin
        glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
        for j := 0 to FaceNum - 1 do
           glDrawElements(GL_LINE_LOOP, 4, GL_UNSIGNED_SHORT, @Face[j]);
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        glPushAttrib(GL_ENABLE_BIT);
        glDisable(GL_CULL_FACE);
        glEnable(GL_POLYGON_OFFSET_FILL);
        glDisable(GL_DEPTH_TEST);
        glEnable(GL_BLEND);
        glBlendFunc(GL_ONE_MINUS_SRC_ALPHA, GL_SRC_ALPHA);
        glcolor4f(1.0, 1.0, 1.0, 0.8);
        for j := 0 to FaceNum - 1 do
           glDrawElements(GL_QUADS, 4, GL_UNSIGNED_SHORT, @Face[j]);
        glPopAttrib;
      end else begin

        try
        for j := 0 to FaceNum - 1 do
          glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, @Face[j]);
        except
          GLErrorCode:=glGetError;
          GLError:=true;

          exit;
        //
        end;

      end;

      //   if NormalLen=0 then
      glEnable(GL_LIGHTING);
      glDisable(GL_BLEND);
      if Attribute.Multi then glUnLoadMulti(TextNum);
      glDisable(GL_TEXTURE_2D);

      glDepthFunc(GL_LESS);
    end;
    glPopAttrib();
  end;
  ToChilds:

  for i := 0 to High(Childs) do
  begin
    if Childs[i] <> nil then
      Childs[i].Draw(DrawType);
  end;

  glLoadMatrixf(@PushMatrix);  // возвращаем текущую матрицу

end;


procedure TMesh.glLoad2DMipmaps(target: GLenum;
  Components, Width, Height: GLint; Format, atype: GLenum; Data: Pointer);
var
  i: Integer;
begin
  for i := 0 to 10 do
  begin
    if (Width=0) then Width := 1;
    if (Height=0) then Height := 1;
    glTexImage2D(target, i, Components, Width, Height, 0, Format, atype, Data);
    Inc(Longword(Data), (Width * Height * Components));
    if ((Width = 1) and (Height = 1)) then
      Break;
    Width  := Width div 2;
    Height := Height div 2;
  end;
end;

procedure TMesh.GetTextureGL(matobj:TObject);
var
  IFormat, IComponents, IRepeat: Integer;
  mat:TMaterialObj;
  i:integer;
begin
  mat:=TMaterialObj(matobj);
  for i:=0 to 2 do
    if mat.Texture[i].Texture<>nil then begin
      with mat.Texture[i].Texture do begin
        case i of
        0: begin
        Attribute.Texture:=mat.T1;
        Attribute.MultiT1:=mat.T1;
        end;
        1: begin
          Attribute.MultiT2:=mat.T2;
        end;
        2: begin
          Attribute.MultiT3:=mat.T3;
        end;
        end;
      end;
   end;
end;

procedure  TMesh.InitSizeBox;
begin
  with   SizeBox do
  begin
    Xmax := -MaxSingle;
    Xmin := MaxSingle;
    Ymax := -MaxSingle;
    Ymin := MaxSingle;
    Zmax := -MaxSingle;
    Zmin := MaxSingle;
  end;
end;

procedure TMesh.CalcBox(var Box:TBox; const Ver:TVer);
begin
    with Box do
    begin
      if Ver[0] > Xmax then Xmax := Ver[0];
      if Ver[0] < Xmin then Xmin := Ver[0];
      if Ver[1] > Ymax then Ymax := Ver[1];
      if Ver[1] < Ymin then Ymin := Ver[1];
      if Ver[2] > Zmax then Zmax := Ver[2];
      if Ver[2] < Zmin then Zmin := Ver[2];
    end;
end;

procedure TMesh.CalcSizeBox(Const Ver:TVer);
begin
    CalcBox(SizeBox,Ver);
end;


destructor TMesh.Destroy;
var
  i: Integer;
begin
  Vert := nil;
  RVert := nil;
 // DPos := nil;
  for i := 0 to Length(Weight) - 1 do
    Weight[i] := nil;
  Weight := nil;
  Face := nil;
  Normal := nil;
  TextCoord := nil;
  TextCoord2 := nil;
  Color := nil;
  ColorF := nil;
  for i := 0 to Length(Childs) - 1 do begin
    Childs[i].Free;
    Childs[i]:=nil;
    end;
  Childs := nil;
  Bones := nil;
  inherited Destroy;
end;


function Color256_4(color4: color4d): Cardinal;
var
RGBA:Cardinal;
begin
  RGBA:=0;
  RGBA := RGBA or (round(color4[3]*255) and $ff);
  RGBA := RGBA shl 8;
  RGBA := RGBA or (round(color4[2]*255) and $ff);
  RGBA := RGBA shl 8;
  RGBA := RGBA or (round(color4[1]*255) and $ff);
  RGBA := RGBA shl 8;
  RGBA := RGBA or (round(color4[0]*255) and $ff);
  result:=RGBA;
end;

function Color4_256(RGBA:Cardinal): color4d;
begin
  result[0] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  result[1] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  result[2] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  result[3] := (RGBA and $ff) / 255.0;
end;

procedure glColor4_256(RGBA: Cardinal);
var
  color4: color4d;
begin
  color4 := Color4_256(RGBA);
  glColor4fv(@color4);
end;

procedure glxDrawBitmapText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; bitPoint2: Pointer;
  Name: string; select: Boolean);
var
  vp: TGLVectori4;
  PMatrix, MvMatrix: TGLMatrixd4;
  wtx, wty, wtz: GLdouble;
  Len: Integer;
begin
  // получаем координаты плоскости паралельной экрану
  glGetIntegerv(GL_VIEWPORT, @vp);
  glGetDoublev(GL_MODELVIEW_MATRIX, @MvMatrix);
  glGetDoublev(GL_PROJECTION_MATRIX, @PMatrix);
  gluProject(wdx, wdy, wdz, MvMatrix, PMatrix, vp,
    @wdx, @wdy, @wdz);
  // если выбор активен тогда рисуем прямоугольник на месте иконки и текста
  if select then
  begin
    glBegin(GL_QUADS);
    // учитываем длинну текста если он есть
  {  if not MainForm.HideName1.Checked then
      Len := MainForm.Canvas.TextWidth(Name) div 2
    else
      Len := 0;   }
      Len := Canvas.TextWidth(Name) div 2;

    gluUnProject(wdx + 4 + Len, wdy + 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    gluUnProject(wdx - 4, wdy + 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    gluUnProject(wdx - 4, wdy - 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    gluUnProject(wdx + 4 + Len, wdy - 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    glEnd;
  end 
  else // иначе просто отображаем иконку
  begin
  // Записываем в стек параметры цвета
  glPushAttrib(GL_COLOR_MATERIAL);
  glDisable(GL_LIGHTING);
  glEnable(GL_ALPHA_TEST);
  glColor3f(1, 1, 1);
    gluUnProject(wdx - 8, wdy - 8, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glRasterPos3f(wtx, wty, wtz);
    glDrawPixels(16, 16, $80E1, GL_UNSIGNED_BYTE, bitPoint2);
    // если текст включен, выводим его на экран
 //   if not MainForm.HideName1.Checked then
 //   begin
      gluUnProject(wdx + 10, wdy, wdz, MvMatrix, PMatrix, vp,
        @wtx, @wty, @wtz);
      glRasterPos3f(wtx, wty, wtz);
      glListBase(FontGL);
      glCallLists(Length(Name), GL_UNSIGNED_BYTE, Pointer(Name));
  //  end;
  glDisable(GL_ALPHA_TEST);
  glEnable(GL_LIGHTING);
  glPopAttrib;  // возвращаем параметры из стека
  end;

end;


procedure glxDrawText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; Name: string);
var
  vp: TGLVectori4;
  PMatrix, MvMatrix: TGLMatrixd4;
  wtx, wty, wtz: GLdouble;
  Len: Integer;
begin
  // получаем координаты плоскости паралельной экрану
  glGetIntegerv(GL_VIEWPORT, @vp);
  glGetDoublev(GL_MODELVIEW_MATRIX, @MvMatrix);
  glGetDoublev(GL_PROJECTION_MATRIX, @PMatrix);
  gluProject(wdx, wdy, wdz, MvMatrix, PMatrix, vp,
    @wdx, @wdy, @wdz);
  glDisable(GL_LIGHTING);
    gluUnProject(wdx - 8, wdy - 8, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glRasterPos3f(wtx, wty, wtz);
      gluUnProject(wdx + 10, wdy, wdz, MvMatrix, PMatrix, vp,
        @wtx, @wty, @wtz);
      glRasterPos3f(wtx, wty, wtz);
      glListBase(FontGL);
      glCallLists(Length(Name), GL_UNSIGNED_BYTE, Pointer(Name));
  glEnable(GL_LIGHTING);  
end;

{
function  TAnimClip.GetAnimFrame(Name: string):TAnimInfo;
var
  i,m:integer;
begin
  i:=FNamesObj.IndexOf(Name);
  if (i>-1) then
        Result:=FAnimInfo[FNamesObj.IndexOf(Name)];
end; }


function LineFacet(p1,p2:TXYZ;Axis:TAxis;var p:TXYZ;wd,wd0:TXYZ):boolean;
var
   d:real;
   denom,mu,length:real;
   n,pa,pb,pc:TXYZ;//,pa1,pa2,pa3
begin
   result:=FALSE;
    p.x:=0;p.y:=0;p.z:=0;
    pa.x:=0;pa.y:=0;pa.z:=0;
   case Axis of
   Axis_X: begin    pb.x:=1;pb.y:=0;pb.z:=0;    pc:=wd; end;
   Axis_XY: begin    pb.x:=1;pb.y:=0;pb.z:=0;    pc.x:=0;pc.y:=1;pc.z:=0; end;
   Axis_Y: begin    pb.x:=0;pb.y:=1;pb.z:=0;    pc:=wd;  end;
   Axis_YZ: begin    pb.x:=0;pb.y:=1;pb.z:=0;    pc.x:=0;pc.y:=0;pc.z:=1; end;
   Axis_Z: begin    pb.x:=0;pb.y:=0;pb.z:=1;    pc:=wd; end;
   Axis_XZ: begin    pb.x:=1;pb.y:=0;pb.z:=0;    pc.x:=0;pc.y:=0;pc.z:=1; end;
   Axis_XYZ: begin  pb:=wd;  pc:=wd0;end;
   end;
   //* Calculate the parameters for the plane */
   n.x := (pb.y - pa.y)*(pc.z - pa.z) - (pb.z - pa.z)*(pc.y - pa.y);
   n.y := (pb.z - pa.z)*(pc.x - pa.x) - (pb.x - pa.x)*(pc.z - pa.z);
   n.z := (pb.x - pa.x)*(pc.y - pa.y) - (pb.y - pa.y)*(pc.x - pa.x);
   //Normalize(n);
   length := Sqrt(n.x*n.x+n.y*n.y+n.z*n.z);
   n.x:= n.x/length;
   n.y:= n.y/length;
   n.z:= n.z/length;

   d := - n.x * pa.x - n.y * pa.y - n.z * pa.z;

   //* Calculate the position on the line that intersects the plane */
   denom := n.x * (p2.x - p1.x) + n.y * (p2.y - p1.y) + n.z * (p2.z - p1.z);
   if (ABS(denom) < 1.0E-8)        //* Line and plane don't intersect */
     then exit;
   mu := - (d + n.x * p1.x + n.y * p1.y + n.z * p1.z) / denom;
   if (mu < 0) or( mu > 1)  //* Intersection not along line segment */
      then exit;
  p.x := p1.x + mu * (p2.x - p1.x);
  p.y := p1.y + mu * (p2.y - p1.y);
  p.z := p1.z + mu * (p2.z - p1.z);
   case Axis of
   Axis_X:begin p.y:=0;p.z:=0;end;
   Axis_Y:begin p.x:=0;p.z:=0;end;
   Axis_Z:begin p.y:=0;p.x:=0;end;
   end;
   result:=TRUE;
end;

procedure GetProjectVert(X,Y:real;axis:TAxis;var p:TXYZ);
var
  p1,p2,wd,wd0,wd1:TXYZ;
  vp: TVector4i;
  PrMatrix, VmMatrix: TGLMatrixd4;
begin
    glGetIntegerv(GL_VIEWPORT, @vp);
    glGetDoublev(GL_MODELVIEW_MATRIX, @VmMatrix);
    glGetDoublev(GL_PROJECTION_MATRIX, @PrMatrix);
   case axis of
   Axis_Y,Axis_X,Axis_Z,Axis_XYZ:
        begin
        wd.x:=0;   wd.y:=0;   wd.z:=0;
        gluProject(wd.x, wd.y, wd.z, VmMatrix, PrMatrix, vp,
        @wd.x, @wd.y, @wd.z);
        gluUnProject(wd.x, wd.y+10, wd.z, VmMatrix, PrMatrix, vp,
        @wd0.x, @wd0.y, @wd0.z);
        gluUnProject(wd.x+10, wd.y, wd.z, VmMatrix, PrMatrix, vp,
        @wd1.x, @wd1.y, @wd1.z);
        if axis=Axis_XYZ then
        wd:=wd0 else begin
        wd.x:=(wd0.x+wd1.x)/2;
        wd.y:=(wd0.y+wd1.y)/2;
        wd.z:=(wd0.z+wd1.z)/2;
                        end;
        end;
   end;

    gluUnProject(X, Y, 0, VmMatrix, PrMatrix, vp,
    @p1.x, @p1.y, @p1.z);
    gluUnProject(X, Y, 1, VmMatrix, PrMatrix, vp,
    @p2.x, @p2.y, @p2.z);
//   case axis of
//   Axis_Y,Axis_X,Axis_Z: begin
//    test1:=LineFacet(p1,p2,axis, p,wd0);
//    test2:=LineFacet(p1,p2,axis, p0,wd1);
  //  if (p.x<>p0.x) and (p.y<>p0.y) and (p.z<>p0.z) then
  //  p:=p0;test1:=test2;
//    if not test1 then p:=p0;
 //   end;
 //  else
   LineFacet(p1,p2,axis, p,wd,wd1);
  // end;
 end;

const MaxSingle: single = 1E34;
GeomZero: single = 1E-5;

procedure TMesh.ReadVCFile(FileName: string);
var
VirtualBufer: TMemoryStream;
Buf:Pointer;
Num,i:Integer;
begin
   VirtualBufer:=TMemoryStream.Create;
   VirtualBufer.LoadFromFile(FileName);
   VirtualBufer.Read(Num,4);
   SetLength(Vert, Num);
   for i := 0 to Num - 1 do
      VirtualBufer.Read(Vert[i], 4 * 3);
   VirtualBufer.Read(Num,4);
    SetLength(Face, num);
    for i := 0 to Num - 1 do
      VirtualBufer.Read(Face[i], 2 * 3);
   VirtualBufer.Read(Num,4);
   SetLength(Color, Num*3);
   for i := 0 to Num*3 - 1 do
      begin
        VirtualBufer.Read(Color[i], 3);
        Color[i][3] := 255;
      end;
   VirtualBufer.Free;
end;

procedure TMesh.TestApplyVC(VCMesh: TMesh);
var
Num, Num2,i, j, i1,i2,i3, j1, j2 , j3:Integer;
UpdateColor:boolean;
    function TestV(const v1,v2:TVer):boolean;
    begin
     Result:= ((abs(v1[0]-v2[0])<0.001) and
     (abs(v1[1]-v2[1])<0.001) and
      (abs(v1[2]-v2[2])<0.001) ) ;
    end;

begin
  UpdateColor:=false;
  Num:=Length(Face);
  Num2:=Length(VCMesh.Face);
  // нужно сверить точку с каждой из 3 вершин
  if Length(Color)>0 then
  for i:=0 to Num-1 do
   begin
     i1:=Face[i][0];
     i2:=Face[i][1];
     i3:=Face[i][2];
     for j:=0 to Num2-1 do begin
     j1:=VCMesh.Face[j][0];
     j2:=VCMesh.Face[j][1];
     j3:=VCMesh.Face[j][2];
     if TestV(Vert[i1],VCMesh.Vert[j1]) and
       TestV(Vert[i2],VCMesh.Vert[j2]) and
        TestV(Vert[i3],VCMesh.Vert[j3])
      then
        begin
        Color[i1]:=VCMesh.Color[j*3+0];
        Color[i2]:=VCMesh.Color[j*3+1];
        Color[i3]:=VCMesh.Color[j*3+2];
        UpdateColor:=true;
        break;
        end;
     if TestV(Vert[i2],VCMesh.Vert[j1]) and
       TestV(Vert[i3],VCMesh.Vert[j2]) and
        TestV(Vert[i1],VCMesh.Vert[j3])
      then
        begin
        Color[i2]:=VCMesh.Color[j*3+0];
        Color[i3]:=VCMesh.Color[j*3+1];
        Color[i1]:=VCMesh.Color[j*3+2];
        UpdateColor:=true;
        break;
        end;
    if TestV(Vert[i3],VCMesh.Vert[j1]) and
       TestV(Vert[i1],VCMesh.Vert[j2]) and
        TestV(Vert[i2],VCMesh.Vert[j3])
      then
        begin
        Color[i3]:=VCMesh.Color[j*3+0];
        Color[i1]:=VCMesh.Color[j*3+1];
        Color[i2]:=VCMesh.Color[j*3+2];
        UpdateColor:=true;
        break;
        end;

     end;

   end;

 //if UpdateColor and (ColorIndx<>0) then
//      CntrArr[ColorIndx].WriteXArray(@Color[0], Length(Color), 4);

 for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      Childs[i].TestApplyVC(VCMesh);
end;



procedure TMesh.ResetChilds(Num: integer);
begin
 SetLength(Childs,0);
 SetLength(Childs,num);
end;

procedure TMesh.Clear;
begin
 SetLength(Childs,0);
 Free;
end;

procedure TMesh.SetEntMatrix(EntMatrix: TEntMatrix);
begin
 Transform.TransType := TTMatrix;
 Transform.TrMatrix := EntMatrix.m;
end;

procedure TMesh.SetSizeBox(val: Single);
begin
  with  SizeBox do
  begin
    Xmax := val;
    Xmin := -val;
    Ymax := val;
    Ymin := -val;
    Zmax := val;
    Zmin := -val;
  end;
end;

procedure TMesh.SetBound(BBox: TBbox);
begin
  with  SizeBox do
  begin
    Xmax := BBox.max[1];
    Xmin := BBox.min[1];
    Ymax := BBox.max[2];
    Ymin := BBox.min[2];
    Zmax := BBox.max[3];
    Zmin := BBox.min[3];
  end;
end;


function TMesh.CheckFloor: Boolean;
begin
 Result:=false;
if  ((($1 shl CurrentFloor) and floors) >0) then Result:=true;
end;

function TMesh.CheckFloorHeight(Height: Single): Boolean;
var
  vector: Tver;
  Min: Single; Max:Single;
begin
  if CurrentFloor=-1 then Result:=true else
  begin
     if (Length(BSPCntrLib.Floors)<=CurrentFloor) then begin
       Result:=True; Exit;
     end;
  //  glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);
  //  Vector := MatrXVert(Matrix, Xmin, Ymin, Zmin);
     max:=BSPCntrLib.Floors[CurrentFloor].Ymin;
     min:=BSPCntrLib.Floors[CurrentFloor].Ymin-100;
     if CurrentFloor>0 then begin
        min:=BSPCntrLib.Floors[CurrentFloor-1].Ymin-0.5;
        max:=BSPCntrLib.Floors[CurrentFloor].Ymin;
     end;
     if (Height<Max-0.5) and (Height>Min) then
      Result:=true
      else
      Result:=false;
  end;
end;


end.
