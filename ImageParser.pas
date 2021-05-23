unit ImageParser;

interface

uses System.Classes, CustomTypes, IdHttp, SysUtils, Vcl.ExtCtrls, Vcl.Forms;

type
    TImageParser = class(TThread)
        Url: String;
        OnImageParsed: TImageParsedEvent;
        procedure LoadImage(Path: String);
    private
        procedure Execute; override;
    end;

implementation

procedure TImageParser.LoadImage(Path: String);
begin
    Url := Path;
    Self.Start;
end;

function IsResFile(Path: String): Boolean;
begin
    Result := FileExists(Path);
end;

function FileAlreadyExists(Link: String): Boolean;
begin
    Result := FileExists(ExtractFileName(Link.Replace('/', '\') + '.jpg')) or
      FileExists(ExtractFileName(Link.Replace('/', '\') + '.png'));
end;

function GetFilePath(Link: String): String;
begin
    if FileExists(ExtractFileName(Link.Replace('/', '\') + '.jpg')) then
        Result := ExtractFileName(Link.Replace('/', '\') + '.jpg')
    else
        Result := ExtractFileName(Link.Replace('/', '\') + '.png');
end;

function GetFileExt(MS: TMemoryStream): String;
var
    LOl: Word;
begin
    MS.seek(0, 0);
    MS.Read(LOl, SizeOf(LOl));
    MS.Position := 0;
    if LOl = $D8FF then
        Result := '.jpg'
    else if LOl = $5089 then
        Result := '.png';
end;

procedure TImageParser.Execute;
var
    MS: TMemoryStream;
    IdHttp: TIdHTTP;
begin
    MS := TMemoryStream.Create;
    if IsResFile(Url) then
        MS.LoadFromFile(Url)
    else if FileAlreadyExists(Url) then
    begin
        MS.LoadFromFile(GetFilePath(Url));
    end
    else
    begin
        IdHttp := TIdHTTP.Create(nil);
        MS.LoadFromFile(ExtractFilePath(Application.ExeName) +
          DefaultTutorPicture);
        MS := TMemoryStream.Create;
        try
            IdHttp.get(Url, MS);
            MS.seek(0, soFromBeginning);
            MS.LoadFromStream(MS);
            MS.SaveToFile(ExtractFileName(Url.Replace('/', '\')) +
              GetFileExt(MS));
        except
            MS.LoadFromFile(ExtractFilePath(Application.ExeName) +
              DefaultTutorPicture);
        end;
    end;
    OnImageParsed(MS);
end;

end.
