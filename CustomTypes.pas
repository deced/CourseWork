unit CustomTypes;

interface

uses Group, Tutor, Day, Schedule, Generics.Collections, System.Classes;

type
    TGroupsList = TList<TGroup>;
    TTutorsList = TList<TTutor>;
    TGroupsParsedEvent = procedure(Result: TGroupsList);
    TTutorsParsedEvent = procedure(Result: TTutorsList);
    TGroupSheduleParsedEvent = procedure(Result: TSchedule);
    TTutorScheduleParsedEvent = procedure(Result: TSchedule);
    TWeekParsed = procedure(Result: Byte);

implementation

end.
