unit ScheduleList;

interface

uses Generics.Collections, Schedule;

type
    TScheduleList = class
        Schedules: TList<TSchedule>;
        constructor Create();
    end;

implementation

constructor TScheduleList.Create();
begin
    Schedules := TList<TSchedule>.Create();
end;

end.
