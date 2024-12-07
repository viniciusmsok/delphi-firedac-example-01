unit _DBDouble;

interface

uses
  _DBAttribute;

type
  TDBDouble = class(TDBAttribute)
  private
    _defaultValue: Double;
    _minValue: Double;
    _maxValue: Double;
    _decimalPlaces: Integer;
  public
    constructor Create(AFieldName: string; ARequired: Boolean = False; ADecimalPlaces: Integer = 2);

    function GetDefaultValue: Double;
    procedure SetDefaultValue(value: Double);

    function GetMinValue: Double;
    procedure SetMinValue(value: Double);

    function GetMaxValue: Double;
    procedure SetMaxValue(value: Double);

    function GetDecimalPlaces: Integer;
    procedure SetDecimalPlaces(value: Integer);

    property DefaultValue: Double read GetDefaultValue write SetDefaultValue;
    property MinValue: Double read GetMinValue write SetMinValue;
    property MaxValue: Double read GetMaxValue write SetMaxValue;
    property DecimalPlaces: Integer read GetDecimalPlaces write SetDecimalPlaces;
  end;

implementation

{ TDBDouble }

constructor TDBDouble.Create(AFieldName: string; ARequired: Boolean = False; ADecimalPlaces: Integer = 2);
begin
  inherited Create(AFieldName, ARequired);

  Self._minValue := 0;
  Self._maxValue := 999999999.99;
  Self._decimalPlaces := ADecimalPlaces;
end;

function TDBDouble.GetDecimalPlaces: Integer;
begin
  Result := Self._decimalPlaces;
end;

procedure TDBDouble.SetDecimalPlaces(value: Integer);
begin
  Self._decimalPlaces := value;
end;

function TDBDouble.GetDefaultValue: Double;
begin
  Result := Self._defaultValue;
end;

procedure TDBDouble.SetDefaultValue(value: Double);
begin
  Self._defaultValue := value;
end;

function TDBDouble.GetMinValue: Double;
begin
  Result := Self._minValue;
end;

procedure TDBDouble.SetMinValue(value: Double);
begin
  Self._minValue := value;
end;

function TDBDouble.GetMaxValue: Double;
begin
  Result := Self._maxValue;
end;

procedure TDBDouble.SetMaxValue(value: Double);
begin
  Self._maxValue := value;
end;


end.
