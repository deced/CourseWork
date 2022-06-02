unit Parser;

interface

uses Group, Tutor, System.Classes, System.Net.HttpClient,
    Vcl.StdCtrls, SysUtils, CustomTypes, JsonFactory, IO, Schedule,
    Generics.Collections;

type
    MyTParser = class(TThread)
        OnWeekReady: TWeekParsed;
        OnGroupsReady: TGroupsParsedEvent;
        OnTutorsReady: TTutorsParsedEvent;
        OnGroupScheduleReady: TGroupSheduleParsedEvent;
        OnTutorScheduleReady: TTutorScheduleParsedEvent;
        OnSchedulesReady: TSchedulesParsedEvent;
        procedure ParseTutorSchedule(Id: String);
        procedure ParseGroupSchedule(GroupID: String);
    protected
        GroupID, TutorId: String;
        procedure Execute; Override;
        function GetWeekIndex(): Byte;
        function GetTutorSchedule(TutorId: String): TSchedule;
        function GetGroupSchedule(GroupID: string): TSchedule;
        function GetSchedules(): TList<TSchedule>;
        function GetTutors(): TTutorsList;
        function GetGroups(): TGroupsList;
    end;

implementation

procedure MyTParser.ParseTutorSchedule(Id: String);
begin
    Self.TutorId := Id;
    Self.Resume;
end;

procedure MyTParser.ParseGroupSchedule(GroupID: String);
begin
    Self.GroupID := GroupID;
    Self.Resume;
end;

function MyTParser.GetWeekIndex(): Byte;
var
    HttpClient: THttpClient;
    HttpResponse: IHttpResponse;
begin
    HttpClient := THttpClient.Create;
    HttpResponse := HttpClient.Get('http://journal.bsuir.by/api/v1/week');
    Result := StrToInt(HttpResponse.ContentAsString());
end;

function MyTParser.GetTutors(): TTutorsList;
var
    HttpClient: THttpClient;
    HttpResponse: IHttpResponse;
begin
    Result := LoadTutors();
    if Result.Count = 0 then
    begin
        HttpClient := THttpClient.Create;
        HttpResponse := HttpClient.Get
          ('https://journal.bsuir.by/api/v1/employees');
        Result := TJsonFactory.GetTutors(HttpResponse.ContentAsString());
    end;
end;

function MyTParser.GetGroups(): TGroupsList;
var
    HttpClient: THttpClient;
    HttpResponse: IHttpResponse;
begin
    Result := LoadGroups();
    if Result.Count = 0 then
    begin
        HttpClient := THttpClient.Create;
        HttpResponse := HttpClient.Get
          ('https://journal.bsuir.by/api/v1/groups');
        Result := TJsonFactory.GetGroups(HttpResponse.ContentAsString());
    end;
end;

function MyTParser.GetSchedules(): TList<TSchedule>;
begin
    Result := LoadSchedules;
end;

function MyTParser.GetTutorSchedule(TutorId: String): TSchedule;
var
    HttpClient: THttpClient;
    HttpResponse: IHttpResponse;
begin
    HttpClient := THttpClient.Create;
    HttpResponse := HttpClient.Get
      ('https://journal.bsuir.by/api/v1/portal/employeeSchedule?employeeId='
      + TutorId);
    Result := TJsonFactory.GetTutorSchedule(HttpResponse.ContentAsString());
end;

function MyTParser.GetGroupSchedule(GroupID: string): TSchedule;
var
    HttpClient: THttpClient;
    HttpResponse: IHttpResponse;
begin
    HttpClient := THttpClient.Create;
    HttpResponse := HttpClient.Get
      ('https://journal.bsuir.by/api/v1/studentGroup/schedule?studentGroup='
      + GroupID);
    Result := TJsonFactory.GetGroupShedule(HttpResponse.ContentAsString());
end;

procedure MyTParser.Execute;
var
    WeekIndex: Byte;
    Groups: TGroupsList;
    Tutors: TTutorsList;
    Schedule: TSchedule;
    Schedules: TList<TSchedule>;
begin
    WeekIndex := GetWeekIndex;
    OnWeekReady(WeekIndex);
    Tutors := GetTutors();
    OnTutorsReady(Tutors);
    Groups := GetGroups();
    OnGroupsReady(Groups);
    Schedules := GetSchedules();
    OnSchedulesReady(Schedules);
    while (true) do
    begin
        if GroupID <> '' then
        begin
            Schedule := GetGroupSchedule(GroupID);
            OnGroupScheduleReady(Schedule);
            GroupID := '';
        end;
        if TutorId <> '' then
        begin
            Schedule := GetTutorSchedule(TutorId);
            OnTutorScheduleReady(Schedule);
            TutorId := '';
        end;
        Self.Suspend;
    end;

end;

end.
