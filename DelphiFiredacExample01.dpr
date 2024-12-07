program DelphiFiredacExample01;

uses
  Vcl.Forms,
  _CustomerDAO in 'DAO\_CustomerDAO.pas',
  MainForm in 'MainForm.pas' {FMain},
  _DBAttribute in 'DB\_DBAttribute.pas',
  _DBChar in 'DB\_DBChar.pas',
  _DBDate in 'DB\_DBDate.pas',
  _DBDouble in 'DB\_DBDouble.pas',
  _DBEntity in 'DB\_DBEntity.pas',
  _DBInteger in 'DB\_DBInteger.pas',
  _DBMigration in 'DB\_DBMigration.pas',
  _DBMySQLConnection in 'DB\_DBMySQLConnection.pas',
  _DBQuery in 'DB\_DBQuery.pas',
  _DBTimestamp in 'DB\_DBTimestamp.pas',
  _DBTypes in 'DB\_DBTypes.pas',
  _DBVarchar in 'DB\_DBVarchar.pas',
  _IDBConnection in 'DB\_IDBConnection.pas',
  _IDBQuery in 'DB\_IDBQuery.pas',
  _App in 'Main\_App.pas',
  _Environment in 'Main\_Environment.pas',
  _Language in 'Main\_Language.pas',
  _Library in 'Main\_Library.pas',
  AncestralForm in 'ViewForms\Ancestral\AncestralForm.pas' {FAncestral},
  RegistrationForm in 'ViewForms\Ancestral\RegistrationForm.pas' {FRegistration},
  CustomersForm in 'ViewForms\Registration\CustomersForm.pas' {FCustomers};

{$R *.res}

begin
  Application.Initialize;

  TLanguage.SetConfiguration(TLanguageItem.PT_BR);

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
