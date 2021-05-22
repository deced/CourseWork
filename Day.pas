unit Day;

interface

uses Subject, SysUtils, System.Generics.Collections;

type
    TSubjects = TList<TSubject>;

    TDay = class
    private
        FSubjects: TSubjects;
        FName: String;
    public
        property Subjects: TSubjects read FSubjects write FSubjects;
        property Name: String read FName write FName;
        function ToString(): String; override;
        constructor Create(Subjects: TSubjects; Name: String);
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

constructor TDay.Create(Subjects: TSubjects; Name: String);
begin
    self.Subjects := Subjects;
    self.Name := Name;
end;

end.
