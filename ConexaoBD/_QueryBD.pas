unit _QueryBD;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Comp.Client, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  _IQueryBD, _IConexaoBD;

type
  TQueryBD = class(TFDQuery, IQueryBD)
  public
    function GetSQL: TStrings;
    procedure Fechar;
    function Consultar: Boolean; overload;
    function Consultar(parametros: array of Variant): Boolean; overload;
    function Executar(parametros: array of Variant): Integer;
  end;

implementation

{ TQueryBD }

function TQueryBD.GetSQL: TStrings;
begin
  Result := Self.SQL;
end;

function TQueryBD.Consultar: Boolean;
begin
  Result := Self.Consultar([]);
end;

function TQueryBD.Consultar(parametros: array of Variant): Boolean;
var
  i: Integer;
begin
  if Length(parametros) > 0 then begin
    for i := Low(parametros) to High(parametros) do
      Self.ParamByName('P' + IntToStr(i + 1)).Value := parametros[i];
  end;

  Self.Open;

  Result := Self.RecordCount > 0;
end;

function TQueryBD.Executar(parametros: array of Variant): Integer;
var
  i: Integer;
begin
  if Length(parametros) > 0 then begin
    for i := Low(parametros) to High(parametros) do
      Self.ParamByName('P' + IntToStr(i + 1)).Value := parametros[i];
  end;

  Self.ExecSQL;

  Result := Self.RowsAffected;
end;

procedure TQueryBD.Fechar;
begin
  Self.Close;
end;

end.
