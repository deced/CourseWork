unit Main;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdHTTP, Vcl.StdCtrls, IdBaseComponent,
    IdComponent, IdTCPConnection, System.Net.HttpClient,
    Parser, JsonFactory, CustomTypes, Vcl.ExtCtrls, PngImage,
    Schedule, Vcl.Imaging.jpeg, IdTCPClient, Generics.Collections, Day,
    Rest.Json, IO;

type
    TMainForm = class(TForm)
        Memo1: TMemo;
        Memo2: TMemo;
        Button2: TButton;
        Image1: TImage;
        Button3: TButton;
        Label1: TLabel;
        SearchList: TComboBox;
        GroupMonday: TGroupBox;
        LabelSchedule1: TLabel;
        GroupTuesday: TGroupBox;
        LabelSchedule2: TLabel;
        GroupWednesday: TGroupBox;
        LabelSchedule3: TLabel;
        GroupThursday: TGroupBox;
        LabelSchedule4: TLabel;
        GroupFriday: TGroupBox;
        LabelSchedule5: TLabel;
        GroupSaturday: TGroupBox;
        LabelSchedule6: TLabel;
        Image2: TImage;
        Image3: TImage;
        Image4: TImage;
        Image5: TImage;
        Image6: TImage;
        Image7: TImage;
        TestLabel: TLabel;
        WeekNumberLabel: TLabel;
        ScrollBox: TScrollBox;
        Image8: TImage;
        IdHTTP1: TIdHTTP;
        SchedulesList: TComboBox;
        Button4: TButton;
        DaySchedule: TScrollBox;
        procedure FormCreate(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure Button4Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    MainForm: TMainForm;
    Tutors: TTutorsArray;
    Parser: MyTparser;
    CurrentWeek: Byte;
    GroupsIndex: Integer;
    Schedules: TList<TSchedule>;

implementation

{$R *.dfm}

procedure FillTutuors();
var
    I: Integer;
    NewImage: TImage;
    NewLabel: TLabel;
    NewPannel: TPanel;
    jpg: TJPEGImage;
    fs: TFileStream;
begin
    { SetLength(Panels, 25);
      for I := 0 to 20 do
      begin
      NewPannel := TPanel.Create(Form4);
      NewPannel.parent := Form4.ScrollBox;
      NewPannel.Left := 20;
      NewPannel.Width := 300;
      NewPannel.Height := 80;
      NewPannel.top := I * 100;
      NewLabel := TLabel.Create(Form4);
      NewLabel.Caption := Tutors[I].Fio;
      NewLabel.parent := NewPannel;
      NewLabel.top := 20 * I;
      NewImage := TImage.Create(Form4);
      NewImage.top := 0;
      NewImage.Left := 0;
      NewImage.parent := NewPannel;

      { try
      ShowMessage('');
      fs := TFileStream.Create(IntToStr(I) + '.png', fmCreate);
      IdHTTP1.Get(Tutors[I].PhotoLink, fs);
      NewImage.Picture.LoadFromFile(IntToStr(I) + '.png');

      finally
      fs.Free;
      end; }
    { NewImage.Height := 50;
      NewImage.Width := 50;

      Panels[I] := NewPannel;
      end; }
end;

procedure DisplayGroups(Inp: TGroupsArray);
var
    I: Integer;
begin
    for I := 0 to High(Inp) do
    begin
        MainForm.Memo1.Lines.Add(Inp[I].ToString);
        MainForm.SearchList.Items.Add(Inp[I].Id)
    end;
    SaveGroups(MainForm.SearchList.Items);
end;

procedure DisplayTutors(Inp: TTutorsArray);
var
    I: Integer;
begin
    SetLength(Tutors, length(Tutors));
    Tutors := Inp;
    for I := 0 to High(Inp) do
    begin
        MainForm.Memo2.Lines.Add(Inp[I].ToString);
        MainForm.SearchList.Items.Add(Inp[I].Fio);

    end;
    SaveTutors(MainForm.SearchList.Items);
    // FillTutuors();
end;


procedure PrintDay(Day: TDay);
var
    I: Integer;
    FIOLabel, TutorLabel: TLabel;
    Image: TImage;
begin
    { // Form4.DaySchedule := TScrollBox.Create(Form4);
      for I := 0 to Day.Subjects.Count - 1 do
      begin
      FIOLabel := TLabel.Create(Form4);
      TutorLabel := TLabel.Create(Form4);
      FIOLabel.Top := 20 * I;
      TutorLabel.Top := FIOLabel.Top + 10;
      TutorLabel.Left := FIOLabel.Width - TutorLabel.Width;
      // FIOLabel.Font.Size := 12;
      TutorLabel.Parent := Form4.DaySchedule;
      FIOLabel.Parent := Form4.DaySchedule;
      FIOLabel.Caption := Day.Subjects[I].SubjectName + ' ' + Day.Subjects
      [I].Auditory;
      TutorLabel.Caption := Day.Subjects[I].Tutor.Fio;
      end; }
end;

procedure PrintSchedule(Schedule: TSchedule);
begin
    if MainForm.SchedulesList.Items.IndexOf(Schedule.Info) = -1 then
    begin
        MainForm.SchedulesList.Items.Add(Schedule.Info);
        Schedules.Add(Schedule);
    end;
    PrintDay(Schedule.GetWeek(CurrentWeek)[0]);
    MainForm.LabelSchedule1.Caption := Schedule.GetWeek(CurrentWeek)
      [0].ToString;
    MainForm.LabelSchedule2.Caption := Schedule.GetWeek(CurrentWeek)
      [1].ToString;
    MainForm.LabelSchedule3.Caption := Schedule.GetWeek(CurrentWeek)
      [2].ToString;
    MainForm.LabelSchedule4.Caption := Schedule.GetWeek(CurrentWeek)
      [3].ToString;
    MainForm.LabelSchedule5.Caption := Schedule.GetWeek(CurrentWeek)
      [4].ToString;
    MainForm.LabelSchedule6.Caption := Schedule.GetWeek(CurrentWeek)
      [5].ToString;
    SaveShedules(Schedules);
end;

procedure TMainForm.Button2Click(Sender: TObject);
var
    HttpClient: THttpClient;
    Png: TPngObject;
begin
    if (SearchList.Items.IndexOf(SearchList.Text) <> -1) then
    begin
        if SearchList.Items.IndexOf(SearchList.Text) < GroupsIndex then

            Parser.GetTutorSchedule(Tutors[SearchList.ItemIndex].Id)
        else
            Parser.GetGroupSchedule(SearchList.Text);
    end
    else
    begin
        ShowMessage('Такой группы не существует');
    end;
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
    fs: TFileStream;
begin
    fs := TFileStream.Create('1.png', fmCreate);
    IdHTTP1.Get('http://img.yandex.net/i/www/logo.png', fs);
    fs.Free;
    Self.Image8.Picture.LoadFromFile('1.png');
end;

procedure TMainForm.Button4Click(Sender: TObject);
var
    sch: TSchedule;
begin
    PrintSchedule(Schedules[SchedulesList.Items.IndexOf(SchedulesList.Text)]);
end;

procedure WeekReady(Week: Byte);
begin
    CurrentWeek := Week;
    MainForm.WeekNumberLabel.Caption := 'номер текущей недели: ' +
      IntToStr(Week);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
    I: Integer;
    NewImage: TImage;
    NewLabel: TLabel;
    NewPannel: TPanel;
    Lines: TList<String>;
begin
    Schedules := LoadSchedules();
    Lines := LoadTutors();
    if Lines.Count <> 0 then
        for I := 0 to Lines.Count - 1 do
            SearchList.Items.Add(Lines[I]);
    Lines := LoadGroups();
    GroupsIndex := SearchList.Items.Count;
    if Lines.Count <> 0 then
        for I := 0 to Lines.Count - 1 do
            SearchList.Items.Add(Lines[I]);
    for I := 0 to Schedules.Count - 1 do
        MainForm.SchedulesList.Items.Add(Schedules[I].Info);
    Parser := MyTparser.Create(true);
    Parser.OnGroupsReady := DisplayGroups;
    Parser.OnTutorsReady := DisplayTutors;
    Parser.OnGroupScheduleReady := PrintSchedule;
    Parser.OnTutorScheduleReady := PrintSchedule;

    Parser.OnWeekReady := WeekReady;
    Parser.Start();
end;

end.
