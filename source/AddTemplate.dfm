object TemplateForm: TTemplateForm
  Left = 428
  Top = 306
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Templates'
  ClientHeight = 95
  ClientWidth = 249
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
    Width = 235
    Height = 56
    Caption = 'Select Template Type'
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 25
      Width = 75
      Height = 13
      Caption = 'Template Type:'
    end
    object ComprOpt: TComboBox
      Left = 103
      Top = 22
      Width = 114
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Character'
      Items.Strings = (
        'Character'
        'Animation')
    end
  end
  object Button1: TButton
    Left = 87
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Apply'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 165
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
