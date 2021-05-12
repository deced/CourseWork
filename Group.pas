unit Group;

interface

uses SysUtils;

type
    TGroup = class
        Id: String;
        Cource: Byte;
        function ToString(): string;
        constructor Create(GroupId: String; Course: Byte);
    end;

implementation

function TGroup.ToString;
begin
    Result := '������ ' + Id + ', ���� ' + IntToStr(Cource);
end;

constructor TGroup.Create(GroupId: string; Course: Byte);
begin
    Self.Id := GroupId;
    Self.Cource := Course;
end;

end.
