object DAEExportForm: TDAEExportForm
  Left = 318
  Top = 204
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'COLLADA 1.4.1 Export options'
  ClientHeight = 209
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 255
    Top = 175
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object grpPresets: TGroupBox
    Left = 16
    Top = 8
    Width = 321
    Height = 49
    Caption = 'Presets'
    TabOrder = 1
    object lbl1: TLabel
      Left = 32
      Top = 20
      Width = 75
      Height = 13
      Caption = 'Current Preset:'
    end
  end
  object CBExportOptions: TComboBox
    Left = 136
    Top = 24
    Width = 193
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = '3ds Max (OpenCollada)'
    OnChange = CBExportOptionsChange
    Items.Strings = (
      '3ds Max (OpenCollada)'
      'Blender')
  end
  object grp1: TGroupBox
    Left = 16
    Top = 64
    Width = 321
    Height = 105
    Caption = 'Options'
    TabOrder = 3
    object lbl2: TLabel
      Left = 8
      Top = 24
      Width = 40
      Height = 13
      Caption = 'Up Axis:'
    end
    object lbl3: TLabel
      Left = 152
      Top = 24
      Width = 63
      Height = 13
      Caption = 'Scale Factor:'
    end
    object ExportClips: TCheckBox
      Left = 8
      Top = 48
      Width = 129
      Height = 17
      Caption = 'Export All Clips'
      Enabled = False
      TabOrder = 0
    end
    object CGopt: TCheckBox
      Left = 208
      Top = 48
      Width = 110
      Height = 17
      Caption = 'Export CG Profile'
      TabOrder = 1
    end
    object CBAxis: TComboBox
      Left = 56
      Top = 20
      Width = 89
      Height = 21
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 2
      Text = 'Z-UP'
      Items.Strings = (
        'Y-UP'
        'Z-UP')
    end
    object edtScale: TFloatSpinEdit
      Left = 224
      Top = 20
      Width = 89
      Height = 22
      Increment = 1.000000000000000000
      MaxLength = 4
      MaxValue = 100.000000000000000000
      TabOrder = 3
      Value = 0.025400000000000000
    end
    object ConvertDummies: TCheckBox
      Left = 8
      Top = 72
      Width = 153
      Height = 17
      Caption = 'Convert Dummies as Bones'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
end
