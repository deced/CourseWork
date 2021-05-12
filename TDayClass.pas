unit TDayClass;

interface

uses TSubjectClass, SysUtils, System.Generics.Collections;

type
    TSubjects = TList<TSubject>;

    TDay = class
        Subjects: TSubjects;
        function ToString(): String; override;
        constructor Create(Subjects: TSubjects);
    end;

implementation

function TDay.ToString(): String;
var
    I: Integer;
begin
    Result := '';
    for I := 0 to self.Subjects.Count - 1 do
    begin
        Result := Result + IntToStr(I + 1) + ')' + self.Subjects[I]
          .ToString() + #13#10;
    end;
end;

constructor TDay.Create(Subjects: TSubjects);
begin
    self.Subjects := Subjects;
end;

end.
