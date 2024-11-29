program ExemploMySQL01;

uses
  Vcl.Forms,
  _ClienteDAO in 'DAO\_ClienteDAO.pas',
  _Ambiente in 'Principal\_Ambiente.pas',
  _Biblioteca in 'Principal\_Biblioteca.pas',
  _TypesBD in 'ConexaoBD\_TypesBD.pas',
  FrmAncestral in 'Telas\ancestrais\FrmAncestral.pas' {FormAncestral},
  FrmCadastro in 'Telas\ancestrais\FrmCadastro.pas' {FormCadastro},
  FrmClientes in 'Telas\cadastros\FrmClientes.pas' {FormClientes},
  FrmPrincipal in 'FrmPrincipal.pas' {FormPrincipal},
  _MySQLConnectionBD in 'ConexaoBD\_MySQLConnectionBD.pas',
  _QueryBD in 'ConexaoBD\_QueryBD.pas',
  _IQueryBD in 'ConexaoBD\_IQueryBD.pas',
  _IConexaoBD in 'ConexaoBD\_IConexaoBD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
