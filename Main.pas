unit Main;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
    IdComponent, IdTCPConnection, System.Net.HttpClient,
    Parser, JsonFactory, CustomTypes, Vcl.ExtCtrls, PngImage,
    Schedule, Vcl.Imaging.jpeg, IdTCPClient, Generics.Collections, Day,
    Rest.Json, IO, Vcl.Menus, SubjectLabel, ShowSubject, Subject, DateUtils,
    System.Types, ScheduleLabel;

type

    TMainForm = class(TForm)
        Button2: TButton;
        MainMenu: TMainMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        Button3: TButton;
        Button5: TButton;
        DayLabel: TLabel;
        ScrollBox: TScrollBox;
        SchedulesScrollBox: TScrollBox;
        Label1: TLabel;
        NoSubjectsLabel: TLabel;
        Label2: TLabel;
        SearchList: TComboBox;
        procedure FormCreate(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure PrintDay(Day: TDay);
        procedure FillComboBox(Tutors: TTutorsList; Groups: TGroupsList);
        procedure Button5Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure OnClick(Sender: TObject);
        procedure OnChangeSubject(Sender: TObject);
        procedure OnDeleteClick(Sender: TObject);
        procedure OnScheduleClick(Sender: TObject);
        procedure DisplayGroups(Inp: TGroupsList);
        procedure DisplayTutors(Inp: TTutorsList);
        procedure AddSchedule(Schedule: TSchedule);
        procedure PrintSchedules();
        procedure AddSchedules(Input: TList<TSchedule>);
        procedure CheckSubjectsCount(Day: TDay);
        procedure PrintDateLabel();
    procedure SchedulesScrollBoxMouseWheelUp(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure SchedulesScrollBoxMouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    private
        { Private declarations }
    public
    end;

const
    Days: Array of String = ['œŒÕ≈ƒ≈À‹Õ»  ', '¬“Œ–Õ»  ', '—–≈ƒ¿ ', '◊≈“¬≈–√ ',
      'œﬂ“Õ»÷¿ ', '—”¡¡Œ“¿ ', '¬Œ— –≈—≈Õ‹≈ '];

var
    MainForm: TMainForm;
    Tutors: TTutorsList;
    Parser: MyTparser;
    CurrentWeek: Integer;
    CurrentDay: Integer;
    DaysOffset: Integer;
    GroupsIndex: Integer;
    Schedules: TList<TSchedule>;
    WeekIndex: Integer;
    DayIndex: Integer;
    SubjectLabels: TList<TSubjectLabel>;
    ScheduleLabels: TList<TScheduleLabel>;
    CurrentSchedule: TSchedule;

implementation

{$R *.dfm}

procedure TMainForm.CheckSubjectsCount(Day: TDay);
begin
    if Day.Subjects.Count = 0 then
        NoSubjectsLabel.Visible := true
    else
        NoSubjectsLabel.Visible := false;
end;

procedure TMainForm.OnClick(Sender: TObject);
var
    SubjectIindex: Integer;
    ShowSubjectForm: TShowSubjectForm;
begin
    SubjectIindex := (Sender as TLabel).Top div 60;
    ShowSubjectForm := TShowSubjectForm.Create(self);
    ShowSubjectForm.LoadSubject(CurrentSchedule.GetWeek(WeekIndex)
      [DayIndex].Subjects[SubjectIindex]);
    ShowSubjectForm.Show;
end;

procedure TMainForm.OnChangeSubject(Sender: TObject);
var
    SubjectIindex: Integer;
    Point: TPoint;
    ShowSubject: TShowSubjectForm;
    Subject: TSubject;
begin
    Point := ((Sender as TMenuItem).GetParentComponent as TPopupMenu)
      .PopupPoint;
    Point := ScrollBox.ScreenToClient(Point);
    SubjectIindex := Point.Y div 60;
    ShowSubject := TShowSubjectForm.Create(self);
    Subject := CurrentSchedule.GetWeek(WeekIndex)[DayIndex].Subjects
      [SubjectIindex];
    ShowSubject.LoadSubjectForEditind(Subject);
    ShowSubject.ShowModal;
    if ShowSubject.ModalResult = mrYes then
    begin
        Subject := ShowSubject.Subject;
        CurrentSchedule.Week[WeekIndex].Subjects[SubjectIindex];
        PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
    end;
    SaveShedules(Schedules);
end;

procedure TMainForm.OnDeleteClick(Sender: TObject);
var
    SubjectIindex: Integer;
    Point, Point2: TPoint;
    ShowSubject: TShowSubjectForm;
    Subject: TSubject;
begin
    Point := ((Sender as TMenuItem).GetParentComponent as TPopupMenu)
      .PopupPoint;
    Point := ScrollBox.ScreenToClient(Point);
    SubjectIindex := Point.Y div 60;
    Subject := CurrentSchedule.GetWeek(WeekIndex)[DayIndex].Subjects
      [SubjectIindex];
    if MessageDlg('¬˚ ‰ÂÈÒÚ‚ËÚÂÎ¸ÌÓ ıÓÚËÚÂ Û‰‡ÎËÚ¸' + #13#10 + Subject.ToString,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        CurrentSchedule.Week[DayIndex].Subjects.RemoveItem(Subject,
          FromBeginning);
        PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
        SaveShedules(Schedules);
    end;
end;

procedure TMainForm.PrintDateLabel();
var
    DayString: String;
begin
    DayString := DateToStr(IncDay(Date, DaysOffset));
    DayString := DayString.Remove(Length(DayString) - 5);
    DayString := DayString + ' Õ≈ƒ. ' + inttostr(WeekIndex);
    DayLabel.Caption := Days[DayIndex] + DayString;
end;

procedure TMainForm.PrintDay(Day: TDay);
var
    I: Integer;
    SuperLabel: TSubjectLabel;
    DayString: String;
begin
    PrintDateLabel();
    for I := 0 to SubjectLabels.Count - 1 do
        SubjectLabels[I].Clear;
    CheckSubjectsCount(Day);
    for I := 0 to Day.Subjects.Count - 1 do
    begin
        if SubjectLabels.Count < I then
        begin
            SuperLabel := SubjectLabels[I];
            SuperLabel.SetLocation(I * 60);
        end
        else
        begin
            SuperLabel := TSubjectLabel.Create(ScrollBox, I * 60);
            SubjectLabels.Add(SuperLabel);
        end;
        SuperLabel.TimeStart.OnDblClick := OnClick;
        SuperLabel.PopUpMenu.Items[0].OnClick := OnChangeSubject;
        SuperLabel.PopUpMenu.Items[1].OnClick := OnDeleteClick;
        SuperLabel.SetText(Day.Subjects[I]);
    end;
end;

procedure TMainForm.DisplayGroups(Inp: TGroupsList);
var
    I: Integer;
begin
    for I := 0 to Inp.Count - 1 do
    begin
        SearchList.Items.Add(Inp[I].Id)
    end;
    SaveGroups(Inp);
end;

procedure TMainForm.DisplayTutors(Inp: TTutorsList);
var
    I: Integer;
begin
    Tutors := Inp;
    for I := 0 to Inp.Count - 1 do
    begin
        MainForm.SearchList.Items.Add(Inp[I].Fio);

    end;
    GroupsIndex := Inp.Count;
    SaveTutors(Inp);
end;

procedure SetPrevDay(var Day, Week: Integer);
begin
    if (Day <> CurrentDay) or (Week <> CurrentWeek) then
    begin
        dec(DaysOffset);
        dec(Day);
        if Day < 0 then
        begin
            Day := 6;
            dec(Week);
            if Week = 0 then
                Week := 4;
        end;
    end;
end;

procedure SetNextDay(var Day, Week: Integer);
begin
    inc(DaysOffset);
    inc(Day);
    if Day > 6 then
    begin
        Day := 0;
        inc(Week);
        if Week > 4 then
            Week := 1;
    end;
end;

procedure TMainForm.AddSchedules(Input: TList<TSchedule>);
begin

    Schedules := Input;
    PrintSchedules;
end;

procedure TMainForm.PrintSchedules();
var
    I: Integer;
    ScheduleLabel: TScheduleLabel;
begin
    for I := 0 to ScheduleLabels.Count - 1 do
        ScheduleLabels[I].Clear();
    for I := 0 to Schedules.Count - 1 do
    begin
        if ScheduleLabels.Count > I then
        begin
            ScheduleLabel := ScheduleLabels[I];
            ScheduleLabel.SetLocation((I * ScheduleItemHeight) -
              ((SchedulesScrollBox.VertScrollBar.Position div
              ScheduleItemHeight) * ScheduleItemHeight));
        end
        else
        begin
            ScheduleLabel := TScheduleLabel.Create(SchedulesScrollBox,
              (I * ScheduleItemHeight) -
              ((SchedulesScrollBox.VertScrollBar.Position div
              ScheduleItemHeight) * ScheduleItemHeight));

            ScheduleLabels.Add(ScheduleLabel);
        end;
        ScheduleLabel.ScheduleInfo.OnClick := OnScheduleClick;
        ScheduleLabel.Image.OnClick := OnScheduleClick;
        ScheduleLabel.SetText(Schedules[I]);
    end;
end;


procedure TMainForm.SchedulesScrollBoxMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
    SchedulesScrollBox.VertScrollBar.Position :=
      SchedulesScrollBox.VertScrollBar.Position + ScrollStep;
end;

procedure TMainForm.SchedulesScrollBoxMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
    SchedulesScrollBox.VertScrollBar.Position :=
      SchedulesScrollBox.VertScrollBar.Position - ScrollStep;
end;

procedure TMainForm.AddSchedule(Schedule: TSchedule);
var
    I: Integer;
    Flag: Boolean;
begin
    DaysOffset := 0;
    DayIndex := CurrentDay;
    WeekIndex := CurrentWeek;
    Cursor := crArrow;
    Flag := false;
    for I := 0 to Schedules.Count - 1 do
        if Schedules[I].Info = Schedule.Info then
        begin
            Schedules[I] := Schedule;
            Flag := true;
        end;
    if not Flag then
        Schedules.Add(Schedule);
    PrintSchedules;
    PrintDay(Schedule.GetWeek(WeekIndex)[DayIndex]);
    CurrentSchedule := Schedule;
    SaveShedules(Schedules);
end;

procedure TMainForm.Button2Click(Sender: TObject);
var
    I: Integer;
begin
    Cursor := crAppStart;
    I := SearchList.Items.Count;
    if (SearchList.Items.IndexOf(SearchList.Text) <> -1) then
    begin
        if SearchList.Items.IndexOf(SearchList.Text) < GroupsIndex then

            Parser.ParseTutorSchedule(Tutors[SearchList.ItemIndex].Id)
        else
            Parser.ParseGroupSchedule(SearchList.Text);
    end
    else
    begin
        ShowMessage('“‡ÍÓÈ „ÛÔÔ˚ ÌÂ ÒÛ˘ÂÒÚ‚ÛÂÚ');
    end;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
    SetPrevDay(DayIndex, WeekIndex);
    PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
    SetNextDay(DayIndex, WeekIndex);
    PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
end;

procedure WeekReady(Week: Byte);
begin
    CurrentWeek := Week;
    WeekIndex := Week;
    CurrentDay := DayOfTheWeek(Date) - 1;
    SaveWeekIndexToFile(CurrentWeek);
end;

procedure TMainForm.OnScheduleClick(Sender: TObject);
var
    ScheduleIndex: Integer;
    I: Integer;
begin
    DaysOffset := 0;
    DayIndex := CurrentDay;
    WeekIndex := CurrentWeek;
    ScheduleIndex := (SchedulesScrollBox.VertScrollBar.Position +
      (Sender as TControl).Top) div ScheduleItemHeight;
    CurrentSchedule := Schedules[ScheduleIndex];
    for I := 0 to ScheduleLabels.Count - 1 do
        ScheduleLabels[I].Focus(false);
    ScheduleLabels[ScheduleIndex].Focus(true);
    PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
end;

procedure TMainForm.FillComboBox(Tutors: TTutorsList; Groups: TGroupsList);
var
    I: Integer;
begin
    for I := 0 to Tutors.Count - 1 do
        SearchList.Items.Add(Tutors[I].Fio);
    for I := 0 to Groups.Count - 1 do
        SearchList.Items.Add(Groups[I].Id);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
    I: Integer;
    NewImage: TImage;
begin
    DaysOffset := 0;
    SubjectLabels := TList<TSubjectLabel>.Create;
    ScheduleLabels := TList<TScheduleLabel>.Create;
    Parser := MyTparser.Create(true);
    Parser.OnGroupsReady := DisplayGroups;
    Parser.OnTutorsReady := DisplayTutors;
    Parser.OnGroupScheduleReady := AddSchedule;
    Parser.OnTutorScheduleReady := AddSchedule;
    Parser.OnSchedulesReady := AddSchedules;
    Parser.OnWeekReady := WeekReady;
    Parser.Start();
end;

end.
