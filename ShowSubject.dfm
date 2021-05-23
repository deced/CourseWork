object ShowSubjectForm: TShowSubjectForm
  Left = 0
  Top = 0
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1072#1088#1099
  ClientHeight = 305
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  DesignSize = (
    568
    305)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 180
    Height = 180
    Stretch = True
  end
  object TutorLabel: TLabel
    Left = 8
    Top = 193
    Width = 177
    Height = 50
    Anchors = [akLeft, akTop, akBottom]
    Caption = #1044#1072#1085#1080#1083#1086#1074#1072' '#1043#1072#1083#1080#1085#1072' '#1042#1083#1072#1076#1080#1084#1080#1088#1086#1074#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 198
    Top = 10
    Width = 227
    Height = 25
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1080#1089#1087#1080#1087#1083#1080#1085#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 198
    Top = 50
    Width = 127
    Height = 25
    Caption = #1058#1080#1087' '#1079#1072#1085#1103#1090#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 198
    Top = 90
    Width = 134
    Height = 25
    Caption = #1053#1072#1095#1072#1083#1086' '#1087#1072#1088#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 198
    Top = 130
    Width = 123
    Height = 25
    Caption = #1050#1086#1085#1077#1094' '#1087#1072#1088#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 198
    Top = 170
    Width = 75
    Height = 25
    Caption = #1043#1088#1091#1087#1087#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 198
    Top = 210
    Width = 110
    Height = 25
    Caption = #1040#1091#1076#1080#1090#1086#1088#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SubjectNameEdit: TEdit
    Left = 431
    Top = 8
    Width = 129
    Height = 33
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object StartTimeEdit: TEdit
    Left = 338
    Top = 90
    Width = 222
    Height = 33
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object EndTimeEdit: TEdit
    Left = 338
    Top = 130
    Width = 222
    Height = 33
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object GroupEdit: TEdit
    Left = 338
    Top = 170
    Width = 222
    Height = 33
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object SubjectTypeComboBox: TComboBox
    Left = 338
    Top = 50
    Width = 222
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Items.Strings = (
      #1051#1050#11
      #1055#1047#11
      #1051#1056)
  end
  object AuditoryEdit: TEdit
    Left = 338
    Top = 210
    Width = 222
    Height = 33
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object SaveButton: TButton
    Left = 187
    Top = 257
    Width = 169
    Height = 36
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Visible = False
    OnClick = SaveButtonClick
  end
  object CancelButton: TButton
    Left = 392
    Top = 257
    Width = 168
    Height = 36
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
end
