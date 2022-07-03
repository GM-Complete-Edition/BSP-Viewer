object AddEntities: TAddEntities
  Left = 404
  Top = 234
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Entities'
  ClientHeight = 97
  ClientWidth = 361
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
  object SelectChunkOpt: TGroupBox
    Left = 6
    Top = 2
    Width = 347
    Height = 56
    Caption = 'Select Entities'
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 25
      Width = 39
      Height = 13
      Caption = 'Entities:'
    end
    object cbb1: TCheckComboBox
      Left = 64
      Top = 22
      Width = 265
      Height = 22
      AutoComplete = False
      ItemHeight = 16
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 199
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Apply'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 277
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
