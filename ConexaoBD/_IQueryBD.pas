unit _IQueryBD;

interface

uses
  System.Classes;

type
  IQueryBD = interface
    function GetSQL: TStrings;
    function Consultar: Boolean; overload;
    function Consultar(parametros: array of Variant): Boolean; overload;
    function Executar(parametros: array of Variant): Integer;
    procedure Fechar;
    property SQL: TStrings read GetSQL;
  end;

implementation

end.
