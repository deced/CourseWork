unit ScheduleLabel;

interface

uses Vcl.StdCtrls, Vcl.Controls, Schedule, Vcl.Graphics, Vcl.ExtCtrls,
    System.Types, Windows, Vcl.Menus, ImageParser, System.Classes;

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

    end;

implementation

const
    ImageSize = 100;

procedure TScheduleLabel.CreateControls(Parent: TWinControl);
begin
    Image := TImage.Create(Parent);
    ScheduleInfo := TLabel.Create(Parent);
    Bevel := TBevel.Create(Parent);
end;

procedure TScheduleLabel.SetLocation(Y: Integer);
begin
    Image.Top := Y;
    Image.Left := 0;
    Bevel.Top := Y;
    Bevel.Left := 0;
    ScheduleInfo.Top := Y;
    ScheduleInfo.Left := ImageSize + 5;

end;

procedure TScheduleLabel.Clear();
begin
    Image.Visible := false;
    ScheduleInfo.Visible := false;
    Bevel.Visible := false;
end;

procedure TScheduleLabel.SetText(Schedule: TSchedule);
var
    ImgParser: TImageParser;
begin
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
    ScheduleInfo.Parent := Parent;
    Image.Parent := Parent;
    Bevel.Parent := Parent;
end;

procedure TScheduleLabel.ConfigureBevel(Parent: TWinControl);
begin
    Bevel.Width := Parent.Width;
    Bevel.Height := ImageSize;
end;

procedure TScheduleLabel.ConfigureLabel(Parent: TWinControl);
begin
    ScheduleInfo.AutoSize := false;
    ScheduleInfo.Width := Parent.Width - ImageSize;
    ScheduleInfo.Height := ImageSize;
    ScheduleInfo.Font.Size := 16;
    ScheduleInfo.WordWrap := true;
end;

procedure TScheduleLabel.ConfigureImage();
begin
    Image.Height := ImageSize;
    Image.Width := ImageSize;
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
