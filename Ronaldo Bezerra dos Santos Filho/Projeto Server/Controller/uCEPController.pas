unit uCEPController;

interface
uses Horse, uCEPGenerics, REST.Client, uEnumrationsList, SysUtils, uCEPViaCep,
uCEPApiCep, uCEPAwesomeCep, uTreatJsonSearch, System.JSON;

type
  TCEPController = class
    public
    class function New: TCEPController;
    procedure Registry;

    private
    procedure GetCep(AoRequest: THorseRequest; AoResponse: THorseResponse);
    function CepSearch(const AeCep: string; AeTipoSite: ESiteType; var AsStatus: integer): string;
    function ReturnCep(const AsCep: string): string;
    function ExecCepSearche(const AsCep: string; AeSiteType: ESiteType;
      var AsStatus: integer): string;
  end;

implementation

{ TCEPController }

procedure TCEPController.GetCep(AoRequest: THorseRequest; AoResponse: THorseResponse);
var
  FsCep: string;
begin
  FsCep := AoRequest.Params['CEP'];
  AoResponse.Send(ReturnCep(fsCep));
end;

class function TCEPController.New: TCEPController;
begin
  result := TCEPController.Create;
end;

procedure TCEPController.Registry;
begin
  THorse.Get('/cep/:cep', GetCep);
end;

function TCEPController.ExecCepSearche(const AsCep: string; AeSiteType: ESiteType; var AsStatus: integer): string;
begin
  case AeSiteType of
    etsViaCep: result := TViaCepModel.new
                                     .SetJson(CepSearch(AsCep, AeSiteType, AsStatus))
                                     .TreatJson
                                     .ToJson;
    etsApiCep: result := TApiCepModel.new
                                     .SetJson(CepSearch(AsCep, AeSiteType, AsStatus))
                                     .TreatJson
                                     .ToJson;
    etsAwesome: result := TAwesomeCepModel.new
                                          .SetJson(CepSearch(AsCep, AeSiteType, AsStatus))
                                          .TreatJson
                                          .ToJson;
  end;
end;

function TCEPController.ReturnCep(const AsCep: string): string;
var
  oSiteType: ESiteType;
  sStatus: integer;
  sReturn: string;
begin
  result := EmptyStr;
  sStatus := 200;
  for oSiteType in TSearchSite.GetListSearchSite do
  begin
    sReturn := ExecCepSearche(AsCep, oSiteType, sStatus);
    if sStatus = 200 then
    begin
      result := sReturn;
      exit;
    end
    else
    if sStatus = -1 then    
    begin
      result := '{"error":"CEP não localizado"}';
      exit;
    end;
  end;
end;

function TCEPController.CepSearch(const AeCep: string; AeTipoSite: ESiteType; var AsStatus: integer): string;
var
  oRestClient: TRestClient;
  oRestRequest: TRESTRequest;
  oRestResponse: TRestResponse;
begin
  result := '';
  oRestClient := TRESTClient.Create(nil);
  oRestRequest := TRESTRequest.Create(nil);
  oRestResponse := TRESTResponse.Create(nil);
  try
    try
      Writeln('Consultando CEP '+AeCep+' em - '+TSearchSite.GetSiteName(AeTipoSite));
      oRestRequest.Client := oRestClient;
      oRestRequest.Response := oRestResponse;
      oRestRequest.Client.BaseURL := TSearchSite.GetUrlSite(AeCep, AeTipoSite);
      oRestRequest.Execute;
    except on E: Exception do
      begin
        AsStatus := oRestResponse.StatusCode;
        Writeln(TSearchSite.GetSiteName(AeTipoSite)+' - Error=');
        Writeln('-> '+E.message);
        oRestClient.Destroy;
        oRestRequest.Destroy;
        oRestResponse.Destroy;
      end;
    end;
  finally
    AsStatus := oRestResponse.StatusCode;
    if TTreatJsonSearch.New.SetJson((oRestResponse.JSONValue as TJsonObject)).InvalidJson then
    begin
      AsStatus := -1;
    end
    else
    begin
      result := oRestResponse.JSONValue.ToString;
      oRestClient.Destroy;
      oRestRequest.Destroy;
      oRestResponse.Destroy;
    end;
  end;
end;

end.
