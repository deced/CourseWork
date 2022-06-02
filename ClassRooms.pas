unit ClassRooms;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Parser, CustomTypes,
    ClassRoomsParser, Schedule, Generics.Collections, subject, AuditorySubject,
    Vcl.StdCtrls, System.DateUtils, Vcl.ExtCtrls, SubjectLabel, IO, StrUtils;

type
    TClassRoomsForm = class(TForm)
        ProgressBar: TProgressBar;
        Label2: TLabel;
        SearchBox: TComboBox;
        NextButton: TButton;
        PrevButton: TButton;
        BevelDate: TBevel;
        DayLabel: TLabel;
        ScrollBox: TScrollBox;
        NoSubjectsLabel: TLabel;
        Label3: TLabel;
        procedure Open(Week, Day: Byte);
        procedure DictionaryReady(Inp: TDictionary < string,
          Tlist < TAuditorySubject >> );
        procedure GroupsReady(Inp: TGroupsList);
        procedure GroupReady(Inp: TSchedule);
        procedure PrevButtonClick(Sender: TObject);
        procedure NextButtonClick(Sender: TObject);
        procedure PrintLessons();
        procedure PrintDateLabel();
        procedure FormCreate(Sender: TObject);
        procedure SearchBoxChange(Sender: TObject);
        procedure SortSubjects();
    private
        SubjectLabels: Tlist<TSubjectLabel>;
        Parser: TClassRoomsParser;
        { Private declarations }
    public
        { Public declarations }
    end;

var
    WeekIndex: Integer;
    DayIndex: Integer;
    ClassRoomsForm: TClassRoomsForm;
    CurrentDay: Integer;
    CurrentWeek: Integer;
    DaysOffset: Integer;
    Auditories: TDictionary<string, Tlist<TAuditorySubject>>;

const
    Days: Array of String = ['œŒÕ≈ƒ≈À‹Õ»  ', '¬“Œ–Õ»  ', '—–≈ƒ¿ ', '◊≈“¬≈–√ ',
      'œﬂ“Õ»÷¿ ', '—”¡¡Œ“¿ ', '¬Œ— –≈—≈Õ‹≈ '];

implementation

{$R *.dfm}

procedure TClassRoomsForm.Open(Week, Day: Byte);
begin
    CurrentWeek := Week;
    WeekIndex := Week;
    CurrentDay := DayOfTheWeek(Date) - 1;
    DayIndex := CurrentDay;
    Parser := TClassRoomsParser.Create(true);

    Parser.OnGroupsReady := GroupsReady;
    Parser.OnGroupReady := GroupReady;
    Parser.OnDictionaryReady := DictionaryReady;
    Parser.Start();
        PrintDateLabel();
    self.ShowModal();
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

procedure TClassRoomsForm.PrintDateLabel();
var
    DayString: String;
begin
    DayString := DateToStr(IncDay(Date, DaysOffset));
    DayString := DayString.Remove(Length(DayString) - 5);
    DayString := DayString + ' Õ≈ƒ. ' + inttostr(WeekIndex);
    DayLabel.Caption := Days[DayIndex] + DayString;
end;

function ContainsInArray(Week: TWeekNums; WeekNum: Byte): Boolean;
var
    I: Integer;
begin
    Result := Week[WeekNum];
end;

procedure TClassRoomsForm.SortSubjects();
var
    I, J, time1, time2: Integer;
    TempLabel: TSubjectLabel;

begin
    for I := 0 to SubjectLabels.Count - 1 do
        for J := 0 to SubjectLabels.Count - 1 do
        begin
            time1 := StrToInt
              (SplitString(SubjectLabels[I].TimeStart.Caption, ':')[0]);
            time2 := StrToInt
              (SplitString(SubjectLabels[J].TimeStart.Caption, ':')[0]);
            if time1 < time2 then
            begin
                TempLabel := SubjectLabels[I];
                SubjectLabels[I] := SubjectLabels[J];
                SubjectLabels[J] := TempLabel;

            end;

        end;
    J := 0;
    for I := 0 to SubjectLabels.Count - 1 do
    begin
        if (SubjectLabels[I].SubjectName.Caption <> '') then
        begin
            SubjectLabels[I].SetLocation(J * 60);
            inc(J);
        end;
    end;
end;

procedure TClassRoomsForm.PrintLessons();
var
    I, Index: Integer;
    SuperLabel: TSubjectLabel;
    subject: TSubject;
    AuditorySubject: TAuditorySubject;
begin
    PrintDateLabel();
    for I := 0 to SubjectLabels.Count - 1 do
    begin
        SubjectLabels[I].Clear;
        SubjectLabels[I].Destroy;
    end;
    SubjectLabels.Clear;
    if (Auditories.ContainsKey(SearchBox.Text)) then
    begin
        for I := 0 to Auditories[SearchBox.Text].Count - 1 do
        begin
            AuditorySubject := Auditories[SearchBox.Text][I];
            if (not ContainsInArray(Auditories[SearchBox.Text][I].Weeks,
              WeekIndex)) or (Auditories[SearchBox.Text][I].Day <> DayIndex)
            then
                continue;

            SuperLabel := TSubjectLabel.Create(ScrollBox, Index * 60);
            SubjectLabels.Add(SuperLabel);
            SuperLabel.TimeStart.OnDblClick := OnClick;
            subject := TSubject.Create(Auditories[SearchBox.Text][I].StartTime,
              Auditories[SearchBox.Text][I].EndTime,
              Auditories[SearchBox.Text][I].SubjectName, SearchBox.Text,
              Auditories[SearchBox.Text][I].SubjectType, '', '', '',
              Auditories[SearchBox.Text][I].Weeks,
              Auditories[SearchBox.Text][I].Tutor);
            SuperLabel.SetText(subject);
            inc(index);
        end;
    end;
    SortSubjects();
    NoSubjectsLabel.Visible := Index = 0;
end;

procedure TClassRoomsForm.SearchBoxChange(Sender: TObject);
begin
    PrintLessons();
end;

procedure TClassRoomsForm.PrevButtonClick(Sender: TObject);
begin
    SetPrevDay(DayIndex, WeekIndex);
    PrintLessons();
end;

procedure TClassRoomsForm.GroupReady(Inp: TSchedule);

begin
    ProgressBar.StepIt;
end;

procedure TClassRoomsForm.DictionaryReady(Inp: TDictionary < string,
  Tlist < TAuditorySubject >> );
var
    I: Integer;
    Arr: TArray<string>;
begin
    Arr := Inp.Keys.ToArray;
    for I := 0 to Inp.Keys.Count - 1 do
        SearchBox.Items.Add(Arr[I]);
    Auditories := Inp;
    SearchBox.Enabled := true;
    Label3.Visible := false;
    ProgressBar.Visible := false;

end;

procedure TClassRoomsForm.FormCreate(Sender: TObject);
begin
    SubjectLabels := Tlist<TSubjectLabel>.Create;
    Auditories := TDictionary < string, Tlist < TAuditorySubject >>.Create;
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

procedure TClassRoomsForm.GroupsReady(Inp: TGroupsList);

begin
    ProgressBar.Max := Inp.Count;
    ProgressBar.Visible := true;
end;

procedure TClassRoomsForm.NextButtonClick(Sender: TObject);
begin
    SetNextDay(DayIndex, WeekIndex);
    PrintLessons();
end;

end.
