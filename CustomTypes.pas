unit CustomTypes;

interface

uses Group, Tutor, Day, Schedule,ClassRoom, Generics.Collections,subject, System.Classes,AuditorySubject;

const
    ScheduleItemHeight = 80;
    SubjectItemGeight = 60;
    ScrollStep = 40;
    DefaultGroupPicture = 'res\Group.bmp';
    DefaultTutorPicture = 'res\Default.bmp';

type
    TClasses = TDictionary<string,TList<TClassRoom>>;
    TGroupsList = TList<TGroup>;
    TTutorsList = TList<TTutor>;
    TDictionaryReadyEvent = procedure(Result:TDictionary<string, Tlist<TAuditorySubject>>) of object;
    TAllGroupsParsedEvent = procedure(Result: TList<TSchedule>) of object;
    TGroupsParsedEvent = procedure(Result: TGroupsList) of object;
    TTutorsParsedEvent = procedure(Result: TTutorsList) of object;
    TGroupSheduleParsedEvent = procedure(Result: TSchedule) of object;
    TTutorScheduleParsedEvent = procedure(Result: TSchedule) of object;
    TSchedulesParsedEvent = procedure(Result: TList<TSchedule>) of object;
    TImageParsedEvent = procedure(MS: TMemoryStream) of Object;
    TWeekParsed = procedure(Result: Byte);

implementation

end.
