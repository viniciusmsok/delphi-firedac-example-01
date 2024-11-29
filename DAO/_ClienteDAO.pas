unit _ClienteDAO;

interface

uses
  System.SysUtils,
  _Ambiente, _IConexaoBD, _IQueryBD;

type
  ClientesDAO = class
  public
    class procedure Manter(dados: string);
  end;

implementation

{ Clientes }

class procedure ClientesDAO.Manter(dados: string);
var
  conn: IConexaoBD;
  qr: IQueryBD;
begin
  conn := Ambiente.conn;
  qr := conn.NovaQuery;

  try
    conn.AbrirTransacao('NovoCliente');

    qr.SQL.Add('');
    
    conn.ConfirmarTransacao;
  except
    on E: Exception do begin
      conn.VoltarTransacao;
      raise;
    end;
  end;
end;

end.
