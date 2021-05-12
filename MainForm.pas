unit MainForm;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdHTTP, Vcl.StdCtrls, IdBaseComponent,
    IdComponent, IdTCPConnection, System.Net.HttpClient,
    Parser, JsonFactory, CustomTypes, Vcl.ExtCtrls, PngImage,
    Schedule, Vcl.Imaging.jpeg, IdTCPClient, ScheduleList;

type
    TForm4 = class(TForm)
        Button1: TButton;
        Memo1: TMemo;
        Memo2: TMemo;
        CBGroups: TComboBox;
        Button2: TButton;
        Image1: TImage;
        Button3: TButton;
        Label1: TLabel;
        CBTutors: TComboBox;
        GroupMonday: TGroupBox;
        LabelSchedule1: TLabel;
        GroupTuesday: TGroupBox;
        LabelSchedule2: TLabel;
        GroupWednesday: TGroupBox;
        LabelSchedule3: TLabel;
        GroupThursday: TGroupBox;
        LabelSchedule4: TLabel;
        GroupFriday: TGroupBox;
        LabelSchedule5: TLabel;
        GroupSaturday: TGroupBox;
        LabelSchedule6: TLabel;
        Image2: TImage;
        Image3: TImage;
        Image4: TImage;
        Image5: TImage;
        Image6: TImage;
        Image7: TImage;
        TestLabel: TLabel;
        WeekNumberLabel: TLabel;
        ScrollBox: TScrollBox;
        Image8: TImage;
        IdHTTP1: TIdHTTP;
        CBReady: TComboBox;
        Button4: TButton;
        procedure Button1Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure Button4Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    Form4: TForm4;
    Tutors: TTutorsArray;
    Parser: MyTparser;
    CurrentWeek: Byte;
    Schedules: TScheduleList;

implementation

{$R *.dfm}

procedure FillTutuors();
var
    I: Integer;
    NewImage: TImage;
    NewLabel: TLabel;
    NewPannel: TPanel;
    jpg: TJPEGImage;
    fs: TFileStream;
begin
    { SetLength(Panels, 25);
      for I := 0 to 20 do
      begin
      NewPannel := TPanel.Create(Form4);
      NewPannel.parent := Form4.ScrollBox;
      NewPannel.Left := 20;
      NewPannel.Width := 300;
      NewPannel.Height := 80;
      NewPannel.top := I * 100;
      NewLabel := TLabel.Create(Form4);
      NewLabel.Caption := Tutors[I].Fio;
      NewLabel.parent := NewPannel;
      NewLabel.top := 20 * I;
      NewImage := TImage.Create(Form4);
      NewImage.top := 0;
      NewImage.Left := 0;
      NewImage.parent := NewPannel;

      { try
      ShowMessage('');
      fs := TFileStream.Create(IntToStr(I) + '.png', fmCreate);
      IdHTTP1.Get(Tutors[I].PhotoLink, fs);
      NewImage.Picture.LoadFromFile(IntToStr(I) + '.png');

      finally
      fs.Free;
      end; }
    { NewImage.Height := 50;
      NewImage.Width := 50;

      Panels[I] := NewPannel;
      end; }
end;

procedure DisplayGroups(Inp: TGroupsArray);
var
    I: Integer;
begin
    for I := 0 to High(Inp) do
    begin
        Form4.Memo1.Lines.Add(Inp[I].ToString);
        Form4.CBGroups.Items.Add(Inp[I].Id)
    end;
end;

procedure DisplayTutors(Inp: TTutorsArray);
var
    I: Integer;
begin
    SetLength(Tutors, length(Tutors));
    Tutors := Inp;
    for I := 0 to High(Inp) do
    begin
        Form4.Memo2.Lines.Add(Inp[I].ToString);
        Form4.CBTutors.Items.Add(Inp[I].Fio);

    end;
    // FillTutuors();
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
    if (CBGroups.Items.IndexOf(CBGroups.Text) <> -1) then
    begin
        Parser.GetGroupSchedule(CBGroups.Text);
    end
    else
    begin
        ShowMessage('Такой группы не существует');
        // Parser.Resume;
    end;
end;

procedure A(sch: Tschedule);
begin
    Schedules.Schedules.Add(sch);
    Form4.CBReady.Items.Add(sch.Info);
    Form4.LabelSchedule1.Caption := sch.GetWeek(CurrentWeek)[0].ToString;
    Form4.LabelSchedule2.Caption := sch.GetWeek(CurrentWeek)[1].ToString;
    Form4.LabelSchedule3.Caption := sch.GetWeek(CurrentWeek)[2].ToString;
    Form4.LabelSchedule4.Caption := sch.GetWeek(CurrentWeek)[3].ToString;
    Form4.LabelSchedule5.Caption := sch.GetWeek(CurrentWeek)[4].ToString;
    Form4.LabelSchedule6.Caption := sch.GetWeek(CurrentWeek)[5].ToString;
    // Form4.TestLabel.Caption := sch.GetDayShedule(2).ToString;
end;

procedure TForm4.Button2Click(Sender: TObject);
var
    HttpClient: THttpClient;
    Png: TPngObject;
begin
    if (CBTutors.Items.IndexOf(CBTutors.Text) <> -1) then
    begin
        Parser.GetTutorSchedule(Tutors[CBTutors.ItemIndex].Id);
    end
    else
    begin
        ShowMessage('Такой группы не существует');
        // Parser.Resume;
    end;
end;

procedure TForm4.Button3Click(Sender: TObject);
var
    fs: TFileStream;
begin
    fs := TFileStream.Create('1.png', fmCreate);
    IdHTTP1.Get('http://img.yandex.net/i/www/logo.png', fs);
    fs.Free;
    Self.Image8.Picture.LoadFromFile('1.png');
end;

procedure TForm4.Button4Click(Sender: TObject);
var
    sch: Tschedule;
begin
    A(Schedules.Schedules[CBReady.Items.IndexOf(CBReady.Text)]);

end;

procedure B(Inp: Tschedule);
var
    sch: TWeek;
begin
    Schedules.Schedules.Add(Inp);
    Form4.CBReady.Items.Add(Inp.Info);
    sch := Inp.GetWeek(CurrentWeek);
    Form4.LabelSchedule1.Caption := sch[0].ToString;
    Form4.LabelSchedule2.Caption := sch[1].ToString;
    Form4.LabelSchedule3.Caption := sch[2].ToString;
    Form4.LabelSchedule4.Caption := sch[3].ToString;
    Form4.LabelSchedule5.Caption := sch[4].ToString;
    Form4.LabelSchedule6.Caption := sch[5].ToString;
end;

procedure WeekReady(Week: Byte);
begin
    CurrentWeek := Week;
    Form4.WeekNumberLabel.Caption := 'номер текущей недели: ' + IntToStr(Week);
end;

procedure TForm4.FormCreate(Sender: TObject);
var
    I: Integer;
    NewImage: TImage;
    NewLabel: TLabel;
    NewPannel: TPanel;
begin
    Schedules := TScheduleList.Create;
    { NewLabel := TLabel.Create(Self);
      NewLabel.Caption := 'ffffffffffffffffffffffff';
      NewLabel.Top := 0;
      NewLabel.Left := 0;
      NewLabel.parent := Form4.PanelTutor1; }
    Parser := MyTparser.Create(true);
    Parser.OnGroupsReady := DisplayGroups;
    Parser.OnTutorsReady := DisplayTutors;
    Parser.OnGroupScheduleReady := A;
    Parser.OnTutorScheduleReady := B;

    Parser.OnWeekReady := WeekReady;
    Parser.Start();
end;

end.
