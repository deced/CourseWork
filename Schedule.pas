unit Schedule;

interface

uses Day, System.Generics.Collections, Subject;

type
    TScheduleType = (TutorSchedule, GroupSchedule);
    TWeek = array [0 .. 5] of TDay;

    TSchedule = class
        Week: TWeek;
        ScheduleType: TScheduleType;
        Info: String;
        constructor Create(Week: TWeek; ScheduleType: TScheduleType;
          Info: String);
        function GetWeek(WeekIndex: Byte): TWeek;
    end;

implementation

function ContainsInArray(Week: TWeekNums; WeekNum: Byte): Boolean;
var
    I: Integer;
begin
    Result := Week[WeekNum];
end;

function TSchedule.GetWeek(WeekIndex: Byte): TWeek;
var
    I, J: Integer;
    Day: TDay;
    Subjects: TSubjects;
begin
    for I := 0 to High(Week) do
    begin
        Subjects := TSubjects.Create();
        if Week[I] <> nil then
            if Week[I].Subjects <> nil then
                for J := 0 to Week[I].Subjects.count - 1 do
                begin
                    if ContainsInArray(Week[I].Subjects[J].Weeks, WeekIndex)
                    then
                    begin
                        Subjects.Add(Week[I].Subjects[J]);
                    end;
                end;
        Result[I] := TDay.Create(Subjects);
    end;
end;

constructor TSchedule.Create(Week: TWeek; ScheduleType: TScheduleType;
  Info: String);
begin
    self.Week := Week;
    self.ScheduleType := ScheduleType;
    self.Info := Info;
end;

end.
