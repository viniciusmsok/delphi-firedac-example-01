unit _DBTimestamp;

interface

uses
  _DBAttribute;

type
  TDBTimestamp = class(TDBAttribute)
  protected
    _autofillOnCreate: Boolean;
    _autofillOnUpdate: Boolean;
  public
    constructor Create;

    function GetAutofillOnCreate: Boolean;
    procedure SetAutofillOnCreate(value: Boolean);

    function GetAutofillOnUpdate: Boolean;
    procedure SetAutofillOnUpdate(value: Boolean);

    property AutofillOnCreate: Boolean read GetAutofillOnCreate write SetAutofillOnCreate;
    property AutofillOnUpdate: Boolean read GetAutofillOnUpdate write SetAutofillOnUpdate;
  end;

implementation

{ TDBTimestamp }

constructor TDBTimestamp.Create;
begin
  Self._autofillOnCreate := False;
  Self._autofillOnUpdate := False;
end;

function TDBTimestamp.GetAutofillOnCreate: Boolean;
begin
  Result := Self._autofillOnCreate;
end;

procedure TDBTimestamp.SetAutofillOnCreate(value: Boolean);
begin
  Self._autofillOnCreate := Value;
end;

function TDBTimestamp.GetAutofillOnUpdate: Boolean;
begin
  Result := Self._autofillOnUpdate;
end;

procedure TDBTimestamp.SetAutofillOnUpdate(value: Boolean);
begin
  Self._autofillOnUpdate := Value;
end;

end.
