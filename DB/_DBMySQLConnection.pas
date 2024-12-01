unit _DBMySQLConnection;

interface

uses
  Classes, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Comp.UI,
  _IDBConnection, _DBQuery, _IDBQuery;

type
  TMySQLConnectionBD = class(TFDConnection, IDBConnection)
  private
    transactionName: string;
    transaction: TFDTransaction;
    driver: TFDPhysMySQLDriverLink;
    cursor: TFDGUIxWaitCursor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Connect(
      const server: string;
      const port: Integer;
      const database: string;
      const user: string;
      const password: string
    );

    function NewQuery: IDBQuery;

    procedure BeginTransaction(name: string);
    procedure Rollback;
    procedure Commit;
  end;

implementation

{ TConexaoBD }

constructor TMySQLConnectionBD.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  cursor := TFDGUIxWaitCursor.Create(Self);

  Self.driver := TFDPhysMySQLDriverLink.Create(Self);
  Self.transaction := TFDTransaction.Create(Self);
  transactionName := '';
end;

procedure TMySQLConnectionBD.Connect(
  const server: string;
  const port: Integer;
  const database: string;
  const user: string;
  const password: string
);
begin
  Self.ConnectionName := user;

  Self.DriverName := 'MySQL';
  Self.LoginPrompt := False;

  Self.Params.DriverID := 'MySQL';
  Self.Params.Add('Server=' + server);
  Self.Params.Add('Port=' + IntToStr(port));
  Self.Params.Database := database;
  Self.Params.UserName := user;
  Self.Params.Password := password;

  Self.driver := TFDPhysMySQLDriverLink.Create(Self.Owner);
  Self.driver.VendorLib := GetCurrentDir + PathDelim + 'libmysql.dll';

  Self.Connected := True;
end;

function TMySQLConnectionBD.NewQuery: IDBQuery;
begin
  Result := TQueryBD.Create;
  TFDQuery(Result.DataSet).Connection := Self;
end;

procedure TMySQLConnectionBD.BeginTransaction(name: string);
begin
  if (name = '') or (Trim(Self.transactionName) <> Self.transactionName) then
    raise Exception.Create('Invalid transaction name: ' + name);

  if Self.transactionName <> '' then begin
    raise Exception.Create(
      'Could not open transaction "' + name + '" ' +
      'because transaction "' + Self.transactionName + '" is open.'
    );
  end;

  Self.transaction.StartTransaction;
  Self.transactionName := name;
end;

procedure TMySQLConnectionBD.Rollback;
begin
  try
    Self.transaction.Rollback;
  finally
    Self.transactionName := '';
  end;
end;

procedure TMySQLConnectionBD.Commit;
begin
  try
    Self.transaction.Commit;
  finally
    Self.transactionName := '';
  end;
end;

destructor TMySQLConnectionBD.Destroy;
begin
  Self.driver.Free;
  Self.transaction.Free;
  Self.cursor.Free;

  inherited;
end;

end.
