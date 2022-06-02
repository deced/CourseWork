unit ClassRoomsParser;

interface

uses SysUtils, System.Classes, CustomTypes, System.Net.HttpClient, JsonFactory,
    Generics.Collections, Forms, Schedule, AuditorySubject, Vcl.Dialogs,
    subject, IO;

type
    TClassRoomsParser = class(TThread)
        OnGroupsReady: TGroupsParsedEvent;
        OnGroupReady: TGroupSheduleParsedEvent;
        OnAllGroupsReady: TAllGroupsParsedEvent;
        OnDictionaryReady: TDictionaryReadyEvent;
    protected
        procedure Execute; Override;
        function GetGroups(): TGroupsList;
        function GetGroupSchedule(GroupID: string): TSchedule;
        function GetDictionary(Schedules: Tlist<TSchedule>)  : TDictionary<string, Tlist<TAuditorySubject>>;
    end;

implementation


function TClassRoomsParser.GetGroupSchedule(GroupID: string): TSchedule;
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

function TClassRoomsParser.GetGroups(): TGroupsList;
var
    HttpClient: THttpClient;
    HttpResponse: IHttpResponse;
begin
    Result := TGroupsList.Create();

    HttpClient := THttpClient.Create;
    HttpResponse := HttpClient.Get('https://journal.bsuir.by/api/v1/groups');
    Result := TJsonFactory.GetGroups(HttpResponse.ContentAsString());
end;

function ContainsSubject(subject: TSubject;
  subjects: Tlist<TAuditorySubject>): Boolean;
var
    I: Integer;
begin
    Result := False;
    for I := 0 to subjects.Count - 1 do
        if (subjects[I].StartTime = subject.StartTime) and
          (subjects[I].EndTime = subject.EndTime) and
          (subjects[I].SubjectName = subject.SubjectName) and
          (subjects[I].Weeks[1] = subject.Weeks[1]) and
          (subjects[I].Weeks[2] = subject.Weeks[2]) and
          (subjects[I].Weeks[3] = subject.Weeks[3]) and
          (subjects[I].Weeks[4] = subject.Weeks[4]) then
        begin
            Result := true;
            break;
        end;
end;

function TClassRoomsParser.GetDictionary(Schedules: Tlist<TSchedule>)
  : TDictionary<string, Tlist<TAuditorySubject>>;
var
    I, J, K: Integer;
    Schedule: TSchedule;
    AuditorySubject: TAuditorySubject;
    subject: TSubject;
begin
    Result := TDictionary < string, Tlist < TAuditorySubject >>.Create;
    for I := 0 to Schedules.Count - 1 do
    begin
        Schedule := Schedules[I];
        for J := 0 to high(Schedule.Week) do
            if (Schedule.Week[J] <> nil) and (Schedule.Week[J].subjects <> nil)
            then
                for K := 0 to Schedule.Week[J].subjects.Count - 1 do
                begin
                    subject := Schedule.Week[J].subjects[K];
                    if (subject.Auditory = '') then
                        continue;

                    if not(Result.ContainsKey(subject.Auditory)) then
                    begin
                        Result.Add(subject.Auditory,
                          Tlist<TAuditorySubject>.Create);

                    end;

                    if ContainsSubject(subject, Result[subject.Auditory]) then
                        continue;
                    AuditorySubject := TAuditorySubject.Create
                      (subject.StartTime, subject.EndTime, subject.SubjectName,
                      subject.SubjectType, subject.Weeks, subject.Tutor, J);
                    Result[subject.Auditory].Add(AuditorySubject);
                end;
    end;
end;

procedure TClassRoomsParser.Execute();
var
    I: Integer;
    Schedule: TSchedule;
    Groups: TGroupsList;
    AllSchedules: Tlist<TSchedule>;
    errMsg: string;
begin
    AllSchedules := LoadAllSchedules();

    if (AllSchedules = nil) or (AllSchedules.Count = 0) then
    begin
        AllSchedules := Tlist<TSchedule>.Create();
        Groups := GetGroups();
        OnGroupsReady(Groups);
        for I := 0 to Groups.Count - 1 do
        begin
            try
                Schedule := GetGroupSchedule(Groups[I].Id);
                AllSchedules.Add(Schedule);
            except
                errMsg := errMsg + '\n' + Groups[I].Id;
            end;
            OnGroupReady(Schedule);
        end;
        SaveAllSchedules(AllSchedules);
    end
    else
    OnDictionaryReady(GetDictionary(AllSchedules));
end;

end.
