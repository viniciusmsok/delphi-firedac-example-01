unit _CustomerDAO;

interface

uses
  System.SysUtils,
  _App, _IDBConnection, _IDBQuery;

type
  CustomerDAO = class
  public
    class procedure Maintain(dados: string);
  end;

implementation

{ Clientes }

class procedure CustomerDAO.Maintain(dados: string);
var
  conn: IDBConnection;
  qr: IDBQuery;
begin
  conn := App.conn;
  qr := conn.NewQuery;

  try
    conn.BeginTransaction('Customer->Maintain');

    qr.SQL.Add('');

    conn.Commit;
  except
    on E: Exception do begin
      conn.Rollback;
      raise;
    end;
  end;
end;

end.
