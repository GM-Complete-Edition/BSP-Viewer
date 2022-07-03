object DAEImportForm: TDAEImportForm
  Left = 686
  Top = 446
  BorderStyle = bsSingle
  Caption = 'COLLADA 1.4.1 Import options'
  ClientHeight = 128
  ClientWidth = 343
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
  object AnimOpt: TGroupBox
    Left = 8
    Top = 8
    Width = 326
    Height = 78
    Caption = 'Clip Setting'
    TabOrder = 0
    object ClipLabel: TLabel
      Left = 8
      Top = 20
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object Label1: TLabel
      Left = 8
      Top = 51
      Width = 64
      Height = 13
      Caption = 'BSP Anim Lib:'
    end
    object ClipOpt: TComboBox
      Left = 183
      Top = 16
      Width = 131
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Add Clip'
      Items.Strings = (
        'Add Clip'
        'Replace Clip')
    end
    object ClipName: TEdit
      Left = 40
      Top = 17
      Width = 131
      Height = 21
      TabOrder = 1
      Text = 'New Clip'
    end
    object OutAnimDictionary: TComboBox
      Left = 74
      Top = 47
      Width = 240
      Height = 21
      AutoDropDown = True
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 135
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
end
