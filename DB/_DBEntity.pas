unit _DBEntity;

interface

uses
  System.SysUtils, System.Rtti, System.TypInfo, System.Generics.Collections, System.Classes, System.Variants,
  FireDAC.Comp.Client, FireDAC.Stan.Param,
  _IDBQuery, _IDBConnection, _DBAttribute, _DBInteger, _DBChar, _DBVarchar, _DBDate;

type
  TDBEntity<Model> = class
  private
    tableName: string;
    conn: IDBConnection;
    attributes: TDictionary<string, TDBAttribute>;
    function GetObjectField(const fields: TArray<TRttiField>; const name: string): TRttiField;
  public
    constructor Create(conn: IDBConnection; tableName: string); virtual;

    procedure ClearAttributes;
    procedure MapAttributes; virtual;

    procedure AddAtt(attribute: TDBAttribute);

    function AddInteger(
      AFieldName: string;
      APrimaryKey: Boolean = False;
      ARequired: Boolean = True
    ): TDBInteger;

    function AddChar(
      AFieldName: string;
      AMaxLength: Integer;
      ARequired: Boolean = True;
      AOptions: TArray<string> = nil
    ): TDBChar;

    function AddVarchar(
      AFieldName: string;
      AMaxLength: Integer;
      ARequired: Boolean = True;
      AOptions: TArray<string> = nil
    ): TDBVarchar;

    function AddDate(
      AFieldName: string;
      ARequired: Boolean;
      AAutofillOnCreate: Boolean = False;
      AAutofillOnUpdate: Boolean = False
    ): TDBDate;

    function Insert(data: Model): Model;

    destructor Destroy; override;
  end;

implementation

{ TDBEntity }

function TDBEntity<Model>.GetObjectField(const fields: TArray<TRttiField>; const name: string): TRttiField;
var
  field: TRttiField;
begin
  Result := nil;

  for field in fields do begin
    if not field.Name.Equals(name) then
      Continue;

    Result := field;
    Break;
  end;
end;

function TDBEntity<Model>.Insert(data: Model): Model;
var
  index: Integer;

  fieldList: string;
  paramList: string;
  attributeName: string;

  attribute: TDBAttribute;

  value: TValue;
  field: TRttiField;
  fields: TArray<TRttiField>;
  context: TRttiContext;
  rttiType: TRttiType;

  qr: IDBQuery;
  fieldValues: TArray<Variant>;
begin
  context := TRttiContext.Create;

  fieldList := '';
  paramList := '';
  fieldValues := nil;

  try
    rttiType := Context.GetType(TypeInfo(Model));
    fields := RttiType.GetFields;

    for attributeName in Self.attributes.Keys do begin
      attribute := Self.attributes[attributeName];
      if attribute.readOnly then
        Continue;

      index := Length(fieldValues);
      field := Self.GetObjectField(fields, attribute.fieldName);

      if fieldList <> '' then begin
        fieldList := fieldList + ',' + sLineBreak;
        paramList := paramList + ',' + sLineBreak;
      end;

      fieldList := fieldList + '  ' + attribute.fieldName;
      paramList := paramList + '  :P' + IntToStr(index + 1);

      SetLength(fieldValues, index + 1);
      fieldValues[index] := null;

      value := field.GetValue(@data);
      if not value.IsEmpty then
        fieldValues[index] := value.AsVariant;
    end;
  except
    on e: Exception do
      raise Exception.CreateFmt('Unable to read attributes to insert on "%s".', [Self.tableName]);
  end;

  try
    qr := Self.conn.newQuery;
    qr.SQL.Text := Format(
      'INSERT INTO %s (' + sLineBreak + '%s' + sLineBreak + ')' + sLineBreak + 'VALUES (' + sLineBreak + '%s' + sLineBreak + ')',
      [Self.tableName, fieldList, paramList]
    );

    qr.Execute(fieldValues);
  finally
    context.Free;
    qr := nil;
  end;

  Result := data;
end;

procedure TDBEntity<Model>.AddAtt(attribute: TDBAttribute);
begin
  Self.attributes.Add(attribute.FieldName, attribute);
end;

function TDBEntity<Model>.AddInteger(
  AFieldName: string;
  APrimaryKey: Boolean = False;
  ARequired: Boolean = True
): TDBInteger;
begin
  Result := TDBInteger.Create(AFieldName, APrimaryKey, ARequired);
  Self.attributes.Add(AFieldName, Result);
end;

function TDBEntity<Model>.AddChar(
  AFieldName: string;
  AMaxLength: Integer;
  ARequired: Boolean = True;
  AOptions: TArray<string> = nil
): TDBChar;
begin
  Result := TDBChar.Create(AFieldName, AMaxLength, ARequired, AOptions);
  Self.attributes.Add(AFieldName, Result);
end;

function TDBEntity<Model>.AddVarchar(
  AFieldName: string;
  AMaxLength: Integer;
  ARequired: Boolean = True;
  AOptions: TArray<string> = nil
): TDBVarchar;
begin
  Result := TDBVarchar.Create(AFieldName, AMaxLength, ARequired, AOptions);
  Self.attributes.Add(AFieldName, Result);
end;

function TDBEntity<Model>.AddDate(
  AFieldName: string;
  ARequired: Boolean;
  AAutofillOnCreate: Boolean = False;
  AAutofillOnUpdate: Boolean = False
): TDBDate;
begin
  Result := TDBDate.Create(AFieldName, ARequired, AAutofillOnCreate, AAutofillOnUpdate);
  Self.attributes.Add(AFieldName, Result);
end;

procedure TDBEntity<Model>.ClearAttributes;
var
  obj: TDBAttribute;
begin
  for obj in Self.attributes.Values do
    obj.Free;

  Self.attributes.Clear;
end;

constructor TDBEntity<Model>.Create(conn: IDBConnection; tableName: string);
begin
  Self.tableName := tableName;
  Self.conn := conn;
  Self.attributes := TDictionary<string, TDBAttribute>.Create;
  Self.MapAttributes;
end;

procedure TDBEntity<Model>.MapAttributes;
begin
  Self.ClearAttributes;
end;

destructor TDBEntity<Model>.Destroy;
begin
  Self.ClearAttributes;
end;

end.
