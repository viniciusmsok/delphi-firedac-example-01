unit _Library;

interface

uses
  Winapi.Windows,
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  System.SysUtils, System.StrUtils,
  _Language;

type
  Lib = class
  private
    class procedure GetMessageElements(
      msgPtBR: string;
      msgEnUS: string;
      titlePtBR: string;
      titleEnUS: string;
      var resultTitle: string;
      var resultMessage: string
    );
  public
    class procedure Error(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = '');
    class procedure Exclaim(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = '');
    class procedure Inform(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = '');
    class function Dialog(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = ''): Boolean;

    class procedure Focus(const component: TWinControl);

    class procedure Required(const labelItem: TCustomLabel; const field: TCustomEdit; const applyTrim: Boolean = True); overload;
    class procedure Required(const fieldName: string; const field: TCustomEdit; const applyTrim: Boolean = True); overload;
    class procedure Required(const labelItem: TCustomLabel; const exceptionCondition: Boolean; const focusField: TCustomEdit = nil); overload;
    class procedure Required(const fieldName: string; const exceptionCondition: Boolean; const focusField: TWinControl = nil); overload;

    class function Numbers(const sentence: string): string;
    class function ValidateCPF(sentence: string): Boolean;
    class function ValidateCNPJ(sentence: string): boolean;
  end;

implementation

{ Lib }

class procedure Lib.GetMessageElements(
  msgPtBR: string;
  msgEnUS: string;
  titlePtBR: string;
  titleEnUS: string;
  var resultTitle: string;
  var resultMessage: string
);
var
  lang: string;
begin
  lang := TLanguage.GetConfiguration;
  resultTitle := IfThen(lang = TLanguageItem.PT_BR, titlePtBR, titleEnUS);
  resultMessage := IfThen(lang = TLanguageItem.PT_BR, msgPtBR, msgEnUS);
end;

class procedure Lib.Error(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = '');
var
  msg: string;
  title: string;
begin
  Lib.GetMessageElements(
    msgPtBR,
    msgEnUS,
    IfThen(titlePtBR = '', 'Erro', titlePtBR),
    IfThen(titleEnUS = '', 'Error', titleEnUS),
    title,
    msg
  );

  MessageBox(Application.handle, PChar(msg), PChar(title), MB_OK + MB_ICONERROR + MB_APPLMODAL);
end;

class procedure Lib.Exclaim(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = '');
var
  msg: string;
  title: string;
begin
  Lib.GetMessageElements(
    msgPtBR,
    msgEnUS,
    IfThen(titlePtBR = '', 'Atenção', titlePtBR),
    IfThen(titleEnUS = '', 'Warning', titleEnUS),
    title,
    msg
  );

  MessageBox(Application.handle, PChar(msg), PChar(title), MB_OK + MB_ICONWARNING + MB_APPLMODAL);
end;

class procedure Lib.Inform(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = '');
var
  msg: string;
  title: string;
begin
  Lib.GetMessageElements(
    msgPtBR,
    msgEnUS,
    IfThen(titlePtBR = '', 'Informação', titlePtBR),
    IfThen(titleEnUS = '', 'Inform', titleEnUS),
    title,
    msg
  );

  MessageBox(Application.handle, PChar(msg), PChar(title), MB_OK + MB_ICONINFORMATION + MB_APPLMODAL);
end;

class function Lib.Dialog(msgPtBR: string; msgEnUS: string; titlePtBR: string = ''; titleEnUS: string = ''): Boolean;
var
  msg: string;
  title: string;
begin
  Lib.GetMessageElements(
    msgPtBR,
    msgEnUS,
    IfThen(titlePtBR = '', 'Diálogo', titlePtBR),
    IfThen(titleEnUS = '', 'Dialog', titleEnUS),
    title,
    msg
  );

  Result := MessageBox(Application.handle, PChar(msg), PChar(title), MB_YESNO + MB_ICONQUESTION + MB_APPLMODAL) = ID_YES;
end;

class procedure Lib.Focus(const component: TWinControl);
begin
  try
    if (component <> nil) and component.CanFocus then
      component.SetFocus;
  except
    //nada
  end;
end;

class procedure Lib.Required(const labelItem: TCustomLabel; const field: TCustomEdit; const applyTrim: Boolean = True);
begin
  Lib.Required(labelItem.Caption, field, applyTrim);
end;

class procedure Lib.Required(const fieldName: string; const field: TCustomEdit; const applyTrim: Boolean = True);
begin
  if applyTrim then
    field.Text := Trim(field.Text);

  Lib.Required(fieldName, field.Text = '', field);
end;

class procedure Lib.Required(const labelItem: TCustomLabel; const exceptionCondition: Boolean; const focusField: TCustomEdit = nil);
begin
  Lib.Required(labelItem.Caption, exceptionCondition, focusField);
end;

class procedure Lib.Required(const fieldName: string; const exceptionCondition: Boolean; const focusField: TWinControl = nil);
begin
  if not exceptionCondition then
    Exit;

  Lib.Exclaim(
    'Preencha o campo "' + fieldName + '".',
    'Campo obrigatório'
  );
  Lib.Focus(focusField);
  Abort;
end;

class function Lib.Numbers(const sentence: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(sentence) do begin
    if CharInSet(sentence[i], ['0'..'9']) then
      Result := Result + sentence[i];
  end;
end;

class function Lib.ValidateCPF(sentence: string): Boolean;
var
  i: Integer;
  dv: Integer;
  soma: Integer;
begin
  Result := False;

  sentence := Lib.Numbers(sentence);
  if Length(sentence) <> 11 then
    Exit;

  if sentence = StringOfChar(sentence[1], 11) then
    Exit;

  soma := 0;
  for i := 1 to 9 do
    soma := soma + (StrToInt(sentence[10 - i]) * (i + 1));

  dv := ((11 - (soma mod 11)) mod 11) mod 10;

  if dv <> StrToInt(sentence[10]) then
    Exit;

  soma := 0;
  for i := 1 to 10 do
    soma := soma + (StrToInt(sentence[11 - i]) * (i + 1));

  dv := ((11 - (soma mod 11)) mod 11) mod 10;

  if IntToStr(dv) = sentence[11] then
    Result := true;
end;

class function Lib.ValidateCNPJ(sentence: string): boolean;
var
  i: Integer;
  r: Integer;
  dv: Integer;
  soma: Integer;
  peso: Integer;
begin
  Result := False;

  sentence := Lib.Numbers(sentence);
  if Length(sentence) <> 14 then
    Exit;

  if sentence = StringOfChar(sentence[1], 14) then
    Exit;

  soma := 0;
  peso := 2;
  for i := 12 downto 1 do begin
    soma := soma + (StrToInt(sentence[i]) * peso);

    Inc(peso);
    if peso = 10 then
      peso := 2;
  end;

  dv := 0;

  r := soma mod 11;
  if r > 1 then
    dv := 11 - r;

  if dv <> StrToInt(sentence[13]) then
    Exit;

  soma := 0;
  peso := 2;
  for i := 13 downto 1 do begin
    soma := soma + (StrToInt(sentence[i]) * peso);

    Inc(peso);
    if peso = 10 then
      peso := 2;
  end;

  dv := 0;

  r := soma mod 11;
  if r > 1 then
    dv := 11 - r;

  if dv = StrToInt(sentence[14]) then
    Result := True;
end;

end.
