object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 640
  ClientWidth = 1507
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
  object WeekNumberLabel: TLabel
    Left = 264
    Top = 8
    Width = 89
    Height = 13
    Caption = #1058#1077#1082#1091#1097#1072#1103' '#1085#1077#1076#1077#1083#1103':'
  end
  object Label2: TLabel
    Left = 25
    Top = 10
    Width = 123
    Height = 13
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1103
  end
  object DayLabel: TLabel
    Left = 264
    Top = 59
    Width = 84
    Height = 25
    Caption = 'DayLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 18
    Top = 89
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
  object Button2: TButton
    Left = 20
    Top = 56
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 0
    OnClick = Button2Click
  end
  object SearchList: TComboBox
    Left = 20
    Top = 29
    Width = 215
    Height = 21
    Style = csSimple
    TabOrder = 1
  end
  object Button3: TButton
    Left = 480
    Top = 494
    Width = 75
    Height = 25
    Caption = #1053#1072#1079#1072#1076
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button5: TButton
    Left = 848
    Top = 494
    Width = 75
    Height = 25
    Caption = #1042#1087#1077#1088#1105#1076
    TabOrder = 3
    OnClick = Button5Click
  end
  object ScrollBox: TScrollBox
    Left = 409
    Top = 29
    Width = 595
    Height = 459
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 4
  end
  object SchedulesScrollBox: TScrollBox
    Left = 20
    Top = 120
    Width = 309
    Height = 501
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 5
  end
  object MainMenu: TMainMenu
    Left = 744
    Top = 328
    object N1: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    end
    object N2: TMenuItem
      Caption = #1054#1073' '#1072#1074#1090#1086#1088#1077
    end
  end
end
