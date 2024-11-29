unit FrmCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrmAncestral, Vcl.WinXPanels, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  _Biblioteca;

type
  TFormCadastro = class(TFormAncestral)
    pnTopo: TPanel;
    btSalvar: TBitBtn;
    btCancelar: TBitBtn;
    btExcluir: TBitBtn;
    btPesquisar: TBitBtn;
    btLogs: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OnEnterNext(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSalvarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    { Private declarations }
  protected
    editing: boolean;
    procedure Modo(edicao: boolean; novoRegistro: boolean);
    procedure VerificarDados; virtual; abstract;
    procedure Salvar;
    procedure Cancelar;
    procedure Excluir;
    procedure Pesquisar;
    procedure Logs;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFormCadastro }

procedure TFormCadastro.Modo(edicao: boolean; novoRegistro: boolean);
begin
  btSalvar.Enabled := edicao;
  btCancelar.Enabled := edicao;
  btExcluir.Enabled := edicao and not novoRegistro;
  btPesquisar.Enabled := not edicao;
  btLogs.Enabled := edicao and not novoRegistro;
  editing := edicao;
end;

procedure TFormCadastro.Salvar;
begin
  Modo(False, False);
end;

procedure TFormCadastro.btCancelarClick(Sender: TObject);
begin
  inherited;
  Cancelar;
end;

procedure TFormCadastro.btExcluirClick(Sender: TObject);
begin
  inherited;
  Excluir;
end;

procedure TFormCadastro.btSalvarClick(Sender: TObject);
begin
  inherited;
  VerificarDados;
  Salvar;
end;

procedure TFormCadastro.Cancelar;
begin
  if not Biblioteca.Questionar('Tem certeza que deseja cancelar?') then
    Exit;

  Modo(False, False);
end;

procedure TFormCadastro.Excluir;
begin
  Modo(False, False);
end;

procedure TFormCadastro.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if editing then
    CanClose := Biblioteca.Questionar('Tem certeza que deseja cancelar?');
end;

procedure TFormCadastro.FormCreate(Sender: TObject);
begin
  inherited;
  editing := False;
end;

procedure TFormCadastro.Pesquisar;
begin
  //
end;

procedure TFormCadastro.Logs;
begin
  //
end;

procedure TFormCadastro.OnEnterNext(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    SelectNext(ActiveControl, True, True);
    Key := 0;
  end;
end;

end.
