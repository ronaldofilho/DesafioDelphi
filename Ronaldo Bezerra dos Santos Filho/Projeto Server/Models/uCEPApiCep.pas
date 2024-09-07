unit uCEPApiCep;


interface
uses uCEPGenerics, System.JSON, uEnumrationsList;

type
  TApiCepModel = class(TCEPGenerics)

  public
    class function New: TCEPGenerics;override;
  end;

implementation

{ TViaCepModel }

class function TApiCepModel.New: TCEPGenerics;
begin
  result := TApiCepModel.create;
  result.SetSiteType(ESiteType.etsApiCep);
end;

end.

