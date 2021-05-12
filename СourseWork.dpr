program ÑourseWork;

uses
    Vcl.Forms,
    MainForm in 'MainForm.pas'

{$R *.res},
    TGroupClass in 'TGroupClass.pas',
    TParserClass in 'TParserClass.pas',
    TSubjectClass in 'TSubjectClass.pas',
    TScheduleClass in 'TScheduleClass.pas',
    TDayClass in 'TDayClass.pas',
    TAuditoryClass in 'TAuditoryClass.pas',
    TJsonFactoryClass in 'TJsonFactoryClass.pas',
    CustomTypes in 'CustomTypes.pas';

{$R *.res}

begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TForm4, Form4);
    Application.Run;

end.
