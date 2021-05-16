program ÑourseWork;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {$R *.res},
  Group in 'Group.pas',
  Parser in 'Parser.pas',
  Subject in 'Subject.pas',
  Schedule in 'Schedule.pas',
  Day in 'Day.pas',
  JsonFactory in 'JsonFactory.pas',
  Tutor in 'Tutor.pas',
  CustomTypes in 'CustomTypes.pas';

{$R *.res}

begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TForm4, Form4);
  Application.Run;

end.
