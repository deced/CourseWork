unit Group;

interface

uses SysUtils;

type
    TGroup = class
    private
        FId: String;
        FCource: Byte;
    public
        property Id: String read FId write FId;
        property Cource: Byte read FCource write FCource;
        function ToString(): string;
        constructor Create(GroupId: String; Course: Byte);
    end;

implementation

function TGroup.ToString;
begin
    Result := 'Группа ' + Id + ', Курс ' + IntToStr(Cource);
end;

constructor TGroup.Create(GroupId: string; Course: Byte);
begin
    Self.Id := GroupId;
    Self.Cource := Course;
end;

end.
