unit uTreatJsonSearch;

interface
uses System.JSON, SysUtils;
type
  TTreatJsonSearch = class
  private
    FoJson: TJSONObject;
  public
    class function New: TTreatJsonSearch;
    function SetJson(AoJson: TJSONObject): TTreatJsonSearch;
    function InvalidJson: boolean;
  end;

implementation

{ TTreatJsonSearch }

class function TTreatJsonSearch.New: TTreatJsonSearch;
begin
  result := TTreatJsonSearch.create;
end;

function TTreatJsonSearch.SetJson(AoJson: TJSONObject): TTreatJsonSearch;
begin
  result := Self;
  FoJson := AoJson;
end;

function TTreatJsonSearch.InvalidJson: boolean;
var
  sError: string;
  sCode: string;
begin
  result := (FoJson.TryGetValue<string>('error', sError) and (sError <> EmptyStr));
end;

end.
