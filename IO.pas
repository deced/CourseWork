unit IO;

interface

uses Generics.Collections, Schedule, Rest.Json, SysUtils, System.Classes,
    DateUtils, CustomTypes;
procedure SaveAllSchedules(Schedules: TList<TSchedule>);
function LoadAllSchedules(): TList<TSchedule>;
procedure SaveGroups(Groups: TGroupsList);
procedure SaveTutors(Tutors: TTutorsList);
function LoadGroups(): TGroupsList;
function LoadTutors(): TTutorsList;
procedure SaveShedules(Schedules: TList<TSchedule>);
function LoadSchedules(): TList<TSchedule>;
procedure SaveWeekIndexToFile(Index: Integer);
function LoadWeekIndexFromFile(): Integer;
procedure SaveScheduleIndex(Index: Integer);
function LoadScheduleIndex(): Integer;

implementation

procedure SaveScheduleIndex(Index: Integer);
var
    OutputFile: TextFile;
begin
    try
        AssignFile(OutputFile, 'ScheduleIndex.dat');
        Rewrite(OutputFile);
        Write(OutputFile, Index);
    finally
        CloseFile(OutputFile);
    end;
end;

function LoadScheduleIndex(): Integer;
var
    InputFile: TextFile;
begin
    Result := -1;
    if FileExists('ScheduleIndex.dat') then
    begin
        try
            AssignFile(InputFile, 'ScheduleIndex.dat');
            Reset(InputFile);
            Read(InputFile, Result);

        finally
            CloseFile(InputFile);
        end;
    end
end;

function LoadWeekIndexFromFile(): Integer;
var
    InputFile: TextFile;
    WeekIndex: Integer;
begin
    if FileExists('WeekIndex.dat') then
    begin
        AssignFile(InputFile, 'WeekIndex.dat');
        Reset(InputFile);
        Readln(InputFile, Result);
        Readln(InputFile, WeekIndex);
        if WeekIndex <> WeekOfTheYear(Date) then
        begin
            Result := (Result + (WeekOfTheYear(Date) - WeekIndex)) mod 4;
            if Result = 0 then
                Result := 1;
            Rewrite(InputFile);
            Writeln(InputFile, Result);
            Writeln(InputFile, WeekOfTheYear(Date));
        end;
        CloseFile(InputFile);
    end
    else
    begin
        Result := 255;
    end;
end;

procedure SaveWeekIndexToFile(Index: Integer);
var
    OutputFile: TextFile;
    CurrentWeek: Integer;
begin
    AssignFile(OutputFile, 'WeekIndex.dat');
    if FileExists('WeekIndex.dat') then
    begin
        Reset(OutputFile);
        Readln(OutputFile);
        Readln(OutputFile, CurrentWeek);
        if CurrentWeek <> WeekOfTheYear(Date) then
            Index := (Index + (WeekOfTheYear(Date) - CurrentWeek)) mod 4;
        if Index = 0 then
            Index := 1;
    end;

    Rewrite(OutputFile);
    Writeln(OutputFile, Index);
    Writeln(OutputFile, WeekOfTheYear(Date));
    CloseFile(OutputFile);
end;

function LoadGroups(): TGroupsList;
var
    InputFile: TextFile;
    Input: string;
begin
    Result := TGroupsList.Create;
    { if FileExists('Groups.dat') then
      begin
      AssignFile(InputFile, 'Groups.dat');
      Reset(InputFile);
      Readln(InputFile, Input);
      Result := TJson.JsonToObject<TGroupsList>(Input);
      CloseFile(InputFile);
      end; }

end;

function LoadTutors(): TTutorsList;
var
    InputFile: TextFile;
    Input: string;
begin
    Result := TTutorsList.Create;
    if FileExists('Tutors.dat') then
    begin
        AssignFile(InputFile, 'Tutors.dat');
        Reset(InputFile);
        Readln(InputFile, Input);
        Result := TJson.JsonToObject<TTutorsList>(Input);
        CloseFile(InputFile);
    end;
end;

procedure SaveGroups(Groups: TGroupsList);
var
    OutputFile: TextFile;
    I: Integer;
begin
    AssignFile(OutputFile, 'Groups.dat');
    Rewrite(OutputFile);
    Writeln(OutputFile, TJson.ObjectToJsonString(Groups));
    CloseFile(OutputFile);
end;

procedure SaveTutors(Tutors: TTutorsList);
var
    OutputFile: TextFile;
    I: Integer;
begin
    AssignFile(OutputFile, 'Tutors.dat');
    Rewrite(OutputFile);
    Writeln(OutputFile, TJson.ObjectToJsonString(Tutors));
    CloseFile(OutputFile);
end;

procedure SaveAllSchedules(Schedules: TList<TSchedule>);
var
    OutputFile: TextFile;
    Schedule: TSchedule;
begin
    AssignFile(OutputFile, 'all_schedules.dat');
    Rewrite(OutputFile);
    Write(OutputFile, TJson.ObjectToJsonString(Schedules));
    CloseFile(OutputFile);
end;

function LoadAllSchedules(): TList<TSchedule>;
var
    InputFile: TextFile;
    Json: String;
begin
    Result := TList<TSchedule>.Create;
    if FileExists('all_schedules.dat') then
    begin
        AssignFile(InputFile, 'all_schedules.dat');
        Reset(InputFile);
        Read(InputFile, Json);
        Result := TJson.JsonToObject < TList < TSchedule >> (Json);
        CloseFile(InputFile);
    end;
end;

procedure SaveShedules(Schedules: TList<TSchedule>);
var
    OutputFile: TextFile;
    Schedule: TSchedule;
begin
    AssignFile(OutputFile, 'schedules.dat');
    Rewrite(OutputFile);
    Write(OutputFile, TJson.ObjectToJsonString(Schedules));
    CloseFile(OutputFile);
end;

function LoadSchedules(): TList<TSchedule>;
var
    InputFile: TextFile;
    Json: String;
begin
    Result := TList<TSchedule>.Create;
    if FileExists('schedules.dat') then
    begin
        AssignFile(InputFile, 'schedules.dat');
        Reset(InputFile);
        Read(InputFile, Json);
        Result := TJson.JsonToObject < TList < TSchedule >> (Json);
        CloseFile(InputFile);
    end;
end;

end.
