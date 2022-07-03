object AnimSpeed: TAnimSpeed
  Left = 749
  Top = 183
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Change Anim Speed'
  ClientHeight = 93
  ClientWidth = 289
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
    Width = 275
    Height = 56
    Caption = 'Select Chunk'
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 25
      Width = 60
      Height = 13
      Caption = 'Anim Speed:'
    end
    object edt1: TFloatSpinEdit
      Left = 88
      Top = 22
      Width = 121
      Height = 22
      Increment = 0.100000000000000000
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 127
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Apply'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 205
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
