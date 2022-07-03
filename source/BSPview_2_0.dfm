object FormBSP: TFormBSP
  Left = 645
  Top = 198
  Width = 980
  Height = 728
  Color = clBtnFace
  Constraints.MinHeight = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelView: TPanel
    Left = 0
    Top = 0
    Width = 964
    Height = 650
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter4: TSplitter
      Left = 516
      Top = 0
      Height = 650
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 516
      Height = 650
      Align = alLeft
      Constraints.MinWidth = 200
      ParentColor = True
      TabOrder = 0
      object Panel14: TPanel
        Left = 1
        Top = 25
        Width = 514
        Height = 624
        Align = alClient
        TabOrder = 0
        object Panel24: TPanel
          Left = 1
          Top = 1
          Width = 512
          Height = 622
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object Splitter5: TSplitter
            Left = 1
            Top = 267
            Width = 510
            Height = 2
            Cursor = crVSplit
            Align = alBottom
          end
          object ClassTree: TVirtualStringTree
            Left = 1
            Top = 31
            Width = 510
            Height = 236
            Align = alClient
            Constraints.MinWidth = 200
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'Tahoma'
            Header.Font.Style = []
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Images = TreeImages
            Indent = 19
            ParentFont = False
            PopupMenu = PopupMenu1
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseExplorerTheme]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnBeforeItemErase = DataTreeBeforeItemErase
            OnChange = ClassTreeChange
            OnChecked = ClassTreeChecked
            OnContextPopup = ClassTreeContextPopup
            OnDblClick = ClassTreeDblClick
            OnFreeNode = ClassTreeFreeNode
            OnGetText = ClassTreeGetText
            OnPaintText = ClassTreePaintText
            OnGetImageIndex = ClassTreeGetImageIndex
            Columns = <
              item
                Position = 0
                Width = 400
                WideText = 'Name'
              end
              item
                Position = 1
                Width = 75
                WideText = 'Type'
              end
              item
                Position = 2
                Width = 10
                WideText = 'Hash'
              end
              item
                Position = 3
                Width = 10
                WideText = 'ID'
              end
              item
                Position = 4
                Width = 10
                WideText = 'Version'
              end>
          end
          object Panel25: TPanel
            Left = 1
            Top = 1
            Width = 510
            Height = 30
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            DesignSize = (
              510
              30)
            object Label17: TLabel
              Left = 6
              Top = 8
              Width = 37
              Height = 13
              Caption = 'Search:'
            end
            object Search: TEdit
              Left = 46
              Top = 5
              Width = 376
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnKeyPress = SearchKeyPress
            end
            object FindText: TButton
              Left = 430
              Top = 5
              Width = 75
              Height = 20
              Anchors = [akTop, akRight]
              Caption = 'Find'
              TabOrder = 1
              OnClick = FindTextClick
            end
          end
          object DataTree: TVirtualStringTree
            Left = 1
            Top = 269
            Width = 510
            Height = 352
            Align = alBottom
            ButtonStyle = bsTriangle
            Colors.DropMarkColor = 14647357
            Colors.DropTargetColor = 14647357
            Colors.DropTargetBorderColor = 14647357
            Colors.FocusedSelectionColor = 14647357
            Colors.FocusedSelectionBorderColor = 14647357
            Colors.SelectionRectangleBlendColor = 14647357
            Colors.SelectionRectangleBorderColor = 14647357
            DefaultNodeHeight = 16
            Header.AutoSizeIndex = -1
            Header.DefaultHeight = 20
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'Tahoma'
            Header.Font.Style = []
            Header.Height = 20
            Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
            Images = TreeImages
            Margin = 2
            TabOrder = 2
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnDblClick]
            TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages, toUseExplorerTheme]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnAfterCellPaint = DataTreeAfterCellPaint
            OnBeforeItemErase = DataTreeBeforeItemErase
            OnCreateEditor = DataTreeCreateEditor
            OnEdited = DataTreeEdited
            OnFreeNode = DataTreeFreeNode
            OnGetText = DataTreeGetText
            OnPaintText = DataTreePaintText
            OnGetImageIndex = DataTreeGetImageIndex
            OnNodeDblClick = DataTreeNodeDblClick
            OnScroll = DataTreeScroll
            Columns = <
              item
                Position = 0
                Width = 200
                WideText = 'Name'
              end
              item
                Position = 1
                Width = 205
                WideText = 'Value'
              end
              item
                Position = 2
                Width = 100
                WideText = 'Type'
              end>
          end
        end
      end
      object Panel12: TPanel
        Left = 1
        Top = 1
        Width = 514
        Height = 24
        Align = alTop
        BevelOuter = bvLowered
        Constraints.MinWidth = 360
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        DesignSize = (
          514
          24)
        object TreeProgress: TProgressBar
          Left = 8
          Top = 7
          Width = 495
          Height = 10
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
      end
    end
    object PageControl1: TPageControl
      Left = 519
      Top = 0
      Width = 445
      Height = 650
      ActivePage = TabSheet1
      Align = alClient
      Constraints.MinWidth = 445
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = '3D View'
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 437
          Height = 622
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel3'
          Constraints.MinWidth = 370
          TabOrder = 0
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 437
            Height = 622
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel6'
            TabOrder = 0
            object OpenGLBox: TOpenGLBox
              Left = 0
              Top = 0
              Width = 412
              Height = 587
              Align = alClient
              Caption = 'OpenGLBox'
              Color = clBlack
              TabOrder = 0
              OnClick = OpenGLBoxClick
              OnMouseDown = OpenGLBoxMouseDown
              OnMouseMove = OpenGLBoxMouseMove
              OnMouseUp = OpenGLBoxMouseUp
              OnResize = OpenGLBoxResize
              OnOpenGL = False
              OnPaint = OpenGLBoxPaint
              OnMouseWheelDown = OpenGLBoxMouseWheelDown
              OnMouseWheelUp = OpenGLBoxMouseWheelUp
              OnKeyDown = OpenGLBoxKeyDown
              OnKeyUp = OpenGLBoxKeyUp
            end
            object Panel7: TPanel
              Left = 0
              Top = 587
              Width = 437
              Height = 35
              Align = alBottom
              BevelInner = bvLowered
              BevelOuter = bvLowered
              TabOrder = 1
              Visible = False
              object LabelTime: TLabel
                Left = 180
                Top = 9
                Width = 71
                Height = 20
                Caption = '0.00 sec'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object AnimButton: TSpeedButton
                Left = 254
                Top = 6
                Width = 28
                Height = 25
                Hint = 'Animation'
                HelpType = htKeyword
                AllowAllUp = True
                GroupIndex = 2
                Glyph.Data = {
                  360C0000424D360C000000000000360000002800000040000000100000000100
                  180000000000000C00003A0B00003A0B0000000000000000000000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000000000000000000000000000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000000000000000000000000000000000000000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000000000000000000000000000000000000000000000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000000000000000000000000000000000000000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000000000000000000000000000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000000000000000000000000000000000FF0000FF0000
                  000000000000000000000000000000FF0000FF0000FF0000FF00000000000000
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
                  00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
                  0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                  FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00}
                NumGlyphs = 4
                ParentShowHint = False
                ShowHint = True
              end
              object ExportAnim: TButton
                Tag = 2
                Left = 289
                Top = 6
                Width = 73
                Height = 25
                Caption = 'Export Anim'
                Enabled = False
                TabOrder = 0
                OnClick = ExportDaeClick
              end
              object AnimBox: TComboBox
                Left = 8
                Top = 8
                Width = 167
                Height = 21
                Style = csDropDownList
                ItemHeight = 13
                TabOrder = 1
                OnChange = AnimBoxChange
              end
              object ImportAnim: TButton
                Left = 365
                Top = 6
                Width = 73
                Height = 25
                Caption = 'Import Anim'
                Enabled = False
                TabOrder = 2
                OnClick = ImportAnimClick
              end
            end
            object Panel13: TPanel
              Left = 412
              Top = 0
              Width = 25
              Height = 587
              Align = alRight
              BevelOuter = bvNone
              FullRepaint = False
              TabOrder = 2
              object ToolBar1: TToolBar
                Left = 0
                Top = 0
                Width = 25
                Height = 388
                AutoSize = True
                ButtonHeight = 24
                ButtonWidth = 25
                Caption = 'ToolBar1'
                EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
                EdgeInner = esLowered
                EdgeOuter = esRaised
                Flat = True
                Images = ImageList1
                TabOrder = 0
                Transparent = True
                object ZoomBut: TToolButton
                  Left = 0
                  Top = 0
                  Hint = 'Zoom'
                  AutoSize = True
                  Caption = 'ZoomBut'
                  ImageIndex = 0
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                  OnMouseMove = ToolButtonSMouseMove
                end
                object PanBut: TToolButton
                  Left = 0
                  Top = 24
                  Hint = 'Pan'
                  AutoSize = True
                  Caption = 'PanBut'
                  ImageIndex = 2
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                  OnMouseMove = ToolButtonSMouseMove
                end
                object RotBut: TToolButton
                  Left = 0
                  Top = 48
                  Hint = 'Rotate'
                  AutoSize = True
                  Caption = 'RotBut'
                  ImageIndex = 3
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                  OnMouseMove = ToolButtonSMouseMove
                end
                object PerspBut: TToolButton
                  Left = 0
                  Top = 72
                  Hint = 'Perspective'
                  AutoSize = True
                  Caption = 'PerspBut'
                  ImageIndex = 4
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                  OnMouseMove = ToolButtonSMouseMove
                end
                object DollyBut: TToolButton
                  Left = 0
                  Top = 96
                  Hint = 'Dolly'
                  AutoSize = True
                  Caption = 'DollyBut'
                  ImageIndex = 5
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                  OnMouseMove = ToolButtonSMouseMove
                end
                object CentrBut: TToolButton
                  Left = 0
                  Top = 120
                  Hint = 'Zoom Selected'
                  AutoSize = True
                  Caption = 'CentrBut'
                  ImageIndex = 1
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = CentrButClick
                end
                object SelBut: TToolButton
                  Left = 0
                  Top = 144
                  Hint = 'Select'
                  AutoSize = True
                  Caption = 'SelBut'
                  ImageIndex = 16
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = SelButClick
                end
                object MoveBut: TToolButton
                  Left = 0
                  Top = 168
                  Hint = 'Move'
                  AutoSize = True
                  Caption = 'MoveBut'
                  Enabled = False
                  ImageIndex = 8
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                end
                object RotatBut: TToolButton
                  Left = 0
                  Top = 192
                  Hint = 'Rotate'
                  AutoSize = True
                  Caption = 'RotatBut'
                  Enabled = False
                  ImageIndex = 9
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                end
                object ScaleBut: TToolButton
                  Left = 0
                  Top = 216
                  Hint = 'Scale'
                  AutoSize = True
                  Caption = 'ScaleBut'
                  Enabled = False
                  ImageIndex = 10
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButClick
                end
                object ToolButton13: TToolButton
                  Left = 0
                  Top = 240
                  Hint = 'Restrict to X'
                  AutoSize = True
                  Caption = 'ToolButton13'
                  ImageIndex = 11
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButton13Click
                end
                object ToolButton14: TToolButton
                  Left = 0
                  Top = 264
                  Hint = 'Restrict to Y'
                  AutoSize = True
                  Caption = 'ToolButton14'
                  ImageIndex = 12
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButton13Click
                end
                object ToolButton15: TToolButton
                  Left = 0
                  Top = 288
                  Hint = 'Restrict to Z'
                  AutoSize = True
                  Caption = 'ToolButton15'
                  ImageIndex = 13
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButton13Click
                end
                object ToolButton16: TToolButton
                  Left = 0
                  Top = 312
                  Hint = 'Restrict to XY'
                  AutoSize = True
                  Caption = 'ToolButton16'
                  ImageIndex = 14
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButton13Click
                end
                object ToolButton17: TToolButton
                  Left = 0
                  Top = 336
                  Hint = 'Restrict to YZ'
                  AutoSize = True
                  Caption = 'ToolButton17'
                  ImageIndex = 15
                  ParentShowHint = False
                  Wrap = True
                  ShowHint = True
                  OnClick = ToolButton13Click
                end
                object ToolButton18: TToolButton
                  Left = 0
                  Top = 360
                  Hint = 'Restrict to ZX'
                  AutoSize = True
                  Caption = 'ToolButton18'
                  ImageIndex = 7
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = ToolButton13Click
                end
              end
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Image View'
        ImageIndex = 1
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 502
          Height = 622
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel8'
          FullRepaint = False
          TabOrder = 0
          object ScrollBox1: TScrollBox
            Left = 0
            Top = 112
            Width = 502
            Height = 510
            Align = alClient
            Constraints.MinHeight = 18
            Color = clMedGray
            ParentColor = False
            TabOrder = 0
            OnResize = ScrollBox1Resize
            object ImageT32: TImage
              Left = 0
              Top = 0
              Width = 128
              Height = 128
              AutoSize = True
            end
          end
          object Panel21: TPanel
            Left = 0
            Top = 0
            Width = 502
            Height = 112
            Align = alTop
            BevelInner = bvLowered
            BevelOuter = bvLowered
            TabOrder = 1
            object Label16: TLabel
              Left = 8
              Top = 8
              Width = 53
              Height = 13
              Caption = 'Image Info:'
            end
            object limgWidth: TLabel
              Left = 8
              Top = 40
              Width = 65
              Height = 13
              Caption = 'Resolution:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LabImgWidth: TLabel
              Left = 75
              Top = 40
              Width = 3
              Height = 13
            end
            object LabImgName: TLabel
              Left = 75
              Top = 24
              Width = 3
              Height = 13
            end
            object Label22: TLabel
              Left = 8
              Top = 24
              Width = 37
              Height = 13
              Caption = 'Name:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label23: TLabel
              Left = 199
              Top = 40
              Width = 80
              Height = 13
              Caption = 'Bits Per Pixel:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LabImgBits: TLabel
              Left = 280
              Top = 40
              Width = 3
              Height = 13
            end
            object Label25: TLabel
              Left = 8
              Top = 56
              Width = 34
              Height = 13
              Caption = 'Hash:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LabImgHash: TLabel
              Left = 75
              Top = 56
              Width = 3
              Height = 13
            end
            object Label27: TLabel
              Left = 8
              Top = 72
              Width = 43
              Height = 13
              Caption = 'Format:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label28: TLabel
              Left = 199
              Top = 56
              Width = 53
              Height = 13
              Caption = 'Min Mag:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label30: TLabel
              Left = 199
              Top = 88
              Width = 45
              Height = 13
              Caption = 'Palette:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LabImgPalette: TLabel
              Left = 280
              Top = 88
              Width = 3
              Height = 13
            end
            object LabImgCompr: TLabel
              Left = 280
              Top = 72
              Width = 3
              Height = 13
            end
            object LabImgMigMag: TLabel
              Left = 280
              Top = 56
              Width = 3
              Height = 13
            end
            object LabImgFormat: TLabel
              Left = 75
              Top = 72
              Width = 3
              Height = 13
            end
            object Label19: TLabel
              Left = 199
              Top = 72
              Width = 35
              Height = 13
              Caption = 'Wrap:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label18: TLabel
              Left = 8
              Top = 88
              Width = 29
              Height = 13
              Caption = 'Size:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LabImgSize: TLabel
              Left = 75
              Top = 88
              Width = 3
              Height = 13
            end
          end
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 650
    Width = 964
    Height = 19
    Panels = <
      item
        Width = 400
      end
      item
        Text = 'Info'
        Width = 50
      end>
  end
  object OpenDialog: TOpenDialog
    Filter = 'Ghost Master resource (.bsp)|*.bsp'
    Left = 96
    Top = 120
  end
  object SaveDialog2: TSaveDialog
    Filter = 'PNG image|*.png'
    Left = 654
    Top = 56
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 705
    Top = 79
  end
  object SaveDialogDAE: TSaveDialog
    Filter = 'Collada 3D Model (*.dae)|*.dae'
    Left = 358
    Top = 103
  end
  object OpenDialog2: TOpenDialog
    Filter = 'PNG image|*.png'
    Left = 622
    Top = 51
  end
  object SaveDialog3: TSaveDialog
    Filter = 'BSP file|*.bsp'
    Left = 68
    Top = 119
  end
  object OpenDialogDAE: TOpenDialog
    Filter = 'Collada 3D Model (*.dae)|*.dae'
    Left = 325
    Top = 101
  end
  object PopupMenu1: TPopupMenu
    Left = 293
    Top = 114
    object Expand1: TMenuItem
      Caption = 'Expand'
      OnClick = Expand1Click
    end
    object Collupse1: TMenuItem
      Caption = 'Collupse'
      OnClick = Collupse1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object AddChunk: TMenuItem
      Caption = 'Add Root Chunks'
      OnClick = AddChunkClick
    end
    object MergeChunk: TMenuItem
      Caption = 'Merge'
      OnClick = MergeChunkClick
    end
    object CopyChunk: TMenuItem
      Caption = 'Copy'
      Enabled = False
      OnClick = CopyChunkClick
    end
    object DeleteChunk: TMenuItem
      Caption = 'Delete'
      Enabled = False
      OnClick = DeleteChunkClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object ExportDae: TMenuItem
      Caption = 'Export Model'
      Enabled = False
      OnClick = ExportDaeClick
    end
    object ImportModeldae: TMenuItem
      Caption = 'Import Model'
      Enabled = False
      OnClick = ImportModeldaeClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ExportImage: TMenuItem
      Caption = 'Export Image'
      Enabled = False
      OnClick = ExportImageClick
    end
    object ImportImage: TMenuItem
      Caption = 'Import Image'
      Enabled = False
      OnClick = ImportImageClick
    end
    object BtnN7: TMenuItem
      Caption = '-'
    end
    object BtnDebug1: TMenuItem
      Caption = 'Debug'
      Enabled = False
      Visible = False
      OnClick = BtnDebug1Click
    end
    object BtnChangeGlogalSpeed1: TMenuItem
      Caption = 'Change Anim Speed'
      OnClick = BtnChangeGlogalSpeed1Click
    end
  end
  object TreeImages: TImageList
    Left = 943
    Top = 105
    Bitmap = {
      494C01011F002200040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000989898008F8F8F0077777700919191000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000999999008C8C8C0097979700ECECEC00464646008C8C8C009090
      9000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000438F4300008000000080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F8F8F0093939300DFDFDF00ECECEC00ECECEC0043434300D6D6D6008F8F
      8F00949494000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E0063363E0063363E0063363E0063363E0063363E0063363E006336
      3E00000000000000000000000000000000000000000000000000000000000000
      0000000000000080000000800000008000000080000000800000000000000000
      00000000000000000000000000000000000000000000000000008F8F8F008F8F
      8F00B0B0B000ECECEC00E5E5E500DFDFDF00ECECEC0049494900AFAFAF00ECEC
      EC00909090009898980000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E00FAEBEB00FAEBEB00FAEBEB00FAEBEB00FAEBEB00FAEBEB006336
      3E00000000000000000000000000000000000000000000000000000000000000
      000000800000008000000080000074A37400008000000080000000800000438F
      430000000000000000000000000000000000000000000000000090909000B2B2
      B2009F9F9F00DADADA00ECECEC00E5E5E500ECECEC0052525200A9A9A900D3D3
      D300999999007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E00F4E6E600F4E6E600F4E6E600F4E6E600F4E6E600F4E6E6006336
      3E00000000000000000000000000000000000000000000000000438F43000080
      0000008000000080000000000000000000000000000000800000008000000080
      00000080000000000000000000000000000000000000A8A8A80097979700ECEC
      EC00C6C6C60090909000B9B9B900ECECEC00ECECEC004A4A4A004A4A4A006868
      6800A3A3A3009797970097979700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E00EEDFDF00EEDFDF00EEDFDF00EEDFDF00EEDFDF00EEDFDF006336
      3E00000000000000000000000000000000000000000000800000008000000080
      0000008000000000000000000000000000000000000000000000008000000080
      000000800000008000000000000000000000000000009C9C9C00B5B5B500ECEC
      EC00ECECEC00ECECEC00B5B5B50093939300909090003F3F3F0080808000ECEC
      EC00ECECEC00CACACA008F8F8F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E00E3D5D500E3D5D500E3D5D500E3D5D500E3D5D500E3D5D5006336
      3E00000000000000000000000000000000000000000000800000008000000080
      000000000000000000000000000000000000000000000000000000000000438F
      4300008000000080000000800000000000000000000093939300D1D1D100ECEC
      EC00ECECEC00ECECEC00ECECEC0097979700ECECEC008080800079797900ECEC
      EC00DDDDDD00DFDFDF0089898900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E00DED0D000DED0D000DED0D000DED0D000DED0D000DED0D0006336
      3E00000000000000000000000000000000000000000000000000008000000080
      0000008000000000000000000000000000000000000000000000000000000080
      000000800000008000000080000000000000000000008C8C8C00ECECEC00ECEC
      EC00ECECEC00ECECEC00ECECEC00A3A3A300ECECEC005C5C5C0063636300ECEC
      EC00ECECEC00ECECEC0089898900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E00C4B4B500C4B4B500C4B4B500C4B4B500C4B4B500C4B4B5006336
      3E00000000000000000000000000000000000000000000000000000000000080
      0000008000000080000074A37400000000000000000000000000008000000080
      00000080000074A374000000000000000000000000008C8C8C00ECECEC00ECEC
      EC00E9E9E900BEBEBE00999999006A6A6A006A6A6A0093939300787878007070
      7000DADADA00ECECEC008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063363E0063363E0063363E0063363E0063363E0063363E0063363E006336
      3E00000000000000000000000000000000000000000000000000000000000000
      0000008000000080000000800000008000000080000000800000008000000080
      0000000000000000000000000000000000000000000087878700B5B5B5008F8F
      8F008888880097979700CACACA00AFAFAF00ECECEC00ECECEC00ECECEC00B9B9
      B90078787800B2B2B20094949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000438F430000800000008000000080000000800000008000000000
      0000000000000000000000000000000000000000000083838300838383009191
      9100ECECEC00ECECEC00ECECEC00ADADAD00ECECEC00ECECEC00ECECEC00ECEC
      EC00ECECEC007D7D7D007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000074A37400008000000080000074A37400000000000000
      0000000000000000000000000000000000000000000000000000000000009F9F
      9F0093939300919191009C9C9C008F8F8F00BEBEBE0094949400919191009090
      900091919100999999009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ACACAC00A1A1A100A5A5A500ACACAC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EEF2F300E7EFF000E9F0F100EDF2
      F200F3F4F50000000000EBEBEB00F3F3F3000000000000000000000000000000
      0000000000008080800000000000000000008080800000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DCDCDC0041414100E4E4E4000000
      0000000000000000000000000000000000000000000000000000EEF0EF00ECEE
      EC00EDEFED00EDEFED00ECEEEC00EEEFEE00EEEFEE00ECEEEC00EDEFED00EDEF
      ED00ECEEEC00EEF0EF0000000000000000000000000000000000000000000000
      0000000000000000000000000000F1F3F400DCEDF000D6ECF000D8ECEF00DEEC
      EF00ECF3F400F3F7F80015151500989696000000000000000000000000008080
      8000000000003B3B3B00808080008080800000000000C0C0C000808080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EEEEEE008B8B8B0007070700B0B0B0000000
      0000000000000000000000000000000000000000000000000000477E42007DA2
      740057885100568850007BA473003C783B003C783B007BA47300568850005788
      51007DA37400497D440000000000000000000000000000000000000000000000
      0000000000000000000000000000E7F0F100C5EDF600C1EEF800C4ECF300D4F1
      F700DFF4F7009CA7A900C7CECF00F2F4F4000000000080808000000000003B3B
      3B008080800080808000808080008080800000000000C0C0C000C0C0C000C0C0
      C000808080000000000080808000000000000000000000000000000000000000
      0000F2F2F20070707000B2B2B200DCDCDC00F3F3F300B3B3B300C4C4C400D9D9
      D90000000000000000000000000000000000000000000000000060905A00DEEC
      C9008AAF7E008CAF7D00DEECC90054884E0054884E00DEECC9008CAF7D008AAF
      7E00DEECC900618F590000000000000000000000000000000000000000000000
      0000DBDBDB00463F3E00A1A5A700C5EDF600BAFAFC00ADF2F800B9FAFD00C0F6
      FA00758F9500C1D7DA00F1F9FA00F3F5F6000000000000000000808080008080
      80008080800080808000808080008080800000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000F1F1F100F3F3
      F300C0C0C0001E1E1E008B8B8B000000000000000000BBBBBB00EAEAEA002323
      23007F7F7F000000000000000000000000000000000000000000477A4100729E
      6A0052864C0053854B00729E6A003C7437003C743700729E6A0053854B005286
      4C00729E6A00477B420000000000000000000000000000000000000000000000
      0000BABBBB004128270056707B005CE4F70093F1F400B1FBFC00A9F7FB005D8D
      9400AFE3ED00D7F8FB00DCEBEE00EBF0F1000000000000000000808080008080
      80008080800080808000808080008080800000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000000000000000000000000000E8E8E80015151500A4A4
      A40000000000CACACA00F3F3F300BEBEBE007E7E7E001B1B1B0091919100C1C1
      C10087878700E9E9E9000000000000000000000000000000000059895300BED3
      AD0079A270007BA27000BDD5AC004E8248004E824800BDD5AC007BA2700079A2
      7000BED3AD005989530000000000000000000000000000000000000000000000
      0000ADADAC003220210081D0E4007FFCFD007CF3FA0082E5ED005D919B00A4EF
      F300BCFAFD00C2ECF500D5EBF000E7EFF0000000000000000000808080008080
      80008080800080808000808080008080800000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000000000000000000000000000000000087878700D8D8
      D800E1E1E100A0A0A000E4E4E40089898900565656002E2E2E0067676700EEEE
      EE00C7C7C70041414100C1C1C10000000000000000000000000057875100B4CE
      A50074A06C0076A06B00B4CEA5004B8146004B804600B6CEA500769F6B00759F
      6D00B4CEA5005787510000000000000000000000000000000000000000000000
      00009E9B9A004A34370065D5E10093FEFF007CDAE000448C970087EEF200B2FC
      FD00ADF3F600BFEFF800D4ECF100E5EFF1000000000000000000808080008080
      80008080800080808000808080008080800000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000D2D2D2000000
      0000747474000000000074747400E9E9E90000000000979797001F1F1F005757
      570064646400B7B7B700EBEBEB00000000000000000000000000306D2F002D68
      2A002B6A2A002B6A2A002B682A002A6926002A6927002B682A002B682A002B6A
      2A002D682A00306D2F0000000000000000000000000000000000000000000000
      00002B292900967E7C0073706E0057C2CC0052A4AE008BF4FA007AF6F9008BF6
      F900C1FBFC00CAECF400DFEEF000EEF2F3000000000000000000808080008080
      80008080800080808000808080000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000000000000000000000000009C9C9C006F6F6F00DBDB
      DB00C0C0C00068686800D5D5D50084848400DDDDDD00ACACAC00A5A5A500ADAD
      AD000D0D0D00B0B0B000EBEBEB0000000000000000000000000055875000B3CE
      A500769F6D00769D6B00B4CEA5004C8146004B804600B5CEA600779E6C00749D
      6B00B3CEA5005787510000000000000000000000000000000000000000008D8D
      8D0007070700B6A9A900D8B7B700846C6B0061D3DA0089FDFE0086FAFC0057BF
      D400CCE2E800F1F4F40000000000000000000000000000000000808080008080
      8000808080003B3B3B0000000000808080008080800000000000808080008080
      8000C0C0C000C0C0C000000000000000000000000000747474004B4B4B00CECE
      CE00E4E4E400B9B9B90000000000BDBDBD0000000000BDBDBD00B0B0B0000000
      0000A9A9A9007E7E7E003E3E3E0000000000000000000000000058895200BDD4
      AC0079A270007BA36F00BED5AD004E8248004E804800BCD5AD007BA270007AA2
      7100BDD5AC005889520000000000000000000000000000000000ACADAD000404
      0400413B3B005E585800F7F0F000FAEFEF00AC9C99006595A00075818B005D4E
      5300827F7F000000000000000000000000000000000000000000808080003B3B
      3B000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000808080000000
      000080808000C0C0C000000000000000000000000000D0D0D000F3F3F3000000
      00008787870049494900F3F3F300E0E0E000D9D9D9001A1A1A0010101000D7D7
      D700B7B7B700CACACA006E6E6E00000000000000000000000000467A4100739C
      6A0051864C0054864C00749D6B003B7538003B753800749D6B0052864C005186
      4C00739C6A00467A4100000000000000000000000000CECECE0004030300564E
      4E00B0A4A4009E9292006C656500B2A1A100A38B8E00876B660054454300584D
      4A00868686000000000000000000000000000000000000000000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000080808000000000000000000000000000C9C9C900000000000000
      00007E7E7E004B4B4B00ACACAC00535353009F9F9F002525250000000000B6B6
      B600A1A1A100E5E5E500D5D5D50000000000000000000000000060905900DDEC
      C9008AB081008BB07F00DCEDC80052874F0052874F00DEECC9008BAF80008BAF
      8000DEECC900609059000000000000000000DFDFDF000C0C0C00584F4F00BDB0
      B000F5E6E600D2C3C300443B3B0074767600DCDDDD0000000000000000000000
      000000000000000000000000000000000000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000000000000D6D7D7004D4D4D00D2D2D200CBCB
      CB002C2C2C002C2C2C00A2A2A20096969600CACACA00D7D7D700ADADAD008A8A
      8A00050505004A4A4A00C1C1C100EEEEEE000000000000000000487B45007BA4
      720056875000578851007BA472003F763C003F763C007BA47200588752005788
      51007BA47200487B450000000000000000005050500054494900D8C7C700FDF9
      F900DDC8C800574F4F00C8C9C900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
      800000000000808080000000000000000000868888000000000079797900CACA
      CA006262620080808000D4D4D40057575700040404009393930095959500C6C6
      C6007C7C7C005757570019191900686868000000000000000000EEF0EE00ECEE
      ED00EDEFED00EDEFED00ECEEED00EEEFEE00EEEFEE00ECEEED00EDEFED00EDEF
      ED00ECEEEC00EEF0EE000000000000000000C2C2C2008A7D7D00FFFBFB00DFCB
      CB0068656500E8E8E80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000C0C0C000C0C0C00080808000000000008080
      800000000000000000000000000000000000F2F3F300E3E3E30000000000E8E8
      E8003D3D3D006E6E6E00B2B2B200303030006C6C6C00A9A9A9002E2E2E007B7B
      7B00EBEBEB00EAEAEA00A6A6A600ABABAB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CECECE0079717100A2A1
      A100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F30000000000ECECEC0077777700EDEDED0000000000E6E6E600EEEE
      EE000000000000000000000000000000000000000000CAB29600C4AB8B00C7AC
      8E00C7AD8F00C8AF9100C8B09200C8AF9100C7AF9100C7AF9100C7AE8F00C7AD
      8E00C6AC8D00C1A68600D6C8B700F6F6F6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2D8CB00E1CEB700D9C3A800DBC7
      AC00DECAB100DECBB000DAC5AA00DECBB100DDCAB000DDCAB000DDC9AF00DCC7
      AE00DCC6AC00D3BC9F00D8CBBA00F6F6F60000000000E4E2E200AD919100A295
      9500E8EAEA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2D7CB00DDCBB300D5BFA200D9C5
      AA00D7C1A7009A795800C7AE9200DDCAB000DBC6AC00DBC6AD00DAC5AB00D8C3
      A900D8C2A700D2BB9E00D9CCBC00F6F6F600E9E9E900B6535300ED686800CE55
      550070505000EBEDED0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BEC1C400BDC0C40000000000000000000000
      000000000000000000000000000000000000E3D8CC00DFCDB600D6C1A500DFCB
      B1008B6B530059301000C3AA8E00E2CFB600DDC9AF00DCC8AF00DBC7AD00DAC6
      AC00D9C4A900D4BEA200DBCEBE00F6F6F600D5C4C400EC626200FFE9E900FFA1
      A10099343400C7C8C40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008E939B00404C5A00404C5A008D919900000000000000
      000000000000000000000000000000000000E3D8CC00E2D1BC00DDC9AF00CFBB
      A30042241600471F04008F705700E8D9C300E2D0B800E1CFB700E2D1B800DBC7
      AD00DDC9B000D8C4A900DBCFBF00F6F6F600E9E8E800CE5B5B00FF949400F87A
      780084393800AFB1C600F2F3F300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E6E6E600CDCD
      CD00FCFCFC00FDFDFD00CFCFCF00E1E1E100FCFCFC00CACACA00EAEAEA00F0F0
      F000CACACA00E5E5E50000000000000000000000000000000000000000000000
      0000D1D5D900CDCFD400C5C9CB004C5661004C566100C4C8CA00CDCFD400D1D3
      D70000000000000000000000000000000000E3D9CD00E4D5C000E4D2B900C1AE
      970029130B00330F0000451F0C00B39B8800EEE1CC00ECDDC800C3AC9000B89D
      7F00E5D4BC00DCC9AF00DDD0C100F6F6F60000000000E3E0E000BF858500AD7F
      8100D9D9D600E6E7F1006F6FDB007E7EC600D6D6D70000000000000000000000
      0000000000000000000000000000000000000000000000000000838383000F0F
      0F00F7F7F700FDFDFD005D5D5D003D3D3D009797970016161600CBCBCB006969
      690014141400959595000000000000000000000000000000000000000000A4AD
      B4005062730052637500A5AEB6000000000000000000A6AFB600526375005162
      7300A5ABB300000000000000000000000000E3D9CD00E7D9C600E6D5BE00D5C5
      B000361C1600270600002D0A0000421D1200AD988900C0AB920071492600AC90
      7200EBDBC600E0CEB500DED1C200F6F6F6000000000000000000000000000000
      00000000000000000000000000008C8CE1000404E1004848BD00AFAEC600DDDF
      E000CBCBC900B3B0B000E5E7E7000000000000000000000000007F7F7F000000
      0000F6F6F60000000000E6E6E6001C1C1C000000000088888800F9F9F9000000
      000066666600F8F8F800000000000000000000000000DCDEE000D0D3D700C6CC
      D0005666760052617200BCC2C800DCDDE000DCDEE000BEC4C900526272005766
      7600C6CAD100D1D3D700DBDEDF0000000000E3D9CD00E9DCCA00E7D7C100EEE1
      D0007E685F00210400002A08000029060000361309004F290E00572F0E00A488
      6B00F0E2CE00E3D3BC00DED3C300F6F6F6000000000000000000000000000000
      000000000000000000000000000000000000D3D3E6003231ED00292DFF002828
      AB00A5442E00BC45470082454500E2E2E2000000000000000000818181000000
      0000F5F5F50000000000FDFDFD004848480000000000CDCDCD00FDFDFD000000
      00008C8C8C00000000000000000000000000B3B7BC003E4955003D485600A1A5
      AB000000000000000000AFB3B6003B4754003C475500ABAFB500000000000000
      0000A2A7AC003D4856003C485600B2B6BA00E3D9CD00EDE2D200EEE0CD00F3E7
      D600E8DCD1007050480041190400482209003C190700321001003E1800009A7D
      6800F5E8D600E7D8C100DFD4C500F6F6F6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000727BDA008845
      7B00FF968500FFC2C300E65E5E00B69F9F000000000000000000838383000000
      0000F9F9F900000000009494940005050500343434002F2F2F009E9E9E000000
      000034343400BCBCBC000000000000000000B3B7BB003F4956003C485600A2A7
      AC000000000000000000AFB3B6003B4654003B475400AFB3B600000000000000
      0000A4A8AD003C4856003E495500B3B7BC00E3D9CD00F2E8DD00F7EBDD00F9EF
      E200FDF4EA00EBDFD500845D42006D462300734C2A00603C23002F1205008975
      6A00FAEEDE00EADCC700E0D5C600F6F6F6000000000000000000000000000000
      00000000000000000000000000000000000000000000E2E2E500BFC4D600A14E
      4C00FF908F00FFC3C300E3565600C9BABA00FBFBFB00F3F3F300717171000000
      0000E5E5E500F7F7F70097979700ACACAC00E6E6E60088888800828282000000
      000030303000BCBCBC00000000000000000000000000DDDEE000D2D4D700C6CC
      D1005766760050617100BBC2C800DDDFE100DDDEE000BCC2C800526172005565
      7500C4CACE00D2D4D700DCDDE00000000000E3D9CD00F6EEE400FDF5EA00FEF8
      EF00FFFBF500D7C9BA0095735100916D4A0094714E009976530085664600A493
      8000F9F0E100ECDFCC00E1D5C700F6F6F6000000000000000000E5E7E700D7DA
      DA00EFEFED00E9E9E600C3C3CB008282BA004444C6008181DC00ECEDF300E4E2
      E000C7848500CE727200CEB1B10000000000CDCDCD002C2C2C00171717000F0F
      0F001E1E1E008F8F8F0000000000000000000000000000000000FDFDFD004B4B
      4B0095959500000000000000000000000000000000000000000000000000A7AD
      B5005061730052637400A6AFB6000000000000000000A7AFB700516374005062
      7300A4ADB400000000000000000000000000E3DACD00F8F3EB00FFFDF600FFFF
      FA00E4D6C800AB8A6A00AC8B6A00B0906F00B2917100B3937300B2927000D7C4
      B000FCF9F100EFE2D100E1D5C700F6F6F60000000000BFBABA006E3335006132
      22003F437A003535C3000C0CF1002E2EE800CECEE90000000000000000000000
      000000000000000000000000000000000000F2F2F200C8C8C800C9C9C900CDCD
      CD00C5C5C500E2E2E20000000000000000000000000000000000FDFDFD00EBEB
      EB00EAEAEA000000000000000000000000000000000000000000000000000000
      0000D4D6D900CBD1D400C4C8CA004B55620049536000C3C5C800CCD2D600D2D6
      DA0000000000000000000000000000000000E4D9CD00F8F5F100FFFFFF00FFFF
      FE00F8F1EB00F4EEE900F6F1EC00F6F1EC00F6F1EC00F6F2EC00F6F1EB00FAF7
      F400FFFFFF00F7F1EB00E3D9CC00F6F6F600E5E3E300AC444400FA818300F075
      610060377F00222BFD00A7A7E100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008D949B003F4C5A00404C5A008C949900000000000000
      000000000000000000000000000000000000E1D6C900E5DACD00EAE0D500E9E0
      D500EAE1D600EAE1D600EAE1D600EAE1D600EAE1D600EAE1D600EAE1D600EAE0
      D600E9E0D500E5DACD00E4DACE00F6F6F600DACFCF00E85B5B00FFE9E800FFAA
      A900A0393100B6BAC60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFC3C700BEC2C50000000000000000000000
      000000000000000000000000000000000000F3F2F000F0EDEA00F0EDEA00F0ED
      EA00F0EDEA00F0EDEA00F0EDEA00F0EDEA00F0EDEA00F0EDEA00F0EDEA00F0ED
      EA00F0EDEA00F1EDEA00F3F2F000F6F6F60000000000D6878700F6777700E363
      6300B49391000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F6F6F600F6F6F600F6F6F600F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F6000000000000000000E0CFCF00E2DB
      DA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000272727001E1E1E00EAEAEA00000000000000
      000000000000000000000000000000000000DDE1E000C3C1C000C4C1C200CAC7
      C600FFFFFF00FFFFFF00D0CFD000BEBABA00C3C1C300C2BDBF00EFEFEE00FFFF
      FF00E8EAE900BFBBBD00C6C4C500CBCACA000000000000000000000000000000
      0000BEBEBE007E7E7E001313130000000000131313007E7E7E00E1E1E1000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D0D0D0008D8D8D00F0F0F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D5D5D5004646460010101000767676003B3B3B00B0B0B0000000
      0000000000000000000000000000000000004B131E0072444C006E404800460F
      1900FFFFFF00E6E1E200764D5500643139006738400062323B00B6A6A800FFFF
      FF00764E550065343C0072464C004A111C000000000000000000E1E1E1007E7E
      7E0028282800BFBFBF00D5D5D500000000004F341B000B090800000000002626
      2600ECECEC000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00848484003C3C3C00070707005E5E5E00F5F5
      F500000000000000000000000000000000000000000000000000000000000000
      0000B3B3B30019191900C5C5C4005F605E00A8A8A800E2E2E200343435007D7E
      7E00000000000000000000000000000000007F5A5F00FFFFFF00FFFFFF006234
      3D00FFFFFF00DED9DB00D7C7C900FFFFFF00FFFFFF00E7D7D700B19FA300FFFF
      FF0077505800FFFFFF00FFFFFF009A797F007F7F7F008D888300282727007F7F
      7F00F1EFED00FFFFFF00FFFFFF00000000005F3E20005F3E200066432300B9B3
      AE001E1E1E00131313007E7E7E00000000000000000000000000000000000000
      0000E8E8E80087878700464646006E6E6E00B3B3B30040404000444444006565
      6500000000000000000000000000000000000000000000000000000000007B7B
      7A002E2E2C00C3C4BF00FCFDFE00484C490098969600F7F4F200DEE0DE005053
      5300505150000000000000000000000000006B414700FFFFFF00FFFFFF005A28
      3100FFFFFF00DAD2D500CAB6B800FFFFFE00FFFFFF00D8C4C600AA959900FFFF
      FF0071474F00FFFCFA00FFFFFF008B636A007F7F7F00897F7500AD723B00C387
      4F00FFFFFF00FFFFFF0000000000000000005F3E20005F3E20005F3E2000BFBF
      BF00BFBFBF00B5B5B50013131300000000000000000000000000F4F4F400AAAA
      AA005656560067676700B0B0B000F6F6F600F6F6F6003C3C3C00A4A4A4005F5F
      5F007D7D7D00FEFEFE0000000000000000000000000000000000525253004B4B
      4900D1D2CE00CCCDD900CECAF400343E4F00996E8600F3C7C000DFC8C700ECE5
      E500848687002F303000ECECEC0000000000917178008E6E7400501F28007852
      5900FFFFFF00F0EFEF00A78F94006F474C0062343D00997B8000D5CBCD00FFFF
      FF00B29CA10045141C00815C610086656C007F7F7F00B37C4A00BE7D4000BE7D
      4000FFFFFF00FFFFFF00C9BFB50000000000664323005F3E20005F482000BFBF
      BF00BFBFBF00BFBFBF00000000000000000000000000FCFCFC00414141003E3E
      3E00B6B6B600F6F6F600F6F6F600F6F6F600F6F6F6003939390092929200F6F6
      F6005F5F5F0088888800000000000000000000000000EBEBEB002E2E2B00E5E5
      E200C5C3D200918ED800827AFF000B206800B2375A00FF7B6F00E6858200DFB9
      B900F6F1F2007F8383006666660000000000FFFFFF00FFFFFF00A8A9A9005B5D
      5C00FBFFFE00FFFFFF00FFFFFF00B3B5B40082808200FFFFFF00FFFFFF00FFFF
      FF00898B8B006D6F6E00FFFFFF00FFFFFF007A757000BE7D4000BE7D4000BE7D
      4000FFFFFF00C58D5700B6783E0000000000B0ABA600ABB0A6005F3E2000BFBF
      BF00BFBFBF00BFBFBF00000000000000000000000000D8D8D8003B3B3B006E6E
      6E006C6C6C00A8A8A800F6F6F600F6F6F600F6F6F6004040400082828200F6F6
      F600F6F6F60021212100C8C8C8000000000000000000B7B7B70059595700D5D7
      DF00A19DD3005C50F1004938FF00000B7F00D0111600FF2A1B00FF3D3700EA87
      8300E4CECD00C5C7C7004243430000000000F6F5F500FAFAFA00FFFFFF009690
      91004F4A4C00F3F5F400FFFFFF00ACA6A90079717200FFFFFF00FFFFFF00807D
      7E0069606400FFFFFF00FFFFFF00000000000B090800B6783E00C58D5700FFFF
      FF00BE7D4000BE7D4000BE7D400000000000BFBFBF00BFBFBF00BFBFBF005F48
      20005F3E2000B0ABA600000000000000000000000000AFAFAF0068686800D3D3
      D300929292005A5A5A0080808000F6F6F600B6B6B60034343400393939006363
      63008D8D8D00747474008D8D8D00000000000000000080807E0077777500CBCC
      E300817CE6003D2CFF003C22FF00000C8500D60E0D00FF150800FF120700FA4F
      4800E1B0AE00E3E0E1001E1F1F000000000000000000F5F5F500FAFBFB00FFFF
      FF00958F9000504B4C00FFFFFF00BCB6BA007F787B00FFFFFF00858182006561
      6000FFFFFF00FFFFFF00000000000000000000000000C9BFB500FFFFFF00FFFF
      FF00BE7D4000BE7D40009F68360000000000A0A0A000BFBFBF00BFBFBF005F3E
      20005F3E2000664323000000000000000000000000008E8E8E0077777700F6F6
      F600F6F6F600F6F6F6007D7D7D005D5D5D006F6F6F00282828005C5C5C00F6F6
      F600F6F6F600F6F6F6006A6A6A0000000000000000006162600091929400B9B9
      DF006B63ED002F1FFF004126FF00000D9700EC0B1000FF1D0D00FF100300FF2B
      2200E7959200EEE3E2002E333300000000000000000000000000F5F5F500FDFD
      FD00FFFFFF009D9D9E0099999A00C1C2C2009A999B00CACCCD006A696900FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FAF9
      F900B6783E007F7F7F00131313000000000000000000C9C9C900B0ABA6006643
      23005F3E20005F3E20000000000000000000000000006C6C6C0093939300F6F6
      F600F6F6F600F6F6F600F6F6F60062626200F6F6F6005656560058585800F6F6
      F600F6F6F600F6F6F60051515100FAFAFA00000000004F4F4C00A9A8AE00B2AF
      E4007566FF003918FF002E00FF0000004A00650A0700C8000A00FF000300FF20
      1A00F68B8800EEDFE00050555400D1D1D100000000000000000000000000F9F9
      F900FFFFFF00AE9FA30036212500331C21003D272D002F161D0082707300F2F3
      F300FEFFFF00F6F5F500000000000000000000000000FFFFFF00FFFFFF00C9C9
      C90033281E00BFBFBF0000000000FFFFFF00000000001C140C00000000000B09
      08006E4825004F341B000000000000000000FCFCFC004E4E4E00AAAAAA00F6F6
      F600F6F6F600F6F6F600D0D0D0006B6B6B00ABABAB00373737003A3A3A00F6F6
      F600F6F6F600F6F6F60047474700DADADA00FCFCFD0043434100D7D8DD00BDBA
      EA005039BB00060058000046260000E10A0005FF01000486000032110000CB0A
      1600FF8F8F00FFF2F3007A7E7C00A5A5A5000000000000000000F6F5F500FFFF
      FF00E1DBDC005B242E00B7959900AF888C00AE888D00BA999D0067303A00A38E
      9300FFFFFF00F6F5F500000000000000000000000000E9E9E900302D2B00BE7D
      4000C1B9B200FAF9F900FFFFFF00FAF9F900C58D5700BE7D4000BE7D4000AD72
      3B000B090800000000000000000000000000E0E0E00042424200F6F6F600F6F6
      F600B4B4B4009393930065656500212121002222220033333300252525004242
      42009C9C9C00C9C9C9004F4F4F00BEBEBE00EBEBEB00434342008A8B8A002E28
      2F003E4F4D0051D7740026FF240000FF030000FF010000FF090012FC2F001B66
      350032212400A69C9F00B0B1B1008D8E8E000000000000000000F5F5F500FFFF
      FF00E0DCDC00855D6300FFFFFF00FFFFFF00FFFFFF00FFFFFF00AB888E00A18E
      9300FFFFFF00F5F4F4000000000000000000131313007F7F7F00AD723B00BE7D
      4000BE7D4000BE7D4000C58D5700D3D3D300C58D5700BE7D4000BE7D4000BE7D
      4000AD723B007F7F7F002626260000000000BFBFBF0024242400797979005858
      580043434300444444005C5C5C003A3A3A009B9B9B00F6F6F600B2B2B2006666
      660038383800727272005757570098989800CACACA000000000040403F00F8F7
      F60000000000BBFFBE006EFF71003CFF440029FF33003DFF460082FF8800D6FF
      D900D8E7DD00757677002F2F2F00666666000000000000000000F5F5F500FFFF
      FF00DFDBDC00784C5300FFFFFE00EADADA00EADADA00FFFDFC0095707500A18E
      9100FFFFFF00F5F4F4000000000000000000E1E1E1007E7E7E00282727007F7F
      7F00BC7C4000BE7D4000C58D5700FAF9F900FFFFFF00FAF9F900BAB5B000BC7C
      4000231E19007E7E7E000000000000000000C7C7C70022222200000000003737
      370089898900BCBCBC00F6F6F60065656500F6F6F600F6F6F600F6F6F600F6F6
      F60093939300323232000101010070707000EEEEEE0053535300474647007071
      6F00BCBBB900F7FFF500E3FFE500C5FFC700B4FFB700C9FFC900E9FFED00E7EF
      E500A7A5A70063626300323232009B9B9B000000000000000000F5F5F500FFFF
      FF00E1DCDE00754B5200FEF7F600E2D4D400E2D4D400FCF5F200906B7100A490
      9500FFFFFF00F5F4F4000000000000000000000000000000000000000000EFEB
      E7007E7E7E002A231B00C4C9CD000000000000000000BFBFBF002A231B007E7E
      7E00EFEBE700000000000000000000000000FDFDFD00E9E9E900BFBFBF009797
      97007373730062626200686868003434340071717100666666005D5D5D006060
      60006F6F6F008080800089898900CACACA000000000000000000E7E7E700AEAD
      AE004947490027212700625B6200AEAAAD00BEC3BE008F908F00463E45002622
      26006D6C6D00C8C8C800F8F8F800000000000000000000000000F6F5F500FFFF
      FF00E1DDDD0072464E00F5F1EF00E1D7D500E1D7D500F5F0EF008B666A00A491
      9400FFFFFF00F5F4F40000000000000000000000000000000000000000000000
      000000000000ECECEC007E7E7E0013131300131313007E7E7E00ECECEC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD00DFDFDF00B2B2B2008F8F8F009E9E9E00B8B8B800CECECE00E8E8
      E800FDFDFD000000000000000000000000000000000000000000000000000000
      00000000000000000000BBBBBB00767174007F7C80008C898C00ECEAEC000000
      0000000000000000000000000000000000000000000000000000F6F5F500FEFF
      FF00F3F2F200693D4500826065007B565E007B565E008362680065373F00C5BA
      BD00FFFFFF00F5F4F40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E8E1E100C9B7B700E8E1E1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EFEFEF00E3E3E300C6C6C600A1A0A100A5A8
      A3008D877F005B482D00ADACAB00EFEFEF000000000000000000000000000000
      0000000000000000000000000000EEEEEE00E2E2E200C5C5C500A09FA000A3A7
      A60082898200394F3800ABACAB00EEEEEE000000000000000000000000000000
      00000000000000000000ECECEC009B9B9B006F6D6D006A66660077757500B3B4
      B400F4F4F4000000000000000000000000000000000000000000000000000000
      00000000000000000000EFEAEA00C3AFAF00624E4E00403333005A484800C9B7
      B700000000000000000000000000000000000000000000000000000000000000
      0000F1F1F100DADADA00B6B6B500A2A19F00A3A1A000BAB8B100D9D8CB00C1C0
      BE00E0B06C00FFD59D00523A1A00ABA8A4000000000000000000000000000000
      0000F0F0F000D9D9D900B4B5B5009FA19F00A1A2A000B2B8B300CCD7D000BEC0
      BE008AC48700B8E7B40029432700A5A9A5000000000000000000000000000000
      000000000000E0E1E10033313100BEB0B000F9EBEB00FAF0F000F4E2E2009386
      860054555500F2F2F20000000000000000000000000000000000000000000000
      0000E9E2E200B29898005A48480054434300745D5D005A484800A98B8B009E7E
      7E00E5DCDC00000000000000000000000000000000000000000000000000E9E9
      E9009FA0A00093989800B1B4B400D4D2D300E7E4DA00E2DFD800D5A99800DE57
      2400F0C17700F1EBE400A479400092939300000000000000000000000000E8E8
      E8009E9F9F0093939700B0B1B300D3D2D200DBE4DD00D9E0DA00B4BFAD007B9B
      660093D49200E8EDE7005B8B5800919292000000000000000000000000000000
      0000F4F4F4004B4A4A00F3E1E100FCF5F500F2E3E300F6E7E700F1E2E200FCF9
      F900AC9D9D007F818100000000000000000000000000F7F5F500E6DDDD00AD91
      91004C3D3D0056454500735C5C007A6161007D64640054434300AE929200C3AE
      AE0090737300F4F0F00000000000000000000000000000000000EEEEEE008F90
      9000A9A5A100BF9D6F0091775300A6A59D00E0BFB700EC724600F7561B00ED4E
      25008A735F00D0A65D0055422900CED0D0000000000000000000EDEDED008E8F
      8F00A3A6A20084AB8200638161009DA49F00CBD0C60094B0810082A8690087A0
      71006E7D6B0076B6760035493300CDCECF00E0E0E000AFAEAE00B0AFAF00B5B5
      B500929393008A7D7D00FDFAFA00EEE2E200FDEEEE00FBF3F300F7E8E800EEDE
      DE00FAF7F7005C565600F0F0F00000000000E1D7D7008E717100473939005645
      4500725B5B00775F5F00775F5F00775F5F007B62620055444400BAA3A300BCA5
      A500B3999900AF93930000000000000000000000000000000000BBB9B700A2A8
      A800CFAF8300FFD49D00FCCB8700644B2800C48B8600DABFB400D2C9C400D0CF
      CC00C0C3C1009A9B9A006C6C6C00E2E2E2000000000000000000B8B9B700A2A3
      A70097BC9500B9E6B500A6DFA30038553600A5A9A000C5CCC100C9CDC800CCCF
      CC00C0C2C200999A9A006B6B6B00E1E1E100BCBCBC00B8A9A900C2B2B200B8A9
      A900221F1F00BCAFAF00FDF3F300FFFBFB00D0C2C20014131300FCF9F900F7E8
      E800FCF6F600786E6E00E2E2E20000000000C7B4B40033292900765E5E00715A
      5A00725B5B00745D5D00775F5F00775F5F00775F5F005A484800C0ABAB00B79E
      9E00BCA5A500A2828200D5C7C7000000000000000000EFEFEF0085848200D0D4
      D400CAB39300FFD08200EEBB76005F4B2F00A1A59C00C2C2B600B4B3AA00A6A5
      A100B0B0AF00D4D2D300EDEDED000000000000000000EEEEEE0082848200D0D0
      D300A1BC9F009EE29E0096D092003B533A009CA4A100B6C0BA00AAB2AD00A1A5
      A200AEAFAF00D3D2D200ECECEC0000000000BCBCBC00B8A9A900EEDFDF00F8EA
      EA00423D3D00948C8C00FEFBFB00F8E9E900FDEEEE00E9DCDC00FDEEEE00F0E4
      E400FCF9F9006D686800F0F0F00000000000EFEAEA00937575005D4A4A00765E
      5E00725B5B00765E5E00786060007A616100715A5A00604D4D00C6B2B200B8A0
      A000B59C9C00BDA7A7008E717100E8E1E10000000000DCDCDC0098979500DADA
      DA00E1E2DC00A3886E00A9977A0084848300DBDBDB00D5D3D500DBDBDB00EAEA
      EA000000000000000000000000000000000000000000DBDBDB0095979500D9D9
      D900DCE1DE0080947C00849E840082838300DADADA00D4D2D300DADADA00E9E9
      E90000000000000000000000000000000000BCBCBC00B8A9A900DFD0D000EDDE
      DE009086860023232300FAF8F800FEF4F400FCEDED00FFF4F400F5E6E600FEFB
      FB00E3D3D30044444400D8D8D800D8D8D800F3EFEF00C5B1B100534242006954
      5400775F5F00765E5E007A6161007B62620067525200725B5B00C7B4B400B8A0
      A000B89F9F00B8A0A000A5868600F1ECEC0000000000B8B8B700B5B2B200E7E6
      DB00E6D1CB00D2756600DBDDCF00B0AEAF000000000000000000000000000000
      00000000000000000000000000000000000000000000B6B7B700B3B3B300DCE5
      DF00D8DBD4009CA69100CFDBD500AFAEAE000000000000000000000000000000
      000000000000000000000000000000000000BCBCBC00B8A9A900DBCCCC00DBCD
      CD00F0E1E1003F3B3B00403F3F00F8EFEF00FEFBFB00FEFBFB00FCF9F900E7D9
      D9001F1E1E002F2C2C00494040009392920000000000EEE9E900D8CBCB006752
      5200745D5D00786060007A6161007C6363005E4B4B008E717100C6B2B200BAA2
      A200C0AAAA009F7F7F00EFEAEA00000000000000000092909100CDCDCB00E7E4
      DA00F7693400BA988C00D1CFC200BABAB9000000000000000000000000000000
      0000000000000000000000000000000000000000000091919000CACCCB00DBE4
      DD008FB17900A1A99C00C3CFC600B8B9B9000000000000000000000000000000
      000000000000000000000000000000000000BCBCBC00B8A9A900D7C8C800D0C1
      C100E7D7D700EBDBDB00554E4E0019171700615A5A00756E6E004C4848000A0A
      0A002F2D2D0080757500524F4F00F1F1F100000000000000000000000000EBE5
      E500534242007D6464007A6161007C63630055444400A4858500C3AFAF00C2AD
      AD009E7E7E00E5DCDC000000000000000000E3E3E30094939400DEE4D700D89A
      8B00E7380900B9B0AE00BEBBB000D6D6D6000000000000000000000000000000
      000000000000000000000000000000000000E2E2E20093929300D7E2DE00B1BA
      A80075925D00B3B4B100B2BBB300D5D5D5000000000000000000000000000000
      000000000000000000000000000000000000BCBCBC00B8A9A900D1C3C300CBBD
      BD00D2C4C400E2D4D400F9F6F600403F3F00070606001F1D1D00292828005C57
      5700877F7F0048424200CCCDCD00000000000000000000000000000000000000
      0000D7C9C9004B3C3C00826868007B62620054434300AF949400CCBBBB00A384
      8400DFD4D400000000000000000000000000BABABA00989A9A00BFAA8700946D
      3F00653D2800B6BABA00A9A8A400EAEAEA000000000000000000000000000000
      000000000000000000000000000000000000B9B9B9009798990093B29300587E
      540042503C00B6B6B900A4A8A500E9E9E9000000000000000000000000000000
      000000000000000000000000000000000000BCBCBC00B8A9A900D2C4C400CCBE
      BE00D1C3C300D5C7C700F9EAEA00504F4F005D5B5B0081787800817A7A007D76
      7600655C5C007876760000000000000000000000000000000000000000000000
      000000000000BFA9A9005E4B4B008167670051414100C4B0B000AD919100CFBF
      BF00000000000000000000000000000000009DA0A0005D4D3600FFD09300FFDE
      A800A2772D0079797900ACACAB00000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9F0040533F00B1E4AD00BCEB
      BB004687470078787800AAABAB00000000000000000000000000000000000000
      000000000000000000000000000000000000BCBBBB00B8A9A900B8A9A900B1A2
      A200B8A8A800BBAEAE00D0BFBF005C5B5B00DADBDB0046414100776D6D007169
      690038323200E6E6E60000000000000000000000000000000000000000000000
      000000000000F7F5F500866B6B006D5757006C565600BAA3A300C3AEAE000000
      000000000000000000000000000000000000EFEFEF00ABA59C00977A5300C6A6
      7D0077572B0028282800D1D1D100000000000000000000000000000000000000
      000000000000000000000000000000000000EEEEEE009FA79F006585630091B3
      8E003F643D0027272700D0D0D000000000000000000000000000000000000000
      000000000000000000000000000000000000D6D5D5008D8D8D008E8D8D008F8E
      8E008F8E8E008E8D8D008B8A8A009A9A9A0000000000A5A4A400544C4C004A41
      4100AEAEAE000000000000000000000000000000000000000000000000000000
      00000000000000000000F1ECEC00634F4F005B494900BCA5A500000000000000
      00000000000000000000000000000000000000000000F1F1F100C0B4A3008B7C
      6800BEBEBE00E1E1E100F1F1F100000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0F0F000AAB9A9007182
      7000BDBDBD00E0E0E000F0F0F000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1F1F10039333300504D
      4D00F4F4F4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DED3D3007B626200F6F3F300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C7C700D0CF
      CF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00777777004D4D
      4D004D4D4D004D4D4D00B8B8B800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000055555500555555005555
      5500555555005555550055555500555555005555550055555500555555005555
      5500555555005555550055555500000000000000000000000000EEEEEE005E5E
      5E004D4D4D004D4D4D0051515100D5D5D5000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DFDF
      DF008C8C8C00DFDFDF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D8D8D80093929200656463005E5D5C00585857005F5F5F009C9C9C00DEDE
      DE00000000000000000000000000000000000000000055555500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0055555500000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D0000000000F9F9F900BABABA00000000000000000000000000DDDDDD003A3A
      3A007C7C7C0045454500F3F3F300000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B4B4
      B400605F5F007371700073717000696766005E5C5B0053515000484645005353
      5200CACACA000000000000000000000000000000000055555500FFFFFF005555
      5500555555005555550055555500555555005555550055555500555555005555
      550055555500FFFFFF0055555500000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D00C4C4C4006262620062626200000000000000000000000000898989009797
      9700FFFFFF009F9F9F00A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C0006564
      6400878483008D8A88008D8A8900858281007976750067646300504D4C004340
      40004C4C4B00D0D0D00000000000000000000000000055555500FFFFFF005555
      5500555555005555550055555500555555005555550055555500555555005555
      550055555500FFFFFF0055555500000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D0062626200000000000000000000000000323232009898
      9800FFFFFF00D4D4D4003E3E3E00959595000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006C6C6C00918F
      8D00A29E9C00A9A4A000A49F9B00989390008683810073706F005F5C5B004745
      44003D3B3A007B7A7A00ECECEC00000000000000000055555500FFFFFF005555
      5500555555005555550055555500555555005555550055555500555555005555
      550055555500FFFFFF0055555500000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D0062626200000000000000000081818100ABABAB00FCFC
      FC00FBFBFB00FAFAFA00D6D6D6005F5F5F0036363600C8C8C800000000000000
      00000000000000000000000000000000000000000000B3B3B3007D7B7A00A6A2
      A000C4BEB700D3CAC000CAC2B800B0A9A200908B88007A76750066636200514E
      4D003C39380049484800D3D3D300000000000000000055555500FFFFFF005555
      5500FFFFFF00FFFFFF0055555500555555005555550055555500555555005555
      550055555500FFFFFF0055555500000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D00DBDBDB007373730062626200000000000000000090909000ACACAC00FEFE
      FE00808080009B9B9B00F8F8F800FDFDFD00BCBCBC004848480068686800B9B9
      B900888888006B6B6B00E6E6E60000000000000000008D8D8C00908D8C00BEB8
      B300EBE3D800F7F3E900EFE8DB00CAC0B6009B9691007A777500696665005956
      55003D3B3A0043424100B2B2B200000000000000000055555500FFFFFF00FFFF
      FF005555550055555500FFFFFF00555555005555550055555500FFFFFF005555
      5500FFFFFF00FFFFFF0055555500000000004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D000000000000000000CDCDCD00000000000000000000000000949494007474
      7400BABABA00B2B2B2006E6E6E009F9F9F00FEFEFE00FDFDFD00A1A1A1006868
      6800979797009B9B9B003333330000000000000000007F7F7E009C999800CBC4
      BE00F4F0E400FEFBF500F8F3EC00DBD0C2009D979200817D7B006C6968005A57
      56003F3C3B00413F3F00ABABAB00000000000000000055555500FFFFFF00FFFF
      FF005555550055555500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00555555000000000000000000A9A9A9005A5A5A004D4D
      4D0088888800EEEEEE0000000000A9A9A9005A5A5A004D4D4D0088888800EEEE
      EE00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009F9F9F0051515100CFCFCF00FFFFFF00FBFB
      FB00FFFFFF00FFFFFF002E2E2E0000000000000000008D8D8D0095929100BEB9
      B400E6DED200F4F1E200EDE2D300CAC0B6009B9691007D7978006C6968005754
      53003D3B3A0042414000AFAFAF00000000000000000055555500FFFFFF00FFFF
      FF005555550055555500FFFFFF00555555005555550055555500555555005555
      550055555500FFFFFF005555550000000000BCBCBC004D4D4D004D4D4D004D4D
      4D004D4D4D0079797900BCBCBC004D4D4D004D4D4D004D4D4D004D4D4D007979
      7900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006A6A6A0084848400FBFB
      FB00EEEEEE005F5F5F00676767000000000000000000B3B3B300817F7E00A6A2
      A000C3BDB600CAC2B900C0B8B000A6A09B008D89860079767500676463005350
      4F003C39380049484800D2D2D200000000000000000055555500FFFFFF005555
      5500FFFFFF00FFFFFF0055555500555555005555550055555500555555005555
      550055555500FFFFFF005555550000000000777777004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D00737373004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D00EEEEEE000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000069696900FFFF
      FF00CBCBCB003D3D3D00000000000000000000000000000000006B6A6A00928F
      8E00A19E9B00A6A29E009C989500918D8B00827F7D0073706F00615E5D004A47
      46003F3D3C007373730000000000000000000000000055555500FFFFFF005555
      5500555555005555550055555500555555005555550055555500555555005555
      550055555500FFFFFF0055555500000000007B7B7B004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D00777777004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D00F0F0F0000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000070707000E4E4
      E400A2A2A2009393930000000000000000000000000000000000B8B8B8006766
      66008B8987008D8B89008C89880083807F00787574006865640052504F004644
      43004F4F4E00D5D5D50000000000000000000000000055555500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF005555550000000000C9C9C9004D4D4D004D4D4D004D4D
      4D004D4D4D0086868600C9C9C9004D4D4D004D4D4D004D4D4D004D4D4D008686
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFEFEF007F7F
      7F0090909000000000000000000000000000000000000000000000000000B4B4
      B4006463630076757400757372006A686700605E5D00575554004D4B4B005655
      5500CDCDCD000000000000000000000000000000000055555500555555005555
      5500555555005555550055555500555555005555550055555500555555005555
      55005555550055555500555555000000000000000000C0C0C000737373006666
      660096969600F7F7F70000000000C0C0C000737373006666660096969600F7F7
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D5D5D5009393930069686800605F5E005C5C5C0067676700A2A2A200E0E0
      E000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000727B7000000000000000
      0000000000000000000000000000000000000000000030303000000000002828
      2800FF807000FF686000FF585000FF484000FF383000FF282800FF1818000000
      000000000000000000000000000000000000F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006F906D00499543000F260C00538551000000
      0000000000000000000000000000000000000000000038383800303030003030
      3000FF908800FF787000FF606000FF505000FF404000FF383000FF2820001010
      100010101000000000000000000000000000F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F7006262620062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262000000000000000000000000000000
      0000000000007292730041823C006A9E6100B3CAA700393B36004B7A42005182
      4E00000000000000000000000000000000000000000038383800000000003030
      3000FFB0A000FF888000FF706800FF605800FF504800FF403800FF3030001818
      180000000000101010000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300F7F7F700F7F7F700F7F7F700C3A32F00CBAD3300D3B43300D9BD
      3200E0C63000E6D62D00EEEA2A00F5F62400FFEF2100FFE42100FFE82400FFED
      2700FFE81A00FFE51200FFE80B00F4CB15000000000000000000000000000000
      00004B884500649B5B00A2BB9600B0C1A400B6CEA800363F3100A1AC9A00527E
      4900648766000000000000000000000000000000000040404000383838003838
      3800383838003030300030303000282828002828280020202000202020001818
      180018181800101010000000000000000000F7F7F700F7F7F700F7F7F7003333
      33003333330033333300F7F7F700F7F7F700F7F7F700F7F7F700333333003333
      330033333300F7F7F700F7F7F700F7F7F700A88E2E00AE973700B59C3700BBA0
      3800C0A43400C4A73200C8AF2C00CCC42500D5DC2500E0DB2A00E5C82000EDC5
      1A00EFC91800EEC71200F0CA0D00D3B017000000000000000000469541004D97
      4200AEC0A300B3C5A800A4BD9800A3BD9500B7D4A9003743340081967900BFCA
      B500567F4E007489740000000000000000000000000048484800000000004040
      4000B8FFB80098FF980078FF780060FF600040FF400020FF200000FF00002020
      200000000000181818000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300F7F7F70033333300F7F7F700F7F7F700F7F7F700F7F7F70033333300F7F7
      F70033333300F7F7F700F7F7F700F7F7F700A88E3500AE994000B69F4200BBA5
      4100BFA64000C4A93C00C5A73400CAAC3100CFC02C00D7DE2800DED71E00E2C0
      1800EAC11300EFC71100F0C90D00D4B0150000000000000000004E9D43007AA9
      6C006A9E5C009BBA8F00B0C7A400A3C09800BFDFB1003E4C3A007C9176009FAE
      940073856A001E3E190000000000000000000000000048484800484848004040
      4000C8FFC800A8FFA80090FF900070FF700050FF500038FF380018FF18002828
      280020202000202020000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300F7F7F700F7F7F700F7F7F700AA933B00B3A04D00BAA64D00BEAB
      4E00C2AB4C00C1AA4500C5A93E00C8A93D00CAAA3100CDC12600D4DA1F00DBCB
      1900DFBA1500E9C01000F2C70900D4AF14000000000091A8940069A65E00BEC9
      B2008CB37E005E974F0081AB7000B1CCA300AECBA0002F4E2C00344C2E004E65
      4500799070007293640071896F00000000000000000050505000000000004848
      4800E0FFE000C0FFC000A0FFA00088FF880068FF680048FF480028FF28002828
      280000000000202020000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300F7F7F70033333300F7F7F700F7F7F700F7F7F700F7F7F70033333300F7F7
      F70033333300F7F7F700F7F7F700F7F7F700AD984200BCAE5B00C3B55D00C7B7
      5F00C4B45A00C2AE5200C2AC4900C3A83E00C5A43300C7A92A00CDC52200D3D3
      1C00DABC1700E0B71200ECC20D00D5AF150000000000789B780077AE6B00B0C7
      A400B0C9A100AEC6A0007DAB6E006296540069895B00224A1E005B775700B8CA
      AD00B1C6A60095AF870050724D00000000000000000050505000505050004848
      4800F0FFF000D0FFD000B8FFB80098FF980078FF780060FF600040FF40003030
      300028282800282828000000000000000000F7F7F700F7F7F700F7F7F7003333
      33003333330033333300F7F7F700F7F7F700F7F7F700F7F7F700333333003333
      330033333300F7F7F700F7F7F700F7F7F700B2A04A00CDC57200D6CE7B00D8CE
      7800CEC46B00C6B75E00C1AC5100C0A64100C2A43800C2A22F00C7AE2700CBCB
      2000D2C21A00D8B31400E3BA0C00D1AB1500000000005B8C580094BA8300AAC9
      9E00A6C69700A7C99800BDD4AE00639A5400CAE9BB0054804C0058725200B5C7
      AC00A0B59700A3BA950040683A00000000000000000058585800000000005050
      5000FFFFFF00E8FFE800C8FFC800A8FFA80090FF900070FF700050FF50003030
      300000000000282828000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300F7F7F70033333300F7F7F700F7F7F700F7F7F700F7F7F70033333300F7F7
      F70033333300F7F7F700F7F7F700F7F7F700BCAC5700E0DB9700E9E6AD00E7E3
      A600DCD58300CDC06800C3B05400BFA74700BDA13C00BE9E3200C09F2900C5B7
      2000CAC21900D1AF1400DAB10E00CCA7150000000000447F4100A5C79600A8C8
      9700ABCE9C00B4D5A300C3DBB20071A25F00B1C5A0003667300042623F00C7CF
      BD00A8BF9F00ADC3A1003D6B3600000000000000000060606000585858005858
      5800505050005050500048484800484848004040400040404000383838003838
      380030303000303030000000000000000000F7F7F700F7F7F700F7F7F7003333
      33003333330033333300F7F7F700F7F7F700F7F7F700F7F7F700333333003333
      330033333300F7F7F700F7F7F700F7F7F700C2B26000EBE9B800F8F7E200F3F3
      D100E3DD9800D1C56E00C1AF5700BAA34800B89D3C00B89A3300B9972900BDA6
      2100C4B91B00C9AC1500D3AB0F00C7A216000000000040833A00C3E0B200B6D0
      A500A9C398008BA87D00699061003B783600387B320051A14900398E3300466F
      4700A4AF9A00C8D4BC004A794100000000000000000060606000000000005858
      5800C0FFFF00A0FFFF0088FFFF0068FFFF0048FFFF0028FFFF0010FFFF004040
      400000000000383838000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300F7F7F700333333003333330033333300333333003333330033333300F7F7
      F70033333300F7F7F700F7F7F700F7F7F700BFAE5C00E8E6B300F5F4D900F1EF
      C900E0DB9300CBC06B00BCAA5500B59E4800B1963C00B2943300B2922A00B699
      2200BBAC1A00C2A91500C8A20F00C19E160000000000306F270082A176005892
      50004B96420051A348007AC76F0062BC5300B0EA9C00C3EBAB00B8E6A3006EB9
      65003B87380079A173006A925E007E987D000000000068686800606060006060
      6000D0FFFF00B8FFFF0098FFFF0078FFFF0060FFFF0040FFFF0020FFFF004040
      400040404000383838000000000000000000F7F7F700F7F7F700F7F7F7003333
      33003333330033333300F7F7F700F7F7F700F7F7F700F7F7F700333333003333
      330033333300F7F7F700F7F7F700F7F7F700B5A35500D8D29400E0DB9F00DEDA
      9A00D1C97B00D2C46B00CEB75D00C5AC5000C4A54400C4A33900C5A02E00C7A3
      2400CDB51D00D5B61600DEB31000D9AE1800000000001F6A1C001274090058B1
      4600A2E18D00C7EFAF00D9F3C20072B25B00C4E4AF00BAE2A800BADDA600C2E0
      AE00A3D19100448F380008580600658865000000000068686800000000006060
      6000E8FFFF00C8FFFF00A8FFFF0090FFFF0070FFFF0050FFFF0038FFFF004848
      480000000000404040000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300F7F7F70033333300F7F7F700F7F7F700F7F7F700F7F7F70033333300F7F7
      F70033333300F7F7F700F7F7F700F7F7F700C7B15B00D9CF8200E6DA8500E6DB
      8500F2E183000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007D9A
      7A0062945A005D9F510073B3620051A53C007EB66D00699F5A005E955000588F
      4D00618D560074986C00769E7600000000000000000070707000686868006868
      6800F8FFFF00E0FFFF00C0FFFF00A0FFFF0088FFFF0068FFFF0048FFFF004848
      480048484800404040000000000000000000F7F7F700F7F7F700F7F7F7003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000092A992007FAB7C0087A7840098AA9800000000000000
      0000000000000000000000000000000000000000000078787800000000007070
      7000686868006868680060606000606060005858580058585800505050005050
      500000000000484848000000000000000000F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000078787800787878007070
      7000B8B8FF00A8A8FF009898FF008888FF007878FF005858FF003030FF005858
      580050505000505050000000000000000000F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008AA8D400A4BEE10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F8861002D301400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007181B3001787E900219BFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007A8369006D703D00A4966100493F30004E4E21000000
      000000000000000000000000000000000000000000005F462C005F462C005F46
      2C005F462C005F462C005F462C005F462C005F462C005F462C005F462C005F46
      2C005F462C005F462C005F462C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000336FC9001A80B9000C5CB5001268CE0000000000000000000000
      0000C0CCE2000000000000000000000000000000000000000000000000000000
      0000000000006B7140008F844F00B19A7200C0AA7C00514734007D7158006863
      310000000000000000000000000000000000000000005F462C00FBFDFB00FBFD
      FB00FBFDFB009C7449009C7449009C744900FBFDFB00FBFDFB00FBFDFB009C74
      49009C7449009C7449005F462C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007283A6001167C100274270000865B600ADCBE800000000005479
      B5000093FF00B0C8E20000000000000000000000000000000000000000007C82
      55008E855200AD986B00B49E7600B19C7000C2AD7900594F380071684F00A895
      72005F5E3300000000000000000000000000000000005F462C00FBFDFB00FBFD
      FB00FBFDFB009C7449009C7449009C744900FBFDFB00FBFDFB00FBFDFB009C74
      49009C7449009C7449005F462C00000000000000000000000000000000000000
      00000000000000000000E2E2E200D0D0D000D0D0D000E0E0E000000000000000
      00000000000000000000000000000000000000000000719AD700499AEB000000
      00000000000000000000000000007891B4000066E40098B9DC0000000000A2AB
      BE004979BE000000000000000000000000000000000000000000818649009281
      3700AD996A00B9A47900B59F7000B6A07100C8B07B0061563C00665E4600B5A4
      8100A6946E004F512F000000000000000000000000005F462C00FBFDFB00FBFD
      FB00FBFDFB009C7449009C7449009C744900FBFDFB00FBFDFB00FBFDFB009C74
      49009C7449009C7449005F462C00000000000000000000000000000000000000
      000000000000D1D1D100A0A0A00083838300818181009E9E9E00CECECE000000
      00000000000000000000000000000000000000000000346CC5000C7EF0000000
      0000000000007F96BE00635F6E000E76E7002DB7FF006B8FC800000000000000
      00000000000000000000000000000000000000000000000000008F8E5300B39A
      6C00998746009F8C4E00BDA77300BFA97600D2B982006D61440058523B008675
      51006C5A3400675627008385740000000000000000005F462C009C7449009C74
      49009C744900FBFDFB00FBFDFB00FBFDFB009C7449009C7449009C744900FBFD
      FB00FBFDFB00FBFDFB005F462C00000000000000000000000000000000000000
      0000E1E1E100A1A1A100616161003B3B3B003A3A3A005E5E5E009D9D9D00DEDE
      DE00000000000000000000000000000000000000000000000000CECED8000000
      000000000000280A1A00321828000262CA000E9CF4001A418600836162000000
      0000000000007BADE20000000000000000000000000000000000948D4E00BFA5
      7800BFA87900AD975D009E8A4500B9A26900B69B6200584F29003F3D22008372
      4D00A5956E00AA95670072735A0000000000000000005F462C009C7449009C74
      49009C744900FBFDFB00FBFDFB00FBFDFB009C7449009C7449009C744900FBFD
      FB00FBFDFB00FBFDFB005F462C00000000000000000000000000000000000000
      0000D0D0D000818181003C3C3C001414140013131300383838007E7E7E00CDCD
      CD00000000000000000000000000000000005E92CF002C91E6008AACDC000000
      0000A7A09B003F151900662D32004E2F4600463B68007129290064140E00A8AB
      B4004B6BA3000066DF00AFC2E1000000000000000000000000009D8E5100C3AA
      7800C0A97200C6AC7900C3AA7400A18A4500AA8F5100766C3F0059593D00B8A7
      8400A9987300AD976C006B67410000000000000000005F462C009C7449009C74
      49009C744900FBFDFB00FBFDFB00FBFDFB009C7449009C7449009C744900FBFD
      FB00FBFDFB00FBFDFB005F462C00000000000000000000000000000000000000
      0000D1D1D100818181003A3A3A001313130012121200373737007E7E7E00CBCB
      CB0000000000000000000000000000000000015AC100068CE9000051C3003D9B
      D90046496300441B23006B2C2F006D3B47002B67BA001F6FCE002B448600041F
      53000366C40024ADF60085AFE400000000000000000000000000AA965900C8AC
      7700C5AC7300C7AC7300CCB27B00B39B5800DEC280009C8E59004E503300B5A3
      8000A7967200B6A075006C65390000000000000000005F462C00FBFDFB00FBFD
      FB00FBFDFB009C7449009C7449009C744900FBFDFB00FBFDFB00FBFDFB009C74
      49009C7449009C7449005F462C00000000000000000000000000000000000000
      0000E0E0E0009E9E9E005E5E5E0039393900373737005B5B5B009A9A9A00DDDD
      DD0000000000000000000000000000000000C9CAD500BAC0D10095A8BD000051
      B3000D93F700176BBA0066211C00192657001295FF002BC4FF0023ABFF000E82
      E7000350B8001F8EF700729CDB00BCB7BC00000000007C825D00BAA26300CBB1
      7700CDB37700D7BB7D00DCBD8000B79A5400B29862006A663C0040482C00B19E
      8200B5A27D00B9A57C00796E3B0000000000000000005F462C00FBFDFB00FBFD
      FB00FBFDFB009C7449009C7449009C744900FBFDFB00FBFDFB00FBFDFB009C74
      49009C7449009C7449005F462C00000000000000000000000000000000000000
      000000000000CFCFCF009D9D9D007E7E7E007C7C7C009B9B9B00CCCCCC000000
      0000000000000000000000000000000000000000000000000000000000001D51
      AE0028BAFF00077EE10037162400391C25000852AD000567DC001995F300227E
      DD00A4A7B300A5B0C80000000000000000000000000075794C00D7B87500DBBC
      8000C9AC7300A68F5D007A74490064683E006A753E0095975100949650004A54
      2F0090846800C6AF89008C7C490000000000000000005F462C00FBFDFB00FBFD
      FB00FBFDFB009C7449009C7449009C744900FBFDFB00FBFDFB00FBFDFB009C74
      49009C7449009C7449005F462C00000000000000000000000000000000000000
      00000000000000000000DEDEDE00CDCDCD00CCCCCC00DCDCDC00000000000000
      0000000000000000000000000000000000000000000000000000000000009EA3
      B5002158B70094A7C50077625700401A13002A1010001A2C4900003A8C00055E
      C20087B6E7000000000000000000000000000000000065623300988453007B79
      4600747A430090924F00C9C06E00CBB75C00EECE7A00FCD68500F5D18300CDBA
      6B00787F43007878520099885700898A6C00000000005F462C009C7449009C74
      49009C744900FBFDFB00FBFDFB00FBFDFB009C7449009C7449009C744900FBFD
      FB00FBFDFB00FBFDFB005F462C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004585D50090ABCB00000000007296C3000031960022A4
      F3001393FF00000000000000000000000000000000005A65370061671D00BAA8
      4300F5D07500FFD58900FFD78E00D2AF5900E6C47700ECCA8500E9C78100EEC7
      8200EBC87D00A295490052551500686D4F00000000005F462C009C7449009C74
      49009C744900FBFDFB00FBFDFB00FBFDFB009C7449009C7449009C744900FBFD
      FB00FBFDFB00FBFDFB005F462C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004165AA001FBCFF001B83F600BDC9E200000000009EA1B2002159
      AB004C7ECA000000000000000000000000000000000000000000000000000000
      00008F8A58009F934900B9A15400BB9E4300C4A65800B3995200A08C47009287
      46008B864B00958E60009497750000000000000000005F462C009C7449009C74
      49009C744900FBFDFB00FBFDFB00FBFDFB009C7449009C7449009C744900FBFD
      FB00FBFDFB00FBFDFB005F462C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008090A9000754C4000F79DC001885EC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A1A27700A0A17C0000000000000000000000
      000000000000000000000000000000000000000000005F462C005F462C005F46
      2C005F462C005F462C005F462C005F462C005F462C005F462C005F462C005F46
      2C005F462C005F462C005F462C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000038548C00376FBA00A0B8D90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFF0000FFFFFFFFFE1F0000
      FFFFFFFFF80F0000FFFFFC7FF0070000F00FF83FC0030000F00FF00FC0030000
      F00FC38780010000F00F87C380010000F00F8FE180010000F00FC7E180010000
      F00FE1C380010000F00FF00F80010000FFFFF81F80010000FFFFFC3FE0010000
      FFFFFFFFFC3F0000FFFFFFFFFFFF0000FFFFFFFFFE7FFFFFFFFFFF04F81FFF1F
      C003FE00E007FE1FC003FE008001F00FC003F0008001C187C003F00080018803
      C003F0008001C001C003F0008001D081C003F00080018001C003E00380018291
      C003C00780019001C00380078001B001C003007F80010000C00301FFE0030000
      C00303FFF80F2000FFFF8FFFFE3FF44F8000FFFFFFFFFFFF000087FFFFFFFFFF
      000003FFFFFFFE7F000003FFFFFFFC3F000001FFC003F00F0000807FC003E187
      0000FE01C40380010000FF00C4070C300000FFC0C4030C300000FF8000038001
      0000C00103C7E1870000807F03C7F00F000001FFFFFFFC3F000003FFFFFFFE7F
      000087FFFFFFFFFF0000CFFFFFFFFFFFFFFFFFFFFE3F0000F01FFF1FF81F0000
      C007FC0FF00F00000001F00FE00700000201C003C00100000001800380010000
      00018001800100010001800180018003000180018001C007400180008000E003
      028100000000C003000100000000C003000100000800C003000300000000C003
      E1870000C001C003F81FF007FC1FC003FFFFFFFFFFFFFFFFFF1FFE00FE00FC07
      FC0FF000F000F803F007E000E000F0038003C000C00000010003C000C0000001
      00018001800100010000800F800F0000000080FF80FF0000800180FF80FF0000
      E00300FF00FF0001F00700FF00FF0003F80F01FF01FF0003F81F01FF01FF0087
      FC3F81FF81FFFF87FE3FFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFF81FFFFFFFFFF
      8001C0FFE3FFF00F80010009C1FFE00780010001C1FFC00380010001C0FFC001
      80010001803F800180010001800180018001000DC00180018001820FFE018001
      8001000FFF81800180010007FFC3C00380010007FFC3C0038001000FFFC7E007
      8001820FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFBFA00B0000FFFFFE1F80030000
      0000F80FA00B00000000F007800300000000C003A00B00000000C00380030000
      00008001A00B0000000080018003000000008001A00B00000000800180030000
      00008001A00B0000000080008003000000008000A00B000007FFE00180030000
      FFFFFC3FA00B0000FFFFFFFF80030000FFFFFE7FFF3FFFFFFFFFFC7FFC1F8001
      FFFFF877F80F8001FFFFF823E0078001FC3F9E27C0038001F81F983FC0018001
      F00FD81BC0018001F00F1001C0018001F00F0001C0018001F00F000080018001
      F81FE00380018001FC3FE00780008001FFFFFC8780008001FFFFF847F0018001
      FFFFF87FFE7F8001FFFFFC7FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList1: TImageList
    Height = 15
    Left = 889
    Top = 111
    Bitmap = {
      494C010111001300040010000F00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004B0000000100200000000000004B
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C8C8C008E8E8E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AEAEAE00585858000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006969690000000000FFFFFF00767676000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AEAEAE00B8B8B800BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000040404000000000001414140000000000FFFFFF007D7D7D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003D3D3D003B3B3B00E4E4E400B5B5B500FFFFFF0019191900898989000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000383838002F2F2F00E2E2E200FFFFFF00FFFFFF00FFFFFF00CCCCCC002525
      2500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B3B3B003B3B3B00E2E2E200FFFFFF00FFFFFF00FFFFFF00474747000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003838380036363600F5F5F500FFFFFF00FFFFFF006C6C6C00C2C2C2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B3B3B002F2F2F00FFFFFF00FFFFFF00B3B3B30091919100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003636360031313100FFFFFF00DFDFDF006767670000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002F2F2F004E4E4E00FFFFFF003D3D3D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002C2C2C006060600042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000696969000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000500
      0000000000000000000000000000311919000500000000000000000000000000
      00000000000000000000000000000000000000000000787676003B3B3B000000
      000000000000000000003D3B3B00828080000000000000000000605B5B005858
      5800000000000000000000000000000000000000000000000000000000000000
      000038383800000000000000000000000000514E4E005D5B5B00535353004C4A
      4A00404040000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000020000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000700000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000087828200000000000000
      00000000000000000000000000007B7878000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000534A
      4A00000000002C27270000000000000000000000000000000000000000000000
      0000000000002A25250000000000000000000000000000000000000000000000
      00000000000000000000000000002A1616000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003D252500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000534747000000
      0000000000000A000000312A2A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007369
      6900000000004242420000000000000000006556560000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000604C4C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A3636000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002211
      11005B4545000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003B2F
      2F002F16160000000000000000000000000000000000584A4A00000000001D1D
      1D00000000000000000000000000000000000000000000000000000000000000
      000000000000000000007D656500000000005640400000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000110000005B45450000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002A16
      16001B0505000200000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000696565002005
      05001400000011020200696969000000000000000000000000006C5D5D000000
      0000161616000000000000000000000000000000000000000000000000000000
      00002F272700452C2C006953530000000000220F0F0056424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000362020004E363600000000000000
      0000000000000000000000000000000000000000000000000000271414000F00
      000065626200765D5D0000000000000000002C222200000000005B5656008980
      8000000000001B161600000000000000000000000000B3B3B3001D0505000700
      000000000000765D5D000000000000000000271D1D0000000000000000000000
      000000000000696969000000000000000000000000000000000000000000B3B5
      B50000000000D0BABA0000000000000000006C6565002F1B1B00140000000707
      0700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001B050500332020000000
      0000000000000000000000000000000000000000000089848400362727005B56
      560000000000918989003325250040404000271919003D313100000000000000
      0000382A2A0000000000000000000000000000000000564C4C00312020007B76
      7600000000009D939300382A2A00514E4E00564747002C1D1D00251B1B00271B
      1B00110000008782820000000000000000000000000000000000000000000000
      0000846969001B0707006C6C6C0000000000000000000A000000220A0A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003B2525002A141400200A0A001100000000000000220A0A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000605B5B001D0F0F0027141400514040006C6262009D9A
      9A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000022191900563D3D004733330000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000878484000000000000000000270F0F0067535300C7AEAE00FFFFFF00E2CC
      CC007D6E6E000000000000000000000000000000000000000000D3D3D3005153
      AC004C4EBA004C4EB8004C4EB8004A4CBA006062A20078786E00787678007171
      7100898989000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006C67670000000000B39D9D00E4CCCC0042363600000000000000
      000000000000000000000000000000000000000000000000000000000000938E
      8E0000000000050000000000000000000000000000000000000036252500FFFF
      FF00FFFFFF0062535300000000000000000000000000000000007173AC000000
      FF00B59AFF009F8CFF009D87FF00AE96FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B3333000000000000000000000000000000000000000000000000000000
      000000000000625B5B004E454500311D1D0033272700362C2C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001B0505000000000000000000000000000000000000000000000000000000
      0000F0DADA009A8282006E676700000000000000000000000000696EB8008C78
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003633FF002A16140033201D002207
      0700000000000000000000000000000000000000000000000000000000008E87
      8700000000000000000000000000000000006565650000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B76
      7600696060000000000000000000000000000000000000000000000000002F25
      250000000000000000000000000000000000000000000000000078717100331D
      1D001D0A0A000000000000000000000000000000000000000000000000002527
      2700000000009D87870014000000000000000000000000000000676CB1008973
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003131FF00422A2A004A312F002A11
      1400020000000000000000000000000000000000000000000000000000000000
      0000160707000A00000000000000141414000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001B1111000000
      000051454500000000000000000000000000000000000000000000000000200C
      0C003622220000000000000000000000000000000000000000004E424200AE96
      9600000000000000000000000000000000000000000000000000000000000000
      0000000000002A141400000000000000000000000000000000006265A9008478
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3BFF005D47450053424000361D
      1D00050000000000000000000000000000000000000000000000000000000000
      000000000000000000004A313100000000000500000000000000403B3B000000
      000000000000000000000000000000000000D0D0D00000000000000000004A33
      3300000000000000000000000000000000000000000000000000000000004531
      3100624A4A00000000006E656500000000000000000000000000695D5D00FAE2
      E200000000000000000000000000000000000000000000000000000000000000
      00000200000000000000000000000000000000000000000000006565B1008787
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003D3BFF00624A4C00604A4A003B20
      2200070000000000000000000000000000000000000000000000000000000000
      000000000000827D7D0002000000624E4E00311B1B0000000000000000000000
      000000000000000000000000000000000000000000006762620000000000452C
      2C00221414000000000000000000000000000000000000000000000000000F00
      0000000000002A2020000000000000000000000000000000000073626200FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008284A4000000
      FF006E67FF006562FF005B56FF005651FF000C05FF007B625600604A4A003B22
      25000A0000000000000000000000000000000000000000000000000000000000
      00000000000025202000402A2A00312020004C36360000000000000000000000
      0000000000000000000000000000000000000000000000000000B3B1B1000000
      0000382F2F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000675D5D00FFE9
      E900695353000000000000000000605B5B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008E8E87005640
      2A0098807600A4897D009F897D0096807100967D67007D676500534040003B20
      2000050000000000000000000000000000000000000000000000000000000000
      00008E8E8E0000000000A7919100000000002F1B1B002A161600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9A9A00694E
      4E00AC9696002711110047333300140C0C000000000000000000000000002F2C
      2C0000000000000000000C0000000000000000000000000000008C8989005842
      4200988282009A848400988484008E7B7B00846E6E00675153004C3636003119
      1900020000000000000000000000000000000000000000000000000000000000
      000000000000CEB5B50000000000000000004C404000563D3D00000000005356
      5600000000000000000000000000000000000000000000000000000000000000
      0000000000001B1414000500000047333300220A0A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002F25
      25003D2525005D45450014000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000828787004A31
      31009376780091767600896E7100806969006C565600563D3D00382222001D02
      020000000000000000000000000000000000000000000000000000000000110C
      0C002A1414005D4040000F050500000000000000000000000000200707000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D5D8D800000000002C16160000000000847D7D00000000000000
      0000000000000000000000000000000000000000000000000000A9A9A9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A2A4A4000A02
      02002F2727002C2525002A2222002A202000201919001B1414000F0A0A000000
      00001B1919000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000089878700000000002F20200000000000000000000000
      0000000000000000000000000000000000000000000000000000847B7B002014
      1400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000625D5D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000FFFFFF000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000000000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF008080
      8000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000008000FFFFFF00FFFFFF00FFFFFF0000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000800000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000008080800000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      80000000800000008000FFFFFF00FFFFFF00FFFFFF0000008000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      00008000000000000000FFFFFF00800000008080800000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000808080000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000FFFFFF000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      000000000000FFFFFF0000000000800000000000000080808000000000008000
      0000000000000000000000000000000000000000000093919100565353005B58
      58004E4C4C00514E4E00514E4E0087828200403D3D0000000000000000000000
      00004242420065626200000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000000000008080800000000000FFFFFF0080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000FFFFFF000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000FFFFFF0000000000FFFFFF00800000008080800000000000808080000000
      0000800000000000000000000000000000000000000022161600000000000000
      00000200000000000000000000006E6767000000000000000000000000000000
      000000000000514C4C000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000FFFFFF0000000000FFFFFF00000000008080
      8000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000008000000000000000800000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF0000000000FFFFFF0000000000800000000000000080808000000000008080
      80008000000000000000000000000000000000000000000000000A0000000000
      0000767676000000000000000000000000008980800000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF008080800000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF00800000008080800000000000808080000000
      0000808080008000000000000000000000000000000000000000000000002C19
      1900000000008484840000000000000000000000000025161600000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000FFFFFF0000000000FFFFFF00000000008080
      8000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000080808000000000008080800000000000000000000000
      000000000000000000000000000000000000000000008000000000000000FFFF
      FF00000000008000000080000000FFFFFF008000000080000000000000008080
      8000000000008000000000000000000000000000000000000000000000000000
      0000654E4E000000000089898900000000000000000000000000000000000000
      00006769690000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000000000008080800000000000FFFFFF0080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000080000000000000008000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000008000
      0000808080008000000000000000000000000000000000000000000000001D16
      1600000000006C565600000000000000000000000000000000007B7676001D07
      070000000000C2C4C4000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000808080000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000800000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF008000000000000000800000000000000000000000000000002F2222005647
      470062565600766565004C454500878080001D0C0C0060565600000000009189
      8900000000005B585800000000000000000000000000FFFFFF0000000000FFFF
      FF00000000008080800000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF008080
      8000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000800000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      0000800000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000FFFFFF008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FF00000080808000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000FF000000808080000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000008000
      0000000000000000000000000000000000000000000000000000808080000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      000080808000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000000000
      0000800000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080808000FFFFFF000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000FFFF
      FF0000000000800000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000808080000000000080808000000000000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000000000
      0000FFFFFF008000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000080808000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000800000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000FFFF
      FF000000000080000000000000000000000000000000FFFFFF00000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000808080000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0080808000000000000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000000000
      0000FFFFFF008000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080000000FFFF
      FF00000000008000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF00000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000FFFFFF008000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF0000000000FFFFFF000000
      00000000000080808000FFFFFF00000000000000000000000000000000008080
      8000000000000000000080000000000000000000000000000000808080000000
      000000000000000000000000000000000000000000008000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008000
      000000000000800000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000008000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008000
      0000000000000000000000000000000000008000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000808080000000000000000000FFFFFF000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000400000004B0000000100010000000000580200000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FF3F000000000000
      FF1F000000000000FE1F000000000000FE1F000000000000F03F000000000000
      F01F000000000000F00F000000000000F01F000000000000F01F000000000000
      F03F000000000000F07F000000000000F0FF000000000000F1FF000000000000
      F3FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FC7FE00FFFFFFFFFFC7FE00F9CCFF707FC7FF1FF88CFE303FC7FF8FFC1CFE31F
      FC3FFC7FE3CFE38FF83FFE3FE387C1C7F01FFF1FC1038903E10FF00F88338803
      E18FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFEFFFC0FFFFFFFFFFC7FF007C007FFFFF83FE003C007E387
      F83FE1C1C007E10FE6EFC3E1C007F01FC6E7C7F1C007F81F0001C7F1C007F83F
      86E3C7F1C007F83FC6EFC0F1C007F01FFEFFC0E1C007F10FF83FE0F3C007E18F
      F83FC0FFC007FFFFFC7FC0FFFFFFFFFFFEFFFFFFFFFFFFFF1FFFFEFFFEFFFFFF
      87FFFC7FFD7FFFFF41FFF83FFABFFFFFA87FE00FF45FFFFF541FFC7FEAAF8073
      A907FC7FD457802352A1FD7FCAA7C707A150FFFF9453E38F52A10000A82BF187
      A907FC7FA003C103541FFEFF4005C023A87FFEFF0001FFFF41FFF83F0001FFFF
      87FFFC7FF01FFFFF1FFFFEFFFEFFFFFFFFFB1FF8F9571FFFFFF17FFEF2A73FFF
      FFE1401EE553587FFFC3C00FDAABE79FFF87C017D555E7DFF00FC00BAAA9DBED
      CE1FC0135555DC00D8BFC00B22AADDEDBE1FC0139554DDEFBF5FC00BE8A2EDDF
      AFDFC013E510E59FA7DFE00BC8A5F87FD1BF7002D917FDFFCF3F7802E48FF8FF
      F0FF1FF8FE7FFDFF00000000000000000000000000000000000000000000}
  end
  object LoadTimer: TTimer
    Enabled = False
    Interval = 30
    OnTimer = LoadTimerTimer
    Left = 415
    Top = 9
  end
  object MainMenu1: TMainMenu
    Left = 261
    Top = 15
    object File1: TMenuItem
      Caption = 'File'
      object ButOpenBSP: TMenuItem
        Caption = 'Open BSP...'
        ShortCut = 16463
        OnClick = ButOpenBSPClick
      end
      object ButAddBSP: TMenuItem
        Caption = 'Add BSP...'
        Enabled = False
        ShortCut = 16452
        OnClick = ButAddBSPClick
      end
      object ButSaveBSP: TMenuItem
        Caption = 'Save Bsp...'
        Enabled = False
        ShortCut = 16467
        OnClick = ButSaveBSPClick
      end
      object BtnCreateTemplate1: TMenuItem
        Caption = 'Create Template..'
        ShortCut = 16468
        OnClick = BtnCreateTemplate1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Quit'
        OnClick = Exit1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object LightsPoint: TMenuItem
        AutoCheck = True
        Caption = 'Lights Point'
        ImageIndex = 25
        ShortCut = 16460
        OnClick = ShowChunkClick
      end
      object ShowLight: TMenuItem
        AutoCheck = True
        Caption = 'Light Map'
        ShortCut = 16461
        OnClick = RedrawClick
      end
      object Emitters: TMenuItem
        AutoCheck = True
        Caption = 'Emitters'
        ShortCut = 16453
        OnClick = ShowChunkClick
      end
      object NullNodes: TMenuItem
        AutoCheck = True
        Caption = 'Null Nodes'
        ShortCut = 16462
        OnClick = ShowChunkClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object WardZone: TMenuItem
        AutoCheck = True
        Caption = 'Ward Zone'
        ShortCut = 16471
        OnClick = ShowChunkClick
      end
      object NgonBSP: TMenuItem
        AutoCheck = True
        Caption = 'NgonBSP'
        ShortCut = 16450
        OnClick = ShowChunkClick
      end
      object Collisions: TMenuItem
        AutoCheck = True
        Caption = 'Collisions'
        OnClick = ShowChunkClick
      end
      object MirrorObj: TMenuItem
        AutoCheck = True
        Caption = 'Mirror Objects'
        OnClick = ShowChunkClick
      end
      object Icelayer: TMenuItem
        AutoCheck = True
        Caption = 'Ice layer'
        ShortCut = 16457
        OnClick = ShowChunkClick
      end
    end
    object Render1: TMenuItem
      Caption = 'Render'
      object ShowGrid: TMenuItem
        AutoCheck = True
        Caption = 'Show Grid'
        Checked = True
        ImageIndex = 24
        ShortCut = 16455
        OnClick = ShowGridClick
      end
      object DrawBones: TMenuItem
        AutoCheck = True
        Caption = 'Draw Bones'
        ImageIndex = 10
        ShortCut = 16450
        OnClick = RedrawClick
      end
      object WpNames: TMenuItem
        AutoCheck = True
        Caption = 'Wp Names'
        Checked = True
      end
      object DrawBoxes: TMenuItem
        AutoCheck = True
        Caption = 'Bound Boxes'
        ImageIndex = 17
        OnClick = RedrawClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Floors1: TMenuItem
        Caption = 'Floors'
        Enabled = False
        object AllFloors: TMenuItem
          Tag = -1
          AutoCheck = True
          Caption = 'All Floors'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor11: TMenuItem
          AutoCheck = True
          Caption = 'Floor 1'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor21: TMenuItem
          Tag = 1
          AutoCheck = True
          Caption = 'Floor 2'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor31: TMenuItem
          Tag = 2
          AutoCheck = True
          Caption = 'Floor 3'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor41: TMenuItem
          Tag = 3
          AutoCheck = True
          Caption = 'Floor 4'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor51: TMenuItem
          Tag = 4
          AutoCheck = True
          Caption = 'Floor 5'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor61: TMenuItem
          Tag = 5
          AutoCheck = True
          Caption = 'Floor 6'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor71: TMenuItem
          Tag = 6
          AutoCheck = True
          Caption = 'Floor 7'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
        object Floor81: TMenuItem
          Tag = 7
          AutoCheck = True
          Caption = 'Floor 8'
          GroupIndex = 1
          RadioItem = True
          OnClick = Floor81Click
        end
      end
      object FloorUp: TMenuItem
        Caption = 'Floor Up'
        Enabled = False
        OnClick = FloorUpClick
      end
      object FloorDown: TMenuItem
        Caption = 'Floor Down'
        Enabled = False
        OnClick = FloorDownClick
      end
    end
    object Options1: TMenuItem
      Caption = 'Options'
      object Settings1: TMenuItem
        Caption = 'Settings...'
        OnClick = Settings1Click
      end
    end
  end
end
