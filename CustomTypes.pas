unit CustomTypes;

interface

uses Group, Tutor, Day, Schedule, Generics.Collections, System.Classes;

const
    ScheduleItemHeight = 100;
    SubjectItemGeight = 60;

type
    TGroupsList = TList<TGroup>;
    TTutorsList = TList<TTutor>;
    TGroupsParsedEvent = procedure(Result: TGroupsList) of object;
    TTutorsParsedEvent = procedure(Result: TTutorsList) of object;
    TGroupSheduleParsedEvent = procedure(Result: TSchedule) of object;
    TTutorScheduleParsedEvent = procedure(Result: TSchedule) of object;
    TSchedulesParsedEvent = procedure(Result: TList<TSchedule>) of object;
    TWeekParsed = procedure(Result: Byte);

implementation

end.
