unit _DBAttribute;

interface

uses
  System.SysUtils, System.StrUtils,
  System.Generics.Defaults;

type
  TDBFieldType = (ftInteger, ftDouble, ftChar, ftVarchar, ftText, ftDate, ftTimestamp);

  TDBFieldIndexKind = (ikPrimaryKey, ikIndex, ikUniqueIndex, ikDefault);

  TDBAttribute = class
  protected
    _fieldName: string;
    _fieldType: TDBFieldType;
    _indexKind: TDBFieldIndexKind;
    _required: Boolean;
    _readOnly: Boolean;
  public
    constructor Create(AFieldName: string; ARequired: Boolean);

    procedure SetFieldName(value: string);
    function GetFieldName: string;

    procedure SetFieldType(value: TDBFieldType);
    function GetFieldType: TDBFieldType;

    procedure SetIndexKind(value: TDBFieldIndexKind);
    function GetIndexKind: TDBFieldIndexKind;

    procedure SetRequired(value: Boolean);
    function GetRequired: Boolean;

    procedure SetReadOnly(value: Boolean);
    function GetReadOnly: Boolean;

    property FieldName: string read GetFieldName write SetFieldName;
    property FieldType: TDBFieldType read GetFieldType write SetFieldType;
    property IndexKind: TDBFieldIndexKind read GetIndexKind write SetIndexKind;
    property Required: Boolean read GetRequired write SetRequired;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
  end;

implementation

constructor TDBAttribute.Create(AFieldName: string; ARequired: Boolean);
begin
  Self._fieldName := AFieldName;
  Self._required := ARequired;
end;

procedure TDBAttribute.SetFieldName(value: string);
begin
  Self._fieldName := value;
end;

function TDBAttribute.GetFieldName: string;
begin
  Result := Self._fieldName;
end;

procedure TDBAttribute.SetFieldType(value: TDBFieldType);
begin
  Self._fieldType := value;
end;

function TDBAttribute.GetFieldType: TDBFieldType;
begin
  Result := Self._fieldType;
end;

procedure TDBAttribute.SetIndexKind(value: TDBFieldIndexKind);
begin
  Self._indexKind := value;
end;

function TDBAttribute.GetIndexKind: TDBFieldIndexKind;
begin
  Result := Self._indexKind;
end;

procedure TDBAttribute.SetRequired(value: Boolean);
begin
  Self._required := value;
end;

function TDBAttribute.GetRequired: Boolean;
begin
  Result := Self._required;
end;

procedure TDBAttribute.SetReadOnly(value: Boolean);
begin
  Self._readOnly := value;
end;

function TDBAttribute.GetReadOnly: Boolean;
begin
  Result := Self._readOnly;
end;

end.
