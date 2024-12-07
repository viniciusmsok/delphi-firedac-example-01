unit RegistrationForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPanels, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  _Library, AncestralForm;

type
  TFRegistration = class(TFAncestral)
    pnTop: TPanel;
    btSave: TBitBtn;
    btCancel: TBitBtn;
    btDelete: TBitBtn;
    btSearch: TBitBtn;
    btLogs: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure btLogsClick(Sender: TObject);
    procedure OnEnterNext(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  protected
    editing: Boolean;
    procedure ConfigLanguage; override;
    procedure Mode(edition: Boolean; isNewRecord: Boolean); virtual;
    procedure ValidateData; virtual;
    procedure Save; virtual;
    procedure Cancel; virtual;
    procedure Delete; virtual;
    procedure Search; virtual;
    procedure Logs; virtual;
    function WantToCancelDialog: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFormCadastro }

procedure TFRegistration.FormCreate(Sender: TObject);
begin
  inherited;
  editing := False;
end;

procedure TFRegistration.ConfigLanguage;
begin
  inherited;
  AddCaption(btSave.Name, '&Salvar', '&Save');
  AddCaption(btCancel.Name, '&Cancelar', '&Cancel');
  AddCaption(btDelete.Name, '&Excluir', '&Delete');
  AddCaption(btSearch.Name, '&Pesquisar', '&Search');
end;

procedure TFRegistration.Mode(edition: Boolean; isNewRecord: Boolean);
begin
  btSave.Enabled := edition;
  btCancel.Enabled := edition;
  btDelete.Enabled := edition and not isNewRecord;
  btSearch.Enabled := not edition;
  btLogs.Enabled := edition and not isNewRecord;
  editing := edition;
end;

procedure TFRegistration.Save;
begin
  //
end;

procedure TFRegistration.btSaveClick(Sender: TObject);
begin
  inherited;
  ValidateData;
  Save;
  Mode(False, False);
end;

procedure TFRegistration.Cancel;
begin
  //
end;

procedure TFRegistration.btCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;

  if not Self.WantToCancelDialog then
    Exit;

  Mode(False, False);
end;

procedure TFRegistration.Delete;
begin
  //
end;

procedure TFRegistration.btDeleteClick(Sender: TObject);
begin
  inherited;
  Delete;
  Mode(False, False);
end;

procedure TFRegistration.Search;
begin
  //
end;

procedure TFRegistration.ValidateData;
begin
  //
end;

function TFRegistration.WantToCancelDialog: Boolean;
begin
  Result := Lib.Dialog(
    'Tem certeza que deseja cancelar?',
    'Are you sure you want to cancel?',
    'Cancelar',
    'Cancel'
  );
end;

procedure TFRegistration.btSearchClick(Sender: TObject);
begin
  inherited;
  Search;
end;

procedure TFRegistration.Logs;
begin
  //
end;

procedure TFRegistration.btLogsClick(Sender: TObject);
begin
  inherited;
  Logs;
end;

procedure TFRegistration.OnEnterNext(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    SelectNext(ActiveControl, True, True);
    Key := 0;
  end;
end;

procedure TFRegistration.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if editing then
    CanClose := Self.WantToCancelDialog;
end;

end.
