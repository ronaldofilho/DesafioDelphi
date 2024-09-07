program GetCEP;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  uCEPController in 'Controller\uCEPController.pas',
  uCEPGenerics in 'Generics\uCEPGenerics.pas',
  uEnumrationsList in 'Util\uEnumrationsList.pas',
  uCEPViaCep in 'Models\uCEPViaCep.pas',
  uCEPApiCep in 'Models\uCEPApiCep.pas',
  uCEPAwesomeCep in 'Models\uCEPAwesomeCep.pas',
  uTreatJsonSearch in 'Util\uTreatJsonSearch.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }

    TCEPController.new.Registry;
    THorse.Listen(8899);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
