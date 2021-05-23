unit JsonFactory;

interface

uses CustomTypes, Group, Tutor, Schedule, System.JSON,
    Day, SysUtils, Subject, Vcl.Dialogs,
    System.Generics.Collections;

type
    TJsonFactory = class
    public
        class function GetGroups(JSON: String): TGroupsList;
        class function GetTutors(JSON: String): TTutorsList;
        class function GetGroupShedule(JSON: String): TSchedule;
        class function GetTutorSchedule(JSON: String): TSchedule;
    private
        class function GetTutor(TutorJSON: TJSONValue): TTutor;
        class function DayStringToIndex(WeekDay: String): Integer;
        class function GetSubject(SubjectJSON: TJSONObject): TSubject;
        class function GetWeekNums(WeeksJSON: TJSONArray): TWeekNums;
        class function GetWeek(JSON: String): TWeek;
    end;

implementation

class function TJsonFactory.GetWeekNums(WeeksJSON: TJSONArray): TWeekNums;
var
    I: Integer;
begin
    for I := 0 to High(Result) do
        Result[I] := False;
    for I := 0 to WeeksJSON.Count - 1 do
        Result[StrToInt(WeeksJSON.Items[I].ToString)] := true;
end;

class function TJsonFactory.GetTutor(TutorJSON: TJSONValue): TTutor;
var
    FirstName, LastName, MiddleName, PhotoLink, FIO, Id: string;

begin
    with TutorJSON do
    begin
        FirstName := FindValue('firstName').Value;
        LastName := FindValue('lastName').Value;
        MiddleName := FindValue('middleName').Value;
        PhotoLink := FindValue('photoLink').Value;
        FIO := FindValue('fio').Value;
        Id := FindValue('id').Value;
        Result := TTutor.Create(FirstName, LastName, MiddleName,
          PhotoLink, FIO, Id);
    end;
end;

class function TJsonFactory.GetSubject(SubjectJSON: TJSONObject): TSubject;
var
    Weeks: TWeekNums;
    StartTime, EndTime, SubjectName, Auditory, SubjectType, Note, Group,
      SubGroup: String;
    Tutor: TTutor;
begin
    with SubjectJSON do
    begin
        StartTime := FindValue('startLessonTime').Value;
        EndTime := FindValue('endLessonTime').Value;
        SubjectName := FindValue('subject').Value;
        if (FindValue('auditory') as TJSONArray).Count > 0 then
            Group := (FindValue('studentGroup') as TJSONArray).Items[0].Value
        else
            Group := '';
        if (FindValue('auditory') as TJSONArray).Count > 0 then
            Auditory := (FindValue('auditory') as TJSONArray).Items[0].Value
        else
            Auditory := '';
        if (SubjectJSON.FindValue('employee') as TJSONArray).Count > 0 then
            Tutor := GetTutor((SubjectJSON.FindValue('employee')
              as TJSONArray).Items[0])
        else
        begin
            Tutor := TTutor.Create('', '', '', '', '', '');
        end;
        Weeks := GetWeekNums(FindValue('weekNumber') as TJSONArray);
        SubjectType := FindValue('lessonType').Value;
        SubGroup := FindValue('numSubgroup').Value;
        if SubGroup = '0' then
              SubGroup := '';
        Note := FindValue('note').Value;
        if Note = 'null' then
            Note := '';
        Result := TSubject.Create(StartTime, EndTime, SubjectName, Auditory,
          SubjectType, Group, Note, SubGroup, Weeks, Tutor);
    end;
end;

class function TJsonFactory.DayStringToIndex(WeekDay: String): Integer;
begin
    if WeekDay = 'Понедельник' then
        Result := 0
    else if WeekDay = 'Вторник' then
        Result := 1
    else if WeekDay = 'Среда' then
        Result := 2
    else if WeekDay = 'Четверг' then
        Result := 3
    else if WeekDay = 'Пятница' then
        Result := 4
    else if WeekDay = 'Суббота' then
        Result := 5;
end;

class function TJsonFactory.GetWeek(JSON: String): TWeek;
var
    I, J, WeekIndex: Integer;
    JSONDaysArray, JSONSubjectsArray: TJSONArray;
    DayName: String;
    Subjects: TSubjects;
    Subject: TSubject;
begin
    for I := 0 to High(Result) do
        Result[I] := nil;
    JSONDaysArray := TJSONObject.ParseJSONValue(JSON).FindValue('schedules')
      as TJSONArray;
    for I := 0 to JSONDaysArray.Count - 1 do
    begin
        DayName := JSONDaysArray.Items[I].FindValue('weekDay').Value;
        WeekIndex := DayStringToIndex(DayName);
        JSONSubjectsArray := JSONDaysArray.Items[I].FindValue('schedule')
          as TJSONArray;
        Subjects := TSubjects.Create();
        for J := 0 to JSONSubjectsArray.Count - 1 do
        begin
            Subject := GetSubject(JSONSubjectsArray.Items[J] as TJSONObject);
            Subjects.Add(Subject);
        end;
        Result[WeekIndex] := TDay.Create(Subjects, DayName);
    end;
end;

class function TJsonFactory.GetTutorSchedule(JSON: string): TSchedule;
var
    Info, PhotoLink: String;
begin
    Info := TJSONObject.ParseJSONValue(JSON).FindValue('employee')
      .FindValue('fio').Value;
    PhotoLink := TJSONObject.ParseJSONValue(JSON).FindValue('employee')
      .FindValue('photoLink').Value;
    Result := TSchedule.Create(GetWeek(JSON), TScheduleType.TutorSchedule, Info,
      PhotoLink);
end;

class function TJsonFactory.GetGroupShedule(JSON: String): TSchedule;
var
    Info: String;
begin
    Info := TJSONObject.ParseJSONValue(JSON).FindValue('studentGroup')
      .FindValue('name').Value;
    Result := TSchedule.Create(GetWeek(JSON), TScheduleType.GroupSchedule,
      Info, '');
end;

class function TJsonFactory.GetTutors(JSON: String): TTutorsList;
var
    JSONArray: TJSONArray;
    I: Integer;
begin
    JSONArray := TJSONObject.ParseJSONValue(JSON) as TJSONArray;
    Result := TTutorsList.Create;
    for I := 0 to JSONArray.Count - 1 do
    begin
        with JSONArray do
        begin
            Result.Add(TTutor.Create(Items[I].FindValue('firstName').Value,
              Items[I].FindValue('lastName').Value,
              Items[I].FindValue('middleName').Value,
              Items[I].FindValue('photoLink').Value, Items[I].FindValue('fio')
              .Value, Items[I].FindValue('id').Value));
        end;
    end;
end;

class function TJsonFactory.GetGroups(JSON: String): TGroupsList;
var
    JSONArray: TJSONArray;
    I: Integer;
    Course: Byte;
begin
    JSONArray := TJSONObject.ParseJSONValue(JSON) as TJSONArray;
    Result := TGroupsList.Create;
    for I := 0 to JSONArray.Count - 1 do
    begin
        if not JSONArray.Items[I].FindValue('course').TryGetValue<Byte>(Course)
        then
            Course := 0;
        Result.Add(TGroup.Create(JSONArray.Items[I].FindValue('name')
          .Value, Course));
    end;
end;

end.
