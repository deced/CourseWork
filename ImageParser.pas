unit ImageParser;

interface

uses System.Classes, CustomTypes, IdHttp, SysUtils, Vcl.ExtCtrls;

type
    TImageParser = class(TThread)
        Url: String;
        ImageToLoad: TImage;
        procedure LoadImage(Path: String; Image: TImage);
    private
        procedure Execute; override;
    end;

implementation

procedure TImageParser.LoadImage(Path: String; Image: TImage);
begin
    Url := Path;
    ImageToLoad := Image;
    Self.Start;
end;

function FileAlreadyExists(Link: String): Boolean;
begin
    if FileExists(ExtractFileName(Link.Replace('/', '\') + '.jpg')) or
      FileExists(ExtractFileName(Link.Replace('/', '\') + '.png')) then
        Result := true
    else
        Result := false;
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
        Result := '.png'
    else
        Result := 'блять я хуй знает что за оно';
end;

procedure TImageParser.Execute;
var
    MS: TMemoryStream;
    IdHttp: TIdHTTP;
    str: String;
begin
    if FileAlreadyExists(Url) then
    begin
        ImageToLoad.Picture.LoadFromFile(GetFilePath(Url));
    end
    else
    begin
        IdHttp := TIdHTTP.Create(nil);
        MS := TMemoryStream.Create;
        try
            IdHttp.get(Url, MS);
            str := GetFileExt(MS);
            MS.seek(0, soFromBeginning);
            ImageToLoad.Picture.LoadFromStream(MS);
            ImageToLoad.Picture.SaveToFile
              (ExtractFileName(Url.Replace('/', '\') ) +
              GetFileExt(MS));
        finally

        end;
    end;

end;

end.
