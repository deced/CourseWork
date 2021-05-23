unit Schedule;

interface

uses Day, System.Generics.Collections, Subject;

type
    TScheduleType = (TutorSchedule, GroupSchedule);
    TWeek = array [0 .. 6] of TDay;

    TSchedule = class
    private
        FWeek: TWeek;
        FScheduleType: TScheduleType;
        FInfo: String;
        FPhotoLink: string;
    public
        property Week: TWeek read FWeek write FWeek;
        property ScheduleType: TScheduleType read FScheduleType
          write FScheduleType;
        property Info: String read FInfo write FInfo;
        property PhotoLink: String read FPhotoLink write FPhotoLink;
        constructor Create(Week: TWeek; ScheduleType: TScheduleType;
          Info: String; PhotoLink: string);
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
    WeekName: String;
begin
    for I := 0 to High(Week) do
    begin
        Subjects := TSubjects.Create();
        if Week[I] <> nil then
        begin
            WeekName := '';
            for J := 0 to Week[I].Subjects.count - 1 do
            begin
                if ContainsInArray(Week[I].Subjects[J].Weeks, WeekIndex) then
                begin
                    Subjects.Add(Week[I].Subjects[J]);
                end;
            end;
            WeekName := Week[I].Name;
        end;
        Result[I] := TDay.Create(Subjects, WeekName);
    end;
end;

constructor TSchedule.Create(Week: TWeek; ScheduleType: TScheduleType;
  Info: String; PhotoLink: string);
begin
    self.Week := Week;
    self.ScheduleType := ScheduleType;
    self.Info := Info;
    self.PhotoLink := PhotoLink;
end;

end.
