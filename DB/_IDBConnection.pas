unit _IDBConnection;

interface

uses
  System.Classes, _IDBQuery;

type
  IDBConnection = interface
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

end.
