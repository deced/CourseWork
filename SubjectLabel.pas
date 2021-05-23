unit SubjectLabel;

interface

uses Vcl.StdCtrls, Vcl.Controls, Subject, Vcl.Graphics, Vcl.ExtCtrls,
    System.Types, Windows, Vcl.Menus;

type
    TSubjectLabel = class
        SubjectName, Auditory, TimeStart, TimeEnd, Tutor, Group, Note,
          SubGroup: TLabel;
        Bevel: TBevel;
        PopUpMenu: TPopupMenu;
        SubjectColor: TImage;
        procedure Clear();
        procedure SetLocation(Y: Integer);
        procedure SetText(Subject: TSubject);
        constructor Create(Parent: TWinControl; Y: Integer);
    private
        procedure SetFontSize();
        procedure SetParent(Parent: TWinControl);
        procedure CreateControls(Parent: TWinControl);
        procedure ConfigureBevel(Parent: TWinControl);
        procedure ConfirureImage();
        procedure ConfigurePopupMenu();
        procedure ConfigureTimeLabels(Parent: TWinControl);
        procedure SetSubjectColor(Subject: TSubject);
        procedure SetVisibility(Value: Boolean);
        procedure CorrectLocation();
    end;

implementation

procedure TSubjectLabel.SetVisibility(Value: Boolean);
begin
    SubjectName.Visible := Value;
    Auditory.Visible := Value;
    TimeStart.Visible := Value;
    TimeEnd.Visible := Value;
    Tutor.Visible := Value;
    Group.Visible := Value;
    SubjectColor.Visible := Value;
    Bevel.Visible := Value;
    Note.Visible := Value;
    SubGroup.Visible := Value;
end;

procedure TSubjectLabel.SetSubjectColor(Subject: TSubject);
begin
    if Subject.SubjectType = 'ЛК' then
        SubjectColor.Canvas.Brush.Color := 2930990
    else if Subject.SubjectType = 'ПЗ' then
        SubjectColor.Canvas.Brush.Color := 4639431
    else if Subject.SubjectType = 'ЛР' then
        SubjectColor.Canvas.Brush.Color := 1513124;
    SubjectColor.Canvas.FillRect(SubjectColor.Canvas.ClipRect);
    SubjectColor.Visible := true;
end;

procedure TSubjectLabel.CorrectLocation();
begin
    if Group.Left - (SubjectName.Left + SubjectName.Width) < 10 then
    begin
        Group.Left := SubjectName.Left + SubjectName.Width + 10;
        SubGroup.Left := Group.Left;
    end;
    if Tutor.Left - (Group.Left + Group.Width) < 10 then
        Tutor.Left := Group.Left + Group.Width + 10;
    if (Note.Caption <> '') and (SubGroup.Caption <> '') then
    begin
        Note.Left := SubGroup.Left + SubGroup.Width + 10;
    end;
end;

procedure TSubjectLabel.SetText(Subject: TSubject);
begin
    SetVisibility(true);
    SetSubjectColor(Subject);
    SubjectName.Caption := Subject.SubjectName + ' (' +
      Subject.SubjectType + ')';
    Auditory.Caption := Subject.Auditory;
    TimeStart.Caption := Subject.StartTime;
    TimeEnd.Caption := Subject.EndTime;
    Tutor.Caption := Subject.Tutor.Fio;
    Group.Caption := Subject.Group;
    Note.Caption := Subject.Note;
    if Subject.SubGroup <> '' then
        SubGroup.Caption := 'Подгр. ' + Subject.SubGroup
    else
        SubGroup.Caption := '';
    CorrectLocation();
end;

procedure TSubjectLabel.Clear();
begin
    SetVisibility(false);
end;

procedure TSubjectLabel.SetLocation(Y: Integer);
begin
    SubjectName.Left := 90;
    SubjectName.Top := Y;
    Group.Left := 220;
    Group.Top := Y;

    Auditory.Left := 90;
    Auditory.Top := Y + 30;
    TimeStart.Left := 0;
    TimeStart.Top := Y;
    TimeEnd.Left := 0;
    TimeEnd.Top := Y + 30;
    Tutor.Left := 300;
    Tutor.Top := Y;
    SubjectColor.Top := Y + 5;
    SubjectColor.Left := 70;
    Bevel.Left := 0;
    Bevel.Top := Y;
    Note.Top := Y + 30;
    SubGroup.Top := Y + 30;
    Note.Left := 220;
    SubGroup.Left := 220;
end;

procedure TSubjectLabel.SetFontSize();
begin
    SubjectName.Font.Size := 16;
    Auditory.Font.Size := 16;
    TimeEnd.Font.Size := 16;
    Tutor.Font.Size := 16;
    Group.Font.Size := 16;
    TimeStart.Font.Size := 16;
    Note.Font.Size := 16;
    SubGroup.Font.Size := 16;
end;

procedure TSubjectLabel.SetParent(Parent: TWinControl);
begin
    SubGroup.Parent := Parent;
    Note.Parent := Parent;
    Bevel.Parent := Parent;
    SubjectName.Parent := Parent;
    Auditory.Parent := Parent;
    TimeEnd.Parent := Parent;
    Tutor.Parent := Parent;
    SubjectColor.Parent := Parent;
    Group.Parent := Parent;
    TimeStart.Parent := Parent;
end;

procedure TSubjectLabel.CreateControls(Parent: TWinControl);
begin
    SubGroup := TLabel.Create(Parent);
    Note := TLabel.Create(Parent);
    TimeStart := TLabel.Create(Parent);
    PopUpMenu := TPopupMenu.Create(Parent);
    Bevel := TBevel.Create(Parent);
    SubjectName := TLabel.Create(Parent);
    Auditory := TLabel.Create(Parent);
    TimeEnd := TLabel.Create(Parent);
    Tutor := TLabel.Create(Parent);
    Group := TLabel.Create(Parent);
    SubjectColor := TImage.Create(Parent);
end;

procedure TSubjectLabel.ConfigureBevel(Parent: TWinControl);
begin
    Bevel.Height := 62;
    Bevel.Width := Parent.Width;
    Bevel.Shape := bsFrame;
end;

procedure TSubjectLabel.ConfirureImage();
begin
    SubjectColor.Width := 8;
    SubjectColor.Height := 46;
end;

procedure TSubjectLabel.ConfigurePopupMenu();
var
    MenuItemChange, MenuItemDelete: TMenuItem;
begin
    MenuItemChange := TMenuItem.Create(PopUpMenu);
    MenuItemChange.Caption := 'Изменить';
    MenuItemDelete := TMenuItem.Create(PopUpMenu);
    MenuItemDelete.Caption := 'Удалить';

    PopUpMenu.Items.Add(MenuItemChange);
    PopUpMenu.Items.Add(MenuItemDelete);
end;

procedure TSubjectLabel.ConfigureTimeLabels(Parent: TWinControl);
begin
    TimeEnd.Font.Style := [fsBold];

    TimeStart.AutoSize := false;
    TimeStart.Height := 62;
    TimeStart.Width := Parent.Width;
    TimeStart.PopUpMenu := PopUpMenu;
    TimeStart.Cursor := crHandPoint;
end;

constructor TSubjectLabel.Create(Parent: TWinControl; Y: Integer);
var
    MenuItemChange, MenuItemDelete: TMenuItem;
begin
    CreateControls(Parent);
    ConfigureBevel(Parent);
    ConfigureTimeLabels(Parent);
    ConfigurePopupMenu();
    ConfirureImage();
    SetFontSize();
    SetParent(Parent);
    SetLocation(Y);
end;

end.
