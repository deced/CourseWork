unit Tutor;

interface

type
    TTutor = class
        FirstName, LastName, MiddleName, PhotoLink, Fio, Id: String;
        function ToString(): String;
        constructor Create(FirstName, LastName, MiddleName, PhotoLink, Fio,
          Id: String);
    end;

implementation

function TTutor.ToString(): String;
begin
    Result := FirstName + ' ' + LastName + ' ' + MiddleName;
end;

constructor TTutor.Create(FirstName, LastName, MiddleName, PhotoLink, Fio,
  Id: String);
begin
    Self.FirstName := FirstName;
    Self.LastName := LastName;
    Self.MiddleName := MiddleName;
    Self.PhotoLink := PhotoLink;
    Self.Fio := Fio;
    Self.Id := Id;
end;

end.
