unit BSPCntrLib;

interface

uses OpenGLx, SysUtils, Classes, Windows, Contnrs, ComCtrls, StdCtrls, ExtCtrls,
  Graphics, Valedit, Forms, Math, VirtualTrees,Dialogs;

type

  PVer = ^TVer;
  Tver    = array[0..2] of GLfloat;
  Color4d = array[0..3] of GLfloat;
  TVer4f = array[0..3] of GLfloat;

  AVer    = array of TVer;
  Aval    = array of GLfloat;
  AAval   = array of Aval;
  TFace   = array[0..3] of Word;
  IFace   = array of Word;
  AFace   = array of TFace;
  AData   = array of DWord;
  TFace3  = array[0..2] of Word;
  AFace3  = array of TFace3;
  Tpnt    = array[0..1] of GLfloat;
  ATCoord = array of Tpnt;
  TUColor = array[0..3] of Byte;
  AUColor = array of TUColor;
  AFColor = array of Color4d;
  ATexures  = array of Integer;

  Tvector = record
    X, Y, Z: GLfloat;
  end;

  TBox = record
    Xmin, Ymin, Zmin: GLfloat;
    Xmax, Ymax, Zmax: GLfloat;
  end;

  TVect4 = array[1..4] of GLfloat;
  TMatrix = array[1..4, 1..4] of GLfloat;
  TMatrixD = array[1..4, 1..4] of GLdouble;
  TTransformation = array[0..2] of Tver;
  TVect4b = array [1..4] of byte;

  AVect4 = array of TVect4;

  TEntMatrix = record
     t: TTransformation;
     m: TMatrix;
     mask: UInt64;
  end;

  //TOBB = record
   // center: Tvector;

 //SpBSP contruct structures
 SpBSPFaceHash = record
  hash: integer;
  face_index: integer;
 end;

 ASpBSPFaceHash = array of SpBSPFaceHash;
///////////////////////////


 TBBox = record
    max: TVect4;
    min: TVect4;
  end;

        TImage_block = record
        mask:cardinal;
        width:Integer;
        height:Integer;
        bits:Integer;
        bytewidth:Integer;
        bitmap:Pointer;
        palette:Pointer;
        id:Integer;
        link:Pointer;
        end;

        TFrame = record
          RotX:SmallInt;
          RotY:SmallInt;
          RotZ:SmallInt;
          RotW:SmallInt;
          PosX:Single;
          PosY:Single;
          PosZ:Single;
          Hash:Cardinal;
        end;

        PFrame = ^TFrame;

        TKeyRot = record
           RotX: SmallInt;
           RotY: SmallInt;
           RotZ: SmallInt;
           RotW: SmallInt;
        end;

        TBoneFrame = record
          boneHash:Cardinal;
          id:string;
          frame:TFrame;
          end;

        ABoneFrame = array of TBoneFrame;

        TTimeMatrix = record
          time: Single;
          Matrix: TMatrix;
        end;
        ATimeMatrix = array of TTimeMatrix;
  TgaHead = record
    zero: Word;
    typeTGA: Word;
    zero2: Longword;
    zero3: Longword;
    Width: Word;
    Height: Word;
    ColorBit: Word;
  end;

  TRGBA = record
    b, g, r, a: Byte;
  end;
  ARGBA  = array [0..1] of TRGBA;
  PARGBA = ^ARGBA;

  TRGB = record
    b, g, r: Byte;
  end;
  ARGB  = array [0..1] of TRGB;
  PARGB = ^ARGB;

  AB  = array [0..1] of Byte;
  PAB = ^AB;

  XEnumStrings = array [0..1] of string;
  PXEnumStrings = ^XEnumStrings;

  EnumVertex = ( E_VERTEX, E_NFLOAT,  E_NORMAL,  E_COLOR,  E_WEIGHT,
     E_BONES,  E_UNK  ); //E_TEXCOORD
//  EnumMType = ( M_DEF, M_ALPHA, M_ILLUM, M_UNK );
  EDAEOptions = (DAE_CONVERT,DAE_CG,DAE_LINKS,DAE_ANIM,DAE_CLIPS,DAE_ADDCLIP,DAE_REPLACECLIP,DAE_MAX,DAE_BLENDER,DAE_DUMMY_JOINT);
 // SMtype = set of EnumMType;
  SVertex = set of EnumVertex;
  DAEOptions = set of EDAEOptions;

  BSPDataTypes = (
     BSPInt,BSPDword,BSPWord,BSPSint,BSPSUint16,BSPUint,BSPByte,BSPColor,BSPFloat,BSPString,
     BSPGLParam,BSPGLFactor,BSPGLBool,BSPGLMigMag,BSPGLRepeat,BSPStruct,
     BSPMatrix,BSPVect,BSPUInt64,BSPArray,BSPGLShade,BSPVect4b,BSPBool,BSPChBool,
     BSPVect4,BSPLoad,BSPMesh,BSPBox,BSPChunk,BSPRVect,BSPEntTypes,BSPUVWord,
     BSPHash,BSPRefHash,BSPMatFlags,BSPKeyType,BSPWpTypes,BSPAtomic,
     BSPFace,BSPUVCoord,BSPFAngle,BSPGroup,BSPAngleBlock,BSPTransform,
     BSPNullBoxType,BSPRenderFlags,BSPMatrixFlag,BSPClumpFlag,BSPTextureFormat,BSPEnvMapType,
     BSPWorldFlags, BSPMeshFlags , BSPFloorFlags, BSPResourceAccessData, BSPReadFlags,
     BSPHintFlags, BSPConstantFlags, BSPVertexFlags, BSPMatBlockFlags, BSPNullNodeFlags,
     BSPSpawnType
  );
  BSPMatTypes = ( BMxBlock, BMatrix);

        PClassData = ^TClassData;
        TClassData = record
          Name: String;
          Value: String;
          Hash: String;
          ID:String;
          Version:String;
          Obj: Pointer;
          ImageIndex: Integer;
          ValueIndex: Integer;
          Changed:Boolean;
        end;
      //  TLoadProcedure = procedure (ANode: PVirtualNode; Progress:TProgressBar) of object;
        TLoadItemProcedure = procedure (Node1:PVirtualNode; i:integer; Parr:Pointer) of object;

          // Node data record for the the document properties treeview.
          PPropertyData = ^TPropertyData;
          TPropertyData = record
            DName: String;
            DValue: String;
            PValue: Pointer;
            DType: String;
            DBType: BSPDataTypes;
            ValueIndex: Integer;
            PFunc: TLoadItemProcedure;
            PNum: Integer;
            PArr: Pointer;
            Obj: Pointer;
            Changed: Boolean;
          end;

const
  Space: PChar         = '   ';
  K_Rot = 0;
  K_Pos = 1;
  K_Vect = 2;
  K_UV = 3;
  K_Vis = 4;

  //Limit constants
  SP_MAX_ANIM_NAME = 32;

  //Chunk constants
  C_Projection = 1;
  C_Root = 3;
  C_MaterialObj = 5;
  C_NullNode = 20;
  C_ZoneObj = 23;
  C_Mesh = 1000;
  C_Frame = 1001;
  C_RenderBlock = 1002;
  C_BSP = 1003;
  C_Atomic = 1004;
  C_Clump = 1005;
  C_Camera = 1006;
  C_Light = 1007;
  C_LevelObj = 1009;
  C_MatDictionary = 1010;
  C_SectorOctree = 1011;
  C_World = 1012;
  C_AnimKeyBlock = 1015;
  C_AnimDictionary = 1017;
  C_NgonList = 1018;
  C_NgonBSP = 1019;
  C_NullNodes = 1020;
  C_WaypointMap = 1021;
  C_Zones = 1023;
  C_Spline = 1024;
  C_NullBox = 1026;
  C_DictAnim = 1027;
  C_LightSwitchController = 1029;
  C_Entities = 20000;
  C_Entity = 20001;
  C_Textures = 20002;

  ADD_ROOT = 'Add Root Chunks';
  IM_ENTITY = 'Import Entities';
  IM_NULLNODES = 'Import Nullnodes';

   // Enum Section
  BSPDataNames: array [BSPDataTypes] of String = ('Int32','Dword','Word','Int16', 'UInt16','UInt32',
  'Byte','RGBA','Real','String','CompFunction','BlendFunction','GLbool','TextureFilterMode',
  'TextureAddressMode','Struct','EntMatrix','V3d','UInt64','Array','ShadeMode','RGB',
  'Bool','IsChunk','Vect4m','...','SpMesh','Box','Chunk','RotQuat','EntType','UVCoordW',
  'Hash','refHash','MatFlags','KeyType','WpType','Atomic','Face','UVCoord',
  'AngleFlag','GroupIndex','AngleBlock','Transform','NbType','RenderFlags', 'MatrixFlag',
  'ClumpFlag', 'TextureFormat', 'EnvMapType', 'WorldFlags' , 'MeshFlags', 'FloorFlags', 'ResourceAccessData',
  'ReadFlags', 'HintFlags', 'ConstantFlags', 'VertexFlags', 'MatBlockFlags', 'NullNodeFlags', 'SpawnType');

  BSPEnumVertexS: array [0..13] of String = ( 'VERTEX', 'NFLOAT',  'NORMAL',  'COLOR',  'WEIGHT',
     'BONES',  'UNK' , 'TXCOORD1', 'TXCOORD2', 'TXCOORD3', 'TXCOORD4', 'TXCOORD5', 'TXCOORD6', 'TXCOORDN' );
  BSPEnumMatS: array [0..2] of String = ( 'MAT_ALPHA_TEST', 'MAT_CONSTANT_SHADING', 'MAT_DOUBLE_SIDED' );
  BSPBoolS: array [0..1] of String = ( 'False', 'True' );
  BSPEnumKeyTypeS: array [0..4] of String = ( 'k_Rot','k_Pos','k_Vect','k_UV','k_Vis');

  BSPEntTypesS: array [0..5] of String =  ( '0','1','ENT_RIGID','ENT_ANIMATED','ENT_NPC','ENT_LIGHT');
  BSPWpTypesS: array [0..28] of String =  ( 'WP_CAMPIVOT','WP_FETTER','2','WP_LEAK','4','WP_CAMSTART','6','7','WP_NPC','WP_FLEE','WP_PLACEMENT','11','12','13','14','15','16','WP_TOILET','18','WP_CAMTARGET','20','21','WP_EFFECT','23','24','25','26','27','WP_MISC');
  BSPGLRepeatS: array [0..4] of String = ( 'NA_TEXTURE_ADDRES','WRAP','MIRROR','CLAMP','BORDER');
  BSPGLMigMagS: array [0..6] of String = ( 'NA_FILTER_MODE','NEAREST','LINEAR','MIP_NEAREST','MIP_LINEAR', 'LINEAR_MIP_NEAREST','LINEAR_MIP_LINEAR');
  BSPNullBoxTypeS: array [0..28] of String = ( 'OBB','HaunterSpawn','2','3','4','CameraPosition','CameraRotate','CameraScale','8','9','10','11','12','13','14','15','16','Handle','Spellpoint','19','Chainpoint','FlameEmitter','Smoke','Particle','WaterEmitter','25','26','27','MiscEffect');
  BSPMatrixFlagS: array [0..31] of String = ( 'Indentity','Synchronised','flag_0x4','flag_0x8','flag_0x10','flag_0x20','flag_0x40','flag_0x80','flag_0x100','flag_0x200','flag_0x400','flag_0x800','flag_0x1000','flag_0x2000','flag_0x4000','flag_0x8000','flag_0x10000','flag_0x20000','flag_0x40000','flag_0x80000','flag_0x100000','flag_0x200000','flag_0x400000','flag_0x800000','flag_0x1000000','flag_0x2000000','flag_0x4000000','flag_0x8000000','flag_0x10000000','flag_0x20000000','flag_0x40000000','flag_0x80000000');
  BSPClumpFlagS: array [0..61] of String = ('CF_1','GhostShadding','815E80_4','Atomics','BBox','HasLightChunk','AtomicChunks','Bones','LightPool','AddLightPool','CF_11','CF_12','CF_13','CF_14','CF_15','CF_16','IsMirrored','CF_18','RenderAtomics','CF_20','Render21','LightInOctree','AnimateLights','AmbientLight','CF_25','CF_26','AtomicRenderLights','HasZones','CF_29','CF_30','CF_31','CF_32','CF_33','CF_34','CF_35','CF_36','CF_37','CF_38','CF_39','CF_40','CF_41','CF_42','CF_43','CF_44','CF_45','CF_46','CF_47','CF_48','CF_49','CF_50','CF_51','CF_52','CF_53','CF_54','CF_55','CF_56','CF_57','CF_58','CF_59','CF_60','CF_61','CF_62');
  BSPGLFactorS: array [0..11] of String = ( 'NA_BLEND', 'ZERO','ONE','SRC_COLOR','INV_SRC_COLOR','SRC_ALPHA','INV_SRC_ALPHA','DEST_ALPHA', 'INV_DEST_ALPHA','DEST_COLOR','INV_DEST_COLOR','SRC_ALPHA_SAT');
  BSPGLParamS: array [0..8] of String = ( 'NA_COMP', 'NEVER','LESS', 'EQUAL', 'LESS_EQUAL', 'GREATER', 'NOT_EQUAL', 'GREATER_EQUAL', 'ALWAYS');
  BSPAtomicS: array [0..6] of String = ('A_POINT','A_STATICMESH','A_EMITTER','A_MESH','A_ACTMESH','A_SKINMESH','6');
  BSPGLBoolS: array [0..1] of string = ('GL_DISABLE','GL_ENABLE');
  BSPGLShadeS: array [0..2] of string = ('NA_SHADE_MODE','FLAT','GOURAUD');
  BSPTextureFormatS : array [0..5] of string = ('FORMAT5551', 'FORMAT565', 'FORMAT4444', 'FORMATLUM8', 'FORMAT8888', 'FORMAT888');
  BSPEnvMapTypeS: array [0..1] of string = ('NONE','PLANAR');
  BSPWorldFlagsS: array [0..3] of string = ('HAS_SWITCHABLE_LIGHTS', 'USE_AMBIENT', 'DESTRUCTING', 'Y_BASED_FOG');
  BSPMeshFlagsS: array [0..4] of string = ('EMPTY_SPACE', 'BOUNDS_DIRTY', 'NEVER_RECALCULATE_BOUNDS', 'REBUILD_COMPILED_LISTS', 'WORLD_GEOMETRY');
  BSPFloorFlagsS: array [0..6] of string = ('FLOOR 1', 'FLOOR 2', 'FLOOR 3', 'FLOOR 4', 'FLOOR 5', 'FLOOR 6', 'ALL FLOORS');
  BSPResourceAccessDataS: array [0..16] of string = ('VERTEX_DATA', 'TRIANGLE_DATA', 'TRIANGLE_DATA_FAST', 'TRIANGLE_DATA_INDICES', 'RANGE', 'ALPHA_SORT', 'RUNTIME_LIGHTABLE', 'MATERIAL', 'MATERIAL_COLOUR', 'ZBUFFER_FIX', 'DOUBLE_SIDED', 'BOUNDS', 'MATERIAL_ENVMAP_TEXTURE_MATRIX', 'MATERIAL_POSTMAP_TEXTURE_MATRIX', 'VERTEX_FORMAT', 'NUM_VERT', 'NUM_TRIANGLES');
  BSPReadFlagsS: array [0..6] of string = ('VERTEX', 'RHW', 'NORMAL', 'DIFFUSE', 'WEIGHT', 'INDEX', 'HASHU32');
  BSPHintFlagsS: array [0..4] of string = ('SEQUENTIAL_QUADS', 'SEQUENTIAL_ACCESS_ONLY', 'DYNAMIC_STREAMING_VERTEX_ACCESS', 'LIGHTS_MAY_FREEZE', 'DONT_RECALCULATE_BOUNDS');
  BSPConstantFlagsS: array [0..1] of string = ('CONFINED', 'SKINNED');
  BSPVertexFlagsS: array [0..13] of string = ('VERTEX', 'RHW', 'NORMAL', 'DIFFUSE', 'WEIGHT', 'INDEX', 'HASHU32', 'TEXTURE_COORD_1', 'TEXTURE_COORD_2', 'TEXTURE_COORD_3', 'TEXTURE_COORD_4', 'TEXTURE_COORD_5', 'TEXTURE_COORD_6', 'TEXTURE_COORD_N' );
  BSPRenderFlagsS: array [0..4] of String = ('REQUIRES_ALPHA_SORT_Z', 'REQUIRES_ALPHA_SORT_LAYER_Z', 'RUNTIME_LIGHTABLE', 'ZBUFFER_FIX', 'DOUBLE_SIDED');
  BSPMatBlockFlagsS: array [0..14] of String = ('BOUNDS_DIRTY', 'INVISIBLE_NONSELECTABLE', 'WORLDPIPELINE', 'SPECIAL1PIPELINE', 'SPECIAL2PIPELINE', 'NEVER_COMPILE', 'NEVER_RECALC_BOUNDS', 'RUNTIME_LIT', 'VERTEX_LIT', 'PREVERTEX_LIT', 'INVISIBLE', 'ADDITIVE_TRANS', 'STREAM_LIGHTING_SID', 'ISENVMAPPED', 'HALO');
  BSPNullNodeFlagsS: array [0..1] of string = ('BOUNDS_VALID', 'SPAWN');
  BSPSpawnTypeS: array [0..29] of string = ('DEFAULT', 'FETTER' , 'FIREPLACE', 'LEAK', 'TENTACLES', 'CAMERAPOSITION', 'CAMERATARGET', 'CAMERAROLL', 'SPAWN', 'FLEE', 'POSITION', 'BREAKABLE', 'MIRROR', 'MIRRORBOX', 'MIRRORBACKDROP', 'TRAINWHEELSPARK', 'HIDE', 'ACTIONPOINT', 'SPELLPOINT', 'HAUNTERTALKS', 'CHAINPOINT', 'SMALL_FIRE', 'MEDIUM_FIRE', 'LARGE_FIRE', 'WATER_EMITTER', 'NO_HAND_SPELLPOINT', 'VOLUMETRIC_LIGHT_POINT', 'VOLUMETRIC_WINDOW_PT', 'MISC_EFFECT', 'ASTRAL_CAP');

  //Special flag enums
  BSPTextureFormatF : array [0..5] of Integer = ($100, $200, $300, $400, $500, $600);
  BSPWorldFlagsF : array [0..3] of Integer = ($1, $2, $10000, $20000);
  BSPEnumMatF : array [0..2] of Integer = ($2, $4, $8);
  BSPFloorFlagsF: array [0..6] of Integer = ($1, $2, $4, $8, $10, $20, $FFFFFFFF);
  BSPResourceAccessDataF : array [0..16] of Integer = ($2, $4, $8, $10, $400, $800, $1000, $2000, $4000, $8000, $10000, $20000, $40000, $80000, $2000000, $4000000, $8000000);
  BSPReadFlagsF: array [0..6] of Integer = ($100, $200, $400, $800, $1000, $2000, $4000);
  BSPHintFlagsF: array [0..4] of Integer = ($2, $4, $8, $10, $20);
  BSPConstantFlagsF: array [0..1] of Integer = ($2, $4);
  BSPRenderFlagsF: array [0..4] of Integer = ($2, $4, $8, $10, $20);
  BSPMatBlockFlagsF: array [0..14] of Integer = ($1, $2, $4, $8, $10, $20, $40, $80, $100, $200, $400, $1000, $2000, $4000, $8000);

type

  TXCtrls = record
    DrawBoxes,
    AnimButton,
//    EditAnimBut,Dummy,
    ShowLight,NullNodes,WpNames,
    Quilt,Collisions,Mirror,Emitters,NgonBSP,WardZone,
    Icelayer,Light,Move,Rotate,Scale
    : PBoolean;
 //   JointButton: TSpeedButton;
    GlValueList: TValueListEditor;
    AnimBox: TComboBox;
    TreeProgress:TProgressBar;
    App:TApplication;
    StopTimer:procedure;
 //   ValueList: TValueListEditor;
    Status, StatusM: TStatusPanel;
    ClassTree: TVirtualStringTree;
    XImageLab: TLabel;
    XImage: TImage;
    Handle: THandle;
    Canvas: TCanvas;
  end;


var

  GLError: boolean = false;
  GLPause: boolean = False;
  GLErrorCode: Integer = 0;
  But:TXCtrls;
  Floors: array of TBox;
  CurrentFloor: Integer =-1;
  FloorOffset: Single = 0.4;
  MaxFloors: Integer = 1;

function SetEnumStr(flags:Cardinal;EnumStr:array of string; nf_name: string = 'NO_FLAGS'):string;
function SetEnumStr64(flags:Cardinal;EnumStr:array of string):string;
function SetCustomFlagEnumStr(flags: Cardinal; EnumStr:array of string; EnumFlags: array of Integer; nf_name: string = 'NO_FLAGS'): string;
function MeshSetStr(p:Pointer):string;

implementation

function SetCustomFlagEnumStr(flags: Cardinal; EnumStr:array of string; EnumFlags: array of Integer; nf_name: string = 'NO_FLAGS'): string;
var
  s,delim:string;
  i:Integer;
begin
  s:='';  delim:=' | ';
  if flags = 0 then
  begin
    s:= s + nf_name + delim;
  end
  else
  begin
    for i:=Low(EnumStr) to High(EnumStr) do
    begin
      if (flags - EnumFlags[i] >= 0) then
      begin
        if ((flags and EnumFlags[i]) > 0) then
        begin
          s:=s+EnumStr[i]+delim;
        end;
      end;
    end;
  end;
  if s<>'' then   SetLength(s, Length(s)-length(delim));
  Result:= s;
end;

function SetEnumStr(flags : Cardinal; EnumStr : array of string; nf_name: string = 'NO_FLAGS') : string;
var
  s,delim : string;
  i : Integer;
begin
  s:= '';
  delim:= ' | ';
  if flags=0 then
  begin
    s:= s + nf_name + delim;
  end
  else
  begin
  for i:= Low(EnumStr) to High(EnumStr) do
    if ( ( ($1 shl i) and flags ) > 0 ) then
      s:= s + EnumStr[i] + delim;
  end;
  if s <> '' then
    SetLength(s, Length(s) - length(delim));
  result:= s;
end;

function SetEnumStr64(flags:Cardinal;EnumStr:array of string):string;
var
  s,delim:string;
  i:integer;
  p: Pointer;
  flagLow,flagHigh:Cardinal;
begin
  s:='';  delim:=' | ';
  flagLow:= Cardinal(Pointer(flags)^);
  flagHigh:= Cardinal(Pointer(flags + 4)^);
  if flagLow <> 0 then
  begin
    for i:=0 to 30 do
    begin
      if ((($1 shl i) and flagLow)>0)
       then s:=s+EnumStr[i]+delim;
    end;
  end;
  if flagHigh <> 0 then
  begin
    for i:= 0 to 30 do
    begin
        if ((($1 shl i) and flagHigh)>0)
       then s:=s+EnumStr[i+31]+delim;
    end;
  end;
  if s<>'' then   SetLength(s, Length(s)-length(delim));
  result:=s;
end;


function MeshSetStr(p:Pointer):string;
var
  mesh_flags:Cardinal;
  ntex:byte;
  bflag:Cardinal;
begin
  mesh_flags:=Cardinal(p^);
  ntex:= mesh_flags and $ff;
  bflag := byte(mesh_flags shr 8);
  if ntex>0 then  bflag:= bflag or ($1 shl (ntex+6));
  result:=SetEnumStr(bflag,BSPVertexFlagsS);
end;

end.
