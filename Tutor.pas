unit Tutor;

interface

type
    TTutor = class
    private
        FFirstName, FLastName, FMiddleName, FPhotoLink, FFio, FId: String;
    public
        property FirstName: String read FFirstName write FFirstName;
        property LastName: String read FLastName write FLastName;
        property MiddleName: String read FMiddleName write FMiddleName;
        property PhotoLink: String read FPhotoLink write FPhotoLink;
        property Fio: String read FFio write FFio;
        property Id: String read FId write FId;
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
