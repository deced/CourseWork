unit ClassRoom;

interface
type
    TClassRoom = class
    private
        Number: String;
        Floor: Byte;
    public
        function ToString(): string;
        constructor Create();
    end;
implementation
function TClassRoom.ToString(): String;
var
    I: Integer;
begin
    Result := '';
end;

constructor TClassRoom.Create();
begin

end;

end.
