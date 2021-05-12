unit CustomTypes;

interface

uses TGroupClass, TTutorClass, TDayClass, TScheduleClass;

type
    TGroupsArray = Array of TGroup;
    TTutorsArray = array of TTutor;
    TGroupsParsedEvent = procedure(Result: TGroupsArray);
    TTutorsParsedEvent = procedure(Result: TTutorsArray);
    TGroupSheduleParsedEvent = procedure(Result: TSchedule);
    TTutorScheduleParsedEvent = procedure(Result: TSchedule);
    TWeekParsed = procedure(Result : Byte);
    // TWeek = array [0 .. 6] of TDay;

implementation

end.
