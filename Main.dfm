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
  object Label3: TLabel
    Left = 25
    Top = 85
    Width = 113
    Height = 13
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077
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
  object SchedulesList: TComboBox
    Left = 20
    Top = 104
    Width = 145
    Height = 21
    TabOrder = 2
  end
  object Button4: TButton
    Left = 20
    Top = 131
    Width = 75
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button3: TButton
    Left = 480
    Top = 494
    Width = 75
    Height = 25
    Caption = #1053#1072#1079#1072#1076
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button5: TButton
    Left = 848
    Top = 494
    Width = 75
    Height = 25
    Caption = #1042#1087#1077#1088#1105#1076
    TabOrder = 5
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
    TabOrder = 6
  end
  object SchedulesScrollBox: TScrollBox
    Left = 20
    Top = 162
    Width = 309
    Height = 459
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 7
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
