unit _DBQuery;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Comp.Client, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  _IDBQuery, _IDBConnection;

type
  TQueryBD = class(TInterfacedObject, IDBQuery)
  private
    ds: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function GetSQL: TStrings;
    function GetDataSet: TDataSet;

    function AsDateTime(fieldName: string): TDateTime;
    function AsFloat(fieldName: string): Double;
    function AsInteger(fieldName: string): Integer;
    function AsString(fieldName: string): string;
    function AsVariant(fieldName: string): Variant;

    function Query: Boolean; overload;
    function Query(params: array of Variant): Boolean; overload;
    function Execute(params: array of Variant): Integer;
    procedure Close;

    function Bof: Boolean;
    function Eof: Boolean;
    procedure First;
    procedure Last;
    procedure Next;

    property SQL: TStrings read GetSQL;
    property DataSet: TDataSet read GetDataSet;
  end;

implementation

{ TQueryBD }

constructor TQueryBD.Create;
begin
  inherited Create;
  Self.ds := TFDQuery.Create(Application);
end;

destructor TQueryBD.Destroy;
begin
  Self.ds.Free;
  inherited Destroy;
end;

function TQueryBD.GetDataSet: TDataSet;
begin
  Result := Self.ds;
end;

function TQueryBD.GetSQL: TStrings;
begin
  Result := Self.ds.SQL;
end;

procedure TQueryBD.Last;
begin
  Self.ds.Last;
end;

procedure TQueryBD.Next;
begin
  Self.ds.Next;
end;

function TQueryBD.Query: Boolean;
begin
  Result := Self.Query([]);
end;

function TQueryBD.Query(params: array of Variant): Boolean;
var
  i: Integer;
begin
  if Length(params) > 0 then begin
    for i := Low(params) to High(params) do
      Self.ds.ParamByName('P' + IntToStr(i + 1)).Value := params[i];
  end;

  Self.ds.Open;

  Result := Self.ds.RecordCount > 0;

  if Result then
    Self.ds.First;
end;

function TQueryBD.Bof: Boolean;
begin
  Result := Self.ds.Bof;
end;

function TQueryBD.EOF: Boolean;
begin
  Result := Self.ds.Eof;
end;

function TQueryBD.Execute(params: array of Variant): Integer;
var
  i: Integer;
begin
  if Length(params) > 0 then begin
    for i := Low(params) to High(params) do
      Self.ds.ParamByName('P' + IntToStr(i + 1)).Value := params[i];
  end;

  Self.ds.ExecSQL;

  Result := Self.ds.RowsAffected;
end;

procedure TQueryBD.First;
begin
  Self.ds.First;
end;

function TQueryBD.AsDateTime(fieldName: string): TDateTime;
begin
  Result := Self.ds.FieldByName(fieldName).AsDateTime;
end;

function TQueryBD.AsFloat(fieldName: string): Double;
begin
  Result := Self.ds.FieldByName(fieldName).AsFloat;
end;

function TQueryBD.AsVariant(fieldName: string): Variant;
begin
  Result := Self.ds.FieldByName(fieldName).Value;
end;

function TQueryBD.AsInteger(fieldName: string): Integer;
begin
  Result := Self.ds.FieldByName(fieldName).AsInteger;
end;

function TQueryBD.AsString(fieldName: string): string;
begin
  Result := Self.ds.FieldByName(fieldName).AsString;
end;

procedure TQueryBD.Close;
begin
  Self.ds.Close;
end;

end.
