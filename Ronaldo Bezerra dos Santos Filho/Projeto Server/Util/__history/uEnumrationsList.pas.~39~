unit uEnumrationsList;

interface
uses SysUtils;
type
  ESiteType = (etsViaCep, etsApiCep, etsAwesome);

  TSiteTypeList = array of ESiteType;

  EFieldsCep = (efCep, efComplemento, efLogradouro,
                efBairro, efCidade, efUf, efDdd, efIbge);

  TSearchSite = class
  public
  const
    _ksViaCep = 'http://viacep.com.br/ws/%s/json/';
    _ksApiCep = 'https://cdn.apicep.com/file/apicep/%s.json';
    _ksAwesomeApi = 'https://cep.awesomeapi.com.br/json/%s';

    class function GetUrlSite(const AsCep: string; AeTipoSite: ESiteType): string;
    class function GetSiteName(AeTipoSite: ESiteType): string;
    class function GetListSearchSite: TSiteTypeList;
  end;

  TFieldsViaCep = class
  public
    class function GetField(const AeSiteType: ESiteType; AeFieldCep: EFieldsCep): string;
  end;

implementation

{ TSiteConsulta }
class function TSearchSite.GetUrlSite(const AsCep: string; AeTipoSite: ESiteType): string;
begin
  case AeTipoSite of
    etsViaCep: result := Format(_ksViaCep, [AsCep]);
    etsApiCep: result := Format(_ksApiCep, [AsCep]);
    etsAwesome: result := Format(_ksAwesomeApi, [AsCep]);
  end;
end;

class function TSearchSite.GetListSearchSite: TSiteTypeList;
begin
  result := [etsViaCep, etsApiCep, etsAwesome];
end;

class function TSearchSite.GetSiteName(AeTipoSite: ESiteType): string;
begin
  case AeTipoSite of
    etsViaCep: result := 'ViaCep';
    etsApiCep: result := 'ApiCep';
    etsAwesome: result := 'AwesomeApi';
  end;
end;

{ TFieldsViaCep }

class function TFieldsViaCep.GetField(const AeSiteType: ESiteType; AeFieldCep: EFieldsCep): string;
begin
  case AeSiteType of
    etsViaCep, etsApiCep:
      case AeFieldCep of
        efCep: result := 'cep';
        efComplemento: result := 'complemento';
        efLogradouro: result := 'logradouro';
        efBairro: result := 'bairro';
        efCidade: result := 'localidade';
        efUf: result := 'uf';
        efDdd: result := 'ddd';
        efIbge: result := 'ibge';
      end;
    etsAwesome:
      case AeFieldCep of
        efCep: result := 'cep';
        efComplemento: result := 'address_type';
        efLogradouro: result := 'address';
        efBairro: result := 'district';
        efCidade: result := 'city';
        efUf: result := 'state';
        efDdd: result := 'ddd';
        efIbge: result := 'city_ibge';
      end;
  end;
end;

end.
