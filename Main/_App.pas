unit _App;

interface

uses
  _IDBQuery, _IDBConnection;

type
  App = class
  public
    class var conn: IDBConnection;
    class function NewQuery: IDBQuery;
  end;

implementation

{ App }

class function App.NewQuery: IDBQuery;
begin
  Result := App.conn.NewQuery;
end;

end.
