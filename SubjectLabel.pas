unit SubjectLabel;

interface

uses Vcl.StdCtrls, Vcl.Controls, Subject, Vcl.Graphics, Vcl.ExtCtrls,
    System.Types, Windows, Vcl.Menus;

type
    TSubjectLabel = class
        SubjectName, Auditory, TimeStart, TimeEnd, Tutor, Group: TLabel;
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
    end;

implementation

procedure TSubjectLabel.SetText(Subject: TSubject);
begin
    SubjectName.Visible := true;
    SubjectName.Visible := true;
    Auditory.Visible := true;
    TimeStart.Visible := true;
    TimeEnd.Visible := true;
    Tutor.Visible := true;
    Group.Visible := true;
    SubjectColor.Visible := true;
    Bevel.Visible := true;
    SubjectName.Caption := Subject.SubjectName + ' (' +
      Subject.SubjectType + ')';
    Auditory.Caption := Subject.Auditory;
    TimeStart.Caption := Subject.StartTime;
    TimeEnd.Caption := Subject.EndTime;
    Tutor.Caption := Subject.Tutor.Fio;
    Group.Caption := Subject.Group;
    if Subject.SubjectType = 'ЛК' then
        SubjectColor.Canvas.Brush.Color := 2930990
    else if Subject.SubjectType = 'ПЗ' then
        SubjectColor.Canvas.Brush.Color := 4639431
    else if Subject.SubjectType = 'ЛР' then
        SubjectColor.Canvas.Brush.Color := 1513124;
    SubjectColor.Canvas.FillRect(SubjectColor.Canvas.ClipRect);
    SubjectColor.Visible := true;
    Bevel.Visible := true;
end;

procedure TSubjectLabel.Clear();
begin
    SubjectName.Visible := false;
    SubjectName.Visible := false;
    Auditory.Visible := false;
    TimeStart.Visible := false;
    TimeEnd.Visible := false;
    Tutor.Visible := false;
    Group.Visible := false;
    SubjectColor.Visible := false;
    Bevel.Visible := false;
    // SubjectName.Caption := '';
    // Auditory.Caption := '';
    // TimeStart.Caption := '';
    // TimeEnd.Caption := '';
    // Tutor.Caption := '';
    // Group.Caption := '';
    // SubjectColor.Visible := false;
    // Bevel.Visible := false;
end;

procedure TSubjectLabel.SetLocation(Y: Integer);
begin
    SubjectName.Left := 90;
    SubjectName.Top := Y;
    Auditory.Left := 90;
    Auditory.Top := Y + 30;
    TimeStart.Left := 0;
    TimeStart.Top := Y;
    TimeEnd.Left := 0;
    TimeEnd.Top := Y + 30;
    Tutor.Left := 240;
    Tutor.Top := Y + 30;
    SubjectColor.Top := Y + 5;
    SubjectColor.Left := 70;
    Bevel.Left := 0;
    Bevel.Top := Y;
    Group.Left := 240;
    Group.Top := Y;
end;

procedure TSubjectLabel.SetFontSize();
begin
    SubjectName.Font.Size := 16;
    Auditory.Font.Size := 16;
    TimeEnd.Font.Size := 16;
    Tutor.Font.Size := 16;
    Group.Font.Size := 16;
    TimeStart.Font.Size := 16;
end;

procedure TSubjectLabel.SetParent(Parent: TWinControl);
begin
    Bevel.Parent := Parent;
    SubjectName.Parent := Parent;
    Auditory.Parent := Parent;
    TimeEnd.Parent := Parent;
    Tutor.Parent := Parent;
    SubjectColor.Parent := Parent;
    TimeStart.Parent := Parent;
    Group.Parent := Parent;
end;

procedure TSubjectLabel.CreateControls(Parent: TWinControl);
begin
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
