unit _Ambiente;

interface

uses
  _IQueryBD, _IConexaoBD;

type
  Ambiente = class
  public
    class var conn: IConexaoBD;
    class function NovaQuery: IQueryBD;
  end;

implementation

{ Ambiente }

class function Ambiente.NovaQuery: IQueryBD;
begin
  Result := Ambiente.conn.NovaQuery;
end;

end.
