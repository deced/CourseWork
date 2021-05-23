unit ShowSubject;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Subject, Vcl.StdCtrls, Vcl.ExtCtrls,
    IdHttp, IdURI,
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, JPEG,
    ImageParser;

type
    TShowSubjectForm = class(TForm)
        Image1: TImage;
        TutorLabel: TLabel;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label6: TLabel;
        SubjectNameEdit: TEdit;
        StartTimeEdit: TEdit;
        EndTimeEdit: TEdit;
        GroupEdit: TEdit;
        SubjectTypeComboBox: TComboBox;
        AuditoryEdit: TEdit;
        SaveButton: TButton;
        CancelButton: TButton;
        NoteEdit: TEdit;
        Label7: TLabel;
        SubGroupEdit: TEdit;
        Label8: TLabel;
        procedure SaveButtonClick(Sender: TObject);
        procedure CancelButtonClick(Sender: TObject);
    private
        { Private declarations }
    public
        Subject: TSubject;
        procedure LoadSubject(Subject: TSubject);
        procedure LoadSubjectForEditind(Subject: TSubject);
        procedure DisplayImage(MS: TMemoryStream);
    end;

var
    ShowSubjectForm: TShowSubjectForm;

implementation

{$R *.dfm}

procedure LoadImage(MS: TMemoryStream);
begin
    ShowSubjectForm.Image1.Picture.LoadFromStream(MS);
end;

procedure TShowSubjectForm.CancelButtonClick(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

procedure TShowSubjectForm.DisplayImage(MS: TMemoryStream);
begin
    Image1.Picture.LoadFromStream(MS);
end;

procedure TShowSubjectForm.LoadSubjectForEditind(Subject: TSubject);
begin
    self.Subject := Subject;
    SubjectNameEdit.Enabled := true;
    SubjectTypeComboBox.Enabled := true;
    StartTimeEdit.Enabled := true;
    EndTimeEdit.Enabled := true;
    GroupEdit.Enabled := true;
    AuditoryEdit.Enabled := true;
    NoteEdit.Enabled := true;
    SubGroupEdit.Enabled := true;
    SaveButton.Visible := true;
    CancelButton.Visible := true;
    LoadSubject(Subject);

end;

procedure TShowSubjectForm.SaveButtonClick(Sender: TObject);
begin
    Subject.SubjectName := SubjectNameEdit.Text;
    Subject.SubjectType := SubjectTypeComboBox.Text;
    Subject.StartTime := StartTimeEdit.Text;
    Subject.EndTime := EndTimeEdit.Text;
    Subject.Group := GroupEdit.Text;
    Subject.Auditory := AuditoryEdit.Text;
    Subject.Note := NoteEdit.Text;
    Subject.SubGroup := SubGroupEdit.Text;
    ModalResult := mrYes;
end;

procedure TShowSubjectForm.LoadSubject(Subject: TSubject);
var
    ImageParser: TImageParser;
begin
    SubjectNameEdit.Text := Subject.SubjectName;
    SubjectTypeComboBox.Text := Subject.SubjectType;
    StartTimeEdit.Text := Subject.StartTime;
    EndTimeEdit.Text := Subject.EndTime;
    TutorLabel.Caption := Subject.Tutor.LastName + ' ' + Subject.Tutor.FirstName
      + ' ' + Subject.Tutor.MiddleName;
    GroupEdit.Text := Subject.Group;
    AuditoryEdit.Text := Subject.Auditory;
    NoteEdit.Text := Subject.Note;
    SubGroupEdit.Text := Subject.SubGroup;
    if Subject.Tutor.PhotoLink <> '' then
    begin
        ImageParser := TImageParser.create(true);
        ImageParser.OnImageParsed := DisplayImage;
        ImageParser.LoadImage(Subject.Tutor.PhotoLink);
    end;
end;

end.
