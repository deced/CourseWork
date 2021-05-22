unit IO;

interface

uses Generics.Collections, Schedule, Rest.Json, SysUtils, System.Classes,
    DateUtils, CustomTypes;
procedure SaveGroups(Groups: TGroupsList);
procedure SaveTutors(Tutors: TTutorsList);
function LoadGroups(): TGroupsList;
function LoadTutors(): TTutorsList;
procedure SaveShedules(Schedules: TList<TSchedule>);
function LoadSchedules(): TList<TSchedule>;
procedure SaveWeekIndexToFile(Index: Integer);
function LoadWeekIndexFromFile(): Integer;

implementation

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
    if FileExists('Groups.dat') then
    begin
        AssignFile(InputFile, 'Groups.dat');
        Reset(InputFile);
        Readln(InputFile, Input);
        Result := TJson.JsonToObject<TGroupsList>(Input);
        CloseFile(InputFile);
    end;

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
