unit uCEPAwesomeCep;


interface
uses uCEPGenerics, System.JSON, uEnumrationsList;

type
  TAwesomeCepModel = class(TCEPGenerics)

  public
    class function New: TCEPGenerics;override;
  end;

implementation

{ TViaCepModel }

class function TAwesomeCepModel.New: TCEPGenerics;
begin
  result := TAwesomeCepModel.create;
  result.SetSiteType(ESiteType.etsAwesome);
end;

end.

