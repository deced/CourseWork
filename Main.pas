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
    System.Types, ScheduleLabel, System.ImageList, Vcl.ImgList, ClassRooms;

type

    TMainForm = class(TForm)
        AddScheduleButton: TButton;
        MainMenu: TMainMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        PrevButton: TButton;
        NextButton: TButton;
        DayLabel: TLabel;
        ScrollBox: TScrollBox;
        SchedulesScrollBox: TScrollBox;
        Label1: TLabel;
        BevelDate: TBevel;
        SchedulesEmptyLabel: TLabel;
        NoSubjectsLabel: TLabel;
        SearchBox: TComboBox;
        IHATEDELPHIPOPUPS: TPopupMenu;
    N3: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure PrintDay(Day: TDay);
        procedure NextButtonClick(Sender: TObject);
        procedure PrevButtonClick(Sender: TObject);
        procedure OnClick(Sender: TObject);
        procedure OnChangeSubject(Sender: TObject);
        procedure OnDeleteClick(Sender: TObject);
        procedure OnScheduleClick(Sender: TObject);
        procedure DisplayGroups(Inp: TGroupsList);
        procedure DisplayTutors(Inp: TTutorsList);
        procedure AddSchedule(Schedule: TSchedule);
        procedure PrintSchedules();
        procedure AddSchedules(Input: TList<TSchedule>);
        procedure PrintDateLabel();
        function CheckEndDate(): Boolean;
        function CheckSubjectsCount(Day: TDay): Boolean;
        procedure SchedulesScrollBoxMouseWheelUp(Sender: TObject;
          Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
        procedure SchedulesScrollBoxMouseWheelDown(Sender: TObject;
          Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
        procedure AddScheduleButtonClick(Sender: TObject);
        procedure SetCurrentSchedule(Schedule: TSchedule);
        procedure OnScheduleDeleteClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    private
        SubjectLabels: TList<TSubjectLabel>;
    public
    end;

const
    Days: Array of String = ['ПОНЕДЕЛЬНИК ', 'ВТОРНИК ', 'СРЕДА ', 'ЧЕТВЕРГ ',
      'ПЯТНИЦА ', 'СУББОТА ', 'ВОСКРЕСЕНЬЕ '];

var
    Parser: MyTparser;
    MainForm: TMainForm;
    Tutors: TTutorsList;
    Groups: TGroupsList;
    CurrentWeek: Integer;
    CurrentDay: Integer;
    DaysOffset: Integer;
    Schedules: TList<TSchedule>;
    WeekIndex: Integer;
    DayIndex: Integer;
    ScheduleLabels: TList<TScheduleLabel>;
    CurrentSchedule: TSchedule;
    EndDate: TDateTime;
    GroupsIndex: Integer;

implementation

{$R *.dfm}

procedure TMainForm.OnScheduleDeleteClick(Sender: TObject);
var
    ScheduleIndex: Integer;
    Point: TPoint;
begin
    Point := ((Sender as TMenuItem).GetParentComponent as TPopupMenu)
      .PopupPoint;
    Point := SchedulesScrollBox.ScreenToClient(Point);
    ScheduleIndex := Point.Y div ScheduleItemHeight;
    if MessageDlg('Вы действительно хотите удалить ' + #13#10 + ScheduleLabels
      [ScheduleIndex].ScheduleInfo.Caption, mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
    begin
        Schedules.Delete(ScheduleIndex);
        PrintSchedules;
        SaveShedules(Schedules);
    end;
end;

function TMainForm.CheckSubjectsCount(Day: TDay): Boolean;
begin
    if Day.Subjects.Count = 0 then
    begin
        NoSubjectsLabel.Caption := 'В этот день нет занятий';
        NoSubjectsLabel.Visible := true;
        Result := false;
    end
    else
    begin
        NoSubjectsLabel.Visible := false;
        Result := true;
    end;
end;

procedure TMainForm.OnClick(Sender: TObject);
var
    SubjectIindex: Integer;
    ShowSubjectForm: TShowSubjectForm;
begin
    SubjectIindex := (Sender as TLabel).Top div SubjectItemGeight;
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
    SubjectIindex := Point.Y div SubjectItemGeight;
    ShowSubject := TShowSubjectForm.Create(self);
    Subject := CurrentSchedule.GetWeek(WeekIndex)[DayIndex].Subjects
      [SubjectIindex];
    ShowSubject.LoadSubjectForEditind(Subject);
    ShowSubject.ShowModal;
    if ShowSubject.ModalResult = mrYes then
    begin
        Subject := ShowSubject.Subject;
        CurrentSchedule.Week[WeekIndex].Subjects[SubjectIindex] := Subject;
        PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
    end;
    SaveShedules(Schedules);
end;

procedure TMainForm.OnDeleteClick(Sender: TObject);
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
    Subject := CurrentSchedule.GetWeek(WeekIndex)[DayIndex].Subjects
      [SubjectIindex];
    if MessageDlg('Вы действительно хотите удалить' + #13#10 + Subject.ToString,
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
    DayString := DayString + ' НЕД. ' + inttostr(WeekIndex);
    DayLabel.Caption := Days[DayIndex] + DayString;
end;

function TMainForm.CheckEndDate(): Boolean;
begin
    if EndDate < IncDay(Date, DaysOffset) then
    begin
        NoSubjectsLabel.Caption := 'Занятия заканчиваются ' +
          DateToStr(EndDate);
        NoSubjectsLabel.Visible := true;
        Result := false;
    end
    else
    begin
        NoSubjectsLabel.Visible := false;
        Result := true;
    end;
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
    if CheckEndDate() and CheckSubjectsCount(Day) then
        for I := 0 to Day.Subjects.Count - 1 do
        begin
            if SubjectLabels.Count > I then
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

procedure TMainForm.SetCurrentSchedule(Schedule: TSchedule);
var
    Index: Integer;
begin
    CurrentSchedule := Schedule;
    Index := Schedules.IndexOf(CurrentSchedule);
    SaveScheduleIndex(Index);
    EndDate := CurrentSchedule.EndDate;
    SetScheduleFocus(ScheduleLabels, Index);
    PrintDay(Schedule.GetWeek(WeekIndex)[DayIndex]);
end;

procedure TMainForm.DisplayGroups(Inp: TGroupsList);
var
    I: Integer;
begin
    for I := 0 to Inp.Count - 1 do
    begin
        SearchBox.Items.Add(Inp[I].Id)
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
        SearchBox.Items.Add(Inp[I].Fio);

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

procedure TMainForm.AddScheduleButtonClick(Sender: TObject);
var
    I: Integer;
begin
    Cursor := crAppStart;
    if (SearchBox.Items.IndexOf(SearchBox.Text) <> -1) then
    begin
        if SearchBox.Items.IndexOf(SearchBox.Text) < GroupsIndex then
            Parser.ParseTutorSchedule(Tutors[SearchBox.ItemIndex].Id)
        else
            Parser.ParseGroupSchedule(SearchBox.Text);
    end
    else
    begin
        ShowMessage('Такой группы (преподавателя) не существует');
    end;
end;

procedure TMainForm.AddSchedules(Input: TList<TSchedule>);
var
    ScheduleIndex: Integer;
begin
    Schedules := Input;
    PrintSchedules;
    ScheduleIndex := LoadScheduleIndex();
    if (Schedules.Count > ScheduleIndex) and (ScheduleIndex <> -1) then
        SetCurrentSchedule(Schedules[ScheduleIndex]);
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
        ScheduleLabel.PopUpMenu.Items[0].OnClick := OnScheduleDeleteClick;
        ScheduleLabel.SetText(Schedules[I]);
    end;
    SchedulesEmptyLabel.Visible := ScheduleLabels.Count = 0;
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
        if Schedules[I].info = Schedule.info then
        begin
            Schedules[I] := Schedule;
            Flag := true;
        end;
    if not Flag then
        Schedules.Add(Schedule);
    PrintSchedules;
    SaveShedules(Schedules);
end;

procedure TMainForm.PrevButtonClick(Sender: TObject);
begin
    if CurrentSchedule <> nil then
    begin
        SetPrevDay(DayIndex, WeekIndex);
        PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
    end;
end;

procedure TMainForm.N3Click(Sender: TObject);
var
    newForm: TClassRoomsForm;
begin
    newForm := TClassRoomsForm.Create(self);
    newForm.Open(CurrentWeek,CurrentDay);
end;

procedure TMainForm.NextButtonClick(Sender: TObject);
begin
    if CurrentSchedule <> nil then
    begin
        SetNextDay(DayIndex, WeekIndex);
        PrintDay(CurrentSchedule.GetWeek(WeekIndex)[DayIndex]);
    end;
end;

procedure WeekReady(Week: Byte);
begin
    CurrentWeek := Week;
    WeekIndex := Week;
    CurrentDay := DayOfTheWeek(Date) - 1;
    DayIndex := CurrentDay;
    MainForm.PrintDateLabel();
    SaveWeekIndexToFile(CurrentWeek);
    MainForm.N3.Enabled := true;
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
    SetCurrentSchedule(Schedules[ScheduleIndex]);
    EndDate := CurrentSchedule.EndDate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    CreateDir('groups');
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
