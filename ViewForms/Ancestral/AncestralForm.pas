unit AncestralForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Graphics,
  _Library, _Language;

type
  TFAncestral = class(TForm)
    procedure FormDestroy(Sender: TObject);
  public
    language: TLanguage;
    procedure FormCreate(Sender: TObject);

    function GetCaption(name: string): string;
    procedure AddCaption(name: string; ptBRCaption: string; enUSCaption: string);
  protected
    procedure ConfigLanguage; virtual;
  end;

implementation

{$R *.dfm}

{ TFAncestral }

procedure TFAncestral.ConfigLanguage;
begin
  //None
end;

procedure TFAncestral.FormCreate(Sender: TObject);
begin
  inherited;
  Self.language := TLanguage.Create;
  Self.ConfigLanguage;
  Self.language.Apply(Self);
end;

function TFAncestral.GetCaption(name: string): string;
begin
  Result := 'aaa';
  Result := Self.language.GetCaption(name);
end;

procedure TFAncestral.AddCaption(name: string; ptBRCaption: string; enUSCaption: string);
begin
  Self.language.SetCaption(name, ptBRCaption, enUSCaption);
end;

procedure TFAncestral.FormDestroy(Sender: TObject);
begin
  Self.language.Free;
  inherited;
end;

end.
