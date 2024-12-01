unit _IDBQuery;

interface

uses
  DB, System.Classes;

type
  IDBQuery = interface
    function GetSQL: TStrings;
    function GetDataSet: TDataSet;

    function Query: Boolean; overload;
    function Query(params: array of Variant): Boolean; overload;
    function Execute(params: array of Variant): Integer;
    procedure Close;

    function AsDateTime(fieldName: string): TDateTime;
    function AsFloat(fieldName: string): Double;
    function AsInteger(fieldName: string): Integer;
    function AsString(fieldName: string): string;
    function AsVariant(fieldName: string): Variant;
    function Bof: Boolean;
    function Eof: Boolean;
    procedure First;
    procedure Last;
    procedure Next;

    property SQL: TStrings read GetSQL;
    property DataSet: TDataSet read GetDataSet;
  end;

implementation

end.
