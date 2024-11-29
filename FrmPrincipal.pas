unit FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  _Ambiente, FrmClientes, _MySQLConnectionBD, _IQueryBD;

type
  TFormPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    miCadastros: TMenuItem;
    miClientes: TMenuItem;
    procedure miClientesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TMySQLConnectionBD(Ambiente.conn).Destroy;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
var
  teste: IQueryBD;
begin
  Ambiente.conn := TMySQLConnectionBD.Create(Application);
  Ambiente.conn.Conectar('localhost', 3306, 'exemplo01', 'exemplo01', 'dados');
  teste := Ambiente.conn.NovaQuery;
  teste.SQL.Add('SELECT * FROM INFORMATION_SCHEMA.tables');
  teste.Consultar;
  teste.Fechar;
end;

procedure TFormPrincipal.miClientesClick(Sender: TObject);
begin
  FrmClientes.Abrir;
end;

end.
