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
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 873
    Top = 502
    Width = 105
    Height = 105
    AutoSize = True
  end
  object Label1: TLabel
    Left = 10
    Top = 474
    Width = 225
    Height = 185
    AutoSize = False
    WordWrap = True
  end
  object Image2: TImage
    Left = 849
    Top = 488
    Width = 105
    Height = 105
  end
  object Image3: TImage
    Left = 904
    Top = 488
    Width = 105
    Height = 105
  end
  object Image4: TImage
    Left = 904
    Top = 479
    Width = 105
    Height = 105
  end
  object Image5: TImage
    Left = 928
    Top = 471
    Width = 105
    Height = 105
  end
  object Image6: TImage
    Left = 873
    Top = 479
    Width = 105
    Height = 105
  end
  object Image7: TImage
    Left = 904
    Top = 471
    Width = 105
    Height = 105
  end
  object TestLabel: TLabel
    Left = 30
    Top = 399
    Width = 205
    Height = 208
    AutoSize = False
    Caption = 'TestLabel'
    WordWrap = True
  end
  object WeekNumberLabel: TLabel
    Left = 280
    Top = 32
    Width = 89
    Height = 13
    Caption = #1058#1077#1082#1091#1097#1072#1103' '#1085#1077#1076#1077#1083#1103':'
  end
  object Image8: TImage
    Left = 25
    Top = 160
    Width = 321
    Height = 194
    Stretch = True
  end
  object Memo1: TMemo
    Left = 401
    Top = 494
    Width = 185
    Height = 113
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 201
    Top = 494
    Width = 185
    Height = 113
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 25
    Top = 35
    Width = 75
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 62
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object SearchList: TComboBox
    Left = 20
    Top = 8
    Width = 215
    Height = 21
    Style = csSimple
    TabOrder = 4
  end
  object GroupMonday: TGroupBox
    Left = 272
    Top = 51
    Width = 250
    Height = 120
    Caption = #1055#1086#1085#1077#1076#1077#1083#1100#1085#1080#1082
    TabOrder = 5
    object LabelSchedule1: TLabel
      Left = 16
      Top = 24
      Width = 58
      Height = 13
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
    end
  end
  object GroupTuesday: TGroupBox
    Left = 544
    Top = 51
    Width = 250
    Height = 120
    Caption = #1042#1090#1086#1088#1085#1080#1082
    TabOrder = 6
    object LabelSchedule2: TLabel
      Left = 16
      Top = 24
      Width = 58
      Height = 13
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
    end
  end
  object GroupWednesday: TGroupBox
    Left = 824
    Top = 51
    Width = 250
    Height = 120
    Caption = #1057#1088#1077#1076#1072
    TabOrder = 7
    object LabelSchedule3: TLabel
      Left = 16
      Top = 24
      Width = 58
      Height = 13
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
    end
  end
  object GroupThursday: TGroupBox
    Left = 271
    Top = 203
    Width = 250
    Height = 120
    Caption = #1063#1077#1090#1074#1077#1088#1075
    TabOrder = 8
    object LabelSchedule4: TLabel
      Left = 16
      Top = 24
      Width = 58
      Height = 13
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
    end
  end
  object GroupFriday: TGroupBox
    Left = 544
    Top = 203
    Width = 250
    Height = 120
    Caption = #1055#1103#1090#1085#1080#1094#1072
    TabOrder = 9
    object LabelSchedule5: TLabel
      Left = 16
      Top = 24
      Width = 58
      Height = 13
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
    end
  end
  object GroupSaturday: TGroupBox
    Left = 824
    Top = 203
    Width = 250
    Height = 120
    Caption = #1057#1091#1073#1073#1086#1090#1072
    TabOrder = 10
    object LabelSchedule6: TLabel
      Left = 16
      Top = 24
      Width = 58
      Height = 13
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
    end
  end
  object ScrollBox: TScrollBox
    Left = 592
    Top = 329
    Width = 482
    Height = 288
    TabOrder = 11
  end
  object SchedulesList: TComboBox
    Left = 400
    Top = 352
    Width = 145
    Height = 21
    TabOrder = 12
  end
  object Button4: TButton
    Left = 400
    Top = 379
    Width = 75
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 13
    OnClick = Button4Click
  end
  object DaySchedule: TScrollBox
    Left = 1120
    Top = 200
    Width = 313
    Height = 313
    TabOrder = 14
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 208
    Top = 384
  end
end
