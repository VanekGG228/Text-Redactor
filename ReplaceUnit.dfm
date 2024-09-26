object ReplaceForm: TReplaceForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ReplaceForm'
  ClientHeight = 206
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 15
    Width = 45
    Height = 19
    Caption = #1053#1072#1081#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 87
    Width = 106
    Height = 19
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1085#1072'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object FindEditRep: TEdit
    Left = 56
    Top = 40
    Width = 433
    Height = 21
    TabOrder = 0
  end
  object ReplaceEdit: TEdit
    Left = 56
    Top = 112
    Width = 433
    Height = 21
    TabOrder = 1
  end
  object SelTExtCheckBox: TCheckBox
    Left = 56
    Top = 150
    Width = 249
    Height = 17
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072
    TabOrder = 2
  end
  object ReplaceButton: TButton
    Left = 440
    Top = 173
    Width = 75
    Height = 25
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = ReplaceButtonClick
  end
end
