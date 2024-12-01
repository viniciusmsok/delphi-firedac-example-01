unit _Language;

interface

uses
  System.Classes, Winapi.Windows, System.SysUtils, System.Generics.Collections,
  Vcl.Forms, Vcl.Buttons, Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus,
  _Environment;

type
  LanguageCaption = record
    language: string;
    value: string;
  end;

  TLanguageItem = class
  public
    const PT_BR = 'ptBR';
    const EN_US = 'enUS';
    const LANGUAGE_LIST: array of string = [TLanguageItem.PT_BR, TLanguageItem.EN_US];

    var name: string;
    var captions: array of LanguageCaption;

    constructor Create(name: string; ptBRCaption: string; enUSCaption: string);
     function GetCaption(const lang: string): string;
  end;

  TLanguage = class
  private
    class var lang: string;
    const ENVIRONMENT_LANGUAGE_CONFIGURATION = 'APP_ENV_LANGUAGE_CONFIGURATION';
  public
    items: TDictionary<string, TLanguageItem>;

    constructor Create;
    destructor Destroy; override;
    function GetCaption(const name: string): string;
    procedure SetCaption(name: string; ptBRCaption: string; enUSCaption: string);
    procedure Apply(const form: TForm);

    class function GetConfiguration: string;
    class procedure SetConfiguration(language: string);
  end;

implementation

{ TLanguageItem }

constructor TLanguageItem.Create(name: string; ptBRCaption: string; enUSCaption: string);
var
  i: Integer;
begin
  Self.name := name;

  SetLength(captions, Length(Self.LANGUAGE_LIST));
  for i := Low(Self.LANGUAGE_LIST) to High(Self.LANGUAGE_LIST) do begin
    captions[i].language := Self.LANGUAGE_LIST[i];

    if captions[i].language = PT_BR then
      captions[i].value := ptBRCaption
    else if captions[i].language = EN_US then
      captions[i].value := enUSCaption;
  end;
end;

function TLanguageItem.GetCaption(const lang: string): string;
begin
  Result := '';
  for var caption in Self.captions do begin
    if caption.language <> lang then
      Continue;

    Result := caption.value;
    Break;
  end;
end;

{ TLanguage }

constructor TLanguage.Create;
begin
  Self.items := TDictionary<string, TLanguageItem>.Create;
end;

destructor TLanguage.Destroy;
var
  obj: TLanguageItem;
begin
  for obj in Self.items.Values do
    obj.Free;

  Self.items.Clear;
end;

function TLanguage.GetCaption(const name: string): string;
var
  item: TLanguageItem;
begin
  Result := '';

  Self.items.TryGetValue(name, item);
  if item = nil then
    raise Exception.CreateFmt('Unable to find "%s" component caption.', [name]);

  Result := item.GetCaption(Self.lang);
end;

procedure TLanguage.SetCaption(name: string; ptBRCaption: string; enUSCaption: string);
begin
  if Self.items.ContainsKey(name) then begin
    Self.items[name].Free;
    Self.items.Remove(name);
  end;

  Self.items.Add(name, TLanguageItem.Create(name, ptBRCaption, enUSCaption));
end;

class procedure TLanguage.SetConfiguration(language: string);
begin
  TLanguage.lang := language;

  Environment.SetEnv(
    Self.ENVIRONMENT_LANGUAGE_CONFIGURATION,
    language,
    TLanguageItem.LANGUAGE_LIST
  );
end;

class function TLanguage.GetConfiguration: string;
begin
  Result := Environment.GetEnv(
    Self.ENVIRONMENT_LANGUAGE_CONFIGURATION,
    TLanguageItem.EN_US,
    TLanguageItem.LANGUAGE_LIST
  );
end;

procedure TLanguage.Apply(const form: TForm);
var
  c: TComponent;
  captionTxt: string;
begin
  if Self.items.Count = 0 then
    Exit;

  for var item in Self.items do begin
    captionTxt := GetCaption(item.Key);

    if form.Name = item.Key then
      form.Caption := captionTxt;

    c := form.FindComponent(item.Key);
    if c = nil then
      Continue;

    if c is TForm then
      TForm(c).Caption := captionTxt;

    if c is TBitBtn then
      TBitBtn(c).Caption := captionTxt;

    if c is TPanel then
      TPanel(c).Caption := captionTxt;

    if c is TCustomLabel then
      TCustomLabel(c).Caption := captionTxt;

    if c is TMenuItem then
      TMenuItem(c).Caption := captionTxt;
  end;
end;

end.
