unit Parser;

interface

uses Group, Tutor, System.Classes, System.Net.HttpClient,
    Vcl.StdCtrls, SysUtils, CustomTypes, JsonFactory;

type
    MyTParser = class(TThread)
        OnWeekReady: TWeekParsed;
        OnGroupsReady: TGroupsParsedEvent;
        OnTutorsReady: TTutorsParsedEvent;
        OnGroupScheduleReady: TGroupSheduleParsedEvent;
        OnTutorScheduleReady: TTutorScheduleParsedEvent;
        GroupID, TutorId: String;
        procedure Execute; Override;
        procedure GetGroupSchedule(GroupID: String);
        procedure GetTutorSchedule(Id: String);
    end;

implementation

procedure MyTParser.GetTutorSchedule(Id: String);
begin
    Self.TutorId := Id;
    Self.Resume;
end;

procedure MyTParser.GetGroupSchedule(GroupID: String);
begin
    Self.GroupID := GroupID;
    Self.Resume;
end;

procedure MyTParser.Execute;
var
    HttpClient: THttpClient;
    HttpResponse: IHttpResponse;
    I: Integer;
    Course: Byte;
begin
    HttpClient := THttpClient.Create;
    HttpResponse := HttpClient.Get('http://journal.bsuir.by/api/v1/week');
    OnWeekReady(StrToInt(HttpResponse.ContentAsString()));
    HttpResponse := HttpClient.Get('https://journal.bsuir.by/api/v1/groups');
    OnGroupsReady(TJsonFactory.GetGroups(HttpResponse.ContentAsString()));
    HttpResponse := HttpClient.Get('https://journal.bsuir.by/api/v1/employees');
    OnTutorsReady(TJsonFactory.GetTutors(HttpResponse.ContentAsString()));

    HttpResponse := HttpClient.Get('https://journal.bsuir.by/api/v1/auditory');
    while (true) do
    begin
        if GroupID <> '' then
        begin
            HttpResponse :=
              HttpClient.Get
              ('https://journal.bsuir.by/api/v1/studentGroup/schedule?studentGroup='
              + GroupID);
            OnGroupScheduleReady
              (TJsonFactory.GetGroupShedule(HttpResponse.ContentAsString()));
            GroupID := '';
        end;
        if TutorId <> '' then
        begin
            HttpResponse :=
              HttpClient.Get
              ('https://journal.bsuir.by/api/v1/portal/employeeSchedule?employeeId='
              + TutorId);
            OnTutorScheduleReady
              (TJsonFactory.GetTutorSchedule(HttpResponse.ContentAsString()));
            TutorId := '';
        end;
        Self.Suspend;
    end;

end;

end.
