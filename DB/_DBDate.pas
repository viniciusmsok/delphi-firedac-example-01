unit _DBDate;

interface

uses
  _DBAttribute;

type
  TDBDate = class(TDBAttribute)
  protected
    _autofillOnCreate: Boolean;
    _autofillOnUpdate: Boolean;
  public
    constructor Create(
      AFieldName: string;
      ARequired: Boolean = True;
      AAutofillOnCreate: Boolean = False;
      AAutofillOnUpdate: Boolean = False
    );

    function GetAutofillOnCreate: Boolean;
    procedure SetAutofillOnCreate(value: Boolean);

    function GetAutofillOnUpdate: Boolean;
    procedure SetAutofillOnUpdate(value: Boolean);

    property AutofillOnCreate: Boolean read GetAutofillOnCreate write SetAutofillOnCreate;
    property AutofillOnUpdate: Boolean read GetAutofillOnUpdate write SetAutofillOnUpdate;
  end;

implementation

{ TDBDate }

constructor TDBDate.Create(
  AFieldName: string;
  ARequired: Boolean = True;
  AAutofillOnCreate: Boolean = False;
  AAutofillOnUpdate: Boolean = False
);
begin
  inherited Create(AFieldName, ARequired);

  Self._autofillOnCreate := AAutofillOnCreate;
  Self._autofillOnUpdate := AAutofillOnUpdate;
end;

function TDBDate.GetAutofillOnCreate: Boolean;
begin
  Result := Self._autofillOnCreate;
end;

procedure TDBDate.SetAutofillOnCreate(value: Boolean);
begin
  Self._autofillOnCreate := Value;
end;

function TDBDate.GetAutofillOnUpdate: Boolean;
begin
  Result := Self._autofillOnUpdate;
end;

procedure TDBDate.SetAutofillOnUpdate(value: Boolean);
begin
  Self._autofillOnUpdate := Value;
end;

end.
