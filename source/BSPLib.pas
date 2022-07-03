unit BSPLib;

interface

uses OpenGLx, IdGlobal, SysUtils, Classes, Dialogs, Windows, Contnrs,
  ComCtrls, StdCtrls, ExtCtrls, Graphics, Buttons, Valedit, XTrackPanel,
  OpenGLLib,
  Math, BSPCntrLib, BSPMeshLib, VirtualTrees, ZLibExGZ, ZLibEx, PNGImage,
  NativeXml, StrUtils, DictionaryCollection
  { XMLIntf, XMLDoc,OmniXML,FMX.DAE.Schema}//, BitmapsUnit
  ;
{$DEFINE PROGRESSBAR}

type
  TBSP = class;
  TBSPfile = class;
  TTextures = class;
  TTextureOpenGL = class;
  TMatDictionary = class;
  TSpFrame = class;
  TClump = class;
  TSectorOctree = class;
  TSpNgonBSP = class;
  TSpline = class;
  TWaypointMap = class;
  TSpBSP = class;
  TZones = class;
  TLightSwitchController = class;
  TNullNodes = class;
  TProjection = class;
  TDictAnim = class;

  TChunk = class(TObject)
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
    function ChunkTypeCreate(Clone: Boolean): TChunk;
  public
    point: Pointer;
    BSPoint: Pointer;
    IDType: Longword;
    Size: Longword;
    Version: Longword;
    ID: LongWord;
    Data: PClassData;
    BSP: TBSPfile;
    Mem: TMemoryStream;
    TypeName: string;
    DataTree: TCustomVirtualStringTree;
    Readed: Boolean;
    procedure MakeDefault(BSPFile: TBSPfile); virtual;
    function AddTreeData(ANode: PVirtualNode; Name: string; p: Pointer; Btype:
      BSPDataTypes; VReplace: string = ''): PVirtualNode;
    procedure ValueIndex(ANode: PVirtualNode; VIndex: integer);
    procedure AddLoadingMore(ANode: PVirtualNode; N: Integer; Parr: Pointer;
      LoadItem: TLoadItemProcedure);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); virtual;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); virtual;
    function GetMesh: TMesh; virtual;
    procedure ShowMesh(Hide: Boolean); virtual;
    procedure Read; virtual;
    procedure Write; virtual;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; virtual;
    procedure AddMatrixData(ANode: PVirtualNode; Name, Name2: string; const
      Matrix:
      TEntMatrix);
    procedure AddBoundData(ANode: PVirtualNode; const bound: TBBox; bname: string = 'Bounding Box');
    procedure Clone(Chunk: TChunk);
    procedure DeleteChild(Chunk: TChunk); virtual;
    procedure InsertChild(Target, Chunk: TChunk); virtual;
    procedure CheckSize;
    procedure CheckHide(ANode: PVirtualNode); virtual;
    procedure CalcSize;
    function CopyChunk(nBSP: TBSPFile): TChunk; virtual;
    function MakeHash(data: Pchar; size: integer): Cardinal;

    function ReadByteBlock: Cardinal;
    function ReadFloatBlock: Single;
    function ReadFloat: Single;
    function ReadSPWord: Word;
    function ReadSPDword: Cardinal;
    function ReadDword: Cardinal;
    function ReadDouble: Uint64;
    function ReadString: Pchar;
    function ReadStringSize(Size: Integer): Pchar;
    function ReadStringSizeWithoutLen(Size: Integer): Pchar;
    procedure ReadBytesBlock(P: Pointer; Size: Integer);
    function ReadBytesMBlock(Size: Integer): Pointer;
    function ReadVect4b(): TVect4b;
    function ReadBound: TBBox;
    function ReadColor: TUColor;
    function ReadVec3f4: TVect4;
    function ReadMxBlock: TEntMatrix;

    procedure WriteByteBlock(Val: Cardinal);
    procedure WriteFloatBlock(Val: Single);
    procedure WriteFloat(Val: Single);
    procedure WriteSPWord(Val: Word);
    procedure WriteSPDword(Val: Cardinal);
    procedure WriteDword(Val: Cardinal);
    procedure WriteBoolean(Val: Boolean);
    procedure WriteDouble(Val: Uint64);
    procedure WriteString(Val: Pchar);
    procedure WriteStringSize(Val: Pchar; Size: Integer);
    procedure WriteBytesBlock(P: Pointer; Size: Integer);
    procedure WriteBytesMBlock(Val: Pointer; Size: Integer);
    procedure WriteVect4b(Val: TVect4b);
    procedure WriteBound(Val: TBBox);
    procedure WriteColor(Val: TUColor);
    procedure WriteVec3f4(Val: TVect4);
    procedure WriteMxBlock(Val: TEntMatrix);
  end;

  TSetObj = class(TChunk)
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    Name: string;
    Num: Cardinal;
    procedure Write; override;
    procedure AddData(Node1: PVirtualNode; i: Integer; Parr: Pointer); virtual;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
  end;

  TAtomicObj = class(TChunk)
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    atomic_type: Cardinal;
    procedure Read; override;
    procedure Write; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TGLTexture = record //   texture_globj
    uv_set: Cardinal;
    name: Pchar;
    pixel_format: Cardinal;
    min_mag_type: Cardinal;
    wrap_type: Cardinal;
    path: Pchar;
    border_color: TUColor;
    hash: Cardinal;
    Texture: TTextureOpenGL; // link tobj
  end;

  TTextureOpenGL = class(TChunk)
    constructor Create();
    destructor Destroy; override;
  public
    name: Pchar;
    path: Pchar;
    width: Integer;
    height: Integer;
    min_mag_type: Integer;
    wrap_type: Integer;
    pixel_format: Cardinal;
    border_color: TUColor;
    hash: Cardinal;
    image: TImage_block;
    Bitmap: TBitmap;
    P: pointer;
    procedure Read(Chunk: TChunk);
    procedure Write(Chunk: TChunk);
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    function BitmapHash(img: TImage_block): Cardinal;
    function GetMagFilter(filter: Cardinal): Cardinal;
    function GetMinFilter(filter: Cardinal): Cardinal;
    function GetPixFormat(format: Cardinal): Cardinal;
    function GetRepeat(_repeat: Cardinal): Cardinal;
    function MakeBMPImage(XGrid: boolean = true): TBitmap;
    procedure SavePNGImage(Filename: string);
    procedure ReplacePNGImage(Filename: string; CustomTree:
      TCustomVirtualStringTree);
    procedure LoadPNGImage(Filename: string);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure SearchForTextureObj(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Obj: Pointer; var Abort: Boolean);
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
    function MakeTextureHash(): Integer;
    procedure UpdateTextureHash(CustomTree: TCustomVirtualStringTree; oldHash: Cardinal);
  end;

  TMaterialObj = class(TChunk) // 0005
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    Flags: Cardinal;
    m_unk: Cardinal; // dw_156
    AdditiveLightingModel: Cardinal; // b_8
    Diffuse: TUColor;
    Specular: TUColor;
    m_Power: Single;
    ShadeMode: Cardinal;
    Blend: Cardinal;
    Blend_dfactor: Cardinal;
    Blend_sfactor: Cardinal;
    AlphaTest: Cardinal;
    AlphaTestCompMode: Cardinal;
    AlphaRefValue: Single;
    DepthBufferWrite: Cardinal;
    DepthBufferCompMode: Cardinal;
    MaterialHash: Cardinal;
    Owner: Cardinal;
    ColourBufferWrite: Cardinal;
    Texture: array[0..4] of TGLTexture;
    useMatrix: array[0..4] of Cardinal;
    Matrix: array[0..4] of TEntMatrix;
    Gen: array[0..4] of Cardinal;
    EnvMapType: Cardinal;
    PlanarSheerEnvMapDistance: Single;
    mat_id: Cardinal;
    texture_num: integer;
    matrix_num: integer;
    gen_num: integer;
    T1: Cardinal;
    T2: Cardinal;
    T3: Cardinal;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    function ReadGLTexture(Textures: TTextures): TGLTexture;
    procedure WriteGLTexture(Texture: TGLTexture);
    procedure Read; override;
    procedure Write; override;
    procedure SetMaterial(mesh: Tmesh);
    procedure GenTextures;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure AddMaterial(effect: TXmlNode; tDict: TDictionary);
    procedure SearchForMaterialObj(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Obj: Pointer; var Abort: Boolean);
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
    function GetMaterialHash: Cardinal;
    function GetTextureType(id: Cardinal): string;
    procedure SetNewMaterialHash(CustomTree: TCustomVirtualStringTree); overload;
    procedure SetNewMaterialHash(); overload;
  end;

  TRenderBlock = class(TChunk) // 1002
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    flag_1: Cardinal;
    flag_2: Cardinal;
    flag_3: Cardinal;
    flag_4: Cardinal;
    val_5: Cardinal;
    normal_flags: Cardinal;
    mesh_flags: Cardinal;
    mflag: SVertex;
    ntex: Byte;
    val_8: Cardinal;
    vertex_count: Cardinal;
    indices_count: Word;
    indices_limit: Word;
    val_12: Word;
    materialHash: Cardinal;
    face_start: Cardinal;
    face_end: Cardinal;
    draw_count: Cardinal;
    draw_start: Cardinal;
    val_16: Cardinal;
    floor_flag: Cardinal;
    matrix_flag: Cardinal;
    mesh_index: Cardinal;
    mesh: TMesh;
    material: TMaterialObj;
    Clump: TClump;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure AddRenderBlock(node: TXmlNode; a_type: Cardinal);
    procedure Read; override;
    procedure Write; override;
    procedure ReadMeshCoord(LastClump: TClump);
    procedure WriteMeshCoord;
    procedure GetWeightBones(vertex: integer; var weight: Single; var bone1:
      ShortInt; var bone2: ShortInt);
    procedure AddVBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddCBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddUVBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddWBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure CheckHide(ANode: PVirtualNode); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
    procedure RecalculateNormals;
    procedure ReplaceModel(FileName: string);
    procedure ReplaceTextureCoords(FileName: string);
  end;

  AModels = array of TRenderBlock;
  AList = array of Cardinal;
  AFloat = array of Single;
  AMatrix = array of TEntMatrix;
  AChunk = array of TChunk;
  ATextures = array of TTextureOpenGL;
  AMaterial = array of TMaterialObj;

  TSpMesh = class(TChunk) //1000
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    id: Cardinal;
    models_num: Cardinal;
    BBox: TBBox;
    InnerSphere: TVect4;
    Radius: Single;
    IsBSP: Boolean;
    models: AModels;
    Collision: TSpBSP;
    mesh: TMesh;
    Progress: boolean;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure AddMesh(node: TXmlNode; a_type: Cardinal);
    procedure Read; override;
    procedure Write; override;
    procedure Clear;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    procedure DeleteChild(Chunk: TChunk); override;
    procedure CalculateBound;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  THBone = record
    hash: Cardinal;
    index: Integer;
    matrix: TMatrix;
    Bone: Tmesh;
  end;

  ABones = array of THBone;

  TClump = class(TAtomicObj) // 1005
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    hash: Cardinal;
    mask: UInt64;
    floor_flag: Cardinal;
    num_bones: Cardinal;
    bone_hashes: AList;
    bone_matrix: AMatrix;
    has_root: Boolean;
    default_animation: Cardinal;
    render_mirrors: Boolean;
    bbox: TBBox;
    vect1: TVect4;
    vect2: TVect4;
    Root: TSpFrame;
    mesh: TMesh;
    BoneLib: ABones;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure AddClump(e_type: Cardinal; node: TXmlNode);
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddBoneData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure CheckHide(ANode: PVirtualNode); override;
    function GetBoneIndex(Hash: Cardinal): Integer;
    function GetBoneList: AMesh;
    procedure AddBone(Bone: TSpFrame);
    function GetMesh: TMesh; override;
    procedure DeleteChild(Chunk: TChunk); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TSpFrame = class(TChunk) //1001
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    matrix_1: TEntMatrix;
    matrix_2: TEntMatrix;
    bone_index: Integer;
    mask: Cardinal;
    hash: Cardinal;
    name: PChar;
    num_childs: Integer;
    level: Integer;
    Childs: AChunk;
    Bones: AChunk;
    mesh: TMesh;
    Clump: Pointer;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure AddFrame(node: TXmlNode; Frame: TSpFrame);
    procedure AddTypedFrame(index: integer; nbType: integer);
    procedure Read; override;
    procedure Write; override;
    procedure ReadChilds;
    procedure WriteChilds;
    procedure AddChild(Child: TChunk);
    procedure AddBone(Bone: TChunk);
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure CheckHide(ANode: PVirtualNode); override;
    procedure ShowMesh(Hide: Boolean); override;
    procedure DeleteChild(Chunk: TChunk); override;
    function GetModel(mesh_id: integer): TRenderBlock;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TFloor = record
    hasNgonBSP: Boolean;
    NgonBSP: TChunk;
    BBox: TBBox;
  end;

  AFloors = array of TFloor;

  TFloors = class(TChunk)
    constructor Create;
    destructor Destroy; override;
  public
    floors: AFloors;
    mesh: TMesh;
    procedure Read(Chunk: TChunk);
    procedure ReadNgonBSPs(Chunk: TChunk);
    procedure Write(Chunk: TChunk);
    procedure WriteNgonBSPs(Chunk: TChunk);
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure DeleteChild(Chunk: TChunk); override;
  end;

  TWorld = class(TChunk) //1012
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    flags: Cardinal;
    photonLightingAmbient: TVect4b;
    floor_count: Cardinal;
    Floors: TFloors;
    NumZones: Cardinal;
    hasNgonBSP: Boolean;
    hasNullNodes: Boolean;
    hasWaypointMap: Boolean;
    hasMesh: Boolean;
    ModelGroup: TSpMesh; // 1000
    SectorOctree: TSectorOctree; // 1011
    NgonBSP: TSpNgonBSP; // 1019
    NullNodes: TNullNodes; // 1020
    WaypointMap: TWaypointMap; // 1021
    Zones: TZones; // 1023
    SpLights: TLightSwitchController; //1029
    mesh: TMesh;
    procedure MakeDefault(BSPFile: TBSPfile); override;
    procedure Read; override;
    procedure Write; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure DeleteChild(Chunk: TChunk); override;
  end;

  SpBSPLeaf = record
    flag: Cardinal;
    offset: Single;
    shape: Word;
    face: Word;
    v_end: Word;
  end;
  LeafIndex = Cardinal;
  SpBSPBranch = record
    flag: Cardinal;
    offset: Single;
    index: Cardinal;
  end;

  TSBlock = record
    is_mesh: Cardinal;
    flag: Cardinal;
    mesh: TRenderBlock;
    val4: Cardinal;
    val5: Cardinal;
    mindex: integer;
  end;

  PSBlock = ^TSBlock;
  PSBound = ^TSBound;

  TSBound = record
    bound: TBBox;
    val1: Cardinal;
    is_sector: Boolean;
    sector_index: Cardinal;
    sector: PSBlock;
    sbound_index: Cardinal;
    sbound: PSBound;
  end;

  TSBlock2 = Cardinal;

  TSBlock1 = record
    fl1: Single;
    fl2: Single;
    fl3: Single;
    fl4: Single;
    index1: Cardinal;
    val1: Cardinal;
    index2: Cardinal;
    val2: Cardinal;
  end;

  TSBlock18 = record
    fl1: Single;
    fl2: Single;
    fl3: Single;
    fl4: Single;
    offset: Cardinal;
    size: Cardinal;
    unkn: Cardinal;
  end;

  TVBlock1 = record
    vect: TVect4;
    fl1: Single;
    fl2: Single;
    fl3: Single;
    fl4: Single;
  end;

  TVGraph = record
    vect: TVect4;
    val: Cardinal;
    mesh_mask: Cardinal;
  end;

  TZoneObj = class(TChunk) // ZoneObj
    constructor Create();
    destructor Destroy; override;
  public
    idx: integer;
    bound: TBBox;
    hash: Cardinal;
    hasNgonBSP: Boolean;
    NgonBSP: TSpNgonBSP; //1019
    hasArea: Boolean;
    Area: TSpline; //1024
    hasBorder: Boolean;
    Border: TClump; //1005
    floor_flag: Cardinal;
    hasWard: Boolean;
    Ward: TClump; //1005
    Mesh: TMesh;
    procedure Read(Chunk: TChunk);
    procedure Write(Chunk: TChunk);
    procedure WriteChilds(Chunk: TChunk);
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure CheckHide(ANode: PVirtualNode); override;
    procedure DeleteChild(Chunk: TChunk); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  ASpBSPLeaf = array of SpBSPLeaf;
  AFaceGroup = array of LeafIndex;
  ASpBSPBranch = array of SpBSPBranch;
  ASBlock = array of TSBlock;
  ASBlock1 = array of TSBlock1;
  ASBlock2 = array of TSBlock2;
  ASBound = array of TSBound;
  AVBlock1 = array of TVBlock1;
  ASBlock18 = array of TSBlock18;
  //   AVChunks = array of TVChunks;
  AVGraph = array of TVGraph;

  TSpBSP = class(TChunk) // 1003
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    Leaf_list_size: Cardinal;
    BranchNum: Cardinal;
    num_faces: Cardinal;
    faces: ASpBSPLeaf;
    Leaf_list: AFaceGroup;
    Branches: ASpBSPBranch;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddBlock1Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddBlock2Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddBlock3Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure Partition(world: TWorld; isOctree: Boolean);
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TAtomic = class(TAtomicObj) // 1004
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    mask: Cardinal;
    hash: Cardinal;
    has_ModelGroup: Boolean;
    ModelGroup: TSpMesh;
    Mesh: TMesh;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure AddAtomic(node: TXmlNode; a_type: Cardinal);
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure DeleteChild(Chunk: TChunk); override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TLight = class(TAtomicObj) // 1007
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    val_1: Cardinal;
    val_2: Integer;
    power: Single;
    color: TVect4b;
    angle: Single;
    val_3: Single;
    val_4: Integer;
    mesh: Tmesh;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TSpOBB = record
    center: TVect4;
    matrix: TMatrix;
    extends: TVect4;
  end;

  TContOrientedBox3 = record
    Box: TSpOBB;
    resultValid: Boolean;
  end;

  TNullBox = class(TAtomicObj) // 1026
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    link: Cardinal;
    matrix: TMatrix;
    hash: Cardinal;
    emm_type: Cardinal;
    mesh: TMesh;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure AddNullBox(node: TXmlNode; a_type: integer);
    procedure CalculateOBB(box: TBBox; isBbox: boolean);
    procedure SpObbToAABB;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure CheckHide(ANode: PVirtualNode); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TCamera = class(TAtomicObj) // 1006
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    GLProject: TProjection; // 0001
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TProjection = class(TChunk) // 0001
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    render_type: Cardinal;
    render_near: Single;
    render_far: Single;
    render_fov: Single;
    render_box: TRect;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TLevelObj = class(TChunk) // 1009
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    level: Cardinal;
    procedure Read; override;
    procedure Write; override;
    function GetLevel: Integer;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
  end;

  TSpNgonList = class(TChunk) // 1018
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    num_vblock: Cardinal;
    num_sblock: Cardinal;
    vblock: AVBlock1;
    sblock: ASBlock18;
    Mesh: TMesh;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddBlock1Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddBlock2Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure CheckHide(ANode: PVirtualNode); override;
    procedure ShowMesh(Hide: Boolean); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TSpNgonBSP = class(TChunk) // 1019
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    script_type: Cardinal;
    num_block1: Cardinal;
    num_block2: Cardinal;
    sblock1: ASBlock1;
    sblock2: ASBlock2;
    hasNgonList: Boolean;
    NgonList: TSpNgonList;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddBlock1Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddBlock2Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure DeleteChild(Chunk: TChunk); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TWaypointMap = class(TChunk) // 1021
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    num_graph: Cardinal;
    val_graph: Cardinal;
    graph: AVGraph;
    Mesh: TMesh;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddGraphData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
  end;

  TZones = class(TChunk) // 1023
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    num_list: Cardinal;
    list_zones: AList;
    Mesh: TMesh;
    zones: array of TZoneObj;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddChunkBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddListData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    procedure DeleteChild(Chunk: TChunk); override;
    procedure InsertChild(Target, Chunk: TChunk); override;
  end;

  TSpline = class(TChunk) // 1024
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    num_vect: Cardinal;
    val1: Cardinal;
    val2: Cardinal;
    vectors: AVect4;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddVectData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  TUpdateRGB = record//array[1..2] of Cardinal;
    VertexIndex: Integer;
    Colour: TUColor;
  end;

  SingleVertexSwitchBlock = record
    MatBlockIndex: Cardinal;
    NumUpdateVerts: Cardinal;
    UpdateList: array of TUpdateRGB;
  end;

  TBlock20 = record
    LightingSID: Cardinal;
    NumIsWorldGeom: Cardinal;
    NumVerts: Cardinal;
  end;

    TSpRect = record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;

  TLightmapUpdateBlock = record
    LayerNum: Cardinal;
    AdditiveData: AList;
    UpdateSubRect: TSpRect;
  end;

  ALightmapUpdateBlock = array of TLightmapUpdateBlock;

  TSwitchableLightmap = record
    TextureHash: Cardinal;
    LMName: PChar;//array[1..3] of Cardinal;
    UpdateRegion: TSpRect;
    NumUpdateBlocks: Cardinal;
    NumPixToRead: Cardinal;
    LightmapUpdateBlock: ALightmapUpdateBlock;
  end;

  ASingleVertexSwitchBlock = array of SingleVertexSwitchBlock;

  TSwitchableLightData = record
    NumDependantLightmaps: Cardinal;
    Lightmaps: AList;
    NumVBlocks: Cardinal;
    VertexBlocks: ASingleVertexSwitchBlock;
  end;

  AMatBlocks = array of TBlock20;
  ASwitchableLightmap = array of TSwitchableLightmap;
  ASwitchableLightData = array of TSwitchableLightData;

  TLightSwitchController = class(TChunk) // 1029
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    MagicNumber: Cardinal;
    GammaRampPower: Single;
    NumSourceLayers: Cardinal;
    LayerRemapTable: AList;
    NumLightmaps: Cardinal;
    SwitchableLightmap: ASwitchableLightmap;
    NumSwitchLayers: Cardinal;
    SwitchableLightData: ASwitchableLightData;
    NumMatBlocks: Cardinal;
    MatBlocks: AMatBlocks;
    procedure ReadMatBlocks;
    procedure ReadSwitchableLightmap;
    procedure ReadSwitchableLightData;
    procedure WriteMatBlocks;
    procedure WriteSwitchableLightmap;
    procedure WriteSwitchableLightData;
    procedure AddLayerRemapTable(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddAdditiveData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddMatBlockSwitchInfo(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddLightmapUpdateBlockData(Node1: PVirtualNode; i: Integer; Parr:
      Pointer);
    procedure AddSwitchableLightmapData(Node1: PVirtualNode; i: Integer; Parr:
      Pointer);
    procedure AddSwitchableLightDataData(Node1: PVirtualNode; i: Integer; Parr:
      Pointer);
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
  end;

  TSpNullNode = class(TChunk)
    constructor Create();
    destructor Destroy; override;
  public
    matrix: TEntMatrix;
    bound: TBBox;
    hash: Cardinal;
    unk1: Cardinal;
    unk2: Cardinal;
    objectType: Cardinal;
    name: Pchar;
    mesh: TMesh;
    procedure Read(Chunk: TChunk);
    procedure Write(Chunk: TChunk);
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  ANullNodes = array of TSpNullNode;

  TNullNodes = class(TChunk) // 1020
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    Num: Cardinal;
    mesh: TMesh;
    WpPoints: ANullNodes;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddNullNodeData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure CheckHide(ANode: PVirtualNode); override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    procedure DeleteChild(Chunk: TChunk); override;
    procedure InsertChild(Target, Chunk: TChunk); override;
    procedure SorTNullNodes;
  end;

  TMeshList = record
    mindex: integer;
    model: TRenderBlock;
  end;
  AMeshList = array of TMeshList;

  TSectorOctree = class(TChunk) // 1011
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    mesh_num: Cardinal;
    mesh_list: AMeshList;
    sector_nums: Cardinal;
    sector_block: ASBlock;
    sbound_num: Cardinal;
    sbound_list: ASBound;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure Read; override;
    procedure Write; override;
    function GetMIndex(Model: TRenderBlock; Models: AModels): Integer;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddMeshList(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddSectorData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddSBoundData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
  end;

  TMatDictionary = class(TSetObj) // 1010
    procedure MakeDefault(BSPFile: TBSPfile); override;
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    Materials: AMaterial;
    function FindMaterialOfHash(Hash: Cardinal): TMaterialObj;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; virtual;
    procedure Clear;
    procedure AddData(Node1: PVirtualNode; i: Integer; Parr: Pointer); override;
    procedure DeleteChild(Chunk: TChunk); override;
  end;

  TEntity = class(TChunk) // 20001
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    ent_type: Cardinal;
    matrix: TEntMatrix;
    ent_index: Cardinal;
      name: Pchar;
    //Hash(ent_class, string);
    Clump: TClump; // 1005
    mesh: Tmesh;
    procedure MakeDefault(BSPFile: TBSPfile); override;
    procedure AddEntity(e_type: Cardinal; node: TXmlNode);
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure CheckHide(ANode: PVirtualNode); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  AWord = array of Word;

  TKeyVert = record
    is_vect: Boolean;
    num: Word;
    vert: AVer; // vertex
    vert_ind: AWord;
    vert_func: AWord;
    num2: Word;
    norm: AVer; // normal
    norm_ind: AWord;
    norm_func: AWord;
  end;

  TKeyUVBlock = record
    num: Word;
    U_keys: AWord; // U1
    V_keys: AWord; // V1
    num2: Word;
    U2_keys: AWord; // U2
    V2_keys: AWord; // V2
  end;

  TKeyFunc = record
    vert_type: Cardinal;
    norm_type: Cardinal;
    vert: TVer;
    norm: TVer;
  end;

  AKeyRot = array of TKeyRot;
  AKeyVert = array of TKeyVert;
  AKeyUVBlock = array of TKeyUVBlock;
  AByte = array of Byte;

  TAnimKeyBlock = class(TChunk) // 1015
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    key_type: Cardinal;
    bone_hash: Cardinal;
    acceleration: Single;
    key_num: Cardinal;
    mesh_id: SmallInt;
    is_bound: Boolean;
    bound: TBBox;
    ext_pos: Boolean;
    is_time_keys: Boolean;
    time_keys: AFloat;
    rot_keys: AKeyRot; // rotate
    pos_keys: AVer; // pos
    vert_keys: AKeyVert; // vertex
    UV_keys: AKeyUVBlock; // UV
    vis_keys: AByte; // visible
    is_func: Boolean;
    vect_func: TKeyFunc; // vector size
    bone_name: string;
    Clip: TDictAnim;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure AddTimeData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddRotData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddVBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddWBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddWIBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddWTBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddBlock2Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddUVBlockData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddLayerRemapTable(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure LoadRotFlomDAE(BoneHash: Cardinal; TimeMatrix: ATimeMatrix; Dzero:
      Boolean);
    procedure LoadPosFlomDAE(BoneHash: Cardinal; TimeMatrix: ATimeMatrix; Dzero:
      Boolean);
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;
  AFrames = array of TFrame;
  TBoneBlock = record
    boneHash: Cardinal;
    bone: TSpFrame;
    frameHash: Cardinal;
    frame: PFrame;
  end;

  AKeys = array of TAnimKeyBlock;
  ABoneBlock = array of TBoneBlock;

  TDictAnim = class(TChunk) // 1027
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    hash: Cardinal;
    minTime: Single;
    maxTime: Single;
    bone_num: Cardinal;
    bone_block: ABoneBlock;
    keys_num: Cardinal;
    Keys: AKeys;
      name: Pchar;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
      PPropertyData); override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure AddBoneData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddKeysData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure LinkFrames(Frames: AFrames);
    function LinkBones(Bones: AChunk): Boolean;
    function GetBoneName(Hash: Cardinal): string;
    function GetBone(Hash: Cardinal): TSpFrame;
    procedure InsertChild(Target, Chunk: TChunk); override;
    procedure DeleteChild(Chunk: TChunk); override;
    procedure LoadFromDAE(COLLADA: TXmlNode; BoneFrame: ABoneFrame; ClipName:
      string);
    function CopyChunk(nBSP: TBSPFile): TChunk; override;
  end;

  AClips = array of TDictAnim;

  TAnimDictionary = class(TChunk) // 1017
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    NumFrames: Cardinal;
    Frames: AFrames;
    NumClips: Cardinal;
    Clips: AClips;
    procedure MakeDefault(BSPFile: TBSPFile); override;
    procedure Read; override;
    procedure Write; override;
    procedure Clear;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure UpdateClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode);
    procedure AddFramesData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddClipData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    procedure MergeAnims;
    function FindAnimOfHash(Hash: Cardinal): TDictAnim;
    procedure DeleteChild(Chunk: TChunk); override;
    procedure InsertChild(Target, Chunk: TChunk); override;
    procedure ClearBonePoses(Clip: TDictAnim);
    function LoadFromDAE(COLLADA: TXmlNode; clipname: string): TDictAnim;
  end;

  AEntities = array of TEntity;

  TEntities = class(TSetObj) // 20000
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    Entities: AEntities;
    mesh: TMesh;
    procedure MakeDefault(BSPFile: TBSPfile); override;
    procedure Read; override;
    procedure Write; override;
    procedure Clear;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddData(Node1: PVirtualNode; i: Integer; Parr: Pointer); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    procedure DeleteChild(Chunk: TChunk); override;
    procedure InsertChild(Target, Chunk: TChunk); override;
  end;

  TTextures = class(TSetObj) // 20002
    constructor Create(Chunk: TChunk);
    destructor Destroy; override;
  public
    Textures: ATextures;
    procedure MakeDefault(BSPFile: TBSPfile); override;
    procedure Read; override;
    procedure Write; override;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure Clear;
    procedure AddData(Node1: PVirtualNode; i: Integer; Parr: Pointer); override;
    function AreDuplicates(Texture: TTextureOpenGL): Boolean;
    function FindTextureOfHash(Hash: Cardinal): TTextureOpenGL;
    function FindTextureOfName(name: string): TTextureOpenGL;
    procedure DeleteChild(Chunk: TChunk); override;
    function AddTexture(node: TXmlNode; file_path: string): TTextureOpenGL;
  end;

  TBSPfile = class(TChunk) //3
    constructor Create();
    destructor Destroy; override;
  private
    ChkIdx: integer;
    ShpIdx: integer;
    Idx: Integer;
    Pos: integer;
    Size: integer;
    filesize: Integer;
    Uncompress: Integer;
    curChank: TChunk;
    function OutSize: Boolean;
  public
    bspfilename: string;
    iscompress: boolean;
    BSPList: TBSP;
    Textures: TTextures;
    Materials: TMatDictionary;
    World: TWorld;
    AnimLib: TAnimDictionary;
    Entities: TEntities;
    Chunks: AChunk;
    BoneLib: AChunk;
    LastClump: TClump;
    IndexOffset: Integer;
    Mesh: TMesh;
    procedure ClearData;
    procedure AddBone(Bone: TChunk);
    function GetBone(Hash: Cardinal): TSpFrame;
    function GetProgress: Integer;
    function GetMaxProgress: Integer;
    function AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode:
      PVirtualNode): PVirtualNode; override;
    procedure AddFields(CustomTree: TCustomVirtualStringTree); override;
    function GetMesh: TMesh; override;
    procedure ShowMesh(Hide: Boolean); override;
    procedure LoadBSPFile(filename: string);
    procedure SaveBSPFile(filename: string);
    function ReadBSPChunk(level: Integer = 0): TChunk;
    procedure WriteBSPChunk(Chunk: TChunk);
    procedure ReadBSPChunks;
    procedure WriteBSPChunks;
    function GetPoint: Pointer;
    procedure SaveTGA(Name: string; texti: TTextureOpenGL);
    procedure ZLibDecompressStream(InStream, OutStream: TStream);
    procedure DecompressStream;
    procedure CompressStream;
    property Progress: Integer read GetProgress;
    property ProgressMax: Integer read GetMaxProgress;
    function FoundIDType(IDType: Integer): TChunk;
    procedure GenerateTemplateChunks(index: Cardinal);
    procedure AddChunk(Chunk: TChunk);
  end;

  TTransView = record
    xpos, ypos, zpos: GLfloat;
    xrot, yrot, zrot: GLfloat;
    zoom, Per: GLfloat;
  end;

  T3DModel = record
    glList: Integer;
    SizeBox: TBox;
    Texture: Integer;
    Matrix: TMatrix;
    Mult: Boolean;
  end;
  A3DModels = array of T3DModel;

  TIndex = record
    ID: Integer;
    Values: array[0..12] of Integer;
  end;

  TStEdByte = record
    //sbyte,ebyte:smallint;
    id: Integer;
  end;

  TBSP = class
    constructor Create;
    destructor Destroy; override;
  public
    BSPfile: TBSPfile;
    BSPfiles: array of TBSPfile;
    Mesh3D: TMesh;
    MeshFiles: TMesh;
    //    AnimClips: TAnimClips;
    LastXImage: Integer;
    ViewUV: Boolean;
    InsertIndex: Integer;
    BaseNew: Integer;
    Idx: Integer;
    BaseNode: TTreeNode;
    Buf: Pointer;
    ReBuild: boolean;
    Loading: boolean;
    UpdateAnimFlag: boolean;
    BoneList: AMesh;
    procedure LoadBSPFileName(FileName: string);
    procedure SaveBSP(SaveDialog: TSaveDialog);
    procedure CreateTemplateBSPFile(index: Cardinal);
    procedure TestDae(filename: string);
    procedure ImportDAE(filename: string);
    function GetValidPath(path, filename: string): string;
    procedure ExportDAE(FileName: string; Chunk: TChunk; Options: DAEOptions;
      ScaleFactor: Single);
    function ImportDAEAnimClip(FileName: string; AnimLib: TAnimDictionary;
      Options:
      DAEOptions;
      clipname: string): TDictAnim;
    procedure AddDaeChunk(D: TNativeXml; node: TXmlNode; Chunk: TChunk);
    procedure AddAnimChunk(D: TNativeXml; Chunk: TChunk);
    procedure ClearBSPFiles;
    procedure AddBSPFile;
    procedure SetMeshCheck(Node: PVirtualNode; TreeView:
      TCustomVirtualStringTree);
  end;

  //function GetFullName(Name:String):String;

type
  TStringArray = array of string;

type
  TCompressThread = class(TThread)
  private
    { Private declarations }
    fbsp: TBSPfile;
  protected
    procedure Execute; override;
  public
    constructor Create(bsp: TBSPfile);
  end;

function ToTime(milisec: Longword): Single;

procedure oglAxes;
procedure oglGrid(GridMax: Integer);
procedure Light(var Color: Color4D);

const
  APPVER = 'BSPViewer v.2.1 by AlexBond/Woitek1993';

  MAX_LOAD = 10;

  MaxMaps = 10000;
  MaxType = 1000;
  MODEL3DBUF = 10000;

  FontGL = 2000;
  MaxDeph = 100000.0; // максимальная глубина

  Blendval: array[0..11] of Integer =
    (GL_ZERO, GL_ZERO, GL_ONE,
    GL_SRC_COLOR, GL_ONE_MINUS_SRC_COLOR,
    GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA,
    GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA,
    GL_DST_COLOR, GL_ONE_MINUS_DST_COLOR, GL_SRC_ALPHA_SATURATE);

  objAxes = 1;
  objTarget = 2;
  objGrid = 3;
  objBox = 4;
  objOrbitX = 5;
  objOrbitY = 6;
  objOrbitZ = 7;
  objCollGeo = 10;
  objTriangleGeo = 11;
  objLight = 12;

  ambient: color4d = (0.1, 0.1, 0.1, 1.0);
  //  ambient2: color4d = ( 0.1, 0.1, 0.1, 1.0 );
  l_position: color4d = (0.0, 32.0, 0.0, 1.0);
  mat_diffuse: color4d = (0.6, 0.6, 0.6, 1.0);
  mat_specular: color4d = (1.0, 1.0, 1.0, 1.0);
  tmp_fog_color: color4d = (0.0, 0.2, 0.5, 1.0);
  mat_shininess: GLfloat = 50.0;

  ATypePosition = $0102;
  ATypeRotation = $0103;
  ATypeScale = $0104;
  AType2DTex = $0401;
  ATypeReScale = $0904;
  ATypeTexture = $1100;
  ATypeChilds = $0100;
  ATypeX = 0;
  ATypeY = 1;
  ATypeZ = 2;

  TORAD = Pi / 180;
  RADIANS = 180 / Pi;

  ZereVector: Tver = (0, 0, 0);
  TestVert: Tver = (0.0, 0, 0);

  nVn = #13#10;

var
  BSP: TBSP;
  GlobalID: Integer;
  CompressBSP: Boolean = false;
  GrafKeys: array of TGrafKey;
  EdMode, AnimEd: Boolean;
  SelectKey, SKey: PKeyFrame;
  SelectKdata: PKeyData;
  SelectType: Integer;
  SelectObjName: string;
  ShowGraph: Boolean;
  //  AnimClip: TAnimClip;
  MAxis, AAxis: TAxis;
  PSelect, PTarget: TPoint;
  wd, wdup: TXYZ;
  SelectObj, SelectObjOn: Integer;
  Bbitpoint, bBitPoint2: Pointer;
  StarPoint, EmittPoint, LightPoint, PyramidPoint: Pointer;

  AnimTimer: THRTimer;
  AnimClips: TAnimClips;
  CurAnimClip: TAnimClip;
  BaseClip: TAnimClip;

  MaxAnimTime: Single;

  Active3DModel: Integer = MODEL3DBUF;
  TransView, TVModel: TTransView;
  TransSpeed: Tvector;
  TransOnX: Integer;
  TransOnY: Integer;
  GLwidth, GLheight: Integer;
  position2: color4d = (0.0, 0.0, 0.0, 1.0);
  MainBox: TBox;
  NTexture: Integer = 0;
  LastTexture: Integer = 0;
  BSPImport, BSPReplace, ImageReady, BSP3DReady, AnimReady: Boolean;
  SelectMode,
    MoveMode, MoveReady,
    RotateMode, RotateReady,
    ScaleMode, ScaleReady,
    Particle_mode,
    ZoomActivePox, TextureB, FillMode, MoveFirts,
    ScaleFirts, RotateFirts,
    CtrlMove, Ctrl, ShiftOn, FullSize, ChillMode: Boolean;
  ChillMax: Integer;
  // AddClick,DeleteClick:TNotifyEvent;
 //  AddMesh,DeleteMesh:TNotifyEvent;
 //  StrArray: XConteiners;
 //      CntrArr:XContainers;
  ActiveMesh: TMesh;
  ObjMatrix: TMatrix;

  //Import Stuff
  DaeRoot: TXmlNode;                                                      
  DaeSkinBones: TStringList;
  uMaterials: TDictionary;
  templateIndex: Cardinal;
  //Export Stuff
  DaeBlenderBones: AMesh;
  ccFrame: TSpFrame;
  BlenderBoneIndex: integer;
  tDirtyScenarioFlag: Boolean;

  TEXTUREBASE: Integer = 0;
  TEXTURESECOND: Integer = 100000;
  TEXTURELUMP: Integer = 200000;

var
  ActiveMatrix, TempMatrix: TMatrix;
  NKey: Tver;
  MovePoxPos, ScalePoxPos, RotatePoxPos: Tver;
  p: TXYZ;
  theta, alpha, beta, gamma: single;

implementation

{ TBSPfile }

procedure TBSPfile.AddChunk(Chunk: TChunk);
var
  len: integer;
begin
  Chunks[ChkIdx] := Chunk;
  inc(ChkIdx);
end;

procedure TBSPfile.ClearData;
var
  i, len: integer;
begin
  len := Length(Chunks);
  for i := 0 to len - 1 do
    FreeAndNil(Chunks[i]);
  Entities := nil;
  AnimLib := nil;
  World := nil;
  Materials := nil;
  Textures := nil;
  SetLength(Chunks, 0);
  SetLength(BoneLib, 0);
end;

constructor TBSPfile.Create;
begin
  Mem := TMemoryStream.Create;
  Mesh := TMesh.Create;
  IDType := 3;
end;

destructor TBSPfile.Destroy;
begin
  Mesh.Clear;
  ClearData;
  Mem.Free;
  inherited;
end;

function TBSPfile.GetMaxProgress: Integer;
begin
  result := Mem.Size;
end;

function TBSPfile.GetPoint: Pointer;
begin
  Result := Pointer(Longword(Mem.Memory) + Mem.Position);
end;

function TBSPfile.GetProgress: Integer;
begin
  result := GlobalPos;
end;

{ Decompress a stream }

procedure TBSPfile.ZLibDecompressStream(InStream, OutStream: TStream);
const
  BufferSize = 32768;
var
  FileSize: integer;
  ZStream: TGZDecompressionStream;
  Count: Integer;
  Buffer: array[0..BufferSize - 1] of Byte;
begin
  FileSize := GZDecompressStreamSize(InStream);
  InStream.Seek(0, soFromBeginning);
  OutStream.Size := FileSize;
  Size := FileSize * 2;
  Uncompress := 0;
  ZStream := TGZDecompressionStream.Create(InStream);
  try
    while True do
    begin
      Count := ZStream.Read(Buffer, BufferSize);
      Inc(Uncompress, Count);
      if Count <> 0 then
        OutStream.WriteBuffer(Buffer, Count)
      else
        Break;
    end;
  finally
    ZStream.Free;
  end;
end;

procedure TBSPfile.DecompressStream;
var
  newfile: TMemoryStream;
begin
  newfile := TMemoryStream.Create;
  ZLibDecompressStream(Mem, newfile);
  Mem.Free;
  Mem := newfile;
end;

{ Compress a stream }

procedure TBSPfile.CompressStream;
var
  newfile: TMemoryStream;
begin
  newfile := TMemoryStream.Create;
  mem.Seek(0, soBeginning);
  GZCompressStream(mem, newfile);
  mem.Free;
  mem := newfile;
end;

procedure TBSPfile.AddFields(CustomTree: TCustomVirtualStringTree);
var
  num: integer;
begin
  inherited;
  AddTreeData(nil, 'File Name', nil, BSPString, ExtractFileName(bspfilename));
  AddTreeData(nil, 'File Size', @filesize, BSPUint);
  AddTreeData(nil, 'Compressed', @iscompress, BSPBool);
  AddTreeData(nil, 'Data Size', @size, BSPUint);
  if Textures <> nil then
    AddTreeData(nil, 'Textures', @Textures.Num, BSPUint);
  if Materials <> nil then
    AddTreeData(nil, 'Materials', @Materials.Num, BSPUint);
  if Entities <> nil then
    AddTreeData(nil, 'Entities', @Entities.Num, BSPUint);
  if AnimLib <> nil then
    AddTreeData(nil, 'Animations', @AnimLib.NumClips, BSPUint);
  AddTreeData(nil, 'Chunks', @Idx, BSPUint);
end;

procedure TBSPfile.LoadBSPFile(filename: string);
var
  p: pointer;
begin
  iscompress := false;
  pos := 0;
  size := 1;
  Uncompress := 0;
  Mem.Clear;
  ClearData;
  bspfilename := filename;
  Mem.LoadFromFile(filename);
  p := GetPoint;
  filesize := Mem.Size;
  if integer(p^) = 559903 then
  begin
    iscompress := true;
    DecompressStream;
  end;
  ReadBSPChunks;
  size := Mem.Size;
  Mem.Clear;
end;

type
  TgaHead = record
    zero: Word;
    typeTGA: Word;
    zero2: Longword;
    zero3: Longword;
    Width: Word;
    Height: Word;
    ColorBit: Word;
  end;

procedure TBSPfile.WriteBSPChunk(Chunk: TChunk);
var
  version, size_pos, oldpos: integer;
begin
  try
    Chunk.Mem := Mem;
    Mem.Write(Chunk.IDType, 4);
    size_pos := Mem.Position;
    Mem.Write(Chunk.Size, 4);
    version:= 1698;
    Mem.Write(version, 4);
    //Mem.Write(Chunk.Version, 4);
    Chunk.BSPoint := Pointer(Mem.Position);
    Chunk.Write;
    if Chunk.IDType = C_Frame then
      TSpFrame(Chunk).WriteChilds;
    oldpos := Mem.Position;
    Mem.Position := size_pos;
    Mem.Write(Chunk.Size, 4);
    Mem.Position := oldpos;
  except
    on E: Exception do
    begin
      ShowMessage(Format('Error "%s" in WriteBSPChunk() chunk type:%d id:%d',
        [E.ClassName, Chunk.IDType, chunk.ID]));
    end;
  end;
end;

function TBSPfile.ReadBSPChunk(level: Integer = 0): TChunk;
var
  num: Integer;
var
  Chunk: TChunk;
begin
  Chunk := TChunk.Create(nil);

  Mem.Read(Chunk.IDType, 4);
  Chunk.TypeName := format('%d', [Chunk.IDType]);

  Mem.Read(Chunk.Size, 4);
  Mem.Read(Chunk.Version, 4);
  Chunk.ID := GlobalID;
  Inc(Idx);
  Inc(GlobalID);
  Chunk.BSP := self;
  Chunk.BSPoint := GetPoint;
  Chunk.point := Chunk.BSPoint;
  curChank := Chunk;
  Mem.Seek(Chunk.Size, soCurrent);
  Pos := Uncompress + Mem.Position;
  Chunk := Chunk.ChunkTypeCreate(True);
  Chunk.Read;
  if Chunk.IDType = 1001 then
  begin // Bone
    TSpFrame(Chunk).level := level;
    TSpFrame(Chunk).ReadChilds;
  end;
  Chunk.CheckSize;
  Result := Chunk;
end;

const
  MAXCHANKS = 50000;

procedure TBSPfile.ReadBSPChunks;
var
  pos: cardinal;
  size: cardinal;
  Chunk: TChunk;
 // i: integer;
begin
  // пока не конец файла читать чанки
  Mem.Seek(0, soBeginning);
  size := Mem.Size;
  // But.TreeProgress.Max:= size;
  SetLength(Chunks, MAXCHANKS);
  ChkIdx := 0;
  Idx := 0;
  ShpIdx := 0;
  while Mem.Position < size do
  begin
    Chunk := ReadBSPChunk;
    {if Chunk.IDType = 20001 then
      break;}    
    AddChunk(Chunk);
    But.TreeProgress.Position := Round(Mem.Position / size * 100);
  end;
  SetLength(Chunks, ChkIdx);
end;

procedure TBSPfile.WriteBSPChunks;
var
  i: integer;
begin
  But.TreeProgress.Max := High(Chunks);
  for i := 0 to High(Chunks) do
  begin
    WriteBSPChunk(Chunks[i]);
    But.TreeProgress.Position := i;
  end;
end;

procedure TChunk.Write;
begin
  // virtual
end;

// Read / Write

function TChunk.ReadFloatBlock: Single;
begin
  Result := Single(BSPoint^);
  Inc(Longword(BSPoint), 4);
end;

procedure TChunk.WriteFloatBlock(Val: Single);
begin
  Mem.Write(Val, 4);
end;

function TChunk.ReadFloat: Single;
begin
  Result := Single(BSPoint^);
  Inc(Longword(BSPoint), 4);
end;

procedure TChunk.WriteFloat(Val: Single);
begin
  Mem.Write(Val, 4);
end;

function TChunk.ReadByteBlock: Cardinal;
begin
  Result := DWord(BSPoint^);
  Inc(Longword(BSPoint), 4);
end;

procedure TChunk.WriteByteBlock(Val: Cardinal);
begin
  Mem.Write(Val, 4);
end;

function TChunk.ReadSPDword: Cardinal;
begin
  Result := DWord(BSPoint^);
  Inc(Longword(BSPoint), 4);
end;

procedure TChunk.WriteSPDword(Val: Cardinal);
begin
  Mem.Write(Val, 4);
end;

function TChunk.ReadSPWord: Word;
begin
  Result := Word(BSPoint^);
  Inc(Longword(BSPoint), 2);
end;

procedure TChunk.WriteSPWord(Val: Word);
begin
  Mem.Write(Val, 2);
end;

function TChunk.ReadDword(): Cardinal;
begin
  Result := DWord(BSPoint^);
  Inc(Longword(BSPoint), 4);
end;

procedure TChunk.WriteDword(Val: Cardinal);
begin
  Mem.Write(Val, 4);
end;

procedure TChunk.WriteBoolean(Val: Boolean);
var
  b: cardinal;
begin
  b := IfThen(Val, 1, 0);
  Mem.Write(b, 4);
end;

function TChunk.ReadVect4b(): TVect4b;
begin
  Result[1] := Byte(BSPoint^);
  Inc(Longword(BSPoint));
  Result[2] := Byte(BSPoint^);
  Inc(Longword(BSPoint));
  Result[3] := Byte(BSPoint^);
  Inc(Longword(BSPoint));
  Result[4] := 0;
end;

procedure TChunk.WriteVect4b(Val: TVect4b);
begin
  Mem.Write(Val[1], 3);
end;

function TChunk.ReadBound: TBBox;
begin
  Result.max := ReadVec3f4;
  Result.min := ReadVec3f4;
end;

procedure TChunk.WriteBound(Val: TBBox);
begin
  WriteVec3f4(Val.max);
  WriteVec3f4(Val.min);
end;

procedure TChunk.ReadBytesBlock(P: Pointer; Size: Integer);
begin
  Move(BSPoint^, P^, Size);
  Inc(Longword(BSPoint), Size);
end;

procedure TChunk.WriteBytesBlock(P: Pointer; Size: Integer);
begin
  Mem.Write(P^, Size);
end;

function TChunk.ReadBytesMBlock(Size: Integer): Pointer;
var
  NewPoint: Pointer;
begin
  GetMem(NewPoint, Size);
  Move(BSPoint^, NewPoint^, Size);
  Inc(Longword(BSPoint), Size);
  Result := NewPoint;
end;

type
  BArray = array[0..1] of Byte;
  PBArray = ^BArray;
  DArray = array[0..1] of Dword;
  PDArray = ^DArray;

procedure TChunk.WriteBytesMBlock(Val: Pointer; Size: Integer);
var
  pix: Integer;
  b4map: Pointer;
  bp: PBArray;
  b4: PDArray;
begin
  bp := Val;
  b4map := AllocMem(Size * 4);
  b4 := b4map;
  for pix := 0 to Size - 1 do
    b4[pix] := Byte(bp[pix]);
  Mem.Write(b4map^, Size * 4);
  FreeMem(b4map);
end;

function TChunk.ReadString: Pchar;
var
  len, i: Integer;
  c: Char;
  str: Pchar;
begin
  len := ReadByteBlock;
  if len > 0 then
  begin
    str := StrAlloc(len + 1);
    for i := 0 to len - 1 do
    begin
      c := Char(ReadByteBlock);
      if i <> len then
        str[i] := c;
    end;
  end
  else
    str := nil;

  result := str;
end;

procedure TChunk.WriteString(Val: Pchar);
var
  len, i: Integer;
  c: Char;
  Char4: Cardinal;
begin
  len := Length(Val);
  if len > 0 then
    len := len + 1;
  WriteByteBlock(len);
  if len > 0 then
  begin
    for i := 0 to len - 1 do
    begin
      c := Val[i];
      Char4 := Byte(c);
      WriteByteBlock(Char4);
    end;
  end;
end;

function TChunk.ReadStringSize(Size: Integer): Pchar;
var
  len, limit, dlen: Integer;
  str: Pchar;
begin

  len := ReadSPDWord;
  limit := size - 1;
  if (len <= limit) then
    limit := len;
  if limit > 0 then
  begin
    str := StrAlloc(limit + 1);
    strlcopy(str, PChar(BSPoint), limit);
    Inc(Longword(BSPoint), limit);
  end
  else
    str := nil;
  // if limit>=0 then  str[limit]:=#0;
  // dlen := len - limit;
 //  if  dlen > 0 then Inc(Longword(BSPoint), dlen);
  result := str;
end;

function TChunk.ReadStringSizeWithoutLen(Size: Integer): Pchar;
var
  str: Pchar;
begin
   if Size > 0 then
   begin
     str := StrAlloc(Size + 1);
     strlcopy(str, PChar(BSPoint), Size);
     Inc(Longword(BSPoint), Size);
   end
   else
    str:= nil;
   result := str;
end;


procedure TChunk.WriteStringSize(Val: Pchar; Size: Integer);
var
  len, limit, dlen: Integer;
  zero: byte;
begin
  len := Length(Val);
  WriteSPDWord(len);
  limit := size - 1;
  if (len <= limit) then
    limit := len;
  Mem.Write(val^, limit);
  // zero:=0;
 //  Mem.Write(zero,1);
end;

function TChunk.ReadVec3f4: TVect4;
begin
  Result[1] := ReadFloat;
  Result[2] := ReadFloat;
  Result[3] := ReadFloat;
  Result[4] := 1.0;
end;

procedure TChunk.WriteVec3f4(Val: TVect4);
begin
  Mem.Write(Val[1], 4);
  Mem.Write(Val[2], 4);
  Mem.Write(Val[3], 4);
end;

function TChunk.ReadDouble;
begin
  Int64Rec(Result).Lo := ReadByteBlock;
  Int64Rec(Result).Hi := ReadByteBlock;
end;

procedure TChunk.WriteDouble(Val: Uint64);
begin
  Mem.Write(Val, 8);
end;

function TChunk.ReadMxBlock: TEntMatrix;
var
  i: integer;
begin
  for i := 1 to 4 do
  begin
    Result.m[i][1] := ReadFloat;
    Result.m[i][2] := ReadFloat;
    Result.m[i][3] := ReadFloat;
    Result.m[i][4] := 0.0;
  end;
  Result.m[4][4] := 1.0;
  Result.mask := ReadDouble;
  MatrixDecompose(Result.m, Result.t[0], Result.t[1], Result.t[2]);
end;

procedure TChunk.WriteMxBlock(Val: TEntMatrix);
var
  i: integer;
begin
  for i := 1 to 4 do
  begin
    WriteFloat(Val.m[i][1]);
    WriteFloat(Val.m[i][2]);
    WriteFloat(Val.m[i][3]);
  end;
  WriteDouble(Val.mask);
end;

function TChunk.ReadColor: TUColor;
var
  color: TUColor;
begin
  color[0] := Byte(ReadByteBlock);
  color[1] := Byte(ReadByteBlock);
  color[2] := Byte(ReadByteBlock);
  color[3] := Byte(ReadByteBlock);
  Result := color;
end;

procedure TChunk.WriteColor(Val: TUColor);
begin
  WriteByteBlock(Val[0]);
  WriteByteBlock(Val[1]);
  WriteByteBlock(Val[2]);
  WriteByteBlock(Val[3]);
end;

const
  HashValues: array[0..255] of Cardinal =
    (0, $4C11DB7, $9823B6E, $0D4326D9, $130476DC,
    $17C56B6B, $1A864DB2, $1E475005, $2608EDB8, $22C9F00F,
    $2F8AD6D6, $2B4BCB61, $350C9B64, $31CD86D3, $3C8EA00A,
    $384FBDBD, $4C11DB70, $48D0C6C7, $4593E01E, $4152FDA9,
    $5F15ADAC, $5BD4B01B, $569796C2, $52568B75, $6A1936C8,
    $6ED82B7F, $639B0DA6, $675A1011, $791D4014, $7DDC5DA3,
    $709F7B7A, $745E66CD, $9823B6E0, $9CE2AB57, $91A18D8E,
    $95609039, $8B27C03C, $8FE6DD8B, $82A5FB52, $8664E6E5,
    $0BE2B5B58, $0BAEA46EF, $0B7A96036, $0B3687D81, $0AD2F2D84,
    $0A9EE3033, $0A4AD16EA, $0A06C0B5D, $0D4326D90, $0D0F37027,
    $0DDB056FE, $0D9714B49, $0C7361B4C, $0C3F706FB, $0CEB42022,
    $0CA753D95, $0F23A8028, $0F6FB9D9F, $0FBB8BB46, $0FF79A6F1,
    $0E13EF6F4, $0E5FFEB43, $0E8BCCD9A, $0EC7DD02D, $34867077,
    $30476DC0, $3D044B19, $39C556AE, $278206AB, $23431B1C,
    $2E003DC5, $2AC12072, $128E9DCF, $164F8078, $1B0CA6A1,
    $1FCDBB16, $18AEB13, $54BF6A4, $808D07D, $0CC9CDCA,
    $7897AB07, $7C56B6B0, $71159069, $75D48DDE, $6B93DDDB,
    $6F52C06C, $6211E6B5, $66D0FB02, $5E9F46BF, $5A5E5B08,
    $571D7DD1, $53DC6066, $4D9B3063, $495A2DD4, $44190B0D,
    $40D816BA, $0ACA5C697, $0A864DB20, $0A527FDF9, $0A1E6E04E,
    $0BFA1B04B, $0BB60ADFC, $0B6238B25, $0B2E29692, $8AAD2B2F,
    $8E6C3698, $832F1041, $87EE0DF6, $99A95DF3, $9D684044,
    $902B669D, $94EA7B2A, $0E0B41DE7, $0E4750050, $0E9362689,
    $0EDF73B3E, $0F3B06B3B, $0F771768C, $0FA325055, $0FEF34DE2,
    $0C6BCF05F, $0C27DEDE8, $0CF3ECB31, $0CBFFD686, $0D5B88683,
    $0D1799B34, $0DC3ABDED, $0D8FBA05A, $690CE0EE, $6DCDFD59,
    $608EDB80, $644FC637, $7A089632, $7EC98B85, $738AAD5C,
    $774BB0EB, $4F040D56, $4BC510E1, $46863638, $42472B8F,
    $5C007B8A, $58C1663D, $558240E4, $51435D53, $251D3B9E,
    $21DC2629, $2C9F00F0, $285E1D47, $36194D42, $32D850F5,
    $3F9B762C, $3B5A6B9B, $315D626, $7D4CB91, $0A97ED48,
    $0E56F0FF, $1011A0FA, $14D0BD4D, $19939B94, $1D528623,
    $0F12F560E, $0F5EE4BB9, $0F8AD6D60, $0FC6C70D7, $0E22B20D2,
    $0E6EA3D65, $0EBA91BBC, $0EF68060B, $0D727BBB6, $0D3E6A601,
    $0DEA580D8, $0DA649D6F, $0C423CD6A, $0C0E2D0DD, $0CDA1F604,
    $0C960EBB3, $0BD3E8D7E, $0B9FF90C9, $0B4BCB610, $0B07DABA7,
    $0AE3AFBA2, $0AAFBE615, $0A7B8C0CC, $0A379DD7B, $9B3660C6,
    $9FF77D71, $92B45BA8, $9675461F, $8832161A, $8CF30BAD,
    $81B02D74, $857130C3, $5D8A9099, $594B8D2E, $5408ABF7,
    $50C9B640, $4E8EE645, $4A4FFBF2, $470CDD2B, $43CDC09C,
    $7B827D21, $7F436096, $7200464F, $76C15BF8, $68860BFD,
    $6C47164A, $61043093, $65C52D24, $119B4BE9, $155A565E,
    $18197087, $1CD86D30, $29F3D35, $65E2082, $0B1D065B,
    $0FDC1BEC, $3793A651, $3352BBE6, $3E119D3F, $3AD08088,
    $2497D08D, $2056CD3A, $2D15EBE3, $29D4F654, $0C5A92679,
    $0C1683BCE, $0CC2B1D17, $0C8EA00A0, $0D6AD50A5, $0D26C4D12,
    $0DF2F6BCB, $0DBEE767C, $0E3A1CBC1, $0E760D676, $0EA23F0AF,
    $0EEE2ED18, $0F0A5BD1D, $0F464A0AA, $0F9278673, $0FDE69BC4,
    $89B8FD09, $8D79E0BE, $803AC667, $84FBDBD0, $9ABC8BD5,
    $9E7D9662, $933EB0BB, $97FFAD0C, $0AFB010B1, $0AB710D06,
    $0A6322BDF, $0A2F33668, $0BCB4666D, $0B8757BDA, $0B5365D03,
    $0B1F740B4);

function TChunk.MakeHash(data: Pchar; size: integer): Cardinal;
var
  Hash: Cardinal;
  i: integer;
begin
  Hash := 0;
  for i := 0 to size - 1 do
    Hash := HashValues[(Hash shr 24) xor Byte(data[i])] xor (Hash shl 8);
  result := size xor Hash;
end;

//Ttexture Obj

function TTextureOpenGL.BitmapHash(img: TImage_block): Cardinal;
begin
  Result := MakeHash(img.bitmap, img.height * img.bytewidth);
end;

function TBSPfile.OutSize: Boolean;
begin
  // result:=(LongWord(BSPoint)-LongWord(CurChank.point)) >= Longword(CurChank.Size);
end;

procedure TBSPfile.SaveTGA(Name: string; texti: TTextureOpenGL);
var
  VirtualBufer: TMemoryStream;
  tga: TgaHead;
  bmp: TBitmap;
begin
  // bmp:=MakeBMPImage(texti,false);
  VirtualBufer := TMemoryStream.Create;
  tga.zero := 0;
  tga.zero2 := 0;
  tga.zero3 := 0;
  tga.typeTGA := 2;
  tga.Width := bmp.Width;
  tga.Height := bmp.Height;
  tga.ColorBit := 32;
  VirtualBufer.Write(tga, SizeOf(tga) - 2);
  VirtualBufer.Write(Bmp.scanline[tga.Height - 1]^,
    tga.Height * tga.Width * (tga.ColorBit div 8));
  VirtualBufer.SaveToFile(Name);
  VirtualBufer.Free;
end;

function TBSPfile.FoundIDType(IDType: Integer): TChunk;
var
  i, Count: integer;
  found: boolean;
begin
  Result := nil;
  Count := Length(Chunks);
  for i := 0 to Count - 1 do
    if (Chunks[i] <> nil) and (Chunks[i].IDType = IDType) then
    begin
      Result := Chunks[i];
      break;
    end;
end;

procedure TBSPfile.GenerateTemplateChunks(index: Cardinal);
var
  lTextures: TTextures;
  lMatDictionary: TMatDictionary;
  lWorld: TWorld;
  lEntities: TEntities;
  lAnimDictionary: TAnimDictionary;
begin
  ChkIdx := 0;
  Idx := 0;
  ShpIdx := 0;

  bspfilename := 'Template.bsp';
  iscompress := false;
  pos := 0;
  size := 1;
  Uncompress := 0;
  Mem.Clear;
  ClearData;
  SetLength(Chunks, MAXCHANKS);

  templateIndex := index;

  lTextures := TTextures.Create(nil);
  lTextures.MakeDefault(self);
  AddChunk(lTextures);
  lMatDictionary := TMatDictionary.Create(nil);
  lMatDictionary.MakeDefault(self);
  AddChunk(lMatDictionary);
  lWorld := TWorld.Create(nil);
  lWorld.MakeDefault(self);
  AddChunk(lWorld);
  if index <> 1 then
  begin
    lEntities := TEntities.Create(nil);
    lEntities.MakeDefault(self);
    AddChunk(lEntities);
  end
  else
  begin //Animation
    lAnimDictionary := TAnimDictionary.Create(nil);
    lAnimDictionary.MakeDefault(Self);
    AddChunk(lAnimDictionary);
  end;

  SetLength(Chunks, ChkIdx);
end;

constructor TBSP.Create;
begin
  inherited Create;
  UpdateAnimFlag := true;
  LastXImage := -1;
  SetLength(BSPFiles, 1);
  BSPfiles[0] := TBSPfile.Create;
  BSPFile := BSPfiles[0];
  //  Mesh3D := TMesh.Create;
  MeshFiles := TMesh.Create;
  //  LastUV:=TUVData.Create;
end;

procedure oglGrid(GridMax: Integer);
var
  i, size: Integer;
begin
  size := 5;
  glBegin(GL_LINES);
  for i := -GridMax to GridMax do
  begin
    glVertex3f(-GridMax * size, 0, i * size);
    glVertex3f(GridMax * size, 0, i * size);
    glVertex3f(i * size, 0, -GridMax * size);
    glVertex3f(i * size, 0, GridMax * size);
  end;
  glEnd;
end;

procedure oglAxes;
var
  S: string;
begin
  glDisable(GL_LIGHTING);
  glColor3f(1, 0, 0);
  glBegin(GL_LINES);
  glVertex3f(0, 0, 0);
  glVertex3f(1, 0, 0);
  glEnd;
  glRasterPos3f(1.2, 0, 0);
  s := 'x';
  glListBase(2000); //FontGL
  glCallLists(1, GL_UNSIGNED_BYTE, Pointer(S));
  glColor3f(0, 1, 0);
  glBegin(GL_LINES);
  glVertex3f(0, 0, 0);
  glVertex3f(0, 1, 0);
  glEnd;
  glRasterPos3f(0, 1.2, 0);
  s := 'y';
  glCallLists(1, GL_UNSIGNED_BYTE, Pointer(S));
  glColor3f(0, 0, 1);
  glBegin(GL_LINES);
  glVertex3f(0, 0, 0);
  glVertex3f(0, 0, 1);
  glEnd;
  glRasterPos3f(0, 0, 1.2);
  s := 'z';
  glCallLists(1, GL_UNSIGNED_BYTE, Pointer(S));
  glEnable(GL_LIGHTING);
end;

procedure Light(var Color: Color4D);
var
  sinX, cosX, sinY, cosY, Step: Extended;
begin
  Step := TransView.zoom;
  SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
  SinCos((TransView.xrot - 90) * Pi / 180, sinX, cosX);

  Color[0] := -(Transview.xpos + Step * cosY * sinX);
  Color[1] := -(Transview.ypos + Step * cosX);
  Color[2] := -(Transview.zpos + Step * sinY * sinX);
end;

procedure TBSP.LoadBSPFileName(FileName: string);
begin
  BSPfile.BSPList := self;
  bspfile.LoadBSPFile(FileName);
end;

procedure TBSPfile.SaveBSPFile(filename: string);
var
  outStream: TStream;
begin
  pos := 0;
  size := 0;
  Uncompress := 0;
  Mem.Free;
  Mem := TMemoryStream.Create;
  Mem.SetSize(100 * 1024 * 1024);
  WriteBSPChunks; //ress:=False;
  Mem.SetSize(Mem.Position);
  bspfilename := filename;
  iscompress := CompressBSP;
  size := Mem.Size;
  filesize := size;
  But.TreeProgress.Max := 1000;
  if iscompress then
  begin
    Mem.Position := 0;
    TCompressThread.Create(self);
  end
  else
    mem.SaveToFile(filename);
  But.TreeProgress.Position := 1000;
  //bspout.Free;
end;

procedure TBSPfile.AddBone(Bone: TChunk);
var
  len: integer;
  bobj: TSpFrame;
begin
  // bobj:=GetBone(TSpFrame(Bone).hash);
  // if bobj=nil then begin
  len := Length(BoneLib);
  SetLength(BoneLib, len + 1);
  BoneLib[len] := Bone;
  //  end;
end;

function TBSPfile.GetBone(Hash: Cardinal): TSpFrame;
var
  len, i: integer;
begin
  result := nil;
  len := Length(BoneLib);
  for i := 0 to len - 1 do
  begin
    if TSpFrame(BoneLib[i]).hash = Hash then
    begin
      result := TSpFrame(BoneLib[i]);
      break;
    end;
  end;
end;

function TBSPfile.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := TreeView.AddChild(TreeNode);
  Data := TreeView.GetNodeData(Result);
  TreeView.ValidateNode(Result, False);
  Data^.Name := ExtractFileName(bspfilename);
  Data^.Value := '[File]';
  Data^.ImageIndex := 4;
  Data^.Obj := self;
  Result.CheckType := ctTriStateCheckBox;
  Result.CheckState := csCheckedNormal;
  But.TreeProgress.Position := 150;
  if Textures <> nil then
    Textures.AddClassNode(TreeView, Result);
  But.TreeProgress.Position := 250;
  if Materials <> nil then
    Materials.AddClassNode(TreeView, Result);
  But.TreeProgress.Position := 600;
  if World <> nil then
    World.AddClassNode(TreeView, Result);
  But.TreeProgress.Position := 700;
  if AnimLib <> nil then
    AnimLib.AddClassNode(TreeView, Result);
  But.TreeProgress.Position := 850;
  if Entities <> nil then
    Entities.AddClassNode(TreeView, Result);
  But.TreeProgress.Position := 1000;
end;

function TBSPfile.GetMesh: TMesh;
var
  nchild: integer;
begin
  Mesh.ResetChilds(0);
  nchild := 0;
  if (World <> nil) then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := World.GetMesh;
    inc(nchild);
  end;

  if (Entities <> nil) then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := Entities.GetMesh;
    inc(nchild);
  end;
  Result := Mesh;
end;

procedure TBSPfile.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

{ TBSP }

procedure TBSP.SaveBSP(SaveDialog: TSaveDialog);
begin
  if ExtractFileExt(SaveDialog.FileName) = '' then
    SaveDialog.FileName := SaveDialog.FileName + '.bsp';
  BSPfile.SaveBSPFile(SaveDialog.FileName);
end;

procedure TBSP.CreateTemplateBSPFile(index: Cardinal);
begin
  BSPfile.BSPList := self;
  bspfile.GenerateTemplateChunks(index);
end;

function ToTime(milisec: Longword): Single;
begin
  Result := (milisec div 60000) + ((milisec mod 60000) div 1000) / 100;
end;

procedure TBSP.SetMeshCheck(Node: PVirtualNode;
  TreeView: TCustomVirtualStringTree);
var
  NData: PClassData;
  Data: TClassData;
  Chunk: TChunk;
begin
  NData := TreeView.GetNodeData(Node);
  if NData = nil then
    exit;
  Data := NData^;
  if (TObject(Data.Obj) is TChunk) then
  begin
    Chunk := TChunk(Data.Obj);
    Chunk.ShowMesh(csUncheckedNormal = Node.CheckState);
  end;
end;

destructor TBSP.Destroy;
begin
  ClearBSPFiles;
  BSPfiles[0].Free;
  //  Mesh3D.Clear;
  MeshFiles.Clear;
  // MeshFiles.Free;
 //  LastUV.Free;
  inherited Destroy;
end;

const
  MAXMATERIALS = 2000;

procedure TBSP.AddBSPFile;
var
  len: integer;
begin
  len := Length(BSPFiles);
  SetLength(BSPfiles, len + 1);
  BSPFiles[len] := TBSPfile.Create;
  BSPFiles[len].IndexOffset := len * MAXMATERIALS;
  BSPfile := BSPFiles[len];
end;

procedure TBSP.ClearBSPFiles;
var
  i, len: integer;
begin
  len := Length(BSPFiles);
  if len > 1 then
  begin
    for i := 1 to len - 1 do
      if BSPFiles[i] <> nil then
        BSPFiles[i].Free;
  end;
  SetLength(BSPFiles, 1);
  BSPfile := BSPFiles[0];
  GlobalID := 0;
end;

function TrimF(s: string): string;
begin
  Result := StringReplace(Trim(s), '.000000', '', [rfReplaceAll]);
end;

function MatrixToText(Matrix: TMatrix): string;
var
  i, j: integer;
  s: string;
begin
  s := '';
  for j := 1 to 4 do
    for i := 1 to 4 do
      s := Format('%s%.6f ', [s, Matrix[i][j]]);
  Result := TrimF(s);
end;

function SplitFloat(Str: string): AFloat;
var
  ListOfStrings: TStrings;
  i: Integer;
begin
  ListOfStrings := TStringList.Create;
  try
    ListOfStrings.Clear;
    ListOfStrings.Delimiter := ' ';
    ListOfStrings.DelimitedText := Str;
    SetLength(Result, ListOfStrings.Count);
    for i := 0 to ListOfStrings.Count - 1 do
      Result[i] := StrToFloat(ListOfStrings[i]);
  finally
    ListOfStrings.Free;
  end;
end;

function TextToMatrix(sMatrix: string): TMatrix;
var
  i, j, n: integer;
  Matrix: TMatrix;
  Floats: AFloat;
begin
  Floats := SplitFloat(sMatrix);
  n := 0;
  for j := 1 to 4 do
    for i := 1 to 4 do
    begin
      Matrix[i][j] := Floats[n];
      Inc(n);
    end;
  SetLength(Floats, 0);
  Result := Matrix;
end;

function ColorToText(color: TUColor): string;
begin
  Result := format('%.6f %.6f %.6f %.6f', [color[0] / 255, color[1] / 255,
    color[2] / 255, color[3] / 255]);
end;

function VectToText(Vert: AVer): string;
var
  i: Integer;
  s: string;
begin
  s := '';
  for i := 0 to High(Vert) do
    s := Format('%s%.6f %.6f %.6f ', [s, Vert[i][0], Vert[i][1], Vert[i][2]]);
  Result := TrimF(s);
end;

function AreaToText(Vert: AVect4): string;
var
  i: Integer;
  s: string;
begin
  s := '';
  for i := 0 to High(Vert) do
    s := Format('%s%.6f %.6f %.6f ', [s, Vert[i][1], Vert[i][2], Vert[i][3]]);
  Result := TrimF(s);
end;

function UVToText(Vert: ATCoord): string;
var
  i: Integer;
  s: string;
begin
  s := '';
  for i := 0 to High(Vert) do
    s := Format('%s%.6f %.6f ', [s, Vert[i][0], 1 - Vert[i][1]]);
  Result := TrimF(s);
end;

function FaceToText(Face: AFace; Offsets: integer): string;
var
  i, j, o: Integer;
  s: string;
begin
  s := '';
  for i := 0 to High(Face) do
    for j := 0 to 2 do
      for o := 0 to Offsets do
        s := Format('%s%d ', [s, Face[i][j]]);
  Result := Trim(s);
end;

function AreaIndicesToText(indices_count: integer): string;
var
  i, j, o: Integer;
  s: string;
begin
  s := '';
  for i := 0 to indices_count - 1 do
    s := Format('%s%d ', [s, i]);
  Result := Trim(s);
end;

function BonesToTextBlender(Bones: AMesh): string;
var
  i: Integer;
  s: string;
begin
  s := '';
  for i := 0 to DaeSkinBones.Count - 1 do
    s := s + DaeSkinBones[i] + ' ';
  Result := Trim(s);
end;

function BonesToText(Bones: AMesh): string;
var
  i: Integer;
  s: string;
begin
  s := '';
  for i := 0 to High(Bones) do
    s := s + Bones[i].Name + ' ';
  //s := Format('%s%.8x ', [s, Bones[i].Hash]);
//Format('%s%s ',[s,Bones[i].Name]);//
  Result := Trim(s);
end;

function BonesMatrixToText(Bones: AMesh): string;
var
  i: Integer;
  s: string;
begin
  s := '';
  for i := 0 to High(Bones) do
    s := s + ' ' + MatrixToText(Bones[i].InvBoneMatrix);
  Result := Trim(s);
end;

procedure ParseWeight(Weight: AAval; var WeightText: string; var WeightCount:
  Integer; var VertexBones: string; var WeightIndex: string; var VertexCount:
  Integer);
var
  i, j, w, b, v: Integer;
  s, s1, s2: string;
begin
  s := '';
  s1 := '';
  s2 := '';
  w := 0;
  v := 0;
  for i := 0 to High(Weight) do
  begin
    b := 0;
    for j := 0 to High(Weight[i]) do
      if Weight[i][j] > 0 then
      begin
        s := Format('%s%.6f ', [s, Weight[i][j]]);
        s2 := Format('%s%d %d ', [s2, j, w]);
        Inc(w);
        Inc(b);
      end;
    if (b > 0) then
    begin
      s1 := Format('%s%d ', [s1, b]);
      Inc(v);
    end;
  end;
  WeightText := TrimF(s);
  WeightCount := w;
  VertexBones := Trim(s1);
  WeightIndex := Trim(s2);
  VertexCount := v;
end;

procedure ParseBlenderWeight(Vertex: AVer; var WeightText: string; var
  WeightCount:
  Integer; var VertexBones: string; var WeightIndex: string; var VertexCount:
  Integer; jointIndex: Integer);//fr: TSpFrame);
var
  i, j, w, b, v :Integer; //,jointIndex: Integer;
  s, s1, s2: string;
begin
  s := '';
  s1 := '';
  s2 := '';
  {
  jointIndex:= -1;
  for j:=0 to High(DaeBlenderBones) do
  begin
    if DaeBlenderBones[j].Name = fr.name then
    begin
      jointIndex:= j;
      break;
    end;
  end;       }

  for j := 0 to High(Vertex) do
  begin
    s := Format('%s%.6f ', [s, 1.0]);
    s2 := Format('%s%d %d ', [s2, jointIndex, j]);
    s1 := Format('%s%d ', [s1, 1]);
  end;
  WeightText := TrimF(s);
  WeightCount := Length(Vertex);
  VertexBones := Trim(s1);
  WeightIndex := Trim(s2);
  VertexCount := Length(Vertex);
end;

const
  CONVERT_M = '0 0 -1 0 -1 0 0 0 0 1 0 0 0 0 0 1';

var
  ConvertMatrix: string = CONVERT_M;
  InitMatrix: string = '1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1';
  DAEPATH: string;
  ClumpId: string;
  DAE_Options: DAEOptions;

function StrClear(Str, Clear: string): string;
begin
  Result := StringReplace(Str, Clear, '', []);
end;

procedure TBSP.AddDaeChunk(D: TNativeXml; node: TXmlNode; Chunk: TChunk);
var
  x, k, k3, inx, i, nchild, num, num2, FrameIndex: Integer;
  p2: Pointer;
  n, FrameCount: Integer;
  TimeText, MatrixText: string;
  f: Single;
  Pos, Size, RotOrient, Rot, JointOrient: Tver;
  Entity: TEntity;
  Frame: TSpFrame;
  Clump: TClump;
  Mesh, TempMesh: TMesh;
  tempSpMesh: TSpMesh;
  Area: TSpline;
  TObj: TTextureOpenGL;
  drawEnt: Boolean;
  Matrix,
    WorldNode,
    Geometry,
    CMesh,
    ClumpGeom, instance_material,
    Geom,
    Source,
    input,
    inputoffset,
    Triangles, ClumpNode,
    Controller,
    param,
    newnode,
    bind_mat: TXmlNode;
  GeomName, Source_id, tTypeName: string;
  WeightText, VertexBones, WeightIndex: string;
  WeightCount, VertexCount, Offsets, cNum_childs, z: Integer;
  extraList: TStringList;
  meshVertex,meshNormals: AVer;
  //new
  blender_frame_name: string;

  procedure AddExtra(Source: TXmlNode; attributes: TStringList);
  var
    userp, extra, technique: TXmlNode;
    up_text: string;
  begin
    up_text := 'user_properties';
    userp := D.NodeNewText('user_properties', attributes.Text);
    userp.AttributesAdd([
      D.AttrText('sid', up_text),
        D.AttrText('type', 'string')
        ]);
    userp.Value := attributes.DelimitedText;
    extra := D.NodeNew('extra');
    Source.NodeAdd(extra);
    technique := D.NodeNewAttr('technique', [D.AttrText('profile',
        'OpenCOLLADA')]);
    technique.NodeAdd(userp);
    extra.NodeAdd(technique);
  end;

  procedure AddTechnique(Source: TXmlNode; count: Integer; source_id: string);
  var
    Accessor: TXmlNode;
  begin
    Accessor := D.NodeNew('accessor');
    Source.NodeAdd(D.NodeNew('technique_common', [Accessor]));
    Accessor.AttributesAdd([
      D.AttrText('source', '#' + source_id), // Source.Float_array.Id;
        D.AttrInt('count', count),
        D.AttrInt('stride', 3)
        ]);
    Accessor.NodesAdd([
      D.NodeNewAttr('param', [
        D.AttrText('name', 'X'),
          D.AttrText('type', 'float')
          ]),
        D.NodeNewAttr('param', [
        D.AttrText('name', 'Y'),
          D.AttrText('type', 'float')
          ]),
        D.NodeNewAttr('param', [
        D.AttrText('name', 'Z'),
          D.AttrText('type', 'float')
          ])
        ]);
  end;

  procedure AddTechniqueMap(Source: TXmlNode; count: Integer; source_id:
    string);
  var
    Accessor: TXmlNode;
  begin
    Accessor := D.NodeNew('accessor');
    Source.NodeAdd(D.NodeNew('technique_common', [Accessor]));
    Accessor.AttributesAdd([
      D.AttrText('source', '#' + source_id), // Source.Float_array.Id;
        D.AttrInt('count', count),
        D.AttrInt('stride', 2)
        ]);
    Accessor.NodesAdd([
      D.NodeNewAttr('param', [
        D.AttrText('name', 'S'),
          D.AttrText('type', 'float')
          ]),
        D.NodeNewAttr('param', [
        D.AttrText('name', 'T'),
          D.AttrText('type', 'float')
          ])
        ]);
  end;

  procedure AddMaterial(material: TXmlNode; matobj: TMaterialObj);
    //instance_material
  var
    mat,
      fx, blinn, newparam, sampler2D,
      profile_COMMON,
      image, materials, images, transparent,
      param: TXmlNode;
    i, j: integer;
    id: string;
    found: boolean;
    png: string;
    States: TXmlNode;

    function GetWrapType(texture: TGLTexture): string;
    begin
      case texture.wrap_type of
        0, 1: Result := 'WRAP';
        2: Result := 'MIRROR';
        3: Result := 'CLAMP';
        4: Result := 'BORDER';
      end;
    end;

    function GetMinFilter(texture: TGLTexture): string;
    begin
      case texture.wrap_type of
        0, 1: Result := 'REPEAT';
      else
        Result := 'LINEAR';
      end;
    end;

    function GetMagFilter(texture: TGLTexture): string;
    begin
      case texture.wrap_type of
        0: Result := 'NONE';
        1: Result := 'NEAREST';
        2: Result := 'LINEAR';
        3: Result := 'NEAREST_MIPMAP_NEAREST';
        4: Result := 'LINEAR_MIPMAP_NEAREST';
        5: Result := 'NEAREST_MIPMAP_LINEAR';
        6: Result := 'LINEAR_MIPMAP_LINEAR';
      end;
    end;

  begin
    //Check if materials are not repeated
    materials := D.Root.NodeByName('library_materials');
    found := false;
    for i := 0 to materials.ElementCount - 1 do
    begin
      if Utf8CompareText(materials.Elements[i].Attributes[0].Value,
        matobj.TypeName) = 0 then
        found := true;
    end;

    material.AttributesAdd([//Instance material
      D.AttrText('symbol', matobj.TypeName),
        D.AttrText('target', '#' + matobj.TypeName + '-material')
        ]);

    if Length(matobj.Texture[0].name) > 0 then
    begin
      material.NodeAdd(D.NodeNewAttr('bind_vertex_input', [
        D.AttrText('semantic', 'CHANNEL1'),
          D.AttrText('input_semantic', 'TEXCOORD'),
          D.AttrText('input_set', '0')
          ]));
    end;

    if not found then //If not repeated
    begin
      mat := D.NodeNewAttr('material', [
        D.AttrText('id', matobj.TypeName + '-material'),
          //Format('%.8x',[matobj.materialHash]);
        D.AttrText('name', matobj.TypeName)
          ],
          [D.NodeNewAttr('instance_effect',
          [D.AttrText('url', '#' + matobj.TypeName)]
          //Format('#%.8x',[matobj.materialHash]);
          )]);
      D.Root.NodeByName('library_materials').NodeAdd(mat);

      profile_COMMON := D.NodeNew('profile_COMMON'); //profile_COMMON
      fx := D.NodeNewAttr('effect', [
        D.AttrText('id', matobj.TypeName) //,
          //Format('%.8x',[matobj.materialHash]);
//D.AttrText('name', matobj.TypeName)
        ], [profile_COMMON]);
      D.Root.NodeByName('library_effects').NodeAdd(fx);

      if Length(matobj.Texture[0].name) > 0 then
      begin
        profile_COMMON.NodeAdd(D.NodeNewAttr('newparam',
          [D.AttrText('sid', format('%s_png-surface',
            [matobj.Texture[0].name]))],
          [D.NodeNewAttr('surface', [D.AttrText('type', '2D')],
            [D.NodeNewText('init_from', matobj.Texture[0].name + '_png')]
            )]));
        profile_COMMON.NodeAdd(D.NodeNewAttr('newparam',
          [D.AttrText('sid', format('%s_png-sampler',
            [matobj.Texture[0].name]))],
          [D.NodeNew('sampler2D',
            [D.NodeNewText('source', format('%s_png-surface',
              [matobj.Texture[0].name])),
            D.NodeNewText('wrap_s', GetWrapType(matobj.Texture[0])),
              D.NodeNewText('minfilter', GetMinFilter(matobj.Texture[0])),
              D.NodeNewText('magfilter', GetMagFilter(matobj.Texture[0]))
              ])
            ]
            ));
      end;
      blinn := D.NodeNew('blinn');
      profile_COMMON.NodeAdd(D.NodeNewAttr('technique', [D.AttrText('sid',
          'common')], [blinn]));
      blinn.NodeAdd(D.NodeNew('emission', [D.NodeNewText('color', '0 0 0 1')]));
      blinn.NodeAdd(D.NodeNew('ambient', [D.NodeNewText('color',
          ColorToText(matobj.Diffuse))]));

      if Length(matobj.Texture[0].name) > 0 then
      begin
        blinn.NodeAdd(
          D.NodeNew('diffuse', [
          D.NodeNewAttr('texture', [
            D.AttrText('texture', format('%s_png-sampler',
              [matobj.Texture[0].name])),
              //format('%.8x',[matobj.Texture[0].hash]);
            D.AttrText('texcoord', 'CHANNEL1')
              ])
            ]));
        // test if already used this id
        images := D.Root.NodeByName('library_images');
        id := matobj.Texture[0].name + '_png';
        j := images.ElementCount - 1;
        found := false;

        for i := 0 to j do
        begin
          if Utf8CompareText(images.Elements[i].Attributes[0].Value, id) = 0
            then
            found := true;
        end;

        if not found then
        begin
          png := format('%s.png', [matobj.Texture[0].name]);
          image := D.NodeNewAttr('image', [
            D.AttrText('id', id)],
              // D.AttrText('name', id)],
            [D.NodeNewText('init_from', png)]);
          images.NodeAdd(image);
          // save texture as png
          matobj.Texture[0].Texture.SavePNGImage(DAEPATH + png);
        end;
      end
      else
        blinn.NodeAdd(D.NodeNew('diffuse', [D.NodeNewText('color',
            ColorToText(matobj.Diffuse))]));

      blinn.NodeAdd(D.NodeNew('specular', [D.NodeNewText('color',
          ColorToText(matobj.Specular))]));
      blinn.NodeAdd(D.NodeNew('shininess', [D.NodeNewText('float', format('%f',
          [matobj.m_Power]))]));

      if matobj.AlphaTest > 0 then
      begin
        transparent := D.NodeNewAttr('texture', [
          D.AttrText('texture', format('%s_png-sampler',
            [matobj.Texture[0].name])),
            D.AttrText('texcoord', 'CHANNEL1')
            ]);
      end
      else
        transparent := D.NodeNewText('color', '1 1 1 1');

      blinn.NodeAdd(D.NodeNewAttr('transparent', [D.AttrText('opaque',
          'A_ONE')],
        [transparent]));

      blinn.NodeAdd(D.NodeNew('transparency', [D.NodeNewText('float', '1')]));

      if DAE_CG in DAE_Options then
      begin
        States := D.NodeNew('states');
        States.NodeAdd(D.NodeNewAttr('shade_model', [
          D.AttrText('value', StrClear(BSPGLShadeS[matobj.ShadeMode],
            'GL_'))]));
        States.NodeAdd(D.NodeNewAttr('blend_enable', [D.AttrBool('value',
            matobj.Blend > 0)]));
        States.NodeAdd(D.NodeNew('blend_func', [
          D.NodeNewAttr('src', [D.AttrText('value',
              StrClear(BSPGLFactorS[matobj.Blend_sfactor], 'GL_'))]),
          D.NodeNewAttr('dest', [D.AttrText('value',
              StrClear(BSPGLFactorS[matobj.Blend_dfactor], 'GL_'))])
          ]));
        States.NodeAdd(D.NodeNewAttr('alpha_test_enable', [D.AttrBool('value',
            matobj.AlphaTest > 0)]));
        States.NodeAdd(D.NodeNew('alpha_func', [
          D.NodeNewAttr('func', [D.AttrText('value',
              StrClear(BSPGLParamS[matobj.AlphaTestCompMode], 'GL_'))]),
          D.NodeNewAttr('value', [D.AttrFloat('value', matobj.AlphaRefValue)])
          ]));
        States.NodeAdd(D.NodeNewAttr('depth_test_enable', [D.AttrBool('value',
            matobj.DepthBufferWrite > 0)]));
        States.NodeAdd(D.NodeNewAttr('depth_func', [D.AttrText('value',
            StrClear(BSPGLParamS[matobj.DepthBufferCompMode], 'GL_'))]));
        fx.NodeAdd(D.NodeNew('profile_CG', [D.NodeNew('technique',
            [D.NodeNew('pass', [States])])]));
      end;
    end;
  end;

  procedure AddDaeRenderBlock();
  var
    zz: integer;
  begin
    instance_material := D.NodeNew('instance_material');
    newnode.NodeAdd(D.NodeNewAttr('instance_controller',
      [D.AttrText('url', '#' + GeomName + '-skin')],
      [D.NodeNewText('skeleton', '#' + ClumpId),
      D.NodeNew('bind_material', [
        D.NodeNew('technique_common', [instance_material])
          ])
        ]));
    AddMaterial(instance_material, TRenderBlock(Chunk).material);

    Controller := D.NodeNewAttr('controller', [D.AttrText('id', GeomName +
      '-skin')]);
    D.Root.NodeByName('library_controllers').NodeAdd(Controller);
    Source_id := GeomName + '-skin-joints';
    Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);

    ClumpNode := D.NodeNewAttr('skin',
      [D.AttrText('source', '#' + GeomName)],
      [D.NodeNewText('bind_shape_matrix', InitMatrix), Source]);
    Controller.NodeAdd(ClumpNode);
    Source.NodeAdd(D.NodeNewTextAttr('Name_array',
      BonesToText(DaeBlenderBones),
      [D.AttrText('id', Source_id + '-array'),
      D.AttrInt('count', Length(DaeBlenderBones))]));

    Source.NodeAdd(D.NodeNew('technique_common', [
      D.NodeNewAttr('accessor', [
        D.AttrText('source', '#' + Source_id + '-array'),
          D.AttrInt('count', Length(DaeBlenderBones)),
          D.AttrInt('stride', 1)
          ], [
          D.NodeNewAttr('param', [
          D.AttrText('name', 'JOINT'),
            D.AttrText('type', 'name')
            ])
          ])
        ]));

    Source_id := GeomName + '-skin-bind_poses';
    Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
    ClumpNode.NodeAdd(Source);

    Source.NodeAdd(D.NodeNewTextAttr('float_array',
      BonesMatrixToText(DaeBlenderBones),
      [D.AttrText('id', Source_id + '-array'),
      D.AttrInt('count', Length(DaeBlenderBones) * 16)]));

    Source.NodeAdd(D.NodeNew('technique_common', [
      D.NodeNewAttr('accessor', [
        D.AttrText('source', '#' + Source_id + '-array'),
          D.AttrInt('count', Length(DaeBlenderBones)),
          D.AttrInt('stride', 16)
          ], [
          D.NodeNewAttr('param', [
          D.AttrText('name', 'TRANSFORM'),
            D.AttrText('type', 'float4x4')
            ])
          ])
        ]));

    ParseBlenderWeight(Mesh.Vert, WeightText, WeightCount, VertexBones,
      WeightIndex, VertexCount, BlenderBoneIndex);//ccFrame);

    Source_id := GeomName + '-skin-weights';
    Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
    ClumpNode.NodeAdd(Source);

    Source.NodeAdd(D.NodeNewTextAttr('float_array',
      WeightText,
      [D.AttrText('id', Source_id + '-array'),
      D.AttrInt('count', WeightCount)]));

    Source.NodeAdd(D.NodeNew('technique_common', [
      D.NodeNewAttr('accessor', [
        D.AttrText('source', '#' + Source_id + '-array'),
          D.AttrInt('count', WeightCount),
          D.AttrInt('stride', 1)
          ], [
          D.NodeNewAttr('param', [
          D.AttrText('name', 'WEIGHT'),
            D.AttrText('type', 'float')
            ])
          ])
        ]));

    ClumpNode.NodeAdd(D.NodeNew('joints', [
      D.NodeNewAttr('input', [
        D.AttrText('semantic', 'JOINT'),
          D.AttrText('source', '#' + GeomName + '-skin-joints')
          ]),
        D.NodeNewAttr('input', [
        D.AttrText('semantic', 'INV_BIND_MATRIX'),
          D.AttrText('source', '#' + GeomName + '-skin-bind_poses')
          ])
        ]));
    // vertex [bone, weight][num]
    ClumpNode.NodeAdd(D.NodeNewAttr('vertex_weights',
      [D.AttrInt('count', VertexCount)],
      [
      D.NodeNewAttr('input', [
        D.AttrText('semantic', 'JOINT'),
          D.AttrText('offset', '0'),
          D.AttrText('source', '#' + GeomName + '-skin-joints')
          ]),
        D.NodeNewAttr('input', [
        D.AttrText('semantic', 'WEIGHT'),
          D.AttrText('offset', '1'),
          D.AttrText('source', '#' + GeomName + '-skin-weights')
          ]),
        D.NodeNewText('vcount', VertexBones),
        D.NodeNewText('v', WeightIndex)
        ]));
  end;

begin
  case Chunk.IDType of
    C_Root:
      begin
        tDirtyScenarioFlag := true;
        node.AttributesAdd([
          D.AttrText('id', 'node-Scenario'),
            D.AttrText('name', 'Scenario')
            ]);
        node.NodeAdd(D.NodeNewText('matrix', ConvertMatrix));

        if TBSPfile(Chunk).World <> nil then
          if TBSPfile(Chunk).World.hasMesh then
            if TBSPfile(Chunk).World.ModelGroup.models_num > 0 then
              AddDaeChunk(D, node, TBSPfile(Chunk).World);
        if TBSPfile(Chunk).Entities <> nil then
          if Length(TBSPfile(Chunk).Entities.Entities) > 0 then
            for i := 0 to High(TBSPfile(Chunk).Entities.Entities) do
            begin
              WorldNode := D.NodeNew('node');
              node.NodeAdd(WorldNode);
              AddDaeChunk(D, WorldNode, TBSPfile(Chunk).Entities.Entities[i]);
            end;
      end;
    C_NullNode:
      begin
        Mesh := TSpNullNode(Chunk).mesh;
      end;
    C_ZoneObj:
      begin
        if TZoneObj(Chunk).Border <> nil then
          AddDaeChunk(D, node, TZoneObj(Chunk).Border);
        {  if TZoneObj(Chunk).Ward <> nil then
          AddDaeChunk(D, node, TZoneObj(Chunk).Ward);      }
      end;
    C_Mesh:
      begin
        num := TSpMesh(Chunk).models_num;
        if (DAE_BLENDER in DAE_OPTIONS) and (BlenderBoneIndex > -1) then
        begin
          for i := 0 to num - 1 do
            AddDaeChunk(D, DaeRoot, TSpMesh(Chunk).models[i]);
        end
        else
        begin
        for i := 0 to num - 1 do
          AddDaeChunk(D, node, TSpMesh(Chunk).models[i]);
        end;
      end;
    C_Frame:
      begin
        Frame := TSpFrame(Chunk);
        Matrix := D.NodeNew('matrix');
        if (DAE_BLENDER in DAE_OPTIONS) then
        begin

          blender_frame_name:= Frame.Name;
          blender_frame_name:= stringreplace(blender_frame_name, '-', '.', [rfReplaceAll, rfIgnoreCase]);

          newnode := D.NodeNewAttr('node', [
            D.AttrText('id', Format('node-%s', [Frame.name])),
              D.AttrText('name', blender_frame_name)
              ], [Matrix]);
        end
        else
        begin
           newnode := D.NodeNewAttr('node', [
            D.AttrText('id', Format('node-%s', [Frame.name])),
              D.AttrText('name', Frame.Name)
              ], [Matrix]);
        end;
        if (Frame.bone_index > -1) or (DAE_DUMMY_JOINT in DAE_Options) then
        begin
          newnode.AttributeAdd('type', 'JOINT');
          newnode.AttributeAdd('sid', Format('%s', [Frame.name]));
        end;
        Matrix.AttributeAdd('sid', 'matrix');
        n := -1;
        if (DAE_ANIM in DAE_Options) then
        begin
          FrameCount := -1; // get matrix count;
          for i := 0 to High(CurAnimClip.Bones) do
            if CurAnimClip.Bones[i].boneHash = Frame.Hash then
            begin
              n := i;
              Break;
            end;
          if n > -1 then
          begin
            CurAnimClip.GenAnimMatrix(n, FrameCount, TimeText, MatrixText);
            Matrix.Value := MatrixText;
          end;
        end;
        if n = -1 then
          Matrix.Value := MatrixToText(Frame.matrix_1.m);
        num := Length(Frame.Childs);
        num2 := Length(Frame.Bones);

        if (DAE_BLENDER in DAE_OPTIONS) then
        begin
          if ClumpId = 'node-' + Frame.Name then
            DaeRoot:= newnode;
        end
        else
        begin
           if ClumpId = 'node-' + Frame.Name then
            DaeRoot:= newnode;
        end;

        for x := 0 to num - 1 do
          AddDaeChunk(D, newnode, Frame.Childs[x]);


        if ((DAE_BLENDER in DAE_Options) and ((Frame.bone_index > -1) or (BlenderBoneIndex > -1)) ) then
        begin
          for x := 0 to num2 - 1 do
          begin
            if Frame.bone_index > -1 then
              BlenderBoneIndex:= Frame.bone_index;

            ccFrame:= TSpFrame(Frame.Bones[x]);
            AddDaeChunk(D, newnode, Frame.Bones[x]);
          end;
        end
        else
        begin
        for x := 0 to num2 - 1 do
          AddDaeChunk(D, newnode, Frame.Bones[x]);
        end;

        node.NodeAdd(newnode);
      end;
    C_RenderBlock:
      begin // TMesh
        newnode := D.NodeNewAttr('node', [
          D.AttrText('id', 'node-' + Chunk.TypeName),
            D.AttrText('name', Chunk.TypeName)
            ]);
        node.NodeAdd(newnode);
        Mesh := TRenderBlock(Chunk).mesh;
        GeomName := Format('geom-%s', [Chunk.TypeName]);
        Geometry := D.NodeNewAttr('geometry', [
          D.AttrText('id', GeomName),
            D.AttrText('name', Chunk.TypeName)
            ]);
        D.Root.NodeByName('library_geometries').NodeAdd(Geometry);

        if (DAE_BLENDER in DAE_OPTIONS) and (BlenderBoneIndex > -1) then
        begin
          AddDaeRenderBlock()
        end
        else if mesh.XType = 'SS' then
        begin
          instance_material := D.NodeNew('instance_material');
          newnode.NodeAdd(D.NodeNewAttr('instance_controller',
            [D.AttrText('url', '#' + GeomName + '-skin')],
            [D.NodeNewText('skeleton', '#' + ClumpId),
            D.NodeNew('bind_material', [
              D.NodeNew('technique_common', [instance_material])
                ])
              ]));
          AddMaterial(instance_material, TRenderBlock(Chunk).material);

          Controller := D.NodeNewAttr('controller', [D.AttrText('id', GeomName
              +
              '-skin')]);
          D.Root.NodeByName('library_controllers').NodeAdd(Controller);
          Source_id := GeomName + '-skin-joints';
          Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);

          if (DAE_BLENDER in DAE_OPTIONS) then
          begin
            ClumpNode := D.NodeNewAttr('skin',
              [D.AttrText('source', '#' + GeomName)],
              [D.NodeNewText('bind_shape_matrix', InitMatrix), Source]);
            Controller.NodeAdd(ClumpNode);
            Source.NodeAdd(D.NodeNewTextAttr('Name_array',
              BonesToText(DaeBlenderBones),
              [D.AttrText('id', Source_id + '-array'),
              D.AttrInt('count', Length(DaeBlenderBones))]));

            Source.NodeAdd(D.NodeNew('technique_common', [
            D.NodeNewAttr('accessor', [
              D.AttrText('source', '#' + Source_id + '-array'),
                D.AttrInt('count', Length(DaeBlenderBones)),
                D.AttrInt('stride', 1)
                ], [
                D.NodeNewAttr('param', [
                D.AttrText('name', 'JOINT'),
                  D.AttrText('type', 'name')
                  ])
                ])
              ]));

            Source_id := GeomName + '-skin-bind_poses';
            Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
            ClumpNode.NodeAdd(Source);

            Source.NodeAdd(D.NodeNewTextAttr('float_array',
              BonesMatrixToText(DaeBlenderBones),
              [D.AttrText('id', Source_id + '-array'),
              D.AttrInt('count', Length(DaeBlenderBones) * 16)]));

            Source.NodeAdd(D.NodeNew('technique_common', [
              D.NodeNewAttr('accessor', [
                D.AttrText('source', '#' + Source_id + '-array'),
                  D.AttrInt('count', Length(DaeBlenderBones)),
                  D.AttrInt('stride', 16)
                  ], [
                  D.NodeNewAttr('param', [
                  D.AttrText('name', 'TRANSFORM'),
                    D.AttrText('type', 'float4x4')
                    ])
                  ])
                ]));

          end
          else
          begin
            ClumpNode := D.NodeNewAttr('skin',
              [D.AttrText('source', '#' + GeomName)],
              [D.NodeNewText('bind_shape_matrix', InitMatrix), Source]);
            Controller.NodeAdd(ClumpNode);
            Source.NodeAdd(D.NodeNewTextAttr('Name_array',
              BonesToText(Mesh.Bones),
              [D.AttrText('id', Source_id + '-array'),
              D.AttrInt('count', Length(Mesh.Bones))]));

            Source.NodeAdd(D.NodeNew('technique_common', [
            D.NodeNewAttr('accessor', [
              D.AttrText('source', '#' + Source_id + '-array'),
                D.AttrInt('count', Length(Mesh.Bones)),
                D.AttrInt('stride', 1)
                ], [
                D.NodeNewAttr('param', [
                D.AttrText('name', 'JOINT'),
                  D.AttrText('type', 'name')
                  ])
                ])
              ]));

            Source_id := GeomName + '-skin-bind_poses';
            Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
            ClumpNode.NodeAdd(Source);

            Source.NodeAdd(D.NodeNewTextAttr('float_array',
              BonesMatrixToText(Mesh.Bones),
              [D.AttrText('id', Source_id + '-array'),
              D.AttrInt('count', Length(Mesh.Bones) * 16)]));

            Source.NodeAdd(D.NodeNew('technique_common', [
              D.NodeNewAttr('accessor', [
                D.AttrText('source', '#' + Source_id + '-array'),
                  D.AttrInt('count', Length(Mesh.Bones)),
                  D.AttrInt('stride', 16)
                  ], [
                  D.NodeNewAttr('param', [
                  D.AttrText('name', 'TRANSFORM'),
                    D.AttrText('type', 'float4x4')
                    ])
                  ])
                ]));

          end;

          ParseWeight(Mesh.Weight, WeightText, WeightCount, VertexBones,
            WeightIndex, VertexCount);

          Source_id := GeomName + '-skin-weights';
          Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
          ClumpNode.NodeAdd(Source);

          Source.NodeAdd(D.NodeNewTextAttr('float_array',
            WeightText,
            [D.AttrText('id', Source_id + '-array'),
            D.AttrInt('count', WeightCount)]));

          Source.NodeAdd(D.NodeNew('technique_common', [
            D.NodeNewAttr('accessor', [
              D.AttrText('source', '#' + Source_id + '-array'),
                D.AttrInt('count', WeightCount),
                D.AttrInt('stride', 1)
                ], [
                D.NodeNewAttr('param', [
                D.AttrText('name', 'WEIGHT'),
                  D.AttrText('type', 'float')
                  ])
                ])
              ]));

          ClumpNode.NodeAdd(D.NodeNew('joints', [
            D.NodeNewAttr('input', [
              D.AttrText('semantic', 'JOINT'),
                D.AttrText('source', '#' + GeomName + '-skin-joints')
                ]),
              D.NodeNewAttr('input', [
              D.AttrText('semantic', 'INV_BIND_MATRIX'),
                D.AttrText('source', '#' + GeomName + '-skin-bind_poses')
                ])
              ]));
          // vertex [bone, weight][num]
          ClumpNode.NodeAdd(D.NodeNewAttr('vertex_weights',
            [D.AttrInt('count', VertexCount)],
            [
            D.NodeNewAttr('input', [
              D.AttrText('semantic', 'JOINT'),
                D.AttrText('offset', '0'),
                D.AttrText('source', '#' + GeomName + '-skin-joints')
                ]),
              D.NodeNewAttr('input', [
              D.AttrText('semantic', 'WEIGHT'),
                D.AttrText('offset', '1'),
                D.AttrText('source', '#' + GeomName + '-skin-weights')
                ]),
              D.NodeNewText('vcount', VertexBones),
              D.NodeNewText('v', WeightIndex)
              ]));
        end
        else
        begin
          newnode.NodeAdd(D.NodeNewTextAttr('matrix', InitMatrix,
            [D.AttrText('sid', 'matrix')]));
          instance_material := D.NodeNew('instance_material');
          newnode.NodeAdd(D.NodeNewAttr('instance_geometry',
            [D.AttrText('url', '#' + GeomName)],
            [D.NodeNew('bind_material', [
              D.NodeNew('technique_common', [instance_material])
                ])
              ]));
          AddMaterial(instance_material, TRenderBlock(Chunk).material);
        end;

        CMesh := D.NodeNew('mesh');
        Geometry.NodeAdd(CMesh);

        meshVertex:= Copy(Mesh.Vert);
        meshNormals:= Copy(Mesh.Normal);

        if (DAE_BLENDER in DAE_OPTIONS) and (BlenderBoneIndex > -1) then
        begin
          for i:=0 to High(meshVertex) do
          begin
            meshVertex[i]:= MatrXVert(ccFrame.matrix_2.m,meshVertex[i][0],meshVertex[i][1],meshVertex[i][2]);
          end;
        end;
          Source_id := GeomName + '-positions';
          Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
          CMesh.NodeAdd(Source);
          Source.NodeAdd(D.NodeNewTextAttr('float_array',
            VectToText(meshVertex),
            [D.AttrText('id', Source_id + '-array'),
            D.AttrInt('count', Mesh.VertsLen * 3)]));
          AddTechnique(Source, Mesh.VertsLen, Source_id + '-array');

          Source_id := GeomName + '-normals';
          Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
          CMesh.NodeAdd(Source);
          Source.NodeAdd(D.NodeNewTextAttr('float_array',
            VectToText(meshNormals),
            [D.AttrText('id', Source_id + '-array'),
            D.AttrInt('count', Mesh.VertsLen * 3)]));
          AddTechnique(Source, Mesh.VertsLen, Source_id + '-array');

        if Mesh.TextCoord <> nil then
        begin
          Source_id := GeomName + '-map1';
          Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
          CMesh.NodeAdd(Source);
          Source.NodeAdd(D.NodeNewTextAttr('float_array',
            UVToText(Mesh.TextCoord),
            [D.AttrText('id', Source_id + '-array'),
            D.AttrInt('count', Mesh.VertsLen * 2)]));
          AddTechniqueMap(Source, Mesh.VertsLen, Source_id + '-array');
        end;

        CMesh.NodeAdd(D.NodeNewAttr('vertices',
          [D.AttrText('id', GeomName + '-vertices')],
          [D.NodeNewAttr('input', [
            D.AttrText('semantic', 'POSITION'),
              D.AttrText('source', '#' + GeomName + '-positions')
              ])]
            ));

        Triangles := D.NodeNewAttr('triangles', [
          D.AttrText('material', TRenderBlock(Chunk).material.TypeName),
            D.AttrInt('count', Mesh.FacesLen)]);
        CMesh.NodeAdd(Triangles);

        Triangles.NodesAdd([
          D.NodeNewAttr('input', [
            D.AttrText('semantic', 'VERTEX'),
              D.AttrText('source', '#' + GeomName + '-vertices'),
              D.AttrText('offset', '0')
              ]),
            D.NodeNewAttr('input', [
            D.AttrText('semantic', 'NORMAL'),
              D.AttrText('source', '#' + GeomName + '-normals'),
              D.AttrText('offset', '1')
              ])
            ]);
        Offsets := 1;
        if Mesh.TextCoord <> nil then
        begin
          Triangles.NodeAdd(D.NodeNewAttr('input', [
            D.AttrText('semantic', 'TEXCOORD'),
              D.AttrText('source', '#' + GeomName + '-map1'),
              D.AttrText('offset', '2'),
              D.AttrText('set', '0')
              ]));
          Offsets := 2;
        end;
        Triangles.NodeAdd(D.NodeNewText('p', FaceToText(Mesh.Face, Offsets)));
      end;
    C_Atomic:
      begin
        if TAtomic(Chunk).ModelGroup <> nil then
          AddDaeChunk(D, node, TAtomic(Chunk).ModelGroup);
      end;
    C_Clump: //SpClump
      begin
        Clump := TClump(Chunk);
        Frame := Clump.Root;
        BlenderBoneIndex:= -1;
        if Frame <> nil then
        begin
           if (DAE_BLENDER in DAE_OPTIONS) then
           begin
            node.AttributesAdd([
            D.AttrText('id', 'node-entity_' + Frame.Name),
              D.AttrText('name', 'entity_' + Frame.Name)
              ]);
           end
           else
           begin
            node.AttributesAdd([
            D.AttrText('id', 'node-entity_' + Frame.Name),
              D.AttrText('name', 'entity_' + Frame.Name)
              ]);
           end;
          if ClumpId = '' then
          begin

            if (DAE_BLENDER in DAE_OPTIONS) then
              ClumpId := 'node-' + Frame.Name
            else
              ClumpId := 'node-' + Frame.Name;

            if not tDirtyScenarioFlag then
              node.NodeAdd(D.NodeNewText('matrix', ConvertMatrix))
            else
              node.NodeAdd(D.NodeNewText('matrix', InitMatrix));
            // Convert Y Axis to Z Axis
          end
          else
            node.NodeAdd(D.NodeNewText('matrix', InitMatrix));
          DaeRoot := node;
          AddDaeChunk(D, node, Clump.Root);
        end;
      end;
    C_Light:
      begin // Light
        Mesh := TLight(Chunk).mesh;
      end;
    C_NullNodes:
      begin // NullNodes
        num := TNullNodes(Chunk).num;
        for i := 0 to num - 1 do
        begin
          AddDaeChunk(D, node, TNullNodes(Chunk).WpPoints[i]);
        end;
      end;
    C_WaypointMap:
      begin // WaypointMap
        // Mesh:= TWaypointMap(Chunk).mesh;
      end;
    C_Zones:
      begin // Zones
        num := TZones(Chunk).num_list;
        for i := 0 to num - 1 do
        begin
          AddDaeChunk(D, node, TZones(Chunk).Zones[i]);
        end;
      end;
    C_Spline:
      begin
        newnode := D.NodeNewAttr('node', [
          D.AttrText('id', Chunk.TypeName),
            D.AttrText('name', Chunk.TypeName)
            ]);
        node.NodeAdd(newnode);
        GeomName := Format('geom-%s', [Chunk.TypeName]);
        Geometry := D.NodeNewAttr('geometry', [
          D.AttrText('id', GeomName),
            D.AttrText('name', Chunk.TypeName)
            ]);
        D.Root.NodeByName('library_geometries').NodeAdd(Geometry);

        CMesh := D.NodeNew('mesh');
        Geometry.NodeAdd(CMesh);

        Area := TSpline(Chunk);
        Source_id := GeomName + '-positions';
        Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
        CMesh.NodeAdd(Source);
        Source.NodeAdd(D.NodeNewTextAttr('float_array',
          AreaToText(Area.vectors),
          [D.AttrText('id', Source_id + '-array'),
          D.AttrInt('count', Area.num_vect * 3)]));
        AddTechnique(Source, Area.num_vect, Source_id + '-array');

        CMesh.NodeAdd(D.NodeNewAttr('vertices',
          [D.AttrText('id', GeomName + '-vertices')],
          [D.NodeNewAttr('input', [
            D.AttrText('semantic', 'POSITION'),
              D.AttrText('source', '#' + GeomName + '-positions')
              ])]
            ));
        Triangles := D.NodeNewAttr('polylist', [
          D.AttrText('material', ''),
            D.AttrInt('count', 1)]);
        CMesh.NodeAdd(Triangles);

        Triangles.NodesAdd([
          D.NodeNewAttr('input', [
            D.AttrText('semantic', 'VERTEX'),
              D.AttrText('source', '#' + GeomName + '-vertices'),
              D.AttrText('offset', '0')
              ])
            ]);
        Triangles.NodeAdd(D.NodeNewInt('vcount', Area.num_vect));
        Triangles.NodeAdd(D.NodeNewText('p', AreaIndicesToText(Area.num_vect)));

        node.NodeAdd(D.NodeNewText('matrix', ConvertMatrix));

        instance_material := D.NodeNew('instance_material');
        node.NodeAdd(D.NodeNewAttr('instance_geometry',
          [D.AttrText('url', '#' + GeomName)],
          [D.NodeNew('bind_material', [
            D.NodeNew('technique_common', [instance_material])
              ])
            ]));
        AddMaterial(instance_material, BSPfile.Materials.Materials[0]);
      end;
    C_NullBox:
      begin // Link
        if TNullBox(Chunk).atomic_type > 2 then
        begin
          node.NodeAdd(D.NodeNewAttr('node', [
            D.AttrText('id', Format('node-%s-%d-%d', [Chunk.TypeName,
              TNullBox(Chunk).emm_type, Chunk.id])),
              D.AttrText('name', Format('%s-%d-%d', [Chunk.TypeName,
              TNullBox(Chunk).emm_type, Chunk.id]))
              ], [D.NodeNewText('matrix',
              MatrixToText(TNullBox(Chunk).matrix))]));
        end;
      end;
    C_Entity:
      begin
        Entity := TEntity(Chunk);
        if (Entity.Clump <> nil) and (Entity.ent_type <> 5) then
          AddDaeChunk(D, node, Entity.Clump);
      end;

    C_World:
      begin //World
        WorldNode := D.NodeNewAttr('node', [
          D.AttrText('id', 'node-' + Chunk.TypeName),
            D.AttrText('name', Chunk.TypeName)
            ]);
        WorldNode.NodeAdd(D.NodeNewText('matrix', InitMatrix));
        node.NodeAdd(WorldNode);
        AddDaeChunk(D, WorldNode, TWorld(Chunk).ModelGroup);
      end;
    {    20000: begin
          Mesh:= TEntities(Chunk).mesh;
          num:=TEntities(Chunk).Num;
          Mesh.ResetChilds(num);
          for i:=0 to num-1 do begin
              SelectClassTree(TEntities(Chunk).Entities[i],Mesh.childs[i]);
      //        But.TreeProgress.Position:=Round(i/(num-1)*1000);
          end;
        end;
        20001: begin
          Mesh:= TEntity(Chunk).mesh;
          if TEntity(Chunk).Chunk1005<>nil then begin
           Mesh.ResetChilds(1);
           SelectClassTree(TEntity(Chunk).Chunk1005,Mesh.childs[0]);
           end;
        end; }
  end;
end;

procedure TBSP.TestDae(filename: string);
var
  D: TNativeXml;
  root, library_geometries, library_controllers, vertex_weights, mesh, accessor,
    node_skin: TXmlNode;
  cList, vcount: TStringList;
  i, j, vertexCount, NormalsCount, UVMapCount, response, weight_index,
    iterations: integer;
  ErrorFlags: Cardinal;
  haveErrors: Boolean;
  mesh_name: string;
begin
  D := TNativeXml.CreateName('COLLADA');
  D.LoadFromFile(filename);
  root := D.Root;
  library_geometries := root.NodeByName('library_geometries');
  library_controllers := root.NodeByName('library_controllers');
  cList := TStringList.Create;
  cList.Add('Logfile generated by: BSP_Viewer');
  cList.Add('DAE file Name: ' + filename);
  cList.Add('');
  haveErrors := false;
  if library_geometries <> nil then
  begin
    if library_geometries.ElementCount > 0 then
    begin
      for i := 0 to library_geometries.ElementCount - 1 do
      begin
        ErrorFlags := 0;
        mesh := library_geometries.Elements[i].NodeByName('mesh');
        vertexCount := -1;
        NormalsCount := -1;
        UVMapCount := -1;
        for j := 0 to mesh.ElementCount - 1 do
        begin
          if mesh.Elements[j].Name = 'source' then
          begin
            accessor :=
              mesh.Elements[j].NodeByName('technique_common').NodeByName('accessor');
            if AnsiEndsStr('-positions',
              mesh.Elements[j].AttributeByName['id'].Value) then
              vertexCount := accessor.AttributeByName['count'].ValueAsInteger
            else if AnsiEndsStr('-normals',
              mesh.Elements[j].AttributeByName['id'].Value) then
              NormalsCount := accessor.AttributeByName['count'].ValueAsInteger
            else if AnsiEndsStr('-map1',
              mesh.Elements[j].AttributeByName['id'].Value) then
              UVMapCount := accessor.AttributeByName['count'].ValueAsInteger;
          end;
        end;
        if UVMapCount <> -1 then
        begin
          if (vertexCount <> UVMapCount) and (UVMapCount > -1) then
          begin
            ErrorFlags := ErrorFlags or $1;
          end;
        end
        else
        begin
          if (vertexCount <> NormalsCount) and (NormalsCount > -1) then
          begin
            ErrorFlags := ErrorFlags or $2;
          end;
        end;

        if ErrorFlags > 0 then
        begin
          cList.Add('Mesh: ' +
            library_geometries.Elements[i].AttributeByName['name'].Value);
          haveErrors := true;
          if (ErrorFlags and $1) > 0 then //
          begin
            cList.Add('Found: UV Coordinates problem. Value excepted: ' +
              IntToStr(vertexCount) + ' Value obtained:' +
              IntToStr(UVMapCount));
          end
          else if (ErrorFlags and $2) > 0 then //
          begin
            cList.Add('Found: Normals problem. Value excepted: ' +
              IntToStr(vertexCount) + ' Value obtained:' +
              IntToStr(NormalsCount));
          end;
          cList.Add('');
        end;
      end;
    end;
  end;
  if library_controllers <> nil then
  begin
    if library_controllers.ElementCount > 0 then
    begin
      for i := 0 to library_controllers.ElementCount - 1 do
      begin
        ErrorFlags := 0;
        node_skin := library_controllers.Elements[i].NodeByName('skin');
        mesh_name := node_skin.AttributeByName['source'].Value;
        mesh_name := Copy(mesh_name, 7, Length(mesh_name) - 6);
        vertex_weights := node_skin.NodeByName('vertex_weights');
        vcount := TStringList.Create;
        vcount.Delimiter := ' ';
        vcount.DelimitedText := vertex_weights.NodeByName('vcount').Value;
        weight_index := 0;
        for weight_index := 0 to vcount.Count - 1 do
        begin
          iterations := StrToInt(vcount[weight_index]);
          if iterations > 2 then
          begin
            haveErrors := true;
            ErrorFlags := ErrorFlags or $4;
          end;
        end;
        vcount.Free;
        if ErrorFlags > 0 then
        begin
          cList.Add('Mesh: ' + mesh_name);
          cList.Add('Found: Critical error! More than two weights per vertex have been found!');
          cList.Add('');
        end;
      end;
    end;
  end;
  if haveErrors then
  begin
    response :=
      messagedlg('BSP_Viewer found some irregularities in your file. Do you want to generate log file?', mtError, [mbYes, mbNo], 0);
    if response = 6 then //Yes
    begin
      cList.SaveToFile(ExtractFilePath(filename) + 'DaeLogErrors.txt');
      ShowMessage('DaeLogErrors.txt file saved succesfully' + #13#10 +
        filename);
    end;
  end;
  cList.Free;
  D.Free;
end;

function TBSP.GetValidPath(path, filename: string): string;
var
  temp: string;
begin
  if AnsiStartsStr('file:///', filename) then
  begin
    temp := Copy(filename, 9, Length(filename) - 7);
    temp := StringReplace(temp, '/', '\', [rfReplaceAll, rfIgnoreCase]);
    Result := temp;
  end
  else if AnsiStartsStr(':/', filename) then
  begin
    Result := StringReplace(filename, '/', '\', [rfReplaceAll, rfIgnoreCase]);
  end
  else if AnsiStartsStr('../', filename) then
  begin
    Result := path + StringReplace(filename, '../', '', [rfReplaceAll,
      rfIgnoreCase]);
  end
  else //no relative path
  begin
    Result := path + StringReplace(filename, '/', '\', [rfReplaceAll,
      rfIgnoreCase]);
  end;
end;

procedure TBSP.ImportDAE(filename: string);
var
  D: TNativeXml;
  root, library_images, library_materials, library_effects, le_blinn,
    visual_scene, library_geometries, vs_node, node: TXmlNode;
  i, lastIndex: integer;
  TextureDictionary: TTextures;
  Texture: TTextureOpengl;
  MatDictionary: TMatDictionary;
  MaterialObj: TMaterialObj;
  cEntities: TEntities;
  entity: TEntity;
  clump: TClump;
  uTextures: TDictionary;
  path, material, texture_file: string;
  MatHash: Cardinal;

  function FilesValid: boolean;
  var
    PNG: TPNGObject;
    image_path: string;
    i: integer;
    node_image: TXmlNode;

  begin
    Result := true; //We assume it's valid
    library_images := root.NodeByName('library_images');
    for i := 0 to library_images.ElementCount - 1 do
    begin
      node_image := library_images.Elements[i];
      path := ExtractFilePath(Filename);
      image_path := GetValidPath(path,
        node_image.NodeByName('init_from').Value);
      if FileExists(image_path) then
      begin
        try
          try
            PNG := TPNGObject.Create;
            PNG.LoadFromFile(image_path);
          except
            ShowMessage('Texture: ' + image_path +
              ' use unsupported compression format.' + #13#10 +
              'Please, convert your file to another one!');
            Result := False;
            Break;
          end;
        finally
          PNG.Free;
        end;
      end
      else
      begin
        ShowMessage('Texture: ' + image_path + ' was not found!');
        Result := False;
        Break;
      end;
    end;
  end;
begin
  D := TNativeXml.CreateName('COLLADA');
  D.LoadFromFile(FileName);

  root := D.Root;
  DaeRoot := root;
  DaeSkinBones := TStringList.Create;
  if FilesValid() then
  begin
    library_geometries := root.NodeByName('library_geometries');
    visual_scene :=
      root.NodeByName('library_visual_scenes').NodeByName('visual_scene');
    if (library_geometries <> nil) and (visual_scene <> nil) then //Is Valid DAE
    begin
      //Load Images
      path := ExtractFilePath(Filename);
      TextureDictionary := BSPFile.Textures;
      library_images := root.NodeByName('library_images');
      uTextures := TDictionary.Create();
      if library_images <> nil then
      begin
        for i := 0 to library_images.ElementCount - 1 do
        begin
          texture_file := GetValidPath(path,
            library_images.Elements[i].NodeByName('init_from').Value);
          Texture := TextureDictionary.AddTexture(library_images.Elements[i],
            texture_file);
          if not TextureDictionary.AreDuplicates(Texture) then
          begin
            Texture.ID := GlobalID;
            Inc(GlobalID);
            Inc(TextureDictionary.Num);
            lastIndex := Length(TextureDictionary.Textures);
            SetLength(TextureDictionary.Textures, lastIndex + 1);
            TextureDictionary.Textures[lastIndex] := Texture;
          end;
          uTextures.Value[Texture.name] := Texture.hash;
        end;
      end;
      //Load all materials
      uMaterials := TDictionary.Create();
      MatDictionary := BSPFile.Materials;
      library_effects := root.NodeByName('library_effects');
      if library_effects <> nil then
      begin
        for i := 0 to library_effects.ElementCount - 1 do
        begin
          MaterialObj := TMaterialObj.Create(nil);
          MaterialObj.MakeDefault(BSPFile);
          MaterialObj.AddMaterial(library_effects.Elements[i], uTextures);
          material := library_effects.Elements[i].AttributeByName['id'].Value;
          MaterialObj.TypeName := material + '_dae';
          MatHash := MaterialObj.MaterialHash;
          if MatDictionary.FindMaterialOfHash(MatHash) = nil then
          begin
            lastIndex := MatDictionary.Num;
            Inc(MatDictionary.Num);
            SetLength(MatDictionary.Materials, MatDictionary.Num);
            MatDictionary.Materials[lastIndex] := MaterialObj;
          end
          else
            MaterialObj.Free;
          uMaterials.Value[material] := MatHash;
        end;
      end;
      //Check all nodes
      cEntities := BSPFile.Entities;
      for i := 0 to visual_scene.ElementCount - 1 do
      begin
        node := visual_scene.Elements[i];
        if AnsiStartsStr('entity_', node.AttributeByName['name'].Value) then
        begin
          entity := TEntity.Create(nil);
          entity.MakeDefault(BSPFile);
          entity.AddEntity(4, node.NodeByName('node'));
          lastIndex := cEntities.Num;
          Inc(cEntities.Num);
          SetLength(cEntities.Entities, cEntities.Num);
          cEntities.Entities[lastIndex] := entity;
        end; //else World.... etc FIX IT LATER
      end;
      //Clear unused objects
      DaeSkinBones.Free;
      uTextures.Free;
      uMaterials.Free;
    end;
  end;
  D.Free;
end;

procedure TBSP.ExportDAE(FileName: string; Chunk: TChunk; Options: DAEOptions;
  ScaleFactor: Single);
var
  D: TNativeXml;
  COLLADA: TsdElement;
  node: TXmlNode;
  str, up_axis: string;
  tempClump: TClump;
  tempRoot: TSpFrame;
  i: integer;
  nMesh: TMesh;

  procedure RecurseAddBones(var bone: TSpFrame);
  var
    j: integer;
    nMesh: TMesh;
  begin
    if bone.bone_index = -1 then
    begin
      j := Length(DaeBlenderBones);
      SetLength(DaeBlenderBones, j + 1);

      nMesh := TMesh.Create;
      nmesh.Hash := bone.hash;
      nMesh.Name := bone.name;
      nMesh.BoneMatrix:= bone.matrix_2.m;
      nMesh.InvBoneMatrix := MatrixInvertPrecise(bone.matrix_2.m);
      DaeBlenderBones[j] := nMesh;
    end;
    for j := 0 to High(bone.Bones) do
    begin
      RecurseAddBones(TSpFrame(bone.Bones[j]));
    end;
  end;

begin
  // export
  tDirtyScenarioFlag := false;
  //Temporary...
  DAEPATH := ExtractFilePath(FileName);
  D := TNativeXml.CreateName('COLLADA');
  D.XmlFormat := xfReadable;
  D.ExternalEncoding := seUTF8;
  COLLADA := D.Root;
  COLLADA.AttributesAdd([
    D.AttrText('xmlns', 'http://www.collada.org/2005/11/COLLADASchema'),
      D.AttrText('version', '1.4.1')
      ]);
  str := FormatDateTime('yyyy-mm-dd"T"hh:mm:ss', Now);

  DAE_Options := Options;
  if DAE_CONVERT in DAE_Options then
  begin
    up_axis := 'Z_UP';
    ConvertMatrix := CONVERT_M;
  end
  else
  begin
    up_axis := 'Y_UP';
    ConvertMatrix := InitMatrix;
  end;

  COLLADA.NodeAdd(
    D.NodeNew('asset', [
    D.NodeNew('contributor', [
      D.NodeNewText('authoring_tool', 'BSPViewer Exporter'),
        D.NodeNewText('source_data', self.BSPfile.bspfilename)
        ]),
      D.NodeNewText('created', str),
      D.NodeNewText('modified', str),
      D.NodeNewAttr('unit', [//attributes
      D.AttrText('name', 'inch'),
        D.AttrText('meter', FloatToStrF(ScaleFactor, ffGeneral, 7, 4))
        ]),
      D.NodeNewText('up_axis', up_axis)
      ]));
  COLLADA.NodesAdd([
    D.NodeNew('library_effects'),
      D.NodeNew('library_materials'),
      D.NodeNew('library_geometries'),
      D.NodeNew('library_controllers'),
      D.NodeNew('library_images')
      ]);

  node := D.NodeNew('node');
  COLLADA.NodeAdd(
    D.NodeNew('library_visual_scenes', [
    D.NodeNewAttr('visual_scene', [
      D.AttrText('id', 'scene'),
        D.AttrText('name', 'scene')
        ],
        [node]
      )
      ])
      );
  ClumpId := '';
  if Chunk.IDType = C_RenderBlock then
  begin
    node.AttributesAdd([
      D.AttrText('id', IntToStr(C_RenderBlock)),
        D.AttrText('name', 'RenderBlock')
        ]);
    node.NodeAdd(D.NodeNewText('matrix', ConvertMatrix));
  end;
  if Chunk.IDType = C_Mesh then
  begin
    node.AttributesAdd([
      D.AttrText('id', IntToStr(C_Mesh)),
        D.AttrText('name', 'Mesh')
        ]);
    node.NodeAdd(D.NodeNewText('matrix', ConvertMatrix));
  end;
  if (DAE_BLENDER in DAE_Options) then
  begin
    if Chunk.IDType <> C_Root then
    begin
      tempClump := TEntity(Chunk).Clump;
      SetLength(DaeBlenderBones, tempClump.num_bones);
      for i := 0 to tempClump.num_bones - 1 do
      begin
        nMesh := TMesh.Create;
        nMesh.Hash := tempClump.BoneLib[i].Bone.Hash;
        nMesh.Name := tempClump.BoneLib[i].Bone.Name;
        nMesh.BoneMatrix:= tempClump.BoneLib[i].Bone.BoneMatrix;
        nMesh.InvBoneMatrix := tempClump.BoneLib[i].Bone.InvBoneMatrix;
        DaeBlenderBones[i] := nMesh;
      end;

      for i:=0 to High(tempClump.Root.Bones) do
      begin
        RecurseAddBones(TSpFrame(tempClump.Root.Bones[i]));
      end; 
      AddDaeChunk(D, node, Chunk);
      for i:=0 to High(DaeBlenderBones) do
      begin
        DaeBlenderBones[i].Free;
      end;
    end
    else
    begin
      Exclude(DAE_Options, DAE_BLENDER);
      Include(DAE_Options, DAE_MAX);
      AddDaeChunk(D, node, Chunk);
    end;
  end
  else
    AddDaeChunk(D, node, Chunk);

  if (DAE_CLIPS in DAE_Options) or (DAE_ANIM in DAE_Options) then
    AddAnimChunk(D, Chunk);
  COLLADA.NodeAdd(
    D.NodeNew('scene', [
    D.NodeNewAttr('instance_visual_scene', [
      D.AttrText('url', '#scene')]
        )]));

  D.SaveToFile(FileName);
  D.Free;
end;

function RecursiveFindNode(ANode: TXmlNode; const SearchNodeID: string):
  TXmlNode;
var
  I: Integer;
begin
  if (ANode.Name = 'node') and (Utf8CompareText(ANode.Attributes[0].Value,
    SearchNodeID) = 0) then
  begin
    result := ANode;
  end
  else if ANode.ElementCount = 0 then
    Result := nil
  else
  begin
    for I := 0 to ANode.ElementCount - 1 do
    begin
      Result := RecursiveFindNode(ANode.Elements[I], SearchNodeID);
      if Result <> nil then
        Exit;
    end;
  end;
end;

procedure TBSP.AddAnimChunk(D: TNativeXml; Chunk: TChunk);
var
  AnimClip: TAnimClip;
  s: string;
  i, j: Integer;
  Animation,
    Clip,
    Source,
    param,
    sampler,
    input,
    channel,
    LibraryAnim,
    LibraryClips: TXmlNode;

  function AddLINEAR(num: integer): string;
  var
    k: integer;
    l: string;
  begin
    l := '';
    for k := 0 to num - 1 do
      l := Format('%sLINEAR ', [l]);
    Result := Trim(l);
  end;

  procedure AddAnimation(AClip: TAnimClip; BaseMatrix: Boolean);
  var
    n, m, FrameCount: integer;
    TimeText, MatrixText, Source_id: string;
    BoneUse: array of Boolean;
    BoneNode: TXmlNode;
    Frame: TSpFrame;
  begin
    Animation := D.NodeNew('animation');
    LibraryAnim.NodeAdd(Animation);
    m := Length(AClip.Bones) - 1;
    SetLength(BoneUse, m + 1);
    for n := 0 to m do
    begin //GetBoneName
      Frame := Chunk.BSP.GetBone(AClip.Bones[n].boneHash);

      if (DAE_BLENDER in DAE_OPTIONS) then
      begin
        if Frame <> nil then
          s := 'node-' + Frame.name + '_matrix'
        else
          s := 'node-' + Format('%.8x_matrix', [AClip.Bones[n].boneHash]);
      end
      else
      begin
        if Frame <> nil then
          s := 'node-' + Frame.name + '_matrix'
        else
          s := 'node-' + Format('%.8x_matrix', [AClip.Bones[n].boneHash]);
      end;

      FrameCount := 0; // get matrix count;
      AClip.GenAnimMatrix(n, FrameCount, TimeText, MatrixText);
      if BaseMatrix and (FrameCount = 1) then
      begin
        // Replace BoneMatrix to MatrixText
      {  BoneNode:=RecursiveFindNode(D.Root.NodeByName('library_visual_scenes').Elements[0],Format('%.8x',[AClip.Bones[n].boneHash]));
        if BoneNode<>nil then begin
          BoneNode.Elements[0].Value:=MatrixText;
          BoneUse[n]:=False;
        end; }
        Continue;
      end;
      BoneUse[n] := True;

      Source_id := s + '-input';
      Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
      Animation.NodeAdd(Source);
      Source.NodeAdd(D.NodeNewTextAttr('float_array',
        TimeText,
        [D.AttrText('id', Source_id + '-array'),
        D.AttrInt('count', FrameCount)]));
      Source.NodeAdd(D.NodeNew('technique_common', [
        D.NodeNewAttr('accessor', [
          D.AttrText('source', '#' + Source_id + '-array'),
            D.AttrInt('count', FrameCount),
            D.AttrInt('stride', 1)
            ], [
            D.NodeNewAttr('param', [
            D.AttrText('name', 'TIME'),
              D.AttrText('type', 'float')
              ])
            ])
          ]));

      Source_id := s + '-output';
      Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
      Animation.NodeAdd(Source);
      Source.NodeAdd(D.NodeNewTextAttr('float_array',
        MatrixText,
        [D.AttrText('id', Source_id + '-array'),
        D.AttrInt('count', FrameCount * 16)]));
      Source.NodeAdd(D.NodeNew('technique_common', [
        D.NodeNewAttr('accessor', [
          D.AttrText('source', '#' + Source_id + '-array'),
            D.AttrInt('count', FrameCount),
            D.AttrInt('stride', 16)
            ], [
            D.NodeNewAttr('param', [
            D.AttrText('name', 'TRANSFORM'),
              D.AttrText('type', 'float4x4')
              ])
            ])
          ]));

      Source_id := s + '-interpolation';
      Source := D.NodeNewAttr('source', [D.AttrText('id', Source_id)]);
      Animation.NodeAdd(Source);
      Source.NodeAdd(D.NodeNewTextAttr('Name_array',
        AddLINEAR(FrameCount),
        [D.AttrText('id', Source_id + '-array'),
        D.AttrInt('count', FrameCount)]));
      Source.NodeAdd(D.NodeNew('technique_common', [
        D.NodeNewAttr('accessor', [
          D.AttrText('source', '#' + Source_id + '-array'),
            D.AttrInt('count', FrameCount),
            D.AttrInt('stride', 1)
            ], [
            D.NodeNewAttr('param', [
            D.AttrText('name', 'INTERPOLATION'),
              D.AttrText('type', 'name')
              ])
            ])
          ]));

    end;
    for n := 0 to m do
      if BoneUse[n] then
      begin
        Frame := Chunk.BSP.GetBone(AClip.Bones[n].boneHash);
        if (DAE_BLENDER in DAE_OPTIONS) then
        begin
          if Frame <> nil then
            s := 'node-' + Frame.name + '_matrix'
          else
            s := 'node-' + Format('%.8x_matrix', [AClip.Bones[n].boneHash]);
        end
        else
        begin
          if Frame <> nil then
            s := 'node-' + Frame.name + '_matrix'
          else
            s := 'node-' + Format('%.8x_matrix', [AClip.Bones[n].boneHash]);
        end;

        sampler := D.NodeNewAttr('sampler',
          [D.AttrText('id', s + '-sampler')]
          );
        Animation.NodeAdd(sampler);
        sampler.NodesAdd([
          D.NodeNewAttr('input', [
            D.AttrText('semantic', 'INPUT'),
              D.AttrText('source', '#' + s + '-input')
              ]),
            D.NodeNewAttr('input', [
            D.AttrText('semantic', 'OUTPUT'),
              D.AttrText('source', '#' + s + '-output')
              ]),
            D.NodeNewAttr('input', [
            D.AttrText('semantic', 'INTERPOLATION'),
              D.AttrText('source', '#' + s + '-interpolation')
              ])
            ]);

      end;
    for n := 0 to m do
      if BoneUse[n] then
      begin
        Frame := Chunk.BSP.GetBone(AClip.Bones[n].boneHash);
        if (DAE_BLENDER in DAE_OPTIONS) then
        begin
          if Frame <> nil then
            s := 'node-' + Frame.name + '_matrix'
          else
            s := 'node-' + Format('%.8x_matrix', [AClip.Bones[n].boneHash]);
        end
        else
        begin
          if Frame <> nil then
            s := 'node-' + Frame.name + '_matrix'
          else
            s := 'node-' + Format('%.8x_matrix', [AClip.Bones[n].boneHash]);
        end;

        Animation.NodeAdd(D.NodeNewAttr('channel', [
          D.AttrText('source', '#' + s + '-sampler'),
            D.AttrText('target', StringReplace(s, '_matrix', '/matrix',
            [rfReplaceAll, rfIgnoreCase])
            )]));
      end;
  end;

begin
  LibraryAnim := D.Root.NodeNew('library_animations');
  j := AnimClips.Count;
  if (DAE_CLIPS in DAE_Options) and (j > 1) then
  begin
    LibraryClips := D.Root.NodeNew('library_animation_clips');
    //if j>100  then j:=100;
    for i := 0 to j - 1 do
    begin
      AnimClip := AnimClips.GetItemID(i);
      AddAnimation(AnimClip, false);
      Clip := D.NodeNewAttr('animation_clip', [
        D.AttrText('name', AnimClip.Name),
          D.AttrInt('start', 0),
          D.AttrFloat('end', AnimClip.Time)
          ],
          [D.NodeNewAttr('instance_animation',
          [D.AttrText('url', '#' + AnimClip.Name + '-anim')]
          )]);
      LibraryClips.NodeAdd(Clip);
    end;
  end
  else
  begin
    AddAnimation(CurAnimClip, true);
  end;
end;

function TBSP.ImportDAEAnimClip(FileName: string; AnimLib: TAnimDictionary;
  Options: DAEOptions; clipname: string): TDictAnim;
var
  D: TNativeXml;
begin
  D := TNativeXml.CreateName('COLLADA');
  D.LoadFromFile(FileName);
  DAE_Options := Options;
  Result := AnimLib.LoadFromDAE(D.Root, clipname);
  D.Free;
end;

{ TTextureOpenGL }

procedure TTextureOpenGL.AddFields;

begin
  inherited;
  AddTreeData(nil, 'Name', @name, BSPString);
  AddTreeData(nil, 'Mask Name', @path, BSPString);
  AddTreeData(nil, 'Width', @width, BSPInt);
  AddTreeData(nil, 'Height', @height, BSPInt);
  AddTreeData(nil, 'Filter Mode', @min_mag_type, BSPGLMigMag);
  AddTreeData(nil, 'Address Mode', @wrap_type, BSPGLRepeat);
  AddTreeData(nil, 'Format', @pixel_format, BSPTextureFormat);
  AddTreeData(nil, 'Border Colour', @border_color, BSPColor);
  AddTreeData(nil, 'Hash', @hash, BSPHash);
end;

constructor TTextureOpenGL.Create;
begin

end;

type

  TRGBA = record
    b, g, r, a: Byte;
  end;
  ARGBA = array[0..1] of TRGBA;
  PARGBA = ^ARGBA;

  TRGBA4 = record
    b, g, r, a: Integer;
  end;
  ARGBA4 = array[0..1] of TRGBA4;
  PARGBA4 = ^ARGBA4;

  TRGB = record
    b, g, r: Byte;
  end;
  ARGB = array[0..1] of TRGB;
  PARGB = ^ARGB;

  TRGB4 = record
    b, g, r: Integer;
  end;
  ARGB4 = array[0..1] of TRGB4;
  PARGB4 = ^ARGB4;

function TTextureOpenGL.MakeBMPImage(XGrid: boolean = true): TBitmap;
var
  VBuf, VBuf2: Pointer;
  w, h, i, j, ci, IName, ISize, CntrIndx: Integer;
  b: TBitmap;
  p0: PARGBA;
  p1: PARGBA;
  p2: PARGB;
  p4: PARGB;
  Grid, Bsize: Byte;
  Bgrid: Boolean;
  alfa, beta: Real;
  Buffer: TMemoryStream;
  DxtBlocks: pointer;
  pp, bb: PBArray;
begin
  b := TBitmap.Create;
  b.canvas.Brush.Style := bsSolid;
  b.canvas.Brush.Color := clBlack;
  w := width; // Width
  b.Width := w;
  h := height; // Height
  b.Height := h;
  VBuf := image.bitmap;
  if image.bits = 32 then
  begin
    b.PixelFormat := pf32bit;
    for j := 0 to h - 1 do
    begin
      p0 := b.scanline[j];
      p1 := Pointer(Longword(VBuf) + j * w * 4);
      for i := 0 to w - 1 do
      begin
        if XGrid then
        begin
          Bgrid :=
            ((i - i mod 8) mod 16 = 0)
            xor
            ((j - j mod 8) mod 16 = 0);
          if not Bgrid then
            grid := 192
          else
            grid := 255;

          p0[i].B := (p1[i].A * (p1[i].R - Grid) shr 8) + Grid;
          p0[i].G := (p1[i].A * (p1[i].G - Grid) shr 8) + Grid;
          p0[i].R := (p1[i].A * (p1[i].B - Grid) shr 8) + Grid;

        end
        else
        begin
          p0[i].g := p1[i].g;
          p0[i].b := p1[i].r;
          p0[i].r := p1[i].b;
          p0[i].a := p1[i].a;
        end;
      end;
    end;
  end
  else
  begin
    p1 := image.palette;
    bb := image.bitmap;
    b.PixelFormat := pf32bit;
    for j := 0 to h - 1 do
    begin
      p0 := b.scanline[j];
      for i := 0 to w - 1 do
      begin
        ci := bb[j * w + i];
        if XGrid then
        begin
          Bgrid :=
            ((i - i mod 8) mod 16 = 0)
            xor
            ((j - j mod 8) mod 16 = 0);
          if not Bgrid then
            grid := 192
          else
            grid := 255;

          p0[i].B := (p1[ci].A * (p1[ci].R - Grid) shr 8) + Grid;
          p0[i].G := (p1[ci].A * (p1[ci].G - Grid) shr 8) + Grid;
          p0[i].R := (p1[ci].A * (p1[ci].B - Grid) shr 8) + Grid;

        end
        else
        begin
          p0[i].g := p1[ci].g;
          p0[i].b := p1[ci].r;
          p0[i].r := p1[ci].b;
          p0[i].a := p1[ci].a;
        end;
      end;
    end;
  end;
  result := b;
end;

type
  pTRGB = packed record R, G, B: byte
  end;
  pTRGBA = packed record B, G, R, A: byte
  end;
  TRGBAArray = array[0..0] of pTRGBA;
  TRGBArray = array[0..0] of pTRGB;

procedure TTextureOpenGL.LoadPNGImage(Filename: string);
var
  PNG: TPNGObject;
  x, y, bSize, bMax: Cardinal;
  BmpRGBA: ^TRGBAArray;
  PngRGB: ^TRGBArray;
  FileStream: TMemoryStream;
  dataMem: Pointer;
begin
  PNG := TPNGObject.Create;
  try
    PNG.LoadFromFile(Filename);
    FileStream := TMemoryStream.Create;
    FileStream.Position := 0;
    bSize := 1;
    bMax := 255;
    if PNG.Transparent then
    begin
      for y := 0 to PNG.Height - 1 do
      begin
        PngRGB := PNG.ScanLine[y];
        for x := 0 to PNG.Width - 1 do
        begin
          FileStream.Write(PngRGB[X].B, bSize);
          FileStream.Write(PngRGB[X].G, bSize);
          FileStream.Write(PngRGB[X].R, bSize);
          FileStream.Write(PNG.AlphaScanline[y][x], bSize);
        end;
      end;
    end
    else
    begin
      for y := 0 to PNG.Height - 1 do
      begin
        PngRGB := PNG.ScanLine[y];
        for x := 0 to PNG.Width - 1 do
        begin
          FileStream.Write(PngRGB[X].B, bSize);
          FileStream.Write(PngRGB[X].G, bSize);
          FileStream.Write(PngRGB[X].R, bSize);
          FileStream.Write(bMax, bSize);
        end;
      end;
    end;
    dataMem := Pointer(Longword(FileStream.Memory));
    width := PNG.Width;
    height := PNG.Height;
    image.width := width;
    image.height := height;
    image.bytewidth := 4 * width;
    image.bits := 32;
    GetMem(image.bitmap, image.bytewidth * height);
    CopyMemory(image.bitmap, dataMem, image.bytewidth * height);
    FileStream.Free;
    hash := MakeTextureHash;
    Bitmap := MakeBMPImage();
  finally
    PNG.Free;
  end
end;

procedure TTextureOpenGL.ReplacePNGImage(Filename: string; CustomTree:
  TCustomVirtualStringTree);
var
  oldHash: Cardinal;
begin
  oldHash:= hash;
  LoadPNGImage(Filename);
  //Replace Old Texture hash with the new one.
  UpdateTextureHash(CustomTree,oldHash);
end;

procedure TTextureOpenGL.SavePNGImage(Filename: string);
var
  PNG: TPNGObject;
  X, Y: integer;
  BmpRGBA: ^TRGBAArray;
  PngRGB: ^pTRGB;
begin
  PNG := TPNGObject.CreateBlank(COLOR_RGBALPHA, 8, image.Width, image.Height);
  PNG.CreateAlpha;
  for Y := 0 to Pred(image.Height) do
  begin
    BmpRGBA := Pointer(Longword(image.bitmap) + Y * X * 4);
    PngRGB := PNG.Scanline[Y];
    for X := 0 to Pred(image.width) do
    begin
      PNG.AlphaScanline[Y][X] := BmpRGBA[X].A;
      PngRGB^.B := BmpRGBA[X].B;
      PngRGB^.R := BmpRGBA[X].R;
      PngRGB^.G := BmpRGBA[X].G;
      Inc(PngRGB);
    end;
  end;
  try
    PNG.SaveToFile(Filename);
  finally
    PNG.Free;
  end
end;

const
  RGBA4byte = 16; // R4byte G4byte B4byte A4Byte
  RGBAbyte = 4; // RGBA
  index4byte = 4;

procedure TTextureOpenGL.Read(Chunk: TChunk);
var
  pix: Integer;
  b4map: Pointer;
  bp, pp: PBArray;
  b4, p4: PDArray;
  function GetBitsMask(px: Cardinal): Cardinal;
  asm
    and     eax, $2000
    neg     eax
    sbb     eax, eax
    and     al, $0E8
    add     eax, $20
  end;
begin
  BSP := Chunk.BSP;
  name := Chunk.ReadString;
  path := Chunk.ReadString;
  width := Chunk.ReadByteBlock;
  height := Chunk.ReadByteBlock;
  image.width := width;
  image.height := height;
  image.bytewidth := width;
  min_mag_type := Chunk.ReadByteBlock;
  wrap_type := Chunk.ReadByteBlock;
  pixel_format := Chunk.ReadByteBlock;
  border_color := Chunk.ReadColor;

  if (pixel_format and $10 > 0) then
    image.bits := 4
  else
    image.bits := GetBitsMask(pixel_format);

  if image.bits = 4 then
  begin
    // palette  16
    p4 := Chunk.ReadBytesMBlock(RGBA4byte * 16);
    // R4byte G4byte B4byte A4Byte * 16
    GetMem(image.palette, RGBAbyte * 16); // RGBA * 16
    pp := image.palette;
    for pix := 0 to 16 * RGBAbyte - 1 do
      pp[pix] := Byte(p4[pix]);
    FreeMem(p4);
    b4map := Chunk.ReadBytesMBlock(index4byte * image.bytewidth * height);
  end
  else if image.bits = 8 then
  begin // never can be?
    // palette  256
    p4 := Chunk.ReadBytesMBlock(RGBA4byte * 256);
    // R4byte G4byte B4byte A4Byte * 256
    GetMem(image.palette, RGBAbyte * 256); // RGBA * 256
    pp := image.palette;
    for pix := 0 to 256 * RGBAbyte - 1 do
      pp[pix] := Byte(p4[pix]);
    FreeMem(p4);
    b4map := Chunk.ReadBytesMBlock(index4byte * image.bytewidth * height);
  end
  else
  begin // bits = 32;
    image.bytewidth := 4 * width;
    b4map := Chunk.ReadBytesMBlock(RGBAbyte * image.bytewidth * height);
  end;
  GetMem(image.bitmap, image.bytewidth * height);
  bp := image.bitmap;
  b4 := b4map;
  for pix := 0 to image.bytewidth * height - 1 do
    bp[pix] := Byte(b4[pix]);
  FreeMem(b4map);

  hash := MakeTextureHash();
  Bitmap := MakeBMPImage();
end;

procedure TTextureOpenGL.Write(Chunk: TChunk);
var
  data: array[0..1] of Cardinal;
begin
  Chunk.WriteString(name);
  Chunk.WriteString(path);
  Chunk.WriteByteBlock(width);
  Chunk.WriteByteBlock(height);
  Chunk.WriteByteBlock(min_mag_type);
  Chunk.WriteByteBlock(wrap_type);
  Chunk.WriteByteBlock(pixel_format);
  Chunk.WriteColor(border_color);

  if image.bits = 4 then
  begin
    // palette  16
    Chunk.WriteBytesMBlock(image.palette, 16 * RGBAbyte);
    Chunk.WriteBytesMBlock(image.bitmap, 1 * image.width * height);
  end
  else if image.bits = 8 then
  begin
    // palette  256
    Chunk.WriteBytesMBlock(image.palette, 256 * RGBAbyte);
    Chunk.WriteBytesMBlock(image.bitmap, 1 * image.width * height);
  end
  else
  begin // bits = 32;
    Chunk.WriteBytesMBlock(image.bitmap, RGBAbyte * image.width * height);
  end;
end;

destructor TTextureOpenGL.Destroy;
begin
  if Bitmap <> nil then
    Bitmap.Free;
  if image.bitmap <> nil then
    FreeMem(image.bitmap);
  if image.palette <> nil then
    FreeMem(image.palette);
  inherited;
end;

function TTextureOpenGL.GetMagFilter(filter: Cardinal): Cardinal;
begin
  case filter of
    2, 3, 4, 5, 6: result := GL_LINEAR;
  else
    result := GL_NEAREST;
  end;
end;

function TTextureOpenGL.GetMinFilter(filter: Cardinal): Cardinal;
begin
  case filter of
    2: result := GL_LINEAR;
    3: result := GL_NEAREST_MIPMAP_NEAREST;
    4: result := GL_LINEAR_MIPMAP_NEAREST;
    5: result := GL_NEAREST_MIPMAP_LINEAR;
    6: result := GL_LINEAR_MIPMAP_LINEAR;
  else
    result := GL_NEAREST;
  end;
end;

function TTextureOpenGL.GetPixFormat(format: Cardinal): Cardinal;
begin
  // GL_RGBA8  GL_RGB8   GL_RGB  GL_LUMINANCE8
  result := GL_RGBA;
end;

const
  GL_MIRRORED_REPEAT = $8370;
  GL_CLAMP_TO_EDGE = $812F;

function TTextureOpenGL.GetRepeat(_repeat: Cardinal): Cardinal;
begin
  case _repeat of
    2: result := GL_MIRRORED_REPEAT;
    3: result := GL_CLAMP_TO_EDGE;
    4: result := GL_CLAMP;
  else
    result := GL_REPEAT;
  end;
end;

function TTextureOpenGL.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := TreeView.AddChild(TreeNode);
  Data := TreeView.GetNodeData(Result);
  Data^.Name := name;
  Data^.Value := '[Texture]';
  Data^.ID := Format('[%.*d]', [4, ID]);
  Data^.ImageIndex := 3;
  Data^.Obj := self;
  Data^.Hash := Format('[%.*x]', [8, hash]);
end;

procedure TTextureOpenGL.SearchForTextureObj(Sender: TBaseVirtualTree; Node:
  PVirtualNode; Obj: Pointer; var Abort: Boolean);
var
  NodeData: PClassData;
  Chunk: TChunk;
begin
  NodeData := Sender.GetNodeData(Node);
  if TObject(NodeData^.Obj) is TChunk then
  begin
    Chunk := TChunk(NodeData^.Obj);
    if (Chunk = self) then
    begin
      NodeData^.Name := Name;
      NodeData^.Hash := Format('[%.*x]', [8, hash]);
      NodeData^.Changed := true;
    end;
  end;
end;

procedure TTextureOpenGL.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
begin
  UpdateTextureHash(CustomTree, hash);
end;

function TTextureOpenGL.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TTextureOpenGL;
begin
  Chunk := TTextureOpenGL.Create;
  // copy
  if nBSP <> nil then
  begin
    Chunk.name := name;
    Chunk.path := path;
    Chunk.width := width;
    Chunk.height := height;
    Chunk.min_mag_type := min_mag_type;
    Chunk.wrap_type := wrap_type;
    Chunk.pixel_format := pixel_format;
    Chunk.border_color := border_color;
    Chunk.hash := hash;
    //copy image
    Chunk.image.mask := image.mask;
    Chunk.image.width := image.width;
    Chunk.image.height := image.height;
    Chunk.image.bits := image.bits;
    Chunk.image.bytewidth := image.bytewidth;
    Chunk.image.palette := image.palette;
    Chunk.image.id := image.id;
    Chunk.image.link := image.link;
    GetMem(Chunk.image.bitmap, image.bytewidth * height);
    CopyMemory(Chunk.image.bitmap, image.bitmap, image.bytewidth * height);
    //
    Chunk.Bitmap := TBitmap.Create;
    Chunk.Bitmap.Assign(Bitmap);
  end;
  Result := Chunk;
end;

function TTextureOpenGL.MakeTextureHash(): Integer;
var
  hData: array[0..1] of Cardinal;
begin
  Result := BitmapHash(image);
  hData[0] := wrap_type;
  hData[1] := min_mag_type;
  Result := Result xor MakeHash(@hData, 8);
end;

procedure TTextureOpenGL.UpdateTextureHash(CustomTree:
  TCustomVirtualStringTree; oldHash: Cardinal);
var
  i, j: Cardinal;
  tempMaterial: TMaterialObj;
begin
  hash := MakeTextureHash();
  //Replace hash for materials
  if BSP.Materials <> nil then
    if Length(BSP.Materials.Materials) > 0 then
    begin
      for i := 0 to High(BSP.Materials.Materials) do
      begin
        tempMaterial := BSP.Materials.Materials[i];
        if tempMaterial <> nil then
          for j := 0 to 4 do
          begin
            if tempMaterial.Texture[j].hash = oldHash then
            begin

              tempMaterial.Texture[j].name := name;
              tempMaterial.Texture[j].path := path;
              tempMaterial.Texture[j].pixel_format := pixel_format;
              tempMaterial.Texture[j].min_mag_type := min_mag_type;
              tempMaterial.Texture[j].wrap_type := wrap_type;
              tempMaterial.Texture[j].border_color := border_color;
              tempMaterial.Texture[j].hash := hash;
              tempMaterial.Texture[j].Texture := Self;
              tempMaterial.SetNewMaterialHash(CustomTree);
              if tempMaterial.T1 > 0 then
                glDeleteTextures(1, @tempMaterial.T1);
              if tempMaterial.T2 > 0 then
                glDeleteTextures(1, @tempMaterial.T2);
              if tempMaterial.T3 > 0 then
                glDeleteTextures(1, @tempMaterial.T3);
              tempMaterial.GenTextures;
            end;
          end;
      end;
    end;
  CustomTree.IterateSubtree(nil, SearchForTextureObj, nil);
end;

{ TMaterialObj }

procedure TMaterialObj.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_MaterialObj;
  Version := 1698;
  mat_id := ID + BSP.IndexOffset;
end;

function TMaterialObj.ReadGLTexture(Textures: TTextures): TGLTexture;
// ReadTexture
begin
  ZeroMemory(@Result, SizeOf(Result));
  with Result do
  begin
    if Version > 1676 then
      uv_set := ReadByteBlock;
    name := ReadString;
    if Length(name) > 0 then
    begin
      if Version = 1676 then
        uv_set := 0;
      Inc(texture_num);
      pixel_format := ReadByteBlock;
      min_mag_type := ReadByteBlock;
      wrap_type := ReadByteBlock;
      path := ReadString;
      border_color := ReadColor;
      hash := ReadDword;
      if Textures <> nil then
        Texture := Textures.FindTextureOfHash(hash);
    end
    else
    begin
      if Version = 1676 then
      begin
        uv_set:= MaxInt;
      end;
    end;
  end;
end;

procedure TMaterialObj.WriteGLTexture(Texture: TGLTexture);
begin
  with Texture do
  begin
    WriteByteBlock(uv_set);
    WriteString(name);
    if Length(name) > 0 then
    begin
      WriteByteBlock(pixel_format);
      WriteByteBlock(min_mag_type);
      WriteByteBlock(wrap_type);
      WriteString(path);
      WriteColor(border_color);
      WriteDword(hash);
    end;
  end;
end;

procedure TMaterialObj.Read;
var
  i: integer;
  tgl,tgl2 :TGLTexture;
begin
  mat_id := ID + BSP.IndexOffset;
  Flags := ReadDword; // dw_4
  m_unk := ReadDword; // dw_156
  AdditiveLightingModel := ReadByteBlock; // b_8
  Diffuse := ReadColor;
  Specular := ReadColor;
  m_Power := ReadFloatBlock;
  ShadeMode := ReadByteBlock;
  Blend := ReadByteBlock;
  Blend_dfactor := ReadByteBlock;
  Blend_sfactor := ReadByteBlock;
  AlphaTest := ReadByteBlock;
  AlphaTestCompMode := ReadByteBlock;
  AlphaRefValue := ReadFloatBlock;
  DepthBufferWrite := ReadByteBlock;
  DepthBufferCompMode := ReadByteBlock;
  materialHash := ReadDword;
  if (Version = 1698) then
  begin
    Owner := ReadDword;
  end
  else
  begin
     Owner := 0;
  end;
  if (Version = 1698) then
  begin
    ColourBufferWrite := ReadSPDword;
  end
  else
  begin
    ColourBufferWrite:= 1;
  end;
  texture_num := 0;
  matrix_num := 0;
  gen_num := 0;
  if Version = 1676 then
  begin
      for i := 0 to 4 do
      begin
        Texture[i] := ReadGLTexture(BSP.Textures);
      end;
      for i := 0 to 4 do
      begin
        useMatrix[i] := 0;
        Gen[i] := 0;
      end;
  end
  else if (Version > 1692) then
  begin
    if (Version = 1696) then
    begin
      for i := 0 to 3 do
      begin
        Texture[i] := ReadGLTexture(BSP.Textures);
      end;
        ZeroMemory(@tgl, SizeOf(tgl));
        tgl.uv_set:= MaxInt;
        tgl.name:= nil;
        Texture[4]:= tgl;
      for i := 0 to 4 do
      begin
        useMatrix[i] := 0;
        Gen[i] := 0;
      end;
      ReadSPDword;
    end
    else if (Version = 1695) or (Version = 1693)  then
    begin
      for i := 0 to 2 do //only 3 textures
      begin
        Texture[i] := ReadGLTexture(BSP.Textures);
      end;
        ZeroMemory(@tgl2, SizeOf(tgl2));
        tgl2.uv_set:= MaxInt;
        tgl2.name:= nil;
        Texture[3]:= tgl2;
        ZeroMemory(@tgl, SizeOf(tgl));
        tgl.uv_set:= MaxInt;
        tgl.name:= nil;
        Texture[4]:= tgl;
      for i := 0 to 4 do
      begin
        useMatrix[i] := 0;
        Gen[i] := 0;
      end;
    end
    else
    begin
      for i := 0 to 4 do
      begin
        // if OutSize then exit;
        Texture[i] := ReadGLTexture(BSP.Textures);
      end;
      //      if texture_num>2 then
      //        texture_num:=texture_num;
      for i := 0 to 4 do
      begin
        useMatrix[i] := ReadSPDword;
        if useMatrix[i] > 0 then
        begin
          Inc(matrix_num);
          Matrix[i] := ReadMxBlock;
        end;
      end;
      for i := 0 to 4 do
      begin
        Gen[i] := ReadSPDword;
        if Gen[i] > 0 then
          inc(gen_num);
      end;
    end;
  end
  else
  begin // EntType = 1692
    EnvMapType := ReadSPDword;
    PlanarSheerEnvMapDistance := ReadFloat;
  end;
  if (Version > 1697) then
  begin
    EnvMapType := ReadSPDword;
    PlanarSheerEnvMapDistance := ReadFloat;
  end
  else
  begin
    EnvMapType := 0;
    PlanarSheerEnvMapDistance := 0.0;
  end;
end;

procedure TMaterialObj.Write;
var
  i: integer;
begin
  inherited;
  WriteDword(Flags); // dw_4
  WriteDword(m_unk); // dw_156
  WriteByteBlock(AdditiveLightingModel); // b_8
  WriteColor(Diffuse);
  WriteColor(Specular);
  WriteFloatBlock(m_Power);
  WriteByteBlock(ShadeMode);
  WriteByteBlock(Blend);
  WriteByteBlock(Blend_dfactor);
  WriteByteBlock(Blend_sfactor);
  WriteByteBlock(AlphaTest);
  WriteByteBlock(AlphaTestCompMode);
  WriteFloatBlock(AlphaRefValue);
  WriteByteBlock(DepthBufferWrite);
  WriteByteBlock(DepthBufferCompMode);
  WriteDword(materialHash);
  WriteDword(Owner);
  WriteSPDword(ColourBufferWrite);

  if Version > 1692 then
  begin
    for i := 0 to 4 do
    begin
      WriteGLTexture(Texture[i]);
    end;
    for i := 0 to 4 do
    begin
      WriteSPDword(useMatrix[i]);
      if useMatrix[i] > 0 then
      begin
        WriteMxBlock(Matrix[i]);
      end;
    end;
    for i := 0 to 4 do
    begin
      WriteSPDword(Gen[i]);
    end;
  end
  else
  begin // EntType = 1692
    WriteSPDword(EnvMapType);
    WriteSPDword(EnvMapType);
  end;
  WriteSPDword(EnvMapType);
  WriteFloat(PlanarSheerEnvMapDistance);
  CalcSize;
end;

procedure TMaterialObj.AddFields;
var
  Node, Node1, Node2: PVirtualNode;
  i: Integer;
  Data: PPropertyData;
begin
  inherited;
  Node1 := AddTreeData(nil, 'Attributes', nil, BSPStruct);
  AddTreeData(Node1, 'Flags', @Flags, BSPMatFlags);
  AddTreeData(Node1, 'Additive Lighting Model', @AdditiveLightingModel, BSPBool);
  AddTreeData(Node1, 'Colour', @Diffuse, BSPColor);
  AddTreeData(Node1, 'Specular', @Specular, BSPColor);
  AddTreeData(Node1, 'Power', @m_Power, BSPFloat);
  AddTreeData(Node1, 'Shading Mode', @ShadeMode, BSPGLShade);
  AddTreeData(Node1, 'Blend', @Blend, BSPBool);
  Node2 := AddTreeData(Node1, 'Blend Modes', nil, BSPStruct);
  AddTreeData(Node2, 'Source Mode', @Blend_dfactor, BSPGLFactor);
  AddTreeData(Node2, 'Destination Mode', @Blend_sfactor, BSPGLFactor);
  AddTreeData(Node1, 'Alpha Test', @AlphaTest, BSPBool);
  Node2 := AddTreeData(Node1, 'Alpha Test Mode', nil, BSPStruct);
  AddTreeData(Node2, 'Comparison Function', @AlphaTestCompMode, BSPGLParam);
  AddTreeData(Node2, 'Reference', @AlphaRefValue, BSPFloat);
  AddTreeData(Node1, 'Depth Buffer Write', @DepthBufferWrite, BSPBool);
  AddTreeData(Node1, 'Depth Buffer Comparison Mode', @DepthBufferCompMode, BSPGLParam);
  AddTreeData(nil, 'Name Hash', @m_unk, BSPHash);
  AddTreeData(nil, 'Material Hash', @materialHash, BSPHash);
  AddTreeData(nil, 'Owner', @Owner, BSPUint);
  AddTreeData(nil, 'Colour Buffer Write', @ColourBufferWrite, BSPBool);
  Node1 := AddTreeData(nil, format('Textures', [i]), @texture_num, BSPArray);
  Data := DataTree.GetNodeData(Node1);
  Data^.ValueIndex := 16;
  for i := 0 to 4 do
    if Length(Texture[i].name) > 0 then
    begin
      Node := AddTreeData(Node1, GetTextureType(i), nil, BSPStruct, '(' + Texture[i].name + ')');
      Data := DataTree.GetNodeData(Node);
      //DataTree.ValidateNode(Result, False);
      Data^.ValueIndex := 16;
      AddTreeData(Node, 'UV Set', @Texture[i].uv_set, BSPInt);
      AddTreeData(Node, 'Name', @Texture[i].name, BSPString);
      AddTreeData(Node, 'Format', @Texture[i].pixel_format, BSPTextureFormat);
      AddTreeData(Node, 'Filter Mode', @Texture[i].min_mag_type, BSPGLMigMag);
      AddTreeData(Node, 'Address Mode', @Texture[i].wrap_type, BSPGLRepeat);
      AddTreeData(Node, 'Mask Name', @Texture[i].path, BSPString);
      AddTreeData(Node, 'Border Colour', @Texture[i].border_color, BSPColor);
      AddTreeData(Node, 'Hash', @Texture[i].hash, BSPRefHash);
    end
    else
    begin
      Node := AddTreeData(Node1, GetTextureType(i), nil, BSPStruct, 'None');
      AddTreeData(Node, 'Name', @Texture[i].name, BSPString);
    end;

  Node1 := AddTreeData(nil, 'Texture Matrices', @matrix_num, BSPArray);
  Data := DataTree.GetNodeData(Node1);
  Data^.ValueIndex := 17;
  for i := 0 to 4 do
  begin
    if useMatrix[i] > 0 then
      AddMatrixData(Node2, GetTextureType(i) + 'Matrix', format('Transform[%d]',[i]), Matrix[i])
    else
      AddTreeData(Node1, GetTextureType(i) + 'Matrix', @useMatrix[i], BSPMatrix,'None');
  end;
  Node2 := AddTreeData(nil, format('Texture Generates', [i]), @gen_num, BSPArray);
  for i := 0 to 4 do
    AddTreeData(Node2, GetTextureType(i) + 'Gen', @Gen[i], BSPDword);
  AddTreeData(nil, format('Environment Map Type', [i]), @EnvMapType, BSPEnvMapType);
  AddTreeData(nil, format('Planar Sheer Env Map Distance', [i]), @PlanarSheerEnvMapDistance, BSPFloat);
end;

constructor TMaterialObj.Create(Chunk: TChunk);
begin
  inherited;
end;

destructor TMaterialObj.Destroy;
begin
  if T1 > 0 then
    glDeleteTextures(1, @T1);
  if T2 > 0 then
    glDeleteTextures(1, @T2);
  if T3 > 0 then
    glDeleteTextures(1, @T3);
  inherited;
end;

function Color4d_byte(color: TUColor): color4d;
begin
  result[0] := (color[0] and $FF) / 255.0;
  result[1] := (color[1] and $FF) / 255.0;
  result[2] := (color[2] and $FF) / 255.0;
  result[3] := (color[3] and $FF) / 255.0;
end;

procedure TMaterialObj.SetMaterial(mesh: Tmesh);
begin
  //material.Texture[0].name
  mesh.Attribute.Material.use := true;
  mesh.Attribute.Material.Dif := Color4d_byte(Diffuse);
  mesh.Attribute.Material.Spe := Color4d_byte(Specular);
  mesh.Attribute.Material.Shi := m_Power;
  mesh.Attribute.Polygon := ShadeMode;
  mesh.Attribute.ZBuffer := Boolean(DepthBufferWrite);
  mesh.Attribute.ZBufferFuncVal := DepthBufferCompMode - 1;
  mesh.Attribute.AlphaTest := Boolean(AlphaTest);
  mesh.Attribute.AlphaFunc := AlphaTestCompMode - 1;
  mesh.Attribute.AlphaFuncVal := AlphaRefValue;
  mesh.Attribute.Blend := Boolean(Blend);
  mesh.Attribute.BlendVal1 := Blend_dfactor;
  mesh.Attribute.BlendVal2 := Blend_sfactor;
  mesh.GetTextureGL(Self);
end;

function TMaterialObj.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  k: integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 18;
  Data^.Hash := Format('[%.*x]', [8, materialHash]);
  for k := 0 to 4 do
    if Texture[k].Texture <> nil then
      Texture[k].Texture.AddClassNode(TreeView, Result);
end;

procedure TMaterialObj.AddMaterial(effect: TXmlNode; tDict: TDictionary);
var
  blinn: TXmlNode;
  isAlpha: boolean;
  tIndex: integer;

  procedure SetColor(var color: TUColor; colorNode: TXmlNode);
  var
    sList: TStringList;
    i: integer;
  begin
    if colorNode <> nil then
    begin
      sList := TStringList.Create;
      sList.Delimiter := ' ';
      sList.DelimitedText := colorNode.Value;
      for i := 0 to 3 do
        color[i] := floor(StrToFloat(sList[i]) * 255.0);
      sList.Free;
    end
    else
    begin
      for i := 0 to 3 do
        color[i] := 255;
    end;
  end;

  function SetGLTexture(effect: TXmlNode): TGLTexture;
  var
    surface, init_from: TXmlNode;
    tName: string;
    texture: TTextureOpenGL;
  begin
    ZeroMemory(@Result, SizeOf(Result));
    with Result do
    begin
      uv_set := 0;
      surface :=
        effect.NodeByName('profile_COMMON').Elements[0].NodeByName('surface');
      if surface <> nil then
      begin
        init_from :=
          effect.NodeByName('profile_COMMON').Elements[0].NodeByName('surface').NodeByName('init_from');
        tName := init_from.Value;
        tName := Copy(tName, 1, Length(tName) - 4);
        Texture := BSP.Textures.FindTextureOfHash(tDict.Value[tName]);
        if Texture <> nil then
        begin
          name := texture.name;
          Inc(texture_num);
          pixel_format := texture.pixel_format;
          min_mag_type := texture.min_mag_type;
          wrap_type := texture.wrap_type;
          border_color := texture.border_color;
          hash := texture.hash;
        end;
      end;
    end;
  end;

begin
  blinn :=
    effect.NodeByName('profile_COMMON').NodeByName('technique').Elements[0];
  //blinn,Phong... etc
  isAlpha := blinn.NodeByName('transparent').NodeByName('texture') <> nil;
  //if exist then it's texture with alpha channel
  if isAlpha then
  begin
    Flags := 10;
    AlphaTest := 1;
  end
  else
  begin
    Flags := 0;
    AlphaTest := 0;
  end;
  m_unk := 0;
  AdditiveLightingModel := 0;
  SetColor(Diffuse, blinn.NodeByName('diffuse').NodeByName('color'));
  SetColor(Specular, blinn.NodeByName('specular').NodeByName('color'));
  m_power := blinn.NodeByName('shininess').NodeByName('float').ValueAsFloat;
  ShadeMode := 2; //GL_SMOOTH
  Blend := 0; //GL_DISABLED
  Blend_dfactor := 5; //GL_SRC_ALPHA
  Blend_sfactor := 6; //GL_ONE_MINUS_SRC_ALPHA
  AlphaTestCompMode := 5; //GL_GREATER
  AlphaRefValue := 0.5;
  DepthBufferWrite := 1; //GL_ENABLE
  DepthBufferCompMode := 4; //GL_LEQUAL
  Owner := 0;
  ColourBufferWrite := 1; //GL_ENABLE
  Texture[0] := SetGLTexture(effect);
  EnvMapType := 0;
  PlanarSheerEnvMapDistance := 0.0;
  MaterialHash := GetMaterialHash;
end;

procedure TMaterialObj.SearchForMaterialObj(Sender: TBaseVirtualTree; Node:
  PVirtualNode;
  Obj: Pointer; var Abort: Boolean);
var
  NodeData: PClassData;
  Chunk: TChunk;
begin
  NodeData := Sender.GetNodeData(Node);
  if TObject(NodeData^.Obj) is TChunk then
  begin
    Chunk := TChunk(NodeData^.Obj);
    if (Chunk = self) then
    begin
      NodeData^.Hash := Format('[%.*x]', [8, materialHash]);
      NodeData^.Changed := true;
    end;
  end;
end;

procedure TMaterialObj.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
var
  selNode, parentNode: PVirtualNode;
  parentData: PPropertyData;
begin
  // TODO check texture names and update TexturesGL blocks
  if PData.DName <> 'Name Hash' then
  begin
    if (PData.DName = 'Position') or (PData.DName = 'Rotation') or (PData.DName = 'Scale') then
    begin
      selNode := CustomTree.FocusedNode;
      parentNode := selNode.Parent;
      parentData := CustomTree.GetNodeData(parentNode);
      if parentData.DName = 'Transform[0]' then
        Matrix[0].m := GetMatrix(Matrix[0].t[0], Matrix[0].t[1], Matrix[0].t[2])
      else if parentData.DName = 'Transform[1]' then
        Matrix[1].m := GetMatrix(Matrix[1].t[0], Matrix[1].t[1], Matrix[1].t[2])
      else if parentData.DName = 'Transform[2]' then
        Matrix[2].m := GetMatrix(Matrix[2].t[0], Matrix[2].t[1], Matrix[2].t[2])
      else if parentData.DName = 'Transform[3]' then
        Matrix[3].m := GetMatrix(Matrix[3].t[0], Matrix[3].t[1], Matrix[3].t[2])
      else if parentData.DName = 'Transform[4]' then
        Matrix[4].m := GetMatrix(Matrix[4].t[0], Matrix[4].t[1], Matrix[4].t[2])
    end;
    SetNewMaterialHash(CustomTree);
  end;
end;

procedure TMaterialObj.GenTextures;
var
  IFormat, IComponents, IWrap: Integer;
  index: integer;
begin
  for index := 0 to 2 do
  begin
    if Texture[index].Texture <> nil then
    begin

      with Texture[index].Texture do
      begin
        case index of
          0:
            begin
              T1 := TEXTUREBASE + mat_id;
              glBindTexture(GL_TEXTURE_2D, T1);
            end;
          1:
            begin
              T2 := TEXTURESECOND + mat_id;
              glBindTexture(GL_TEXTURE_2D, T2);
            end;
          2:
            begin
              T3 := TEXTURELUMP + mat_id;
              glBindTexture(GL_TEXTURE_2D, T3);
            end;
        end;
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,
          GetMagFilter(Texture[index].min_mag_type));
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
          GetMinFilter(Texture[index].min_mag_type));
        IFormat := GetPixFormat(Texture[index].pixel_format);
        IWrap := GetRepeat(Texture[index].wrap_type);
        IComponents := 4;
        if image.palette <> nil then
        begin
          glEnable(GL_COLOR_TABLE);
          // glColorTable(GL_COLOR_TABLE, GL_RGBA, 256, GL_RGBA, GL_UNSIGNED_BYTE, image.palette);
          IFormat := GL_COLOR_INDEX;
          IComponents := 1;
        end;
        //   border_color:TUColor;
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, IWrap);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, IWrap);

        glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP, 1);
        glTexImage2D(GL_TEXTURE_2D, 0, IComponents, width, height, 0, IFormat,
          GL_UNSIGNED_BYTE, image.bitmap);
      end;
    end;
  end;
end;

function TMaterialObj.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TMaterialObj;
  i, len: integer;
  nTextureOpengl, oTOGL: TGLTexture;
  fTexture: TTextureOpenGL;
begin
  Chunk := TMaterialObj(inherited CopyChunk(nBSP));
  if nBSP <> nil then
  begin
    Chunk.mat_id := mat_id;
    Chunk.flags := flags;
    Chunk.m_unk := m_unk;
    Chunk.AdditiveLightingModel := AdditiveLightingModel;
    Chunk.Diffuse := Diffuse;
    Chunk.Specular := Specular;
    Chunk.m_Power := m_Power;
    Chunk.ShadeMode := ShadeMode;
    Chunk.Blend := Blend;
    Chunk.Blend_dfactor := Blend_dfactor;
    Chunk.Blend_sfactor := Blend_sfactor;
    Chunk.AlphaTest := AlphaTest;
    Chunk.AlphaTestCompMode := AlphaTestCompMode;
    Chunk.AlphaRefValue := AlphaRefValue;
    Chunk.DepthBufferWrite := DepthBufferWrite;
    Chunk.DepthBufferCompMode := DepthBufferCompMode;
    Chunk.materialHash := materialHash;
    Chunk.Owner := Owner;
    Chunk.ColourBufferWrite := ColourBufferWrite;
    Chunk.texture_num := texture_num;
    Chunk.matrix_num := matrix_num;
    Chunk.gen_num := gen_num;
    for i := 0 to 4 do
    begin
      //Copy TTextureOpengl
      oTOGL := Texture[i];
      if length(oTOGL.name) > 0 then
      begin
        nTextureOpengl.uv_set := oTOGL.uv_set;
        nTextureOpengl.name := oTOGL.name;
        nTextureOpengl.pixel_format := oTOGL.pixel_format;
        nTextureOpengl.min_mag_type := oTOGL.min_mag_type;
        nTextureOpengl.wrap_type := oTOGL.wrap_type;
        nTextureOpengl.path := oTOGL.path;
        nTextureOpengl.border_color := oTOGL.border_color;
        nTextureOpengl.hash := oTOGL.hash;
        if oTOGL.Texture <> nil then
        begin
          fTexture := nBSP.Textures.FindTextureOfHash(oTOGL.hash);
          if fTexture = nil then
          begin
            nTextureOpengl.Texture :=
              TTextureOpenGL(oTOGL.Texture.CopyChunk(nBSP));
            //Add texture to dictionary
            len := nBSP.Textures.Num;
            SetLength(nBSP.Textures.Textures, len + 1);
            inc(nBSP.Textures.Num);
            nBSP.Textures.Textures[len] := nTextureOpengl.Texture; //
          end
          else
            nTextureOpengl.Texture := fTexture;
        end;
        Chunk.Texture[i] := nTextureOpengl;
      end;
      { else
         Chunk.Texture[i].uv_set := $FFFFFFFF;      }
    end;

    if Chunk.T1 > 0 then
      glDeleteTextures(1, @Chunk.T1);
    if Chunk.T2 > 0 then
      glDeleteTextures(1, @Chunk.T2);
    if Chunk.T3 > 0 then
      glDeleteTextures(1, @Chunk.T3);
    Chunk.GenTextures;

    for i := 0 to 4 do
    begin
      Chunk.useMatrix[i] := useMatrix[i];
    end;
    for i := 0 to 4 do
    begin
      Chunk.Gen[i] := Gen[i];
    end;
    Chunk.EnvMapType := EnvMapType;
    Chunk.PlanarSheerEnvMapDistance := PlanarSheerEnvMapDistance;
    //Add material to materials
    len := nBSP.Materials.Num;
    SetLength(nBSP.Materials.Materials, len + 1);
    inc(nBSP.Materials.Num);
    nBSP.Materials.Materials[len] := Chunk;
  end;
  Result := Chunk;
end;

function TMaterialObj.GetMaterialHash: Cardinal;
var
  tempSingle: single;
  i: Cardinal;
  data: array[0..37] of Cardinal;
begin
  data[0] := Flags;
  data[1] := AdditiveLightingModel;
  data[2] := PCardinal(@Diffuse[0])^;
  data[3] := PCardinal(@Specular[0])^;
  tempSingle := m_Power;
  data[4] := PCardinal(@tempSingle)^;
  data[5] := ShadeMode;
  data[6] := DepthBufferWrite;
  data[7] := DepthBufferCompMode;
  data[8] := Blend;
  data[9] := Blend_dfactor;
  data[10] := Blend_sfactor;
  data[11] := AlphaTest;
  data[12] := AlphaTestCompMode;
  tempSingle := AlphaRefValue;
  data[13] := PCardinal(@tempSingle)^;
  data[14] := Owner;
  data[15] := ColourBufferWrite;
  for i := 0 to High(useMatrix) do
  begin
    data[16 + i] := useMatrix[i];
  end;
  for i := 0 to High(Gen) do
  begin
    data[21 + i] := Gen[i];
  end;
  for i := 0 to High(Texture) do
  begin
    data[26 + i] := Texture[i].uv_set;
  end;
  for i := 0 to High(Texture) do
  begin
    data[31 + i] := Texture[i].hash;
  end;
  data[36] := EnvMapType;
  tempSingle := PlanarSheerEnvMapDistance;
  data[37] := PCardinal(@tempSingle)^;
  Result := MakeHash(@data, 152);
end;

function TMaterialObj.GetTextureType(id: Cardinal): string;
begin
  case id of
    0: Result := 'BaseTexture';
    1: Result := 'LayerTexture';
    2: Result := 'LightmapTexture';
    3: Result := 'EnvmapTexture';
    4: Result := 'PostmapTexture';
  end;
end;

procedure TMaterialObj.SetNewMaterialHash(CustomTree: TCustomVirtualStringTree);
var
  oMaterialHash, nMaterialHash, i, j: Cardinal;
  teWorld: TWorld;
  teModelGroup: TSpMesh;
  teEntities: TEntities;
  teEntity: TEntity;

  procedure DoEveryBoneReplaceMaterialHash(var bone: TSpFrame);
  var
    i, j, len: Cardinal;
    tempAtomicMesh: TAtomic;
    tempModelGroup: TSpMesh;
    foundAtomic: boolean;
  begin
    foundAtomic := false;
    len := Length(bone.Childs);
    if len > 0 then
      for i := 0 to len - 1 do
      begin
        if foundAtomic then
          Break;
        if bone.Childs[i] is TAtomic then
        begin
          foundAtomic := true;
          tempAtomicMesh := TAtomic(bone.Childs[i]);
          if tempAtomicMesh.ModelGroup <> nil then
          begin
            tempModelGroup := tempAtomicMesh.ModelGroup;
            if tempModelGroup.models_num > 0 then
              for j := 0 to tempModelGroup.models_num - 1 do
              begin
                if tempModelGroup.models[j].materialHash = oMaterialHash then
                begin
                  tempModelGroup.models[j].materialHash := nMaterialHash;
                  SetMaterial(tempModelGroup.models[j].mesh);
                end;
              end;
          end;
        end;
      end;
    len := Length(bone.Bones);
    if len > 0 then
    begin
      for i := 0 to len - 1 do
        DoEveryBoneReplaceMaterialHash(TSpFrame(bone.Bones[i]));
    end;
  end;
begin
  //Update Hash
  oMaterialHash := materialHash;
  materialHash := GetMaterialHash;
  nMaterialHash := materialHash;
  teWorld := BSP.World;
  if teWorld <> nil then
  begin
    if teWorld.hasMesh then
    begin
      teModelGroup := teWorld.ModelGroup;
      if teModelGroup <> nil then
        if teModelGroup.models_num > 0 then
        begin
          for i := 0 to teModelGroup.models_num - 1 do
          begin
            if teModelGroup.models[i].materialHash = oMaterialHash then
            begin
              teModelGroup.models[i].materialHash := nMaterialHash;
              SetMaterial(teModelGroup.models[i].mesh);
            end;
          end;
        end;
    end;
  end;
  teEntities := BSP.Entities;
  if teEntities <> nil then
    if Length(teEntities.Entities) > 0 then
      for i := 0 to High(teEntities.Entities) do
      begin
        teEntity := teEntities.Entities[i];
        if teEntity.Clump <> nil then
          if teEntity.Clump.Root <> nil then
          begin
            DoEveryBoneReplaceMaterialHash(teEntity.Clump.Root);
          end;
      end;
  CustomTree.IterateSubtree(nil, SearchForMaterialObj, nil);
end;

procedure TMaterialObj.SetNewMaterialHash();
var
  oMaterialHash, nMaterialHash, i, j: Cardinal;
  teWorld: TWorld;
  teModelGroup: TSpMesh;
  teEntities: TEntities;
  teEntity: TEntity;

  procedure DoEveryBoneReplaceMaterialHash(var bone: TSpFrame);
  var
    i, j, len: Cardinal;
    tempAtomicMesh: TAtomic;
    tempModelGroup: TSpMesh;
    foundAtomic: boolean;
  begin
    foundAtomic := false;
    len := Length(bone.Childs);
    if len > 0 then
      for i := 0 to len - 1 do
      begin
        if foundAtomic then
          Break;
        if bone.Childs[i] is TAtomic then
        begin
          foundAtomic := true;
          tempAtomicMesh := TAtomic(bone.Childs[i]);
          if tempAtomicMesh.ModelGroup <> nil then
          begin
            tempModelGroup := tempAtomicMesh.ModelGroup;
            if tempModelGroup.models_num > 0 then
              for j := 0 to tempModelGroup.models_num - 1 do
              begin
                if tempModelGroup.models[j].materialHash = oMaterialHash then
                begin
                  tempModelGroup.models[j].materialHash := nMaterialHash;
                  SetMaterial(tempModelGroup.models[j].mesh);
                end;
              end;
          end;
        end;
      end;
    len := Length(bone.Bones);
    if len > 0 then
    begin
      for i := 0 to len - 1 do
        DoEveryBoneReplaceMaterialHash(TSpFrame(bone.Bones[i]));
    end;
  end;
begin
  //Update Hash
  oMaterialHash := materialHash;
  materialHash := GetMaterialHash;
  nMaterialHash := materialHash;
  teWorld := BSP.World;
  if teWorld <> nil then
  begin
    if teWorld.hasMesh then
    begin
      teModelGroup := teWorld.ModelGroup;
      if teModelGroup <> nil then
        if teModelGroup.models_num > 0 then
        begin
          for i := 0 to teModelGroup.models_num - 1 do
          begin
            if teModelGroup.models[i].materialHash = oMaterialHash then
            begin
              teModelGroup.models[i].materialHash := nMaterialHash;
              SetMaterial(teModelGroup.models[i].mesh);
            end;
          end;
        end;
    end;
  end;
  teEntities := BSP.Entities;
  if teEntities <> nil then
    if Length(teEntities.Entities) > 0 then
      for i := 0 to High(teEntities.Entities) do
      begin
        teEntity := teEntities.Entities[i];
        if teEntity.Clump <> nil then
          if teEntity.Clump.Root <> nil then
          begin
            DoEveryBoneReplaceMaterialHash(teEntity.Clump.Root);
          end;
      end;
end;

{ TChunk }

procedure TChunk.MakeDefault(BSPFile: TBSPfile);
begin
  BSP := BSPFile;
  ID := GlobalID;
  Inc(BSP.Idx);
  Inc(GlobalID);
end;

procedure TChunk.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  DataTree := CustomTree;
  DataTree.Clear;
end;

procedure TChunk.AddMatrixData(ANode: PVirtualNode; Name, Name2: string; const
  Matrix:
  TEntMatrix);
var
  Node: PVirtualNode;
  Data: PPropertyData;
begin
  //Tranformation Matrix
  Node := AddTreeData(ANode, Name2, @Matrix.t[0][0], BSPTransform);
  Data := DataTree.GetNodeData(Node);
  Data^.ValueIndex := 17;
  AddTreeData(Node, 'Position', @Matrix.t[0][0], BSPVect4);
  AddTreeData(Node, 'Rotation', @Matrix.t[1][0], BSPVect4);
  AddTreeData(Node, 'Scale', @Matrix.t[2][0], BSPVect4);

  //Matrix
  Node := AddTreeData(ANode, Name, @Matrix.m[4][1], BSPMatrix);
  Data := DataTree.GetNodeData(Node);
  Data^.ValueIndex := 17;
  AddTreeData(Node, '[1]', @Matrix.m[1][1], BSPVect4);
  AddTreeData(Node, '[2]', @Matrix.m[2][1], BSPVect4);
  AddTreeData(Node, '[3]', @Matrix.m[3][1], BSPVect4);
  AddTreeData(Node, '[4]', @Matrix.m[4][1], BSPVect4);
  AddTreeData(Node, 'Flags', @Matrix.mask, BSPMatrixFlag);
end;

procedure TChunk.AddBoundData(ANode: PVirtualNode; const bound: TBBox ; bname: string = 'Bounding Box');
var
  Node: PVirtualNode;
begin
  Node := AddTreeData(ANode, bname, nil, BSPStruct);
  AddTreeData(Node, 'Supremum', @bound.min, BSPVect);
  AddTreeData(Node, 'Infimum', @bound.max, BSPVect);
end;

function ToCosDeg(b: byte): Single;
var
  rad: single;
begin
  rad := Cos(b * 0.012271847); //pi/256
  if b = 0 then
    rad := 1.0;
  if b = 128 then
    rad := 0.0;
  if b = 255 then
    rad := -1.0;

  result := rad; //*180/pi;
end;

function ToDegFlag(b: byte): string;
var
  axis: string;
  axs, block: byte;
begin
  axs := b and 3;
  if axs = 0 then
    axis := 'XYZ'
  else if axs = 1 then
    axis := 'X'
  else if axs = 2 then
    axis := 'Y'
  else
    axis := 'Z';

  if (b and $10) > 0 then
    block := 3
  else if (b and $40) > 0 then
    block := 1
  else if (b and $20) > 0 then
    block := 2
  else
    block := 0;
  result := Format('b:%d %s', [block, axis]);
end;

procedure TChunk.ValueIndex(ANode: PVirtualNode; VIndex: integer);
var
  Data: PPropertyData;
begin
  Data := DataTree.GetNodeData(ANode);
  Data^.ValueIndex := VIndex;
end;

function TChunk.AddTreeData(ANode: PVirtualNode; Name: string;
  p: Pointer; Btype: BSPDataTypes; VReplace: string): PVirtualNode;
var
  Data: PPropertyData;
  s: string;
  c: Cardinal;

begin
  Result := DataTree.AddChild(ANode);
  Data := DataTree.GetNodeData(Result);
  DataTree.ValidateNode(Result, False);
  Data^.DName := Name;
  s := '';
  Data^.PValue := p;
  c := Dword(p);
  case Btype of
    BSPArray,
      BSPInt: s := Format('%d', [Integer(p^)]);
    BSPBool, BSPChBool: s := BoolToStr(Boolean(p^), true);
    BSPDword, BSPHash, BSPRefHash: s := Format('%.*x', [8, Dword(p^)]);
    BSPWord: s := Format('%.*x', [4, Word(p^)]);
    BSPSint: s := Format('%.d', [SmallInt(p^)]);
    BSPSUint16: s := Format('%.d', [Word(p^)]);
    BSPUVWord: s := Format('%.2f', [Word(p^) / 256]);
    BSPUint: s := Format('%d', [Cardinal(p^)]);
    BSPColor:
      begin
        s := Format('<r:%d g:%d b:%d a:%d>',
          [byte(Pointer(c)^), byte(Pointer(c + 1)^), byte(Pointer(c + 2)^),
          byte(Pointer(c + 3)^)]);
        Data^.ValueIndex := 3;
      end;
    BSPGroup:
      begin
        if Integer(p^) < 1 then
          s := Format('%.d*', [Dword(p^) and $7FFFFFFF])
        else
          s := Format('%.d', [integer(p^)]);
      end;
    BSPFAngle:
      begin
        s := Format('[x:%.2f y:%.2f z:%.2f %s]',
          [ToCosDeg(byte(Pointer(c)^)), ToCosDeg(byte(Pointer(c + 1)^)),
          ToCosDeg(byte(Pointer(c + 2)^)), ToDegFlag(byte(Pointer(c + 3)^))]);
      end;
    BSPAngleBlock:
      begin
        s := Format('[x:%.2f y:%.2f z:%.2f w:%2f]',
          [ToCosDeg(byte(Pointer(c)^)), ToCosDeg(byte(Pointer(c + 1)^)),
          ToCosDeg(byte(Pointer(c + 2)^)), Single(Pointer(c + 4)^)]);
      end;
    BSPRVect:
      begin
        s := Format('<x:%.2f y:%.2f z:%.2f w:%.2f>',
          [SmallInt(Pointer(c)^) * 0.000030518509, SmallInt(Pointer(c + 2)^) *
          0.000030518509,
            SmallInt(Pointer(c + 4)^) * 0.000030518509, SmallInt(Pointer(c + 6)^)
            * 0.000030518509]);
      end;
    BSPVect:
      begin
        s := Format('<x:%.2f y:%.2f z:%.2f>',
          [Single(Pointer(c)^), Single(Pointer(c + 4)^), Single(Pointer(c +
            8)^)]);
      end;
    BSPUVCoord:
      begin
        s := Format('<u:%.2f v:%.2f>',
          [Single(Pointer(c)^), Single(Pointer(c + 4)^)]);
      end;
    BSPFace:
      begin
        s := Format('[%d %d %d]',
          [Word(Pointer(c)^), Word(Pointer(c + 2)^), Word(Pointer(c + 4)^)]);
      end;
    BSPBox:
      begin
        s := Format('[%d %d %d %d]',
          [Integer(Pointer(c)^), Integer(Pointer(c + 4)^), Integer(Pointer(c +
            8)^), Integer(Pointer(c + 12)^)]);
      end;
    BSPMatrix, BSPVect4, BSPTransform:
      begin
        s := Format('[%.2f %.2f %.2f %.2f]',
          [Single(Pointer(c)^), Single(Pointer(c + 4)^), Single(Pointer(c +
            8)^), Single(Pointer(c + 12)^)]);
      end;
    BSPVect4b:
      begin
        s := Format('<r:%d g:%d b:%d>', [byte(Pointer(c)^), byte(Pointer(c + 1)^), byte(Pointer(c + 2)^)]);
        Data^.ValueIndex := 3;
      end;
    BSPUInt64: s := Format('%.*x %.*x', [8, Dword(Pointer(c)^), 8, Dword(Pointer(c + 4)^)]);
    BSPFloat: s := Format('%f', [Single(p^)]);
    BSPByte: s := Format('%d', [Byte(p^)]);
    BSPGLFactor: s := BSPGLFactorS[Byte(p^)];
    BSPGLParam: s := BSPGLParamS[Byte(p^)];
    BSPGLBool: s := BSPGLBoolS[Byte(p^)];
    BSPGLMigMag: s := BSPGLMigMagS[Byte(p^)];
    BSPNullBoxType: s := BSPNullBoxTypeS[Byte(p^)];
    BSPGLRepeat: s := BSPGLRepeatS[Byte(p^)];
    BSPGLShade: s := BSPGLShadeS[Byte(p^)];
    BSPEntTypes: s := BSPEntTypesS[Byte(p^)];
    BSPKeyType: s := BSPEnumKeyTypeS[Byte(p^)];
    BSPWpTypes: s := BSPWpTypesS[Byte(p^)];
    BSPAtomic: s := BSPAtomicS[Byte(p^)];
    BSPSpawnType: s := BSPSpawnTypeS[Byte(p^)];
    BSPString:
      begin
        if p <> nil then
          s := PChar(p^);
        Data^.ValueIndex := 22;                                                                            
      end;
    BSPMesh: Data^.ValueIndex := 12;
    BSPVertexFlags: s := MeshSetStr(p);
    BSPMatFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPEnumMatS, BSPEnumMatF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPFloorFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPFloorFlagsS, BSPFloorFlagsF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPNullNodeFlags: s := SetEnumStr(Cardinal(p^), BSPNullNodeFlagsS) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPMatrixFlag: s := SetEnumStr(Cardinal(p^), BSPMatrixFlagS) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPMeshFlags: s := SetEnumStr(Cardinal(p^), BSPMeshFlagsS) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPTextureFormat: s := SetCustomFlagEnumStr(Cardinal(p^), BSPTextureFormatS, BSPTextureFormatF, 'DEFAULT') + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPResourceAccessData: s := SetCustomFlagEnumStr(Cardinal(p^), BSPResourceAccessDataS, BSPResourceAccessDataF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPReadFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPReadFlagsS, BSPReadFlagsF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPHintFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPHintFlagsS, BSPHintFlagsF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPConstantFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPConstantFlagsS, BSPConstantFlagsF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPMatBlockFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPMatBlockFlagsS, BSPMatBlockFlagsF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPRenderFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPRenderFlagsS, BSPRenderFlagsF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPWorldFlags: s := SetCustomFlagEnumStr(Cardinal(p^), BSPWorldFlagsS, BSPWorldFlagsF) + format(' [%s%x]', ['0x', Cardinal(p^)]);

    BSPClumpFlag: s := SetEnumStr64(c, BSPClumpFlagS) + format(' [%s%x]', ['0x', UInt64(p^)]);

    BSPEnvMapType: s := BSPEnvMapTypeS[Byte(p^)];

  end;
  if VReplace <> '' then
    s := VReplace;
  Data^.DValue := s;
  Data^.DType := BSPDataNames[Btype];
  Data^.DBType := Btype;
end;

constructor TChunk.Create(Chunk: TChunk);
begin
  if (Chunk <> nil) then
    Clone(Chunk);
end;

destructor TChunk.Destroy;
begin

  inherited;
end;

procedure TChunk.Clone(Chunk: TChunk);
begin
  point := Chunk.point;
  BSPoint := Chunk.BSPoint;
  IDType := Chunk.IDType;
  Size := Chunk.Size;
  Version := Chunk.Version;
  TypeName := Chunk.TypeName;
  ID := Chunk.ID;
  BSP := Chunk.BSP;
  Mem := Chunk.Mem;
  Chunk.Free;
end;

procedure TChunk.AddLoadingMore(ANode: PVirtualNode; N: Integer; Parr: Pointer;
  LoadItem: TLoadItemProcedure);
var
  Data: PPropertyData;
  Node: PVirtualNode;
  i, pnum: integer;
begin
  pnum := n;
  if n > MAX_LOAD then
    pnum := MAX_LOAD;
  for i := 0 to pnum - 1 do
    LoadItem(ANode, i, Parr);
  if n > MAX_LOAD then
  begin
    Node := DataTree.AddChild(ANode);
    Data := DataTree.GetNodeData(Node);
    Data^.DName := '...';
    Data^.DValue := format('+%d items', [N - MAX_LOAD]);
    Data^.DType := BSPDataNames[BSPLoad];
    Data^.DBType := BSPLoad;
    Data^.PFunc := LoadItem;
    Data^.PNum := N;
    Data^.PArr := Parr;
  end;
end;

procedure TChunk.CheckSize;
begin
  Readed := Size = (LongWord(BSPoint) - Longword(Point));
end;

procedure TChunk.CalcSize;
begin

  Size := (mem.Position - LongWord(BSPoint));
end;

function TChunk.AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode: PVirtualNode): PVirtualNode;
var
  s: string;
begin
  Result := TreeView.AddChild(TreeNode);
  Data := TreeView.GetNodeData(Result);
  Data^.Name := TypeName;
  Data^.ID := Format('[%.*d]', [4, ID]);
  Data^.Version := Format('[%.*d]', [4, Version]);
  s := '';
  if not Readed then
    s := '*';
  Data^.Value := Format('[%.*d]%s', [4, IDType, s]);
  Data^.Obj := self;
end;

function TChunk.GetMesh: TMesh;
begin
  Result := nil;
end;

procedure TChunk.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
begin
  Data^.Name := TypeName;
  Data^.Changed := true;
end;

procedure TChunk.CheckHide(ANode: PVirtualNode);
begin

end;

procedure TChunk.ShowMesh(Hide: Boolean);
begin

end;

procedure TChunk.DeleteChild(Chunk: TChunk);
begin

end;

function TChunk.CopyChunk(nBSP: TBSPfile): TChunk;
var
  Chunk: TChunk;
begin
  Chunk := ChunkTypeCreate(False);
  Chunk.point := point;
  Chunk.BSPoint := BSPoint;
  Chunk.IDType := IDType;
  Chunk.Size := Size;
  Chunk.Version := Version;
  Chunk.TypeName := TypeName;
  if nBSP = nil then
    Chunk.BSP := BSP
  else
    Chunk.BSP := nBSP;
  Chunk.Mem := Mem;
  Chunk.ID := GlobalID;
  Inc(GlobalID);

  Result := Chunk;
end;

procedure TChunk.InsertChild(Target, Chunk: TChunk);
begin

end;

function TChunk.ChunkTypeCreate(Clone: Boolean): TChunk;
var
  Chunk: TChunk;
begin
  if Clone then
    Chunk := Self
  else
    Chunk := nil;
  case (IDType) of
    1: Chunk := TProjection.Create(Chunk);
    5: Chunk := TMaterialObj.Create(Chunk);
    20: Chunk := TSpNullNode.Create;
    23: Chunk := TZoneObj.Create;
    1000: Chunk := TSpMesh.Create(Chunk);
    1001: Chunk := TSpFrame.Create(Chunk);
    1002: Chunk := TRenderBlock.Create(Chunk);
    1003: Chunk := TSpBSP.Create(Chunk);
    1004: Chunk := TAtomic.Create(Chunk);
    1005: Chunk := TClump.Create(Chunk);
    1006: Chunk := TCamera.Create(Chunk);
    1007: Chunk := TLight.Create(Chunk);
    1009: Chunk := TLevelObj.Create(Chunk);
    1010: Chunk := TMatDictionary.Create(Chunk);
    1011: Chunk := TSectorOctree.Create(Chunk);
    1012: Chunk := TWorld.Create(Chunk);
    1015: Chunk := TAnimKeyBlock.Create(Chunk);
    1017: Chunk := TAnimDictionary.Create(Chunk);
    1018: Chunk := TSpNgonList.Create(Chunk);
    1019: Chunk := TSpNgonBSP.Create(Chunk);
    1020: Chunk := TNullNodes.Create(Chunk);
    1021: Chunk := TWaypointMap.Create(Chunk);
    1023: Chunk := TZones.Create(Chunk);
    1024: Chunk := TSpline.Create(Chunk);
    1026: Chunk := TNullBox.Create(Chunk);
    1027: Chunk := TDictAnim.Create(Chunk);
    1029: Chunk := TLightSwitchController.Create(Chunk);
    20000: Chunk := TEntities.Create(Chunk);
    20001: Chunk := TEntity.Create(Chunk);
    20002: Chunk := TTextures.Create(Chunk);
  end;
  Result := Chunk;
end;

procedure TChunk.Read;
begin

end;

{ TSetObj }

procedure TSetObj.AddData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin

end;

procedure TSetObj.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1: PVirtualNode;
begin
  inherited;
  Node1 := AddTreeData(nil, Name, @Num, BSPArray);
  AddLoadingMore(Node1, Num, nil, AddData);
end;

constructor TSetObj.Create(Chunk: TChunk);
begin
  inherited;
end;

destructor TSetObj.Destroy;
begin

  inherited;
end;

procedure TSetObj.Write;
begin
  inherited;
  WriteByteBlock(Num);
  Size := 4;
end;

{ TMatDictionary }

procedure TMatDictionary.MakeDefault(BSPfile: TBSPfile);
begin
  inherited;
  IDType := C_MatDictionary;
  Version := 1698;

  BSP.Materials := self;
  Clear;
  Num := 0;
  Name := 'Num of Materials';
  SetLength(Materials, Num);
end;

constructor TMatDictionary.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Material Dictionary';
end;

destructor TMatDictionary.Destroy;
begin
  Clear;
  inherited;
end;

procedure TMatDictionary.Clear;
var
  i: integer;
begin
  if Length(Materials) > 0 then
  begin
    for i := 0 to Length(Materials) - 1 do
      if Materials[i] <> nil then
        FreeAndNil(Materials[i]);
  end;
  SetLength(Materials, 0);
end;

procedure TMatDictionary.Read;
var
  i: integer;
begin
  BSP.Materials := self;
  Clear;
  Num := ReadByteBlock;
  Name := 'Num of Materials';
  SetLength(Materials, Num);
  for i := 0 to Num - 1 do
  begin
    Materials[i] := TMaterialObj(BSP.ReadBSPChunk);
    Materials[i].TypeName := format('Mat_%d', [i]);
  end;
end;

procedure TMatDictionary.Write;
var
  i: integer;
begin
  inherited;
  for i := 0 to Num - 1 do
  begin
    if Materials[i].Version <> 1698 then
      Materials[i].SetNewMaterialHash();
    BSP.WriteBSPChunk(Materials[i]);
  end;
end;

function TMatDictionary.FindMaterialOfHash(Hash: Cardinal): TMaterialObj;
var
  i: integer;
begin
  Result := nil;
  if Length(Materials) > 0 then
  begin
    for i := 0 to Length(Materials) - 1 do
      if (Materials[i] <> nil) and (Materials[i].materialHash = Hash) then
      begin
        Result := Materials[i];
        Break;
      end;
  end;
end;

procedure TMatDictionary.AddData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2: PVirtualNode;
  Data: PPropertyData;
begin
  inherited;
  Node2 := AddTreeData(Node1, format('mat [%d]', [i]), nil, BSPChunk);
  Data := DataTree.GetNodeData(Node2);
  Data^.Obj := @Materials[i];
  Data^.ValueIndex := 18;
end;

function TMatDictionary.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: integer;

begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 18;
  for x := 0 to num - 1 do
  begin
    Materials[x].AddClassNode(TreeView, Result);
    Materials[x].GenTextures;
{$IFDEF PROGRESSBAR}But.TreeProgress.Position := 250 + Round(x / num * 350);
{$ENDIF}
  end;
end;

procedure TMatDictionary.DeleteChild(Chunk: TChunk);
var
  MatObj: TMaterialObj;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TMaterialObj then
  begin
    MatObj := TMaterialObj(Chunk);
    Dec(Num);
    MoveIndex := False;
    for i := 0 to num do
    begin
      if MoveIndex then
        Materials[i - 1] := Materials[i];
      if Materials[i] = MatObj then
        MoveIndex := true;
    end;
    SetLength(Materials, Num);
    MatObj.Destroy;
  end;
  // LINK with all SPMesh
end;

{ TTextures }

procedure TTextures.MakeDefault(BSPfile: TBSPFile);
begin
  inherited;
  IDType := C_Textures;
  Version := 1698;

  BSP.Textures := self;
  Clear;
  Num := 0;
  Name := 'Num of Textures';
  SetLength(Textures, Num);
end;

function TTextures.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 16;
  for x := 0 to num - 1 do
  begin
    Textures[x].AddClassNode(TreeView, Result);
    //     But.TreeProgress.Position:=200+Round(x/num*200);
  end;
end;

procedure TTextures.AddData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
var
  Node2: PVirtualNode;
  Data: PPropertyData;
begin
  inherited;
  Node2 := AddTreeData(Node1, format('Texture [%d]', [i]), nil, BSPChunk,
    Textures[i].name);
  Data := DataTree.GetNodeData(Node2);
  Data^.Obj := @Textures[i];
  Data^.ValueIndex := 3;
end;

procedure TTextures.Clear;
var
  i: integer;
begin
  if Length(Textures) > 0 then
  begin
    for i := 0 to Length(Textures) - 1 do
      FreeAndNil(Textures[i]);
  end;
  SetLength(Textures, 0);
end;

constructor TTextures.Create(Chunk: TChunk);
begin
  inherited Create(Chunk);
  TypeName := 'Texture Dictionary';
end;

procedure TTextures.DeleteChild(Chunk: TChunk);
var
  Tex: TTextureOpenGL;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TTextureOpenGL then
  begin
    Tex := TTextureOpenGL(Chunk);
    Dec(Num);
    MoveIndex := False;
    for i := 0 to num do
    begin
      if MoveIndex then
        Textures[i - 1] := Textures[i];
      if Textures[i] = Tex then
        MoveIndex := true;
    end;
    SetLength(Textures, Num);
    Tex.Destroy;
  end;
  // LINK with all MaterialObj
end;

destructor TTextures.Destroy;
begin
  Clear;
  inherited;
end;

function TTextures.AreDuplicates(Texture: TTextureOpenGL): Boolean;
var
  i: integer;
begin
  Result := false;
  if Length(Textures) > 0 then
  begin
    for i := 0 to Length(Textures) - 1 do
      if (Textures[i] <> nil) and (Textures[i].hash = Texture.hash) and
        (Textures[i].name = Texture.name) then
      begin
        Result := true;
        Break;
      end;
  end;
end;

function TTextures.FindTextureOfName(name: string): TTextureOpenGL;
var
  i: integer;
begin
  Result := nil;
  if Length(Textures) > 0 then
  begin
    for i := 0 to Length(Textures) - 1 do
      if (Textures[i] <> nil) and (Textures[i].name = name) then
      begin
        Result := Textures[i];
        Break;
      end;
  end;
end;

function TTextures.FindTextureOfHash(Hash: Cardinal): TTextureOpenGL;
var
  i: integer;
begin
  Result := nil;
  if Length(Textures) > 0 then
  begin
    for i := 0 to Length(Textures) - 1 do
      if (Textures[i] <> nil) and (Textures[i].hash = Hash) then
      begin
        Result := Textures[i];
        Break;
      end;
  end;
end;

procedure TTextures.Read;
var
  texti: integer;
  Texture: TTextureOpenGL;
begin
  BSP.Textures := self;
  Clear;
  Num := ReadByteBlock;
  Name := 'Num of Textures';
  SetLength(Textures, Num);
  for texti := 0 to Num - 1 do
  begin
    Texture := TTextureOpenGL.Create;
    Texture.ID := GlobalID;
    Inc(GlobalID);
    Texture.Read(self);
    Textures[texti] := Texture;
  end;
end;

procedure TTextures.Write;
var
  texti: integer;
begin
  inherited;
  for texti := 0 to Num - 1 do
    Textures[texti].Write(self);
  CalcSize;
end;

function TTextures.AddTexture(node: TXmlNode; file_path: string):
  TTextureOpenGL;
var
  tName, tID: string;
  found: boolean;
  lastIndex: integer;
begin
  Result := TTextureOpenGL.Create;
  with Result do
  begin
    BSP := Self.BSP;
    tId := node.NodeByName('id').Value;
    tName := Copy(tId, 1, Length(tId) - 4); //_png = 4
    name := StrNew(PChar(tName));
    min_mag_type := 4;
    border_color[0] := 255;
    border_color[1] := 255;
    border_color[2] := 255;
    border_color[3] := 255;
    LoadPNGImage(file_path); //(path + tName + '.png');
    if width <> height then
      wrap_type := 1
    else
      wrap_type := 3;

    hash := MakeTextureHash();
  end;
end;

{ TFloors }

function TFloors.AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode: PVirtualNode): PVirtualNode;
var
  k: integer;
  Node: PVirtualNode;
begin
  Node := TreeView.AddChild(TreeNode);
  Data := TreeView.GetNodeData(Node);
  Data^.Name := TypeName;
  Data^.Value := 'Floors';
  Data^.ImageIndex := 23;
  Data^.Obj := self;
  for k := 0 to High(floors) do
    if floors[k].hasNgonBSP then
      floors[k].NgonBSP.AddClassNode(TreeView, Node);
end;

procedure TFloors.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node, Node1: PVirtualNode;
  i: Integer;
begin
  inherited;
  for i := 0 to High(floors) do
  begin
    Node1 := AddTreeData(nil, format('Floor [%d]', [i]), nil, BSPStruct);
    Node := AddTreeData(Node1, 'Occlusion BSP', @floors[i].hasNgonBSP, BSPChBool);
    if floors[i].hasNgonBSP then
      ValueIndex(Node, 26);
    AddBoundData(Node1, floors[i].BBox, 'Ghost Camera');
  end;
end;

constructor TFloors.Create;
begin
  TypeName := 'Floors';
  mesh := TMesh.Create;
end;

procedure TFloors.DeleteChild(Chunk: TChunk);
var
  NgonBSP: TSpNgonBSP;
  i: integer;
begin
  if Chunk is TSpNgonBSP then
  begin
    NgonBSP := TSpNgonBSP(Chunk);
    for i := 0 to High(floors) do
      if floors[i].NgonBSP = NgonBSP then
      begin
        floors[i].hasNgonBSP := False;
        FreeAndNil(floors[i].NgonBSP);
        Break;
      end;
  end;
end;

destructor TFloors.Destroy;
var
  i: Integer;
begin
  mesh.Clear;
  for i := 0 to High(Floors) do
    if floors[i].hasNgonBSP then
      FreeAndNil(floors[i].NgonBSP);
  SetLength(floors, 0);
  inherited;
end;

function TFloors.GetMesh: TMesh;
var
  nchild, x: integer;
begin
  Result := Mesh;
  Mesh.ResetChilds(0);
  nchild := 0;
  for x := 0 to High(floors) do
    if floors[x].NgonBSP <> nil then
    begin
      SetLength(Mesh.Childs, nchild + 1);
      Mesh.childs[nchild] := floors[x].NgonBSP.GetMesh;
      Mesh.childs[nchild].floors := $1 shl x;
      inc(nchild);
    end;
end;

procedure TFloors.Read(Chunk: TChunk);
var
  i: Integer;
begin
  SetLength(floors, TWorld(Chunk).floor_count);
  TypeName := Format('Floors [%d]', [Length(Floors)]);
  for i := 0 to High(floors) do
  begin
    if TWorld(Chunk).Version = 1676 then
    begin
      if i > 1 then
        Chunk.ReadSPDword;
      Chunk.ReadSPDword;
      floors[i].hasNgonBSP := false;
    end
    else
    begin
      if (TWorld(Chunk).Version = 1696) or (TWorld(Chunk).Version = 1695) or (TWorld(Chunk).Version = 1693) then
        Chunk.ReadSPDword;
      floors[i].hasNgonBSP := Boolean(Chunk.ReadSPDword);
    end;
    floors[i].BBox := Chunk.ReadBound;
  end;
end;

procedure TFloors.ReadNgonBSPs(Chunk: TChunk);
var
  i: Integer;
begin
  for i := 0 to High(floors) do
    if floors[i].hasNgonBSP then
    begin
      floors[i].NgonBSP := Chunk.BSP.ReadBSPChunk;
      floors[i].NgonBSP.TypeName := format('Floor %d', [i]);
    end;
end;

procedure TFloors.Write(Chunk: TChunk);
var
  i: Integer;
begin
  for i := 0 to High(floors) do
  begin
    Chunk.WriteBoolean(floors[i].hasNgonBSP);
    Chunk.WriteBound(floors[i].BBox);
  end;
end;

procedure TFloors.WriteNgonBSPs(Chunk: TChunk);
var
  i: Integer;
begin
  for i := 0 to High(floors) do
    if floors[i].hasNgonBSP then
      Chunk.BSP.WriteBSPChunk(floors[i].NgonBSP);
end;

{ TWorld }

constructor TWorld.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'World';
  mesh := TMesh.Create;
end;

destructor TWorld.Destroy;
begin
  Mesh.Clear;
  FreeAndNil(Floors);
  FreeAndNil(ModelGroup);
  FreeAndNil(SectorOctree);
  FreeAndNil(NgonBSP);
  FreeAndNil(NullNodes);
  FreeAndNil(WaypointMap);
  FreeAndNil(Zones);
  FreeAndNil(SpLights);
  inherited;
end;

type
  PBBox = ^TBBox;

procedure TWorld.MakeDefault(BSPfile: TBSPFile);
var
  bbox: PBBox;
begin
  inherited;
  IDType := C_World;
  Version := 1698;
  BSP.World := self;
  flags := 2;
  photonLightingAmbient[1] := 255;
  photonLightingAmbient[2] := 255;
  photonLightingAmbient[3] := 255;
  photonLightingAmbient[4] := 255;
  if templateIndex = 3 then //if animation
    floor_count := 0
  else
    floor_count := 1;
  Floors := TFloors.Create;
  SetLength(Floors.floors, floor_count);
  Floors.TypeName := Format('Floors [%d]', [Length(Floors.floors)]);
  if templateIndex <> 3 then
  begin
    Floors.floors[0].hasNgonBSP := false;
    bbox := @Floors.floors[0].BBox;
    bbox^.max[1] := 100.0;
    bbox^.max[2] := bbox^.max[1];
    bbox^.max[3] := bbox^.max[1];
    bbox^.min[1] := -100.0;
    bbox^.min[2] := bbox^.min[1];
    bbox^.min[3] := bbox^.min[1];

    //tFloor.hash
  end;
  NumZones := 0;
  hasNgonBSP := False;
  hasNullNodes := False;
  hasWaypointMap := False;
  hasMesh := true;

  ModelGroup := TSpMesh.Create(nil);
  ModelGroup.MakeDefault(BSPFile);

  SectorOctree := TSectorOctree.Create(nil);
  SectorOctree.MakeDefault(BSPFile);
end;

procedure TWorld.Read;
begin
  BSP.World := self;
  flags := ReadDword;
  photonLightingAmbient := ReadVect4b;
  floor_count := ReadSPDword;
  if Version = 1676 then
    floor_count:= floor_count + 1; 
  Floors := TFloors.Create;
  Floors.Read(self);

  NumZones := ReadSPDword;
  hasNgonBSP := Boolean(ReadSPDword);
  hasNullNodes := Boolean(ReadSPDword);
  hasWaypointMap := Boolean(ReadSPDword);
  hasMesh := Boolean(ReadSPDword);
  if hasMesh then
    ModelGroup := TSpMesh(BSP.ReadBSPChunk);
  SectorOctree := TSectorOctree(BSP.ReadBSPChunk);
  Floors.ReadNgonBSPs(self);
  if hasNgonBSP then
    NgonBSP := TSpNgonBSP(BSP.ReadBSPChunk);
  if hasNullNodes then
    NullNodes := TNullNodes(BSP.ReadBSPChunk);
  if hasWaypointMap then
    WaypointMap := TWaypointMap(BSP.ReadBSPChunk);
  if NumZones > 0 then
    Zones := TZones(BSP.ReadBSPChunk);
  if (flags and 1 = 1) then
    SpLights := TLightSwitchController(BSP.ReadBSPChunk);
end;

procedure TWorld.Write;
begin
  inherited;
  WriteDword(flags);
  WriteVect4b(photonLightingAmbient);
  WriteSPDword(floor_count);
  Floors.Write(Self);
  WriteSPDword(NumZones);
  WriteBoolean(hasNgonBSP);
  WriteBoolean(hasNullNodes);
  WriteBoolean(hasWaypointMap);
  WriteBoolean(hasMesh);
  CalcSize;
  if hasMesh then
    BSP.WriteBSPChunk(ModelGroup);
  BSP.WriteBSPChunk(SectorOctree);
  Floors.WriteNgonBSPs(Self);
  if hasNgonBSP then
    BSP.WriteBSPChunk(NgonBSP);
  if hasNullNodes then
    BSP.WriteBSPChunk(NullNodes);
  if hasWaypointMap then
    BSP.WriteBSPChunk(WaypointMap);
  if NumZones > 0 then
    BSP.WriteBSPChunk(Zones);
  if (flags and 1 = 1) then
    BSP.WriteBSPChunk(SpLights);
end;

procedure TWorld.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node: PVirtualNode;
begin
  inherited;
  Node := AddTreeData(nil, 'Flags', @flags, BSPWorldFlags);
  if (flags and 1 = 1) then
    ValueIndex(Node, 25);
  AddTreeData(nil, 'Ambient Light Color', @photonLightingAmbient, BSPVect4b);
  Node := AddTreeData(nil, 'Num Floors', @floor_count, BSPUint);
  ValueIndex(Node, 23);
  Node := AddTreeData(nil, 'Num Zones', @NumZones, BSPUint);
  ValueIndex(Node, 29);
  Node := AddTreeData(nil, 'Occlusion BSP', @hasNgonBSP, BSPChBool);
  ValueIndex(Node, 26);
  Node := AddTreeData(nil, 'Nulls', @hasNullNodes, BSPChBool);
  ValueIndex(Node, 5);
  Node := AddTreeData(nil, 'Waypoints', @hasWaypointMap, BSPChBool);
  ValueIndex(Node, 21);
  Node := AddTreeData(nil, 'Mesh', @hasMesh, BSPChBool);
  ValueIndex(Node, 15);
end;

procedure TWorld.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:PPropertyData);
begin
  if PData.DName = 'Num Floors' then
  begin
    SetLength(floors.floors, floor_count);
  end;
  inherited;
end;

function TWorld.AddClassNode(TreeView: TCustomVirtualStringTree; TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 17;
  Result.CheckType := ctTriStateCheckBox;
  Result.CheckState := csCheckedNormal;
  if (floor_count > 0) then
    Floors.AddClassNode(TreeView, Result);
  if hasMesh then
  begin
    ModelGroup.Progress := true;
    ModelGroup.AddClassNode(TreeView, Result);
  end;
  SectorOctree.AddClassNode(TreeView, Result);
  if hasNgonBSP then
    NgonBSP.AddClassNode(TreeView, Result);
  if hasNullNodes then
    NullNodes.AddClassNode(TreeView, Result);
  if hasWaypointMap then
    WaypointMap.AddClassNode(TreeView, Result);
  if Zones <> nil then
    Zones.AddClassNode(TreeView, Result);
  if SpLights <> nil then
    SpLights.AddClassNode(TreeView, Result);
end;

function TWorld.GetMesh: TMesh;
var
  nchild: integer;
begin
  Result := mesh;
  Mesh.ResetChilds(0);
  nchild := 0;

  if (ModelGroup <> nil) then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := ModelGroup.GetMesh;
    inc(nchild);
  end;
  if (floor_count > 0) then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := Floors.GetMesh;
    inc(nchild);
  end;
  if NgonBSP <> nil then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := NgonBSP.GetMesh;
    Mesh.childs[nchild].floors := $1 shl floor_count;
    inc(nchild);
  end;
  if NullNodes <> nil then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := NullNodes.GetMesh;
    inc(nchild);
  end;
  if WaypointMap <> nil then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := WaypointMap.GetMesh;
    inc(nchild);
  end;
  if Zones <> nil then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := Zones.GetMesh;
    inc(nchild);
  end;
end;

procedure TWorld.DeleteChild(Chunk: TChunk);
begin
  if Chunk is TSpMesh then
  begin
    hasMesh := false;
    FreeAndNil(ModelGroup);
  end;
  if Chunk is TSpNgonBSP then
  begin
    hasNgonBSP := false;
    FreeAndNil(NgonBSP);
  end;
  if Chunk is TNullNodes then
  begin
    hasNullNodes := false;
    FreeAndNil(NullNodes);
  end;
  if Chunk is TWaypointMap then
  begin
    hasWaypointMap := false;
    FreeAndNil(WaypointMap);
  end;
  if Chunk is TZones then
  begin
    NumZones := 0;
    FreeAndNil(Zones);
  end;
  if Chunk is TLightSwitchController then
  begin
    flags := flags and $FFFFFFFE;
    FreeAndNil(SpLights);
  end;
end;

{ TSpMesh }

procedure TSpMesh.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_Mesh;
  Version := 1698;

  id := 10;
  models_num := 0;
  Clear;
  SetLength(models, models_num);
  BBox.max[1] := 0.0;
  BBox.max[2] := 0.0;
  BBox.max[3] := 0.0;
  BBox.max[4] := 1.0;
  BBox.min := BBox.max;
  InnerSphere[1] := 0.0;
  InnerSphere[2] := 0.0;
  InnerSphere[3] := 0.0;
  InnerSphere[4] := 1.0;
  Radius := 0.0;
  IsBSP := false;
end;

procedure TSpMesh.AddMesh(node: TXmlNode; a_type: Cardinal);
var
  RenderBlock: TRenderBlock;
begin
  if a_type = 5 then
    id := 10
  else
    id := 8;
  models_num := 1;
  Clear;
  RenderBlock := TRenderBlock.Create(nil);
  RenderBlock.MakeDefault(BSP);
  RenderBlock.AddRenderBlock(node, a_type);
  SetLength(models, models_num);
  models[0] := RenderBlock;
  models[0].TypeName := format('Shape_%d', [BSP.ShpIdx]);
  Inc(BSP.ShpIdx);
end;

procedure TSpMesh.Read;
var
  i: Integer;
begin
  id := ReadDword;
  models_num := ReadSPWord; //2
  Clear;
  SetLength(models, models_num);
  BBox := ReadBound;
  InnerSphere := ReadVec3f4;
  Radius := ReadFloat;
  IsBSP := Boolean(ReadDword);
  // SetLength(Mesh.Childs, models_num);
  for i := 0 to models_num - 1 do
  begin
    models[i] := TRenderBlock(BSP.ReadBSPChunk);
    models[i].TypeName := format('Shape_%d', [BSP.ShpIdx]);
    // mesh.Childs[i]:=models[i].mesh;
    Inc(BSP.ShpIdx);
  end;
  if IsBSP then
    Collision := TSpBSP(BSP.ReadBSPChunk);
end;

procedure TSpMesh.Write;
var
  i: Integer;
begin
  inherited;
  WriteDword(id);
  WriteSPWord(models_num);
  WriteBound(BBox);
  WriteVec3f4(InnerSphere);
  WriteFloat(Radius);
  WriteBoolean(IsBSP);
  CalcSize;
  for i := 0 to models_num - 1 do
    BSP.WriteBSPChunk(models[i]);
  if IsBSP then
    BSP.WriteBSPChunk(Collision);
end;

procedure TSpMesh.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node: PVirtualNode;
  Data: PPropertyData;
begin
  inherited;
  AddTreeData(nil, 'Flags', @id, BSPMeshFlags);
  AddTreeData(nil, 'Num Blocks', @models_num, BSPSint);
  AddBoundData(nil, BBox);
  AddTreeData(nil, 'Center', @InnerSphere, BSPVect);
  AddTreeData(nil, 'Radius', @Radius, BSPFloat);
  Node := AddTreeData(nil, 'BSP', @IsBSP, BSPChBool);
  if IsBSP then
    ValueIndex(Node, 5);
end;

constructor TSpMesh.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Mesh';
  mesh := TMesh.Create;
  mesh.ChName := 'MG';
end;

destructor TSpMesh.Destroy;
begin
  Clear;
  Mesh.Clear;
  inherited;
end;

procedure TSpMesh.Clear;
var
  i: integer;
begin
  if Length(models) > 0 then
  begin
    for i := 0 to Length(models) - 1 do
      FreeAndNil(models[i]);
  end;
  FreeAndNil(Collision);
  SetLength(models, 0);
  // SetLength(Mesh.Childs,0);
end;

function TSpMesh.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 15;
  Result.CheckType := ctTriStateCheckBox;
  Result.CheckState := csCheckedNormal;
  for x := 0 to models_num - 1 do
  begin
    Models[x].AddClassNode(TreeView, Result);
{$IFDEF PROGRESSBAR}if Progress then
      But.TreeProgress.Position := 600 + Round(x / models_num * 100);
{$ENDIF}
  end;
  if IsBSP then
    Collision.AddClassNode(TreeView, Result);
end;

function TSpMesh.GetMesh: TMesh;
var
  i: integer;
begin
  Result := mesh;
  Mesh.ResetChilds(models_num);
  for i := 0 to models_num - 1 do
  begin
    Mesh.childs[i] := models[i].GetMesh;
  end;
end;

procedure TSpMesh.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

procedure TSpMesh.DeleteChild(Chunk: TChunk);
var
  Model: TRenderBlock;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TRenderBlock then
  begin
    Model := TRenderBlock(Chunk);
    Dec(models_num);
    MoveIndex := False;
    for i := 0 to models_num do
    begin
      if MoveIndex then
        Models[i - 1] := Models[i];
      if Models[i] = Model then
        MoveIndex := true;
    end;
    SetLength(Models, models_num);
    Model.Destroy;
  end;
  // LINK to Collision, NgonBSP, SectorOctree
  if Chunk is TSpBSP then
  begin
    IsBSP := false;
    FreeAndNil(Collision);
  end;
end;

function TSpMesh.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TSpMesh;
  i: integer;
  tempBSP: TBSPFile;
begin
  Chunk := TSpMesh(inherited CopyChunk(nBSP));
  Chunk.mesh := TMesh.Create;
  Chunk.mesh.ChName := 'MG';
  Chunk.id := id;
  Chunk.models_num := models_num;
  SetLength(Chunk.models, models_num);
  Chunk.BBox := BBox;
  Chunk.InnerSphere := InnerSphere;
  Chunk.Radius := Radius;
  Chunk.IsBSP := IsBSP;

  if nBSP = nil then
    tempBSP := BSP
  else
    tempBSP := nBSP;

  for i := 0 to models_num - 1 do
  begin
    Chunk.models[i] := TRenderBlock(models[i].CopyChunk(nBSP));
    Chunk.models[i].TypeName := format('Shape_%d', [tempBSP.ShpIdx]);
    Inc(tempBSP.ShpIdx);
  end;
  if IsBSP then
    Chunk.Collision := TSpBSP(Collision.CopyChunk(nBSP));
  Result := Chunk;
end;

procedure TSpMesh.CalculateBound;
var
  model_index, vector_index: integer;
  min, max: TVect4;
  cVector: TVer;
  cMesh: TRenderBlock;
begin
  if models_num > 0 then
  begin
    min[1] := Math.MaxSingle;
    min[2] := min[1];
    min[3] := min[1];
    max[1] := Math.MinSingle;
    max[2] := max[1];
    max[3] := max[1];
    for model_index := 0 to models_num - 1 do
    begin
      cMesh := models[model_index];
      for vector_index := 0 to cMesh.vertex_count - 1 do
      begin
        cVector := cMesh.mesh.Vert[vector_index];
        if cVector[0] < min[1] then
          min[1] := cVector[0];
        if cVector[1] < min[2] then
          min[2] := cVector[1];
        if cVector[2] < min[3] then
          min[3] := cVector[2];
        if cVector[0] > max[1] then
          max[1] := cVector[0];
        if cVector[1] > max[2] then
          max[2] := cVector[1];
        if cVector[2] > max[3] then
          max[3] := cVector[2];
      end;
    end;
    BBox.min := min;
    BBox.max := max;
    InnerSphere[1] := (BBox.max[1] + BBox.min[1]) / 2;
    InnerSphere[2] := (BBox.max[2] + BBox.min[2]) / 2;
    InnerSphere[3] := (BBox.max[3] + BBox.min[3]) / 2;
    Radius := Math.Max(Math.Max(InnerSphere[1], InnerSphere[2]),
      InnerSphere[3]);
  end;
end;

{ TRenderBlock }

procedure TRenderBlock.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_RenderBlock;
  Version := 1698;
end;

procedure TRenderBlock.AddRenderBlock(node: TXmlNode; a_type: Cardinal);
var
  i, j, k, bone_index: integer;
  library_geometries, geometry, nMesh, nSource, nTriangles, library_controllers,
    instance_material, controller, nSkin, vertex_weights, nNormals, nMap1,
    nodeP,
    joints_array: TXmlNode;
  source_id, nodeName: string;
  bflag: Byte;
  float_array, normal_array, texcoord_array, vcount, v, joints: TStringList;
  data_offset, face_index, weigth_index, offset, pVertex, pNormal, pTexcoord,
    nIndex, uvIndex, stride, iterations: Cardinal;
  generateNormals, badUV: Boolean;

  procedure CalculateFaces;
  begin
    while k < float_array.Count do
    begin
      mesh.Face[face_index][0] := StrToInt(float_array[k + pVertex]);
      mesh.Face[face_index][1] := StrToInt(float_array[k + pVertex + offset]);
      mesh.Face[face_index][2] := StrToInt(float_array[k + pVertex + offset *
        2]);
      inc(face_index);
      k := k + data_offset;
    end;
  end;

  procedure SortUV(index, map1Index: Cardinal);
  begin
    mesh.TextCoord[index][0] := StrToFloat(texcoord_array[map1Index * stride]);
    mesh.TextCoord[index][1] := 1.0 - StrToFloat(texcoord_array[map1Index *
      stride + 1]);
  end;

  procedure SortNormal(index, nIndex: Cardinal);
  begin
    mesh.Normal[index][0] := StrToFloat(normal_array[nIndex * 3]);
    mesh.Normal[index][1] := StrToFloat(normal_array[nIndex * 3 + 1]);
    mesh.Normal[index][2] := StrToFloat(normal_array[nIndex * 3 + 2]);
  end;

  procedure CalculateFacesAndNormalsAndUV;
  begin
    normal_array := TStringList.Create;
    normal_array.Delimiter := ' ';
    normal_array.DelimitedText := nNormals.NodeByName('float_array').Value;
    texcoord_array := TStringList.Create;
    texcoord_array.Delimiter := ' ';
    texcoord_array.DelimitedText := nMap1.NodeByName('float_array').Value;
    stride :=
      nMap1.NodeByName('technique_common').NodeByName('accessor').AttributeByName['stride'].ValueAsInteger;
    SetLength(mesh.Normal, vertex_count);
    SetLength(mesh.TextCoord, vertex_count);
    while k < float_array.Count do
    begin
      mesh.Face[face_index][0] := StrToInt(float_array[k + pVertex]);
      mesh.Face[face_index][1] := StrToInt(float_array[k + pVertex + offset]);
      mesh.Face[face_index][2] := StrToInt(float_array[k + pVertex + offset *
        2]);
      SortNormal(StrToInt(float_array[k + pVertex]), StrToInt(float_array[k +
        pNormal]));
      SortNormal(StrToInt(float_array[k + pVertex + offset]),
        StrToInt(float_array[k + pNormal + offset]));
      SortNormal(StrToInt(float_array[k + pVertex + offset * 2]),
        StrToInt(float_array[k + pNormal + offset * 2]));
      SortUV(StrToInt(float_array[k + pVertex]), StrToInt(float_array[k +
        pTexcoord]));
      SortUV(StrToInt(float_array[k + pVertex + offset]), StrToInt(float_array[k
        + pTexcoord + offset]));
      SortUV(StrToInt(float_array[k + pVertex + offset * 2]),
        StrToInt(float_array[k + pTexcoord + offset * 2]));
      inc(face_index);
      k := k + data_offset;
    end;
    texcoord_array.Free;
    normal_array.Free;
  end;

  procedure CalculateFacesAndUV;
  begin
    texcoord_array := TStringList.Create;
    texcoord_array.Delimiter := ' ';
    texcoord_array.DelimitedText := nMap1.NodeByName('float_array').Value;
    stride :=
      nMap1.NodeByName('technique_common').NodeByName('accessor').AttributeByName['stride'].ValueAsInteger;
    SetLength(mesh.TextCoord, vertex_count);
    while k < float_array.Count do
    begin
      mesh.Face[face_index][0] := StrToInt(float_array[k + pVertex]);
      mesh.Face[face_index][1] := StrToInt(float_array[k + pVertex + offset]);
      mesh.Face[face_index][2] := StrToInt(float_array[k + pVertex + offset *
        2]);
      SortUV(StrToInt(float_array[k + pVertex]), StrToInt(float_array[k +
        pTexcoord]));
      SortUV(StrToInt(float_array[k + pVertex + offset]), StrToInt(float_array[k
        + pTexcoord + offset]));
      SortUV(StrToInt(float_array[k + pVertex + offset * 2]),
        StrToInt(float_array[k + pTexcoord + offset * 2]));
      inc(face_index);
      k := k + data_offset;
    end;
    texcoord_array.Free;
  end;

  procedure CalculateFacesAndNormals;
  begin
    normal_array := TStringList.Create;
    normal_array.Delimiter := ' ';
    normal_array.DelimitedText := nNormals.NodeByName('float_array').Value;
    SetLength(mesh.Normal, vertex_count);
    while k < float_array.Count do
    begin
      mesh.Face[face_index][0] := StrToInt(float_array[k + pVertex]);
      mesh.Face[face_index][1] := StrToInt(float_array[k + pVertex + offset]);
      mesh.Face[face_index][2] := StrToInt(float_array[k + pVertex + offset *
        2]);
      SortNormal(StrToInt(float_array[k + pVertex]), StrToInt(float_array[k +
        pNormal]));
      SortNormal(StrToInt(float_array[k + pVertex + offset]),
        StrToInt(float_array[k + pNormal + offset]));
      SortNormal(StrToInt(float_array[k + pVertex + offset * 2]),
        StrToInt(float_array[k + pNormal + offset * 2]));
      inc(face_index);
      k := k + data_offset;
    end;
    normal_array.Free;
  end;

begin
  flag_1 := $0E0E7C00;
  flag_2 := $00000100;
  flag_3 := $000C4800;
  flag_4 := $FFFFFFFF;
  val_5 := $00000000;
  mesh.Attribute.Multi := false;
  library_geometries := DaeRoot.NodeByName('library_geometries');
  library_controllers := DaeRoot.NodeByName('library_controllers');
  float_array := TStringList.Create;
  for i := 0 to library_geometries.ElementCount - 1 do
  begin
    geometry := library_geometries.Elements[i];
    if geometry.AttributeByName['name'].Value =
      node.AttributeByName['name'].Value then //found a geometry
    begin
      nMesh := geometry.NodeByName('mesh');
      for j := 0 to nMesh.ElementCount - 1 do
      begin
        nSource := nMesh.Elements[j];
        if nSource.AttributeByName['id'] <> nil then
        begin
          source_id := nSource.AttributeByName['id'].Value;
          if AnsiEndsStr('-positions', source_id) then //positions
          begin
            bflag := bflag or $1; //Vertex
            float_array.Clear;
            float_array.Delimiter := ' ';
            float_array.DelimitedText :=
              nSource.NodeByName('float_array').Value;
            vertex_count := float_array.Count div 3;
            SetLength(mesh.Vert, vertex_count);
            for k := 0 to vertex_count - 1 do
            begin
              mesh.Vert[k][0] := StrToFloat(float_array[k * 3]);
              mesh.Vert[k][1] := StrToFloat(float_array[k * 3 + 1]);
              mesh.Vert[k][2] := StrToFloat(float_array[k * 3 + 2]);
              mesh.CalcSizeBox(mesh.Vert[k]);
            end;
          end
          else if AnsiEndsStr('-normals', source_id) then //normals
          begin
            bflag := bflag or $4;
            nNormals := nSource;
          end
          else if AnsiEndsStr('-map1', source_id) then //textcoord 1
          begin
            mesh.Attribute.Multi := true;
            mesh_flags := mesh_flags or $1; //ntex;
            ntex := 1;
            nMap1 := nSource;
          end;
        end
        else if nSource.Name = 'triangles' then //triangles
        begin
          data_offset := (nSource.ElementCount - 1) * 3; //inputs - p
          float_array.Clear;
          float_array.Delimiter := ' ';
          float_array.DelimitedText := nSource.NodeByName('p').Value;
          indices_count := nSource.AttributeByName['count'].ValueAsInteger;
          SetLength(mesh.Face, indices_count);
          for k := 0 to nSource.ElementCount - 2 do //except p
          begin
            if nSource.Elements[k].AttributeByName['semantic'].Value = 'VERTEX'
              then
              pVertex :=
                nSource.Elements[k].AttributeByName['offset'].ValueAsInteger
            else if nSource.Elements[k].AttributeByName['semantic'].Value =
              'NORMAL' then
              pNormal :=
                nSource.Elements[k].AttributeByName['offset'].ValueAsInteger
            else if (nSource.Elements[k].AttributeByName['semantic'].Value =
              'TEXCOORD') and
              (nSource.Elements[k].AttributeByName['set'].ValueAsInteger = 0)
                then
              pTexcoord :=
                nSource.Elements[k].AttributeByName['offset'].ValueAsInteger;
          end;

          k := 0;
          face_index := 0;
          offset := nSource.ElementCount - 1;

          if nMap1 <> nil then
          begin
            badUV :=
              nMap1.NodeByName('technique_common').NodeByName('accessor').AttributeByName['count'].ValueAsInteger <> vertex_count;
            if badUV then
            begin
              SetLength(Mesh.TextCoord, vertex_count);
              //Set Null coords, and try normals
              if nNormals <> nil then
              begin
                generateNormals :=
                  nNormals.NodeByName('technique_common').NodeByName('accessor').AttributeByName['count'].ValueAsInteger <> vertex_count;
                if generateNormals then //Calculate faces
                begin
                  CalculateFaces;
                  RecalculateNormals;
                end
                else //Calculate normals with faces
                begin
                  CalculateFacesAndNormals;
                end;
              end
              else
              begin
                CalculateFaces;
              end;
            end
            else
            begin //Good UV, Try normals
              if nNormals <> nil then
              begin
                generateNormals :=
                  nNormals.NodeByName('technique_common').NodeByName('accessor').AttributeByName['count'].ValueAsInteger <> vertex_count;
                if generateNormals then //Calculate faces
                begin
                  CalculateFacesAndUV;
                  RecalculateNormals;
                end
                else
                begin //face, normals, UV
                  CalculateFacesAndNormalsAndUV;
                end;
              end
              else
              begin //faces with UV
                CalculateFacesAndUV;
              end;
            end;
          end
          else
          begin //without UV, try normals
            if nNormals <> nil then
            begin
              generateNormals :=
                nNormals.NodeByName('technique_common').NodeByName('accessor').AttributeByName['count'].ValueAsInteger <> vertex_count;
              if generateNormals then //Calculate faces
              begin
                CalculateFaces;
                RecalculateNormals;
              end
              else
              begin
                CalculateFacesAndNormals;
              end;
            end
            else //No UV, no Normals
            begin
              CalculateFaces;
            end;
          end;
        end;
      end;
      break;
    end;
  end;

  if node.NodeByName('instance_controller') <> nil then
  begin
    normal_flags := $00000006;
    instance_material :=
      node.NodeByName('instance_controller').NodeByName('bind_material').NodeByName('technique_common').NodeByName('instance_material');
    Self.materialHash :=
      uMaterials.Value[instance_material.AttributeByName['symbol'].Value];
    bflag := bflag or $30; // Weight,Bone
    //library_controllers get all weights
    nodeName := node.AttributeByName['id'].Value;
    nodeName := 'geom' + Copy(nodeName, 5, length(nodeName) - 4) + '-';
    for i := 0 to library_controllers.ElementCount - 1 do
    begin
      controller := library_controllers.Elements[i];
      if AnsiContainsText(controller.AttributeByName['id'].Value, nodeName) then
      begin
        nSkin := controller.NodeByName('skin');
        for j := 0 to nSkin.ElementCount - 1 do
        begin
          nSource := nSkin.Elements[j];
          if nSource.AttributeByName['id'] <> nil then
          begin
            if AnsiEndsStr('-joints', nSource.AttributeByName['id'].Value) then
              joints_array := nSource;
            if AnsiEndsStr('-weights', nSource.AttributeByName['id'].Value) then
            begin
              vertex_weights := nSkin.NodeByName('vertex_weights');
              float_array.Clear;
              float_array.Delimiter := ' ';
              float_array.DelimitedText :=
                nSource.NodeByName('float_array').Value;
              vcount := TStringList.Create;
              vcount.Delimiter := ' ';
              vcount.DelimitedText := vertex_weights.NodeByName('vcount').Value;
              v := TStringList.Create;
              v.Delimiter := ' ';
              v.DelimitedText := vertex_weights.NodeByName('v').Value;
              SetLength(mesh.Weight, vertex_count);
              mesh.XType := 'SS';
              for k := 0 to vertex_count - 1 do
                SetLength(mesh.Weight[k], BSP.LastClump.num_bones);
              k := 0;
              weigth_index := 0;
              {  while weigth_index < vertex_count do
                begin
                  mesh.Weight[weigth_index][0]:= 1.0;
                  inc(weigth_index);
                end; }
              joints := TStringList.Create;
              joints.Delimiter := ' ';
              joints.DelimitedText :=
                joints_array.NodeByName('Name_array').Value;
              while weigth_index < vertex_count do
              begin
                iterations := StrToInt(vcount[weigth_index]);
                if iterations > 2 then
                begin
                  ShowMessage('Error has accured! More than two weights per vertex have been found!');
                end;
                while iterations > 0 do
                begin
                  bone_index := DaeSkinBones.IndexOf(joints[StrToInt(v[k])]);
                  mesh.Weight[weigth_index][bone_index] :=
                    StrToFloat(float_array[StrToInt(v[k + 1])]);
                  k := k + 2;
                  dec(iterations);
                end;
                inc(weigth_index);
              end;
              joints.Free;
              vcount.Free;
              v.Free;
              break;
            end;
          end;
        end;
        break;
      end;
    end;
  end
  else
  begin
    normal_flags := $00000000;
    instance_material :=
      node.NodeByName('instance_geometry').NodeByName('bind_material').NodeByName('technique_common').NodeByName('instance_material');
    Self.materialHash :=
      uMaterials.Value[instance_material.AttributeByName['symbol'].Value];
  end;

  if BSP.Materials <> nil then
  begin
    material := BSP.Materials.FindMaterialOfHash(materialHash);
    if material <> nil then
      material.SetMaterial(mesh);
  end;
  if a_type = 5 then
  begin
    matrix_flag := $80000080;
    draw_start := vertex_count;
    face_end := indices_count;
  end
  else
  begin
    matrix_flag := $00000080;
    draw_start := 0;
    face_end := 0;
  end;

  val_8 := $00000008;
  indices_limit := 0;
  val_16 := $FFFFFFFF;
  floor_flag := 0;
  move(bflag, mflag, SizeOf(mflag));
  mesh_flags := mesh_flags or short(bflag shl 8);
  matrix_flag := matrix_flag or $80;
  mesh_index := 0;
  mesh.VertsLen := vertex_count;
  val_12 := 0;
  face_start := 0;
  draw_count := 0;
  //Free objects
  float_array.Free;
end;

procedure TRenderBlock.Read;
var
  bflag: Byte;
begin
  Clump := BSP.LastClump;
  flag_1 := ReadDword;
  flag_2 := ReadDword;
  flag_3 := ReadDword;
  flag_4 := ReadDword;
  val_5 := ReadDword;
  normal_flags := ReadDword;
  mesh_flags := ReadDword;
  ntex := mesh_flags and $FF;
  bflag := byte(mesh_flags shr 8);
  move(bflag, mflag, SizeOf(mflag));
  val_8 := ReadDword;
  vertex_count := ReadDword;
  mesh.VertsLen := vertex_count;
  indices_count := ReadSPWord;
  mesh.FacesLen := indices_count;
  indices_limit := ReadSPWord;
  val_12 := ReadSPWord;
  materialHash := ReadDword;
  if BSP.Materials <> nil then
  begin
    material := BSP.Materials.FindMaterialOfHash(materialHash);
    material.SetMaterial(mesh);
  end;
  face_start := ReadDword;
  face_end := ReadDword;
  draw_count := ReadDword;
  draw_start := ReadDword;
  val_16 := ReadDword;
  floor_flag := ReadDword;
  mesh.floors := floor_flag;
  //  if (floor_flag and $8000)>0 then mesh.XType:='GD';
  matrix_flag := ReadDword;
  if (matrix_flag and $400) > 0 then
    mesh.XType := 'CG';
  mesh_index := ReadDword;
  // meshdata
  ReadMeshCoord(BSP.LastClump);
end;

procedure TRenderBlock.Write;
begin
  inherited;
  WriteDword(flag_1);
  WriteDword(flag_2);
  WriteDword(flag_3);
  WriteDword(flag_4);
  WriteDword(val_5);
  WriteDword(normal_flags);
  WriteDword(mesh_flags);

  WriteDword(val_8);
  WriteDword(vertex_count);
  WriteSPWord(indices_count);
  WriteSPWord(indices_limit);
  WriteSPWord(val_12);
  WriteDword(materialHash);

  WriteDword(face_start);
  WriteDword(face_end);
  WriteDword(draw_count);
  WriteDword(draw_start);
  WriteDword(val_16);
  WriteDword(floor_flag);
  WriteDword(matrix_flag);
  WriteDword(mesh_index);
  // meshdata
  WriteMeshCoord();
  CalcSize;
end;                                        

procedure TRenderBlock.AddVBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('Vertex [%d]', [i]), @AVer(Parr)[i], BSPVect);
end;

procedure TRenderBlock.AddCBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('Color [%d]', [i]), @AUColor(Parr)[i], BSPColor);
end;

procedure TRenderBlock.AddFBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('Face [%d]', [i]), @AFace(Parr)[i], BSPFace);
end;

procedure TRenderBlock.AddWBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  weight: single;
  bone1, bone2: ShortInt;
begin
  GetWeightBones(i, weight, bone1, bone2);
  AddTreeData(Node1, format('Weight [%d][%d]', [i, bone1]), @Mesh.Weight[i][bone1], BSPFloat);
  if weight < 1 then
    AddTreeData(Node1, format('Weight [%d][%d]', [i, bone2]), @Mesh.Weight[i][bone2], BSPFloat);
end;

procedure TRenderBlock.AddUVBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('UV coord [%d]', [i]), @ATCoord(Parr)[i],
    BSPUVCoord);
end;

procedure TRenderBlock.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1, Node2: PVirtualNode;
begin
  inherited;
  AddTreeData(nil, 'Read Access Flags', @flag_1, BSPResourceAccessData);
  AddTreeData(nil, 'Vertex Read Flags', @flag_2, BSPReadFlags);
  AddTreeData(nil, 'Write Access Flags', @flag_3, BSPResourceAccessData);
  AddTreeData(nil, 'Vertex Write Flags', @flag_4, BSPReadFlags);
  AddTreeData(nil, 'Hint Flags', @val_5, BSPHintFlags);
  AddTreeData(nil, 'Constant Flags', @normal_flags, BSPConstantFlags);
  AddTreeData(nil, 'Vertex Flags', @mesh_flags, BSPVertexFlags);
  AddTreeData(nil, 'Render Flags', @val_8, BSPRenderFlags);
  AddTreeData(nil, 'Num Vertex', @vertex_count, BSPUint);
  AddTreeData(nil, 'Num List Tris', @indices_count, BSPSUint16);
  AddTreeData(nil, 'Num Strips', @indices_limit, BSPSUint16);
  AddTreeData(nil, 'Num Strip Tris', @val_12, BSPSUint16);
  AddTreeData(nil, 'Material Hash', @materialHash, BSPRefHash);
  Node1 := AddTreeData(nil, 'Vertex Range Block', nil, BSPStruct);
  AddTreeData(Node1, 'Triangle Index 0', @face_start, BSPInt);
  AddTreeData(Node1, 'Triangle Index 1', @face_end, BSPInt);
  AddTreeData(Node1, 'Vertex Index 0', @draw_count, BSPInt);
  AddTreeData(Node1, 'Vertex Index 1', @draw_start, BSPInt);
  AddTreeData(nil, 'Layer Z', @val_16, BSPDword);
  AddTreeData(nil, 'Floor Flags', @floor_flag, BSPFloorFlags);
  AddTreeData(nil, 'Flags', @matrix_flag, BSPMatBlockFlags);
  AddTreeData(nil, 'Lighting SID', @mesh_index, BSPUint);

  Node1 := AddTreeData(nil, 'Mat Block', nil, BSPStruct);
  if E_VERTEX in mflag then
  begin
    Node2 := AddTreeData(Node1, 'Vertices', @vertex_count, BSPArray);
    AddLoadingMore(Node2, vertex_count, Mesh.Vert, AddVBlockData);
  end;
  if E_NORMAL in mflag then
  begin
    Node2 := AddTreeData(Node1, 'Normals', @vertex_count, BSPArray);
    AddLoadingMore(Node2, vertex_count, Mesh.Normal, AddVBlockData);
  end;
  if E_COLOR in mflag then
  begin
    Node2 := AddTreeData(Node1, 'Diffuses', @vertex_count, BSPArray);
    AddLoadingMore(Node2, vertex_count, Mesh.Color, AddCBlockData);
  end;
  if E_WEIGHT in mflag then
  begin
    Node2 := AddTreeData(Node1, 'Weights', @vertex_count, BSPArray);
    AddLoadingMore(Node2, vertex_count, Mesh.Weight, AddWBlockData);
  end;
  if ntex > 0 then
  begin
    Node2 := AddTreeData(Node1, 'Texture Coordinates', @vertex_count, BSPArray);
    AddLoadingMore(Node2, vertex_count, Mesh.TextCoord, AddUVBlockData);
    if ntex > 1 then
    begin
      Node2 := AddTreeData(Node1, 'Texture Coordinates 2', @vertex_count, BSPArray);
      AddLoadingMore(Node2, vertex_count, Mesh.TextCoord2, AddUVBlockData);
    end;
    if ntex > 2 then
    begin
      Node2 := AddTreeData(Node1, 'Texture Coordinates 3', @vertex_count, BSPArray);
      AddLoadingMore(Node2, vertex_count, Mesh.TextCoordN, AddUVBlockData);
    end;
  end;
  Node2 := AddTreeData(Node1, 'Faces', @indices_count, BSPArray);
  AddLoadingMore(Node2, indices_count, Mesh.Face, AddFBlockData);

end;

constructor TRenderBlock.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Mesh';
  mesh := TMesh.Create();
  mesh.XType := 'SH';
end;

destructor TRenderBlock.Destroy;
begin
  Mesh.Clear;
  inherited;
end;

procedure TRenderBlock.ReadMeshCoord(LastClump: TClump);
var
  i, t, bones: integer;
  weight: single;
  bone1, bone2: ShortInt;
begin
  // set sizes
  bones := 0;
  mesh.Attribute.Multi := false;
  if E_VERTEX in mflag then
    SetLength(mesh.Vert, vertex_count);
  if E_NORMAL in mflag then
    SetLength(mesh.Normal, vertex_count);
  if E_COLOR in mflag then
    SetLength(mesh.Color, vertex_count);
  if E_WEIGHT in mflag then
  begin
    SetLength(mesh.Weight, vertex_count);
    if LastClump <> nil then
    begin
      bones := LastClump.num_bones;
      mesh.XType := 'SS';
      for i := 0 to vertex_count - 1 do
        SetLength(mesh.Weight[i], bones);
    end;
  end;
  if ntex > 0 then
    SetLength(mesh.TextCoord, vertex_count);
  if ntex > 1 then
  begin
    mesh.Attribute.Multi := true;
    SetLength(mesh.TextCoord2, vertex_count);
  end;
  if ntex > 2 then
  begin
    SetLength(mesh.TextCoordN, vertex_count);
  end;
  mesh.InitSizeBox; //
  for i := 0 to vertex_count - 1 do
  begin
    if E_VERTEX in mflag then
      ReadBytesBlock(@mesh.Vert[i][0], 12);
    mesh.CalcSizeBox(mesh.Vert[i]);
    if E_NORMAL in mflag then
      ReadBytesBlock(@mesh.Normal[i][0], 12);
    if E_NFLOAT in mflag then
      mesh.Normal[i][0] := ReadFloat; // ???
    if E_COLOR in mflag then
      ReadBytesBlock(@mesh.Color[i][0], 4);
    weight := 0;
    if E_WEIGHT in mflag then
      weight := ReadFloat;
    if E_BONES in mflag then
    begin
      // SetLength(mesh.Weight[i],Length(mesh.Bones)); // Num Bones?
      bone1 := ReadSPWord;
      bone2 := ReadSPWord;
      if bones > 0 then
      begin
        if bone1 <> -1 then
          mesh.Weight[i][bone1] := weight; //weight?
        if bone2 <> -1 then
          mesh.Weight[i][bone2] := 1.0 - weight; //1-weight?
      end;
    end;
    if ntex > 0 then
    begin
      ReadBytesBlock(@mesh.TextCoord[i][0], 8);
      if ntex > 1 then
        ReadBytesBlock(@mesh.TextCoord2[i][0], 8);
      for t := 2 to ntex - 1 do
        ReadBytesBlock(@mesh.TextCoordN[i][0], 8); // ntextures
    end;
  end;

  SetLength(mesh.Face, indices_count);
  for i := 0 to indices_count - 1 do
  begin
    mesh.Face[i][0] := ReadDword;
    mesh.Face[i][1] := ReadDword;
    mesh.Face[i][2] := ReadDword;
  end;
end;

procedure TRenderBlock.WriteMeshCoord;
var
  i, t, bones: integer;
  weight: single;
  bone1, bone2: ShortInt;
begin

  for i := 0 to vertex_count - 1 do
  begin
    if E_VERTEX in mflag then
      WriteBytesBlock(@mesh.Vert[i][0], 12);
    if E_NORMAL in mflag then
      WriteBytesBlock(@mesh.Normal[i][0], 12);
    if E_NFLOAT in mflag then
      WriteFloat(mesh.Normal[i][0]); // ???
    if E_COLOR in mflag then
      WriteBytesBlock(@mesh.Color[i][0], 4);
    GetWeightBones(i, weight, bone1, bone2);
    if E_WEIGHT in mflag then
      WriteFloat(weight);
    if E_BONES in mflag then
    begin
      WriteSPWord(bone1);
      WriteSPWord(bone2);
    end;
    if ntex > 0 then
    begin
      WriteBytesBlock(@mesh.TextCoord[i][0], 8);
      if ntex > 1 then
        WriteBytesBlock(@mesh.TextCoord2[i][0], 8);
      for t := 2 to ntex - 1 do
        WriteBytesBlock(@mesh.TextCoordN[i][0], 8); // ntextures
    end;
  end;

  for i := 0 to indices_count - 1 do
  begin
    WriteDword(mesh.Face[i][0]);
    WriteDword(mesh.Face[i][1]);
    WriteDword(mesh.Face[i][2]);
  end;
end;

procedure TRenderBlock.GetWeightBones(vertex: integer; var weight: Single; var
  bone1:
  ShortInt; var bone2: ShortInt);
var
  i, bones: Integer;
begin
  bone1 := -1;
  bone2 := -1;
  if Assigned(mesh.Weight) then
  begin
    bones := Length(mesh.Weight[vertex]);
    for i := 0 to bones - 1 do
    begin
      if (bone1 = -1) and (mesh.Weight[vertex][i] > 0) then
      begin
        weight := mesh.Weight[vertex][i];
        bone1 := i;
        if weight = 1.0 then
          Break;
      end;
      if (bone1 <> -1) and (mesh.Weight[vertex][i] > 0) then
        bone2 := i;
    end;
  end;
end;

function TRenderBlock.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 12;
  mesh.Indx := ID;
  CheckHide(Result);
  if material <> nil then
  begin
    material.AddClassNode(TreeView, Result);
    mesh.GetTextureGL(material);
  end;
end;

function TRenderBlock.GetMesh: TMesh;
begin
  Result := mesh;
  if mesh.XType = 'SS' then
  begin
    Mesh.Bones := BSP.BSPList.BoneList;
    Mesh.RVert := Copy(Mesh.Vert);
  end;
end;

procedure TRenderBlock.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csCheckedNormal;
  mesh.Hide := false;
  if (mesh.XType = 'CG') and not But.Collisions^ then
  begin
    ANode.CheckState := csUncheckedNormal;
    mesh.Hide := true;
  end;
  {  if (mesh.XType='GD') and not But.Ground^ then begin
      ANode.CheckState:=csUncheckedNormal;
      mesh.Hide:=true;
    end;   }
end;

procedure TRenderBlock.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

function TRenderBlock.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TRenderBlock;
  i: integer;
  nMaterial: TMaterialObj;
begin
  Chunk := TRenderBlock(inherited CopyChunk(nBSP));
  Chunk.Clump := Clump;
  Chunk.mesh := TMesh.Create;
  Chunk.mesh.XType := mesh.XType;
  Chunk.flag_1 := flag_1;
  Chunk.flag_2 := flag_2;
  Chunk.flag_3 := flag_3;
  Chunk.flag_4 := flag_4;
  Chunk.val_5 := val_5;
  Chunk.normal_flags := normal_flags;
  Chunk.mesh_flags := mesh_flags;
  Chunk.ntex := ntex;
  Chunk.mflag := mflag;
  Chunk.val_8 := val_8;
  Chunk.vertex_count := vertex_count;
  Chunk.mesh.VertsLen := vertex_count;
  Chunk.indices_count := indices_count;
  Chunk.mesh.FacesLen := indices_count;
  Chunk.indices_limit := indices_limit;
  Chunk.val_12 := val_12;
  Chunk.materialHash := materialHash;

  if nBSP = nil then
  begin
    Chunk.material := material;
    Chunk.material.SetMaterial(Chunk.mesh);
  end
  else
  begin
    nMaterial := nBSP.Materials.FindMaterialOfHash(materialHash);
    if nMaterial = nil then
      nMaterial := TMaterialObj(material.CopyChunk(nBSP));
    Chunk.material := nMaterial;
    Chunk.material.SetMaterial(Chunk.mesh);
  end;

  Chunk.face_start := face_start;
  Chunk.face_end := face_end;
  Chunk.draw_count := draw_count;
  Chunk.draw_start := draw_start;
  Chunk.val_16 := val_16;
  Chunk.floor_flag := floor_flag;
  Chunk.mesh.floors := floor_flag;
  Chunk.matrix_flag := matrix_flag;
  Chunk.mesh_index := mesh_index;
  // meshdata
  Chunk.mesh.Attribute.Multi := false;
  if E_VERTEX in mflag then
    Chunk.mesh.Vert := Copy(mesh.Vert);
  if E_NORMAL in mflag then
    Chunk.mesh.Normal := Copy(mesh.Normal);
  if E_COLOR in mflag then
    Chunk.mesh.Color := Copy(mesh.Color);
  if E_WEIGHT in mflag then
  begin
    SetLength(Chunk.mesh.Weight, vertex_count);
    for i := 0 to vertex_count - 1 do
      Chunk.mesh.Weight[i] := Copy(mesh.Weight[i]);
  end;
  if ntex > 0 then
    Chunk.mesh.TextCoord := Copy(mesh.TextCoord);
  if ntex > 1 then
  begin
    Chunk.mesh.Attribute.Multi := true;
    Chunk.mesh.TextCoord2 := Copy(mesh.TextCoord2);
  end;
  if ntex > 2 then
    Chunk.mesh.TextCoordN := Copy(mesh.TextCoordN);

  Chunk.mesh.SizeBox := mesh.SizeBox;
  Chunk.mesh.Face := Copy(mesh.Face);

  Result := Chunk;
end;

procedure TRenderBlock.RecalculateNormals;
var
  NumFace, NumVert, i, j: integer;
  FaceNorm: TVer;
  NormalCount: ATexures;
begin
  SetLength(mesh.Normal, vertex_count);
  SetLength(NormalCount, vertex_count);
  for i := 0 to indices_count - 1 do
  begin
    FaceNorm := GenNormal(i, mesh.Face, mesh.Vert);
    for j := 0 to 2 do
    begin
      VertAdd(mesh.Normal[mesh.Face[i][j]], FaceNorm);
      NormalCount[mesh.Face[i][j]] := NormalCount[mesh.Face[i][j]] + 1;
    end;
  end;
  for i := 0 to vertex_count - 1 do
    for j := 0 to 2 do
      mesh.Normal[i][j] := mesh.Normal[i][j] / NormalCount[i];
end;

procedure TRenderBlock.ReplaceModel(FileName: string);
var
  D: TNativeXml;
  root, meshNode, float_array, normal_array, triangles, indices_array: TXmlNode;
  i, j, face_index, data_offset, offset: integer;
  vertices, normals, indices: TStringList;
begin
  D := TNativeXml.CreateName('COLLADA');
  D.LoadFromFile(FileName);
  root := D.Root;
  meshNode :=
    root.NodeByName('library_geometries').NodeByName('geometry').NodeByName('mesh');
  for i := 0 to meshNode.NodeCount - 1 do
  begin
    if AnsiEndsStr('positions', meshNode.Nodes[i].Attributes[0].Value) then
    begin
      float_array := meshNode.Nodes[i].NodeByName('float_array');
      Include(mflag, E_VERTEX);
      vertices := TStringList.Create;
      vertices.Delimiter := ' ';
      vertices.DelimitedText := float_array.Value;
      vertex_count := vertices.Count div 3;
      SetLength(mesh.Vert, vertex_count);
      for j := 0 to vertex_count - 1 do
      begin
        mesh.Vert[j][0] := StrToFloat(vertices[j * 3]);
        mesh.Vert[j][1] := StrToFloat(vertices[j * 3 + 1]);
        mesh.Vert[j][2] := StrToFloat(vertices[j * 3 + 2]);
      end;
      vertices.Free;
      //add indices
    end
    else if AnsiEndsStr('normals', meshNode.Nodes[i].Attributes[0].Value) then
    begin
      normal_array := meshNode.Nodes[i].NodeByName('float_array');
      Include(mflag, E_NORMAL);
      SetLength(mesh.Normal, vertex_count);
      normals := TStringList.Create;
      normals.Delimiter := ' ';
      normals.DelimitedText := normal_array.Value;
      if normals.Count = 3 then
      begin
        for j := 0 to vertex_count - 1 do
        begin
          mesh.Normal[j][0] := StrToFloat(normals[0]);
          mesh.Normal[j][1] := StrToFloat(normals[1]);
          mesh.Normal[j][2] := StrToFloat(normals[2]);
        end;
      end
      else
      begin
        for j := 0 to vertex_count - 1 do
        begin
          mesh.Normal[j][0] := StrToFloat(normals[j * 3]);
          mesh.Normal[j][1] := StrToFloat(normals[j * 3 + 1]);
          mesh.Normal[j][2] := StrToFloat(normals[j * 3 + 2]);
        end;
      end;
      normals.free;
      Break;
    end;
  end;
  triangles := meshNode.NodeByName('triangles');
  data_offset := (triangles.ElementCount - 1) * 3;
  indices_array := triangles.NodeByName('p');
  indices := TStringList.Create;
  indices.Delimiter := ' ';
  indices.DelimitedText := indices_array.Value;
  indices_count := indices.Count div data_offset;
  SetLength(mesh.Face, indices_count);
  j := 0;
  face_index := 0;
  offset := data_offset div 3;
  while j < indices.Count do
  begin
    mesh.Face[face_index][0] := StrToInt(indices[j]);
    mesh.Face[face_index][1] := StrToInt(indices[j + offset]);
    mesh.Face[face_index][2] := StrToInt(indices[j + offset * 2]);
    inc(face_index);
    j := j + data_offset;
  end;
  indices.Free;
end;

procedure TRenderBlock.ReplaceTextureCoords(FileName: string);
var
  D: TNativeXml;
  root, lib_geom, geom, meshNode, float_array: TXmlNode;
  i, j, k, l, count: integer;
  id, id2, id3: string;
  uvList: TStringList;
begin
  if mesh.TextCoord <> nil then
  begin
    D := TNativeXml.CreateName('COLLADA');
    D.LoadFromFile(FileName);
    root := D.Root;
    lib_geom := root.NodeByName('library_geometries');
    for i := 0 to lib_geom.NodeCount - 1 do
    begin
      geom := lib_geom.Nodes[i];
      if TypeName = geom.Attributes[1].Value then
      begin
        meshNode := geom.NodeByName('mesh');
        id := 'geom-' + TypeName + '-UV0';
        id2 := 'geom-' + TypeName + '-map1';
        for j := 0 to meshNode.NodeCount - 1 do
        begin
          if (id = meshNode.Nodes[j].Attributes[0].Value) or (id2 =
            meshNode.Nodes[j].Attributes[0].Value) then
          begin
            float_array := meshNode.Nodes[j].NodeByName('float_array');
            uvList := TStringList.Create;
            uvList.Delimiter := ' ';
            uvList.DelimitedText := float_array.Value;
            if id = meshNode.Nodes[j].Attributes[0].Value then
              for k := 0 to vertex_count - 1 do
              begin
                mesh.TextCoord[k][0] := strtofloat(uvList[k * 2]);
                mesh.TextCoord[k][1] := 1.0 - strtofloat(uvList[(k * 2) + 1]);
              end
            else
            begin
              for k := 0 to vertex_count - 1 do
              begin
                mesh.TextCoord[k][0] := strtofloat(uvList[k * 3]);
                mesh.TextCoord[k][1] := 1.0 - strtofloat(uvList[(k * 3) + 1]);
              end;
            end;
            uvList.Free;
            Break;
          end;
        end;
      end;
    end;
  end;

  //replace texture
 { if ntex > 0 then
  if ntex > 1 then
  begin
  end;
  if ntex > 2 then
  begin

  end;}
  D.Free;
end;

{ TSpBSP }

procedure TSpBSP.Read;
var
  i: integer;
begin
  num_faces := ReadDword;
  Leaf_list_size := ReadDword;
  BranchNum := ReadDword;
  SetLength(faces, num_faces);
  SetLength(Leaf_list, Leaf_list_size);
  SetLength(Branches, BranchNum);
  for i := 0 to num_faces - 1 do
  begin
    faces[i].flag := ReadDword;
    faces[i].offset := ReadFloat;
    faces[i].shape := ReadSPWord;
    faces[i].face := ReadSPWord;
  end;
  for i := 0 to Leaf_list_size - 1 do
    Leaf_list[i] := ReadDword;
  for i := 0 to BranchNum - 1 do
  begin
    Branches[i].flag := ReadDword;
    Branches[i].offset := ReadFloat;
    Branches[i].index := ReadDword;
  end;
end;

procedure TSpBSP.Write;
var
  i: integer;
begin
  inherited;
  WriteDword(num_faces);
  WriteDword(Leaf_list_size);
  WriteDword(BranchNum);
  for i := 0 to num_faces - 1 do
  begin
    WriteDword(faces[i].flag);
    WriteFloat(faces[i].offset);
    WriteSPWord(faces[i].shape);
    WriteSPWord(faces[i].face);
  end;
  for i := 0 to Leaf_list_size - 1 do
    WriteDword(Leaf_list[i]);
  for i := 0 to BranchNum - 1 do
  begin
    WriteDword(Branches[i].flag);
    WriteFloat(Branches[i].offset);
    WriteDword(Branches[i].index);
  end;
  CalcSize;
end;

procedure TSpBSP.AddBlock1Data(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Leaf [%d]', [i]), nil, BSPStruct);
  AddTreeData(Node2, 'Axis Aligment Flags', @faces[i].flag, BSPFAngle);
  AddTreeData(Node2, 'Dot Product', @faces[i].offset, BSPFloat);
  AddTreeData(Node2, 'Mat Block Index', @faces[i].shape, BSPSint);
  AddTreeData(Node2, 'Face Index', @faces[i].face, BSPSint);
end;

procedure TSpBSP.AddBlock2Data(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
begin
  AddTreeData(Node1, format('LeafList [%d]', [i]), @Leaf_list[i], BSPGroup);
end;

procedure TSpBSP.AddBlock3Data(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Branch [%d]', [i]), nil, BSPStruct);
  AddTreeData(Node2, 'Axis Aligment Flags', @Branches[i].flag, BSPFAngle);
  AddTreeData(Node2, 'Dot Product', @Branches[i].offset, BSPFloat);
  AddTreeData(Node2, 'Face Index', @Branches[i].index, BSPUint);
end;

procedure TSpBSP.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1, Node2: PVirtualNode;
  branch_nodes: array of PVirtualNode;
  Data: PPropertyData;
  i: integer;
  {  procedure AddBlockTree(index,object_type:Integer;Node:PVirtualNode);
    var NodeTemp:PVirtualNode;
    s:string;
    flags:Cardinal;
    branch_flags,leaf_flags,leafg_flags:byte;
    loop:boolean;
    Leaf_index: integer;
    begin
      ShowMessage('Object_type: ' + IntToStr(object_type) + ' index: ' + IntToStr(index) );
       case object_type of
       0://Brach
       begin
         flags:=Dword(@Branches[index].flag);
         branch_flags:=byte(Pointer(flags+3)^);
         s:=format('Branch [%d]',[index]);
         NodeTemp:=AddTreeData(Node,s,@Branches[index],BSPAngleBlock);
         if (branch_flags and $40) > 0 then
         begin
           AddBlockTree(Branches[index].index , 2 ,NodeTemp); //go to next branch
         end
         else
         if (branch_flags and $20) > 0 then
         begin
           AddBlockTree(Branches[index].index , 1 ,NodeTemp); //go to next branch
         end
         else
         begin
           AddBlockTree(Branches[index].index , 0 ,NodeTemp); //go to next branch
         end;
         if (branch_flags and $10) > 0 then
           AddBlockTree(Branches[index].index + 1 , 0 ,NodeTemp);
       end;
       1://FaceGroup
       begin
         s:=format('LeafGroup [%d]',[index]);
         NodeTemp:=AddTreeData(Node,s,@Branches[index],BSPAngleBlock);
         loop:= true;
         repeat
         leaf_index:= FaceGroup[index];
         if leaf_index < 0 then
         begin
           leaf_index:= leaf_index and $7FFFFFFF;
           loop:= false;
         end
         else
         begin
           AddBlockTree(leaf_index , 2 ,NodeTemp);
         end;
         until(loop);

       end;
       2://Leaf
       begin
         flags:=Dword(@Leafs[index].flag);
         leaf_flags:=byte(Pointer(flags+3)^);
         s:=format('Leaf [%d]',[index]);
         NodeTemp:=AddTreeData(Node,s,@Leafs[index],BSPAngleBlock);
       end;
    end;

    end; }
begin
  inherited;

  // AddTreeData(nil,'FaceGroupNum',@FaceGroupNum,BSPUint);
  //  AddTreeData(nil,'b3_num',@b3_num,BSPUint);
  //  AddTreeData(nil,'b1_num',@b1_num,BSPUint);

  Node1 := AddTreeData(nil, 'Faces', @num_faces, BSPArray);
  AddLoadingMore(Node1, num_faces, faces, AddBlock1Data);

  Node1 := AddTreeData(nil, 'Leaf List', @Leaf_list_size, BSPArray);
  AddLoadingMore(Node1, Leaf_list_size, 0, AddBlock2Data);

  Node1 := AddTreeData(nil, 'Branches', @BranchNum, BSPArray);
  AddLoadingMore(Node1, BranchNum, 0, AddBlock3Data);
  {
    Node1 := AddTreeData(nil, 'Root', nil, BSPArray);
    SetLength(branch_nodes,BranchNum);
    for i:=0 to BranchNum -1 do
    begin
      branch_nodes[i]:= AddTreeData(nil, format('Branch [%d]',[i]),@BranchNum, BSPArray);
    end;
  }

end;

procedure TSpBSP.Partition(world: TWorld; isOctree: Boolean);
var
  throttle_threshold: Integer;
begin
  if isOctree then
    throttle_threshold:= 200
  else
    throttle_threshold:= 2000;
end;

constructor TSpBSP.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Collision';
end;

destructor TSpBSP.Destroy;
begin
  SetLength(faces, 0);
  SetLength(Leaf_list, 0);
  SetLength(Branches, 0);
  inherited;
end;

function TSpBSP.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 5;
end;

function TSpBSP.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TSpBSP;
begin
  Chunk := TSpBSP(inherited CopyChunk(nBSP));
  Chunk.num_faces := num_faces;
  Chunk.Leaf_list_size := Leaf_list_size;
  Chunk.BranchNum := BranchNum;
  Chunk.faces := Copy(faces);
  Chunk.Leaf_list := Copy(Leaf_list);
  Chunk.Branches := Copy(Branches);
  Result := Chunk;
end;

{ TSectorOctree }

procedure TSectorOctree.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_SectorOctree;
  Version := 1698;

  mesh_num := 0;
  SetLength(mesh_list, mesh_num);

  sector_nums := 1;
  SetLength(sector_block, sector_nums);
  sector_block[0].flag := $FFFFFFFF;
  sector_block[0].is_mesh := 0;
  sector_block[0].mindex := 0;
  sector_block[0].val4 := 0;
  sector_block[0].val5 := 0;

  sbound_num := 1;
  SetLength(sbound_list, sbound_num);
  sbound_list[0].bound.min[1] := -100;
  sbound_list[0].bound.min[2] := -100;
  sbound_list[0].bound.min[3] := -100;
  sbound_list[0].bound.max[1] := 100;
  sbound_list[0].bound.max[2] := 100;
  sbound_list[0].bound.max[3] := 100;
  sbound_list[0].val1 := 0;
  sbound_list[0].is_sector := True;
  sbound_list[0].sector_index := 0;
end;

procedure TSectorOctree.Read;
var
  i: integer;
  mindex: integer;
  Models: AModels;
begin
  Models := BSP.World.ModelGroup.models;              
  mesh_num := ReadSPDword;
  SetLength(mesh_list, mesh_num);
  for i := 0 to mesh_num - 1 do
  begin
    mindex := ReadDword;
    mesh_list[i].mindex := mindex;
    if mindex = -1 then
      mesh_list[i].model := nil
    else
      mesh_list[i].model := Models[mindex];
  end;
  sector_nums := ReadDword;
  SetLength(sector_block, sector_nums);
  for i := 0 to sector_nums - 1 do
  begin
    sector_block[i].flag := ReadDword;
    sector_block[i].is_mesh := ReadSPDword;
    if sector_block[i].is_mesh <> 0 then
    begin
      mindex := ReadDword;
      sector_block[i].mindex := mindex;
      sector_block[i].mesh := mesh_list[mindex].model;
    end;
    sector_block[i].val4 := ReadDword;
    sector_block[i].val5 := ReadDword;
  end;
  sbound_num := ReadSPDword;
  SetLength(sbound_list, sbound_num);
  for i := 0 to sbound_num - 1 do
  begin
    sbound_list[i].bound := ReadBound;
    sbound_list[i].val1 := ReadDword;
    sbound_list[i].is_sector := Boolean(ReadDword);
    mindex := ReadDword;
    if sbound_list[i].is_sector then
      sbound_list[i].sector_index := mindex
        // sbound_list[i].sector:=@sector_block[mindex]
    else
      sbound_list[i].sbound_index := mindex
        // sbound_list[i].sbound:=@sector_block[mindex];
  end;
end;

procedure TSectorOctree.Write;
var
  i: integer;
  mindex: integer;
begin
  inherited;
  WriteSPDword(mesh_num);
  for i := 0 to mesh_num - 1 do
  begin
    WriteDword(mesh_list[i].mindex);
  end;
  WriteDword(sector_nums);
  for i := 0 to sector_nums - 1 do
  begin
    WriteDword(sector_block[i].flag);
    WriteSPDword(sector_block[i].is_mesh);
    if sector_block[i].is_mesh <> 0 then
    begin
      WriteDword(sector_block[i].mindex);
    end;
    WriteDword(sector_block[i].val4);
    WriteDword(sector_block[i].val5);
  end;
  WriteSPDword(sbound_num);
  for i := 0 to sbound_num - 1 do
  begin
    WriteBound(sbound_list[i].bound);
    WriteDword(sbound_list[i].val1);
    WriteBoolean(sbound_list[i].is_sector);
    if sbound_list[i].is_sector then
      mindex := sbound_list[i].sector_index
    else
      mindex := sbound_list[i].sbound_index;
    WriteDword(mindex);
  end;
  CalcSize;
end;

function TSectorOctree.GetMIndex(Model: TRenderBlock; Models: AModels): Integer;
var
  i: Integer;
begin
  Result := -1;
  if Model <> nil then
    for i := 0 to High(Models) do
    begin
      if Model = Models[i] then
      begin
        Result := i;
        Break;
      end;
    end;
end;

procedure TSectorOctree.AddMeshList(Node1: PVirtualNode; i: Integer; Parr:Pointer);
var
  Data: PPropertyData;
begin
  if mesh_list[i].model = nil then
    AddTreeData(Node1, format('Material Block Index [%d]', [i]), nil, BSPMesh, 'None')
  else
    AddTreeData(Node1, format('Material Block Index [%d]', [i]), nil, BSPMesh, mesh_list[i].model.TypeName)
end;

procedure TSectorOctree.AddSectorData(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Data: PPropertyData;
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Leaf [%d]', [i]), nil, BSPStruct);
  if sector_block[i].is_mesh <> 0 then
  begin
    Data := DataTree.GetNodeData(Node2);
    Data^.ValueIndex := 12;
    Data^.DValue := sector_block[i].mesh.TypeName;
  end;
  AddTreeData(Node2, 'Num World Blocks', @sector_block[i].is_mesh, BSPInt);
  AddTreeData(Node2, 'Sector Floor Flags', @sector_block[i].flag, BSPFloorFlags);
  // AddTreeData(Node2,'mesh',@sector_block[i].mesh,BSPDword);
  AddTreeData(Node2, 'Num Zones', @sector_block[i].val4, BSPUint);
  AddTreeData(Node2, 'Zone List', @sector_block[i].val5, BSPUint);
end;

procedure TSectorOctree.AddSBoundData(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Data: PPropertyData;
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Octant [%d]', [i]), nil, BSPStruct);
  AddBoundData(Node2, sbound_list[i].bound, 'World Bounds');
  AddTreeData(Node2, 'Flags', @sbound_list[i].val1, BSPDword);
  AddTreeData(Node2, 'Is Leaf', @sbound_list[i].is_sector, BSPBool);
  AddTreeData(Node2, 'Leaf Index', @sbound_list[i].sector_index, BSPUint);
  AddTreeData(Node2, 'Subtree Index', @sbound_list[i].sbound_index, BSPUint)
end;

procedure TSectorOctree.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1, Node2: PVirtualNode;
  Data: PPropertyData;
  i, pnum: integer;
  Debug: Boolean;
begin
  inherited;
  Debug := false;
  Node1 := AddTreeData(nil, 'Octree Block Lists', @mesh_num, BSPArray);
  AddLoadingMore(Node1, mesh_num, 0, AddMeshList);
  Node1 := AddTreeData(nil, 'Leaves', @sector_nums, BSPArray);
  AddLoadingMore(Node1, sector_nums, 0, AddSectorData);
  Node1 := AddTreeData(nil, 'Octants', @sbound_num, BSPArray);
  AddLoadingMore(Node1, sector_nums, 0, AddSBoundData);
end;

constructor TSectorOctree.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Sector Octree';
end;

destructor TSectorOctree.Destroy;
begin
  SetLength(sector_block, 0);
  SetLength(sbound_list, 0);
  SetLength(mesh_list, 0);
  inherited;
end;

function TSectorOctree.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 27;
end;

{ TSpNgonBSP }

procedure TSpNgonBSP.Read;
var
  i: integer;
begin
  script_type := ReadSPDword;
  num_block1 := ReadDword;
  SetLength(sblock1, num_block1);
  for i := 0 to num_block1 - 1 do
  begin
    sblock1[i].fl1 := ReadFloat;
    sblock1[i].fl2 := ReadFloat;
    sblock1[i].fl3 := ReadFloat;
    sblock1[i].fl4 := ReadFloat;
    if script_type > 0 then
    begin
      sblock1[i].index1 := ReadDword;
      sblock1[i].index2 := ReadDword;
    end
    else
    begin
      sblock1[i].index1 := ReadDword;
      sblock1[i].val1 := ReadDword;
      sblock1[i].index2 := ReadDword;
      sblock1[i].val2 := ReadDword;
    end;
  end;
  num_block2 := ReadDword;
  SetLength(sblock2, num_block2);
  for i := 0 to num_block2 - 1 do
    sblock2[i] := ReadDword;

  hasNgonList := Boolean(ReadDword);
  if hasNgonList then
    NgonList := TSpNgonList(BSP.ReadBSPChunk);
end;

procedure TSpNgonBSP.Write;
var
  i: integer;
begin
  inherited;
  WriteSPDword(script_type);
  WriteDword(num_block1);
  for i := 0 to num_block1 - 1 do
  begin
    WriteFloat(sblock1[i].fl1);
    WriteFloat(sblock1[i].fl2);
    WriteFloat(sblock1[i].fl3);
    WriteFloat(sblock1[i].fl4);
    if script_type > 0 then
    begin
      WriteDword(sblock1[i].index1);
      WriteDword(sblock1[i].index2);
    end
    else
    begin
      WriteDword(sblock1[i].index1);
      WriteDword(sblock1[i].val1);
      WriteDword(sblock1[i].index2);
      WriteDword(sblock1[i].val2);
    end;
  end;
  WriteDword(num_block2);
  for i := 0 to num_block2 - 1 do
    WriteDword(sblock2[i]);

  WriteBoolean(hasNgonList);
  CalcSize;
  if hasNgonList then
    BSP.WriteBSPChunk(NgonList);
end;

procedure TSpNgonBSP.AddBlock1Data(Node1: PVirtualNode; i: Integer; Parr: Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Branch [%d]', [i]), nil, BSPStruct);
  AddTreeData(Node2, 'Plane', @sblock1[i].fl1, BSPVect4);
  AddTreeData(Node2, 'Negation Leaf', @sblock1[i].index1, BSPUint);
  AddTreeData(Node2, 'Negation', @sblock1[i].val1, BSPUint);
  AddTreeData(Node2, 'Position Leaf', @sblock1[i].index1, BSPUint);
  AddTreeData(Node2, 'Position', @sblock1[i].val2, BSPUint);
end;

procedure TSpNgonBSP.AddBlock2Data(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
begin
  AddTreeData(Node1, format('Face List [%d]', [i]), @sblock2[i], BSPUint);
end;

procedure TSpNgonBSP.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1, Node2: PVirtualNode;
begin
  inherited;
  AddTreeData(nil, 'Plane BSP', @script_type, BSPDword);
  Node1 := AddTreeData(nil, 'Branches', @num_block1, BSPArray);
  AddLoadingMore(Node1, num_block1, 0, AddBlock1Data);
  Node1 := AddTreeData(nil, 'Face Lists', @num_block2, BSPArray);
  AddLoadingMore(Node1, num_block2, 0, AddBlock2Data);
  Node1 := AddTreeData(nil, 'Ngon List', @hasNgonList, BSPChBool);
  if hasNgonList then
    ValueIndex(Node1, 30);
end;

constructor TSpNgonBSP.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'NgonBSP';
end;

destructor TSpNgonBSP.Destroy;
begin
  SetLength(sblock1, 0);
  SetLength(sblock2, 0);
  if NgonList <> nil then
    FreeAndNil(NgonList);
  inherited;
end;

function TSpNgonBSP.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 26;
  //Result.CheckType:=ctTriStateCheckBox;
  //Result.CheckState:=csCheckedNormal;
  if hasNgonList then
    NgonList.AddClassNode(TreeView, Result);
end;

function TSpNgonBSP.GetMesh: TMesh;
begin
  Result := nil;
  if NgonList <> nil then
    Result := NgonList.GetMesh;
end;

procedure TSpNgonBSP.DeleteChild(Chunk: TChunk);
begin
  if Chunk is TSpNgonList then
  begin
    hasNgonList := false;
    FreeAndNil(NgonList);
  end;
end;

function TSpNgonBSP.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TSpNgonBSP;
  i: integer;
begin
  Chunk := TSpNgonBSP(inherited CopyChunk(nBSP));
  Chunk.script_type := script_type;
  Chunk.num_block1 := num_block1;
  Chunk.sblock1 := Copy(sblock1);
  Chunk.num_block2 := num_block2;
  Chunk.sblock2 := Copy(sblock2);
  hasNgonList := hasNgonList;
  if hasNgonList then
    Chunk.NgonList := TSpNgonList(NgonList.CopyChunk(nBSP));
  Result := Chunk;
end;

{ TSpNgonList }

procedure TSpNgonList.Read;
var
  i, f, n: integer;
begin
  num_vblock := ReadDword;
  SetLength(vblock, num_vblock);
  SetLength(Mesh.Vert, num_vblock);
  num_sblock := ReadSPDword;
  SetLength(sblock, num_sblock);
  SetLength(Mesh.Face, num_sblock);
  Mesh.InitSizeBox; //
  for i := 0 to num_vblock - 1 do
  begin
    vblock[i].vect := ReadVec3f4;
    Move(vblock[i].vect[1], Mesh.Vert[i][0], 12);
    Mesh.CalcSizeBox(Mesh.Vert[i]);
    vblock[i].fl1 := ReadFloat;
    vblock[i].fl2 := ReadFloat;
    vblock[i].fl3 := ReadFloat;
    vblock[i].fl4 := ReadFloat;
  end;
  for i := 0 to num_sblock - 1 do
  begin
    sblock[i].fl1 := ReadFloat;
    sblock[i].fl2 := ReadFloat;
    sblock[i].fl3 := ReadFloat;
    sblock[i].fl4 := ReadFloat;
    sblock[i].offset := ReadDword;
    Mesh.Face[i][3] := sblock[i].offset;
    sblock[i].size := ReadDword;
    n := sblock[i].size;
    if n > 4 then
      n := 4;
    for f := 0 to n - 1 do
      Mesh.Face[i][f] := sblock[i].offset + f;
    sblock[i].unkn := ReadDword;
  end;
end;

procedure TSpNgonList.Write;
var
  i: integer;
begin
  inherited;
  WriteDword(num_vblock);
  WriteSPDword(num_sblock);
  for i := 0 to num_vblock - 1 do
  begin
    WriteVec3f4(vblock[i].vect);
    WriteFloat(vblock[i].fl1);
    WriteFloat(vblock[i].fl2);
    WriteFloat(vblock[i].fl3);
    WriteFloat(vblock[i].fl4);
  end;
  for i := 0 to num_sblock - 1 do
  begin
    WriteFloat(sblock[i].fl1);
    WriteFloat(sblock[i].fl2);
    WriteFloat(sblock[i].fl3);
    WriteFloat(sblock[i].fl4);
    WriteDword(sblock[i].offset);
    WriteDword(sblock[i].size);
    WriteDword(sblock[i].unkn);
  end;
  CalcSize;
end;

procedure TSpNgonList.AddBlock1Data(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Vertex [%d]', [i]), nil, BSPStruct);
  AddTreeData(Node2, 'Vertex', @vblock[i].vect, BSPVect);
  AddTreeData(Node2, 'Edge Plane', @vblock[i].fl1, BSPVect4);
end;

procedure TSpNgonList.AddBlock2Data(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Face [%d]', [i]), nil, BSPStruct);
  AddTreeData(Node2, 'Face Plane', @sblock[i].fl1, BSPVect4);
  AddTreeData(Node2, 'Vertex Index', @sblock[i].offset, BSPUint);
  AddTreeData(Node2, 'Num Vertices', @sblock[i].size, BSPUint);
  AddTreeData(Node2, 'Flags', @sblock[i].unkn, BSPDword);
end;

procedure TSpNgonList.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1, Node2: PVirtualNode;
begin
  inherited;
  Node1 := AddTreeData(nil, 'Vertices', @num_vblock, BSPArray);
  AddLoadingMore(Node1, num_vblock, 0, AddBlock1Data);
  Node2 := AddTreeData(nil, 'Faces', @num_sblock, BSPArray);
  AddLoadingMore(Node2, num_sblock, 0, AddBlock2Data);
end;

constructor TSpNgonList.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'NgonList';
  Mesh := TMesh.Create;
  Mesh.XType := 'CL';
end;

destructor TSpNgonList.Destroy;
begin
  Mesh.Clear;
  SetLength(vblock, 0);
  SetLength(sblock, 0);
  inherited;
end;

function TSpNgonList.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 30;
  CheckHide(Result);
end;

function TSpNgonList.GetMesh: TMesh;
begin
  Result := Mesh;
end;

procedure TSpNgonList.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csUncheckedNormal;
  mesh.Hide := not But.NgonBSP^;
  if But.NgonBSP^ then
    ANode.CheckState := csCheckedNormal;
end;

procedure TSpNgonList.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

function TSpNgonList.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TSpNgonList;
  i, f, n: integer;
begin
  Chunk := TSpNgonList(inherited CopyChunk(nBSP));
  Chunk.Mesh := TMesh.Create;
  Chunk.Mesh.XType := 'CL';

  Chunk.num_vblock := num_vblock;
  Chunk.vblock := Copy(vblock);
  Chunk.Mesh.Vert := Copy(Mesh.Vert);
  Chunk.num_sblock := num_sblock;
  Chunk.sblock := Copy(sblock);
  Chunk.Mesh.Face := Copy(Mesh.Face);
  Chunk.Mesh.SizeBox := Mesh.SizeBox;

  Result := Chunk;
end;

{ TNullNodes }

procedure TNullNodes.Read;
var
  i: integer;
begin
  num := ReadSPDword;
  SetLength(WpPoints, num);
  for i := 0 to num - 1 do
  begin
    WpPoints[i] := TSpNullNode.Create;
    WpPoints[i].ID := GlobalID;
    Inc(GlobalID);
    WpPoints[i].Read(self);
  end;
end;

procedure TNullNodes.Write;
var
  i: integer;
begin
  inherited;
  num := Length(WpPoints);
  WriteSPDword(num);
  for i := 0 to num - 1 do
  begin
    WpPoints[i].Write(self);
  end;
  CalcSize;
end;

procedure TNullNodes.AddNullNodeData(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('NullNode [%d]', [i]), nil, BSPStruct,
    WpPoints[i].name);
end;

procedure TNullNodes.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1, Node2: PVirtualNode;
begin
  inherited;

  Node1 := AddTreeData(nil, 'NullNodes', @num, BSPArray);
  AddLoadingMore(Node1, num, 0, AddNullNodeData);
end;

constructor TNullNodes.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'NullNodes';
  Mesh := TMesh.Create;
end;

destructor TNullNodes.Destroy;
var
  i: integer;
begin
  Mesh.Clear;
  for i := 0 to num - 1 do
    FreeAndNil(WpPoints[i]);
  SetLength(WpPoints, 0);
  inherited;
end;

function TNullNodes.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: Integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 5;
  CheckHide(Result);
  for x := 0 to Num - 1 do
    WpPoints[x].AddClassNode(TreeView, Result);

end;

function TNullNodes.GetMesh: TMesh;
var
  i: Integer;
begin
  Result := mesh;
  Mesh.ResetChilds(num);
  for i := 0 to num - 1 do
    Mesh.childs[i] := WpPoints[i].GetMesh;
end;

procedure TNullNodes.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csUncheckedNormal;
  mesh.Hide := not But.NullNodes^;
  if But.NullNodes^ then
    ANode.CheckState := csCheckedNormal
end;

procedure TNullNodes.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

procedure TNullNodes.DeleteChild(Chunk: TChunk);
var
  Wpoint: TSpNullNode;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TSpNullNode then
  begin
    Wpoint := TSpNullNode(Chunk);
    Dec(Num);
    MoveIndex := False;
    for i := 0 to num do
    begin
      if MoveIndex then
        WpPoints[i - 1] := WpPoints[i];
      if WpPoints[i] = Wpoint then
        MoveIndex := true;
    end;
    SetLength(WpPoints, Num);
    Wpoint.Destroy;
  end;
end;

procedure TNullNodes.InsertChild(Target, Chunk: TChunk);
var
  i: integer;
  Wpoint: TSpNullNode;
begin
  if Chunk is TSpNullNode then
  begin
    Inc(Num);
    Wpoint := TSpNullNode(Target);
    SetLength(WpPoints, Num);
    for i := num - 2 downto 0 do
    begin
      if WpPoints[i] = Wpoint then
      begin
        WpPoints[i + 1] := TSpNullNode(Chunk);
        break;
      end;
      WpPoints[i + 1] := WpPoints[i];
    end;
  end;
end;

function CompareWpPoint(Item1, Item2: Pointer): Integer;
begin
  Result := CompareValue(Int64(TSpNullNode(Item1^).hash),
    Int64(TSpNullNode(Item2^).hash));
end;

procedure TNullNodes.SorTNullNodes;
var
  SortList: TList;
  newNullNodes: ANullNodes;
  i, wpLen: integer;
begin
  SortList := TList.Create;
  wpLen := Length(WpPoints);
  for i := 0 to wpLen - 1 do
  begin
    SortList.Add(@WpPoints[i]);
  end;
  SortList.Sort(@CompareWpPoint);
  SetLength(newNullNodes, wpLen);
  for i := 0 to wpLen - 1 do
  begin
    newNullNodes[i] := TSpNullNode(SortList[i]^);
  end;
  Self.WpPoints := newNullNodes;
  SortList.Free;
end;

{ TZones }

procedure TZones.Read;
var
  i: Integer;
  zoneobj: TZoneObj;
begin
  num_list := ReadSPDword;
  SetLength(list_zones, num_list);
  for i := 0 to num_list - 1 do
    list_zones[i] := ReadDword;
  if num_list > 0 then
  begin
    SetLength(zones, BSP.World.NumZones);
    for i := 0 to BSP.World.NumZones - 1 do
    begin //  BSP.World.chunk1023_count
      zoneobj := TZoneObj.Create;
      zoneobj.ID := GlobalID;
      Inc(GlobalID);
      zoneobj.Read(self);
      zones[i] := zoneobj;
      zones[i].idx := i; //list_zones[i];
    end;
  end;
  // CheckSize;
end;

procedure TZones.Write;
var
  i: Integer;
begin
  inherited;
  WriteSPDword(num_list);
  for i := 0 to num_list - 1 do
    WriteDword(list_zones[i]);
  if num_list > 0 then
  begin
    for i := 0 to BSP.World.NumZones - 1 do //  BSP.World.chunk1023_count
      zones[i].Write(self);
    CalcSize;
    for i := 0 to BSP.World.NumZones - 1 do
      zones[i].WriteChilds(self);
  end;
end;

procedure TZones.AddChunkBlockData(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
begin
  AddTreeData(Node1, format('Zone [%d]', [i]), nil, BSPStruct);
end;

procedure TZones.AddFields(CustomTree: TCustomVirtualStringTree);
var
  num: integer;
  Node1: PVirtualNode;
begin
  inherited;
  Node1 := AddTreeData(nil, 'Zone Octant Connections', @num_list, BSPArray);
  AddLoadingMore(Node1, num_list, 0, AddListData);
  num := Length(zones);
  Node1 := AddTreeData(nil, 'Zones', @num, BSPArray);
  AddLoadingMore(Node1, num, 0, AddChunkBlockData);
end;

procedure TZones.AddListData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
begin
  AddTreeData(Node1, format('Zone Octant Connection [%d]', [i]), @list_zones[i], BSPUint);
end;

constructor TZones.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Zones';
  Mesh := TMesh.Create;
  Mesh.XType := 'ZS';
end;

destructor TZones.Destroy;
var
  i: Integer;
begin
  SetLength(list_zones, 0);
  Mesh.Clear;
  if Length(zones) > 0 then
  begin
    for i := 0 to High(zones) do
    begin
      FreeAndNil(zones[i]);
    end;
  end;
  SetLength(zones, 0);

  inherited;
end;

function TZones.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 29;
  Result.CheckType := ctTriStateCheckBox;
  Result.CheckState := csCheckedNormal;
  for x := 0 to High(zones) do
    zones[x].AddClassNode(TreeView, Result);
end;

function TZones.GetMesh: TMesh;
var
  i: integer;
begin
  Result := Mesh;
  Mesh.ResetChilds(Length(Zones));
  for i := 0 to High(zones) do
    Mesh.childs[i] := Zones[i].GetMesh;
end;

procedure TZones.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

procedure TZones.DeleteChild(Chunk: TChunk);
var
  Zone: TZoneObj;
  i, l, n: integer;
  MoveIndex: boolean;
  new_list: Alist;
begin
  if Chunk is TZoneObj then
  begin
    Zone := TZoneObj(Chunk);
    Dec(BSP.World.NumZones);
    MoveIndex := False;
    for i := 0 to BSP.World.NumZones do
    begin
      if MoveIndex then
        zones[i - 1] := zones[i];
      if zones[i] = Zone then
      begin
        MoveIndex := true;
        l := i;
      end;
    end;
    SetLength(zones, BSP.World.NumZones);
    Zone.Destroy;
    // LINK list_zones
    SetLength(new_list, num_list);
    n := 0;
    for i := 0 to num_list - 1 do
    begin
      if list_zones[i] = l then
        Continue;
      new_list[n] := list_zones[i];
      Inc(n);
    end;
    num_list := n;
    list_zones := new_list;
    SetLength(new_list, 0);
  end;
end;

procedure TZones.InsertChild(Target, Chunk: TChunk);
var
  i, l: integer;
  Zone: TZoneObj;
  new_index: AList;
begin
  if Chunk is TZoneObj then
  begin
    Inc(BSP.World.NumZones);
    Zone := TZoneObj(Target);
    SetLength(Zones, BSP.World.NumZones);
    for i := BSP.World.NumZones - 2 downto 0 do
    begin
      if Zones[i] = Zone then
      begin
        Zones[i + 1] := TZoneObj(Chunk);
        Zones[i + 1].idx := i + 1;
        l := i;
        break;
      end;
      Zones[i + 1] := Zones[i];
      Zones[i + 1].Data^.Name := Format('Zone [%d]', [i + 1]);
    end;
  end;
  // LINK list_zones
  inc(num_list);
  SetLength(list_zones, num_list);
  for i := num_list - 2 downto 0 do
  begin
    if list_zones[i] < l + 1 then
    begin
      list_zones[i + 1] := l + 1;
      Break;
    end;
    list_zones[i + 1] := list_zones[i] + 1;
  end;

end;

{ TSpline }

procedure TSpline.Read;
var
  i: Integer;
begin
  num_vect := ReadDword;
  val1 := ReadSPDword;
  val2 := ReadDword;
  SetLength(vectors, num_vect);
  for i := 0 to num_vect - 1 do
  begin
    vectors[i] := ReadVec3f4;
  end;
end;

procedure TSpline.Write;
var
  i: Integer;
begin
  inherited;
  WriteDword(num_vect);
  WriteSPDword(val1);
  WriteDword(val2);
  for i := 0 to num_vect - 1 do
  begin
    WriteVec3f4(vectors[i]);
  end;
  CalcSize;
end;

procedure TSpline.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1: PVirtualNode;
begin
  inherited;
  // AddTreeData(nil,'num_vect',@num_vect,BSPDword);
  AddTreeData(nil, 'Closed', @val1, BSPDword);
  AddTreeData(nil, 'Type', @val2, BSPDword);
  Node1 := AddTreeData(nil, 'Waypoints', @num_vect, BSPArray);
  AddLoadingMore(Node1, num_vect, 0, AddVectData);
end;

procedure TSpline.AddVectData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
begin
  AddTreeData(Node1, format('Waypoint[%d]', [i]), @vectors[i], BSPVect);
end;

function TSpline.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 24;
end;

constructor TSpline.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Area';
end;

destructor TSpline.Destroy;
begin
  SetLength(vectors, 0);
  inherited;
end;

function TSpline.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TSpline;
begin
  Chunk := TSpline(inherited CopyChunk(nBSP));
  Chunk.num_vect := num_vect;
  Chunk.val1 := val1;
  Chunk.val2 := val2;
  Chunk.vectors := Copy(vectors);
  Result := Chunk;
end;

{ TWaypointMap }

procedure TWaypointMap.Read;
var
  i, n, mesh_index: integer;
begin
  num_graph := ReadSPDword;
  val_graph := ReadSPDword;
  SetLength(graph, num_graph);
  SetLength(Mesh.Vert, num_graph);
  SetLength(Mesh.Face, num_graph * 100);
  for i := 0 to num_graph - 1 do
  begin
    graph[i].vect := ReadVec3f4;
    Mesh.Vert[i][0] := graph[i].vect[1];
    Mesh.Vert[i][1] := graph[i].vect[2] + 0.1;
    Mesh.Vert[i][2] := graph[i].vect[3];
    graph[i].val := ReadDword;
    Mesh.CalcSizeBox(Mesh.Vert[i]);
  end;
  n := 0;
  for i := 0 to num_graph - 1 do
  begin
    mesh_index := ReadDword;
    Mesh.face[n][0] := mesh_index;
    Mesh.face[n][1] := i;
    while mesh_index <> -1 do
    begin
      graph[mesh_index].mesh_mask := ReadDword;
      Mesh.face[n][2] := graph[mesh_index].mesh_mask;
      mesh_index := ReadDword;
      Inc(n);
      Mesh.face[n][0] := mesh_index;
      Mesh.face[n][1] := i;
    end;
    Inc(n);
  end;
  SetLength(Mesh.Face, n);
  // CheckSize;
end;

procedure TWaypointMap.Write;
var
  i, n, mesh_index, mesh_mask: integer;
begin
  inherited;
  WriteSPDword(num_graph);
  WriteSPDword(val_graph);
  for i := 0 to num_graph - 1 do
  begin
    WriteVec3f4(graph[i].vect);
    WriteDword(graph[i].val);
  end;
  n := High(Mesh.face);
  for i := 0 to n do
  begin
    mesh_index := SmallInt(Mesh.face[i][0]);
    WriteDword(mesh_index);
    if SmallInt(Mesh.face[i][0]) <> -1 then
    begin
      mesh_mask := SmallInt(Mesh.face[i][2]);
      WriteDword(mesh_mask);
    end;
  end;
  CalcSize;
end;

procedure TWaypointMap.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1: PVirtualNode;
begin
  inherited;
  //AddTreeData(nil, 'Num Waypoints', @num_graph, BSPUint);
  Node1 := AddTreeData(nil, 'Waypoints', @num_graph, BSPArray);
  AddLoadingMore(Node1, num_graph, 0, AddGraphData);
  AddTreeData(nil, 'Num Links', @val_graph, BSPUint);

end;

procedure TWaypointMap.AddGraphData(Node1: PVirtualNode; i: Integer; Parr:
  Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Waypoint [%d]', [i]), nil, BSPStruct);
  AddTreeData(Node2, 'Position', @graph[i].vect, BSPVect);
  AddTreeData(Node2, 'Flags', @graph[i].val, BSPDword);
  AddTreeData(Node2, 'Link Flags', @graph[i].mesh_mask, BSPDword);
end;

constructor TWaypointMap.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'WaypointMap';
  Mesh := TMesh.Create;
  Mesh.XType := 'NM';
end;

destructor TWaypointMap.Destroy;
begin
  SetLength(graph, 0);
  Mesh.Clear;
  inherited;
end;

function TWaypointMap.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 21;
  Result.CheckType := ctTriStateCheckBox;
  Result.CheckState := csCheckedNormal;
end;

function TWaypointMap.GetMesh: TMesh;
begin
  Result := Mesh;
end;

procedure TWaypointMap.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

{ TAtomicObj }

procedure TAtomicObj.Read;
begin
  atomic_type := ReadDword;
end;

procedure TAtomicObj.Write;
begin
  inherited;
  WriteDword(atomic_type);
end;

procedure TAtomicObj.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
  AddTreeData(nil, 'Atomic Type', @atomic_type, BSPUint);
end;

constructor TAtomicObj.Create(Chunk: TChunk);
begin
  inherited;
end;

destructor TAtomicObj.Destroy;
begin

  inherited;
end;

function TAtomicObj.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TAtomicObj;
begin
  Chunk := TAtomicObj(inherited CopyChunk(nBSP));
  Chunk.atomic_type := atomic_type;
  Result := Chunk;
end;

{ TClump }

function TClump.GetBoneIndex(Hash: Cardinal): Integer;
var
  len, i: Integer;
begin
  Result := -1;
  len := Length(BoneLib);
  for i := 0 to len - 1 do
    if BoneLib[i].hash = Hash then
    begin
      Result := i;
      exit;
    end;
end;

procedure TClump.AddBone(Bone: TSpFrame);
var
  i: Integer;
begin
  i := GetBoneIndex(Bone.hash);
  if i <> -1 then
  begin
    BoneLib[i].Bone := Bone.mesh;
    BoneLib[i].Bone.InvBoneMatrix := BoneLib[i].matrix;
  end;
end;

procedure TCLump.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_Clump;
  Version := 1698;
  BSP.LastClump := Self;
end;

procedure TCLump.AddClump(e_type: Cardinal; node: TXmlNode);
var
  root_frame: TSpFrame;

  procedure SetMatrixFromNode(var matrix: TMatrix; bind_poses: TStringList;
    bone_index: Cardinal);
  var
    i, j, index: integer;
  begin
    for j := 0 to 3 do
      for i := 0 to 3 do
      begin
        index := (j * 4) + i;
        matrix[i + 1][j + 1] := StrToFloat(bind_poses[bone_index * 16 + index]);
      end;
  end;

  procedure MapSkinBones;
  var
    library_controller, name_array, node_skin, bind_poses: TXmlNode;
    lbind_poses, l_joints: TStringList;
    ii, jj, kk, joint_index: integer;
  begin
    num_bones := 500; //max bones
    SetLength(bone_hashes, num_bones);
    SetLength(bone_matrix, num_bones);
    SetLength(BoneLib, num_bones);

    DaeSkinBones.Delimiter := ' ';
    DaeSkinBones.Duplicates := dupIgnore;
    library_controller := DaeRoot.NodeByName('library_controllers');
    if library_controller <> nil then
    begin
      if library_controller.ElementCount > 0 then
      begin
        mask := mask or $C0;
        for jj := 0 to library_controller.ElementCount - 1 do
        begin
          node_skin := library_controller.Elements[jj].NodeByName('skin');
          name_array := node_skin.Elements[1].NodeByName('Name_array');
          bind_poses := node_skin.Elements[2].NodeByName('float_array');
          lbind_poses := TStringList.Create;
          lbind_poses.Delimiter := ' ';
          lbind_poses.DelimitedText := bind_poses.Value;
          l_joints := TStringList.Create;
          l_joints.Delimiter := ' ';
          l_joints.DelimitedText := name_array.Value;
          for kk := 0 to l_joints.Count - 1 do
          begin
            if DaeSkinBones.IndexOf(l_joints[kk]) = -1 then //we have a new bone
            begin
              DaeSkinBones.Add(l_joints[kk]);
              joint_index := DaeSkinBones.Count - 1;
              SetMatrixFromNode(bone_matrix[joint_index].m, lbind_poses, kk);
            end;
          end;
          lbind_poses.Free;
          l_joints.Free;
        end;
        //Set new size
        num_bones := DaeSkinBones.Count;
        SetLength(bone_hashes, num_bones);
        SetLength(bone_matrix, num_bones);
        SetLength(BoneLib, num_bones);
      end
      else
        mask := mask or $8; //No Skin mask
    end
    else
    begin
      mask := mask or $8;
    end;
  end;

begin
  atomic_type := 4;
  hash := 0;
  mask := $0000000002000000;
  floor_flag := 1;
  mesh.floors := floor_flag;
  default_animation := 0;
  render_mirrors := false;
  has_root := node <> nil;
  if has_root then
  begin
    MapSkinBones();
    root_frame := TSpFrame.Create(nil);
    root_frame.MakeDefault(BSP);
    root_frame.AddFrame(node, nil);
    Root := root_frame;
  end;

end;

procedure TClump.Read;
var
  i: Integer;
begin
  inherited;
  BSP.LastClump := Self;
  hash := ReadDword;
  mask := ReadDouble;
  if (Version = 1696) or (Version = 1695) or (Version = 1693) then
  begin
    floor_flag := 15;
  end
  else
  begin
    floor_flag := ReadDword;
  end;
  mesh.floors := floor_flag;
  num_bones := ReadDword;
  SetLength(bone_hashes, num_bones);
  SetLength(bone_matrix, num_bones);
  SetLength(BoneLib, num_bones);
  for i := 0 to num_bones - 1 do
    bone_hashes[i] := ReadDword;
  for i := 0 to num_bones - 1 do
  begin
    bone_matrix[i] := ReadMxBlock;
    BoneLib[i].hash := bone_hashes[i];
    BoneLib[i].matrix := bone_matrix[i].m;
    BoneLib[i].index := i;
  end;
  has_root := Boolean(ReadDword);
  default_animation := ReadDword;
  if Version = 1693 then
  begin
    render_mirrors := false;
  end
  else
  begin
    render_mirrors := Boolean(ReadDword);
  end;
  if render_mirrors then
  begin
    bbox := ReadBound;
    vect1 := ReadVec3f4;
    vect2 := ReadVec3f4;
  end;
  if has_root then
    Root := TSpFrame(BSP.ReadBSPChunk);
end;

procedure TClump.Write;
var
  i: Integer;
begin
  inherited;
  WriteDword(hash);
  WriteDouble(mask);
  WriteDword(floor_flag);
  WriteDword(num_bones);
  for i := 0 to num_bones - 1 do
    WriteDword(bone_hashes[i]);
  for i := 0 to num_bones - 1 do
  begin
    WriteMxBlock(bone_matrix[i]);
  end;
  WriteBoolean(has_root);
  WriteDword(default_animation);
  WriteBoolean(render_mirrors);
  if render_mirrors then
  begin
    WriteBound(bbox);
    WriteVec3f4(vect1);
    WriteVec3f4(vect2);
  end;
  CalcSize;
  if has_root then
    BSP.WriteBSPChunk(Root);
end;

procedure TClump.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1, NodeBBox: PVirtualNode;
  Data: PPropertyData;
begin
  inherited;
  AddTreeData(nil, 'Name Hash', @hash, BSPHash);
  AddTreeData(nil, 'Flags', @mask, BSPClumpFlag);
  AddTreeData(nil, 'Floor Flags', @floor_flag, BSPDword);
  Node1 := AddTreeData(nil, 'Inverted Base Poses', @num_bones, BSPArray);
  AddLoadingMore(Node1, num_bones, 0, AddBoneData);
  Node1 := AddTreeData(nil, 'Hierarchy', @has_root, BSPChBool);
  if has_root then
    ValueIndex(Node1, 5);
  AddTreeData(nil, 'Default Anim Hash', @default_animation, BSPRefHash);
  Node1 := AddTreeData(nil, 'Mirror Data', @render_mirrors, BSPBool);
  if render_mirrors then
  begin
    ValueIndex(Node1, 17);
    AddBoundData(Node1, bbox);
    AddTreeData(Node1, 'Reflection Plane Normal', @vect1, BSPVect);
    AddTreeData(Node1, 'Reflection Plane Pop', @vect2, BSPVect);
  end;
end;

procedure TClump.AddBoneData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
var
  Node2: PVirtualNode;
  Data: PPropertyData;
begin
  Node2 := AddTreeData(Node1, format('bone [%d]', [i]), nil, BSPStruct,
    bonelib[i].Bone.Name);
  ValueIndex(Node2, 10);
  AddTreeData(Node2, 'Hash', @bone_hashes[i], BSPRefHash);
  AddMatrixData(Node2, 'Inv Bone Matrix', 'Trans Inv Bone matrix',
    bone_matrix[i]);
end;

constructor TClump.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Clump';
  mesh := TMesh.Create;
  mesh.XType := 'SK';
end;

destructor TClump.Destroy;
var
  i: Integer;
begin
  SetLength(bone_hashes, 0);
  SetLength(bone_matrix, 0);
  SetLength(BoneLib, 0);
  for i := 0 to High(BoneLib) do
    FreeAndNil(BoneLib[i]);
  if Root <> nil then
    FreeAndNil(Root);
  Mesh.Clear;
  inherited;
end;

function TClump.GetBoneList: AMesh;
var
  len, i: Integer;
begin
  len := Length(BoneLib);
  SetLength(Result, 0);
  SetLength(Result, len);
  for i := 0 to len - 1 do
    Result[i] := BoneLib[i].Bone;
end;

function TClump.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  CheckHide(Result);
  Data^.ImageIndex := 13;
  Data^.Hash := Format('[%.*x]', [8, hash]);
  if Root <> nil then
    Root.AddClassNode(TreeView, Result);
end;

function TClump.GetMesh: TMesh;
begin
  Result := mesh;
  if Root <> nil then
  begin
    Mesh.ResetChilds(1);
    BSP.BSPList.BoneList := GetBoneList;
    Mesh.childs[0] := Root.GetMesh;
  end;
end;

procedure TClump.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csCheckedNormal;
  {   if floor_flag=$00008000 then begin
       ANode.CheckState:=csUncheckedNormal;
       mesh.Hide:=not But.BaseMask^;
       if But.BaseMask^ then
          ANode.CheckState:=csCheckedNormal
     end; }
  if TypeName = 'Ward' then
  begin
    ANode.CheckState := csUncheckedNormal;
    mesh.Hide := not But.WardZone^;
    if But.WardZone^ then
      ANode.CheckState := csCheckedNormal
  end;
  if render_mirrors then
  begin
    ANode.CheckState := csUncheckedNormal;
    mesh.Hide := not But.Mirror^;
    if But.Mirror^ then
      ANode.CheckState := csCheckedNormal
  end;
end;

procedure TClump.DeleteChild(Chunk: TChunk);
begin
  if Chunk is TSpFrame then
  begin
    has_root := false;
    num_bones := 0;
    SetLength(bone_hashes, num_bones);
    SetLength(bone_matrix, num_bones);
    SetLength(BoneLib, num_bones);
    FreeAndNil(Root);
  end;
end;

function CompareFrameHash(Item1, Item2: Pointer): Integer;
begin
  Result := CompareValue(Int64(TFrame(Item1^).Hash),
    Int64(TFrame(Item2^).Hash));
end;

function TClump.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TClump;
  i: Integer;
  nAnimDictionary: TAnimDictionary;
  nDictAnim: TDictAnim;
  nNames: TStringList;
  nBindPoses: TList;
  nBindPoseSize: Cardinal;
  nFrames: AFrames;
begin
  Chunk := TClump(inherited CopyChunk(nBSP));
  Chunk.mesh := TMesh.Create;
  Chunk.mesh.XType := 'SK';
  if nBSP = nil then
    BSP.LastClump := Chunk
  else
    nBSP.LastClump := Chunk;
  Chunk.hash := hash;
  Chunk.mask := mask;
  Chunk.floor_flag := floor_flag;
  Chunk.mesh.floors := floor_flag;
  Chunk.num_bones := num_bones;
  Chunk.bone_hashes := Copy(bone_hashes);
  SetLength(Chunk.bone_matrix, num_bones);
  SetLength(Chunk.BoneLib, num_bones);
  for i := 0 to num_bones - 1 do
  begin
    Chunk.bone_matrix[i] := bone_matrix[i];
    Chunk.BoneLib[i].hash := bone_hashes[i];
    Chunk.BoneLib[i].matrix := bone_matrix[i].m;
    Chunk.BoneLib[i].index := i;
  end;
  Chunk.has_root := has_root;
  Chunk.default_animation := default_animation;
  if (nBSP <> nil) and (default_animation > 0) then
  begin
    if nBSP.AnimLib = nil then
    begin
      nAnimDictionary := TAnimDictionary.Create(nil);
      nAnimDictionary.MakeDefault(nBSP);
      SetLength(nBSP.Chunks, Length(nBSP.Chunks) + 1);
      nBSP.AddChunk(nAnimDictionary);
    end;
    if nBSP.AnimLib.FindAnimOfHash(default_animation) = nil then
    begin
      nDictAnim := BSP.AnimLib.FindAnimOfHash(default_animation);
      if nDictAnim <> nil then
      begin
        nDictAnim.CopyChunk(nBSP);
      end;
      nNames := TStringList.Create;
      nNames.Duplicates := dupIgnore;
      nBindPoses := TList.Create;
      for i := 0 to nBSP.AnimLib.NumFrames - 1 do
      begin
        if nNames.IndexOf(IntToStr(nBSP.AnimLib.Frames[i].Hash)) = -1 then
        begin
          nNames.Add(IntToStr(nBSP.AnimLib.Frames[i].Hash));
          nBindPoses.Add(@nBSP.AnimLib.Frames[i]);
        end;
      end;
      nBindPoseSize := nNames.Count;
      nBindPoses.Sort(@CompareFrameHash);
      SetLength(nFrames, nBindPoseSize);
      for i := 0 to nBindPoseSize - 1 do
      begin
        nFrames[i] := TFrame(nBindPoses[i]^);
      end;
      nBSP.AnimLib.Frames := nFrames;
      nBSP.AnimLib.NumFrames := nBindPoseSize;
      nBindPoses.Free;
      nNames.Free;
    end;
  end;
  Chunk.render_mirrors := render_mirrors;
  if Chunk.render_mirrors then
  begin
    Chunk.bbox := bbox;
    Chunk.vect1 := vect1;
    Chunk.vect2 := vect2;
  end;
  if Chunk.has_root then
    Chunk.Root := TSpFrame(Root.CopyChunk(nBSP));
  Result := Chunk;
end;

{ TSpFrame }

procedure TSpFrame.ReadChilds;
var
  NextChunk: TChunk;
begin
  NextChunk := BSP.ReadBSPChunk;
  while NextChunk.IDType <> 1009 do
  begin // 1004 1006 1007 1026 1009
    AddChild(NextChunk);
    NextChunk := BSP.ReadBSPChunk;
  end;
  // 1009
  if TLevelObj(NextChunk).GetLevel = level then
  begin
    TLevelObj(NextChunk).Free;
    level := level + 1;
    NextChunk := BSP.ReadBSPChunk(level);
    while NextChunk.IDType = 1001 do
    begin
      AddBone(NextChunk); // 1001
      NextChunk := BSP.ReadBSPChunk(level);
      if NextChunk.IDType = 1009 then
        Break;
    end;
  end;
  level := level - 1;
  if TLevelObj(NextChunk).GetLevel <> level then
    level := 0;
  TLevelObj(NextChunk).Free
end;

procedure TSpFrame.WriteChilds;
var
  LevelChunk: TChunk;
  i: integer;
begin
  for i := 0 to High(Childs) do
  begin
    BSP.WriteBSPChunk(Childs[i]);
  end;
  LevelChunk := TLevelObj.Create(nil);
  TLevelObj(LevelChunk).level := level;
  LevelChunk.Version := Version;
  BSP.WriteBSPChunk(LevelChunk);
  LevelChunk.Free;
  for i := 0 to High(Bones) do
  begin
    BSP.WriteBSPChunk(Bones[i]);
    LevelChunk := TLevelObj.Create(nil);
    TLevelObj(LevelChunk).level := TSpFrame(Bones[i]).level;
    LevelChunk.Version := Bones[i].Version;
    BSP.WriteBSPChunk(LevelChunk);
    LevelChunk.Free;
  end;
  if level = 0 then
  begin
    LevelChunk := TLevelObj.Create(nil);
    TLevelObj(LevelChunk).level := level;
    LevelChunk.Version := Version;
    BSP.WriteBSPChunk(LevelChunk);
    LevelChunk.Free;
  end;
end;

procedure TSpFrame.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_Frame;
  Version := 1698;
  mesh.SetSizeBox(1);
  BSP.AddBone(self);
end;

procedure TSpFrame.AddTypedFrame(index: integer; nbType: integer);
var
  nTypedFrame: TSpFrame;
  i,j: integer;
begin
  nTypedFrame:= TSpFrame.Create(nil);
  nTypedFrame.MakeDefault(Self.BSP);
  for i:=0 to 3 do
   for j:=0 to 3 do
   begin
     if i = j then
      nTypedFrame.matrix_1.m[i][j]:= 1.0
     else
      nTypedFrame.matrix_1.m[i][j]:= 0.0;
   end;
  MatrixDecompose(nTypedFrame.matrix_1.m, nTypedFrame.matrix_1.t[0], nTypedFrame.matrix_1.t[1], nTypedFrame.matrix_1.t[2]);
  mesh.SetEntMatrix(nTypedFrame.matrix_1);
end;

procedure TSpFrame.AddFrame(node: TXmlNode; Frame: TSpFrame);
var
  node_type: TsdAttribute;
  bone_sid: string;
  nIndex, mesh_index: Cardinal;
  a_type: integer;
  cAtomic: TAtomic;
  childFrame: TSpFrame;
  nodesList: TList;
  childNode: TXmlNode;
  invMatrix: TEntMatrix;
  renderBlock: TRenderBlock;
  nullbox, obb: TNullBox;
  boneList: TList;
  tFrame: TSpFrame;
  //new
  tempName: string;
  procedure CalculateBoneOBB(obb: TNullBox);
  var
    bbox: TBBox;
    ii: integer;
    cVector: TVer;
  begin
    if (boneList.Count > 0) then
    begin
      bbox.min[1] := Math.MaxSingle;
      bbox.min[2] := bbox.min[1];
      bbox.min[3] := bbox.min[1];
      bbox.max[1] := Math.MinSingle;
      bbox.max[2] := bbox.max[1];
      bbox.max[3] := bbox.max[1];
      boneList.Add(Self);
      for ii := 0 to boneList.Count - 1 do
      begin
        tFrame := TSpFrame(boneList[ii]);
        cVector[0] := tFrame.matrix_1.m[4][1];
        cVector[1] := tFrame.matrix_1.m[4][2];
        cVector[2] := tFrame.matrix_1.m[4][3];

        if cVector[0] < bbox.min[1] then
          bbox.min[1] := cVector[0];
        if cVector[1] < bbox.min[2] then
          bbox.min[2] := cVector[1];
        if cVector[2] < bbox.min[3] then
          bbox.min[3] := cVector[2];
        if cVector[0] > bbox.max[1] then
          bbox.max[1] := cVector[0];
        if cVector[1] > bbox.max[2] then
          bbox.max[2] := cVector[1];
        if cVector[2] > bbox.max[3] then
          bbox.max[3] := cVector[2];
      end;
      obb.CalculateOBB(bbox, True);
    end
    else
      obb.CalculateOBB(bbox, False);
  end;

  procedure SetMatrixFromNode(var matrix: TMatrix; node: TXmlNode);
  var
    floats: TStringList;
    i, j, index: integer;
  begin
    floats := TStringList.Create;
    floats.Delimiter := ' ';
    floats.DelimitedText := node.Value;
    for j := 0 to 3 do
      for i := 0 to 3 do
      begin
        index := (j * 4) + i;
        matrix[i + 1][j + 1] := StrToFloat(floats[index]);
      end;
    floats.Free;
  end;

begin
  boneList := TList.Create;

  SetMatrixFromNode(matrix_1.m, node.NodeByName('matrix'));
  MatrixDecompose(matrix_1.m, matrix_1.t[0], matrix_1.t[1], matrix_1.t[2]);
  mesh.SetEntMatrix(matrix_1);

  name := StrNew(PChar(node.AttributeByName['name'].Value));
  //if (DAE_BLENDER in DAE_OPTIONS) then
  //begin
    tempName:= stringreplace(name, '.', '-', [rfReplaceAll, rfIgnoreCase]);
    name := StrNew(PAnsiChar(AnsiString(tempName)));
  //end;

  if Length(name) > 0 then
  begin
    mesh.Name := name;
    hash := MakeHash(name, Length(name));
    mesh.hash := hash;
  end;

  if Frame <> nil then
  begin
    matrix_2.m := MatrxMatr(matrix_1.m, Frame.matrix_2.m);
    mesh.BoneMatrix := matrix_2.m;
    MatrixDecompose(matrix_2.m, matrix_2.t[0], matrix_2.t[1], matrix_2.t[2]);
    Self.level := Frame.level + 1;
  end
  else //Root
  begin
    matrix_2.m := matrix_1.m;
    matrix_2.t := matrix_2.t;
    Self.level := 0;

    //Add NullBox with a_type 2
    a_type := 2;
    obb := TNullbox.Create(nil);
    obb.MakeDefault(BSP);
    obb.AddNullBox(childNode, a_type);
    obb.hash := hash;
    AddChild(obb);
  end;

  if BSP.LastClump <> nil then
  begin
    Clump := @BSP.LastClump;
  end;

  node_type := node.AttributeByName['type'];
  if node_type <> nil then
  begin
    bone_sid := node.AttributeByName['sid'].Value;
    bone_index := DaeSkinBones.IndexOf(bone_sid);
    TypeName := format('Bone[%d]', [bone_index]);
    mesh.XType := 'BG';
    if BSP.LastClump <> nil then
      mesh.BoneMatrix := matrix_2.m;
    //Update Clump
    BSP.LastClump.bone_hashes[bone_index] := hash;
    BSP.LastClump.BoneLib[bone_index].hash :=
      BSP.LastClump.bone_hashes[bone_index];
    BSP.LastClump.BoneLib[bone_index].matrix :=
      BSP.LastClump.bone_matrix[bone_index].m;
    BSP.LastClump.BoneLib[bone_index].index := bone_index;
    BSP.LastClump.AddBone(self);

    //Add bone OBB
    a_type := 0;
    obb := TNullbox.Create(nil);
    obb.MakeDefault(BSP);
    obb.AddNullBox(childNode, a_type);
    obb.hash := hash;
    AddChild(obb);
  end
  else
  begin //Chain
    bone_index := -1;
    TypeName := 'Group';
    mesh.XType := 'GR';
  end;

  if Length(name) > 0 then
  begin
    TypeName := format('%s "%s"', [TypeName, name]);
  end;

  cAtomic := nil;
  nodesList := TList.Create;
  node.NodesByName('node', nodesList);
  if nodesList.Count > 0 then
  begin
    for nIndex := 0 to nodesList.Count - 1 do
    begin
      childNode := TXmlNode(nodesList.Items[nIndex]);
      if childNode.NodeByName('instance_controller') <> nil then //skinned shape
      begin
        if cAtomic = nil then
        begin
          cAtomic := TAtomic.Create(nil);
          cAtomic.MakeDefault(BSP);
          cAtomic.AddAtomic(childNode, 5);
          AddChild(cAtomic);
        end
        else
        begin
          renderBlock := TRenderBlock.Create(nil);
          renderBlock.MakeDefault(BSP);
          renderBlock.AddRenderBlock(childNode, cAtomic.atomic_type);
          mesh_index := Length(cAtomic.ModelGroup.models);
          inc(cAtomic.ModelGroup.models_num);
          SetLength(cAtomic.ModelGroup.models, cAtomic.ModelGroup.models_num);
          cAtomic.ModelGroup.models[mesh_index] := renderBlock;
          cAtomic.ModelGroup.models[mesh_index].TypeName := format('Shape_%d',
            [BSP.ShpIdx]);
          Inc(BSP.ShpIdx);
        end;
      end
      else if childNode.NodeByName('instance_geometry') <> nil then
        //non skinned shape
      begin
        if cAtomic = nil then
        begin
          cAtomic := TAtomic.Create(nil);
          cAtomic.MakeDefault(BSP);
          cAtomic.AddAtomic(childNode, 3);
          AddChild(cAtomic);
        end
        else
        begin
          renderBlock := TRenderBlock.Create(nil);
          renderBlock.MakeDefault(BSP);
          renderBlock.AddRenderBlock(childNode, cAtomic.atomic_type);
          mesh_index := Length(cAtomic.ModelGroup.models);
          inc(cAtomic.ModelGroup.models_num);
          SetLength(cAtomic.ModelGroup.models, cAtomic.ModelGroup.models_num);
          cAtomic.ModelGroup.models[mesh_index] := renderBlock;
          cAtomic.ModelGroup.models[mesh_index].TypeName := format('Shape_%d',
            [BSP.ShpIdx]);
          Inc(BSP.ShpIdx);
        end;
      end
      else if AnsiStartsStr('NullBox-', childNode.AttributeByName['name'].Value)
        then //NullBox
      begin
        nullbox := TNullbox.Create(nil);
        nullbox.MakeDefault(BSP);
        nullbox.AddNullBox(childNode, 4);
        AddChild(nullbox);
      end
      else
      begin
        childFrame := TSpFrame.Create(nil);
        childFrame.MakeDefault(BSP);
        childFrame.AddFrame(childNode, Self);
        if not ((childFrame.bone_index = -1) and (Length(childFrame.Childs) = 1)
          and (Length(childFrame.Bones) = 0)) then
          boneList.Add(childFrame);
        AddBone(childFrame);
      end;
    end;
  end;

  if a_type = 0 then //is bone
  begin
    CalculateBoneOBB(obb);
  end;
  if cAtomic <> nil then
  begin
    cAtomic.ModelGroup.CalculateBound;
    if (obb <> nil) and (cAtomic.atomic_type = 5) then
    begin
      obb.CalculateOBB(cAtomic.ModelGroup.BBox, True);
    end
  end;
  boneList.Free;
  nodesList.Free;
end;

procedure TSpFrame.Read;
begin
  matrix_1 := ReadMxBlock;
  mesh.SetEntMatrix(matrix_1);
  matrix_2 := ReadMxBlock;

  bone_index := ReadSPDword;
  mask := ReadDword;
  if (Version = 1696) or (Version = 1695) or (Version = 1693) then
  begin
    ReadMxBlock; //one more matrix
  end;
  hash := ReadDword;
  mesh.Hash := Hash;
  if BSP.LastClump <> nil then
  begin
    Clump := @BSP.LastClump;
  end;
  name := ReadStringSize(255);
  if bone_index = -1 then
  begin
    TypeName := 'Group';
    mesh.XType := 'GR';
  end
  else
  begin
    TypeName := format('Bone[%d]', [bone_index]);
    mesh.XType := 'BG';
    if Clump <> nil then
      mesh.BoneMatrix := matrix_2.m;
    //TClump(Clump).AddBone(self);
    BSP.LastClump.AddBone(self);
  end;
  if Length(name) > 0 then
  begin
    TypeName := format('%s "%s"', [TypeName, name]);
    mesh.Name := name;
  end;
  mesh.SetSizeBox(1);
  BSP.AddBone(self);
end;

procedure TSpFrame.Write;
begin
  inherited;
  WriteMxBlock(matrix_1);
  WriteMxBlock(matrix_2);
  WriteSPDword(bone_index);
  WriteDword(mask);
  WriteDword(hash);
  WriteStringSize(name, 255);
  CalcSize;
end;

procedure TSpFrame.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
  AddMatrixData(nil, 'Local Matrix', 'Local Transform', matrix_1);
  AddMatrixData(nil, 'Global Matrix', 'Global Transform', matrix_2);
  AddTreeData(nil, 'Bone Index', @bone_index, BSPUint);
  AddTreeData(nil, 'Flags', @mask, BSPDword);
  AddTreeData(nil, 'Hash', @hash, BSPHash);
  AddTreeData(nil, 'Name', @name, BSPString);
end;

constructor TSpFrame.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Bone';
  mesh := TMesh.Create;
  // mesh.XType:='BO';
end;

destructor TSpFrame.Destroy;
var
  i: integer;
begin
  if Length(Childs) > 0 then
  begin
    for i := 0 to Length(Childs) - 1 do
      FreeAndNil(Childs[i]);
  end;
  SetLength(Childs, 0);
  if Length(Bones) > 0 then
  begin
    for i := 0 to Length(Bones) - 1 do
      FreeAndNil(Bones[i]);
  end;
  SetLength(Bones, 0);
  Mesh.Clear;
  inherited;
end;

procedure TSpFrame.AddBone(Bone: TChunk);
var
  len: integer;
begin
  len := Length(Bones);
  SetLength(Bones, len + 1);
  Bones[len] := Bone;
end;

procedure TSpFrame.AddChild(Child: TChunk);
var
  len: integer;
begin
  len := Length(Childs);
  SetLength(Childs, len + 1);
  Childs[len] := Child;
end;

function TSpFrame.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x, num: integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 10;
  CheckHide(Result);
  Data^.Hash := Format('[%.*x]', [8, hash]);
  if bone_index = -1 then
    Data^.ImageIndex := 5;
  num := Length(Childs);
  for x := 0 to num - 1 do
    Childs[x].AddClassNode(TreeView, Result);
  num := Length(Bones);
  for x := 0 to num - 1 do
    Bones[x].AddClassNode(TreeView, Result);
end;

function TSpFrame.GetMesh: TMesh;
var
  num, num2, x: integer;
begin
  Result := mesh;
  num := Length(Childs);
  num2 := Length(Bones);
  Mesh.ResetChilds(num + num2);
  for x := 0 to num - 1 do
    Mesh.childs[x] := Childs[x].GetMesh;
  for x := 0 to num2 - 1 do
    Mesh.childs[num + x] := Bones[x].GetMesh;
end;

procedure TSpFrame.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
var
  i: integer;
  oldHash: Cardinal;
  entity: TEntity;
  link: TNullBox;
  root_frame: TSpFrame;
  clump: TClump;
  procedure RecalculateBoneMatrix(var bone1: TSpFrame; bone2: TSpFrame);
  var
    i: integer;
  begin
    bone1.matrix_2.m := MatrXMatr(bone1.matrix_1.m, bone2.matrix_2.m);
    bone1.mesh.BoneMatrix := bone1.matrix_2.m;
    MatrixDecompose(bone1.matrix_2.m, bone1.matrix_2.t[0], bone1.matrix_2.t[1], bone1.matrix_2.t[2]);
    if bone1.bone_index <> -1 then
    begin
      clump.bone_matrix[bone1.bone_index].m :=
        MatrixInvertPrecise(bone1.matrix_2.m);
      clump.BoneLib[bone1.bone_index].matrix :=
        clump.bone_matrix[bone1.bone_index].m;
    end;

    for i := 0 to High(bone1.Bones) do
    begin
      RecalculateBoneMatrix(TSpFrame(bone1.bones[i]), bone1);
    end;
  end;
begin
  if bone_index = -1 then
    TypeName := 'Group'
  else
  begin
    TypeName := format('Bone[%d]', [bone_index]);
  end;

  if Length(name) > 0 then
    TypeName := format('%s "%s"', [TypeName, name]);

  if PData.DName = 'name' then
  begin
    if length(name) > 0 then
    begin
      oldHash := hash;
      hash := MakeHash(name, Length(name));
      //check all Clumps

      if BSP.Entities <> nil then
        if Length(BSP.Entities.Entities) > 0 then
          for i := 0 to High(BSP.Entities.Entities) do
          begin
            entity := BSP.Entities.Entities[i];
            if entity.Clump.Root = Self then
              if entity.Clump.hash = oldHash then
                entity.Clump.hash := hash;
          end;
      //Check Emitters
      if Length(Childs) > 0 then
        for i := 0 to High(Childs) do
        begin
          if Childs[i] is TNullBox then
          begin
            link := TNullBox(Childs[i]);
            if link.hash = oldHash then
            begin
              link.hash := hash;
            end;
          end
          else if Childs[i] is TAtomic then
          begin
            if TAtomic(Childs[i]).hash = oldHash then
              TAtomic(Childs[i]).hash := hash;
          end;
        end;
    end;
  end
  else if (PData.DName[1] = '[') or (PData.DName = 'position') or (PData.DName =
    'rotation') or (PData.DName = 'scale') then
  begin
    if (PData.DName[1] = '[') then
    begin
      MatrixDecompose(matrix_1.m, matrix_1.t[0], matrix_1.t[1], matrix_1.t[2]);
    end
    else
    begin
      matrix_1.m := GetMatrix(matrix_1.t[0], matrix_1.t[1], matrix_1.t[2]);
    end;
    //B2.local * b1.global = b2.global  if b2 was selected to be changed
    clump := TClump(Self.Clump^);
    if clump.Root = Self then
    begin
      matrix_2.m := matrix_1.m;
      mesh.BoneMatrix := matrix_2.m;
      MatrixDecompose(matrix_2.m, matrix_2.t[0], matrix_2.t[1], matrix_2.t[2]);
      for i := 0 to High(Bones) do
        RecalculateBoneMatrix(TSpFrame(Bones[i]), Self);
    end
    else
    begin
      root_frame := clump.Root;
      for i := 0 to High(root_frame.Bones) do
        RecalculateBoneMatrix(TSpFrame(root_frame.Bones[i]), root_frame);
    end;
    mesh.SetEntMatrix(matrix_1);
  end;
  inherited;
end;

procedure TSpFrame.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csCheckedNormal;
  if name = 'ice_layer' then
  begin
    ANode.CheckState := csUncheckedNormal;
    mesh.Hide := not But.Icelayer^;
    if But.Icelayer^ then
      ANode.CheckState := csCheckedNormal
  end;
end;

procedure TSpFrame.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

procedure TSpFrame.DeleteChild(Chunk: TChunk);
var
  Bone: TSpFrame;
  i, num: integer;
  MoveIndex: boolean;
begin
  case Chunk.IDType of
    1001:
      begin
        Bone := TSpFrame(Chunk);
        Num := Length(Bones);
        Dec(Num);
        MoveIndex := False;
        for i := 0 to num do
        begin
          if MoveIndex then
            Bones[i - 1] := Bones[i];
          if Bones[i] = Bone then
            MoveIndex := true;
        end;
        SetLength(Bones, Num);
        Bone.Destroy;
      end;
    1004, 1006, 1007, 1026:
      begin
        Num := Length(Childs);
        Dec(Num);
        MoveIndex := False;
        for i := 0 to num do
        begin
          if MoveIndex then
            Childs[i - 1] := Childs[i];
          if Childs[i] = Chunk then
            MoveIndex := true;
        end;
        SetLength(Childs, Num);
        Chunk.Destroy;
      end;
  end;
  // LINK with BSP.BoneLib !!
end;

function TSpFrame.GetModel(mesh_id: integer): TRenderBlock;
var
  i: integer;
begin
  Result := nil;
  if mesh_id < 0 then
    mesh_id := 0;
  for i := 0 to High(Childs) do
    if Childs[i] is TAtomic then
      if TAtomic(Childs[i]).has_ModelGroup and
        (TAtomic(Childs[i]).ModelGroup.models_num > mesh_id) then
        Result := TAtomic(Childs[i]).ModelGroup.models[mesh_id];
end;

function TSpFrame.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TSpFrame;
  i: Integer;
begin
  Chunk := TSpFrame(inherited CopyChunk(nBSP));
  Chunk.mesh := TMesh.Create;
  Chunk.matrix_1 := matrix_1;
  Chunk.mesh.SetEntMatrix(matrix_1);
  Chunk.matrix_2 := matrix_2;

  Chunk.bone_index := bone_index;
  Chunk.mask := mask;
  Chunk.hash := hash;
  Chunk.mesh.Hash := Hash;
  //Chunk.Clump := Clump;
  Chunk.name := StrNew(name);
  if bone_index = -1 then
    Chunk.mesh.XType := 'GR'
  else
  begin
    Chunk.mesh.XType := 'BG';
    if Clump <> nil then
      Chunk.mesh.BoneMatrix := matrix_2.m;
    if nBSP = nil then
      BSP.LastClump.AddBone(Chunk)//TClump(Clump).AddBone(Chunk) //BUG, need to be fixed,Clump UPDATE
    else
      //TClump(Clump).AddBone(Chunk);
      nBSP.LastClump.AddBone(Chunk);
  end;
  Chunk.mesh.Name := name;
  Chunk.mesh.SizeBox := mesh.SizeBox;
  if nBSP = nil then
    BSP.AddBone(Chunk)
  else
    nBSP.AddBone(Chunk);

  SetLength(Chunk.Childs, Length(Childs));
  for i := 0 to High(Childs) do
    Chunk.Childs[i] := Childs[i].CopyChunk(nBSP);
  SetLength(Chunk.Bones, Length(Bones));
  for i := 0 to High(Bones) do
    Chunk.Bones[i] := Bones[i].CopyChunk(nBSP);
  Chunk.level := level;
  Result := Chunk;
end;

{ TLevelObj }

procedure TLevelObj.Read;
begin
  level := ReadDword;
end;

procedure TLevelObj.Write;
begin
  inherited;
  WriteDword(level);
end;

procedure TLevelObj.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
  AddTreeData(nil, 'Stream Depth', @level, BSPUint);
end;

constructor TLevelObj.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Tree level';
  IDType := 1009;
  Version := 1697;
  Size := 4;
  level := 0;
end;

destructor TLevelObj.Destroy;
begin
  inherited;
end;

function TLevelObj.GetLevel: Integer;
begin
  Result := level;
  // Free;
end;

function TLevelObj.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 0;
end;

{ TAtomic }

procedure TAtomic.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_Atomic;
  Version := 1698;
end;

procedure TAtomic.AddAtomic(node: TXmlNode; a_type: Cardinal);
begin
  atomic_type := a_type;
  if atomic_type = 5 then
    mask := 5
  else
    mask := 1;
  mesh.Hide := (mask and $1) = 0;
  hash := 0;
  has_ModelGroup := true;
  ModelGroup := TSpMesh.Create(nil);
  ModelGroup.MakeDefault(BSP);
  ModelGroup.AddMesh(node, a_type);
end;

procedure TAtomic.Read;
begin
  inherited;
  mask := ReadDword;
  mesh.Hide := (mask and $1) = 0;
  hash := ReadDword;
  has_ModelGroup := Boolean(ReadDword);
  if has_ModelGroup then
    ModelGroup := TSpMesh(BSP.ReadBSPChunk);
end;

procedure TAtomic.Write;
begin
  inherited;
  WriteDword(mask);
  WriteDword(hash);
  WriteBoolean(has_ModelGroup);
  CalcSize;
  if has_ModelGroup then
    BSP.WriteBSPChunk(ModelGroup);
end;

procedure TAtomic.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node: PVirtualNode;
begin
  inherited;
  AddTreeData(nil, 'Flags', @mask, BSPDword);
  AddTreeData(nil, 'Name Hash', @hash, BSPHash);
  Node := AddTreeData(nil, 'Mesh', @has_ModelGroup, BSPChBool);
  if has_ModelGroup then
    ValueIndex(Node, 15);
end;

constructor TAtomic.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Atomic';
  Mesh := TMesh.Create;
  Mesh.ChName := 'AM';
end;

destructor TAtomic.Destroy;
begin
  Mesh.Clear;
  if ModelGroup <> nil then
    FreeAndNil(ModelGroup);
  inherited;
end;

function TAtomic.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 11;
  Data^.Hash := Format('[%.*x]', [8, hash]);
  if ModelGroup <> nil then
    ModelGroup.AddClassNode(TreeView, Result);
end;

function TAtomic.GetMesh: TMesh;
begin
  mesh.Hide := (mask and $1) = 0;
  Result := Mesh;
  if ModelGroup <> nil then
  begin
    Mesh.ResetChilds(1);
    Mesh.Childs[0] := ModelGroup.GetMesh;
  end;
end;

procedure TAtomic.DeleteChild(Chunk: TChunk);
begin
  if Chunk is TSpMesh then
  begin
    has_ModelGroup := false;
    FreeAndNil(ModelGroup);
  end;
end;

procedure TAtomic.UpdateNode(CustomTree: TCustomVirtualStringTree;
  PData: PPropertyData);
begin
  if PData.DName = 'Flags' then
    mesh.Hide := (mask and $1) = 0;
  inherited;
end;

function TAtomic.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TAtomic;
begin
  Chunk := TAtomic(inherited CopyChunk(nBSP));
  Chunk.Mesh := TMesh.Create;
  Chunk.Mesh.ChName := 'AM';
  Chunk.mask := mask;
  Chunk.mesh.Hide := (mask and $1) = 0;
  Chunk.hash := hash;
  Chunk.has_ModelGroup := has_ModelGroup;
  if has_ModelGroup then
    Chunk.ModelGroup := TSpMesh(ModelGroup.CopyChunk(nBSP));
  Result := Chunk;
end;

{ TNullBox }

procedure TNullBox.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_NullBox;
  Version := 1698;
end;

procedure TNullBox.AddNullBox(node: TXmlNode; a_type: integer);
var
  nb_variables: TStringList;

  procedure SetMatrixFromNode(var matrix: TMatrix; node: TXmlNode);
  var
    floats: TStringList;
    i, j, index: integer;
  begin
    floats := TStringList.Create;
    floats.Delimiter := ' ';
    floats.DelimitedText := node.Value;
    for j := 0 to 3 do
      for i := 0 to 3 do
      begin
        index := (j * 4) + i;
        matrix[i + 1][j + 1] := StrToFloat(floats[index]);
      end;
    floats.Free;
  end;
begin
  if a_type = 4 then
  begin
    atomic_type := a_type;
    link := 0;
    SetMatrixFromNode(matrix, node.NodeByName('matrix'));
    hash := 0;
    mesh.Transform.TransType := TTMatrix;
    mesh.Transform.TrMatrix := matrix;
    nb_variables := TStringList.Create;
    nb_variables.Delimiter := '-';
    nb_variables.DelimitedText := node.AttributeByName['name'].Value;
    emm_type := StrToInt(nb_variables[1]);
    nb_variables.Free;
  end
  else //Generated Nullboxes
  begin
    atomic_type := a_type;
    case atomic_type of
      0: //Bone
        begin
          link := $FFFFFFFF;
          emm_type := 0;
        end;
      2: //OBB
        begin
          link := $FFFFFFFF;
          emm_type := 0;
        end;
    end;
  end;
end;

procedure TNullBox.CalculateOBB(box: TBbox; isBbox: boolean);
var
  BBox: TBBox;
  i: integer;
begin
  if isBbox then
  begin
    BBox := box;
  end
  else
  begin
    BBox.max[1] := 0.04;
    BBox.max[2] := 0.04;
    BBox.max[3] := 0.04;
    BBox.min[1] := -0.04;
    BBox.min[2] := -0.04;
    BBox.min[3] := -0.04;
  end;
  self.matrix[1][1] := 1.0;
  self.matrix[2][2] := 1.0;
  self.matrix[3][3] := 1.0;
  self.matrix[4][4] := 1.0;
  self.matrix[4][1] := (BBox.max[1] + BBox.min[1]) * 0.5;
  self.matrix[4][2] := (BBox.max[2] + BBox.min[2]) * 0.5;
  self.matrix[4][3] := (BBox.max[3] + BBox.min[3]) * 0.5;

  self.matrix[1][4] := Abs(BBox.min[1] - BBox.max[1]) * 0.5;
  self.matrix[2][4] := Abs(BBox.min[2] - BBox.max[2]) * 0.5;
  self.matrix[3][4] := Abs(BBox.min[3] - BBox.max[3]) * 0.5;

  if self.matrix[1][4] < 0.00050000002 then
    self.matrix[1][4] := 0.00050000002;
  if self.matrix[2][4] < 0.00050000002 then
    self.matrix[2][4] := 0.00050000002;
  if self.matrix[3][4] < 0.00050000002 then
    self.matrix[3][4] := 0.00050000002;

  SpObbToAABB;
end;

procedure TNullBox.SpObbToAABB;
var
  extends_x, extends_y, extends_z: double;
  abs_x1, abs_x2, abs_x3, abs_y1, abs_y2, abs_y3, abs_z1, abs_z2, abs_z3:
    Single;
  bbox: TBBox;
begin
  extends_x := matrix[1][4];
  abs_x1 := Abs(extends_x * matrix[1][1]);
  abs_x2 := Abs(extends_x * matrix[1][2]);
  abs_x3 := Abs(extends_x * matrix[1][3]);

  extends_y := matrix[2][4];
  abs_y1 := Abs(extends_y * matrix[2][1]);
  abs_y2 := Abs(extends_y * matrix[2][2]);
  abs_y3 := Abs(extends_y * matrix[2][3]);

  extends_z := matrix[3][4];
  abs_z1 := Abs(extends_z * matrix[3][1]);
  abs_z2 := Abs(extends_z * matrix[3][2]);
  abs_z3 := Abs(extends_z * matrix[3][3]);

  if abs_x1 < abs_y1 then
    abs_x1 := abs_y1;
  if abs_x2 < abs_y2 then
    abs_x2 := abs_y2;
  if abs_x3 < abs_y3 then
    abs_x3 := abs_y3;

  if abs_x1 < abs_z1 then
    abs_x1 := abs_z1;
  if abs_x2 < abs_z2 then
    abs_x2 := abs_z2;
  if abs_x3 < abs_z3 then
    abs_x3 := abs_z3;

  bbox.max[1] := matrix[4][1] - abs_x1;
  bbox.max[2] := matrix[4][2] - abs_x2;
  bbox.max[3] := matrix[4][3] - abs_x3;

  bbox.min[1] := abs_x1 + matrix[4][1];
  bbox.min[2] := abs_x2 + matrix[4][2];
  bbox.min[3] := abs_x3 + matrix[4][3];

  mesh.SetBound(bbox);
end;

procedure TNullBox.Read;
var
  i: integer;
begin
  inherited;
  link := ReadDword;
  matrix[4][1] := ReadFloat;
  matrix[4][2] := ReadFloat;
  matrix[4][3] := ReadFloat;
  matrix[4][4] := 1.0;
  for i := 1 to 3 do
  begin
    matrix[i][1] := ReadFloat;
    matrix[i][2] := ReadFloat;
    matrix[i][3] := ReadFloat;
    matrix[i][4] := ReadFloat;
  end;
  SpObbToAABB;
  //mesh.Transform.TransType := TTMatrix;
  //mesh.Transform.TrMatrix := matrix;
  hash := ReadDword;
  emm_type := ReadDword;
end;

procedure TNullBox.Write;
var
  i: integer;
begin
  inherited;
  WriteDword(link);
  WriteFloat(matrix[4][1]);
  WriteFloat(matrix[4][2]);
  WriteFloat(matrix[4][3]);
  for i := 1 to 3 do
  begin
    WriteFloat(matrix[i][1]);
    WriteFloat(matrix[i][2]);
    WriteFloat(matrix[i][3]);
    WriteFloat(matrix[i][4]);
  end;
  WriteDword(hash);
  WriteDword(emm_type);
  CalcSize;
end;

procedure TNullBox.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node: PVirtualNode;
  Data: PPropertyData;
begin
  inherited;
  AddTreeData(nil, 'Null Index', @link, BSPUint);
  Node := AddTreeData(nil, 'Bounds', @matrix[4][1], BSPMatrix);
  Data := DataTree.GetNodeData(Node);
  Data^.ValueIndex := 17;
  AddTreeData(Node, 'Axis_X', @matrix[1][1], BSPVect4);
  AddTreeData(Node, 'Axis_Y', @matrix[2][1], BSPVect4);
  AddTreeData(Node, 'Axis_Z', @matrix[3][1], BSPVect4);
  AddTreeData(Node, 'Center', @matrix[4][1], BSPVect4);
  AddTreeData(nil, 'Name Hash', @hash, BSPHash);
  AddTreeData(nil, 'Spawn Type', @emm_type, BSPNullBoxType);
end;

constructor TNullBox.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'NullBox';
  Mesh := TMesh.Create;
  Mesh.XType := 'EM';
end;

destructor TNullBox.Destroy;
begin
  mesh.Clear;
  inherited;
end;

function TNullBox.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 1;
  mesh.Indx := ID;
  CheckHide(Result);
end;

procedure TNullbox.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
begin
  if (PData.DName = 'Center') or AnsiStartsStr('Axis', PData.DName) then
  begin
    SpObbToAABB;
  end;
  inherited;
end;

function TNullBox.GetMesh: TMesh;
begin
  Result := mesh;
end;

procedure TNullBox.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csUncheckedNormal;
  mesh.Hide := not But.Emitters^;
  if But.Emitters^ then
    ANode.CheckState := csCheckedNormal
end;

procedure TNullBox.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

function TNullBox.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TNullBox;
begin
  Chunk := TNullBox(inherited CopyChunk(nBSP));
  Chunk.Mesh := TMesh.Create;
  Chunk.Mesh.XType := 'EM';
  Chunk.link := link;
  Chunk.matrix := matrix;
  Chunk.mesh.Transform.TransType := TTMatrix;
  Chunk.mesh.Transform.TrMatrix := matrix;
  Chunk.hash := hash;
  Chunk.emm_type := emm_type;
  Result := Chunk;
end;

{ TEntities }

procedure TEntities.MakeDefault(BSPfile: TBSPFile);
begin
  inherited;
  IDType := C_Entities;
  Version := 1698;

  BSP.Entities := self;
  Clear;
  Num := 0;
  Name := 'Entities Count';
  SetLength(Entities, Num);
end;

procedure TEntities.Read;
var
  i: integer;
begin
  BSP.Entities := self;
  Clear;
  //Num := 0;
  //ReadDword;
  Num := ReadDword;
  Name := 'Entities Count';
  SetLength(Entities, Num);
  for i := 0 to Num - 1 do
    Entities[i] := TEntity(BSP.ReadBSPChunk);
end;

procedure TEntities.Write;
var
  i: integer;
begin
  inherited;
  for i := 0 to Num - 1 do
    BSP.WriteBSPChunk(Entities[i]);
end;

procedure TEntities.Clear;
var
  i: integer;
begin
  if Length(Entities) > 0 then
  begin
    for i := 0 to Length(Entities) - 1 do
      if Entities[i] <> nil then
        FreeAndNil(Entities[i]);
  end;
end;

constructor TEntities.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Entities';
  mesh := Tmesh.Create;
end;

destructor TEntities.Destroy;
begin
  Clear;
  Mesh.Clear;
  inherited;
end;

procedure TEntities.AddData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2: PVirtualNode;
  Data: PPropertyData;
begin
  inherited;
  Node2 := AddTreeData(Node1, format('Entity [%d]', [i]), nil, BSPChunk,
    Entities[i].name);
  Data := DataTree.GetNodeData(Node2);
  Data^.Obj := @Entities[i];
  Data^.ValueIndex := 28;
end;

function TEntities.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 19;
  Result.CheckType := ctTriStateCheckBox;
  // if But.ShowFull^ then
  Result.CheckState := csCheckedNormal;
  for x := 0 to num - 1 do
  begin
    Entities[x].AddClassNode(TreeView, Result);
{$IFDEF PROGRESSBAR}But.TreeProgress.Position := 850 + Round(x / num * 150);
{$ENDIF}
  end;
end;

function TEntities.GetMesh: TMesh;
var
  i: integer;
begin
  Result := mesh;
  Mesh.ResetChilds(num);
  for i := 0 to num - 1 do
  begin
    Mesh.childs[i] := Entities[i].GetMesh;
  end;
end;

procedure TEntities.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

procedure TEntities.DeleteChild(Chunk: TChunk);
var
  Entity: TEntity;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TEntity then
  begin
    Entity := TEntity(Chunk);
    Dec(Num);
    MoveIndex := False;
    for i := 0 to num do
    begin
      if MoveIndex then
        Entities[i - 1] := Entities[i];
      if Entities[i] = Entity then
        MoveIndex := true;
    end;
    SetLength(Entities, Num);
    Entity.Destroy;
  end;
end;

procedure TEntities.InsertChild(Target, Chunk: TChunk);
var
  Entity: TEntity;
  i: integer;
begin
  if Chunk is TEntity then
  begin
    Entity := TEntity(Target);
    Inc(Num);
    SetLength(Entities, Num);
    for i := num - 2 downto 0 do
    begin
      if Entities[i] = Entity then
      begin
        Entities[i + 1] := TEntity(Chunk);
        break;
      end;
      Entities[i + 1] := Entities[i];
    end;
  end;
end;

{ TEntity }

procedure TEntity.MakeDefault(BSPFile: TBSPfile);
begin
  inherited;
  IDType := C_Entity;
  Version := 1698;
  BSP.LastClump := nil;
end;

procedure TEntity.AddEntity(e_type: Cardinal; node: TXmlNode);

  procedure SetMatrixFromNode(var matrix: TMatrix; node: TXmlNode);
  var
    floats: TStringList;
    i, j, index: integer;
  begin
    floats := TStringList.Create;
    floats.Delimiter := ' ';
    floats.DelimitedText := node.Value;
    for j := 0 to 3 do
      for i := 0 to 3 do
      begin
        index := (j * 4) + i;
        matrix[i + 1][j + 1] := StrToFloat(floats[index]);
      end;
    floats.Free;
  end;

  procedure SetIdentityMatrix(var matrix: TEntMatrix);
  var
    x, y: integer;
  begin
    for x := 1 to 4 do
      for y := 1 to 4 do
      begin
        if x <> y then
          matrix.m[x][y] := 0.0
        else
          matrix.m[x][y] := 1.0;
      end;
    MatrixDecompose(matrix.m, matrix.t[0], matrix.t[1], matrix.t[2]);
  end;

begin
  ent_type := e_type;
  ent_index := 1;
  TypeName := format('Entity [%s]', [BSPEntTypesS[ent_type]]);
  if node <> nil then
  begin
    SetMatrixFromNode(matrix.m, node.NodeByName('matrix'));
    MatrixDecompose(matrix.m, matrix.t[0], matrix.t[1], matrix.t[2]);
    Clump := TClump.Create(nil);
    Clump.MakeDefault(BSP);
    Clump.AddClump(ent_type, node);
  end
  else
    SetIdentityMatrix(matrix);
end;

procedure TEntity.Read;
begin
  BSP.LastClump := nil;
  ent_type := ReadDword;
  matrix := ReadMxBlock;
  //  mesh.SetEntMatrix(matrix);
  ent_index := ReadSPDword;
  name := ReadStringSize(50);
  if Length(name) > 0 then
  begin
    TypeName := format('Entity [%s] "%s"', [BSPEntTypesS[ent_type], name]);
    Mesh.Name := name;
  end
  else
    TypeName := format('Entity [%s]', [BSPEntTypesS[ent_type]]);
  //EntMakeHash(ent_class, string);
  Clump := TClump(BSP.ReadBSPChunk);
end;

procedure TEntity.Write;
begin
  inherited;
  WriteDword(ent_type);
  WriteMxBlock(matrix);
  WriteSPDword(ent_index);
  WriteStringSize(name, 50);
  CalcSize;
  BSP.WriteBSPChunk(Clump);
end;

procedure TEntity.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
  AddTreeData(nil, 'Type', @ent_type, BSPEntTypes);
  AddMatrixData(nil, 'Initial Matrix', 'Transform', matrix);
  AddTreeData(nil, 'Num Action Points', @ent_index, BSPUint);
  AddTreeData(nil, 'Category', @name, BSPString);
end;

constructor TEntity.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Entity';
  mesh := TMesh.Create;
end;

destructor TEntity.Destroy;
begin
  if Clump <> nil then
    FreeAndNil(Clump);
  Mesh.Clear;
  inherited;
end;

function TEntity.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 28;
  CheckHide(Result);
  if Clump <> nil then
    Clump.AddClassNode(TreeView, Result);
end;

function TEntity.GetMesh: TMesh;
begin
  Result := mesh;
  if Clump <> nil then
  begin
    Mesh.ResetChilds(1);
    Mesh.childs[0] := Clump.GetMesh;
  end;
end;

procedure TEntity.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
begin
  if Length(name) > 0 then
    TypeName := format('Entity [%s] "%s"', [BSPEntTypesS[ent_type], name])
  else
    TypeName := format('Entity [%s]', [BSPEntTypesS[ent_type]]);

  if (PData.DName = 'Position') or (PData.DName = 'Rotation') or (PData.DName = 'Scale') then
  begin
    matrix.m := GetMatrix(matrix.t[0], matrix.t[1], matrix.t[2]);
  end
  else if PData.DName[1] = '[' then
  begin
    MatrixDecompose(matrix.m, matrix.t[0], matrix.t[1], matrix.t[2]);
  end;

  inherited;
end;

procedure TEntity.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csCheckedNormal;
  if (ent_type = 5) then
  begin
    ANode.CheckState := csUncheckedNormal;
    mesh.Hide := not But.Light^;
    if But.Light^ then
      ANode.CheckState := csCheckedNormal
  end;
end;

procedure TEntity.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

function TEntity.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TEntity;
begin
  Chunk := TEntity(inherited CopyChunk(nBSP));
  Chunk.mesh := TMesh.Create;
  if nBSP = nil then
    BSP.LastClump := nil
  else
    nBSP.LastClump := nil;

  Chunk.ent_type := ent_type;
  Chunk.matrix := matrix;
  Chunk.ent_index := ent_index;
  Chunk.name := StrNew(name);
  Chunk.TypeName := TypeName;
  Chunk.Mesh.Name := Mesh.Name;
  Chunk.Clump := TClump(Clump.CopyChunk(nBSP));
  Result := Chunk;
end;

{ TLight }

procedure TLight.Read;
begin
  inherited;
  val_1 := ReadSPDword;
  val_2 := ReadDword;
  //  mesh.floors:=val_1;
  power := ReadFloat;
  ReadBytesBlock(@color[1], 4);
  mesh.Attribute.light := Color4d_byte(TUColor(color));
  angle := ReadFloat;
  val_3 := ReadFloat;
  if Version < 1695 then
    val_4 := -1
  else
    val_4 := ReadDword;
end;

procedure TLight.Write;
begin
  inherited;
  WriteSPDword(val_1);
  WriteDword(val_2);
  WriteFloat(power);
  WriteBytesBlock(@color[1], 4);
  WriteFloat(angle);
  WriteFloat(val_3);
  //if Version >= 1695 then FIX ME: No version checks when saving!
  WriteDword(val_4);
  CalcSize;
end;

procedure TLight.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
  AddTreeData(nil, 'Light Type', @val_1, BSPUint);
  AddTreeData(nil, 'Flags', @val_2, BSPUint);
  AddTreeData(nil, 'Radius', @power, BSPFloat);
  AddTreeData(nil, 'Color', @color, BSPColor);
  AddTreeData(nil, 'Cone Angle', @angle, BSPFloat);
  AddTreeData(nil, 'Photon Light Abs Scale', @val_3, BSPFloat);
  AddTreeData(nil, 'LightSwitch Layer Index', @val_4, BSPUint);
end;

constructor TLight.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Light';
  mesh := Tmesh.Create;
  mesh.XType := 'LT';
  mesh.SetSizeBox(0.1);
end;

destructor TLight.Destroy;
begin
  Mesh.Clear;
  inherited;
end;

function TLight.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 25;
  mesh.Indx := ID;
end;

function TLight.GetMesh: TMesh;
begin
  Result := mesh;
end;

procedure TLight.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
begin
  inherited;
  if PData.DName = 'Color' then
    mesh.Attribute.light := Color4d_byte(TUColor(color));
end;

function TLight.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TLight;
begin
  Chunk := TLight(inherited CopyChunk(nBSP));
  Chunk.mesh := Tmesh.Create;
  Chunk.mesh.XType := 'LT';
  Chunk.mesh.SetSizeBox(0.1);
  Chunk.val_1 := val_1;
  Chunk.val_2 := val_2;
  Chunk.power := power;
  Chunk.color := color;
  Chunk.mesh.Attribute.light := mesh.Attribute.light;
  Chunk.angle := angle;
  Chunk.val_3 := val_3;
  Chunk.val_4 := val_4;
  Result := Chunk;
end;

{ TCamera }

procedure TCamera.Read;
begin
  inherited;
  GLProject := TProjection(BSP.ReadBSPChunk());
end;

procedure TCamera.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
end;

constructor TCamera.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'GLModes';
end;

destructor TCamera.Destroy;
begin
  if GLProject <> nil then
    FreeAndNil(GLProject);
  inherited;
end;

procedure TCamera.Write;
begin
  inherited;
  CalcSize;
  if GLProject <> nil then
    BSP.WriteBSPChunk(GLProject);
end;

function TCamera.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 17;
  GLProject.AddClassNode(TreeView, Result);
end;

function TCamera.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TCamera;
begin
  Chunk := TCamera(inherited CopyChunk(nBSP));
  Chunk.GLProject := TProjection(GLProject.CopyChunk(nBSP));
  Result := Chunk;
end;

{ TProjection }

procedure TProjection.Read;
begin
  render_type := ReadByteBlock;
  render_near := ReadFloatBlock;
  render_far := ReadFloatBlock;
  render_fov := ReadFloatBlock;
  ReadBytesBlock(@render_box.Top, 16);
end;

procedure TProjection.Write;
begin
  inherited;
  WriteByteBlock(render_type);
  WriteFloatBlock(render_near);
  WriteFloatBlock(render_far);
  WriteFloatBlock(render_fov);
  WriteBytesBlock(@render_box.Top, 16);
  CalcSize;
end;

procedure TProjection.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
  AddTreeData(nil, 'Type', @render_type, BSPDword);
  AddTreeData(nil, 'Near Z', @render_near, BSPFloat);
  AddTreeData(nil, 'Far Z', @render_far, BSPFloat);
  AddTreeData(nil, 'Opening Angle Y', @render_fov, BSPFloat);
  AddTreeData(nil, 'Target Area', @render_box.Top, BSPBox);
end;

constructor TProjection.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'GLProject';
end;

destructor TProjection.Destroy;
begin

  inherited;
end;

function TProjection.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 9;
end;

function TProjection.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TProjection;
begin
  Chunk := TProjection(inherited CopyChunk(nBSP));
  Chunk.render_type := render_type;
  Chunk.render_near := render_near;
  Chunk.render_far := render_far;
  Chunk.render_fov := render_fov;
  Chunk.render_box := render_box;
  Result := Chunk;
end;

{ TLightSwitchController }

procedure TLightSwitchController.Read;
begin
  MagicNumber := ReadDword;
  if MagicNumber < 1 then
    GammaRampPower := 4.0
  else
    GammaRampPower := ReadFloat;
  if MagicNumber >= 3 then
    NumSourceLayers := ReadDword;
  if NumSourceLayers > 0 then
  begin
    SetLength(LayerRemapTable, NumSourceLayers);
    ReadBytesBlock(@LayerRemapTable[0], NumSourceLayers * 4);
  end;
  NumLightmaps := ReadDword;
  if NumLightmaps > 0 then
    ReadSwitchableLightmap;
  NumSwitchLayers := ReadDword;
  if NumSwitchLayers > 0 then
    ReadSwitchableLightData;
  NumMatBlocks := ReadDword;
  if NumMatBlocks > 0 then
    ReadMatBlocks;
end;

procedure TLightSwitchController.Write;
begin
  inherited;
  WriteDword(MagicNumber);
  if MagicNumber >= 1 then
    WriteFloat(GammaRampPower);
  if MagicNumber >= 3 then
    WriteDword(NumSourceLayers);
  if NumSourceLayers > 0 then
  begin
    WriteBytesBlock(@LayerRemapTable[0], NumSourceLayers * 4);
  end;
  WriteDword(NumLightmaps);
  if NumLightmaps > 0 then
    WriteSwitchableLightmap;
  WriteDword(NumSwitchLayers);
  if NumSwitchLayers > 0 then
    WriteSwitchableLightData;
  WriteDword(NumMatBlocks);
  if NumMatBlocks > 0 then
    WriteMatBlocks;
  CalcSize;
end;

procedure TLightSwitchController.AddMatBlockSwitchInfo(Node1: PVirtualNode; i: Integer;
  Parr:
  Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('MatBlockSwitchInfo [%d]', [i]), nil, BSPStruct);
  with AMatBlocks(Parr)[i] do
  begin
    AddTreeData(Node2, 'LightingSID', @LightingSID, BSPDword);
    AddTreeData(Node2, 'NumIsWorldGeom', @NumIsWorldGeom, BSPDword);
    AddTreeData(Node2, 'NumVerts', @NumVerts, BSPUint);
  end;
end;

procedure TLightSwitchController.AddSwitchableLightmapData(Node1: PVirtualNode;
  i: Integer; Parr:
  Pointer);
var
  Node2, Node3: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('SwitchableLightmap [%d]', [i]), nil, BSPStruct);
  with ASwitchableLightmap(PArr)[i] do
  begin
    AddTreeData(Node2, 'Texture Hash', @TextureHash, BSPRefHash);
    AddTreeData(Node2, 'Lightmap Texture Name', @LMName, BSPString);
    Node3 := AddTreeData(Node2, 'Update Region', nil, BSPStruct);
    AddTreeData(Node3, 'x', @UpdateRegion.x, BSPint);
    AddTreeData(Node3, 'y', @UpdateRegion.y, BSPint);
    AddTreeData(Node3, 'w', @UpdateRegion.w, BSPint);
    AddTreeData(Node3, 'h', @UpdateRegion.h, BSPint);
    Node3 := AddTreeData(Node2, 'Update Blocks', @NumUpdateBlocks, BSPArray);
    AddLoadingMore(Node3, NumUpdateBlocks, LightmapUpdateBlock, AddLightmapUpdateBlockData);
  end;
end;

procedure TLightSwitchController.AddLayerRemapTable(Node1: PVirtualNode; i: Integer; Parr: Pointer);
begin
  AddTreeData(Node1, format('Layer Remap Table [%d]', [i]), @AList(Parr)[i], BSPDword);
end;

procedure TLightSwitchController.AddAdditiveData(Node1: PVirtualNode; i: Integer; Parr: Pointer);
begin
  AddTreeData(Node1, format('AdditiveData [%d]', [i]), @AList(Parr)[i], BSPColor);
end;

procedure TLightSwitchController.AddSwitchableLightDataData(Node1: PVirtualNode;
  i: Integer; Parr:
  Pointer);
var
  Node2, Node3: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('SwitchableLightData [%d]', [i]), nil, BSPStruct);
  with ASwitchableLightData(Parr)[i] do
  begin
    Node3 := AddTreeData(Node2, 'Dependant Lightmaps', @NumDependantLightmaps, BSPArray);
    AddLoadingMore(Node3, NumDependantLightmaps, Lightmaps, AddLayerRemapTable);
    AddTreeData(Node2, 'Vertex Switch Blocks', @NumVBlocks, BSPUint);
  end;
end;

procedure TLightSwitchController.AddLightmapUpdateBlockData(Node1: PVirtualNode;
  i: Integer; Parr:
  Pointer);
var
  Node2, Node3: PVirtualNode;
  n: integer;
begin
  Node2 := AddTreeData(Node1, format('Lightmap Update Block [%d]', [i]), nil,
    BSPStruct);
  with ALightmapUpdateBlock(PArr)[i] do
  begin
    AddTreeData(Node2, 'Layer Num', @LayerNum, BSPUint);
    Node3 := AddTreeData(Node2, 'Update Sub Rectangle', nil, BSPStruct);
    AddTreeData(Node3, 'x', @UpdateSubRect.x, BSPInt);
    AddTreeData(Node3, 'y', @UpdateSubRect.y, BSPInt);
    AddTreeData(Node3, 'w', @UpdateSubRect.w, BSPInt);
    AddTreeData(Node3, 'h', @UpdateSubRect.h, BSPInt);
    n := Length(AdditiveData);
    Node3 := AddTreeData(Node2, 'Additive Data', @n, BSPArray);
    AddLoadingMore(Node3, n, AdditiveData, AddAdditiveData);
  end;

end;

procedure TLightSwitchController.ReadMatBlocks;
var
  i: integer;
begin
  SetLength(MatBlocks, NumMatBlocks);
  for i := 0 to NumMatBlocks - 1 do
  begin
    MatBlocks[i].LightingSID := ReadDword;
    MatBlocks[i].NumIsWorldGeom := ReadDword;
    MatBlocks[i].NumVerts := ReadDword;
  end;
end;

procedure TLightSwitchController.WriteMatBlocks;
var
  i: integer;
begin
  for i := 0 to NumMatBlocks - 1 do
  begin
    WriteDword(MatBlocks[i].LightingSID);
    WriteDword(MatBlocks[i].NumIsWorldGeom);
    WriteDword(MatBlocks[i].NumVerts);
  end;
end;

procedure TLightSwitchController.ReadSwitchableLightmap;
var
  i, j, n: integer;
begin
  SetLength(SwitchableLightmap, NumLightmaps);
  for i := 0 to NumLightmaps - 1 do
  begin
    SwitchableLightmap[i].TextureHash := ReadDword;
    SwitchableLightmap[i].LMName:= ReadStringSizeWithoutLen(12);
    SwitchableLightmap[i].UpdateRegion.x := ReadDword;
    SwitchableLightmap[i].UpdateRegion.y := ReadDword;
    SwitchableLightmap[i].UpdateRegion.w := ReadDword;
    SwitchableLightmap[i].UpdateRegion.h := ReadDword;
    SwitchableLightmap[i].NumUpdateBlocks := ReadDword;
    if MagicNumber >= 2 then
      SwitchableLightmap[i].NumPixToRead := 0
    else
    SwitchableLightmap[i].NumPixToRead := SwitchableLightmap[i].UpdateRegion.w * SwitchableLightmap[i].UpdateRegion.h;
    SetLength(SwitchableLightmap[i].LightmapUpdateBlock, SwitchableLightmap[i].NumUpdateBlocks);
    for j := 0 to SwitchableLightmap[i].NumUpdateBlocks - 1 do
    begin
      n := SwitchableLightmap[i].NumPixToRead;
      if n <= 0 then
      begin
        SwitchableLightmap[i].LightmapUpdateBlock[j].LayerNum := ReadDword;
        SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.x := ReadSPDword;
        SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.y := ReadSPDword;
        SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.w := ReadSPDword;
        SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.h := ReadSPDword;
        n := SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.w * SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.h;
      end;
      SetLength(SwitchableLightmap[i].LightmapUpdateBlock[j].AdditiveData, n);
      ReadBytesBlock(@SwitchableLightmap[i].LightmapUpdateBlock[j].AdditiveData[0], n * 4);
    end;
  end;
end;

procedure TLightSwitchController.WriteSwitchableLightmap;
var
  i, j, n: integer;
begin
  for i := 0 to NumLightmaps - 1 do
  begin
    WriteDword(SwitchableLightmap[i].TextureHash);
    WriteString(SwitchableLightmap[i].LMName);
    WriteDword(SwitchableLightmap[i].UpdateRegion.x);
    WriteDword(SwitchableLightmap[i].UpdateRegion.y);
    WriteDword(SwitchableLightmap[i].UpdateRegion.w);
    WriteDword(SwitchableLightmap[i].UpdateRegion.h);
    WriteDword(SwitchableLightmap[i].NumUpdateBlocks);

    for j := 0 to SwitchableLightmap[i].NumUpdateBlocks - 1 do
    begin
      n := SwitchableLightmap[i].NumPixToRead;
      if n <= 0 then
      begin
        WriteDword(SwitchableLightmap[i].LightmapUpdateBlock[j].LayerNum);
        WriteSPDword(SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.x);
        WriteSPDword(SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.y);
        WriteSPDword(SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.w);
        WriteSPDword(SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.h);
        n := SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.w * SwitchableLightmap[i].LightmapUpdateBlock[j].UpdateSubRect.h;
      end;
      WriteBytesBlock(@SwitchableLightmap[i].LightmapUpdateBlock[j].AdditiveData[0], n * 4);
    end;
  end;
end;

procedure TLightSwitchController.ReadSwitchableLightData;
var
  i, j: integer;
begin
  SetLength(SwitchableLightData, NumSwitchLayers);
  for i := 0 to NumSwitchLayers - 1 do
  begin
    SwitchableLightData[i].NumDependantLightmaps := ReadDword;
    SetLength(SwitchableLightData[i].Lightmaps, SwitchableLightData[i].NumDependantLightmaps);
    ReadBytesBlock(@SwitchableLightData[i].Lightmaps[0], SwitchableLightData[i].NumDependantLightmaps * 4);
    SwitchableLightData[i].NumVBlocks := ReadDword;
    SetLength(SwitchableLightData[i].VertexBlocks, SwitchableLightData[i].NumVBlocks);
    for j := 0 to SwitchableLightData[i].NumVBlocks - 1 do
    begin // num2 = 0 allways
      SwitchableLightData[i].VertexBlocks[j].MatBlockIndex := ReadDword;
      SwitchableLightData[i].VertexBlocks[j].NumUpdateVerts := ReadDword;
      SetLength(SwitchableLightData[i].VertexBlocks[j].UpdateList, SwitchableLightData[i].VertexBlocks[j].NumUpdateVerts);
      ReadBytesBlock(@SwitchableLightData[i].VertexBlocks[j].UpdateList[0], SwitchableLightData[i].VertexBlocks[j].NumUpdateVerts * 8);
    end;
  end;
end;

procedure TLightSwitchController.WriteSwitchableLightData;
var
  i, j: integer;
begin
  for i := 0 to NumSwitchLayers - 1 do
  begin
    WriteDword(SwitchableLightData[i].NumDependantLightmaps);
    WriteBytesBlock(@SwitchableLightData[i].Lightmaps[0], SwitchableLightData[i].NumDependantLightmaps * 4);
    WriteDword(SwitchableLightData[i].NumVBlocks);
    for j := 0 to SwitchableLightData[i].NumVBlocks - 1 do
    begin // num2 = 0 allways
      WriteDword(SwitchableLightData[i].VertexBlocks[j].MatBlockIndex);
      WriteDword(SwitchableLightData[i].VertexBlocks[j].NumUpdateVerts);
      WriteBytesBlock(@SwitchableLightData[i].VertexBlocks[j].UpdateList[0], SwitchableLightData[i].VertexBlocks[j].NumUpdateVerts * 8);
    end;
  end;
end;

procedure TLightSwitchController.AddFields(CustomTree:
  TCustomVirtualStringTree);
var
  tempNode: PVirtualNode;
begin
  inherited;
  AddTreeData(nil, 'Magic Number', @MagicNumber, BSPUint);
  AddTreeData(nil, 'Gamma Ramp Power', @GammaRampPower, BSPFloat);
  tempNode := AddTreeData(nil, 'Source Layers', @NumSourceLayers, BSPArray);
  AddLoadingMore(tempNode, NumSourceLayers, LayerRemapTable, AddLayerRemapTable);
  tempNode := AddTreeData(nil, 'Switchable Lightmaps', @NumLightmaps, BSPArray);
  AddLoadingMore(tempNode, NumLightmaps, SwitchableLightmap, AddSwitchableLightmapData);
  tempNode := AddTreeData(nil, 'Switchable Light Datas', @NumSwitchLayers, BSPArray);
  AddLoadingMore(tempNode, NumSwitchLayers, SwitchableLightData, AddSwitchableLightDataData);
  tempNode := AddTreeData(nil, 'MatBlock Switch Infos', @NumMatBlocks, BSPArray);
  AddLoadingMore(tempNode, NumMatBlocks, MatBlocks, AddMatBlockSwitchInfo);
end;

constructor TLightSwitchController.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Switchable Lights';
end;

destructor TLightSwitchController.Destroy;
var
  i, j: integer;
begin
  SetLength(MatBlocks, 0);
  if Length(SwitchableLightmap) > 0 then
  begin
    for i := 0 to Length(SwitchableLightmap) - 1 do
      if Length(SwitchableLightmap[i].LightmapUpdateBlock) > 0 then
      begin
        for j := 0 to Length(SwitchableLightmap[i].LightmapUpdateBlock) - 1 do
          SetLength(SwitchableLightmap[i].LightmapUpdateBlock[j].AdditiveData, 0);
        SetLength(SwitchableLightmap[i].LightmapUpdateBlock, 0);
      end;
    SetLength(SwitchableLightmap, 0);
  end;
  if Length(SwitchableLightData) > 0 then
  begin
    for i := 0 to Length(SwitchableLightData) - 1 do
    begin
      SetLength(SwitchableLightData[i].Lightmaps, 0);
      if Length(SwitchableLightData[i].VertexBlocks) > 0 then
        for j := 0 to Length(SwitchableLightData[i].VertexBlocks) - 1 do
          SetLength(SwitchableLightData[i].VertexBlocks[j].UpdateList, 0);
      SetLength(SwitchableLightData[i].VertexBlocks, 0);
    end;
    SetLength(SwitchableLightData, 0);
  end;
  inherited;
end;

function TLightSwitchController.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 25;
end;

{ TAnimKeyBlock }

procedure TAnimKeyBlock.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1: PVirtualNode;
begin
  inherited;
  AddTreeData(nil, 'Type', @key_type, BSPKeyType);
  AddTreeData(nil, 'Target Hash', @bone_hash, BSPRefHash);
  AddTreeData(nil, 'Target Speed', @acceleration, BSPFloat);
  AddTreeData(nil, 'Num Keys', @key_num, BSPUint);
  AddTreeData(nil, 'MatBlock Index', @mesh_id, BSPSInt);
  if is_bound then
    AddBoundData(nil, bound);
  AddTreeData(nil, 'Interpolation Type', @ext_pos, BSPBool);
  if is_time_keys then
  begin
    Node1 := AddTreeData(nil, 'Times', @key_num, BSPArray);
    AddLoadingMore(Node1, key_num, time_keys, AddTimeData);
  end;

  case key_type of
    K_Rot: // word block
      begin
        Node1 := AddTreeData(nil, 'Rotation Keys', @key_num, BSPArray);
        AddLoadingMore(Node1, key_num, rot_keys, AddRotData);
      end;
    K_Pos: // vector block
      begin
        Node1 := AddTreeData(nil, 'Translate Keys', @key_num, BSPArray);
        AddLoadingMore(Node1, key_num, pos_keys, AddVBlockData);
      end;
    K_Vect: // unk blocks
      begin
        Node1 := AddTreeData(nil, 'Shape Keys', @key_num, BSPArray);
        AddLoadingMore(Node1, key_num, vert_keys, AddBlock2Data);
      end;
    K_UV: // UV block
      begin
        Node1 := AddTreeData(nil, 'UV Keys', @key_num, BSPArray);
        AddLoadingMore(Node1, key_num, UV_keys, AddUVBlockData);
      end;
    K_Vis: // byte block
      begin
        Node1 := AddTreeData(nil, 'State Keys', @key_num, BSPArray);
        AddLoadingMore(Node1, key_num, vis_keys, AddLayerRemapTable);
      end;
  end;

  Node1 := AddTreeData(nil, 'Have ADPCM', @is_func, BSPBool);
  if is_func then
    with vect_func do
    begin
      AddTreeData(Node1, 'Vertex Type', @vert_type, BSPUint);
      AddTreeData(Node1, 'Normal Type', @norm_type, BSPUint);
      AddTreeData(Node1, 'Vertex Range', @vert, BSPVect);
      AddTreeData(Node1, 'Normal Range', @norm, BSPVect);
    end;
end;

procedure TAnimKeyBlock.AddRotData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Key [%d]', [i]), @AKeyRot(PArr)[i], BSPRVect);
end;

procedure TAnimKeyBlock.AddVBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('vect [%d]', [i]), @AVer(Parr)[i], BSPVect);
end;

procedure TAnimKeyBlock.AddWTBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('[%d]', [i]), @AWord(Parr)[i], BSPUVWord);
end;

procedure TAnimKeyBlock.AddWIBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('[%d]', [i]), @AWord(Parr)[i], BSPSint);
end;

procedure TAnimKeyBlock.AddWBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('[%d]', [i]), @AWord(Parr)[i], BSPWord);
end;

procedure TAnimKeyBlock.AddBlock2Data(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2, Node3: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Shape [%d]', [i]), nil, BSPStruct);
  with AKeyVert(PArr)[i] do
  begin
    if num > 0 then
    begin
      if is_vect then
      begin
        Node3 := AddTreeData(Node2, 'XYZs', nil, BSPStruct);
        AddLoadingMore(Node3, num, vert, AddVBlockData);
      end
      else
      begin
        Node3 := AddTreeData(Node2, 'vert_ind', nil, BSPStruct);
        AddLoadingMore(Node3, num, vert_ind, AddWIBlockData);
        Node3 := AddTreeData(Node2, 'vert_func', nil, BSPStruct);
        AddLoadingMore(Node3, num, vert_func, AddWBlockData);
      end;
    end;
    if num2 > 0 then
    begin
      if is_vect then
      begin
        Node3 := AddTreeData(Node2, 'norm', nil, BSPStruct);
        AddLoadingMore(Node3, num2, norm, AddVBlockData);
      end
      else
      begin
        Node3 := AddTreeData(Node2, 'norm_ind', nil, BSPStruct);
        AddLoadingMore(Node3, num2, norm_ind, AddWIBlockData);
        Node3 := AddTreeData(Node2, 'norm_func', nil, BSPStruct);
        AddLoadingMore(Node3, num2, norm_func, AddWBlockData);
      end;
    end;
  end;
end;

procedure TAnimKeyBlock.AddUVBlockData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2, Node3: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('Key [%d]', [i]), nil, BSPStruct);
  with AKeyUVBlock(PArr)[i] do
  begin
    if num > 0 then
    begin
      Node3 := AddTreeData(Node2, 'fxU', nil, BSPStruct);
      AddLoadingMore(Node3, num, U_keys, AddWTBlockData);
      Node3 := AddTreeData(Node2, 'fxV', nil, BSPStruct);
      AddLoadingMore(Node3, num, V_keys, AddWTBlockData);
    end;
    if num2 > 0 then
    begin
      Node3 := AddTreeData(Node2, 'fxU 2', nil, BSPStruct);
      AddLoadingMore(Node3, num2, U2_keys, AddWTBlockData);
      Node3 := AddTreeData(Node2, 'fxV 2', nil, BSPStruct);
      AddLoadingMore(Node3, num2, V2_keys, AddWTBlockData);
    end;
  end;
end;

procedure TAnimKeyBlock.AddLayerRemapTable(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('State [%d]', [i]), @AByte(Parr)[i], BSPByte);
end;

procedure TAnimKeyBlock.AddTimeData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
begin
  AddTreeData(Node1, format('Time [%d]', [i]), @time_keys[i], BSPFloat);
end;

constructor TAnimKeyBlock.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Key';
  Version := 1698;
  IDType := 1015;
end;

destructor TAnimKeyBlock.Destroy;
var
  i, j: integer;
begin
  SetLength(time_keys, 0);
  SetLength(rot_keys, 0);
  SetLength(pos_keys, 0);
  if Length(vert_keys) > 0 then
  begin
    for i := 0 to High(vert_keys) do
    begin
      SetLength(vert_keys[i].vert, 0);
      SetLength(vert_keys[i].norm, 0);
      SetLength(vert_keys[i].vert_ind, 0);
      SetLength(vert_keys[i].vert_func, 0);
      SetLength(vert_keys[i].norm_ind, 0);
      SetLength(vert_keys[i].norm_func, 0);
    end;
    SetLength(vert_keys, 0);
  end;
  if Length(UV_keys) > 0 then
  begin
    for i := 0 to High(UV_keys) do
    begin
      SetLength(UV_keys[i].U_keys, 0);
      SetLength(UV_keys[i].V_keys, 0);
      SetLength(UV_keys[i].U2_keys, 0);
      SetLength(UV_keys[i].V2_keys, 0);
    end;
    SetLength(UV_keys, 0);
  end;
  SetLength(vis_keys, 0);
  inherited;
end;

procedure TAnimKeyBlock.Read;
var
  i, j: integer;
begin
  key_type := ReadSPDWord;
  bone_hash := ReadDWord;
  acceleration := ReadFloat;
  key_num := ReadSPDword;
  mesh_id := ReadSPWord;
  is_bound := Boolean(ReadDword);
  if is_bound then
    bound := ReadBound;
  ext_pos := Boolean(ReadSPDword);
  is_time_keys := Boolean(ReadDword);
  if is_time_keys then
  begin
    SetLength(time_keys, key_num);
    ReadBytesBlock(@time_keys[0], key_num * 4); // ReadFloat
  end;
  case key_type of
    K_Rot: // word block Rotate Vector
      begin
        SetLength(rot_keys, key_num); //8
        for i := 0 to key_num - 1 do
        begin
          rot_keys[i].RotX := Word(ReadSPDword);
          rot_keys[i].RotY := Word(ReadSPDword);
          rot_keys[i].RotZ := Word(ReadSPDword);
          rot_keys[i].RotW := Word(ReadSPDword);
        end;
      end;
    K_Pos: // vector block Pos Vector
      begin
        SetLength(pos_keys, key_num); //12
        for i := 0 to key_num - 1 do
        begin
          pos_keys[i][0] := ReadFloat;
          pos_keys[i][1] := ReadFloat;
          pos_keys[i][2] := ReadFloat;
        end;
      end;
    K_Vect: // blocks
      begin
        SetLength(vert_keys, key_num); //  24
        for i := 0 to key_num - 1 do
          with vert_keys[i] do
          begin
            is_vect := Boolean(ReadDword);
            num := ReadSPWord;
            if num > 0 then
            begin
              if is_vect then
              begin // vertex
                SetLength(vert, num);
                for j := 0 to num - 1 do
                begin
                  vert[i][0] := ReadFloat;
                  vert[i][1] := ReadFloat;
                  vert[i][2] := ReadFloat;
                end;
              end
              else
              begin
                SetLength(vert_ind, num);
                SetLength(vert_func, num);
                ReadBytesBlock(@vert_ind[0], num * 2); // ReadSPWord2  wblock1
                ReadBytesBlock(@vert_func[0], num * 2); // ReadSPWord2  vlbock1
              end;
            end;
            num2 := ReadSPWord;
            if num2 > 0 then
            begin
              if is_vect then
              begin // normal
                SetLength(norm, num2);
                for j := 0 to num2 - 1 do
                begin
                  norm[i][0] := ReadFloat;
                  norm[i][1] := ReadFloat;
                  norm[i][2] := ReadFloat;
                end;
              end
              else
              begin
                SetLength(norm_ind, num2);
                SetLength(norm_func, num2);
                ReadBytesBlock(@norm_ind[0], num2 * 2); // ReadSPWord2  wblock2
                ReadBytesBlock(@norm_func[0], num2 * 2); // ReadSPWord2  vlbock2
              end;
            end;
          end;
      end;
    K_UV: // unk block UV Coord
      begin
        SetLength(UV_keys, key_num); //  20
        for i := 0 to key_num - 1 do
        begin
          with UV_keys[i] do
          begin
            num := ReadSPWord;
            if num > 0 then
            begin
              SetLength(U_keys, num);
              SetLength(V_keys, num);
              ReadBytesBlock(@U_keys[0], num * 2); // ReadSPWord
              ReadBytesBlock(@V_keys[0], num * 2); // ReadSPWord
            end;
            num2 := ReadSPWord;
            if num2 > 0 then
            begin
              SetLength(U2_keys, num);
              SetLength(V2_keys, num);
              ReadBytesBlock(@U2_keys[0], num * 2); // ReadSPWord
              ReadBytesBlock(@V2_keys[0], num * 2); // ReadSPWord
            end;
          end;
        end;
      end;
    K_Vis: // byte block
      begin
        SetLength(vis_keys, key_num); //12
        ReadBytesBlock(@vis_keys[0], key_num); // ReadByte
      end;
  end;
  is_func := Boolean(ReadDword);
  if is_func then
    with vect_func do
    begin
      vert_type := ReadDword;
      norm_type := ReadDword;
      vert[0] := ReadFloat;
      vert[1] := ReadFloat;
      vert[2] := ReadFloat;
      norm[0] := ReadFloat;
      norm[1] := ReadFloat;
      norm[2] := ReadFloat;
    end;
  //CheckSize;
end;

procedure TAnimKeyBlock.Write;
var
  i, j: integer;
begin
  inherited;

  WriteSPDWord(key_type);
  WriteDWord(bone_hash);
  WriteFloat(acceleration);
  WriteSPDword(key_num);
  WriteSPWord(mesh_id);
  WriteBoolean(is_bound);
  if is_bound then
    WriteBound(bound);
  WriteBoolean(ext_pos);
  WriteBoolean(is_time_keys);
  if is_time_keys then
  begin
    WriteBytesBlock(@time_keys[0], key_num * 4); // WriteFloat
  end;
  case key_type of
    K_Rot: // word block Rotate Vector
      begin
        for i := 0 to key_num - 1 do
        begin
          WriteSPDword(rot_keys[i].RotX);
          WriteSPDword(rot_keys[i].RotY);
          WriteSPDword(rot_keys[i].RotZ);
          WriteSPDword(rot_keys[i].RotW);
        end;
      end;
    K_Pos: // vector block Pos Vector
      begin
        for i := 0 to key_num - 1 do
        begin
          WriteFloat(pos_keys[i][0]);
          WriteFloat(pos_keys[i][1]);
          WriteFloat(pos_keys[i][2]);
        end;
      end;
    K_Vect: // blocks
      begin
        for i := 0 to key_num - 1 do
          with vert_keys[i] do
          begin
            WriteBoolean(is_vect);
            WriteSPWord(num);
            if num > 0 then
            begin
              if is_vect then
              begin
                for j := 0 to num - 1 do
                begin
                  WriteFloat(vert[i][0]);
                  WriteFloat(vert[i][1]);
                  WriteFloat(vert[i][2]);
                end;
              end
              else
              begin
                WriteBytesBlock(@vert_ind[0], num * 2); // WriteSPWord2  wblock1
                WriteBytesBlock(@vert_func[0], num * 2); // WriteSPWord2  vlbock1
              end;
            end;
            WriteSPWord(num2);
            if num2 > 0 then
            begin
              if is_vect then
              begin
                for j := 0 to num2 - 1 do
                begin
                  WriteFloat(norm[i][0]);
                  WriteFloat(norm[i][1]);
                  WriteFloat(norm[i][2]);
                end;
              end
              else
              begin
                WriteBytesBlock(@norm_ind[0], num2 * 2); // WriteSPWord2  wblock2
                WriteBytesBlock(@norm_func[0], num2 * 2);
                // WriteSPWord2  vlbock2
              end;
            end;
          end;
      end;
    K_UV: // unk block UV Coord
      begin
        for i := 0 to key_num - 1 do
        begin
          with UV_keys[i] do
          begin
            WriteSPWord(num);
            if num > 0 then
            begin
              WriteBytesBlock(@U_keys[0], num * 2); // WriteSPWord
              WriteBytesBlock(@V_keys[0], num * 2); // WriteSPWord
            end;
            WriteSPWord(num2);
            if num2 > 0 then
            begin
              WriteBytesBlock(@U2_keys[0], num * 2); // WriteSPWord
              WriteBytesBlock(@V2_keys[0], num * 2); // WriteSPWord
            end;
          end;
        end;
      end;
    K_Vis: // byte block
      begin
        WriteBytesBlock(@vis_keys[0], key_num); // WriteByte
      end;
  end;
  WriteBoolean(is_func);
  if is_func then
    with vect_func do
    begin
      WriteDword(vert_type);
      WriteDword(norm_type);
      WriteFloat(vert[0]);
      WriteFloat(vert[1]);
      WriteFloat(vert[2]);
      WriteFloat(norm[0]);
      WriteFloat(norm[1]);
      WriteFloat(norm[2]);
    end;
  CalcSize;
end;

function TAnimKeyBlock.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 8;
  //  Data^.Hash:=Format('[%.*x]',[8,TAnimKeyBlock(Chunk).hash_name]);
end;

procedure TAnimKeyBlock.UpdateNode(CustomTree: TCustomVirtualStringTree;
  PData: PPropertyData);

  procedure ChangeKeysLength(VectorData: boolean = false);
  var
    i, j, vert_num: integer;
    Bone: TSpFrame;
    Model: TRenderBlock;
    InitData: boolean;
  begin
    Bone := Clip.GetBone(bone_hash);
    InitData := False;
    if Bone <> nil then
    begin
      Model := Bone.GetModel(mesh_id);
      if Model <> nil then
      begin
        vert_num := Model.vertex_count;
        if VectorData then
          InitData := true;
      end;
    end;
    if (vert_num = 0) or (Length(vert_keys) = 0) then
    begin
      vert_num := 1;
      VectorData := false;
    end;

    case key_type of
      K_Rot: // word block Rotate Vector
        begin
          if Length(rot_keys) <> key_num then
            SetLength(rot_keys, key_num);
        end;
      K_Pos: // vector block Pos Vector
        begin
          if Length(pos_keys) <> key_num then
            SetLength(pos_keys, key_num);
        end;
      K_Vect: // blocks
        begin
          if (Length(vert_keys) <> key_num) or InitData then
          begin
            SetLength(vert_keys, key_num); //  24
            for i := 0 to key_num - 1 do
              with vert_keys[i] do
              begin
                if (num = 0) or InitData then
                begin
                  num := vert_num;
                  is_vect := VectorData;
                end;
                if is_vect then
                begin
                  SetLength(vert, num);
                  if InitData then
                    Move(Model.mesh.Vert[0], vert[0], num * SizeOf(TVer));
                end
                else
                begin
                  SetLength(vert_ind, num);
                  SetLength(vert_func, num);
                end;
                if num2 > 0 then
                begin
                  if is_vect then
                  begin
                    SetLength(norm, num2);
                    if InitData then
                      Move(Model.mesh.Normal[0], norm[0], num * SizeOf(TVer));
                  end
                  else
                  begin
                    SetLength(norm_ind, num2);
                    SetLength(norm_func, num2);
                  end;
                end;
              end;
          end;
        end;
      K_UV: // unk block UV Coord
        begin
          if Length(UV_keys) <> key_num then
          begin
            SetLength(UV_keys, key_num); //  20
            for i := 0 to key_num - 1 do
              with UV_keys[i] do
              begin
                if num = 0 then
                  num := vert_num;
                if num > 0 then
                begin
                  SetLength(U_keys, num);
                  SetLength(V_keys, num);
                end;
                if num2 > 0 then
                begin
                  SetLength(U2_keys, num);
                  SetLength(V2_keys, num);
                end;
              end;
          end;
        end;
      K_Vis: // byte block
        begin
          if Length(vis_keys) <> key_num then
            SetLength(vis_keys, key_num);
        end;
    end;
  end;
begin
  if PData.DName = 'key_type' then
  begin
    if key_type = K_Vect then
      if Length(vert_keys) <> key_num then
        is_func := True;
    ChangeKeysLength;
  end
  else if PData.DName = 'key_num' then
  begin
    if is_time_keys then
      SetLength(time_keys, key_num);
    ChangeKeysLength;
  end
  else if PData.DName = 'vect_func' then
  begin
    if (key_type = K_Vect) then
    begin
      if is_func then
      begin
        SetLength(vert_keys, 0);
        ChangeKeysLength(False);
      end
      else
        ChangeKeysLength(True);
    end;
  end;
  inherited;
end;

procedure TAnimKeyBlock.LoadPosFlomDAE(BoneHash: Cardinal;
  TimeMatrix: ATimeMatrix; Dzero: Boolean);
var
  i, f, d, key1, key2, key3: integer;
  pos: TVer;
  pos_keys2: AVer;
  time_keys2: AFloat;
  function CheckMidPos(key1, key2, key3: integer): Boolean;
  var
    PosA: TVer;
    divTime: Single;
  begin
    if SamePos(@pos_keys[key1], @pos_keys[key3]) and
      SamePos(@pos_keys[key2], @pos_keys[key3]) then
    begin
      Result := True;
      Exit;
    end;

    divTime := (time_keys[key2] - time_keys[key1]) / (time_keys[key3] -
      time_keys[key1]);

    PosA[0] := pos_keys[key1][0] + (pos_keys[key3][0] - pos_keys[key1][0]) *
      divTime;
    PosA[1] := pos_keys[key1][1] + (pos_keys[key3][1] - pos_keys[key1][1]) *
      divTime;
    PosA[2] := pos_keys[key1][2] + (pos_keys[key3][2] - pos_keys[key1][2]) *
      divTime;

    Result := SamePos(@PosA, @pos_keys[key2]);
  end;
begin
  key_type := K_Pos;
  bone_hash := BoneHash;
  acceleration := 0.0;
  key_num := Length(TimeMatrix);
  mesh_id := -1;
  is_bound := false;
  ext_pos := false;
  is_time_keys := true;

  SetLength(time_keys, key_num);
  SetLength(pos_keys, key_num); //12
  // pass 1
  f := 0;
  d := 0;
  if Dzero then
  begin
    d := 1;
    Pos[0] := TimeMatrix[0].Matrix[4][1];
    Pos[1] := TimeMatrix[0].Matrix[4][2];
    Pos[2] := TimeMatrix[0].Matrix[4][3];
  end;
  for i := d to key_num - 2 do
  begin
    if (i > 0) and SamePos(@Pos, @TimeMatrix[i].Matrix[4])
      and SamePos(@Pos, @TimeMatrix[i + 1].Matrix[4]) then
      Continue;

    time_keys[f] := TimeMatrix[i].time;
    pos_keys[f][0] := TimeMatrix[i].Matrix[4][1];
    pos_keys[f][1] := TimeMatrix[i].Matrix[4][2];
    pos_keys[f][2] := TimeMatrix[i].Matrix[4][3];
    Pos := pos_keys[f];
    Inc(f);
  end;
  i := key_num - 1;
  if not SamePos(@Pos, @TimeMatrix[i].Matrix[4]) then
  begin
    time_keys[f] := TimeMatrix[i].time;
    pos_keys[f][0] := TimeMatrix[i].Matrix[4][1];
    pos_keys[f][1] := TimeMatrix[i].Matrix[4][2];
    pos_keys[f][2] := TimeMatrix[i].Matrix[4][3];
    Inc(f);
  end;
  key_num := f;
  // pass 2
  if key_num > 2 then
  begin
    SetLength(time_keys2, key_num);
    SetLength(pos_keys2, key_num); //8
    key1 := 0;
    f := 0;
    //  if not Dzero then begin
    pos_keys2[f] := pos_keys[0];
    time_keys2[f] := time_keys[0];
    Inc(f);
    //  end;
    for i := 1 to key_num - 2 do
    begin
      key2 := i;
      key3 := i + 1;
      if not CheckMidPos(key1, key2, key3) then
      begin
        pos_keys2[f] := pos_keys[key2];
        time_keys2[f] := time_keys[key2];
        key1 := i;
        Inc(f);
      end;
    end;
    if not SamePos(@pos_keys[key1], @pos_keys[key3]) then
    begin
      pos_keys2[f] := pos_keys[key3];
      time_keys2[f] := time_keys[key3];
      Inc(f);
    end;
    time_keys := Copy(time_keys2, 0, f);
    pos_keys := Copy(pos_keys2, 0, f);
    SetLength(time_keys2, 0);
    SetLength(pos_keys2, 0); //8
  end;
  key_num := f;
  SetLength(time_keys, key_num);
  SetLength(pos_keys, key_num);
  is_func := false;
end;

procedure TAnimKeyBlock.LoadRotFlomDAE(BoneHash: Cardinal;
  TimeMatrix: ATimeMatrix; Dzero: Boolean);
var
  i, j, f, d, key1, key2, key3: integer;
  Rot: TVer4f;
  R1Matrix: TMatrix;
  divTime: Single;
  time_keys2: AFloat;
  rot_keys2: AKeyRot;
  function QuatToRot(PRot: PQuat): TKeyRot;
  begin
    Result.RotX := Round(PRot^.x / 0.000030518509);
    Result.RotY := Round(PRot^.y / 0.000030518509);
    Result.RotZ := Round(PRot^.z / 0.000030518509);
    Result.RotW := Round(PRot^.w / 0.000030518509);
  end;
  function RotToQuat(Rot: TKeyRot): Quat;
  begin
    Result.x := Rot.RotX * 0.000030518509;
    Result.y := Rot.RotY * 0.000030518509;
    Result.z := Rot.RotZ * 0.000030518509;
    Result.w := Rot.RotW * 0.000030518509;
  end;
  function CheckMidRot(key1, key2, key3: integer): Boolean;
  var
    u: Single;
    q1, q2, a: Quat;
    RotA: TKeyRot;
  begin
    if SameWRot(rot_keys[key1], rot_keys[key3]) and
      SameWRot(rot_keys[key2], rot_keys[key3]) then
    begin
      Result := True;
      Exit;
    end;

    divTime := (time_keys[key2] - time_keys[key1]) / (time_keys[key3] -
      time_keys[key1]);
    q1 := RotToQuat(rot_keys[key1]);
    q2 := RotToQuat(rot_keys[key3]);

    if QuatAverage(a, q1, q2, divTime) then
    else
    begin
      QuatNormalize(q1);
      QuatNormalize(q2);
      QuatAverage(a, q1, q2, divTime);
    end;
    RotA := QuatToRot(@a);
    Result := SameWRot(RotA, rot_keys[key2]);
  end;
begin
  key_type := K_Rot;
  bone_hash := BoneHash;
  acceleration := 0.0;
  key_num := Length(TimeMatrix);
  mesh_id := -1;
  is_bound := false;
  ext_pos := false;
  is_time_keys := true;

  SetLength(time_keys, key_num);
  SetLength(rot_keys, key_num); //8

  // pass 1
  f := 0;
  if key_num > 2 then
  begin
    for i := 0 to key_num - 2 do
    begin
      if (i > 0) and (SameRotMatrix(R1Matrix, TimeMatrix[i].Matrix)) and
        (SameRotMatrix(TimeMatrix[i].Matrix, TimeMatrix[i + 1].Matrix)) then
        Continue;
      time_keys[f] := TimeMatrix[i].time;
      Rot := MatrixToQuat(TimeMatrix[i].Matrix);
      rot_keys[f] := QuatToRot(@Rot);
      R1Matrix := TimeMatrix[i].Matrix;
      Inc(f);
    end;
  end
  else
  begin
    time_keys[f] := TimeMatrix[0].time;
    Rot := MatrixToQuat(TimeMatrix[0].Matrix);
    rot_keys[f] := QuatToRot(@Rot);
    R1Matrix := TimeMatrix[0].Matrix;
    Inc(f);
  end;
  i := key_num - 1;
  if not SameRotMatrix(R1Matrix, TimeMatrix[i].Matrix) then
  begin
    time_keys[f] := TimeMatrix[i].time;
    Rot := MatrixToQuat(TimeMatrix[i].Matrix);
    rot_keys[f] := QuatToRot(@Rot);
    Inc(f);
  end;
  key_num := f;
  // pass 2
  if key_num > 2 then
  begin
    SetLength(time_keys2, key_num);
    SetLength(rot_keys2, key_num); //8
    key1 := 0;
    f := 0;
    if not Dzero then
    begin
      rot_keys2[f] := rot_keys[0];
      time_keys2[f] := time_keys[0];
      Inc(f);
    end;
    for i := 1 to key_num - 2 do
    begin
      key2 := i;
      key3 := i + 1;
      // compare rot[1] rot[2] rot[3] where rot[2]= Midle(rot1,rot2,time[2]);
      if not CheckMidRot(key1, key2, key3) then
      begin
        rot_keys2[f] := rot_keys[key2];
        time_keys2[f] := time_keys[key2];
        key1 := i;
        Inc(f);
      end;
    end;
    if not SameWRot(rot_keys[key1], rot_keys[key3]) then
    begin
      rot_keys2[f] := rot_keys[key3];
      time_keys2[f] := time_keys[key3];
      Inc(f);
    end;
    time_keys := Copy(time_keys2, 0, f);
    rot_keys := Copy(rot_keys2, 0, f);
    SetLength(time_keys2, 0);
    SetLength(rot_keys2, 0); //8
  end;
  key_num := f;
  SetLength(time_keys, key_num);
  SetLength(rot_keys, key_num); //8
  is_func := false;
end;

function TAnimKeyBlock.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TAnimKeyBlock;
begin
  Chunk := TAnimKeyBlock(inherited CopyChunk(nBSP));
  Chunk.key_type := key_type;
  Chunk.bone_hash := bone_hash;
  Chunk.acceleration := acceleration;
  Chunk.key_num := key_num;
  Chunk.mesh_id := mesh_id;
  Chunk.is_bound := is_bound;
  Chunk.ext_pos := ext_pos;
  Chunk.is_time_keys := is_time_keys;
  Chunk.time_keys := Copy(time_keys);
  Chunk.bound := bound;
  Chunk.pos_keys := Copy(pos_keys);
  Chunk.rot_keys := Copy(rot_keys);
  Chunk.vert_keys := Copy(vert_keys);
  Chunk.UV_keys := Copy(UV_keys);
  Chunk.vis_keys := Copy(vis_keys);
  Chunk.is_func := is_func;
  // copy
  Result := Chunk;
end;

{ TDictAnim }

procedure TDictAnim.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1: PVirtualNode;
begin
  inherited;
  AddTreeData(nil, 'Name Hash', @hash, BSPHash);
  AddTreeData(nil, 'Min Time', @minTime, BSPFloat);
  AddTreeData(nil, 'Max Time', @maxTime, BSPFloat);
  Node1 := AddTreeData(nil, 'Base Poses', @bone_num, BSPArray);
  AddLoadingMore(Node1, bone_num, bone_block, AddBoneData);
  Node1 := AddTreeData(nil, 'Sequences', @keys_num, BSPArray);
  AddLoadingMore(Node1, keys_num, Keys, AddKeysData);
  AddTreeData(nil, 'Name', @name, BSPString);
end;

procedure TDictAnim.AddKeysData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2: PVirtualNode;
  Data: PPropertyData;
begin
  Node2 := AddTreeData(Node1, format('Sequence [%d]', [i]), nil, BSPChunk, Keys[i].TypeName);
  Data := DataTree.GetNodeData(Node2);
  Data^.Obj := @Keys[i];
  Data^.ValueIndex := 8;
end;

procedure TDictAnim.AddBoneData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2: PVirtualNode;
  Node3: PVirtualNode;
  s: string;
begin
  s := '';
  if ABoneBlock(PArr)[i].bone <> nil then
    s := ABoneBlock(PArr)[i].bone.name;
  Node2 := AddTreeData(Node1, format('Base Pose [%d]', [i]), nil, BSPStruct, s);
  with ABoneBlock(PArr)[i] do
  begin
    AddTreeData(Node2, 'Bone Hash', @boneHash, BSPRefHash);
    Node3 := AddTreeData(Node2, 'Base Pose hash', @frameHash, BSPRefHash);
    AddTreeData(Node3, 'Rot', @frame^.RotX, BSPRVect);
    AddTreeData(Node3, 'Pos', @frame^.PosX, BSPVect);
  end;
end;

constructor TDictAnim.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Clip';
  Version := 1698;
  IDType := 1027;
end;

destructor TDictAnim.Destroy;
var
  i: integer;
begin
  SetLength(bone_block, 0);
  if Length(Keys) > 0 then
  begin
    for i := 0 to Length(Keys) - 1 do
      if Keys[i] <> nil then
        FreeAndNil(Keys[i]);
    SetLength(Keys, 0);
  end;
  inherited;
end;

procedure TDictAnim.Read;
var
  i: Integer;
begin
  hash := ReadSPDword;
  minTime := ReadFloat;
  maxTime := ReadFloat;
  bone_num := ReadSPDword;
  SetLength(bone_block, bone_num);
  for i := 0 to bone_num - 1 do
  begin
    bone_block[i].boneHash := ReadDword;
    bone_block[i].frameHash := ReadDword;
  end;
  keys_num := ReadSPDword;
  SetLength(Keys, keys_num);
  name := ReadStringSize(32);
  if Length(name) > 0 then
    TypeName := format('Clip "%s"', [name]);
  for i := 0 to keys_num - 1 do
  begin
    Keys[i] := TAnimKeyBlock(BSP.ReadBSPChunk());
    Keys[i].Clip := Self;
    Keys[i].TypeName := format('Key #%d', [i]);
  end;
end;

procedure TDictAnim.Write;
var
  i: Integer;
begin
  inherited;
  WriteSPDword(hash);
  WriteFloat(minTime);
  WriteFloat(maxTime);
  WriteSPDword(bone_num);
  for i := 0 to bone_num - 1 do
  begin
    WriteDword(bone_block[i].boneHash);
    WriteDword(bone_block[i].frameHash);
  end;
  WriteSPDword(keys_num);
  WriteStringSize(name, 32);
  CalcSize;
  for i := 0 to keys_num - 1 do
  begin
    BSP.WriteBSPChunk(Keys[i]);
  end;
end;

procedure TDictAnim.LinkFrames(Frames: AFrames);
var
  i, f, l: integer;
begin
  l := Length(Frames);
  for i := 0 to bone_num - 1 do
  begin
    for f := 0 to l - 1 do
      if bone_block[i].frameHash = Frames[f].Hash then
      begin
        bone_block[i].frame := @Frames[f];
        Break;
      end;
  end;
end;

function TDictAnim.LinkBones(Bones: AChunk): Boolean;
var
  i, b, l: integer;
begin
  l := Length(Bones);
  result := false;
  for i := 0 to bone_num - 1 do
  begin
    for b := 0 to l - 1 do
      if TSpFrame(Bones[b]).hash = bone_block[i].boneHash then
      begin
        result := true;
        bone_block[i].bone := TSpFrame(Bones[b]);
        Break;
      end;
  end;
end;

function TDictAnim.GetBone(Hash: Cardinal): TSpFrame;
var
  i: integer;
begin
  result := nil;
  for i := 0 to bone_num - 1 do
    if (bone_block[i].boneHash = Hash) and (bone_block[i].bone <> nil) then
    begin
      result := bone_block[i].bone;
      Break;
    end;
end;

function TDictAnim.GetBoneName(Hash: Cardinal): string;
var
  Bone: TSpFrame;
begin
  result := '[not found]';
  if Hash = 0 then
    result := '[root]';
  Bone := GetBone(Hash);
  if Bone <> nil then
    Result := Bone.name;
end;

function TDictAnim.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: Integer;
  s: string;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 9;
  Data^.Hash := Format('[%.*x]', [8, hash]);
  for x := 0 to High(BSP.BSPList.BSPFiles) do
  begin
    if LinkBones(BSP.BSPList.BSPFiles[x].BoneLib) then
      break;
  end;
  for x := 0 to keys_num - 1 do
  begin
    s := GetBoneName(Keys[x].bone_hash);
    Keys[x].TypeName := format('#%d [%s] "%s"',
      [x, BSPEnumKeyTypeS[Keys[x].key_type], s]);
    Keys[x].AddClassNode(TreeView, Result);
  end;
end;

procedure TDictAnim.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
begin
  if PData.DName = 'Name' then
    if length(name) > 0 then
    begin
      TypeName := format('Clip "%s"', [name]);
      hash := MakeHash(name, Length(name));
    end;
  inherited;
end;

procedure TDictAnim.InsertChild(Target, Chunk: TChunk);
var
  AnimKeyBlockTarget: TAnimKeyBlock;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TAnimKeyBlock then
  begin
    AnimKeyBlockTarget := TAnimKeyBlock(Target);
    Inc(keys_num);
    SetLength(Keys, keys_num);
    for i := keys_num - 2 downto 0 do
    begin
      if Keys[i] = AnimKeyBlockTarget then
      begin
        Keys[i + 1] := TAnimKeyBlock(Chunk);
        break;
      end;
      Keys[i + 1] := Keys[i];
    end;
  end;
end;

procedure TDictAnim.DeleteChild(Chunk: TChunk);
var
  AnimKeyBlock: TAnimKeyBlock;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TAnimKeyBlock then
  begin
    AnimKeyBlock := TAnimKeyBlock(Chunk);
    Dec(keys_num);
    MoveIndex := False;
    for i := 0 to keys_num do
    begin
      if MoveIndex then
        Keys[i - 1] := Keys[i];
      if Keys[i] = AnimKeyBlock then
        MoveIndex := true;
    end;
    SetLength(Keys, keys_num);
    AnimKeyBlock.Destroy;
  end;
end;

function NodeById(ANode: TXmlNode; ID: string): TXmlNode;
var
  I: Integer;
begin
  if ID[1] = '#' then
    Delete(ID, 1, 1);
  Result := nil;
  for I := 0 to ANode.ElementCount - 1 do
  begin
    if (Utf8CompareText(ANode.Elements[i].AttributeValueByName['id'], ID) = 0)
      then
    begin
      result := ANode.Elements[i];
      Break;
    end
  end;
end;

function CompareBoneFrame(Item1, Item2: Pointer): Integer;
begin
  Result := CompareValue(Int64(TBoneFrame(Item1^).boneHash),
    Int64(TBoneFrame(Item2^).boneHash));
end;

type
  TNodeBone = record
    Node: TXmlNode;
    BoneHash: Cardinal;
    frame: PFrame;
  end;
  PNodeBone = ^TNodeBone;

function CompareNodeBone(Item1, Item2: Pointer): Integer;
begin
  Result := CompareValue(Int64(PNodeBone(Item1).BoneHash),
    Int64(PNodeBone(Item2).BoneHash));
end;

procedure TDictAnim.LoadFromDAE(COLLADA: TXmlNode; BoneFrame: ABoneFrame;
  ClipName: string);
var
  tmin, tmax: Single;
  i, j, b, m: integer;
  Animation, Scene: TXmlNode;
  Channels: TList;
  NodeBone: PNodeBone;
  target, source: string;
  TimeMatrix: ATimeMatrix;
  SortList: TList;
  dzero: Boolean;
  Key: TAnimKeyBlock;

  function GetHashFrameFromTarget(target: string): PNodeBone;
  var
    n: Integer;
    s: string;
    hstr: PAnsiChar;
    thash: Cardinal;
  begin
    New(Result);
    Result.frame := nil;
    s := Copy(target, 1, Pos('/', target) - 1);
    for n := 0 to High(BoneFrame) do
      if BoneFrame[n].id = s then
      begin
        Result^.BoneHash := BoneFrame[n].boneHash;
        Result^.frame := @BoneFrame[n].frame;
        Break;
      end;
  end;
  function GetInputOutput(sampler: TXmlNode): ATimeMatrix;
  var
    TimeNode, MatrixNode: TXmlNode;
    count, k, jj, ii, mm: integer;
    timeF,
      matrixF: AFloat;
    s: string;
  begin
    Result := nil;
    if (sampler <> nil) and (sampler.ElementCount = 3) then
    begin
      TimeNode := NodeById(Animation,
        sampler.Elements[0].AttributeValueByName['source']);
      MatrixNode := NodeById(Animation,
        sampler.Elements[1].AttributeValueByName['source']);
      count :=
        StrToInt(TimeNode.NodeByName('float_array').AttributeValueByName['count']);
      SetLength(Result, count);
      timeF := SplitFloat(TimeNode.NodeByName('float_array').Value);
      matrixF := SplitFloat(MatrixNode.NodeByName('float_array').Value);
      mm := 0;
      for k := 0 to count - 1 do
      begin
        Result[k].time := timeF[k];
        for jj := 1 to 4 do
          for ii := 1 to 4 do
          begin
            Result[k].Matrix[ii][jj] := matrixF[mm];
            Inc(mm);
          end;
      end;
      timeF := nil;
      matrixF := nil;
    end;
  end;

  function DublePosMatrix(PosMatrix: ATimeMatrix; frame: TFrame): Boolean;
  var
    d: integer;
  begin
    Result := False;
    dzero := false;
    for d := 0 to High(PosMatrix) do
      if not (EqualPos(frame.PosX, PosMatrix[d].Matrix[4][1]) and
        EqualPos(frame.PosY, PosMatrix[d].Matrix[4][2]) and
        EqualPos(frame.PosZ, PosMatrix[d].Matrix[4][3])) then
      begin
        dzero := d > 0;
        exit;
      end;
    Result := true;
  end;

  function DubleRotMatrix(RotMatrix: ATimeMatrix; frame: TFrame): Boolean;
  var
    d: integer;
    RMatrix: TMatrix;
    Rot: TVer4f;
    RotX, RotY, RotZ, RotW: SmallInt;
  begin
    Result := False;
    dzero := false;
    RMatrix := RotMatrix[0].Matrix;
    Rot := MatrixToQuat(RMatrix);
    RotX := Round(Rot[0] / 0.000030518509);
    RotY := Round(Rot[1] / 0.000030518509);
    RotZ := Round(Rot[2] / 0.000030518509);
    RotW := Round(Rot[3] / 0.000030518509);

    if not ((RotX = frame.RotX) and (RotY = frame.RotY)
      and (RotZ = frame.RotZ) and (RotW = frame.RotW)) then
      exit;
    dzero := true;
    for d := 1 to High(RotMatrix) do
      if not (SameRotMatrix(RotMatrix[d].Matrix, RMatrix)) then
        exit;
    Result := true;
  end;
begin
  name := StrNew(PChar(clipname));
  hash := MakeHash(name, Length(name));
  minTime := 0;
  bone_num := Length(BoneFrame);
  SetLength(bone_block, bone_num);
  SortList := TList.Create;
  for i := 0 to High(BoneFrame) do
    SortList.Add(@BoneFrame[i]);
  SortList.Sort(@CompareBoneFrame);
  for i := 0 to bone_num - 1 do
  begin
    bone_block[i].boneHash := TBoneFrame(SortList[i]^).boneHash;
    bone_block[i].frameHash := TBoneFrame(SortList[i]^).frame.Hash;
  end;

  Animation := COLLADA.NodeByName('library_animations').NodeByName('animation');
  Channels := TList.Create;
  Animation.NodesByName('channel', Channels);

  keys_num := Channels.Count * 2;
  SetLength(Keys, keys_num);

  tmax := 0;
  tmin := 1000;
  TypeName := format('Clip "%s"', [name]);
  SortList.Clear;
  for i := 0 to Channels.Count - 1 do
  begin
    target := TXmlNode(Channels[i]).AttributeValueByName['target'];
    source := TXmlNode(Channels[i]).AttributeValueByName['source'];
    NodeBone := GetHashFrameFromTarget(target);
    NodeBone^.Node := NodeById(Animation, source);
    SortList.Add(NodeBone);
  end;
  SortList.Sort(@CompareNodeBone);
  j := 0;
  for i := 0 to SortList.Count - 1 do
  begin
    // Get Sampler - Get Input - Get Output
    NodeBone := SortList[i];
    TimeMatrix := GetInputOutput(NodeBone.Node);
    m := High(TimeMatrix);
    if tmax < TimeMatrix[m].time then
      tmax := TimeMatrix[m].time;
    if NodeBone.frame <> nil then
    begin
      if not DubleRotMatrix(TimeMatrix, NodeBone.frame^) then
      begin
        Key := TAnimKeyBlock.Create(nil);
        Key.LoadRotFlomDAE(NodeBone.BoneHash, TimeMatrix, dzero);
        if Key.key_num > 0 then
        begin
          Key.BSP := BSP;
          Key.ID := GlobalID;
          Inc(GlobalID);
          Keys[j] := Key;
          if tmin > Keys[j].time_keys[0] then
            tmin := Keys[j].time_keys[0];
          Keys[j].Clip := Self;
          Keys[j].TypeName := format('Key #%d', [j]);
          Inc(j);
        end
        else
          Key.Destroy;
      end;

      if not DublePosMatrix(TimeMatrix, NodeBone.frame^) then
      begin
        Key := TAnimKeyBlock.Create(nil);
        Key.LoadPosFlomDAE(NodeBone.BoneHash, TimeMatrix, dzero);
        if Key.key_num > 0 then
        begin
          Key.BSP := BSP;
          Key.ID := GlobalID;
          Inc(GlobalID);
          Keys[j] := Key;
          if tmin > Keys[j].time_keys[0] then
            tmin := Keys[j].time_keys[0];
          Keys[j].Clip := Self;
          Keys[j].TypeName := format('Key #%d', [j]);
          Inc(j);
        end
        else
          Key.Destroy;
      end;
    end;

    SetLength(TimeMatrix, 0);
    Dispose(NodeBone);
  end;
  maxTime := tmax;
  minTime := tmin;
  keys_num := j;
  SetLength(Keys, keys_num);
  Channels.Free;
  SortList.Free;
end;

function TDictAnim.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TDictAnim;
  i: integer;
  nFrames: AFrames;
  prevCount, newCount: Cardinal;
begin
  Chunk := TDictAnim(inherited CopyChunk(nBSP));
  Chunk.TypeName := TypeName;
  Chunk.name := name;
  Chunk.hash := hash;
  Chunk.minTime := minTime;
  Chunk.maxTime := maxTime;
  Chunk.bone_num := bone_num;
  Chunk.bone_block := Copy(bone_block);
  Chunk.keys_num := keys_num;
  SetLength(Chunk.Keys, keys_num);
  for i := 0 to keys_num - 1 do
  begin
    Chunk.Keys[i] := TAnimKeyBlock(Keys[i].CopyChunk(nBSP));
    Chunk.Keys[i].Clip := Chunk;
  end;

  if nBSP <> nil then
  begin
    prevCount := nBSP.AnimLib.NumFrames;
    newCount := prevCount + bone_num;
    nBSP.AnimLib.NumFrames := newCount;
    SetLength(nBSP.AnimLib.Frames, newCount);
    for i := prevCount to newCount - 1 do
    begin
      CopyMemory(@nBSP.AnimLib.Frames[i], Chunk.bone_block[i - prevCount].frame,
        SizeOf(TFrame));
    end;
    i := nBSP.AnimLib.NumClips;
    Inc(nBSP.AnimLib.NumClips);
    SetLength(nBSP.AnimLib.Clips, i + 1);
    nBSP.AnimLib.Clips[i] := Chunk;
  end;
  Result := Chunk;
end;

{ TAnimDictionary }

procedure TAnimDictionary.MakeDefault(BSPFile: TBSPFile);
begin
  inherited;
  IDType := C_AnimDictionary;
  Version := 1698;
  if BSPFile <> nil then
    BSPFile.AnimLib := self
  else
    BSP.AnimLib := self;
  Clear;
  NumFrames := 0;
  SetLength(Frames, NumFrames);
  NumClips := 0;
  SetLength(Clips, NumClips);
end;

procedure TAnimDictionary.Read;
var
  i: integer;
begin
  BSP.AnimLib := self;
  Clear;
  NumFrames := ReadSPDword;
  SetLength(Frames, NumFrames);
  for i := 0 to NumFrames - 1 do
  begin
    Frames[i].RotX := ReadSPWord;
    Frames[i].RotY := ReadSPWord;
    Frames[i].RotZ := ReadSPWord;
    Frames[i].RotW := ReadSPWord;
    Frames[i].PosX := ReadFloat;
    Frames[i].PosY := ReadFloat;
    Frames[i].PosZ := ReadFloat;
    Frames[i].Hash := MakeHash(@Frames[i].RotX, 20);
  end;
  NumClips := ReadSPDword;
  SetLength(Clips, NumClips);
  for i := 0 to NumClips - 1 do
  begin
    Clips[i] := TDictAnim(BSP.ReadBSPChunk());
    Clips[i].LinkFrames(Frames);
  end;
end;

procedure TAnimDictionary.Write;
var
  i: integer;
begin
  inherited;
  WriteSPDword(NumFrames);
  for i := 0 to NumFrames - 1 do
  begin
    WriteSPWord(Frames[i].RotX);
    WriteSPWord(Frames[i].RotY);
    WriteSPWord(Frames[i].RotZ);
    WriteSPWord(Frames[i].RotW);
    WriteFloat(Frames[i].PosX);
    WriteFloat(Frames[i].PosY);
    WriteFloat(Frames[i].PosZ);
  end;
  WriteSPDword(NumClips);
  CalcSize;
  for i := 0 to NumClips - 1 do
  begin
    BSP.WriteBSPChunk(Clips[i]);
  end;
end;

procedure TAnimDictionary.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node1: PVirtualNode;
begin
  inherited;
  Node1 := AddTreeData(nil, 'BasePoses', @NumFrames, BSPArray);
  AddLoadingMore(Node1, NumFrames, Frames, AddFramesData);
  Node1 := AddTreeData(nil, 'Clips', @NumClips, BSPArray);
  AddLoadingMore(Node1, NumClips, Clips, AddClipData);
end;

procedure TAnimDictionary.Clear;
var
  i: integer;
begin
  SetLength(Frames, 0);
  if Length(Clips) > 0 then
  begin
    for i := 0 to Length(Clips) - 1 do
      if Clips[i] <> nil then
        FreeAndNil(Clips[i]);
    SetLength(Clips, 0);
  end;
end;

constructor TAnimDictionary.Create(Chunk: TChunk);
begin
  inherited;
  TypeName := 'Anim Lib'
end;

destructor TAnimDictionary.Destroy;
begin
  Clear;
  inherited;
end;

procedure TAnimDictionary.AddFramesData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2: PVirtualNode;
begin
  Node2 := AddTreeData(Node1, format('BasePose [%d]', [i]), nil, BSPStruct,
    format('%x', [Frames[i].Hash]));
  with AFrames(PArr)[i] do
  begin
    AddTreeData(Node2, 'Rot', @RotX, BSPRVect);
    AddTreeData(Node2, 'Pos', @PosX, BSPVect);
  end;
end;

procedure TAnimDictionary.AddClipData(Node1: PVirtualNode; i: Integer;
  Parr: Pointer);
var
  Node2: PVirtualNode;
  Data: PPropertyData;
begin
  Node2 := AddTreeData(Node1, format('Clip [%d]', [i]), nil, BSPChunk,
    Clips[i].name);
  Data := DataTree.GetNodeData(Node2);
  Data^.Obj := @Clips[i];
  Data^.ValueIndex := 9;
end;

procedure TAnimDictionary.UpdateClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode);
var
  x: integer;
begin
  TreeView.DeleteChildren(TreeNode);
  for x := 0 to NumClips - 1 do
  begin
    Clips[x].LinkFrames(Frames);
    Clips[x].AddClassNode(TreeView, TreeNode);
  end;
end;

function TAnimDictionary.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
var
  x: integer;
begin
  Result := inherited AddClassNode(TreeView, TreeNode);
  Data^.ImageIndex := 6;
  for x := 0 to NumClips - 1 do
  begin
    Clips[x].AddClassNode(TreeView, Result);
{$IFDEF PROGRESSBAR}But.TreeProgress.Position := 700 + Round(x / NumClips *
      150);
{$ENDIF}
  end;
end;

function CompareAnimKeyBlock(Item1, Item2: Pointer): Integer;
begin
  Result := CompareValue(Int64(TAnimKeyBlock(Item1^).bone_hash),
    Int64(TAnimKeyBlock(Item2^).bone_hash));
end;

procedure TAnimDictionary.MergeAnims;
const
  AIndexes: array[0..1] of integer = (8, 0);
var
  chuj: TAnimDictionary;
  newClip: TDictAnim;
  oldMaxTime: Single;
  i, j, k, l, z, newClipLength: integer;
  foundKey: Boolean;
  copiedKey, tempKey: TAnimKeyBlock;
  SortList: TList;
  sortedKeys: AKeys;
begin
  newClip := TDictAnim(Clips[AIndexes[0]].CopyChunk(nil));
  oldMaxTime := newClip.maxTime;
  newClip.maxTime := Clips[AIndexes[0]].maxTime + Clips[AIndexes[1]].maxTime -
    Clips[AIndexes[0]].minTime;
  for i := 1 to High(AIndexes) do
  begin //dla kazdej animacji ktora chce zlaczyc z 1
    for j := 0 to High(Clips[AIndexes[i]].Keys) do
    begin //ide po wszystkich kluczasz wybranej animacji do zlaczenia
      foundKey := false; //Czy znalazlem klucz? Jeszcze nie;
      for k := 0 to High(newClip.Keys) do
      begin //przechodze po wszystkich swoich kluczach
        newClipLength := newClip.Keys[k].key_num - 1; //save last index of clip
        if (newClip.Keys[k].bone_hash = Clips[AIndexes[i]].Keys[j].bone_hash)
          and
          (newClip.Keys[k].key_type = Clips[AIndexes[i]].Keys[j].key_type) and
          (Clips[AIndexes[i]].Keys[j].key_num > 0) then
        begin
          foundKey := True; //jesli znalazlem taka animacje to swietnie
          newClip.Keys[k].key_num := newClip.Keys[k].key_num +
            Clips[AIndexes[i]].Keys[j].key_num - 1; //set new length
          SetLength(newClip.Keys[k].time_keys, newClip.Keys[k].key_num);
          case newClip.Keys[k].key_type of
            K_Rot:
              begin
                SetLength(newClip.Keys[k].rot_keys, newClip.Keys[k].key_num);
                //resize array to new length
                for l := newClipLength to newClip.Keys[k].key_num - 1 do
                begin
                  newClip.Keys[k].time_keys[l] :=
                    Clips[AIndexes[i]].Keys[j].time_keys[l - newClipLength] +
                    oldMaxTime - newClip.minTime;
                  newClip.Keys[k].rot_keys[l] :=
                    Clips[AIndexes[i]].Keys[j].rot_keys[l - newClipLength];
                end;
              end;
            K_Pos:
              begin
                SetLength(newClip.Keys[k].pos_keys, newClip.Keys[k].key_num);
                //resize array to new length
                for l := newClipLength to newClip.Keys[k].key_num - 1 do
                begin
                  newClip.Keys[k].time_keys[l] :=
                    Clips[AIndexes[i]].Keys[j].time_keys[l - newClipLength] +
                    oldMaxTime - newClip.minTime;
                  newClip.Keys[k].pos_keys[l] :=
                    Clips[AIndexes[i]].Keys[j].pos_keys[l - newClipLength];
                end;
              end;
            K_Vect: //TODO: FIX
              begin
                SetLength(newClip.Keys[j].vert_keys, newClip.Keys[j].key_num);
                //resize array to new length
              end;
            K_UV: //TODO: FIX
              begin
                SetLength(newClip.Keys[j].UV_keys, newClip.Keys[j].key_num);
                //resize array to new length
              end;
            K_Vis:
              begin
                SetLength(newClip.Keys[k].vis_keys, newClip.Keys[k].key_num);
                //resize array to new length
                for l := newClipLength to newClip.Keys[k].key_num - 1 do
                begin
                  newClip.Keys[k].time_keys[l] :=
                    Clips[AIndexes[i]].Keys[j].time_keys[l - newClipLength] +
                    oldMaxTime - newClip.minTime;
                  newClip.Keys[k].vis_keys[l] :=
                    Clips[AIndexes[i]].Keys[j].vis_keys[l - newClipLength];
                end;
              end;
          end;
          break;
        end;
      end;
      if not foundKey then
      begin //if key not found then ADD THIS KEY:
        inc(newClip.keys_num);
        SetLength(newClip.Keys, newClip.keys_num);
        copiedKey := TAnimKeyBlock(Clips[AIndexes[i]].Keys[j].CopyChunk(nil));
        copiedKey.Clip := newClip;
        inc(copiedKey.key_num);
        SetLength(copiedKey.time_keys, copiedKey.key_num);
        for z := copiedKey.key_num - 2 downto 0 do
        begin
          copiedKey.time_keys[z + 1] := copiedKey.time_keys[z];
        end;
        copiedKey.time_keys[0] := copiedKey.time_keys[1];
        for z := 1 to High(copiedKey.time_keys) do
        begin
          copiedKey.time_keys[z] := copiedKey.time_keys[z] +
            Clips[AIndexes[0]].maxTime - Clips[AIndexes[0]].minTime;
        end;
        //set new time:
        case copiedKey.key_type of
          K_Rot:
            begin
              SetLength(copiedKey.rot_keys, copiedKey.key_num);
              for z := copiedKey.key_num - 2 downto 0 do
              begin
                copiedKey.rot_keys[z + 1] := copiedKey.rot_keys[z];
              end;
              copiedKey.rot_keys[0] := copiedKey.rot_keys[1];
            end;
          K_Pos:
            begin
              SetLength(copiedKey.pos_keys, copiedKey.key_num);
              for z := copiedKey.key_num - 2 downto 0 do
              begin
                copiedKey.pos_keys[z + 1] := copiedKey.pos_keys[z];
              end;
              copiedKey.pos_keys[0] := copiedKey.pos_keys[1];
            end;
        end;
        newClip.Keys[newClip.keys_num - 1] := copiedKey;
      end;
    end;
  end;

  //sort keys:
  SortList := TList.Create; //Sort base Pose bones
  { for i := 0 to newClip.bone_num - 1 do     //and here
   begin
     SortList.Add(@newClip.bone_block[i]);
   end;
   SortList.Sort(@CompareBoneFrame);
   for i := 0 to newClip.bone_num - 1 do
   begin
     newClip.bone_block[i].boneHash := TBoneFrame(SortList[i]^).boneHash;
     newClip.bone_block[i].frameHash := TBoneFrame(SortList[i]^).frame.Hash;
   end;
   SortList.Clear;
   SortList.Free;     }
  for i := 0 to newClip.keys_num - 1 do
  begin
    SortList.Add(@newClip.Keys[i]);
  end;
  SortList.Sort(@CompareAnimKeyBlock);
  //copy all the keys...
  SetLength(sortedKeys, newClip.keys_num);
  for i := 0 to newClip.keys_num - 1 do
  begin
    sortedKeys[i] := TAnimKeyBlock(SortList[i]^);
  end;
  newClip.Keys := sortedKeys;
  SortList.Free;
  Clips[AIndexes[0]] := newClip;
  ClearBonePoses(Clips[AIndexes[0]]);
end;

function TAnimDictionary.FindAnimOfHash(Hash: Cardinal): TDictAnim;
var
  i: integer;
begin
  Result := nil;
  if NumClips > 0 then
  begin
    for i := 0 to NumClips - 1 do
      if (Clips[i] <> nil) and (Clips[i].hash = Hash) then
      begin
        Result := Clips[i];
        Break;
      end;
  end;
end;

procedure TAnimDictionary.DeleteChild(Chunk: TChunk);
var
  Clip: TDictAnim;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TDictAnim then
  begin
    Clip := TDictAnim(Chunk);
    Dec(NumClips);
    MoveIndex := False;
    for i := 0 to NumClips do
    begin
      if MoveIndex then
        Clips[i - 1] := Clips[i];
      if Clips[i] = Clip then
        MoveIndex := true;
    end;
    SetLength(Clips, NumClips);
    ClearBonePoses(Clip); // Clear used BonePoses from Frames
    Clip.Destroy;
  end;
end;

procedure TAnimDictionary.InsertChild(Target, Chunk: TChunk);
var
  ClipTarget: TDictAnim;
  i: integer;
  MoveIndex: boolean;
begin
  if Chunk is TDictAnim then
  begin
    ClipTarget := TDictAnim(Target);
    Inc(NumClips);
    SetLength(Clips, NumClips);
    for i := NumClips - 2 downto 0 do
    begin
      if Clips[i] = ClipTarget then
      begin
        Clips[i + 1] := TDictAnim(Chunk);
        Clips[i + 1].LinkFrames(Frames);
        break;
      end;
      Clips[i + 1] := Clips[i];
    end;
  end;
end;

type
  TUsedHash = record
    hash: Cardinal;
    used: Boolean;
  end;

procedure TAnimDictionary.ClearBonePoses(Clip: TDictAnim);
var
  i, j, k, f: Integer;
  NewFrames: AFrames;
  ToDelete: boolean;
  UsedHash: array of TUsedHash;
begin
  // make used array
  SetLength(UsedHash, Length(Clip.bone_block));
  for i := 0 to High(UsedHash) do
    UsedHash[i].hash := Clip.bone_block[i].frameHash;
  // found used
  for i := 0 to NumClips - 1 do
    for j := 0 to High(Clips[i].bone_block) do
    begin
      for k := 0 to High(UsedHash) do
        if (not UsedHash[k].used) and (Clips[i].bone_block[j].frameHash =
          UsedHash[k].hash) then
        begin
          UsedHash[k].used := true;
          Break;
        end;
    end;
  // rebuild frames
  SetLength(NewFrames, NumFrames);
  f := 0;
  for i := 0 to NumFrames - 1 do
  begin
    ToDelete := False;
    for j := 0 to High(UsedHash) do
      if (Frames[i].Hash = UsedHash[j].hash) and (not UsedHash[j].used) then
      begin
        ToDelete := True;
        Break;
      end;
    if ToDelete then
      Continue;
    NewFrames[f] := Frames[i];
    Inc(f);
  end;
  SetLength(NewFrames, f);
  SetLength(Frames, 0);
  Frames := NewFrames;
  NumFrames := Length(Frames);
  // rebuilds links
  for i := 0 to NumClips - 1 do
  begin
    Clips[i].LinkFrames(Frames);
  end;
  UsedHash := nil;
end;

function TAnimDictionary.LoadFromDAE(COLLADA: TXmlNode; clipname: string):
  TDictAnim;
var
  ClipChunk, OldClip: TDictAnim;
  b, i, j, Rindex: integer;
  Clump, Scene: TXmlNode;
  frame: TSpFrame;
  oldnum: Integer;
  BoneData: ABoneFrame;
  NoFound: boolean;
  errorbone: string;
  function GetBoneMatrix(bonename, sMatrix, sid: string): TBoneFrame;
  var
    matrix: TMatrix;
    Rot: TVer4f;
  begin
    Result.boneHash := MakeHash(PChar(bonename), Length(bonename));
    Result.id := sid;
    matrix := TextToMatrix(sMatrix);
    Rot := MatrixToQuat(matrix);
    with Result.frame do
    begin
      RotX := Round(Rot[0] / 0.000030518509);
      RotY := Round(Rot[1] / 0.000030518509);
      RotZ := Round(Rot[2] / 0.000030518509);
      RotW := Round(Rot[3] / 0.000030518509);
      PosX := matrix[4][1];
      PosY := matrix[4][2];
      PosZ := matrix[4][3];
      Hash := MakeHash(@RotX, 20);
    end;
  end;
  procedure FindNextBone(BNode: TXmlNode);
  var
    k: integer;
    bname, bmatrix, bid: string;
  begin
    if (BNode.Name = 'node') and (BNode.AttributeCount > 1) then
      for k := 0 to BNode.ElementCount - 1 do
      begin
        if (k = 0) and (BNode.Elements[0].name = 'matrix') then
        begin
          bname := BNode.AttributeValueByName['name'];
          bmatrix := BNode.Elements[0].Value;
          bid := BNode.AttributeValueByName['id'];
          if (not (AnsiStartsStr('entity_', bname)) and not
            (AnsiStartsStr('NullBox-', bname))) then
            //ERROR - Because if is entity_, then it was added to BonePos as Bone
          begin
            BoneData[b] := GetBoneMatrix(bname, bmatrix, bid);
            Inc(b);
          end;
          Continue;
        end;
        try
          FindNextBone(BNode.Elements[k]);
        except
          on E: Exception do
            errorbone := BNode.AttributeValueByName['name'];
        end;
      end;
  end;
begin
  Clump := nil;
  Scene :=
    COLLADA.NodeByName('library_visual_scenes').NodeByName('visual_scene');
  for i := 0 to Scene.ElementCount - 1 do
  begin
    if AnsiStartsStr('entity_', Scene.Elements[i].AttributeValueByName['name'])
      then
    begin
      Clump := Scene.Elements[i];
      Break;
    end;
  end;
  if Clump = nil then
    Exit; // error
  b := 0;
  SetLength(BoneData, 500);
  FindNextBone(Clump);
  SetLength(BoneData, b);

  SetLength(Frames, NumFrames + b);
  for i := 0 to b - 1 do
  begin // add frames to animlib
    NoFound := true;
    for j := 0 to NumFrames - 1 do
      if Frames[j].Hash = BoneData[i].frame.Hash then
      begin
        NoFound := False;
        break;
      end;
    if NoFound then
    begin
      Frames[Numframes] := BoneData[i].frame;
      Inc(NumFrames);
    end;
  end;
  SetLength(Frames, NumFrames);

  ClipChunk := TDictAnim.Create(nil);
  ClipChunk.BSP := BSP;
  ClipChunk.ID := GlobalID;
  Inc(GlobalID);
  ClipChunk.LoadFromDAE(COLLADA, BoneData, clipname);
  ClipChunk.LinkFrames(Frames);
  SetLength(BoneData, 0);

  if DAE_ADDCLIP in DAE_Options then
  begin
    SetLength(Clips, NumClips + 1);
    Clips[NumClips] := ClipChunk;
    Inc(NumClips);
  end
  else if DAE_REPLACECLIP in DAE_Options then
  begin
    Rindex := 0;
    for i := 0 to High(Clips) do
      if Clips[i].name = clipname then
      begin
        Rindex := i;
        Break;
      end;
    OldClip := Clips[Rindex];
    Clips[Rindex] := ClipChunk;
    ClearBonePoses(OldClip); // Clear used BonePoses from Frames
    OldClip.Destroy;
  end;

  Result := ClipChunk;
end;

{ TZoneObj }

function TZoneObj.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := TreeView.AddChild(TreeNode);
  CheckHide(Result);
  Data := TreeView.GetNodeData(Result);
  Data^.Name := Format('Zone [%d]', [idx]);
  Data^.Value := '[Zone]';
  Data^.ID := Format('[%.*d]', [4, ID]);
  Data^.ImageIndex := 29;
  Data^.Hash := Format('[%.*x]', [8, hash]);
  Data^.Obj := self;
  if hasNgonBSP then
    NgonBSP.AddClassNode(TreeView, Result);
  if hasArea then
    Area.AddClassNode(TreeView, Result);
  if hasBorder then
    Border.AddClassNode(TreeView, Result);
  if hasWard then
    Ward.AddClassNode(TreeView, Result);
end;

procedure TZoneObj.AddFields(CustomTree: TCustomVirtualStringTree);
var
  Node: PVirtualNode;
begin
  inherited;
  AddBoundData(nil, bound);
  AddTreeData(nil, 'Hash', @hash, BSPHash);
  Node := AddTreeData(nil, 'BSP', @hasNgonBSP, BSPChBool);
  if hasNgonBSP then
    ValueIndex(Node, 26);
  Node := AddTreeData(nil, 'Outline Spline', @hasArea, BSPChBool);
  if hasArea then
    ValueIndex(Node, 24);
  Node := AddTreeData(nil, 'Outline Clump', @hasBorder, BSPChBool);
  if hasBorder then
    ValueIndex(Node, 13);
  AddTreeData(nil, 'Flags', @floor_flag, BSPUint);
  Node := AddTreeData(nil, 'Top', @hasWard, BSPChBool);
  if hasWard then
    ValueIndex(Node, 13);
end;

procedure TZoneObj.CheckHide(ANode: PVirtualNode);
begin
  ANode.CheckType := ctTriStateCheckBox;
  ANode.CheckState := csCheckedNormal;
end;

function TZoneObj.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TZoneObj;
begin
  Chunk := TZoneObj(inherited CopyChunk(nBSP));
  Chunk.IDType := 23;
  Chunk.Mesh := TMesh.Create;
  Chunk.Mesh.ChName := 'ZN';
  Chunk.bound := bound;
  Chunk.hash := hash;
  Chunk.hasNgonBSP := hasNgonBSP;
  Chunk.hasArea := hasArea;
  Chunk.hasBorder := hasBorder;
  Chunk.floor_flag := floor_flag;
  Chunk.Mesh.floors := floor_flag;
  Chunk.hasWard := hasWard;

  if hasNgonBSP then
    Chunk.NgonBSP := TSpNgonBSP(NgonBSP.CopyChunk(nBSP));
  if hasArea then
    Chunk.Area := TSpline(Area.CopyChunk(nBSP));
  if hasBorder then
    Chunk.Border := TClump(Border.CopyChunk(nBSP));
  if hasWard then
    Chunk.Ward := TClump(Ward.CopyChunk(nBSP));

  Result := Chunk;
end;

constructor TZoneObj.Create();
begin
  IDType := 23;
  Mesh := TMesh.Create;
  Mesh.ChName := 'ZN';
end;

procedure TZoneObj.DeleteChild(Chunk: TChunk);
begin
  if Chunk is TSpNgonBSP then
  begin
    hasNgonBSP := false;
    FreeAndNil(NgonBSP);
  end;
  if Chunk is TSpline then
  begin
    hasArea := false;
    FreeAndNil(Area);
  end;
  if Chunk is TClump then
    if Border = Chunk then
    begin
      hasBorder := false;
      FreeAndNil(Border);
    end
    else
    begin
      hasWard := false;
      FreeAndNil(Ward);
    end;
end;

destructor TZoneObj.Destroy;
begin
  FreeAndNil(NgonBSP);
  FreeAndNil(Area);
  FreeAndNil(Border);
  FreeAndNil(Ward);
  Mesh.Clear;
  inherited;
end;

function TZoneObj.GetMesh: TMesh;
var
  nchild, x: integer;
begin
  Result := Mesh;
  Mesh.ResetChilds(0);
  nchild := 0;
  if Border <> nil then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := Border.GetMesh;
    inc(nchild);
  end;
  if Ward <> nil then
  begin
    SetLength(Mesh.Childs, nchild + 1);
    Mesh.childs[nchild] := Ward.GetMesh;
    inc(nchild);
  end;
end;

procedure TZoneObj.Read(Chunk: TChunk);
begin
  bound := Chunk.ReadBound;
  hash := Chunk.ReadDword;
  hasNgonBSP := Boolean(Chunk.ReadDword);
  hasArea := Boolean(Chunk.ReadDword);
  hasBorder := Boolean(Chunk.ReadDword);
  floor_flag := Chunk.ReadDword;
  Mesh.floors := floor_flag;
  if Chunk.Version < 1698 then
    hasWard := false
  else
    hasWard := Boolean(Chunk.ReadDword);

  if hasNgonBSP then
    NgonBSP := TSpNgonBSP(Chunk.BSP.ReadBSPChunk);
  if hasArea then
    Area := TSpline(Chunk.BSP.ReadBSPChunk);
  if hasBorder then
  begin
    Border := TClump(Chunk.BSP.ReadBSPChunk);
    Border.TypeName := 'Border';
  end;
  if hasWard then
  begin
    Ward := TClump(Chunk.BSP.ReadBSPChunk);
    Ward.TypeName := 'Ward';
  end;

end;

procedure TZoneObj.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

procedure TZoneObj.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
begin
  Data^.Changed := true;
end;

procedure TZoneObj.Write(Chunk: TChunk);
begin
  Chunk.WriteBound(bound);
  Chunk.WriteDword(hash);
  Chunk.WriteBoolean(hasNgonBSP);
  Chunk.WriteBoolean(hasArea);
  Chunk.WriteBoolean(hasBorder);
  Chunk.WriteDword(floor_flag);
  if Chunk.Version >= 1698 then
    Chunk.WriteBoolean(hasWard);
end;

procedure TZoneObj.WriteChilds(Chunk: TChunk);
begin
  if hasNgonBSP then
    Chunk.BSP.WriteBSPChunk(NgonBSP);
  if hasArea then
    Chunk.BSP.WriteBSPChunk(Area);
  if hasBorder then
    Chunk.BSP.WriteBSPChunk(Border);
  if hasWard then
    Chunk.BSP.WriteBSPChunk(Ward);
end;

{ TSpNullNode }

function TSpNullNode.AddClassNode(TreeView: TCustomVirtualStringTree;
  TreeNode: PVirtualNode): PVirtualNode;
begin
  Result := TreeView.AddChild(TreeNode);
  Result.CheckType := ctTriStateCheckBox;
  Result.CheckState := csCheckedNormal;
  mesh.Indx := ID;
  Data := TreeView.GetNodeData(Result);
  Data^.Name := name;
  Data^.Value := '[NullNode]';
  Data^.ImageIndex := 5;
  Data^.Obj := self;
  Data^.ID := Format('[%.*d]', [4, ID]);
  Data^.Hash := Format('[%.*x]', [8, hash]);
end;

procedure TSpNullNode.AddFields(CustomTree: TCustomVirtualStringTree);
begin
  inherited;
  AddMatrixData(nil, 'Matrix', 'Transform', matrix);
  AddBoundData(nil, bound, 'Global Bounds');
  AddTreeData(nil, 'Hash', @hash, BSPRefHash);
  AddTreeData(nil, 'Floor Flags', @unk1, BSPFloorFlags);
  AddTreeData(nil, 'Flags', @unk2, BSPNullNodeFlags);
  AddTreeData(nil, 'Spawn Type', @objectType, BSPSpawnType);
  AddTreeData(nil, 'Null Name', @name, BSPString);
end;

function TSpNullNode.CopyChunk(nBSP: TBSPFile): TChunk;
var
  Chunk: TSpNullNode;
begin
  Chunk := TSpNullNode(inherited CopyChunk(nBSP));
  Chunk.mesh := TMesh.Create;
  Chunk.mesh.XType := 'WP';
  Chunk.IDType := 20;
  Chunk.matrix := matrix;
  Chunk.mesh.SetEntMatrix(matrix);
  Chunk.bound := bound;
  Chunk.mesh.SizeBox := Mesh.SizeBox;
  Chunk.hash := hash;
  Chunk.unk1 := unk1;
  Chunk.unk2 := unk2;
  Chunk.objectType := objectType;
  Chunk.name := StrNew(name);
  Chunk.mesh.Name := name;
  Chunk.mesh.ColorIndx := objectType;
  Result := Chunk;
end;

constructor TSpNullNode.Create;
begin
  mesh := TMesh.Create();
  mesh.XType := 'WP';
  IDType := 20;
end;

destructor TSpNullNode.Destroy;
begin
  Mesh.Clear;
  inherited;
end;

function TSpNullNode.GetMesh: TMesh;
begin
  Result := mesh;
end;

procedure TSpNullNode.Read(Chunk: TChunk);
begin
  matrix := Chunk.ReadMxBlock;
  mesh.SetEntMatrix(matrix);
  bound := Chunk.ReadBound;
  // mesh.SeTBBox(bound);
  mesh.SetSizeBox(1);
  hash := Chunk.ReadDword;
  unk1 := Chunk.ReadDword;
  unk2 := Chunk.ReadDword;
  objectType := Chunk.ReadDword;
  name := Chunk.ReadStringSize(32);
  mesh.Name := name;
  //
  mesh.ColorIndx := objectType;
end;

procedure TSpNullNode.ShowMesh(Hide: Boolean);
begin
  Mesh.Hide := Hide;
end;

procedure TSpNullNode.UpdateNode(CustomTree: TCustomVirtualStringTree; PData:
  PPropertyData);
var
  sNullNodeNode, NullNodeArrNode: PVirtualNode;
  sWpData, NullNodeArrNodeData: PClassData;
  wpPoints: TNullNodes;
  NullNode: TSpNullNode;
  i: integer;
begin
  if PData.DName = 'Name' then
  begin
    if length(name) > 0 then
    begin
      mesh.Name := name;
      hash := MakeHash(name, Length(name));
      Data^.Name := name;
      //sort keys
      sNullNodeNode := CustomTree.GetFirstSelected;
      NullNodeArrNode := sNullNodeNode.Parent;
      sWpData := CustomTree.GetNodeData(sNullNodeNode.Parent);
      wpPoints := TNullNodes(sWpData.Obj);
      wpPoints.SorTNullNodes;
      //sort Nodes
      NullNodeArrNode := CustomTree.GetFirstChild(NullNodeArrNode);
      while Assigned(NullNodeArrNode) do
      begin
        NullNodeArrNodeData := CustomTree.GetNodeData(NullNodeArrNode);
        NullNode := TSpNullNode(NullNodeArrNodeData.Obj);
        if hash < NullNode.hash then
        begin
          CustomTree.MoveTo(sNullNodeNode, NullNodeArrNode, amInsertBefore,
            False);
          break;
        end;
        NullNodeArrNode := CustomTree.GetNextSibling(NullNodeArrNode);
      end;
    end;
  end;
  if (PData.DName = 'Position') or (PData.DName = 'Rotation') or (PData.DName = 'Scale') then
  begin
    matrix.m := GetMatrix(matrix.t[0], matrix.t[1], matrix.t[2]);
    bound.min[1] := matrix.m[4][1];
    bound.min[2] := matrix.m[4][2];
    bound.min[3] := matrix.m[4][3];
    bound.min[4] := matrix.m[4][4];
    bound.max := bound.min;
    mesh.SetEntMatrix(matrix);
  end
  else if PData.DName[1] = '[' then
  begin
    MatrixDecompose(matrix.m, matrix.t[0], matrix.t[1], matrix.t[2]);
    bound.min[1] := matrix.m[4][1];
    bound.min[2] := matrix.m[4][2];
    bound.min[3] := matrix.m[4][3];
    bound.min[4] := matrix.m[4][4];
    bound.max := bound.min;
    mesh.SetEntMatrix(matrix);
  end
  else if PData.DName = 'Type' then
  begin
    mesh.ColorIndx := objectType;
  end;
  Data^.Changed := true;
end;

procedure TSpNullNode.Write(Chunk: TChunk);
begin
  Chunk.WriteMxBlock(matrix);
  Chunk.WriteBound(bound);
  Chunk.WriteDword(hash);
  Chunk.WriteDword(unk1);
  Chunk.WriteDword(unk2);
  Chunk.WriteDword(objectType);
  Chunk.WriteStringSize(name, 32);
end;

{ TCompressThread }

constructor TCompressThread.Create(bsp: TBSPfile);
begin
  inherited Create(false);
  fbsp := bsp;
end;

procedure TCompressThread.Execute;
var
  outStream: TStream;
begin
  inherited;
  But.TreeProgress.Position := fbsp.Mem.Position;
  outStream := TFileStream.Create(fbsp.bspfilename, fmCreate);
  GZCompressStream(fbsp.mem, outStream, '', '', 0);
  But.TreeProgress.Position := fbsp.Mem.Position;
  fbsp.filesize := outStream.Size;
  outStream.Free;
  But.StopTimer;
  Terminate;
end;

end.

