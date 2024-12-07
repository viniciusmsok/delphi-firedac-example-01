unit _DBVarchar;

interface

uses
  _DBAttribute;

type
  TDBVarchar = class(TDBAttribute)
  private
    _maxLength: Integer;
    _options: TArray<string>;
  public
    constructor Create(AFieldName: string; AMaxLength: Integer; ARequired: Boolean; AOptions: TArray<string> = nil);

    function GetMaxLength: Integer;
    procedure SetMaxLength(value: Integer);
    function GetOptions: TArray<string>;
    procedure SetOptions(value: TArray<string>);

    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    property Options: TArray<string> read GetOptions write SetOptions;
  end;

implementation

{ TDBVarchar }

constructor TDBVarchar.Create(AFieldName: string; AMaxLength: Integer; ARequired: Boolean; AOptions: TArray<string> = nil);
begin
  inherited Create(AFieldName, ARequired);
  _maxLength := AMaxLength;
  _options := AOptions;
end;

function TDBVarchar.GetMaxLength: Integer;
begin
  Result := Self._maxLength;
end;

procedure TDBVarchar.SetMaxLength(value: Integer);
begin
  Self._maxLength := value;
end;

function TDBVarchar.GetOptions: TArray<string>;
begin
  Result := Self._options;
end;

procedure TDBVarchar.SetOptions(value: TArray<string>);
begin
  Self._options := value;
end;

end.
