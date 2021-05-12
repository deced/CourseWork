unit Schedule;

interface

uses TDayClass, System.Generics.Collections, TSubjectClass;

type
    TScheduleType = (TutorSchedule, GroupSchedule);
    TWeek = array [0 .. 5] of TDay;

    TSchedule = class
        Week: TWeek;
        ScheduleType: TScheduleType;
        constructor Create(Week: TWeek; ScheduleType: TScheduleType);
        function GetWeek(WeekIndex: Byte): TWeek;
    end;

implementation

function ContainsInArray(Week: TWeekNums; WeekNum: Byte): Boolean;
var
    I: Integer;
begin
    Result := Week[WeekNum ];
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

constructor TSchedule.Create(Week: TWeek; ScheduleType: TScheduleType);
begin
    self.Week := Week;
    self.ScheduleType := ScheduleType;
end;

end.
