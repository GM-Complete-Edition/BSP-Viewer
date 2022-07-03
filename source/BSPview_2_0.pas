unit BSPview_2_0;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls {, Grids}, ComCtrls, ExtCtrls {, ValEdit}, OpenGLx,
  OpenGL_Box,
  OpenGLLib, Clipbrd, ShellAPI,
  Buttons, Menus, IdGlobal, Math, ImgList, BSPLib, BSPCntrLib, BSPMeshLib,
  GraphUtil, ZLibExGZ, ZLibEx,
  ToolWin, VirtualTrees, Editors;

type
  TFormBSP = class(TForm)
    OpenDialog: TOpenDialog;
    PanelView: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    ImageT32: TImage;
    ScrollBox1: TScrollBox;
    SaveDialog2: TSaveDialog;
    Panel3: TPanel;
    OpenGLBox: TOpenGLBox;
    Timer1: TTimer;
    Splitter4: TSplitter;
    ClassTree: TVirtualStringTree;
    SaveDialogDAE: TSaveDialog;
    OpenDialog2: TOpenDialog;
    SaveDialog3: TSaveDialog;
    OpenDialogDAE: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Expand1: TMenuItem;
    Collupse1: TMenuItem;
    ExportAnim: TButton;
    Panel6: TPanel;
    Panel7: TPanel;
    AnimBox: TComboBox;
    ImportAnim: TButton;
    LabelTime: TLabel;
    Panel8: TPanel;
    TreeImages: TImageList;
    Panel12: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ImageList1: TImageList;
    Panel13: TPanel;
    ToolBar1: TToolBar;
    ZoomBut: TToolButton;
    PanBut: TToolButton;
    RotBut: TToolButton;
    PerspBut: TToolButton;
    DollyBut: TToolButton;
    CentrBut: TToolButton;
    SelBut: TToolButton;
    MoveBut: TToolButton;
    RotatBut: TToolButton;
    ScaleBut: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    Panel14: TPanel;
    TreeProgress: TProgressBar;
    Panel21: TPanel;
    Label16: TLabel;
    limgWidth: TLabel;
    LabImgWidth: TLabel;
    LabImgName: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    LabImgBits: TLabel;
    Label25: TLabel;
    LabImgHash: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    LabImgPalette: TLabel;
    LabImgCompr: TLabel;
    LabImgMigMag: TLabel;
    LabImgFormat: TLabel;
    Label19: TLabel;
    LabImgSize: TLabel;
    Label18: TLabel;
    Panel24: TPanel;
    Panel25: TPanel;
    Label17: TLabel;
    Search: TEdit;
    FindText: TButton;
    DataTree: TVirtualStringTree;
    Splitter5: TSplitter;
    LoadTimer: TTimer;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    View1: TMenuItem;
    Render1: TMenuItem;
    ButOpenBSP: TMenuItem;
    ButAddBSP: TMenuItem;
    ButSaveBSP: TMenuItem;
    N1: TMenuItem;
    ExportImage: TMenuItem;
    DrawBones: TMenuItem;
    ShowGrid: TMenuItem;
    ShowLight: TMenuItem;
    DrawBoxes: TMenuItem;
    Exit1: TMenuItem;
    LightsPoint: TMenuItem;
    Icelayer: TMenuItem;
    Collisions: TMenuItem;
    N4: TMenuItem;
    NullNodes: TMenuItem;
    AnimButton: TSpeedButton;
    ExportDae: TMenuItem;
    ImportModeldae: TMenuItem;
    N5: TMenuItem;
    Floors1: TMenuItem;
    Floor11: TMenuItem;
    Floor21: TMenuItem;
    Floor31: TMenuItem;
    Floor41: TMenuItem;
    Floor51: TMenuItem;
    Floor61: TMenuItem;
    Floor71: TMenuItem;
    Floor81: TMenuItem;
    AllFloors: TMenuItem;
    FloorUp: TMenuItem;
    FloorDown: TMenuItem;
    N6: TMenuItem;
    Options1: TMenuItem;
    Settings1: TMenuItem;
    MirrorObj: TMenuItem;
    N2: TMenuItem;
    Emitters: TMenuItem;
    NgonBSP: TMenuItem;
    WpNames: TMenuItem;
    WardZone: TMenuItem;
    N3: TMenuItem;
    DeleteChunk: TMenuItem;
    CopyChunk: TMenuItem;
    MergeChunk: TMenuItem;
    ImportImage: TMenuItem;
    BtnCreateTemplate1: TMenuItem;
    AddChunk: TMenuItem;
    BtnN7: TMenuItem;
    BtnDebug1: TMenuItem;
    BtnChangeGlogalSpeed1: TMenuItem;
    procedure ButOpenBSPClick(Sender: TObject);
    procedure BuildClassTree();
    procedure FormCreate(Sender: TObject);
    procedure ExportImageClick(Sender: TObject);
    procedure OpenGLBoxResize(Sender: TObject);
    procedure OpenGLBoxPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ClassTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ExportBSP3DClick(Sender: TObject);
    procedure ImportImageClick(Sender: TObject);
    procedure ButSaveBSPClick(Sender: TObject);
    procedure Expand1Click(Sender: TObject);
    procedure Collupse1Click(Sender: TObject);
    procedure ExportAnimClick(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure AnimBoxChange(Sender: TObject);
    procedure ImportAnimClick(Sender: TObject);
    procedure OpenGLBoxMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure OpenGLBoxMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure OpenGLBoxMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure OpenGLBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure ToolButClick(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButtonSMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure OpenGLBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLBoxClick(Sender: TObject);
    procedure CentrButClick(Sender: TObject);
    procedure SelButClick(Sender: TObject);
    procedure ClassTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure RedrawClick(Sender: TObject);
    procedure ClassTreeAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure ClassTreeDblClick(Sender: TObject);
    procedure SearchChunks(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Data: Pointer; var Abort: Boolean);
    procedure SearchChunk(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Obj: Pointer; var Abort: Boolean);
    procedure SearchHash(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Data: Pointer; var Abort: Boolean);
    procedure ShowChunkClick(Sender: TObject);
    procedure SearchForText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Data: Pointer; var Abort: Boolean);
    procedure SearchForChunk(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Data: Pointer; var Abort: Boolean);
    procedure FindTextClick(Sender: TObject);
    procedure SearchKeyPress(Sender: TObject; var Key: Char);

    procedure DataTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure DataTreeBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure DataTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ClassTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ClassTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);

    procedure DataTreeAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure LoadTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DataTreeNodeDblClick(Sender: TBaseVirtualTree;
      const HitInfo: THitInfo);
    procedure ShowFullClick(Sender: TObject);
    procedure ButAddBSPClick(Sender: TObject);
    procedure ShowGridClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ClassTreeChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure OpenGLBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExportDaeClick(Sender: TObject);
    procedure ImportModeldaeClick(Sender: TObject);
    procedure Floor81Click(Sender: TObject);
    procedure FloorUpClick(Sender: TObject);
    procedure FloorDownClick(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure DataTreeCreateEditor(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure ClassTreeFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure DataTreeFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure DataTreeEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure DataTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure ClassTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure DeleteChunkClick(Sender: TObject);
    procedure ClassTreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure DataTreeScroll(Sender: TBaseVirtualTree; DeltaX,
      DeltaY: Integer);
    procedure CopyChunkClick(Sender: TObject);
    procedure MergeChunkClick(Sender: TObject);
    procedure BtnCreateTemplate1Click(Sender: TObject);
    procedure AddChunkClick(Sender: TObject);
    procedure BtnDebug1Click(Sender: TObject);
    procedure BtnChangeGlogalSpeed1Click(Sender: TObject);

  private
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure WndProc(var Msg: TMessage); message WM_UPDATEUISTATE;
  public
    { Public declarations }
    sortcount: Integer;
    maxst, MaxCount: Integer;
    BSPUpdating: Boolean;
    OggLib: boolean;
    StPanel, StPanel2: TStatusPanel;
    function LoadTGAResource(Name: string): Pointer;
    procedure InitGLOptions;
    procedure OpenGLGenObject;
    procedure display;
    procedure Zoomer(Step: Extended);
    function DoSelect(x: GLInt; y: GLInt): GLint;
    procedure UpdateBSPTree(Save: Boolean; ReloadString: Boolean = true);
    procedure ClearName(var s: string);
    procedure OpenBSPFile(FileName: string);
    procedure AddBSPFile(FileName: string);
    procedure CreateTemplate;
  end;

procedure StopTimer;

const
  crZoom = 1;
  crPan = 2;
  crRotXY = 3;
  crPer = 4;
  crDolly = 5;
  crMove = 6;
  crRotate = 9;
  crSelect = 8;
  crRotZ = 7;
  crScale = 10;
  crUpDown = 11;
  crFill = 12;
  crGet = 13;
  crErase = 14;
  crOpenHand = 15;
  crClosedHand = 16;

  MaxSelect = 500; // максимальное количество объектов под курсором
  MaxDeph = 100000.0; // максимальная глубина

  BrdScr = 16;
var
  EditValues: boolean;
  GridOn: Boolean;
  TempCur: TCursor;
  Scrn: TPoint;
  FormBSP: TFormBSP;
  TempX, TempY: Integer;
  ToolButTemp, ToolButTemp2: TToolButton;
  GpMove, TimeDrag: Boolean;
  FdTime, Fddiv: Single;
  BPSName: string;
  Start: Cardinal;

  selectBuf: array[0..MaxSelect * 4] of GLInt;

implementation

uses DAEImportF, DAEExportF, SettingF, ColorPicker, AddChunk, AddTemplate,
  ChangeAnimSpeed, AddEntities;

{$R *.dfm}

type
  TTimerThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create();
  end;

var
  Timer: TTimerThread;

procedure TFormBSP.OpenBSPFile(FileName: string);
var
  s: string;
  i: integer;
begin
  Start := GetTickCount;
  ClassTree.Enabled := true;
  BPSName := ExtractFileName(FileName);
  TreeProgress.Max := 1000;
  BSP.Mesh3D := nil;
  ActiveMesh := nil;
  SelectObj := 0;
  ClassTree.Clear;
  DataTree.Clear;
  BSP.ClearBSPFiles;

  ButOpenBSP.Enabled := false;
  ButAddBSP.Enabled := false;

  //  LoadTimer.Enabled:=True;
  try
    BSP.LoadBSPFileName(FileName); //20% progress 200
  except
    on E: Exception do
    begin
      ShowMessage(Format('Error "%s" in LoadBSPFileName()', [E.ClassName]));
      ButOpenBSP.Enabled := true;
    end;
  end;
  //   LoadTimer.Enabled:=False;
  UpdateBSPTree(true, true); //80% progess   800

  Caption := Format('%s - [%s]', [APPVER, BPSName]);
  BSPReplace := False;
  BSP.LastXImage := -1;
  ButSaveBSP.Enabled := True;
end;

procedure TFormBSP.AddBSPFile(FileName: string);
var
  s: string;
  i: integer;
begin
  Start := GetTickCount;
  ClassTree.Enabled := true;
  BPSName := ExtractFileName(FileName);
  TreeProgress.Max := 1000;
  BSP.Mesh3D := nil;
  // ClassTree.Clear;
  // DataTree.Clear;
  BSP.AddBSPFile;
  // TScanThread.Create(FileName);

  ButOpenBSP.Enabled := false;
  ButAddBSP.Enabled := false;
  //  LoadTimer.Enabled:=True;
  try
    BSP.LoadBSPFileName(FileName); //10% progress 100
  except
    on E: Exception do
    begin
      ShowMessage(Format('Error "%s" in LoadBSPFileName()', [E.ClassName]));
      ButOpenBSP.Enabled := true;
    end;
  end;
  //  LoadTimer.Enabled:=False;
  UpdateBSPTree(true, true); //80% progess   800

  Caption := Format('%s - [%s]', [APPVER, BPSName]);
  BSPReplace := False; //BSP.saidx = BSP.BSPHandle.MaxCount;
  BSP.LastXImage := -1;
  // ShowBuild.Enabled:=WF;
  // ButSaveBSP.Enabled := False;
end;

procedure TFormBSP.CreateTemplate;
var
  s: string;
  i: integer;
begin
  if TemplateForm.ShowModal = mrOK then
  begin
    Start := GetTickCount;
    ClassTree.Enabled := true;
    BPSName := 'template.bsp';
    TreeProgress.Max := 1000;
    BSP.Mesh3D := nil;
    ActiveMesh := nil;
    SelectObj := 0;
    ClassTree.Clear;
    DataTree.Clear;
    BSP.ClearBSPFiles;
    BSP.CreateTemplateBSPFile(TemplateForm.ComprOpt.ItemIndex);
    ButOpenBSP.Enabled := true;
    ButAddBSP.Enabled := false;
    UpdateBSPTree(true, true); //80% progess   800
    Caption := Format('%s - [%s]', [APPVER, BPSName]);
    BSPReplace := False;
    BSP.LastXImage := -1;
    ButSaveBSP.Enabled := True;
  end;
end;

procedure TFormBSP.ButOpenBSPClick(Sender: TObject);
begin
  //OggStopClick(Sender);
  if OpenDialog.Execute then
  begin
    if FileExists(OpenDialog.FileName) then
      OpenBSPFile(OpenDialog.FileName);
  end;
end;

procedure TFormBSP.ButAddBSPClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    if FileExists(OpenDialog.FileName) then
      AddBSPFile(OpenDialog.FileName);
  end;
end;

procedure TFormBSP.ExportAnimClick(Sender: TObject);
begin
  DAEExportForm.Exportclips.Checked := false;
  DAEExportForm.ExportClips.Enabled := False;
  ExportDaeClick(Sender);
end;

const
  MaxSingle: Single = 1E34;

function TFormBSP.LoadTGAResource(Name: string): Pointer;
var
  Stream: TCustomMemoryStream;
begin
  Stream := TResourceStream.Create(hInstance, Name, 'TGA');
  Result := AllocMem(Stream.Size);
  Move(Stream.Memory^, Result^, Stream.Size);
  Inc(Integer(Result), 18);
  Stream.Free;
end;

procedure TFormBSP.FormCreate(Sender: TObject);
begin
  //  TVistaAltFix.Create(Self);
  DragAcceptFiles(Handle, TRUE);
  Caption := APPVER;
  BSP := TBSP.Create;

  But.AnimButton := @AnimButton.Down;
  But.DrawBoxes := @DrawBoxes.Checked;
  But.AnimBox := AnimBox;
  //  But.ShowFull := @ShowFull.Checked;
  But.ShowLight := @ShowLight.Checked;
  But.TreeProgress := TreeProgress;
  But.ClassTree := ClassTree;
  But.XImage := ImageT32;
  But.Handle := Handle;
  //  But.Dummy := @ShowDummy.Checked;
  But.Collisions := @Collisions.Checked;
  But.Mirror := @MirrorObj.Checked;
  But.NullNodes := @NullNodes.Checked;
  But.WpNames := @WpNames.Checked;
  But.Emitters := @Emitters.Checked;
  But.NgonBSP := @NgonBSP.Checked;
  But.WardZone := @WardZone.Checked;
  // But.Ground := @Ground.Checked;
 //  But.Quilt := @Quilt.Checked;
  But.Icelayer := @Icelayer.Checked;
  But.Light := @LightsPoint.Checked;
  But.Canvas := Canvas;
  But.Move := @MoveBut.Down;
  But.Rotate := @RotatBut.Down;
  But.Scale := @ScaleBut.Down;

  StPanel := StatusBar1.Panels[0];
  But.StatusM := StPanel;
  But.App := Application;
  But.StopTimer := StopTimer;
  StPanel2 := StatusBar1.Panels[1];
  But.Status := StPanel2;

  GridOn := True;

  bBitPoint2 := LoadTGAResource('Dummy');
  EmittPoint := LoadTGAResource('Emitter');

  //UnActiveColor:= ColorToRGB(clBtnFace);
  //ActiveColor:= ColorToRGB(clWindow);
  // загружаем простые иконки
  Screen.Cursors[crSelect] := LoadCursor(HInstance, 'SELECT');
  Screen.Cursors[crMove] := LoadCursor(HInstance, 'MOVE');
  Screen.Cursors[crRotate] := LoadCursor(HInstance, 'ROTATE');
  Screen.Cursors[crScale] := LoadCursor(HInstance, 'SCALE');
  Screen.Cursors[crPan] := LoadCursor(HInstance, 'PAN');
  Screen.Cursors[crZoom] := LoadCursor(HInstance, 'ZOOM');
  Screen.Cursors[crDolly] := LoadCursor(HInstance, 'ZOOM2');
  Screen.Cursors[crPer] := LoadCursor(HInstance, 'PER');
  Screen.Cursors[crRotXY] := LoadCursor(HInstance, 'ROTXY');
  Screen.Cursors[crRotZ] := LoadCursor(HInstance, 'ROTZ');
  Screen.Cursors[crFill] := LoadCursor(HInstance, 'FILL');
  Screen.Cursors[crGet] := LoadCursor(HInstance, 'GETFILL');
  Screen.Cursors[crErase] := LoadCursor(HInstance, 'ERASE');
  Screen.Cursors[crOpenHand] := LoadCursor(HInstance, 'OPENHAND');
  Screen.Cursors[crClosedHand] := LoadCursor(HInstance, 'CLOSEDHAND');
  //Screen.Cursors[crUpDown]:=LoadCursor(HInstance, 'UPDOWN');
  // загружаем шфирты в GL и Инициализируем его
  OpenGLBox.GL_Font := FontGL;
  // ставим активность кнопок
  SelBut.Down := true;
  ToolButTemp := SelBut;
  SelectObj := 0;
  // загружаем активный курсор в буфер
  TempCur := OpenGLBox.Cursor;
  Scrn.X := screen.DesktopRect.Right - 1;
  Scrn.Y := screen.DesktopRect.Bottom - 1;

  DataTree.NodeDataSize := SizeOf(TPropertyData);
  ClassTree.NodeDataSize := SizeOf(TClassData);

  OpenGLBox.glBoxInit;
  InitGLOptions;
  OpenGLGenObject;
  // InitOggLib;
  // Timer:=TTimerThread.Create;
  if ParamCount <> 0 then
    OpenBSPFile(ParamStr(1));
  FloorUp.ShortCut := ShortCut(VK_PRIOR, []);
  FloorDown.ShortCut := ShortCut(VK_NEXT, []);
  AllFloors.ShortCut := ShortCut(VK_HOME, []);
end;

procedure TFormBSP.OpenGLGenObject;
begin
  // создаем объект осей XY
  glNewList(objAxes, GL_COMPILE);
  oglAxes;
  glEndList;

  glNewList(objLight, GL_COMPILE);
  oglLight;
  glEndList;

  glNewList(objBox, GL_COMPILE);
  oglBox(0.05, GL_QUADS);
  glEndList;
  // создаем Сетку
  glNewList(objGrid, GL_COMPILE);
  oglGrid(16);
  glEndList;
end;

procedure TFormBSP.InitGLOptions;
begin
  glEnable(GL_DEPTH_TEST);
  glAlphaFunc(GL_GREATER, 0.8);
  glEnable(GL_COLOR_MATERIAL);
  glShadeModel(GL_SMOOTH);
  // glEnable(GL_NORMALIZE);
  //  glEnable(GL_CULL_FACE);
  glEnable(GL_AUTO_NORMAL);
  // включение света
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glPolygonOffset(1.0, 1.0);
  glLightfv(GL_LIGHT0, GL_AMBIENT, @ambient);
  glLightfv(GL_LIGHT0, GL_POSITION, @l_position);
  // пропорции света
  glMaterialfv(GL_FRONT, GL_DIFFUSE, @mat_diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, @mat_specular);
  glMaterialfv(GL_FRONT, GL_SHININESS, @mat_shininess);

  // glSelectBuffer(SizeOf(selectBuf), @selectBuf);  // создание буфера выбора
  // очистка  TransView
  // zeromemory(@TransView, SizeOf(TransView));

  TransView.xrot := -20.0;
  TransView.yrot := 136.0;
  TransView.Per := 35.0;
  TransView.zoom := 50.0;
  AnimTimer := THRTimer.Create;
end;

// функция выделения или же выбора

function TFormBSP.DoSelect(x: GLInt; y: GLInt): GLint;
var
  SelObject: GLInt;
begin
  //Меняем координально режим выбора
  PSelect.x := x;
  PSelect.y := y;
  SelectMode := True;
  display; //(true);
  SelectMode := False;
  glReadBuffer(GL_BACK);
  SelObject := 0;
  glReadPixels(0, 0, 1, 1, GL_RGB, GL_UNSIGNED_BYTE, @SelObject);
  //StatusBar1.Panels[1].text := format('%d',[SelObject]);
  Result := selObject;
end;

procedure TFormBSP.display;
var
  i: integer;
  vp: TVector4i;
  //   fi,fj,
  fzoom: Glfloat;
  PMatrix, MvMatrix: TGLMatrixd4;
  wdx, wdy, wdz,
    wtx, wty, wtz,
    wtx2, wty2, wtz2: GLdouble;

begin
  //  if GLPause then Exit;
  if GLError then
    Exit;
  // проэктировочный режим
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity(); // загружаем еденичную матрицу
  glViewport(0, 0, GLwidth, GLheight);

  if SelectMode then
  begin // если режим выделения
    glGetIntegerv(GL_VIEWPORT, @vp);
    glLoadIdentity;
    // загружаем матрицу выделения
    gluPickMatrix(PSelect.x, GLHeight - PSelect.y - 4, 2, 2, vp);
    glViewport(0, 0, 1, 1);
  end;
  //  glGetFloatv(GL_PROJECTION_MATRIX, @PrMatrix);

  //  TestMinMax(10.0, 150.0, TransView.Per);
  // мартица перспективы

  gluPerspective(TransView.Per, GLwidth / GLheight, TransView.zoom / 50,
    MaxDeph);
  if TransView.yrot > 360.0 then
    TransView.yrot := TransView.yrot - 360;
  if TransView.yrot < -360.0 then
    TransView.yrot := TransView.yrot + 360;
  // матрица камеры
  gluLookAt(0, 0, -TransView.zoom, 0, 0, 0, 0, 1, 0);
  glRotatef(TransView.xrot, 1, 0, 0);
  glRotatef(TransView.yrot, 0, 1, 0); // смещение мира
  glTranslatef(TransView.xpos, TransView.ypos, TransView.zpos);
  //  glGetFloatv(GL_PROJECTION_MATRIX,@PrMatrix);
  //  WPar:=PrMatrix[4,4];
  // режим модели
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity(); // обновляем экран
  //  glClearDepth(0.0);
  glDepthMask(GL_TRUE);
  //glClearColor(1.0, 0.0, 0.56, 1.0); //temporary
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  //  Light
  Light(position2);
  glLightfv(GL_LIGHT0, GL_POSITION, @position2);
  glDisable(GL_LIGHTING);
  glDisable(GL_BLEND);
  glDisable(GL_TEXTURE_2D);
  glDisable(GL_ALPHA_TEST);
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);
  glEnable(GL_CULL_FACE);

  if SelectMode then
  begin
    glPushMatrix;
    if BSP.Mesh3D <> nil then
    begin
      BSP.Mesh3D.Draw(DrSelect);
    end;
    glPopMatrix;
  end
  else
  begin

    // Grid
    //  glPushMatrix;
    if GridOn then
    begin
      glColor3f(0.5, 0.5, 0.5);
      glCallList(objGrid);
    end;
    //  glPopMatrix;

    glEnable(GL_LIGHTING);
    glPushMatrix;

    //    If mainBox.Xmax>10000 then glScalef(0.001,0.001,0.001);
    if BSP.Mesh3D <> nil then
    begin
      LastTexture := 0;
      BSP.Mesh3D.Draw(DrGenAnim);
      BSP.Mesh3D.Draw(DrMesh);
      //   if CurrentFloor>-1 then BSP.Mesh3D.DrawSelectBox(Floors[CurrentFloor]);
      BSP.Mesh3D.Draw(DrBlend);

      glDisable(GL_DEPTH_TEST);
      if DrawBones.Checked then
        BSP.Mesh3D.Draw(DrBone);

    end;
    //
    glEnable(GL_LIGHTING);
    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);
    glPopMatrix;

    glDisable(GL_LIGHTING);
    glDisable(GL_DEPTH_TEST);
  end;
  glClear(GL_DEPTH_BUFFER_BIT);

  fzoom := TransView.zoom / 15;

  glLoadMatrixf(@ObjMatrix);
  glPushAttrib(GL_ENABLE_BIT);
  glDisable(GL_LIGHTING);
  glDisable(GL_TEXTURE_2D);
  glScalef(fzoom, fzoom, fzoom);

  if SelectMode and not MoveMode then
  else if MoveBut.Down or (RotBut.Down and (MoveBut = ToolButTemp2)) then
  begin
    oglDynAxes(AAxis, mMove, SelectMode, false);
  end;

  if RotatBut.Down or (RotBut.Down and (RotatBut = ToolButTemp2)) then
  begin
    // получаем координаты плоскости паралельной экрану
    glGetIntegerv(GL_VIEWPORT, @vp);
    glGetDoublev(GL_MODELVIEW_MATRIX, @MvMatrix);
    glGetDoublev(GL_PROJECTION_MATRIX, @PMatrix);
    gluProject(0, 0, 0, MvMatrix, PMatrix, vp,
      @wdx, @wdy, @wdz);
    gluUnProject(wdx, wdy, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    gluUnProject(wdx, wdy, -1, MvMatrix, PMatrix, vp,
      @wtx2, @wty2, @wtz2);
    eqn[0] := wtx2 - wtx;
    eqn[1] := wty2 - wty;
    eqn[2] := wtz2 - wtz;
    glGetFloatv(GL_MODELVIEW_MATRIX, @MatrixRot);
    oglDynAxes(AAxis, mRotate, SelectMode);
  end;

  if ScaleBut.Down or (RotBut.Down and (ScaleBut = ToolButTemp2)) then
  begin
    oglDynAxes(AAxis, mScale, SelectMode, false);
  end;
  glPopAttrib;

  if not SelectMode then
  begin
    // Axes X,Y,Z   -  рисуем оси слево внизу для понятия
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glViewport(0, 0, GLwidth div 7, GLheight div 7);
    gluPerspective(20, GLwidth / GLheight, 5, 20);
    gluLookAt(0, 0, -10, 0, 0, 0, 0, 1, 0);
    glRotatef(TransView.xrot, 1, 0, 0);
    glRotatef(TransView.yrot, 0, 1, 0);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glCallList(objAxes);
    // End Axes
    // выводим из того что нарисовали из буфера на экран
    SwapBuffers(OpenGLBox.GL_DC);
  end;

end;

procedure TFormBSP.ClearName(var s: string);
var
  i: Integer;
begin
  for i := 0 to Length(s) - 1 do
    if (s[i] = '/') or (s[i] = ':') or (s[i] = '\') then
      s[i] := '_';
end;

procedure TFormBSP.ExportImageClick(Sender: TObject);
var
  s: string;
  NData: PClassData;
  Data: TClassData;
  TxObj: TTextureOpenGL;
begin
  NData := ClassTree.GetNodeData(ClassTree.FocusedNode);
  if NData = nil then
    exit;
  Data := NData^;
  if (TObject(Data.Obj) is TTextureOpenGL) then
  begin
    TxObj := TTextureOpenGL(Data.Obj);
    s := TxObj.Name;
    //ClearName(s);
    SaveDialog2.FileName := s + '.png';
    if SaveDialog2.Execute then
      if (SaveDialog2.FileName <> '') then
        TxObj.SavePNGImage(SaveDialog2.FileName);
  end;
end;

procedure TFormBSP.OpenGLBoxResize(Sender: TObject);
begin
  GLwidth := OpenGLBox.Width;
  GLheight := OpenGLBox.Height;
end;

procedure TFormBSP.OpenGLBoxPaint(Sender: TObject);
begin
  display;
end;

procedure TFormBSP.Timer1Timer(Sender: TObject);
var
  step, cosX, cosY, sinY, sinX: Extended;
  procedure MoveX(value: single);
  begin
    SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
    SinCos(TransView.xrot * Pi / 180, sinX, cosX);
    Step := value * (TransView.zoom) *
      DegToRad(TransView.Per);
    Transview.xpos := Transview.xpos - Step * sinY;
    Transview.zpos := Transview.zpos + Step * cosY;
  end;
  procedure MoveY(value: single);
  begin
    SinCos(TransView.xrot * Pi / 180, sinX, cosX);
    SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
    Step := value * (TransView.zoom) *
      DegToRad(TransView.Per);
    Transview.ypos := Transview.ypos + Step * cosX;
    Transview.zpos := Transview.zpos + Step * sinY * sinX;
    Transview.xpos := Transview.xpos + Step * cosY * sinX;
  end;
begin
  // if RotateBut.Down then
  //   TransView.yrot := TransView.yrot + 0.2;
  if AnimReady then
    AnimTimer.ReadTimer;
  if (TransOnX <> 0) or (TransOnY <> 0) then
  begin
    if TransOnX = 1 then
      MoveX(+0.1);
    if TransOnX = -1 then
      MoveX(-0.1);
    if TransView.zoom > 1 then
    begin
      Zoomer(TransView.zoom / 10);
    end;
    TransView.zoom := 1;
    if TransOnY = 1 then
      Zoomer(-0.1);
    if TransOnY = -1 then
      Zoomer(0.1);
  end;
  if FormBSP.Active then
    OpenGLBox.Repaint;
  { If (PageControl1.ActivePageIndex=3) and OggLib and (bpp>0) then begin
   DrawSpectrum; // draw peak waveform
   DrawTime_Line(BASS_ChannelGetPosition(chan,BASS_POS_BYTE),0,TColor($FFFFFF)); // current pos
   PB.Repaint;
   end; }
end;

function AddClassData(ANode: PVirtualNode; Name: string; Value: string;
  ImageIndex: Integer; obj: TObject): PVirtualNode;
var
  Data: PClassData;
  s: string;
  c: Cardinal;
  AVST: TCustomVirtualStringTree;
begin
  AVST := FormBSP.ClassTree;
  Result := AVST.AddChild(ANode);
  Data := AVST.GetNodeData(Result);
  Avst.ValidateNode(Result, False);
  Data^.Name := Name;
  Data^.Value := Value;
  Data^.ImageIndex := ImageIndex;
  Data^.Obj := obj;
end;

procedure TFormBSP.ClassTreeChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  MaxSky: Single;
  MaxZoom: Single;
  p2: Pointer;
  i, k, n, j: integer;
  s: string;
  TxObj: TTextureOpenGL;
  MtObj: TMaterialObj;
  PropData: PPropertyData;
  NData: PClassData;
  Obj: Pointer;
  CheckTime: boolean;
  AnimateHash: Cardinal;
  AnimLib: TAnimDictionary;
  AnimFound: Boolean;
begin
  if not ClassTree.Visible then
    exit;
  NData := Sender.GetNodeData(Node);
  if NData = nil then
    exit;
  Obj := NData^.Obj;
  // select View Tab
  if PageControl1.ActivePageIndex <> 2 then
    case NData^.ImageIndex of
      3: PageControl1.ActivePageIndex := 1;
    else
      PageControl1.ActivePageIndex := 0;
    end;

  AnimReady := false;
  AnimBox.Clear;
  LabelTime.Caption := Format('%.2f sec', [0.0]);
  EditValues := False;
  if (TObject(Obj) is TChunk) then
  begin
    //  CheckTime:= (TObject(Data.Obj) is TWorld) or (TObject(Data.Obj) is TEntities) or (TObject(Data.Obj) is TBSPfile);
    EditValues := True;
    if (TObject(Obj) is TBSPfile) then
      EditValues := False;

    TChunk(Obj).AddFields(DataTree);
    BSP.Mesh3D := nil;
    SetLength(BSP.BoneList, 0);
    k := Length(BSP.BSPfiles);
    if (k > 1) then
    begin
      for i := 0 to k - 1 do
        // get active
        if TChunk(Obj).BSP = BSP.BSPfiles[i] then
          BSP.BSPfile := BSP.BSPfiles[i];
    end;

    //  if CheckTime then Start:=GetTickCount;
    if (TObject(Obj) is TBSPfile) and (Length(BSP.BSPfiles) > 1) then
    begin
      k := Length(BSP.BSPfiles);
      BSP.MeshFiles.ResetChilds(k);
      for i := 0 to k - 1 do
        BSP.MeshFiles.Childs[i] := BSP.BSPfiles[i].GetMesh;
      BSP.Mesh3D := BSP.MeshFiles;
    end
    else
      BSP.Mesh3D := TChunk(Obj).GetMesh;
    ExportDae.Enabled := false;
    ImportModeldae.Enabled := false;

    if (TChunk(Obj) is TEntities) then
      AddChunk.Caption := IM_ENTITY
    else if (TChunk(Obj) is TNullNodes) then
      AddChunk.Caption := IM_NULLNODES
    else
      AddChunk.Caption := ADD_ROOT;

    BtnChangeGlogalSpeed1.Enabled := (TChunk(Obj) is TDictAnim);

    AddChunk.Enabled := (TChunk(Obj) is TEntities) or (TChunk(Obj) is TBSPfile)
      or (TChunk(Obj) is TNullNodes);// or (TChunk(Obj) is TSpFrame);

    if (TChunk(Obj) is TSpMesh) or (TChunk(Obj) is TEntities) then
    begin
      ImportModeldae.Enabled := true;
    end;
    if (TChunk(Obj) is TZoneObj) or (TChunk(Obj) is TSpline) or (TChunk(Obj) is
      TBSPFile) then
    begin
      ExportDae.Enabled := true;
    end;

    if (TChunk(Obj) is TEntity) then
    begin
      if (TEntity(Obj).ent_type = 2) and (TEntity(Obj).Clump <> nil) then
      begin
        ExportDae.Enabled := true;
      end;

      if ((TEntity(Obj).ent_type = 3) or (TEntity(Obj).ent_type = 4)) and
        (TEntity(Obj).Clump <> nil) then
      begin
        ExportDae.Enabled := true;
        AnimateHash := TEntity(Obj).Clump.default_animation;
        AnimLib := nil;
        AnimClips := nil;
        CurAnimClip := nil;
        AnimBox.Clear;
        k := Length(BSP.BSPfiles);
        AnimReady := False;
        for i := 0 to k - 1 do
          if (BSP.BSPfiles[i].AnimLib <> nil) then
          begin
            AnimLib := BSP.BSPfiles[i].AnimLib;
            if AnimLib <> nil then
            begin
              if AnimClips = nil then
                AnimClips := TAnimClips.Create;
              AnimFound := (AnimClips.BuildAnim(AnimLib, AnimateHash) > 0);
              AnimReady := AnimReady or AnimFound;
              if (AnimateHash > 0) and (TEntity(Obj).Clump.Root <> nil) then
                AnimClips.SetRootBone(TEntity(Obj).Clump.Root.hash);
            end;

          end;

        if AnimReady then
        begin
          AnimBox.Items.Assign(AnimClips.FStrings);
          CurAnimClip := AnimClips.GetItemID(0);
          AnimBox.ItemIndex := 0;
        end;
      end;
    end;
    if (TChunk(Obj) is TRenderBlock) or (TChunk(Obj) is TSpMesh) then
    begin
      // ExportDae.Enabled:=true;
      ImportModeldae.Enabled := true;
    end;

    //PMGenerateRoof1.Enabled := TChunk(Obj) is TZoneObj;

    //  if CheckTime then StatusBar1.Panels[1].Text:= Format('Loaded: %d ms', [GetTickCount - Start]);
    ExportImage.Enabled := false;
    ImportImage.Enabled := false;
    if (TObject(Obj) is TTextureOpenGL) then
    begin
      TxObj := TTextureOpenGL(Obj);
      ImageT32.Picture.Bitmap.Width := 0;
      ImageT32.Picture.Bitmap.Height := 0;
      ImageT32.Picture.Bitmap.Assign(TxObj.Bitmap);
      LabImgName.Caption := TxObj.name;
      LabImgWidth.Caption := format('%d x %d pixels', [TxObj.width,
        TxObj.height]);
      LabImgBits.Caption := format('%d bits', [TxObj.image.bits]);
      LabImgMigMag.Caption := BSPGLMigMagS[TxObj.min_mag_type];
      LabImgHash.Caption := format('%x', [TxObj.hash]);
      LabImgFormat.Caption := format('%x', [TxObj.pixel_format]);
      LabImgCompr.Caption := BSPGLRepeatS[TxObj.wrap_type];
      LabImgSize.Caption := format('%d bytes', [TxObj.image.bytewidth * 4 *
        TxObj.image.height]);
      s := 'not used';
      if (TxObj.image.bits = 4) then
        s := '16 colors';
      if (TxObj.image.bits = 8) then
        s := '256 colors';
      LabImgPalette.Caption := s;
      ScrollBox1Resize(self);
      ExportImage.Enabled := true;
      ImportImage.Enabled := true;
    end;

  end;

  if BSP.Mesh3D <> nil then
  begin

    if GLError then
    begin
      Application.MessageBox(
        PChar('OpenGL Crash...' + sGLError[GLErrorCode]),
        PChar('Error'), MB_ICONASTERISK or MB_OK);
      // GLError:=false;
    end;
    //NTexture := 0;
    //Material.use:=false;
    //ClassTree.Items.Clear;

    with MainBox do
    begin
      Xmax := -MaxSingle;
      Xmin := MaxSingle;
      Ymax := -MaxSingle;
      Ymin := MaxSingle;
      Zmax := -MaxSingle;
      Zmin := MaxSingle;
    end;

    // RichEdit1.Text := Str;
    ImageReady := false;
    BSP3DReady := false;

    // StPanel2.Text  := IntToStr(XCntr.Index);
    ShowGraph := false;

    ScrollBox1Resize(self);

    ExportImage.Enabled := ImageReady;
    ImportImage.Enabled := ImageReady; //BSPReplace and ImageReady;
    ImportAnim.Enabled := AnimReady;
    ExportAnim.Enabled := AnimReady;
    //  Panel1.Visible:= AnimReady;
    Panel7.Visible := AnimReady;

    if AnimReady then
      AnimBoxChange(self);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    with MainBox do
    begin
      BSP.Mesh3D.GetBox(MainBox);
      TransView.Xpos := -(XMax + Xmin) / 2;
      TransView.Ypos := -(YMax + Ymin) / 2;
      TransView.Zpos := -(ZMax + Zmin) / 2;
      MaxZoom := Max((Xmax - Xmin), (Ymax - Ymin));
      MaxZoom := Max(MaxZoom, (Zmax - Zmin));
      TransView.zoom := MaxZoom * 3;
      TransView.xrot := -20.0;
      TransView.Per := 35.0;
      {  if WF then MaxSky:=15000 else MaxSky:= 9000;
        if XMax > MaxSky then  //sky
        begin
          TransView.Xpos := 0;
          TransView.Ypos := -86;
          TransView.Zpos := 0;
          TransView.zoom := 100;
          TransView.xrot := 30;
          TransView.Per := 90;
          //   glDisable(GL_DEPTH_TEST);
          //   glEnable(GL_CULL_FACE);
        end;  }
      TVModel := TransView;
    end;
  end;
  StPanel.Text := NData^.Name;
end;

procedure TFormBSP.ExportBSP3DClick(Sender: TObject);
var
  s: string;
begin
  // Application.MessageBox('This version for test.', 'Testing', MB_OK);
  // Exit;

  { s := BSP.Mesh3D.Name;
   ClearName(s);
   SaveBSP3D.FileName := Format('(%s).BSP3d', [s]);
   if SaveBSP3D.Execute and (SaveBSP3D.FileName <> '') then
   begin
     BSP.Mesh3D.SaveAsBSP3d(SaveBSP3D.FileName);
   end;  }
end;

procedure TFormBSP.ImportImageClick(Sender: TObject);
var
  NData: PClassData;
  Data: TClassData;
  TxObj: TTextureOpenGL;
begin
  NData := ClassTree.GetNodeData(ClassTree.FocusedNode);
  if NData = nil then
    exit;
  Data := NData^;
  if (TObject(Data.Obj) is TTextureOpenGL) then
  begin
    if OpenDialog2.Execute and (OpenDialog2.FileName <> '') then
    begin
      TxObj := TTextureOpenGL(Data.Obj);
      TxObj.ReplacePNGImage(OpenDialog2.FileName, ClassTree);
      ClassTreeChange(ClassTree, ClassTree.FocusedNode);
    end;
  end;
end;

procedure StopTimer;
begin
  FormBSP.LoadTimer.Enabled := False;
  FormBSP.StatusBar1.Panels[1].Text := Format('Packed: %d ms', [GetTickCount -
    Start]);
  FormBSP.ClassTree.Enabled := True;
  FormBSP.Timer1.Enabled := True;
end;

procedure TFormBSP.ButSaveBSPClick(Sender: TObject);
begin
  FormBSP.SaveDialog3.FileName := FormBSP.OpenDialog.FileName;
  // ChangeFileExt(s,'.bsp');
  if SaveDialog3.Execute and (SaveDialog3.FileName <> '') then
  begin
    Start := GetTickCount;
    BSP.SaveBSP(SaveDialog3);
    if BSP.BSPfile.iscompress then
    begin
      LoadTimer.Enabled := true;
      ClassTree.Enabled := False;
      Timer1.Enabled := False;
    end;
    StatusBar1.Panels[1].Text := Format('Saved: %d ms', [GetTickCount - Start]);
  end;
  Caption := Format('%s - [%s]', [APPVER,
    ExtractFileName(SaveDialog3.FileName)]);
end;

procedure TFormBSP.Expand1Click(Sender: TObject);
begin
  if ClassTree.GetFirstSelected <> nil then
    ClassTree.FullExpand(ClassTree.GetFirstSelected);
end;

procedure TFormBSP.Collupse1Click(Sender: TObject);
begin
  if ClassTree.GetFirstSelected <> nil then
    ClassTree.FullCollapse(ClassTree.GetFirstSelected);
end;

procedure TFormBSP.ScrollBox1Resize(Sender: TObject);
begin
  ImageT32.Left := FormBSP.Scrollbox1.Width div 2 - ImageT32.Width div 2;
  ImageT32.Top := FormBSP.Scrollbox1.Height div 2 - ImageT32.Height div 2;
  if ImageT32.Left < 0 then
    ImageT32.Left := 0;
  if ImageT32.Top < 0 then
    ImageT32.Top := 0;
end;

procedure TFormBSP.AnimBoxChange(Sender: TObject);
begin
  // update timer
  AnimTimer.StartTimer;
  CurAnimClip := AnimClips.GetItemID(AnimBox.ItemIndex);
  ShowGraph := false;
  //  UpdateGraph;
  AnimTimer.MaxTime := CurAnimClip.Time;
  LabelTime.Caption := Format('%.2f sec', [AnimTimer.MaxTime]);
end;

procedure TFormBSP.ImportAnimClick(Sender: TObject);
var
  id, i: integer;
  Options: DAEOptions;
  Chunk: TChunk;
  NodeData: PClassData;
  AnimLibNode: PVirtualNode;
  AnimLib: TAnimDictionary;
  AnimClip: TDictAnim;
  animname: string;
begin
  //  Application.MessageBox('This version for test.', 'Testing', MB_OK);
  if ClassTree.FocusedNode <> nil then
  begin
    NodeData := ClassTree.GetNodeData(ClassTree.FocusedNode);
    if TObject(NodeData^.Obj) is TChunk then
    begin
      Chunk := TChunk(NodeData^.Obj);
      if Chunk.IDType = 20001 then
        Chunk := TEntity(Chunk).Clump;

      if OpenDialogDAE.Execute and (OpenDialogDAE.FileName <> '') then
      begin
        DAEImportForm.OuTAnimDictionary.Items.Clear;
        for i := 0 to High(BSP.BSPfiles) do
          if (BSP.BSPfiles[i].AnimLib <> nil) then
          begin
            DAEImportForm.OuTAnimDictionary.ItemIndex :=
              DAEImportForm.OuTAnimDictionary.Items.Add(BSP.BSPfiles[i].bspfilename);
          end;

        if DAEImportForm.ShowModal = mrOK then
        begin
          Options := [];
          if DAEImportForm.ClipOpt.ItemIndex = 0 then
            Include(Options, DAE_ADDCLIP);
          if DAEImportForm.ClipOpt.ItemIndex = 1 then
            Include(Options, DAE_REPLACECLIP);
          //clip name ;
          AnimLib := nil;
          for i := 0 to High(BSP.BSPfiles) do
            if (BSP.BSPfiles[i].AnimLib <> nil) then
              if DAEImportForm.OuTAnimDictionary.Text =
                BSP.BSPfiles[i].bspfilename then
              begin
                AnimLibNode := ClassTree.IterateSubtree(nil, SearchChunk,
                  BSP.BSPfiles[i].AnimLib);
                AnimLib := BSP.BSPfiles[i].AnimLib;
                break;
              end;
          if AnimLib <> nil then
          begin
            if DAE_ADDCLIP in Options then
              animname := DAEImportForm.ClipName.Text
            else
              animname := AnimBox.Text;
            AnimClip := BSP.ImportDAEAnimClip(OpenDialogDAE.FileName, AnimLib,
              Options, animname);
            // Update AnimLib
            AnimLib.UpdateClassNode(ClassTree, AnimLibNode);
            ClassTreeChange(ClassTree, ClassTree.FocusedNode);
          end;
        end;
        {
         AnimBoxChange(Sender);    }
      end;
    end;
  end;
end;

procedure TFormBSP.OpenGLBoxMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  TransView.zoom := TransView.zoom + TransView.zoom * 0.1;
  if not Timer1.Enabled then
    OpenGLBox.Repaint;
end;

procedure TFormBSP.OpenGLBoxMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  TransView.zoom := TransView.zoom - TransView.zoom * 0.1;
  if not Timer1.Enabled then
    OpenGLBox.Repaint;
end;

procedure TFormBSP.Zoomer(Step: Extended);
var
  sinX, cosX, sinY, cosY: Extended;
begin
  SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
  SinCos((TransView.xrot - 90) * Pi / 180, sinX, cosX);
  Transview.ypos := Transview.ypos + Step * cosX;
  Transview.xpos := Transview.xpos + Step * cosY * sinX;
  Transview.zpos := Transview.zpos + Step * sinY * sinX;
end;

procedure TFormBSP.OpenGLBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  CurPoint: TPoint;
  sinX, cosX, sinY, cosY, Step: Extended;
  hit: Integer;
  procedure GetAxis;
  begin
    if hit > 10000 then
    begin
      AAxis := TAxis(hit - 10001);
      OpenGLBox.Repaint;
    end
    else
      AAxis := MAxis;
  end;
begin
  if OpenGLBox.OnOpenGL then
  begin
    //if not (ssMiddle in Shift) and (TempCur<>OpenGLBox.Cursor) then OpenGLBox.Cursor:=TempCur;
    if (ssLeft in Shift) or (ssMiddle in Shift) then
    begin
      Ctrl := ssCtrl in Shift;
      ShiftOn := ssShift in Shift;
      GetCursorPos(CurPoint);
      CurPoint.X := TempX - CurPoint.X;
      CurPoint.Y := TempY - CurPoint.Y;
      //if (CurPoint.X=0) and (CurPoint.Y=0) then exit;

      case OpenGLBox.Cursor of
        crDolly:
          begin
            Zoomer(-CurPoint.Y / 10);
          end;
        crPan:
          begin

            SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
            SinCos(TransView.xrot * Pi / 180, sinX, cosX);
            Step := CurPoint.X / GLwidth * (TransView.zoom) *
              DegToRad(TransView.Per);
            Transview.xpos := Transview.xpos - Step * sinY;
            Transview.zpos := Transview.zpos + Step * cosY;
            Step := CurPoint.Y / GLheight * (TransView.zoom) *
              DegToRad(TransView.Per);
            Transview.ypos := Transview.ypos + Step * cosX;
            Transview.zpos := Transview.zpos + Step * sinY * sinX;
            Transview.xpos := Transview.xpos + Step * cosY * sinX;
          end;
        crRotXY:
          begin
            Transview.Xrot := Transview.Xrot + CurPoint.Y / 5;
            Transview.yrot := Transview.yrot - CurPoint.X / 5;
          end;
        crPer:
          begin
            TransView.Per := TransView.Per - CurPoint.Y / 10;
          end;
        crZoom:
          begin //UpdateActiveWindow:=true;
            TransView.zoom := TransView.zoom - CurPoint.Y / 10;
          end;
        crMove:
          begin
            PTarget.X := X;
            PTarget.Y := GLheight - Y - 1;
          end;
        crRotate:
          begin
            PTarget.X := X;
            PTarget.Y := GLheight - Y - 1;
          end;
        crScale:
          begin
            PTarget.X := X;
            PTarget.Y := GLheight - Y - 1;
          end;
      end;

      GetCursorPos(CurPoint);
      TempX := CurPoint.X;
      TempY := CurPoint.Y;
      if CurPoint.X > Scrn.X - BrdScr then
      begin
        TempX := BrdScr;
        setcursorpos(TempX, CurPoint.y);
      end;
      if CurPoint.X < BrdScr then
      begin
        TempX := Scrn.X - BrdScr;
        setcursorpos(TempX, CurPoint.y);
      end;
      if CurPoint.y > Scrn.Y - BrdScr then
      begin
        TempY := BrdScr;
        setcursorpos(CurPoint.x, TempY);
      end;
      if CurPoint.y < BrdScr then
      begin
        TempY := Scrn.Y - BrdScr;
        setcursorpos(CurPoint.x, TempY);
      end;
      if not Timer1.Enabled then
        OpenGLBox.Repaint;
    end
    else
      case OpenGLBox.Cursor of
        crDefault, crSelect
          //, crFill,crErase, crGet, crMove, crRotate, crScale
        :
          begin
            if MoveBut.Down then
              MoveMode := true;
            if RotatBut.Down then
              RotateMode := true;
            if ScaleBut.Down then
              ScaleMode := true;

            GetCursorPos(CurPoint);
            if (TempX = CurPoint.X) and (TempY = CurPoint.Y) then
              Exit;

            TempX := CurPoint.X;
            TempY := CurPoint.Y;
            // тестирование окон
            hit := 0;

            if not AnimButton.Down then
              hit := DoSelect(X, Y);
            StatusBar1.Panels.Items[0].Text := Format('[%.*d]', [4, hit]);
            if hit > 0 then
            begin
              {
               if MoveBut.Down then
               begin
                 if hit<10000 then begin OpenGLBox.Cursor :=crDefault;  exit;end;
                 OpenGLBox.Cursor := crMove;
                 GetAxis;
               end
               else if RotatBut.Down then
               begin
                 if hit<10000 then begin OpenGLBox.Cursor :=crDefault;  exit;end;
                 OpenGLBox.Cursor := crRotate;
                 GetAxis;
               end
               else if ScaleBut.Down then
               begin
                 if hit<10000 then begin OpenGLBox.Cursor :=crDefault;  exit;end;
                 OpenGLBox.Cursor := crScale;
                 GetAxis;
               end
               else
               begin     }
              OpenGLBox.Cursor := crSelect;

              RotateMode := false;
              ScaleMode := false;
              MoveMode := false;
              SelectObjOn := hit;

              // end;
            end
            else
              OpenGLBox.Cursor := crDefault;
            //  if SelectObj>0 then display(time,false);

          end;
      end;

    //
  end;
end;

procedure TFormBSP.OpenGLBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_NUMPAD7: TransView.xrot := TransView.xrot + 10;
    VK_NUMPAD1: TransView.xrot := TransView.xrot - 10;
    VK_NUMPAD8: TransView.zpos := TransView.zpos + 10;
    VK_NUMPAD2: TransView.zpos := TransView.zpos - 10;
    VK_NUMPAD4: TransView.xpos := TransView.xpos + 10;
    VK_NUMPAD6: TransView.xpos := TransView.xpos - 10;
    VK_NUMPAD9: TransView.Per := TransView.Per + 10;
    VK_NUMPAD3: TransView.Per := TransView.Per - 10;
  end;
  if (Key = Ord('W')) then
    TransOnY := +1; // Zoomer(-TransView.zoom/10);
  if (Key = Ord('S')) then
    TransOnY := -1; // Zoomer(TransView.zoom/10);
  if (Key = Ord('A')) then
    TransOnX := -1; // MoveX(-0.1);
  if (Key = Ord('D')) then
    TransOnX := +1; // MoveX(+0.1);
  {        if (Key=Ord('C')) and (CentrBut.Enabled) then CentrButClick(CentrBut);
          if (Key=Ord('Q')) then SelButClick(SelBut);
          if (Key=Ord('W')) and (MoveBut.Enabled)then ToolButClick(MoveBut);
          if (Key=Ord('E')) and (RotatBut.Enabled)then ToolButClick(RotatBut);
          if (Key=Ord('R')) and (ScaleBut.Enabled)then ToolButClick(ScaleBut);
          if (Key=Ord('X')) then    Zoomer(+1);
          if (Key=Ord('S')) then    Zoomer(-1); }

  if not Timer1.Enabled then
    OpenGLBox.Repaint;
end;

procedure TFormBSP.OpenGLBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('W')) then
    TransOnY := 0;
  if (Key = Ord('S')) then
    TransOnY := 0;
  if (Key = Ord('A')) then
    TransOnX := 0;
  if (Key = Ord('D')) then
    TransOnX := 0;
end;

procedure TFormBSP.ToolButton13Click(Sender: TObject);
begin
  ToolButton13.Down := false;
  ToolButton14.Down := false;
  ToolButton15.Down := false;
  ToolButton16.Down := false;
  ToolButton17.Down := false;
  ToolButton18.Down := false;
  TToolButton(Sender).Down := true;
  MAxis := TAxis(TToolButton(Sender).Index - 10);
  AAxis := MAxis;
  if not Timer1.Enabled then
    OpenGLBox.Repaint;
end;

procedure TFormBSP.ToolButClick(Sender: TObject);
begin
  if (TToolButton(Sender) = MoveBut) and (MAxis = Axis_XYZ) then
    ToolButton13Click(ToolButton13);
  if ToolButTemp = TToolButton(Sender) then
  begin
    ToolButTemp.Down := false;
    if (ToolButTemp2 <> nil) and (ToolButTemp2.Enabled) then
    begin
      if (ToolButTemp2 = MoveBut) or
        (ToolButTemp2 = RotatBut) or
        (ToolButTemp2 = ScaleBut) then
      begin
        ToolButClick(ToolButTemp2);
        exit;
      end
      else
        ToolButTemp2 := nil;
    end;
    OpenGLBox.Cursor := crDefault;
    SelBut.Down := true;
    ToolButTemp := SelBut;
  end
  else
  begin
    TToolButton(Sender).Down := true;
    OpenGLBox.Cursor := TToolButton(Sender).Index + 1;
    if ToolButTemp <> nil then
      ToolButTemp.Down := false;
    ToolButTemp2 := ToolButTemp;
    ToolButTemp := TToolButton(Sender);
    TempCur := OpenGLBox.Cursor;
  end;

  {  if (TToolButton(Sender) = MoveBut) or
              (TToolButton(Sender) = RotatBut) or
              (TToolButton(Sender) = ScaleBut) then  HmPickBut.Down:= false;
 //  if TToolButton(Sender)=MoveBut then HmPickBut.Down:= false;    }
  if not Timer1.Enabled then
    OpenGLBox.Repaint;
end;

procedure TFormBSP.ToolButtonSMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels.Items[0].Text := TToolButton(Sender).Hint;
end;

procedure TFormBSP.OpenGLBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CurPoint: TPoint;
  // b, a, t, q: Integer;
  Node: PVirtualNode;
  s: string;
  Data: PClassData;
begin
  if OpenGLBox.OnOpenGL then
  begin
    if Button = mbLeft then
    begin
      if OpenGLBox.Cursor = crDefault then
        if MoveBut.Down or RotatBut.Down or
          ScaleBut.Down then
        else
        begin
          SelectObj := 0;
          SelectKey := nil;
          SelectType := 0;
          //   ToolButton6.Enabled := false;
          ActiveMesh := nil;
          {  if EditAnim.Down then begin
             UpdateAnimTree(TreeView2);
             UpdateGraph;
            MoveBut.Enabled :=EdMode;
            RotatBut.Enabled :=EdMode;
            ScaleBut.Enabled :=EdMode;
             end;     }
          OpenGLBox.Repaint;
        end;

      if OpenGLBox.Cursor = crSelect then
        if SelectObjOn > 0 then
        begin

          SelectObj := SelectObjOn;
          s := Format('[%.*d]', [4, SelectObj]);
          Node := ClassTree.IterateSubtree(nil, SearchForChunk, Pointer(s));
          if Assigned(Node) then
          begin
            ClassTree.FocusedNode := Node;
            OpenGLBox.Repaint;
            if ssShift in Shift then
              ClassTree.Selected[Node] := True;
            //   else
            if ssCtrl in Shift then
            begin
              Data := ClassTree.GetNodeData(Node);
              if (TObject(Data^.Obj) is TChunk) then
                TChunk(Data^.Obj).AddFields(DataTree);
            end; //}
          end
            //      ToolButton6.Enabled := true;

             {     OpenGLBox.Repaint;
                If EditAnim.Down and (ActiveMesh <> nil) then begin
                UpdateAnimTree(TreeView2);
                UpdateGraph;
                EdMode:=ActiveMesh.Transform.TransType<>TTNone;
                MoveBut.Enabled :=EdMode;
                RotatBut.Enabled :=EdMode;
                ScaleBut.Enabled :=EdMode;
                end; }

              {  if ShowBuild.Down then
                begin
                 MoveBut.Enabled :=True;
                 UpdateBuildPanel;
                end;  }
            {      if ActivePoxel <> nil then
                  begin
                    if ImportMapActive then
                    begin
                      Label4.Caption := ActivePoxel.Name;
                      TreeView3.Selected := ActivePoxel.TreeNodeLink;
                      RefrashList(ActivePoxel);
                    end
                    else if SelectPoxel<>ActivePoxel then
                    begin
                      SelectLabel.Caption := ActivePoxel.Name;
                      TreeView1.Selected := ActivePoxel.TreeNodeLink;
                      RefrashList(ActivePoxel);
                      SelectDone;
                    end;
                  end;    }

        end
        else

        begin
          //    SelectLabel.Caption := 'None';
          SelectObj := 0;
          //    ToolButton6.Enabled := false;
          MoveBut.Enabled := False;
          RotatBut.Enabled := False;
          ScaleBut.Enabled := False;
          ActiveMesh := nil;
          OpenGLBox.Repaint;
        end;

      {     if MoveMode and (SelectObj=0) then
           begin
           SelButClick(SelBut);
           end;  }

      case OpenGLBox.Cursor of
        crMove, crRotate, crScale:
          case AAxis of
            Axis_X: ToolButton13Click(ToolButton13);
            Axis_Y: ToolButton13Click(ToolButton14);
            Axis_Z: ToolButton13Click(ToolButton15);
            Axis_XY: ToolButton13Click(ToolButton16);
            Axis_YZ: ToolButton13Click(ToolButton17);
            Axis_XZ: ToolButton13Click(ToolButton18);
            Axis_XYZ:
              begin
                ToolButton13.Down := false;
                ToolButton14.Down := false;
                ToolButton15.Down := false;
                ToolButton16.Down := false;
                ToolButton17.Down := false;
                ToolButton18.Down := false;
                MAxis := Axis_XYZ;
                AAxis := MAxis;
                OpenGLBox.Repaint;
                // ToolButton13Click(ToolButton18)
              end;
          end;
      end;

      if OpenGLBox.Cursor = crMove then
      begin
        MoveReady := true;
        MoveFirts := true;
        PTarget.X := X;
        PTarget.Y := GLheight - Y - 1;
      end
      else
        MoveMode := false;

      if OpenGLBox.Cursor = crScale then
      begin
        ScaleReady := true;
        ScaleFirts := true;
      end
      else
        ScaleMode := false;

      if OpenGLBox.Cursor = crRotate then
      begin
        RotateReady := true;
        RotateFirts := true;
      end
      else
        RotateMode := false;

      GetCursorPos(CurPoint);
      TempX := CurPoint.X;
      TempY := CurPoint.Y;
    end;
    if Button = mbMiddle then
    begin
      GetCursorPos(CurPoint);
      TempX := CurPoint.X;
      TempY := CurPoint.Y;
      TempCur := OpenGLBox.Cursor;
      OpenGLBox.Cursor := crPan;
    end;
    if Button = mbRight then
      ToolButClick(RotBut);
  end;
end;

procedure TFormBSP.OpenGLBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  if mbMiddle = Button then
    OpenGLBox.Cursor := TempCur;

  MoveReady := false;
  ScaleReady := false;
  RotateReady := false;
  if not Timer1.Enabled then
    OpenGlBox.Repaint;
  //     TrackPanel1.Repaint;
  ;
  OpenGLBox.Repaint;
end;

procedure TFormBSP.OpenGLBoxClick(Sender: TObject);
begin
  OpenGLBox.OnOpenGL := true;
end;

procedure TFormBSP.CentrButClick(Sender: TObject);
var
  MaxZoom: single;
begin
  if BSP.Mesh3D <> nil then
  begin

    TVModel.xrot := TransView.xrot;
    TVModel.yrot := TransView.yrot;
    TransView := TVModel;

  end
  else
  begin
    TransView.xpos := 0;
    TransView.ypos := 0;
    TransView.zpos := 0;
    TransView.xrot := -20.0;
    TransView.yrot := 136.0;
    TransView.Per := 35.0;
    TransView.zoom := 50.0;
  end;
  if not Timer1.Enabled then
    OpenGlBox.Repaint;
end;

var
  Edited: Boolean;

procedure TFormBSP.SelButClick(Sender: TObject);
begin
  ToolButTemp.Down := false;
  OpenGLBox.Cursor := crDefault;
  SelBut.Down := true;
  //  HmPickBut.Down:=false;
  ToolButTemp := SelBut;
  if not Timer1.Enabled then
    OpenGLBox.Repaint;
end;

procedure TFormBSP.ClassTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin

  if not ClassTree.Focused and Node.Selected then
    TCustomTreeView(Sender).Canvas.Font.Color := clGreen;
end;

var
  NeedUpdate: Boolean;
  MainNodeSelect: Boolean;

procedure TFormBSP.RedrawClick(Sender: TObject);
begin
  OpenGLBox.Repaint;
end;

procedure TFormBSP.ClassTreeAdvancedCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
var
  Rect: TRect;
  oldcolor: TColor;
begin
  if (Node.ImageIndex >= $01000000) and (Stage = cdPostPaint) then
  begin
    with Sender.Canvas do
    begin
      Rect := Node.DisplayRect(True);
      Rect.Left := Rect.Left - 17;
      Rect.Right := Rect.Left + 14;
      Rect.Top := Rect.Top + 1;
      Rect.Bottom := Rect.Top + 14;
      oldcolor := Brush.Color;
      Brush.Color := Node.ImageIndex and $FFFFFF;
      FillRect(Rect);
      Rectangle(Rect);
      Brush.Color := oldcolor;
    end;
  end;
end;

procedure TFormBSP.UpdateBSPTree(Save: boolean; ReloadString: Boolean = true);
var
  i: integer;
begin
  // обновляем дерево
  if Save then
  begin

    // BSP.Loading:=true;
    // BSP.LinkChunks; //30%
   //  BSP.Loading:=false;

    // ButSaveBSP.Enabled := True;
  end;

  BSPUpdating := true;
  BuildClassTree; //90%
  StatusBar1.Panels[1].Text := Format('Loaded: %d ms', [GetTickCount - Start]);
  BSPUpdating := false;
  ButOpenBSP.Enabled := true;
  ButAddBSP.Enabled := true;
  // обновить строки
  //if ReloadString then
   // BSP.LoadValueString(StringsTable);

  ClassTree.Expanded[ClassTree.FocusedNode] := true;
  ClassTree.Visible := true;
  ClassTreeChange(ClassTree, ClassTree.FocusedNode);
end;

function HexToByte(S: Pchar): Byte;
const
  Convert: array['0'..'f'] of SmallInt =
    (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15);
begin
  result := Byte((Convert[S[0]] shl 4) + Convert[S[1]]);
end;

procedure TFormBSP.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      if (Pos('.BSP', UpperCase(CFileName)) <> 0) then
      begin
        if (BSP.BSPfiles[0].bspfilename = '') then
          OpenBSPFile(CFileName)
        else
          AddBSPFile(CFileName);
      end
      else if (Pos('.DAE', UpperCase(CFileName)) <> 0) then
      begin
        BSP.TestDae(CFileName);
      end;
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TFormBSP.ClassTreeDblClick(Sender: TObject);
begin
  if ClassTree.GetFirstSelected <> nil then
    ClassTreeChange(TBaseVirtualTree(Sender), ClassTree.GetFirstSelected);
end;

type
  TBinItem = record
    Name: Integer;
    Str: Integer;
  end;

  ABinItem = array of TBinItem;

  TBinFile = record
    Version: Integer;
    BlockLength: Integer;
    NumStrings: Integer;
    SizeItem: Integer;
    IndexTable: ABinItem;
    Data: Pointer;
  end;

var
  AbsIndex: Integer;

procedure TFormBSP.SearchForText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Data: Pointer; var Abort: Boolean);
var
  NodeData: PClassData;
begin
  NodeData := Sender.GetNodeData(Node);
  Abort := ((Pos(AnsiUpperCase(string(data)), AnsiUpperCase(NodeData.Name)) <> 0)
    or (Pos(AnsiUpperCase(string(data)), AnsiUpperCase(NodeData.Hash)) <> 0))
    and (AbsIndex < Sender.AbsoluteIndex(Node));
  //abort the search if a node with the text is found.
end;

procedure TFormBSP.SearchForChunk(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Data: Pointer; var Abort: Boolean);
var
  NodeData: PClassData;
begin
  NodeData := Sender.GetNodeData(Node);
  Abort := (Pos(AnsiUpperCase(string(data)), AnsiUpperCase(NodeData.ID)) <> 0);
end;

procedure TFormBSP.FindTextClick(Sender: TObject);
var
  i, index: integer;
  Found: boolean;
  s: string;
  Node: PVirtualNode;
begin
  Found := false;
  s := Search.Text;
  Node := nil;
  AbsIndex := 0;
  if ClassTree.FocusedNode <> nil then
  begin
    AbsIndex := ClassTree.AbsoluteIndex(ClassTree.FocusedNode);
  end;
  Node := ClassTree.IterateSubtree(Node, SearchForText, Pointer(s));
  if Assigned(Node) then
  begin
    ClassTree.FocusedNode := Node;
    ClassTree.Selected[Node] := True;
  end
  else
    Application.MessageBox(
      PChar(
      Format('Search string "%s" not found', [s])
      ),
      PChar('Information'), MB_ICONASTERISK or MB_OK);
end;

procedure TFormBSP.SearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FindTextClick(Sender);
    Key := #0;
  end;

end;

procedure TFormBSP.BuildClassTree;
var
  BSPNode: PVirtualNode;
  found: TChunk;
  s: string;
  i, num: integer;
  function AddFloorBound(Bound: TBBox): TBox;
  begin
    with Result do
    begin
      Xmax := bound.max[1];
      Xmin := bound.min[1];
      Ymax := bound.max[2];
      Ymin := bound.min[2];
      Zmax := bound.max[3];
      Zmin := bound.min[3];
    end;
  end;
begin
  // clear
  ClassTree.Visible := false;
  if (Length(BSP.BSPfiles) = 1) then
    ClassTree.Clear;
  //    BSP.CntrArr.ClearNames;
     // BSP.CntrArr.ClearChilds;
     // XCntr.ClearAllChilds;
  TreeProgress.Position := 100; //BSP.BSPHandle.MaxCount;
  {   BSP tree }

  try
    CurrentFloor := -1;
    Floors1.Enabled := False;
    FloorUp.Enabled := false;
    FloorDown.Enabled := false;
    SetLength(Floors, 0);
    for i := 0 to 8 do
      Floors1.Items[i].Visible := False;

    ClassTree.UpdateCount := 1;
    with BSP do
    begin
      BSPNode := BSPfile.AddClassNode(ClassTree, nil);
      if (BSPfile.World.floor_count > 1) then
      begin
        GridOn := False;
        ShowGrid.Checked := False;
      end;
      if (BSPfile.World.floor_count > 0) then
      begin
        MaxFloors := BSPfile.World.floor_count;
        SetLength(Floors, BSPfile.World.floor_count);
        Floors1.Items[0].Visible := True;
        Floors1.Items[0].Checked := false;
        for i := 0 to BSPfile.World.floor_count - 1 do
        begin
          Floors[i] := AddFloorBound(BSPfile.World.Floors.floors[i].BBox);
          Floors1.Items[i + 1].Visible := True;
        end;
        CurrentFloor := 0;
        Floors1.Items[1].Checked := true;
        Floors1.Enabled := True;
        FloorUp.Enabled := True;
        FloorDown.Enabled := True;
      end;
    end;
    ClassTree.UpdateCount := 0;
  finally
    TreeProgress.Position := 1000;
    //BSPImport := TreeProgress.Position=TreeProgress.Max;
  end;
  ClassTree.FocusedNode := BSPNode;
end;

procedure TFormBSP.DataTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PPropertyData;
begin
  Data := Sender.GetNodeData(Node);
  if TextType = ttNormal then
    case Column of
      0:
        CellText := Data.DName;
      1:
        CellText := Data.DValue;
      2:
        CellText := Data.DType;
    end;
end;

procedure TFormBSP.DataTreeBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  r: TRect;
begin
  inherited;
  // color every 2nd row in grid  Odd(Node.Index)
  R := Sender.GetDisplayRect(Node, 0, True);
  if Odd((R.Top - Sender.OffsetY) div Node.NodeHeight) then
  begin
    ItemColor := 16446961;
    EraseAction := eaColor;
  end;
end;

procedure TFormBSP.DataTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PPropertyData;
begin
  Data := Sender.GetNodeData(Node);
  case Kind of
    ikNormal, ikSelected:
      case Column of
        1:
          if Data.ValueIndex > 0 then
            ImageIndex := Data.ValueIndex;
        2:
          if (Data.DBType = BSPRefHash) and (Cardinal(Data.PValue^) <> 0) then
            ImageIndex := 20;
      end;
  end;
end;

procedure TFormBSP.ClassTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PClassData;
begin
  Data := Sender.GetNodeData(Node);
  if TextType = ttNormal then
    case Column of
      0:
        CellText := Data.Name;
      1:
        CellText := Data.Value;
      2:
        CellText := Data.Hash;
      3:
        CellText := Data.ID;
      4:
        CellText := Data.Version;
    end;
end;

procedure TFormBSP.ClassTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PClassData;
begin
  Data := Sender.GetNodeData(Node);
  case Kind of
    ikNormal, ikSelected:
      case Column of
        0:
          if Data.ImageIndex > -1 then
            ImageIndex := Data.ImageIndex;
        1:
          if Data.ValueIndex > 0 then
            ImageIndex := Data.ValueIndex;
      end;
  end;
end;

procedure TFormBSP.DataTreeAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  Rect: TRect;
  oldcolor: TColor;
  oldpen: TColor;
  Data: PPropertyData;
begin
  Data := Sender.GetNodeData(Node);
  if Column = 1 then
    if (Data.DBType = BSPColor) or (Data.DBType = BSPVect4b) then
      with TargetCanvas do
      begin
        Rect := CellRect;
        Rect.Left := Rect.Left + 3;
        Rect.Right := Rect.Left + 14;
        Rect.Top := Rect.Top + 1;
        Rect.Bottom := Rect.Top + 14;
        oldcolor := Brush.Color;
        oldpen := Pen.Color;
        Pen.Color := clBlack;
        Brush.Color := DWord(Data.PValue^) and $FFFFFF;
        FillRect(Rect);
        Rectangle(Rect);
        Pen.Color := oldpen;
        Brush.Color := oldcolor;
      end;
end;

{ TTimerThread }

constructor TTimerThread.Create;
begin
  inherited create(false);
  Priority := tpNormal;
  FreeOnTerminate := true;
end;

procedure TTimerThread.Execute;
begin
  inherited;
  while True do
  begin
    // if (FormBSP.TreeProgress.Position>0) and (FormBSP.TreeProgress.Position<>FormBSP.TreeProgress.Max) then
    FormBSP.TreeProgress.Update;
    Sleep(100);
  end;
  // Terminate;
end;

procedure TFormBSP.LoadTimerTimer(Sender: TObject);
var
  pos: integer;
begin
  pos := Round(BSP.BSPfile.GetProgress / BSP.BSPfile.GetMaxProgress * 1000);
  TreeProgress.Position := pos; // 20%
  //  TreeProgress.Repaint;
end;

procedure TFormBSP.FormDestroy(Sender: TObject);
begin
  BSP.Free;
  ClassTree.Clear;
  DataTree.Clear;
  AnimTimer.Free;
  Timer1.Enabled := False;
end;

procedure TFormBSP.DataTreeNodeDblClick(Sender: TBaseVirtualTree;
  const HitInfo: THitInfo);
var
  Data: PPropertyData;
  i, Num, j: Integer;
  parr: Pointer;
  s: string;
  ANode, Node: PVirtualNode;
  LoadItem: TLoadItemProcedure;
  color: TUColor;
begin
  if EditValues and (HitInfo.HitColumn = 1) then
  begin
    Data := Sender.GetNodeData(HitInfo.HitNode);
    case Data.DBType of
      BSPColor:
        begin
          color := TUColor(Data.PValue^);
          ColorPickerForm.SetColor(color);
          if ColorPickerForm.ShowModal = mrOk then
          begin
            color := ColorPickerForm.GetColor;
            Data.DValue := Format('<r:%d g:%d b:%d a:%d>',
              [color[0], color[1], color[2], color[3]]);
            TUColor(Data.PValue^) := color;
            Data.Changed := true;
            DataTreeEdited(Sender, HitInfo.HitNode, 1);
          end;
        end;
      BSPVect4b:
        begin
          color := TUColor(Data.PValue^);
          ColorPickerForm.SetColor(color);
          if ColorPickerForm.ShowModal = mrOk then
          begin
            color := ColorPickerForm.GetColor;
            Data.DValue := Format('<r:%d g:%d b:%d>',[color[0], color[1], color[2]]);
            TUColor(Data.PValue^) := color;
            Data.Changed := true;
            DataTreeEdited(Sender, HitInfo.HitNode, 1);
          end;
        end;
        BSPString, BSPInt, BSPUint, BSPFloat, BSPVect, BSPVect4, BSPDword,
        BSPSint,
        BSPWpTypes, BSPMatFlags, BSPEntTypes, BSPKeyType, BSPWord, BSPFace,
        BSPUVCoord,
        BSPUInt64, BSPRefHash, BSPHash, BSPBool, BSPRVect, BSPByte,
        BSPBox, BSPUVWord,
        BSPGLParam, BSPGLBool, BSPGLRepeat, BSPGLMigMag, BSPGLFactor,
        BSPGLShade, BSPNullBoxType, BSPRenderFlags, BSPMatrixFlag,
        BSPClumpFlag, BSPTextureFormat, BSPEnvMapType,BSPWorldFlags, BSPMeshFlags,
        BSPFloorFlags, BSPResourceAccessData, BSPReadFlags, BSPHintFlags, BSPConstantFlags,
        BSPSUint16, BSPMatBlockFlags, BSPNullNodeFlags, BSPSpawnType:
        begin
          if Data.DBType = BSPHash then
            Search.Text := Data.DValue;
          Sender.EditNode(HitInfo.HitNode, 1);
        end;
      BSPLoad:
        if Assigned(Data.PFunc) then
        begin
          LoadItem := Data.PFunc;
          ANode := HitInfo.HitNode;
          Num := Data.PNum;
          parr := Data.PArr;
          TreeProgress.Min := 0;
          TreeProgress.Max := Num - 1;
          Node := ANode.Parent;
          DataTree.DeleteNode(ANode);
          Start := GetTickCount;
          DataTree.UpdateCount := 1;
          for i := MAX_LOAD to num - 1 do
          begin
            LoadItem(Node, i, parr);
            TreeProgress.Position := i;
          end;
          DataTree.UpdateCount := 0;
          StatusBar1.Panels[1].Text := Format('Loaded: %d ms', [GetTickCount -
            Start]);
        end;
    end;
  end
  else if (HitInfo.HitColumn = 2) then
  begin
    Data := Sender.GetNodeData(HitInfo.HitNode);
    if Data.DBType = BSPRefHash then
    begin
      // go to Hash
      s := Format('[%.*x]', [8, Cardinal(Data.PValue^)]);
      Node := ClassTree.IterateSubtree(nil, SearchHash, @s);
      if Node <> nil then
      begin
        ClassTree.FocusedNode := Node;
        ClassTree.Selected[Node] := True;
        OpenGLBox.Repaint;
      end;
    end;
  end;
end;

procedure TFormBSP.SearchHash(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Data: Pointer; var Abort: Boolean);
var
  NodeData: PClassData;
begin
  NodeData := Sender.GetNodeData(Node);
  if NodeData^.Hash = string(Data^) then
    Abort := true;
end;

procedure TFormBSP.ShowFullClick(Sender: TObject);
begin
  // reselect node
  ClassTreeChange(ClassTree, ClassTree.FocusedNode);
end;

procedure TFormBSP.ShowGridClick(Sender: TObject);
begin
  GridOn := ShowGrid.Checked;
  OpenGLBox.Repaint;
end;

procedure TFormBSP.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormBSP.ClassTreeChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  BSP.SetMeshCheck(Node, ClassTree);
  // OpenGLBox.Repaint;
end;

procedure TFormBSP.SearchChunks(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Data: Pointer; var Abort: Boolean);
var
  NodeData: PClassData;
  Chunk: TChunk;
begin
  if Node.CheckType = ctNone then
    exit;
  NodeData := Sender.GetNodeData(Node);
  if TObject(NodeData^.Obj) is TChunk then
  begin
    Chunk := TChunk(NodeData^.Obj);
    Chunk.CheckHide(Node);
  end;
end;

procedure TFormBSP.ShowChunkClick(Sender: TObject);
begin
  GLPause := true;
  ClassTree.IterateSubtree(nil, SearchChunks, nil);
  GLPause := false;
  ClassTree.Repaint;
  OpenGLBox.Repaint;
end;

procedure TFormBSP.ExportDaeClick(Sender: TObject);
var
  NodeData: PClassData;
  Chunk: TChunk;
  s: string;
  Options: DAEOptions;
begin
  // export to Dae
  if ClassTree.FocusedNode <> nil then
  begin
    NodeData := ClassTree.GetNodeData(ClassTree.FocusedNode);
    if TObject(NodeData^.Obj) is TChunk then
    begin
      Chunk := TChunk(NodeData^.Obj);
      Options := [];
      if Sender is TButton then
      begin // Anim Export
        s := Format('%s[%s]', [s, CurAnimClip.Name]);
        DAEExportForm.ExportClips.Enabled := False;
        DAEExportForm.CGopt.Enabled := False;
        Include(Options, DAE_ANIM);
      end
      else
      begin
        s := ChangeFileExt(ExtractFileName(BSP.BSPfile.bspfilename), '');
        DAEExportForm.ExportClips.Enabled := (AnimClips <> nil);
        DAEExportForm.CGopt.Enabled := True;
      end;
      SaveDialogDae.FileName := ChangeFileExt(s, '.dae');
      if SaveDialogDae.Execute and (SaveDialogDae.FileName <> '') then
      begin
        // s := ExtractFileName(SaveDialogDae.FileName);
        if ExtractFileExt(SaveDialogDae.FileName) = '' then
          SaveDialogDae.FileName := SaveDialogDae.FileName + '.dae';

        if (Chunk.IDType = C_Entity) or (Chunk.IDType = C_Root) then
          if DAEExportForm.ShowModal = mrOK then
          begin
            case DaeExportForm.CBExportOptions.ItemIndex of
              0: Include(Options, DAE_MAX); //3dsMax(OpenCollada)
              1: Include(Options, DAE_BLENDER); //Blender
            else
              Include(Options, DAE_MAX); //Default
            end;

            if DaeExportForm.ConvertDummies.Checked then
              Include(Options, DAE_DUMMY_JOINT);

            if DAEExportForm.CBAxis.ItemIndex = 1 then
              Include(Options, DAE_CONVERT);
            if DAE_ANIM in Options then
            else
            begin
              if DAEExportForm.CGopt.Checked then
                Include(Options, DAE_CG);
              if (AnimClips <> nil) and DAEExportForm.ExportClips.Checked then
                Include(Options, DAE_CLIPS);
            end;

            BSP.ExportDAE(SaveDialogDae.FileName, Chunk, Options,DAEExportForm.edtScale.Value);
          end;
      end;
    end;
  end;
end;

procedure TFormBSP.ImportModeldaeClick(Sender: TObject);
var
  Data: PClassData;
  Chunk: TObject;
  Mesh: TRenderBlock;
  Entities: TEntities;
  Entity: TEntity;
begin
  if OpenDialogDae.Execute and (OpenDialogDae.FileName <> '') then
  begin
    //Only UV RIGHT NOW
    Data := ClassTree.GetNodeData(ClassTree.FocusedNode);
    if Data = nil then
      exit;
    Chunk := Data.Obj;
    { if Chunk is TSpMesh then
     begin
       Mesh := TSpMesh(Data.Obj).models[0];
       Mesh.ReplaceModel(OpenDialogDae.FileName);
       TSpMesh(Data.Obj).CalculateBound;
       //Mesh.
     end
     else if Chunk is TRenderBlock then
     begin
       Mesh := TRenderBlock(Data.Obj);
       Mesh.ReplaceTextureCoords(OpenDialogDae.FileName);
     end
     else }
    if Chunk is TEntities then
    begin
      Entities := TEntities(Data.Obj);
      BSP.ImportDAE(OpenDialogDae.FileName);
    end;
    UpdateBSPTree(true, true);
  end;
end;

procedure TFormBSP.Floor81Click(Sender: TObject);
begin
  CurrentFloor := TMenuItem(Sender).Tag;
  OpenGLBox.Repaint;
end;

procedure TFormBSP.FloorUpClick(Sender: TObject);
begin
  if CurrentFloor + 1 < MaxFloors then
  begin
    CurrentFloor := CurrentFloor + 1;
    Floors1.Items[CurrentFloor + 1].Checked := true;
  end;
  OpenGLBox.Repaint;
end;

procedure TFormBSP.FloorDownClick(Sender: TObject);
begin
  if CurrentFloor > 0 then
  begin
    CurrentFloor := CurrentFloor - 1;
    Floors1.Items[CurrentFloor + 1].Checked := true;
  end;
  OpenGLBox.Repaint;
end;

procedure TFormBSP.Settings1Click(Sender: TObject);
begin
  if SettingsForm.ShowModal = mrOK then
  begin
    CompressGZ := zcLevel7;
    case SettingsForm.ComprOpt.ItemIndex of
      0:
        begin
          CompressBSP := false;
        end; // none
      1:
        begin
          CompressBSP := true;
          CompressGZ := zcLevel7;
        end; // default
      2:
        begin
          CompressBSP := true;
          CompressGZ := zcFastest;
        end; // fast
      3:
        begin
          CompressBSP := true;
          CompressGZ := zcMax;
        end; // max
    end;
  end;
end;

procedure TFormBSP.DataTreeCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  EditLink := TPropertyEditLink.Create;
end;

procedure TFormBSP.ClassTreeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PClassData;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TFormBSP.DataTreeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PPropertyData;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TFormBSP.DataTreeEdited(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PPropertyData;
  CData: PClassData;
begin
  if EditValues and (Column = 1) then
  begin
    Data := Sender.GetNodeData(Node);
    if Data.Changed then
    begin
      CData := ClassTree.GetNodeData(ClassTree.FocusedNode);
      //BSPRefHash TODO update ClassTree and Mesh
      if (TObject(CData.Obj) is TChunk) then
        TChunk(CData.Obj).UpdateNode(ClassTree, Data);
      ClassTree.Refresh;
      ClassTreeChange(ClassTree, ClassTree.FocusedNode);
    end;
  end;
end;

procedure TFormBSP.DataTreePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PPropertyData;
begin
  if Column = 1 then
  begin
    Data := Sender.GetNodeData(Node);
    if Data.Changed then
      TargetCanvas.Font.Style := [fsBold]
    else
      TargetCanvas.Font.Style := [];
  end;
end;

procedure TFormBSP.ClassTreePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PClassData;
begin
  if Column = 0 then
  begin
    Data := Sender.GetNodeData(Node);
    if Data.Changed then
      TargetCanvas.Font.Style := [fsBold]
    else
      TargetCanvas.Font.Style := [];
  end;
end;

procedure TFormBSP.SearchChunk(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Obj: Pointer; var Abort: Boolean);
var
  NodeData: PClassData;
  Chunk: TChunk;
begin
  NodeData := Sender.GetNodeData(Node);
  if TObject(NodeData^.Obj) is TChunk then
  begin
    Chunk := TChunk(NodeData^.Obj);
    if (Chunk = Obj) then
    begin
      Abort := true;
    end;
  end;
end;

procedure TFormBSP.DeleteChunkClick(Sender: TObject);
var
  Node, PNode: PVirtualNode;
  Data: PClassData;
  Chunk, PChunk: TChunk;
begin
  if ClassTree.GetFirstSelected <> nil then
  begin
    Node := ClassTree.GetFirstSelected;
    Data := ClassTree.GetNodeData(Node);
    if Data = nil then
      exit;
    Chunk := TChunk(Data.Obj);
    PNode := Node.Parent;
    if PNode <> nil then
    begin
      Data := ClassTree.GetNodeData(PNode);
      PChunk := TChunk(Data.Obj);
      Data.Changed := true;
      while Node <> nil do
      begin
        ClassTree.DeleteNode(Node);
        Node := ClassTree.IterateSubtree(nil, SearchChunk, Chunk);
      end;
      if PChunk <> nil then
        PChunk.DeleteChild(Chunk);
    end;
    DataTree.Clear;
    OpenGLBox.Repaint;
  end;

end;

procedure TFormBSP.ClassTreeContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  Node, PNode: PVirtualNode;
  Data: PClassData;
  Chunk, PChunk: TChunk;
  CanDel, CanCopy, CanMerge: Boolean;
begin
  CanDel := true;
  CanCopy := False;
  CanMerge := False;
  if EditValues and (ClassTree.GetFirstSelected <> nil) then
  begin
    Node := ClassTree.GetFirstSelected;
    Data := ClassTree.GetNodeData(Node);
    Chunk := TChunk(Data.Obj);
    PNode := Node.Parent;
    if PNode <> nil then
    begin
      Data := ClassTree.GetNodeData(PNode);
      PChunk := TChunk(Data.Obj);
      if (Data.Obj <> nil) or
        (Chunk is TEntity) or
        (Chunk is TZones) or
        (Chunk is TNullNodes) then
        CanCopy := True;
      if Chunk is TAnimDictionary then
        CanMerge := True;
      if (Data.Obj = nil) or
        (Chunk is TMatDictionary) or
        (Chunk is TTextures) or
        (Chunk is TWorld) or
        (Chunk is TAnimDictionary) or
        (Chunk is TEntities) or
        ((Chunk is TClump) and (PChunk is TEntity)) or
        ((Chunk is TMaterialObj) and (PChunk is TRenderBlock)) or
        ((Chunk is TTextureOpenGL) and (PChunk is TMaterialObj)) or
        ((Chunk is TFloors) and (PChunk is TWorld)) or
        ((Chunk is TSectorOctree) and (PChunk is TWorld)) then
        CanDel := false;
    end;
  end;
  DeleteChunk.Enabled := EditValues and CanDel;
  CopyChunk.Enabled := EditValues and CanCopy;
  MergeChunk.Enabled := EditValues and CanMerge;
end;

procedure TFormBSP.WndProc(var Msg: TMessage);
begin
  FindText.Refresh; // fix Windows Alt
end;

procedure TFormBSP.DataTreeScroll(Sender: TBaseVirtualTree; DeltaX,
  DeltaY: Integer);
begin
  if Sender.IsEditing then
    Sender.UpdateEditBounds;
end;

procedure TFormBSP.CopyChunkClick(Sender: TObject);
var
  Node, PNode, NewNode: PVirtualNode;
  Data: PClassData;
  Chunk, PChunk, NewChunk: TChunk;
begin
  if ClassTree.GetFirstSelected <> nil then
  begin
    Node := ClassTree.GetFirstSelected;
    Data := ClassTree.GetNodeData(Node);
    if Data = nil then
      exit;
    Chunk := TChunk(Data.Obj);
    PNode := Node.Parent;
    if PNode <> nil then
    begin
      Data := ClassTree.GetNodeData(PNode);
      PChunk := TChunk(Data.Obj);
      Data.Changed := true;
      if PChunk <> nil then
      begin
        NewChunk := Chunk.CopyChunk(nil);
        PChunk.InsertChild(Chunk, NewChunk);
        NewNode := NewChunk.AddClassNode(ClassTree, PNode);
        Data := ClassTree.GetNodeData(NewNode);
        Data.Changed := true;
        ClassTree.MoveTo(NewNode, Node, amInsertAfter, False);
      end;
    end;
  end;
  OpenGLBox.Repaint;
end;

procedure TFormBSP.MergeChunkClick(Sender: TObject);
var
  AnimLibNode: PVirtualNode;
  Data: PClassData;
  AnimLib: TAnimDictionary;
begin
  if ClassTree.GetFirstSelected <> nil then
  begin
    AnimLibNode := ClassTree.GetFirstSelected;
    Data := ClassTree.GetNodeData(AnimLibNode);
    if Data = nil then
      exit;
    AnimLib := TAnimDictionary(Data.Obj);
    AnimLib.MergeAnims;
    // Update AnimLib
    AnimLib.UpdateClassNode(ClassTree, AnimLibNode);
    ClassTreeChange(ClassTree, ClassTree.FocusedNode);
  end;
  OpenGLBox.Repaint;
end;
{
procedure TFormBSP.PMGenerateRoof1Click(Sender: TObject);
var
  Node, NewNode: PVirtualNode;
  Data: PClassData;
  ZoneObj: TZoneObj;
  Ward: TClump;
  newHashStr: string;
  newHash: Cardinal;
  i, j, area_index, newVertexSize, state: integer;
  atomicMesh: TAtomic;

begin
  if ClassTree.GetFirstSelected <> nil then
  begin
    Node := ClassTree.GetFirstSelected;
    Data := ClassTree.GetNodeData(Node);
    if Data = nil then
      exit;
    ZoneObj := TZoneObj(Data.Obj);
    Data.Changed := true;
    if (ZoneObj.hasBorder) and not (ZoneObj.hasWard) then
    begin
      Ward := TClump(ZoneObj.Border.CopyChunk);
      Ward.TypeName := 'Ward';
      Ward.Root.matrix_2.m := Ward.Root.matrix_1.m;
      newHashStr := 'MDL_face' + IntToStr(Ward.Root.mask) +
        IntToStr(Ward.Root.hash);
      newHash := Ward.MakeHash(StrNew(PChar(newHashStr)), Length(newHashStr));
      Ward.hash := newHash;
      Ward.Root.name := StrNew(PChar(newHashStr));
      Ward.Root.hash := newHash;
      for i := 0 to High(Ward.Root.Childs) do
      begin
        if Ward.Root.Childs[i] is TAtomic then
        begin
          atomicMesh := TAtomic(Ward.Root.Childs[i]);
          atomicMesh.hash := newHash;
          if atomicMesh.has_ModelGroup then
          begin
            //create a mesh.
            newVertexSize := 3 + (Length(ZoneObj.Area.vectors) - 3) * 3;
            atomicMesh.ModelGroup.models[0].flag_1:= $0E0E7C02;
            atomicMesh.ModelGroup.models[0].flag_3:= $000CE802;
            atomicMesh.ModelGroup.models[0].vertex_count := newVertexSize;
            atomicMesh.ModelGroup.models[0].indices_count := newVertexSize div
              3;
            atomicMesh.ModelGroup.models[0].materialHash := $193CCDC6;
            atomicMesh.ModelGroup.models[0].material :=
              atomicMesh.ModelGroup.models[0].BSP.Materials.FindMaterialOfHash(atomicMesh.ModelGroup.models[0].materialHash);
            atomicMesh.ModelGroup.models[0].material.SetMaterial(atomicMesh.ModelGroup.models[0].mesh);
            SetLength(atomicMesh.ModelGroup.models[0].mesh.Vert, newVertexSize);
            SetLength(atomicMesh.ModelGroup.models[0].mesh.Normal,
              newVertexSize);
            SetLength(atomicMesh.ModelGroup.models[0].mesh.face,
              atomicMesh.ModelGroup.models[0].indices_count);

            for j := 0 to 2 do
            begin
              atomicMesh.ModelGroup.models[0].mesh.Vert[j][0] :=
                ZoneObj.Area.vectors[j][1];
              atomicMesh.ModelGroup.models[0].mesh.Vert[j][1] :=
                ZoneObj.Area.vectors[j][2];
              atomicMesh.ModelGroup.models[0].mesh.Vert[j][2] :=
                ZoneObj.Area.vectors[j][3];
            end;
            j := 3;
            atomicMesh.ModelGroup.models[0].mesh.Vert[j] :=
              atomicMesh.ModelGroup.models[0].mesh.Vert[j - 3];
            atomicMesh.ModelGroup.models[0].mesh.Vert[j + 1] :=
              atomicMesh.ModelGroup.models[0].mesh.Vert[j - 1];
            atomicMesh.ModelGroup.models[0].mesh.Vert[j + 2][0] :=
              ZoneObj.Area.vectors[j][1];
            atomicMesh.ModelGroup.models[0].mesh.Vert[j + 2][1] :=
              ZoneObj.Area.vectors[j][2];
            atomicMesh.ModelGroup.models[0].mesh.Vert[j + 2][2] :=
              ZoneObj.Area.vectors[j][3];

            //add normals
            for j := 0 to newVertexSize - 1 do
            begin
              atomicMesh.ModelGroup.models[0].mesh.Normal[j][0] := 0.0;
              atomicMesh.ModelGroup.models[0].mesh.Normal[j][1] := 1.0;
              atomicMesh.ModelGroup.models[0].mesh.Normal[j][2] := 0.0;
            end;
            area_index := 0;
            //add indices
            for j := 0 to atomicMesh.ModelGroup.models[0].indices_count - 1 do
            begin
              atomicMesh.ModelGroup.models[0].mesh.Face[j][0] := area_index;
              atomicMesh.ModelGroup.models[0].mesh.Face[j][1] := area_index + 1;
              atomicMesh.ModelGroup.models[0].mesh.Face[j][2] := area_index + 2;
              area_index := area_index + 3;
            end;
            atomicMesh.ModelGroup.CalculateBound;
          end;
        end;
      end;

      ZoneObj.Ward := Ward;
      ZoneObj.hasWard := true;

      NewNode := ZoneObj.Ward.AddClassNode(ClassTree, Node);
      Data := ClassTree.GetNodeData(NewNode);
      Data.Changed := true;
      ClassTree.MoveTo(NewNode, Node, amAddChildLast, False);
    end;
  end;
  OpenGLBox.Repaint;
end;
      }
{procedure TFormBSP.PMRoof1Click(Sender: TObject);
var
  Node, NewNode: PVirtualNode;
  Data: PClassData;
  Frame: TSpFrame;
  InvertedMatrix: TMatrix;
  stream: TMemoryStream;
  sl,sl2: TStringlist;
  i,j,k: integer;
  entities: TEntities;
  entity: TEntity;
  clump: TClump;
  tNull: TNullBox;
  temp :string;
  flag_value: integer;
  mesh: TSpMesh;
  renderBlock: TRenderBlock;
  vertices: AVer;
  product: double;
  normals,point:Tver;
  BspTree:TSpBSP;
  //flag: Cardinal;
  Models: AModels;
  face,face_temp: TFace;
  temp_angle,index:integer;
  a_x,a_y,a_z,branch_flag: byte;
  NumFaces:ATexures;
  flag: Cardinal;
  p_test: Pointer;
{function getAngle(cx, cy, ex, ey:single): byte;
var
  dx,dy,theta: double;
begin
  dy:= ey - cy;
  dx:= ex - cx;
  theta:= Math.ArcTan2(dy,dx);
  Result:= Round((256 / 3.14159265359) * theta);
end;}

{procedure CalculateBound(v1,v2,v3: Tver);
var
  model_index, vector_index: integer;
  min, max: TVect4;
  cVector: TVer;
  cMesh: TRenderBlock;
  Bbox: TBBox;
  InnerSphere: TVect4;
  Radius: Single;

  procedure SetMinMax(v: Tver);
begin
        cVector := v;
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
begin
    min[1] := Math.MaxSingle;
    min[2] := min[1];
    min[3] := min[1];
    max[1] := Math.MinSingle;
    max[2] := max[1];
    max[3] := max[1];

    SetMinMax(v1);
    SetMinMax(v2);
    SetMinMax(v3);

    BBox.min := min;
    BBox.max := max;
    InnerSphere[1] := (BBox.max[1] + BBox.min[1]) / 2;
    InnerSphere[2] := (BBox.max[2] + BBox.min[2]) / 2;
    InnerSphere[3] := (BBox.max[3] + BBox.min[3]) / 2;
    ShowMessage(FloatToStr(InnerSphere[1])  + ':' + FloatToStr(InnerSphere[2]) + ':' + FloatToStr(InnerSphere[3]));
    Radius:= Math.Max(Math.Max(InnerSphere[1],InnerSphere[2]),InnerSphere[3]);
    ShowMessage(FloatToStr(Radius));
end;

function Normalize(v:TVer):TVer;
var
  v1:double;
begin
  v1:= sqrt(v[0] * v[0] + v[1] * v[1] + v[2]* v[2]);
  Result[0]:= 1.0 / v1 * v[0];
  Result[1]:= 1.0 / v1 * v[1];
  Result[2]:= 1.0 / v1 * v[2];
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
    ShowMessage('LENGTH'+FloatToStr(Length));
    pn[0] := pn[0] / Length;
    pn[1] := pn[1] / Length;
    pn[2] := pn[2] / Length;
  end;

  function GenNormal(v1,v2,v3:TVer):Tver;
  var
  n,pa,pb,pc:Tver;
  area: double;
  i: integer;
  begin
    pa:=v1;
    pb:=v2;
    pc:=v3;
    n := VectorProduct(CreateVector(pa,pb),CreateVector(pa,pc));
    Normalise(n);
    area:= -1.0 * (n[0] * v3[0] + n[1] * v3[1] + n[2] * v3[2]);
    ShowMessage('Area: ' + FloatToStr(area));
    ShowMessage(IntToStr(Round(Math.ArcCos(n[0]) / 0.012271847)));
    result:=n;
  end;
       }
{
function IsStrANumber(const S: string): Boolean;
var
  P: PChar;
begin
  P      := PChar(S);
  Result := False;
  while P^ <> #0 do
  begin
    if not (P^ in ['0'..'9']) then Exit;
    Inc(P);
  end;
  Result := True;
end;

procedure forAllChildrens(frame: TSpFrame);
var
  j: Integer;
begin
  for j:=0 to High(frame.Childs) do
  begin
    if frame.Childs[j] is TNullBox then
    begin
      tNull:= TNullBox(frame.Childs[j] );
      if (tNull.emm_type > Length(BSPNullBoxTypeS) -1) or (IsStrANumber(BSPNullBoxTypeS[tNull.emm_type])) then
        sl.Add('Frame name: ' + frame.name + ' Type: ' + IntToStr(tNull.emm_type) );
    end
    else if frame.Childs[j] is TSpFrame then
    begin
      forAllChildrens(TSpFrame(frame.Childs[j]));
    end;
  end;
  for j:=0 to High(frame.Bones) do
  begin
    if frame.Bones[j] is TNullBox then
    begin
      tNull:= TNullBox(frame.Bones[j] );
      if (tNull.emm_type > Length(BSPNullBoxTypeS) -1) or (IsStrANumber(BSPNullBoxTypeS[tNull.emm_type])) then
        sl.Add('Frame name: ' + frame.name + ' Type: ' + IntToStr(tNull.emm_type) );
    end
    else if frame.Bones[j] is TSpFrame then
    begin
      forAllChildrens(TSpFrame(frame.Bones[j]));
    end;
  end;
end;

function testSameFace(faceindex: integer): boolean;
var
  ii: integer;
  t_face: TFace;
begin
  t_face:= Models[i].mesh.Face[faceindex];
  //face 0
  if not ( (face[0] + face[1] + face[2]) = (t_face[0] + t_face[1] + t_face[2]) ) then
  begin
    Result:= false;
    exit;
  end;
  for ii:=0 to 2 do
  begin
    Result:= false;
    if (face[ii] = t_face[0]) or (face[ii] = t_face[1]) or (face[ii] = t_face[2]) then
      Result:= true;
    if not Result then
      exit;
  end;
end;

begin
    Node := ClassTree.GetFirstSelected;
    Data := ClassTree.GetNodeData(Node);
    if Data = nil then
      exit;
    BspTree:= TSpBSP(Data.Obj);
    sl:= TStringList.Create;
    sl2:= TStringList.Create;
    Models:= BspTree.BSP.World.ModelGroup.models;
   { SetLength(BspTree.Leafs,0);
    SetLength(BspTree.Leafs,50000);//50k max
    index:=0;
    i:=0;
    while i <= High(Models) do
    begin
      renderBlock:= Models[i];
      j:=0;
      if (renderBlock.matrix_flag and $20000000) = 0 then  //no collision
      begin
        while j <= High(renderBlock.mesh.face) do  //without the last one
        begin
          normals:= GenNormal(j, renderBlock.mesh.face, renderBlock.mesh.Vert);
          //calculate angles
          temp_angle:=Round(Math.ArcCos(normals[0]) / 0.012271847);
          if temp_angle > 255 then
            a_x:= 255
          else
            a_x:= temp_angle;

          temp_angle:=Round(Math.ArcCos(normals[1]) / 0.012271847);
          if temp_angle > 255 then
            a_y:= 255
          else
            a_y:= temp_angle;

          temp_angle:=Round(Math.ArcCos(normals[2]) / 0.012271847);
          if temp_angle > 255 then
            a_z:= 255
          else
            a_z:= temp_angle;

          flag:= 0;
          p_test:= @flag;
          Byte(p_test^):= a_x;
          Inc(PByte(p_test), 1);
          Byte(p_test^):= a_y;
          Inc(PByte(p_test), 1);
          Byte(p_test^):= a_z;
          Inc(PByte(p_test), 1);

          face:= renderBlock.mesh.Face[j];
          point:=  renderBlock.mesh.Vert[renderBlock.mesh.Face[j][0]];
          BspTree.Leafs[index].fl_1:= -1.0 * (normals[0] * point[0] + normals[1] * point[1] + normals[2] * point[2]);
          BspTree.Leafs[index].shape:= i;
          BspTree.Leafs[index].face:= j;
          if testSameFace(j+1) then
          begin
            inc(j); //skip face
            Byte(p_test^):= Byte(p_test^) or $8;//have duplicate;
          end;
          if a_x = 0 then
            Byte(p_test^):= Byte(p_test^) or $1;
          if a_y = 0 then
            Byte(p_test^):= Byte(p_test^) or $2;
          if a_z = 0 then
            Byte(p_test^):= Byte(p_test^) or $3;

          BspTree.Leafs[index].flag:= flag;
          Inc(index);
          Inc(j);
        end;
        inc(i);
        end
        else
        Inc(i);//skip model;
    end;
    SetLength(BspTree.Leafs,index);
    BspTree.LeafNum:= index;
   }
   {
   //Test Branches
   for i:=0 to BspTree.BranchNum -1 do
   begin
    flag:=Dword(@BspTree.Branches[i].flag);
    sl.Add('Branch: ' + IntToStr(i));
    sl.Add('Planar Normals angle: x: ' +IntToStr(byte(Pointer(flag)^)) + ' y: ' + IntToStr(byte(Pointer(flag+1)^))+ ' z: ' + IntToStr(byte(Pointer(flag+2)^)) );
    branch_flag:= byte(Pointer(flag+3)^);
    if branch_flag and $40 > 0 then
      sl.Add('Object Type: Leaf')
    else if branch_flag and $20 > 0 then
      sl.Add('Object Type: Face Group')
    else
      sl.Add('Object Type: Branch');

    if branch_flag and $10 > 0 then
      sl.Add('Object Flag: Last Node');

    if branch_flag and $60 > 0 then
      sl.Add('Object Flag: Last Face');

    //sl.Add('Planar flags: ' + Format('[%.*x]', [2, byte(Pointer(flag+3)^)]));
    sl.Add('Planar offset: ' + FloatToStr(BspTree.Branches[i].offset));
    sl.Add('Object Index: ' + IntToStr(BspTree.Branches[i].index));
    sl.Add(' ');
   end;
    sl.SaveToFile('C:\Users\niewi\Desktop\BSP_Tree_Branches_original.txt');
    //sl2.SaveToFile('C:\Users\niewi\Desktop\BSP_Tree_new.txt');
    sl.Free;
    sl2.Free;

    // test num faces
   { SetLength(NumFaces,Length(Models));
    for i:=0 to BspTree.LeafNum -1 do
    begin
        Inc(NumFaces[BspTree.Leafs[i].shape]);
    end;
    for i:=0 to High(NumFaces) do
    begin
      sl.Add('Shape: ' + IntToStr(i));
      sl.Add('Num Faces: ' + IntToStr(NumFaces[i]));
      sl.Add(' ')
    end;
    sl.SaveToFile('C:\Users\niewi\Desktop\BSP_Tree_NumShapes.txt');
    sl.Free;
    sl2.Free;
    }

  {  for i:=0 to BspTree.LeafNum -1 do
    begin
      flag:=Dword(@BspTree.Leafs[i].flag);
      //if (byte(Pointer(flag+3)^) and $8) > 0 then
      begin
      face:= Models[BspTree.Leafs[i].shape].mesh.Face[BspTree.Leafs[i].face];
      normals:= GenNormal(BspTree.Leafs[i].face, Models[BspTree.Leafs[i].shape].mesh.Face , Models[BspTree.Leafs[i].shape].mesh.Vert) ;
      sl.Add('Leaf: ' + IntToStr(i));
      //sl.Add('Planar Normals angle: x: ' +IntToStr(byte(Pointer(flag)^)) + ' y: ' + IntToStr(byte(Pointer(flag+1)^))+ ' z: ' + IntToStr(byte(Pointer(flag+2)^)) );
      sl.Add('Planar flags: ' + Format('[%.*x]', [2, byte(Pointer(flag+3)^)]));

      //new generated
      sl2.Add('Leaf: ' + IntToStr(i));
      temp_angle:=Round(Math.ArcCos(normals[0]) / 0.012271847);
      if temp_angle > 255 then
        a_x:= 255
      else
        a_x:= temp_angle;

      temp_angle:=Round(Math.ArcCos(normals[1]) / 0.012271847);
      if temp_angle > 255 then
        a_y:= 255
      else
        a_y:= temp_angle;

      temp_angle:=Round(Math.ArcCos(normals[2]) / 0.012271847);
      if temp_angle > 255 then
        a_z:= 255
      else
        a_z:= temp_angle;
      //sl2.Add('Planar Normals angle: x: ' +IntToStr(a_x) + ' y: ' + IntToStr(a_y)+ ' z: ' + IntToStr(a_z) );
      flag:=0; //XYZ
      if a_x = 0 then
        flag:= flag or $1;
      if a_y = 0 then
        flag:= flag or $2;
      if a_z = 0 then
        flag:= flag or $3;
      if (BspTree.Leafs[i].face -1) >= 0 then
      begin
      if testSameFace(BspTree.Leafs[i].face -1) then
        flag:= flag or $8;
      end;
      if (BspTree.Leafs[i].face + 1) <= High(Models[BspTree.Leafs[i].shape].mesh.Face) then
      begin
      if testSameFace(BspTree.Leafs[i].face +1) then
        flag:= flag or $8;
      end;

      sl2.Add('Planar flags: ' + Format('[%.*x]', [2, flag]));

      //sl.Add('Planar offset: ' + FloatToStr(BspTree.Leafs[i].fl_1));
      sl.Add(' ');
      sl2.Add(' ');
      end;

    end;
    sl.SaveToFile('C:\Users\niewi\Desktop\BSP_Tree_original.txt');
    sl2.SaveToFile('C:\Users\niewi\Desktop\BSP_Tree_new.txt');
    sl.Free;
    sl2.Free; }

    //renderBlock:= TRenderBlock(Data.Obj);
    //renderBlock.RecalculateNormals;
 {   sl:= TStringlist.Create;
    sl2:= TStringlist.Create;
    sl.LoadFromFile('C:\Users\niewi\Desktop\vertices.txt');
    SetLength(vertices,sl.Count);
    for i:=0 to sl.Count -1 do
    begin
     sl2.DelimitedText:= sl[i];
     vertices[i][0]:= StrToFloat(sl2[0]);
     vertices[i][1]:= StrToFloat(sl2[1]);
     vertices[i][2]:= StrToFloat(sl2[2]);
    end;
    sl.Free;
    sl2.Free;    }
    //test scalar!
   // angles:= GenNormal(vertices[0],vertices[1],vertices[2]);
    //ShowMessage(FloatToStr(angles[0]) + ':' + FloatToStr(angles[1]) + ':' + FloatToStr(angles[2]));
    {
    product:= product + vertices[2][0] * vertices[0][0];
    product:= product + vertices[2][1] * vertices[0][1];
    product:= product + vertices[2][2] * vertices[0][2];
    ShowMessage(FloatToStr(product));    }
  {
    mesh:= TSpMesh(Data.Obj);
    if mesh.models_num > 0 then
    begin
      sl:= TStringlist.Create;
      begin
        for i:=0 to mesh.models_num -1 do
        begin
          renderBlock:= mesh.models[i];
          for j:=0 to renderBlock.vertex_count -1 do
          begin
            for k:=0 to 2 do
            begin
              sl.Add(FloatToStr(renderBlock.mesh.Vert[j][k]));
            end;
          end;
        end;
      end;
    end;
    sl.SaveToFile('C:\\Users\\niewi\\Desktop\\VerticesList.txt');
    sl.Free;
    }

  {  sl:= TStringlist.Create;
    temp:= ':=flag_0x0,';
    flag_value:= 1;
    for i:=1 to 32 do
    begin
      temp:= temp + format('%s%x%s', ['flag_0x',flag_value,',']);
      flag_value:= flag_value shl 1;
    end;
    sl.Add(temp);
    sl.SaveToFile('C:\\Users\\niewi\\Desktop\\RenderFlagsNames.txt');
    sl.Free;  }

   { entities:= TEntities(Data.Obj);
    sl:= TStringlist.Create;
    for i:=0 to Length(entities.Entities) -1 do
    begin
      entity:= entities.Entities[i];
      if entity.Clump <> nil then
      begin
        clump:= entity.Clump;
        if clump.has_root then
        begin
          forAllChildrens(clump.Root);
        end;
      end;
    end;
    sl.SaveToFile('C:\\Users\\niewi\\Desktop\\NullBoxTypes.txt');
    sl.Free;
  }
  { //Test Inverse Matrix
    Node := ClassTree.GetFirstSelected;
    Data := ClassTree.GetNodeData(Node);
    if Data = nil then
      exit;
    Frame := TSpFrame(Data.Obj);
    InvertedMatrix:= MatrixInvert(Frame.matrix_2.m);

    for i:=1 to 4 do
      for j:=1 to 4 do
        stream.Write(InvertedMatrix[i][j],4);
     stream.SaveToFile('C:\\Users\\niewi\\Desktop\\testMatrix');
     stream.Free;   }
//end;

procedure TFormBSP.BtnCreateTemplate1Click(Sender: TObject);
begin
  CreateTemplate;
end;

procedure TFormBSP.AddChunkClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PClassData;
  Chunk: TChunk;
  BSPFile: TBSPFile;
  i, sIndex, ChunkID, sChunkID: integer;
  SelectedItem: string;
  AnimDictionary: TAnimDictionary;
  Entities: TEntities;
  cBSP: TBSPfile;
  parent: TSpFrame;

  procedure AddFrame();
  begin
    AddChunkForm.ComprOpt.Items.Clear;
    AddChunkForm.ComprOpt.Items.Add('SpellPoint');
    AddChunkForm.ComprOpt.Items.Add('ChainPoint');
    AddChunkForm.ComprOpt.ItemIndex := 0;
    if AddChunkForm.ShowModal = mrOK then
    begin
      parent:= TSpFrame(Data.Obj);
      case AddChunkForm.ComprOpt.ItemIndex of
        0://SpellPint
        begin
          parent.AddTypedFrame(-1, 18);
        end;
        1:
        begin
          parent.AddTypedFrame(-1, 19);
        end;
      end;
    end;
  end;

  procedure AddRoot();
  begin
    AddChunkForm.ComprOpt.Items.Clear;
    BSPFile := TBSPFile(Data.Obj);
    if BSPFile.AnimLib = nil then
      AddChunkForm.ComprOpt.Items.Add('AnimLib');
    if BSPFile.Entities = nil then
      AddChunkForm.ComprOpt.Items.Add('Entities');

    AddChunkForm.ComprOpt.ItemIndex := 0;

    if AddChunkForm.ComprOpt.Items.Count > 0 then
    begin
      if AddChunkForm.ShowModal = mrOK then
      begin
        sIndex := AddChunkForm.ComprOpt.ItemIndex;
        if sIndex <> -1 then
        begin
          SelectedItem := AddChunkForm.ComprOpt.Items[sIndex];
          case ChunkID of
            C_Root:
              begin
                if SelectedItem = 'AnimLib' then
                begin
                  AnimDictionary := TAnimDictionary.Create(nil);
                  AnimDictionary.MakeDefault(BSPFile);
                  SetLength(BSPFile.Chunks, Length(BSPFile.Chunks) + 1);
                  BSPFile.AddChunk(AnimDictionary);
                end
                else if SelectedItem = 'Entities' then
                begin
                  Entities := TEntities.Create(nil);
                  Entities.MakeDefault(BSPFile);
                  SetLength(BSPFile.Chunks, Length(BSPFile.Chunks) + 1);
                  BSPFile.AddChunk(Entities);
                end;
              end;
          end;
          UpdateBSPTree(true, true);
        end;
      end;
    end;
  end;

  procedure AddEntities();
  var
    nBSP: TBSP;
    nBSPFile: TBSPfile;
    i, len: integer;
    nEntities: AEntities;
    nEntity: TEntity;
    nClump: TClump;
    nRoot: TSpFrame;
  begin
    if OpenDialog.Execute then
    begin
      nBSP := TBSP.Create;
      nBSP.LoadBSPFileName(OpenDialog.FileName);
      nBSPFile := nBSP.BSPfile;
      nEntities := nBSPFile.Entities.Entities;
      if length(nEntities) > 0 then //if there are any entities
      begin
        for i := 0 to High(nEntities) do
        begin
          if nEntities[i].Clump <> nil then
          begin
            nClump := nEntities[i].Clump;
            if nClump.Root <> nil then
            begin
              nRoot := nClump.Root;
              AddEntitiesForm.cbb1.Items.Add(nRoot.name);
            end;
          end;
        end;
        if AddEntitiesForm.cbb1.Items.Count > 0 then
        begin
          AddEntitiesForm.Caption := 'Add Entities';
          AddEntitiesForm.SelectChunkOpt.Caption := 'Select Entities';
          AddEntitiesForm.Label1.Caption := 'Entities:';
          if AddEntitiesForm.ShowModal = mrOk then
          begin
            for i := 0 to AddEntitiesForm.cbb1.Items.Count - 1 do
            begin
              if AddEntitiesForm.cbb1.Checked[i] then
              begin
                nEntity := TEntity(nEntities[i].CopyChunk(cBSP));
                len := Length(cBSP.Entities.Entities);
                SetLength(cBSP.Entities.Entities, len + 1);
                Inc(cBSP.Entities.Num);
                cBSP.Entities.Entities[len] := nEntity;
              end;
            end;
            UpdateBSPTree(true, true);
          end;
        end;
      end;
      AddEntitiesForm.cbb1.Clear;
      nBSP.Free;
    end;
  end;

  procedure AddNullNodes();
  var
    nBSP: TBSP;
    nBSPFile: TBSPfile;
    i,j: integer;
    nworld: TWorld;
    oNullNodes,nNullNodes: TNullNodes;
    nullNodeName: String;
    nSpNullNode:TSpNullNode;
    found:boolean;

    procedure AddNullNode(nullNodes: TNullNodes; nullnode: TSpNullNode);
    var
      lIndex:integer;
    begin
     lIndex:= Length(nullNodes.WpPoints);
     SetLength(nullNodes.WpPoints,lIndex +1);
     nullNodes.WpPoints[lIndex]:= nullnode;
     inc(nullNodes.Num);
    end;

  begin
    if OpenDialog.Execute then
    begin
      nBSP := TBSP.Create;
      nBSP.LoadBSPFileName(OpenDialog.FileName);
      nBSPFile := nBSP.BSPfile;
      begin
        if nBSPFile.World <> nil then
        begin
          nworld:= nBSPFile.World;
          if (nworld.hasNullNodes) and (nworld.NullNodes <> nil) then
          begin
            nNullNodes:= nworld.NullNodes;
            for i:=0 to nNullNodes.Num -1 do
            begin
              AddEntitiesForm.cbb1.Items.Add(nNullNodes.WpPoints[i].name);
            end;
            if AddEntitiesForm.cbb1.Items.Count > 0 then
            begin
              AddEntitiesForm.Caption:= 'Add NullNodes';
              AddEntitiesForm.SelectChunkOpt.Caption:= 'Select NullNodes';
              AddEntitiesForm.Label1.Caption:= 'Nullnodes:';
              if AddEntitiesForm.ShowModal = mrOk then
              begin
                oNullNodes:= TNullNodes(Chunk);
                for i := 0 to AddEntitiesForm.cbb1.Items.Count - 1 do
                begin
                  if AddEntitiesForm.cbb1.Checked[i] then
                  begin
                    found:= false;
                    for j:= 0 to oNullNodes.Num -1 do
                    begin
                      if AddEntitiesForm.cbb1.Items[i] = oNullNodes.WpPoints[j].name then
                      begin
                        if MessageDlg('Duplicate of Nullnode: "' + oNullNodes.WpPoints[j].name + '" was found. Do you want to rename Nullnode?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                        begin
                          nullNodeName:= InputBox('Select NullNode name', 'Nullnode:', '');
                          if nullNodeName <> '' then
                          begin
                            nSpNullNode:= TSpNullNode(nNullNodes.WpPoints[i].CopyChunk(nBSPFile));
                            nSpNullNode.name:= StrNew(PChar(nullNodeName));
                            nSpNullNode.hash := nBSPFile.MakeHash(nSpNullNode.name, Length(nSpNullNode.name));
                            AddNullNode(oNullNodes, nSpNullNode);
                          end;
                        end
                        else
                        begin
                          if MessageDlg('Do you want to replace it?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                          begin
                            oNullNodes.WpPoints[j]:= TSpNullNode(nNullNodes.WpPoints[i].CopyChunk(nBSPFile));
                          end;
                        end;
                        found:= true;
                        Break;
                      end;
                    end;
                    if not found then
                      AddNullNode(oNullNodes, TSpNullNode(nNullNodes.WpPoints[i].CopyChunk(nBSPFile)));
                  end;
                end;
                oNullNodes.SorTNullNodes;
                UpdateBSPTree(true, true);
              end;
            end;
          end;
        end;
      AddEntitiesForm.cbb1.Clear;
      nBSP.Free;
    end;
  end;
  end;

begin
  Node := ClassTree.GetFirstSelected;
  Data := ClassTree.GetNodeData(Node);
  if Data = nil then
    exit;
  Chunk := TChunk(Data.Obj);
  ChunkID := Chunk.IDType;
  cBSP := Chunk.BSP;
  case ChunkID of
    C_Root: AddRoot();
    C_Entities: AddEntities();
    C_NullNodes: AddNullNodes();
    C_Frame: AddFrame();
  end;
end;

procedure TFormBSP.BtnDebug1Click(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PClassData;
  world: TWorld;
  sl: TStringList;
  i: integer;
  //global variables
  throttle_threshold: integer;
  nBSP: TSpBSP;
function SpIndicesDegenerate(var mb: TRenderBlock; index: Integer): Boolean;
var
  faces: AFace;
  face: array[0..2] of Word;
begin
  faces:= mb.mesh.Face;
  face[0]:=faces[index][0];
  face[1]:=faces[index][1];
  face[2]:=faces[index][2];
  Result:= (face[0] = face[1]) or (face[0] = face[2]) or (face[1] = face[2]);
end;

function GetNonDegenerateFaceCount(var mesh: TSpMesh): integer;
var
  i,j: integer;
  mb: TRenderBlock;
begin
  Result:= 0;
  for i:=0 to mesh.models_num -1 do
  begin
    mb:= mesh.models[i];
    for j:=0 to mb.indices_count -1 do
    begin
      if not(SpIndicesDegenerate(mb,j)) then
        Result:= Result + 1;
    end;
  end;
end;

function SpV3dHash(var vec: TVect4): Integer;
var
  v1,v2,v3: integer;
begin
  CopyMemory(@v1, @vec[1],4);
  CopyMemory(@v2, @vec[2],4);
  CopyMemory(@v3, @vec[3],4);
  Result:= v3 xor v2 xor v1;
end;

function face_hash_cmp(Item1, Item2: Pointer): Integer;
begin
  Result := CompareValue(Int64(SpBSPFaceHash(Item1^).hash),
    Int64(SpBSPFaceHash(Item2^).hash));
end;

procedure SortHashes(var fh: ASpBSPFaceHash);
var
  sortList: TList;
  i,len: integer;
  nFace_hashes: ASpBSPFaceHash;
begin
    sortList := TList.Create;
    len := Length(fh);
    for i:= 0 to len - 1 do
    begin
      SortList.Add(@fh[i]);
    end;
    SortList.Sort(@face_hash_cmp);
    SetLength(nFace_hashes, len);
    for i := 0 to len - 1 do
    begin
      nFace_hashes[i] := SpBSPFaceHash(SortList[i]^);
    end;
    fh:= nFace_hashes;
end;

procedure GetPolyVertices(var mat_block: TRenderBlock;facei: integer; var pv: AVer);
var
  face: TFace;
begin
  face:= mat_block.mesh.Face[facei];
  pv[0]:= mat_block.mesh.Vert[face[0]];
  pv[1]:= mat_block.mesh.Vert[face[1]];
  pv[2]:= mat_block.mesh.Vert[face[2]];
end;

function EqualPos(value1,value2:single):Boolean;
begin
  result:= Abs(value1 - value2) < 0.000001;
end;

function SpTrisDuplicate(var pv1: AVer; var pv2: Aver) : Boolean;
var
  i,j,dups: integer;
begin
  dups:= 0;
  for i:=0 to 2 do
  begin
    for j:=0 to 2 do
    begin
      if EqualPos(pv1[i][0],pv2[j][0]) and EqualPos(pv1[i][1],pv2[j][1]) and EqualPos(pv1[i][2],pv2[j][2]) then
      begin
        Inc(dups);
        Break;
      end;
    end;
  end;
  Result:= (dups = 3);
end;

procedure DeleteDoubleSided(var mesh: TSpMesh);
var
  face_hashes: ASpBSPFaceHash;
  i,face_index,hash1,hash2,hash3,nnum_faces: integer;
  mat_block,mb,mb_prev: TRenderBlock;
  v1,v2,v3: TVect4;
  face: TFace;
  pv1,pv2:AVer;
begin
  SetLength(face_hashes,nBSP.num_faces);
  for i:=0 to nBSP.num_faces -1 do //for all faces
  begin
    nBSP.faces[i].v_end:= 0;
    face_index:= nBSP.faces[i].face;
    mat_block:=mesh.models[nBSP.faces[i].shape];
    face:= mat_block.mesh.Face[face_index];
    //copy 3 vertex positions
    CopyMemory(@v1,@mat_block.mesh.Vert[face[0]],12);
    CopyMemory(@v2,@mat_block.mesh.Vert[face[1]],12);
    CopyMemory(@v3,@mat_block.mesh.Vert[face[2]],12);
    // make face hashes!
    hash1:= SpV3dHash(v1);
    hash2:= SpV3dHash(v2) xor hash1;
    hash3:= SpV3dHash(v3);
    face_hashes[i].hash:= hash3 xor hash2;
    face_hashes[i].face_index:= i;
  end;
  //Sort hashes
  SortHashes(face_hashes);
  SetLength(pv1,3);
  SetLength(pv2,3);
  for i:=1 to nBSP.num_faces -1 do //for all faces except first
  begin
    if face_hashes[i].hash = face_hashes[i-1].hash then //if duplicate
    begin
      mb:= mesh.models[nBSP.faces[face_hashes[i].face_index].shape];//SpMesh::GetMatBlock(_this->Mesh, _this->face[fh[i].face_index].shape);
      mb_prev:= mesh.models[nBSP.faces[face_hashes[i-1].face_index].shape];
      if ( (mb.matrix_flag and $400) = (mb_prev.matrix_flag and $400) ) then   //( (mb->matrix_flag & 0x400) == (mb_prev->matrix_flag & 0x400) )
      begin
        GetPolyVertices(mb,nBSP.faces[face_hashes[i].face_index].face,pv1);
        GetPolyVertices(mb_prev,nBSP.faces[face_hashes[i-1].face_index].face,pv2);
        if SpTrisDuplicate(pv1,pv2) then
        begin
          nBSP.faces[face_hashes[i-1].face_index].v_end:= 2;
          nBSP.faces[face_hashes[i].face_index].v_end:= 1;
        end;
      end;
    end;
  end;
  SetLength(face_hashes,0);//clear fh
  nnum_faces:= 0;
  for i:=0 to nBSP.num_faces -1 do
  begin
    if nBSP.faces[i].v_end <> 2 then
    begin
      nBSP.faces[nnum_faces]:= nBSP.faces[i];
      Inc(nnum_faces);
    end;
  end;
  nBSP.num_faces:= nnum_faces;
  SetLength(nBSP.faces,nnum_faces);
end;

procedure PrepareForPartitioning(world: TWorld);
var
  i,j,pos: integer;
  MatBlock: TRenderBlock;
  //debug
  sl: TStringList;
begin
  //New bsp file
  pos:= 0;
  nBSP:=TSpBSP.Create(nil);
  nBSP.num_faces:= GetNonDegenerateFaceCount(world.ModelGroup);
  if nBSP.num_faces > 0 then
  begin
    SetLength(nBSP.faces, nBSP.num_faces); // faces=(SpBSPLeaf*)SpMalloc(numf*sizeof(SpBSPLeaf))
    for i:=0 to world.ModelGroup.models_num - 1 do  // for all meshes
    begin
      MatBlock:= world.ModelGroup.models[i];
      if (MatBlock <> nil) and ( (MatBlock.matrix_flag and $20000000) = 0) then  //if model exist and NoCollision Flag is not set
      begin
        for j:=0 to MatBlock.indices_count -1 do //for all faces
        begin
          if not(SpIndicesDegenerate(MatBlock, j)) then
          begin
            nBSP.faces[pos].shape:= i;
            nBSP.faces[pos].face:= j;
            Inc(pos);
          end;
        end;
      end;
    end;
    nBSP.num_faces:= pos; //new size
    SetLength(nBSP.faces, nBSP.num_faces);
    DeleteDoubleSided(world.ModelGroup);
  end;

  //debug///
  //print new faces
  sl:= TStringList.Create;
  for i:=0 to nBSP.num_faces -1 do
  begin
    sl.Add('Leaf: ' + IntToStr(i) + ' shape: ' + IntToStr(nBSP.faces[i].shape) + ' face: ' + IntToStr(nBSP.faces[i].face));
  end;
  sl.SaveToFile('C:\Users\niewi\Desktop\newBSP.txt');
  sl.Clear;
  //print original leafs
    for i:=0 to world.ModelGroup.Collision.num_faces -1 do
    begin
      sl.Add('Leaf: ' + IntToStr(i) + ' shape: ' + IntToStr(world.ModelGroup.Collision.faces[i].shape) + ' face: ' + IntToStr(world.ModelGroup.Collision.faces[i].face));
    end;
    sl.SaveToFile('C:\Users\niewi\Desktop\oldBSP.txt');
    sl.Free;
    
  nBSP.Free; //free new object
end;

procedure Partition(world: TWorld; isOctree: Boolean);
begin
  if isOctree then
    throttle_threshold:= 200
  else
    throttle_threshold:= 2000;

  PrepareForPartitioning(world);




end;

begin
  Node := ClassTree.GetFirstSelected;
  Data := ClassTree.GetNodeData(Node);
  if Data = nil then
    exit;
  world := TWorld(Data.Obj);
  Partition(world,false);
end;

procedure TFormBSP.BtnChangeGlogalSpeed1Click(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PClassData;
  dictAnim: TDictAnim;
  newAnimSpeed: double;
  i, j: integer;
begin
  Node := ClassTree.GetFirstSelected;
  Data := ClassTree.GetNodeData(Node);
  if Data = nil then
    exit;

  if AnimSpeedForm.ShowModal = mrOK then
  begin
    newAnimSpeed := AnimSpeedForm.edt1.Value;
    dictAnim := TDictAnim(Data.Obj);
    for i := 0 to dictAnim.keys_num - 1 do
    begin
      //dictAnim.Keys[i].acceleration:= newAnimSpeed;
      for j := 0 to dictAnim.Keys[i].key_num - 1 do
      begin
        dictAnim.Keys[i].time_keys[j] := dictAnim.Keys[i].time_keys[j] /
          newAnimSpeed;
      end;
    end;
    dictAnim.minTime := dictAnim.minTime / newAnimSpeed;
    dictAnim.maxTime := dictAnim.maxTime / newAnimSpeed;
  end;
end;

end.

