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
        SearchList: TComboBox;
        WeekNumberLabel: TLabel;
        Label2: TLabel;
        MainMenu: TMainMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        Button3: TButton;
        Button5: TButton;
        DayLabel: TLabel;
        ScrollBox: TScrollBox;
        SchedulesScrollBox: TScrollBox;
    Label1: TLabel;
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
        procedure SchedulesScrollBoxClick(Sender: TObject);
        procedure AddSchedules(Input: TList<TSchedule>);
    private
        { Private declarations }
    public
    end;

const
    Days: Array of String = ['Понедельник', 'Вторник', 'Среда', 'Четверг',
      'Пятница', 'Суббота'];

var
    MainForm: TMainForm;
    Tutors: TTutorsList;
    Parser: MyTparser;
    CurrentWeek: Byte;
    GroupsIndex: Integer;
    Schedules: TList<TSchedule>;
    DayIndex: Integer;
    SubjectLabels: TList<TSubjectLabel>;
    ScheduleLabels: TList<TScheduleLabel>;
    CurrentSchedule: TSchedule;

implementation

{$R *.dfm}

procedure TMainForm.OnScheduleClick(Sender: TObject);
var
    ScheduleIndex: Integer;
begin
    ScheduleIndex := (Sender as TControl).Top div ScheduleItemHeight;
    CurrentSchedule := Schedules[ScheduleIndex];
    AddSchedule(CurrentSchedule);
end;

procedure TMainForm.OnClick(Sender: TObject);
var
    SubjectIindex: Integer;
    ShowSubjectForm: TShowSubjectForm;
begin
    SubjectIindex := (Sender as TLabel).Top div 60;
    ShowSubjectForm := TShowSubjectForm.Create(self);
    ShowSubjectForm.LoadSubject(CurrentSchedule.GetWeek(CurrentWeek)
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
    Subject := CurrentSchedule.GetWeek(CurrentWeek)[DayIndex].Subjects
      [SubjectIindex];
    ShowSubject.LoadSubjectForEditind(Subject);
    ShowSubject.ShowModal;
    if ShowSubject.ModalResult = mrYes then
    begin
        Subject := ShowSubject.Subject;
        CurrentSchedule.Week[CurrentWeek].Subjects[SubjectIindex];
        PrintDay(CurrentSchedule.GetWeek(CurrentWeek)[DayIndex]);
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
    ShowMessage(inttostr(SubjectIindex) + ' ' + CurrentSchedule.GetWeek
      (CurrentWeek)[DayIndex].Subjects[SubjectIindex].ToString);
    CurrentSchedule.Week[DayIndex].Subjects.RemoveItem
      (CurrentSchedule.GetWeek(CurrentWeek)[DayIndex].Subjects[SubjectIindex],
      FromBeginning);
    PrintDay(CurrentSchedule.GetWeek(CurrentWeek)[DayIndex]);
    SaveShedules(Schedules);
end;

procedure TMainForm.PrintDay(Day: TDay);
var
    I: Integer;
    SuperLabel: TSubjectLabel;
begin
    DayLabel.Caption := Days[DayIndex];
    for I := 0 to SubjectLabels.Count - 1 do
        SubjectLabels[I].Clear;
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
            ScheduleLabel.ScheduleInfo.OnClick := OnScheduleClick;
            ScheduleLabel.Image.OnClick := OnScheduleClick;
            ScheduleLabels.Add(ScheduleLabel);
        end;
        ScheduleLabel.SetText(Schedules[I]);
    end;
end;

procedure TMainForm.AddSchedule(Schedule: TSchedule);
var
    I: Integer;
    Flag: Boolean;
begin
    Flag := False;
    for I := 0 to Schedules.Count - 1 do
        if Schedules[I].Info = Schedule.Info then
        begin
            Schedules[I] := Schedule;
            Flag := True;
        end;
    if not Flag then
        Schedules.Add(Schedule);
    PrintSchedules;
    PrintDay(Schedule.GetWeek(CurrentWeek)[DayIndex]);
    CurrentSchedule := Schedule;
    SaveShedules(Schedules);
end;

procedure TMainForm.SchedulesScrollBoxClick(Sender: TObject);
begin
    ShowMessage('');
end;

procedure TMainForm.Button2Click(Sender: TObject);
var
    I: Integer;
begin
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
        ShowMessage('Такой группы не существует');
    end;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
    dec(DayIndex);
    if DayIndex < 0 then
        DayIndex := 0;
    PrintDay(CurrentSchedule.GetWeek(CurrentWeek)[DayIndex]);
end;


procedure TMainForm.Button5Click(Sender: TObject);
begin
    inc(DayIndex);
    if DayIndex > High(CurrentSchedule.GetWeek(CurrentWeek)) then
        DayIndex := 0;
    PrintDay(CurrentSchedule.GetWeek(CurrentWeek)[DayIndex]);
end;

procedure WeekReady(Week: Byte);
begin
    CurrentWeek := Week;
    MainForm.WeekNumberLabel.Caption := 'номер текущей недели: ' +
      inttostr(Week);
    SaveWeekIndexToFile(CurrentWeek);
end;

procedure TMainForm.FillComboBox(Tutors: TTutorsList; Groups: TGroupsList);
var
    I: Integer;
begin
    I := SearchList.Items.Count;
    for I := 0 to Tutors.Count - 1 do
        SearchList.Items.Add(Tutors[I].Fio);
    for I := 0 to Groups.Count - 1 do
        SearchList.Items.Add(Groups[I].Id);
    I := SearchList.Items.Count;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
    I: Integer;
    NewImage: TImage;

begin
    DayIndex := DayOfTheWeek(Date) - 1;
    if DayIndex = 6 then
        DayIndex := 0;
    DayLabel.Caption := Days[DayIndex];
    SubjectLabels := TList<TSubjectLabel>.Create;
    ScheduleLabels := TList<TScheduleLabel>.Create;
    Parser := MyTparser.Create(True);
    Parser.OnGroupsReady := DisplayGroups;
    Parser.OnTutorsReady := DisplayTutors;
    Parser.OnGroupScheduleReady := AddSchedule;
    Parser.OnTutorScheduleReady := AddSchedule;
    Parser.OnSchedulesReady := AddSchedules;
    Parser.OnWeekReady := WeekReady;
    Parser.Start();
end;

end.
