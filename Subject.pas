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
        FWeeks: TWeekNums;
    public
        property StartTime: String read FStartTime write FStartTime;
        property EndTime: String read FEndTime write FEndTime;
        property SubjectName: String read FSubjectName write FSubjectName;
        property Tutor: TTutor read FTutor write FTutor;
        property Auditory: String read FAuditory write FAuditory;
        property SubjectType: String read FSubjectType write FSubjectType;
        property Weeks: TWeekNums read FWeeks write FWeeks;
        function ToString(): String; override;
        constructor Create(StartT, EndT: String; SubjectName: string;
          Tutor: TTutor; Auditory: String; SubjectType: String;
          Weeks: TWeekNums);

    end;

implementation

function TSubject.ToString(): String;
begin
    Result := SubjectType + ' ' + SubjectName + ' ' + StartTime + '-' + EndTime
      + ' ' + Tutor.Fio;
end;

constructor TSubject.Create(StartT, EndT: String; SubjectName: string;
  Tutor: TTutor; Auditory: String; SubjectType: String; Weeks: TWeekNums);
begin
    Self.StartTime := StartT;
    Self.EndTime := EndT;
    Self.SubjectName := SubjectName;
    Self.Tutor := Tutor;
    Self.Auditory := Auditory;
    Self.SubjectType := SubjectType;
    Self.Weeks := Weeks;
end;

end.
