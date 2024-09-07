unit uCepModel;

interface
uses System.JSON;
type
  TCepModel = class
  private
    FsCep: string;
    FsLogradouro: string;
    FsComplemento: string;
    FsUf: string;
    FsBairro: string;
    FsDdd: string;
    FsIbge: string;
    FsJson: string;
    FsCidade: string;

  public
    class function New: TCepModel;
    function SetJson(AeJson: string): TCepModel;
    function TreatJson: TCepModel;

  published
    property Cep: string read FsCep write FsCep;
    property Logradouro: string read FsLogradouro write FsLogradouro;
    property Complemento: string read FsComplemento write FsComplemento;
    property Uf: string read FsUf write FsUf;
    property Bairro: string read Fsbairro write Fsbairro;
    property Ddd: string read FsDdd write FsDdd;
    property Ibge: string read FsIbge write FsIbge;
    property Cidade: string read FsCidade write FsCidade;
    property Json: string read FsJson;
  end;

implementation


function TCepModel.TreatJson: TCepModel;
var
  oJsonValue: TJSONValue;
  sAux: string;
begin
  result := Self;
  oJsonValue := TJSONObject.ParseJSONValue(Json);
  with oJsonValue do
  begin
    if TryGetValue<string>('cep',sAux) then
      Cep := sAux;
    if TryGetValue<string>('complemento', sAux) then
      Complemento := sAux;
    if TryGetValue<string>('logradouro', sAux) then
      Logradouro := sAux;
    if TryGetValue<string>('bairro', sAux) then
      Bairro := sAux;
    if TryGetValue<string>('uf', sAux) then
      Uf := sAux;
    if TryGetValue<string>('ddd', sAux) then
      Ddd := sAux;
    if TryGetValue<string>('ibge', sAux) then
      Ibge := sAux;
    if TryGetValue<string>('cidade', sAux) then
      Cidade := sAux;
  end;
end;

class function TCepModel.New: TCepModel;
begin
  result := TCepModel.create;
end;

function TCepModel.SetJson(AeJson: string): TCepModel;
begin
  FsJson := AeJson;
  result := Self;
end;

end.
