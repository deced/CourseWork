program ÑourseWork;



uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Group in 'Group.pas',
  Parser in 'Parser.pas',
  Subject in 'Subject.pas',
  Schedule in 'Schedule.pas',
  Day in 'Day.pas',
  JsonFactory in 'JsonFactory.pas',
  Tutor in 'Tutor.pas',
  CustomTypes in 'CustomTypes.pas',
  IO in 'IO.pas',
  ShowSubject in 'ShowSubject.pas' {ShowSubjectForm},
  SubjectLabel in 'SubjectLabel.pas',
  ImageParser in 'ImageParser.pas',
  ScheduleLabel in 'ScheduleLabel.pas',
  ClassRooms in 'ClassRooms.pas' {ClassRoomsForm},
  ClassRoom in 'ClassRoom.pas',
  ClassRoomsParser in 'ClassRoomsParser.pas',
  AuditorySubject in 'AuditorySubject.pas';

{$R *.res}

begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TShowSubjectForm, ShowSubjectForm);
  Application.CreateForm(TClassRoomsForm, ClassRoomsForm);
  Application.Run;

end.
