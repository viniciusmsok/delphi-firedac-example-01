unit _CustomerDAO;

interface

uses
  System.SysUtils,
  _App,
  _IDBConnection, _IDBQuery, _DBEntity, _DBInteger, _DBAttribute;

type
  Customer = record
    customer_id: Integer;
    person_type: string;
    main_name: string;
    social_name: string;
    federal_id: string;
    email: string;
  end;

  CustomerDAO = class(TDBEntity<Customer>)
  public
    const ATT_CUSTOMER_ID = 'customer_id';
    const ATT_PERSON_TYPE = 'person_type';
    const ATT_MAIN_NAME   = 'main_name';
    const ATT_SOCIAL_NAME = 'social_name';
    const ATT_FEDERAL_ID  = 'federal_id';
    const ATT_EMAIL       = 'email';

    const PERSON_TYPE_NATURAL = 'NAT';
    const PERSON_TYPE_LEGAL   = 'LEG';

    constructor Create(conn: IDBConnection); reintroduce;
    procedure MapAttributes; override;
  end;

implementation

{ CustomerDAO }

constructor CustomerDAO.Create(conn: IDBConnection);
begin
  inherited Create(conn, 'customers');
end;

procedure CustomerDAO.MapAttributes;
begin
  inherited;
  Self.AddInteger(Self.ATT_CUSTOMER_ID, True).SetIndexKind(TDBFieldIndexKind.ikPrimaryKey);
  Self.AddChar(Self.ATT_PERSON_TYPE, 3, True, [Self.PERSON_TYPE_NATURAL, Self.PERSON_TYPE_LEGAL]);
  Self.AddVarchar(Self.ATT_MAIN_NAME, 70).SetIndexKind(TDBFieldIndexKind.ikIndex);
  Self.AddVarchar(Self.ATT_SOCIAL_NAME, 70).SetIndexKind(TDBFieldIndexKind.ikIndex);
  Self.AddVarchar(Self.ATT_FEDERAL_ID, 50).SetIndexKind(TDBFieldIndexKind.ikIndex);
  Self.AddVarchar(Self.ATT_EMAIL, 250);
end;

end.
