unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  CustomersForm,
  _Environment, _DBMySQLConnection, _IDBQuery, _App, _Language, _Library;

type
  TFMain = class(TForm)
    mmMenu: TMainMenu;
    miRegister: TMenuItem;
    miCustomer: TMenuItem;
    miEnUS: TMenuItem;
    miPtBR: TMenuItem;
    procedure miCustomerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miPtBRClick(Sender: TObject);
  private
    language: TLanguage;
    procedure ConfigLanguage;
    procedure RequireCloseAllScreensMessage;
    function WantToLogOutDialog: Boolean;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

procedure TFMain.FormCreate(Sender: TObject);
var
  teste: IDBQuery;
begin
  App.conn := TMySQLConnectionBD.Create(Self);
  Self.ConfigLanguage;

  App.conn.Connect('localhost', 3306, 'exemplo01', 'exemplo01', 'dados');
  teste := App.conn.NewQuery;
  teste.SQL.Add('SELECT * FROM INFORMATION_SCHEMA.tables');
  teste.Query;
  ShowMessage(teste.AsString('TABLE_NAME'));
  teste.Close;
  teste := nil;
end;

procedure TFMain.ConfigLanguage;
begin
  Self.language := TLanguage.Create;

  Self.language.SetCaption(miRegister.Name, 'Cadastros', 'Registers');
  Self.language.SetCaption(miCustomer.Name, 'Clientes', 'Customers');

  Self.language.Apply(Self);
end;

procedure TFMain.RequireCloseAllScreensMessage;
begin
  Lib.Exclaim(
    'Antes de sair do sistema, feche todas as telas!',
    'Before exiting the system, close all screens!'
  );
end;

function TFMain.WantToLogOutDialog: Boolean;
begin
  Result := Lib.Dialog(
    'Tem certeza que deseja sair?',
    'Are you sure you want to log out?'
  );
end;

procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  if Self.MDIChildCount > 0 then begin
    for i := 0 to Screen.FormCount - 1 do begin
      if (TForm(Screen.Forms[i]).FormStyle = fsMDIChild) and (TForm(Screen.Forms[i]).Left > FMain.Width) then begin
        TForm(Screen.Forms[i]).Top := 50;
        if FMain.Width - (TForm(Screen.Forms[i]).Width + 100) > 50 then
          TForm(Screen.Forms[i]).Left := FMain.Width - (TForm(Screen.Forms[i]).Width + 100)
        else
          TForm(Screen.Forms[i]).Left := FMain.Width - 300;
      end;
    end;

    Self.RequireCloseAllScreensMessage;
    CanClose := False;
  end
  else
    CanClose := Self.WantToLogOutDialog;
end;

procedure TFMain.miCustomerClick(Sender: TObject);
begin
  TFCustomers.Open;
end;

procedure TFMain.miPtBRClick(Sender: TObject);
begin
  if Self.MDIChildCount > 0 then begin
    Lib.Exclaim(
      'Feche todas as telas para aplicar as alterações.',
      'Close all screens to apply changes.'
    );

    Exit;
  end;

  if Sender = miPtBR then begin
    TLanguage.SetConfiguration(TLanguageItem.PT_BR);
    Self.language.Apply(Self);
  end
  else if Sender = miEnUS then begin
    TLanguage.SetConfiguration(TLanguageItem.EN_US);
    Self.language.Apply(Self);
  end;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  if TMySQLConnectionBD(App.conn).Connected then
    TMySQLConnectionBD(App.conn).Close;

  TMySQLConnectionBD(App.conn).Free;

  Self.language.Free;
  inherited;
end;

end.
