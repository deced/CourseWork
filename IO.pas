unit IO;

interface

uses Generics.Collections, Schedule, Rest.Json, SysUtils, System.Classes;
procedure SaveGroups(Groups: TStrings);
procedure SaveTutors(Tutors: TStrings);
function LoadGroups():  TList<String>;
function LoadTutors():  TList<String>;
procedure SaveShedules(Schedules: TList<TSchedule>);
function LoadSchedules(): TList<TSchedule>;

implementation

function LoadGroups(): TList<String>;
var
    InputFile: TextFile;
    Line: string;
begin
    Result := TList<String>.Create;
    if FileExists('Groups.dat') then
    begin
        AssignFile(InputFile, 'Groups.dat');
        Reset(InputFile);
        while not Eof(InputFile) do
        begin
            Readln(InputFile, Line);
            Result.Add(Line);
        end;
        CloseFile(InputFile);
    end;
end;

function LoadTutors(): TList<String>;
var
    InputFile: TextFile;
    Line: string;
begin
    Result := TList<String>.Create;
    if FileExists('Tutors.dat') then
    begin
        AssignFile(InputFile, 'Tutors.dat');
        Reset(InputFile);
        while not Eof(InputFile) do
        begin
            Readln(InputFile, Line);
            Result.Add(Line);
        end;
        CloseFile(InputFile);
    end;
end;

procedure SaveGroups(Groups: TStrings);
var
    OutputFile: TextFile;
    I: Integer;
begin
    AssignFile(OutputFile, 'Groups.dat');
    Rewrite(OutputFile);
    for I := 0 to Groups.Count - 1 do
        Writeln(OutputFile, Groups[I]);
    CloseFile(OutputFile);
end;

procedure SaveTutors(Tutors: TStrings);
var
    OutputFile: TextFile;
    I: Integer;
begin
    AssignFile(OutputFile, 'Tutors.dat');
    Rewrite(OutputFile);
    for I := 0 to Tutors.Count - 1 do
        Writeln(OutputFile, Tutors[I]);
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
