unit _MySQLConnectionBD;

interface

uses
  Classes, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Comp.UI,
  _IConexaoBD, _QueryBD, _IQueryBD;

type
  TMySQLConnectionBD = class(TFDConnection, IConexaoBD)
  private
    nomeTransacao: string;
    transacao: TFDTransaction;
    driver: TFDPhysMySQLDriverLink;
    cursor: TFDGUIxWaitCursor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Conectar(
      const servidor: string;
      const porta: Integer;
      const banco: string;
      const usuario: string;
      const senha: string
    );

    function NovaQuery: IQueryBD;

    procedure AbrirTransacao(nome: string);
    procedure VoltarTransacao;
    procedure ConfirmarTransacao;
  end;

implementation

{ TConexaoBD }

constructor TMySQLConnectionBD.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  cursor := TFDGUIxWaitCursor.Create(AOwner);

  Self.driver := TFDPhysMySQLDriverLink.Create(AOwner);
  Self.transacao := TFDTransaction.Create(Self);
  nomeTransacao := '';
end;

procedure TMySQLConnectionBD.Conectar(
  const servidor: string;
  const porta: Integer;
  const banco: string;
  const usuario: string;
  const senha: string
);
begin
  ConnectionName := usuario;

  DriverName := 'MySQL';
  LoginPrompt := False;

  Params.DriverID := 'MySQL';
  Params.Add('Server=' + servidor);
  Params.Add('Port=' + IntToStr(porta));
  Params.Database := banco;
  Params.UserName := usuario;
  Params.Password := senha;

  driver := TFDPhysMySQLDriverLink.Create(Self.Owner);
  driver.VendorLib := GetCurrentDir + PathDelim + 'libmysql.dll';

  Connected := True;
end;

function TMySQLConnectionBD.NovaQuery: IQueryBD;
begin
  Result := TQueryBD.Create(Self);
  TQueryBD(Result).Connection := Self;
end;

procedure TMySQLConnectionBD.AbrirTransacao(nome: string);
begin
  if (nome = '') or (Trim(Self.nomeTransacao) <> Self.nomeTransacao) then
    raise Exception.Create('Nome de transação inválido: ' + nome);

  if Self.nomeTransacao <> '' then begin
    raise Exception.Create(
      'Não foi possível abrir a transação "' + nome + '". ' +
      'A transação "' + Self.nomeTransacao + '" está aberta.'
    );
  end;

  Self.transacao.StartTransaction;
  Self.nomeTransacao := nome;
end;

procedure TMySQLConnectionBD.VoltarTransacao;
begin
  try
    Self.transacao.Rollback;
  finally
    Self.nomeTransacao := '';
  end;
end;

procedure TMySQLConnectionBD.ConfirmarTransacao;
begin
  try
    Self.transacao.Commit;
  finally
    Self.nomeTransacao := '';
  end;
end;

destructor TMySQLConnectionBD.Destroy;
begin
  Self.driver.Free;
  Self.transacao.Free;
  Self.cursor.Free;

  inherited;
end;

end.
