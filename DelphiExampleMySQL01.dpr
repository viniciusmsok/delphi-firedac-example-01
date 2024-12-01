program DelphiExampleMySQL01;

uses
  Vcl.Forms,
  _CustomerDAO in 'DAO\_CustomerDAO.pas',
  _App in 'Main\_App.pas',
  _Library in 'Main\_Library.pas',
  RegistrationForm in 'ViewForms\Ancestral\RegistrationForm.pas' {FRegistration},
  MainForm in 'MainForm.pas' {FMain},
  CustomersForm in 'ViewForms\Registration\CustomersForm.pas' {FCustomers},
  _DBMySQLConnection in 'DB\_DBMySQLConnection.pas',
  _DBQuery in 'DB\_DBQuery.pas',
  _DBTypes in 'DB\_DBTypes.pas',
  _IDBConnection in 'DB\_IDBConnection.pas',
  _IDBQuery in 'DB\_IDBQuery.pas',
  AncestralForm in 'ViewForms\Ancestral\AncestralForm.pas' {FAncestral},
  _Language in 'Main\_Language.pas',
  _Environment in 'Main\_Environment.pas';

{$R *.res}

begin
  Application.Initialize;

  TLanguage.SetConfiguration(TLanguageItem.PT_BR);

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
