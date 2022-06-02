object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1103' '#1087#1072#1088' '#1041#1043#1059#1048#1056
  ClientHeight = 629
  ClientWidth = 1062
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DayLabel: TLabel
    Left = 450
    Top = 3
    Width = 595
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = -1
    Width = 250
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1105#1085#1085#1099#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BevelDate: TBevel
    Left = 450
    Top = 3
    Width = 600
    Height = 30
  end
  object AddScheduleButton: TButton
    Left = 352
    Top = 30
    Width = 92
    Height = 29
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = AddScheduleButtonClick
  end
  object PrevButton: TButton
    Left = 450
    Top = 576
    Width = 117
    Height = 35
    Caption = #1053#1072#1079#1072#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = PrevButtonClick
  end
  object NextButton: TButton
    Left = 935
    Top = 576
    Width = 117
    Height = 35
    Caption = #1042#1087#1077#1088#1105#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = NextButtonClick
  end
  object ScrollBox: TScrollBox
    Left = 450
    Top = 39
    Width = 600
    Height = 531
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 3
    object NoSubjectsLabel: TLabel
      Left = 0
      Top = 256
      Width = 600
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #1042' '#1101#1090#1086#1090' '#1076#1077#1085#1100' '#1085#1077#1090' '#1079#1072#1085#1103#1090#1080#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object SchedulesScrollBox: TScrollBox
    Left = 8
    Top = 66
    Width = 436
    Height = 545
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 4
    OnMouseWheelDown = SchedulesScrollBoxMouseWheelDown
    OnMouseWheelUp = SchedulesScrollBoxMouseWheelUp
    object SchedulesEmptyLabel: TLabel
      Left = 0
      Top = 248
      Width = 436
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #1057#1087#1080#1089#1086#1082' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1081' '#1087#1091#1089#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object SearchBox: TComboBox
    Left = 8
    Top = 30
    Width = 338
    Height = 29
    ParentCustomHint = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 5
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1092#1072#1084#1080#1083#1080#1102' '#1080#1083#1080' '#1085#1086#1084#1077#1088' '#1075#1088#1091#1087#1087#1099
  end
  object MainMenu: TMainMenu
    Left = 368
    object N3: TMenuItem
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077' '#1072#1091#1076#1080#1090#1086#1088#1080#1081
      Enabled = False
      OnClick = N3Click
    end
    object N1: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    end
    object N2: TMenuItem
      Caption = #1054#1073' '#1072#1074#1090#1086#1088#1077
    end
  end
  object IHATEDELPHIPOPUPS: TPopupMenu
    Left = 320
    Top = 120
  end
end
