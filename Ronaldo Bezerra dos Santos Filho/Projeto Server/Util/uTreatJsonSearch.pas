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
  bError: Boolean;
  sCode: string;
begin
  result := ((FoJson.TryGetValue<boolean>('erro', bError) and bError)
         or (FoJson.TryGetValue<string>('code', sCode) and (sCode <> EmptyStr)));
end;

end.
