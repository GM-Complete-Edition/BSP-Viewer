object SettingsForm: TSettingsForm
  Left = 628
  Top = 299
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 97
  ClientWidth = 446
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
  object SaveBSPOpt: TGroupBox
    Left = 6
    Top = 2
    Width = 434
    Height = 56
    Caption = 'Save BSP file'
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 25
      Width = 103
      Height = 13
      Caption = 'Compression BSP file:'
    end
    object ComprOpt: TComboBox
      Left = 127
      Top = 22
      Width = 99
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'None'
      Items.Strings = (
        'None'
        'Default'
        'Fast'
        'Max')
    end
  end
  object Button1: TButton
    Left = 287
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Apply'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 365
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
