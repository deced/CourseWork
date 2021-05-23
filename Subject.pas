unit Subject;

interface

uses Tutor;

type
    TWeekNums = Array [0 .. 4] of Boolean;

    TSubject = class
    private
        FStartTime: String;
        FEndTime: String;
        FSubjectName: String;
        FTutor: TTutor;
        FAuditory: String;
        FSubjectType: String;
        FGroup: String;
        FNote: String;
        FSubGroup: String;
        FWeeks: TWeekNums;
    public
        property StartTime: String read FStartTime write FStartTime;
        property EndTime: String read FEndTime write FEndTime;
        property SubjectName: String read FSubjectName write FSubjectName;
        property Tutor: TTutor read FTutor write FTutor;
        property Auditory: String read FAuditory write FAuditory;
        property SubjectType: String read FSubjectType write FSubjectType;
        property Group: String read FGroup write FGroup;
        property Note: String read FNote write FNote;
        property SubGroup: String read FSubGroup write FSubGroup;
        property Weeks: TWeekNums read FWeeks write FWeeks;
        function ToString(): String; override;
        constructor Create(StartT, EndT, SubjectName, Auditory, SubjectType,
          Group, Note, SubGroup: String; Weeks: TWeekNums; Tutor: TTutor);

    end;

implementation

function TSubject.ToString(): String;
begin
    Result := SubjectType + ' ' + SubjectName + ' ' + StartTime + '-' + EndTime
      + ' ' + Tutor.Fio;
end;

constructor TSubject.Create(StartT, EndT, SubjectName, Auditory, SubjectType,
  Group, Note, SubGroup: String; Weeks: TWeekNums; Tutor: TTutor);
begin
    Self.StartTime := StartT;
    Self.EndTime := EndT;
    Self.SubjectName := SubjectName;
    Self.Tutor := Tutor;
    Self.Auditory := Auditory;
    Self.SubjectType := SubjectType;
    Self.Group := Group;
    Self.Weeks := Weeks;
    Self.Note := Note;
    Self.SubGroup := SubGroup;
end;

end.
