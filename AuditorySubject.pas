unit AuditorySubject;

interface

uses Subject, Tutor;

type
    TAuditorySubject = class
    private
        FDay: Integer;
        FStartTime: String;
        FEndTime: String;
        FSubjectName: String;
        FSubjectType: String;
        FTutor: TTutor;
        FWeeks: TWeekNums;
    public
        property Day: Integer read FDay write FDay;
        property Tutor: TTutor read FTutor write FTutor;
        property StartTime: String read FStartTime write FStartTime;
        property EndTime: String read FEndTime write FEndTime;
        property SubjectName: String read FSubjectName write FSubjectName;
        property SubjectType: String read FSubjectType write FSubjectType;
        property Weeks: TWeekNums read FWeeks write FWeeks;
        function ToString(): String; override;
        constructor Create(StartT, EndT, SubjectName, SubjectType : string; Weeks: TWeekNums; Tutor: TTutor;Day:Integer);

    end;

implementation

constructor TAuditorySubject.Create(StartT, EndT, SubjectName, SubjectType : string; Weeks: TWeekNums; Tutor: TTutor; Day:Integer);
begin
    FStartTime := StartT;
    FEndTime := EndT;
    FSubjectName := SubjectName;
    FSubjectType := SubjectType;
    FWeeks := Weeks;
    FTutor := Tutor;
    FDay := Day;
end;

function TAuditorySubject.ToString: string;
begin
    Result := FStartTime + ' ' + FEndTime + ' ' + FSubjectName;
end;

end.
