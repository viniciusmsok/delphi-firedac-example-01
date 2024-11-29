unit _Biblioteca;

interface

uses
  Winapi.Windows,
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  System.SysUtils;

type
  Biblioteca = class
  public
    class procedure Erro(const mensagem: string; const titulo: string = 'Erro');
    class procedure Exclamar(const mensagem: string; const titulo: string = 'Atenção');
    class procedure Foco(const componente: TWinControl);
    class procedure Informar(const mensagem: string; const titulo: string = 'Informação');
    class procedure Obrigatorio(const legenda: TCustomLabel; const campo: TCustomEdit; const aplicarTrim: Boolean = True); overload;
    class procedure Obrigatorio(const nomeCampo: string; const campo: TCustomEdit; const aplicarTrim: Boolean = True); overload;
    class procedure Obrigatorio(const legenda: TCustomLabel; const condicaoExcecao: Boolean; const campoFoco: TCustomEdit = nil); overload;
    class procedure Obrigatorio(const nomeCampo: string; const condicaoExcecao: Boolean; const campoFoco: TWinControl = nil); overload;
    class function Numeros(const texto: string): string;
    class function Questionar(const mensagem: string): Boolean;
    class function ValidarCPF(sentenca: string): Boolean;
    class function ValidarCNPJ(sentenca: string): boolean;
  end;

implementation

{ Biblioteca }

class procedure Biblioteca.Erro(const mensagem: string; const titulo: string = 'Erro');
begin
  MessageBox(Application.handle, PChar(mensagem), PChar(titulo), MB_OK + MB_ICONERROR + MB_APPLMODAL);
end;

class procedure Biblioteca.Exclamar(const mensagem: string; const titulo: string = 'Atenção');
begin
  MessageBox(Application.handle, PChar(mensagem), PChar(titulo), MB_OK + MB_ICONWARNING + MB_APPLMODAL);
end;

class procedure Biblioteca.Foco(const componente: TWinControl);
begin
  try
    if (componente <> nil) and componente.CanFocus then
      componente.SetFocus;
  except
    //nada
  end;
end;

class procedure Biblioteca.Informar(const mensagem: string; const titulo: string = 'Informação');
begin
  MessageBox(Application.handle, PChar(mensagem), PChar(titulo), MB_OK + MB_ICONINFORMATION + MB_APPLMODAL);
end;

class procedure Biblioteca.Obrigatorio(const legenda: TCustomLabel; const campo: TCustomEdit; const aplicarTrim: Boolean = True);
begin
  Biblioteca.Obrigatorio(legenda.Caption, campo, aplicarTrim);
end;

class procedure Biblioteca.Obrigatorio(const nomeCampo: string; const campo: TCustomEdit; const aplicarTrim: Boolean = True);
begin
  if aplicarTrim then  
    campo.Text := Trim(campo.Text);

  Biblioteca.Obrigatorio(nomeCampo, campo.Text = '', campo);
end;

class procedure Biblioteca.Obrigatorio(const legenda: TCustomLabel; const condicaoExcecao: Boolean; const campoFoco: TCustomEdit = nil);
begin
  Biblioteca.Obrigatorio(legenda.Caption, condicaoExcecao, campoFoco);
end;

class procedure Biblioteca.Obrigatorio(const nomeCampo: string; const condicaoExcecao: Boolean; const campoFoco: TWinControl = nil);
begin
  if not condicaoExcecao then
    Exit;

  Biblioteca.Exclamar('Preencha o campo "' + nomeCampo + '".', 'Campo obrigatório');
  Biblioteca.Foco(campoFoco);
  Abort;
end;

class function Biblioteca.Numeros(const texto: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(texto) do begin
    if CharInSet(texto[i], ['0'..'9']) then
      Result := Result + texto[i];
  end;
end;

class function Biblioteca.Questionar(const mensagem: string): Boolean;
begin
  Result := MessageBox(Application.handle, PChar(mensagem), 'Diálogo', MB_YESNO + MB_ICONQUESTION + MB_APPLMODAL) = ID_YES;
end;

class function Biblioteca.ValidarCPF(sentenca: string): Boolean;
var
  i: Integer;
  dv: Integer;
  soma: Integer;
begin
  Result := False;

  sentenca := Biblioteca.Numeros(sentenca);
  if Length(sentenca) <> 11 then
    Exit;

  if sentenca = StringOfChar(sentenca[1], 11) then
    Exit;

  soma := 0;
  for i := 1 to 9 do
    soma := soma + (StrToInt(sentenca[10 - i]) * (i + 1));

  dv := ((11 - (soma mod 11)) mod 11) mod 10;

  if dv <> StrToInt(sentenca[10]) then
    Exit;

  soma := 0;
  for i := 1 to 10 do
    soma := soma + (StrToInt(sentenca[11 - i]) * (i + 1));

  dv := ((11 - (soma mod 11)) mod 11) mod 10;

  if IntToStr(dv) = sentenca[11] then
    Result := true;
end;

class function Biblioteca.ValidarCNPJ(sentenca: string): boolean;
var
  i: Integer;
  r: Integer;
  dv: Integer;
  soma: Integer;
  peso: Integer;
begin
  Result := False;

  sentenca := Biblioteca.Numeros(sentenca);
  if Length(sentenca) <> 14 then
    Exit;

  if sentenca = StringOfChar(sentenca[1], 14) then
    Exit;

  soma := 0;
  peso := 2;
  for i := 12 downto 1 do begin
    soma := soma + (StrToInt(sentenca[i]) * peso);

    Inc(peso);
    if peso = 10 then
      peso := 2;
  end;

  dv := 0;

  r := soma mod 11;
  if r > 1 then
    dv := 11 - r;

  if dv <> StrToInt(sentenca[13]) then
    Exit;

  soma := 0;
  peso := 2;
  for i := 13 downto 1 do begin
    soma := soma + (StrToInt(sentenca[i]) * peso);

    Inc(peso);
    if peso = 10 then
      peso := 2;
  end;

  dv := 0;

  r := soma mod 11;
  if r > 1 then
    dv := 11 - r;

  if dv = StrToInt(sentenca[14]) then
    Result := True;
end;

end.
