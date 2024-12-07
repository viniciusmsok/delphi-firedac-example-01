unit _DBChar;

interface

uses
  _DBAttribute;

type
  TDBChar = class(TDBAttribute)
  private
    _maxLength: Integer;
    _options: TArray<string>;
  public
    constructor Create(AFieldName: string; AMaxLength: Integer; ARequired: Boolean = True; AOptions: TArray<string> = nil);

    function GetMaxLength: Integer;
    procedure SetMaxLength(value: Integer);
    function GetOptions: TArray<string>;
    procedure SetOptions(value: TArray<string>);

    property MaxLength: Integer read GetMaxLength write SetMaxLength;
    property Options: TArray<string> read GetOptions write SetOptions;
  end;

implementation

{ TDBChar }

constructor TDBChar.Create(AFieldName: string; AMaxLength: Integer; ARequired: Boolean = True; AOptions: TArray<string> = nil);
begin
  inherited Create(AFieldName, ARequired);
  _maxLength := AMaxLength;
  _options := options;
end;

function TDBChar.GetMaxLength: Integer;
begin
  Result := Self._maxLength;
end;

procedure TDBChar.SetMaxLength(value: Integer);
begin
  Self._maxLength := value;
end;

function TDBChar.GetOptions: TArray<string>;
begin
  Result := Self._options;
end;

procedure TDBChar.SetOptions(value: TArray<string>);
begin
  Self._options := value;
end;

end.
