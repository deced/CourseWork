unit Subject;

interface

uses Tutor;

type
    TWeekNums = Array [0 .. 4] of Boolean;

    TSubject = class
        StartTime: String;
        EndTime: String;
        SubjectName: String;
        Tutor: TTutor;
        Auditory: String;
        SubjectType: String;
        Weeks: TWeekNums;
        function ToString(): String; override;
        constructor Create(StartT, EndT: String; SubjectName: string;
          Tutor: TTutor; Auditory: String;
          SubjectType: String; Weeks: TWeekNums);

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
