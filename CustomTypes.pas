unit CustomTypes;

interface

uses Group, Tutor, Day, Schedule;

type
    TGroupsArray = Array of TGroup;
    TTutorsArray = array of TTutor;
    TGroupsParsedEvent = procedure(Result: TGroupsArray);
    TTutorsParsedEvent = procedure(Result: TTutorsArray);
    TGroupSheduleParsedEvent = procedure(Result: TSchedule);
    TTutorScheduleParsedEvent = procedure(Result: TSchedule);
    TWeekParsed = procedure(Result: Byte);

implementation

end.
