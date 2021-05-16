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
  IO in 'IO.pas';

{$R *.res}

begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
