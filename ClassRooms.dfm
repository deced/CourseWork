object ClassRoomsForm: TClassRoomsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1072#1091#1076#1080#1090#1086#1088#1080#1081
  ClientHeight = 627
  ClientWidth = 829
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 322
    Height = 25
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1103' '#1072#1091#1076#1080#1090#1086#1088#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BevelDate: TBevel
    Left = 347
    Top = 8
    Width = 462
    Height = 30
  end
  object DayLabel: TLabel
    Left = 347
    Top = 8
    Width = 462
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
  object Label3: TLabel
    Left = 8
    Top = 76
    Width = 223
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1081'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 107
    Width = 319
    Height = 42
    MarqueeInterval = 1
    Step = 1
    TabOrder = 0
    Visible = False
  end
  object SearchBox: TComboBox
    Left = 8
    Top = 39
    Width = 322
    Height = 29
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1072#1091#1076#1080#1090#1086#1088#1080#1080', '#1085#1072#1087#1088#1080#1084#1077#1088' 410-4'
    ParentCustomHint = False
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1072#1091#1076#1080#1090#1086#1088#1080#1080
    OnChange = SearchBoxChange
  end
  object NextButton: TButton
    Left = 692
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
  object PrevButton: TButton
    Left = 347
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
    TabOrder = 3
    OnClick = PrevButtonClick
  end
  object ScrollBox: TScrollBox
    Left = 347
    Top = 39
    Width = 462
    Height = 531
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 4
    object NoSubjectsLabel: TLabel
      Left = 16
      Top = 256
      Width = 439
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
end
