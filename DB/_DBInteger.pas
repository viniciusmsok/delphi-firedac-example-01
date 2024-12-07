unit _DBInteger;

interface

uses
  _DBAttribute;

type
  TDBInteger = class(TDBAttribute)
  protected
    _defaultValue: Integer;
    _minValue: Integer;
    _maxValue: Integer;
  public
    constructor Create(AFieldName: string; APrimaryKey: Boolean = False; ARequired: Boolean = True);

    function GetDefaultValue: Integer;
    procedure SetDefaultValue(value: Integer);

    function GetMinValue: Integer;
    procedure SetMinValue(value: Integer);

    function GetMaxValue: Integer;
    procedure SetMaxValue(value: Integer);

    property DefaultValue: Integer read GetDefaultValue write SetDefaultValue;
    property MinValue: Integer read GetMinValue write SetMinValue;
    property MaxValue: Integer read GetMaxValue write SetMaxValue;
  end;

implementation

{ TDBInteger }

constructor TDBInteger.Create(AFieldName: string; APrimaryKey: Boolean = False; ARequired: Boolean = True);
begin
  inherited Create(AFieldName, ARequired);

  Self._minValue := 0;
  Self._maxValue := 999999999;

  if APrimaryKey then
    Self._indexKind := TDBFieldIndexKind.ikPrimaryKey;
end;

function TDBInteger.GetDefaultValue: Integer;
begin
  Result := Self._defaultValue;
end;

procedure TDBInteger.SetDefaultValue(value: Integer);
begin
  Self._defaultValue := Value;
end;

function TDBInteger.GetMinValue: Integer;
begin
  Result := Self._minValue;
end;

procedure TDBInteger.SetMinValue(value: Integer);
begin
  Self._minValue := Value;
end;

function TDBInteger.GetMaxValue: Integer;
begin
  Result := Self._maxValue;
end;

procedure TDBInteger.SetMaxValue(value: Integer);
begin
  Self._maxValue := Value;
end;

end.
