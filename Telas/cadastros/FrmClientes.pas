unit FrmClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrmAncestral, Vcl.ExtCtrls,
  FrmCadastro, Vcl.StdCtrls, Vcl.Buttons, Vcl.NumberBox, Vcl.Mask, _Biblioteca;

type
  TFormClientes = class(TFormCadastro)
    nID: TNumberBox;
    Label1: TLabel;
    eNomeOficial: TEdit;
    lbNomeOficial: TLabel;
    lbRegistroReceita: TLabel;
    Label4: TLabel;
    cbTipoPessoa: TComboBox;
    eRegistroReceita: TMaskEdit;
    eNomeSecundario: TEdit;
    lbNomeSecundario: TLabel;
    eEmail: TEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure nIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbTipoPessoaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eNomeOficialExit(Sender: TObject);
  const
    //Tipo de pessoa
    C_OPCAO_TIPO_PESSOA_FISICA = 'Física';
    C_OPCAO_TIPO_PESSOA_JURIDICA = 'Jurídica';
  private
    procedure Modo(edicao: boolean; novoRegistro: boolean); overload;
  protected
    procedure VerificarDados; override;
  public
    { Public declarations }
  end;

procedure Abrir;

implementation

{$R *.dfm}

procedure Abrir;
var
  f: TFormClientes;
begin
  f := TFormClientes.Create(Application);
  f.Show;
end;

procedure TFormClientes.FormCreate(Sender: TObject);
begin
  inherited;
  cbTipoPessoa.Items.Clear;
  cbTipoPessoa.Items.Add(C_OPCAO_TIPO_PESSOA_FISICA);
  cbTipoPessoa.Items.Add(C_OPCAO_TIPO_PESSOA_JURIDICA);
  cbTipoPessoa.ItemIndex := 0;
  cbTipoPessoaChange(Self);
end;

procedure TFormClientes.Modo(edicao: boolean; novoRegistro: boolean);
begin
  inherited;
  nID.Enabled := not edicao;

  cbTipoPessoa.Enabled := edicao;
  eNomeOficial.Enabled := edicao;
  eNomeSecundario.Enabled := edicao;
  eRegistroReceita.Enabled := edicao;
  eEmail.Enabled := edicao;

  if novoRegistro then
    nID.Clear;

  eNomeOficial.Clear;
  eNomeSecundario.Clear;
  eEmail.Clear;

  cbTipoPessoa.itemIndex := cbTipoPessoa.Items.IndexOf(C_OPCAO_TIPO_PESSOA_FISICA);
  cbTipoPessoaChange(Self);
end;

procedure TFormClientes.nIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  novoRegistro: boolean;
begin
  inherited;
  if Key = VK_RETURN then begin
    novoRegistro := nID.ValueInt = 0;
    Modo(true, novoRegistro);
    Biblioteca.Foco(cbTipoPessoa);
  end;
end;

procedure TFormClientes.cbTipoPessoaChange(Sender: TObject);
begin
  inherited;
  eRegistroReceita.Clear;

  if cbTipoPessoa.Text = C_OPCAO_TIPO_PESSOA_FISICA then begin
    lbNomeOficial.Caption := 'Nome (registro civil)';
    lbNomeSecundario.Caption := 'Nome social';
    lbRegistroReceita.Caption := 'CPF';
    eRegistroReceita.EditMask := '999.999.999-99';
  end
  else begin
    lbNomeOficial.Caption := 'Razão social';
    lbNomeSecundario.Caption := 'Nome fantasia';
    lbRegistroReceita.Caption := 'CNPJ';
    eRegistroReceita.EditMask := '99.999.999/9999-99';
  end;
end;

procedure TFormClientes.VerificarDados;
begin
  inherited;
  eNomeOficial.Text := Trim(eNomeOficial.Text);
  Biblioteca.Obrigatorio(
    lbNomeOficial.Caption,
    Length(eNomeOficial.Text) < 3,
    eNomeOficial
  );

  eNomeSecundario.Text := Trim(eNomeOficial.Text);
  Biblioteca.Obrigatorio(
    lbNomeSecundario,
    Length(eNomeSecundario.Text) < 3,
    eNomeSecundario
  );

  Biblioteca.Obrigatorio(
    lbRegistroReceita,
    Biblioteca.Numeros(eRegistroReceita.Text) = '',
    eRegistroReceita
  );

  if
    ((cbTipoPessoa.Text = C_OPCAO_TIPO_PESSOA_FISICA) and (not Biblioteca.ValidarCPF(eRegistroReceita.Text)))
    or
    ((cbTipoPessoa.Text = C_OPCAO_TIPO_PESSOA_JURIDICA) and (not Biblioteca.ValidarCNPJ(eRegistroReceita.Text)))

  then begin
    Biblioteca.Exclamar('"' + lbRegistroReceita.Caption + '" inválido');
    Biblioteca.Foco(eRegistroReceita);
    Abort;
  end;
end;

procedure TFormClientes.eNomeOficialExit(Sender: TObject);
begin
  inherited;
  eNomeOficial.Text := Trim(eNomeOficial.Text);

  if eNomeSecundario.Text = '' then
    eNomeSecundario.Text := eNomeOficial.Text;

  eNomeSecundario.Text := Trim(eNomeSecundario.Text);
end;

procedure TFormClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := TCloseAction.caFree;
end;

end.
