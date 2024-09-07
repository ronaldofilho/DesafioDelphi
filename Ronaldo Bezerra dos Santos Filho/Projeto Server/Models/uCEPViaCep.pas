unit uCEPViaCep;

interface
uses uCEPGenerics, System.JSON, uEnumrationsList;

type
  TViaCepModel = class(TCEPGenerics)

  public
    class function New: TCEPGenerics;override;
  end;

implementation

{ TViaCepModel }

class function TViaCepModel.New: TCEPGenerics;
begin
  result := TViaCepModel.create;
  result.SetSiteType(ESiteType.etsViaCep);
end;

end.
