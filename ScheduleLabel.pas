unit ScheduleLabel;

interface

uses Vcl.StdCtrls, Vcl.Controls, Schedule, Vcl.Graphics, Vcl.ExtCtrls,
    System.Types, Windows, Vcl.Menus, ImageParser, System.Classes, CustomTypes;

type
    TScheduleLabel = class
        ScheduleInfo: TLabel;
        Image: TImage;
        Bevel: TBevel;
        constructor Create(Parent: TWinControl; Y: Integer);
        procedure Clear();
        procedure SetLocation(Y: Integer);
        procedure SetText(Schedule: TSchedule);
    private
        procedure CreateControls(Parent: TWinControl);
        procedure SetParent(Parent: TWinControl);
        procedure ConfigureBevel(Parent: TWinControl);
        procedure ConfigureLabel(Parent: TWinControl);
        procedure ConfigureImage();
        procedure SetVisibility(Value: Boolean);
    end;

implementation

procedure TScheduleLabel.SetVisibility(Value: Boolean);
begin
    Image.Visible := Value;
    ScheduleInfo.Visible := Value;
    Bevel.Visible := Value;
end;

procedure TScheduleLabel.CreateControls(Parent: TWinControl);
begin
    Image := TImage.Create(Parent);
    Bevel := TBevel.Create(Parent);
    ScheduleInfo := TLabel.Create(Parent);
end;

procedure TScheduleLabel.SetLocation(Y: Integer);
begin
    Image.Top := Y + 2;
    Image.Left := 2;
    Bevel.Top := Y;
    Bevel.Left := 0;
    ScheduleInfo.Top := Y;
    ScheduleInfo.Left := ScheduleItemHeight + 5;

end;

procedure TScheduleLabel.Clear();
begin
    SetVisibility(false);
end;

procedure TScheduleLabel.SetText(Schedule: TSchedule);
var
    ImgParser: TImageParser;
begin
    SetVisibility(true);
    if Schedule.PhotoLink <> '' then
    begin
        ImgParser := TImageParser.Create(true);
        ImgParser.LoadImage(Schedule.PhotoLink, Image);
    end;
    if Schedule.ScheduleType = TScheduleType.TutorSchedule then
        ScheduleInfo.Caption := Schedule.Info
    else
        ScheduleInfo.Caption := 'Группа ' + #13#10 + Schedule.Info;

end;

procedure TScheduleLabel.SetParent(Parent: TWinControl);
begin
    Bevel.Parent := Parent;
    Image.Parent := Parent;
    ScheduleInfo.Parent := Parent;
end;

procedure TScheduleLabel.ConfigureBevel(Parent: TWinControl);
begin
    Bevel.Width := Parent.Width;
    Bevel.Height := ScheduleItemHeight;
end;

procedure TScheduleLabel.ConfigureLabel(Parent: TWinControl);
begin
    ScheduleInfo.AutoSize := false;
    ScheduleInfo.Width := Parent.Width;
    ScheduleInfo.Height := ScheduleItemHeight;
    ScheduleInfo.Font.Size := 16;
    ScheduleInfo.WordWrap := true;
    ScheduleInfo.Cursor := crHandPoint;
end;

procedure TScheduleLabel.ConfigureImage();
begin
    Image.Height := ScheduleItemHeight - 4;
    Image.Width := ScheduleItemHeight - 4;
    Image.Stretch := true;
end;

constructor TScheduleLabel.Create(Parent: TWinControl; Y: Integer);
begin
    CreateControls(Parent);
    SetParent(Parent);
    ConfigureBevel(Parent);
    ConfigureLabel(Parent);
    ConfigureImage();
    SetLocation(Y);

end;

end.
