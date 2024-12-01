unit _Environment;

interface

uses
  System.Classes, Winapi.Windows, System.SysUtils, System.Generics.Collections;

type
  Environment = class
  private
    class var localEnv: TDictionary<string, string>;
    class procedure StartLocalEnv;
  public
    class function GetEnv(const name: string; default: string; const options: array of string): string; overload;
    class function GetEnv(const name: string; default: string = ''; const options: TArray<string> = []): string; overload;
    class procedure SetEnv(const name: string; const value: string; const options: array of string); overload;
    class procedure SetEnv(const name: string; const value: string; const options: TArray<string>); overload;
  end;

implementation

{ Environment }

class procedure Environment.StartLocalEnv;
begin
  if (Environment.localEnv = nil) or (not Assigned(Environment.localEnv)) then
    Environment.localEnv := TDictionary<string, string>.Create;
end;

class function Environment.GetEnv(const name: string; default: string; const options: array of string): string;
var
  i: Integer;
  opt: TArray<string>;
begin
  SetLength(opt, Length(options));

  for i := Low(opt) to High(opt) do
    opt[i] := options[i];

  Result := Environment.GetEnv(name, default, opt);
end;

class function Environment.GetEnv(const name: string; default: string = ''; const options: TArray<string> = []): string;
var
  size: DWORD;
  buffer: array[0..255] of Char;
begin
  Environment.StartLocalEnv;

  if Environment.localEnv.TryGetValue(name, Result) then
    Exit;

  Result := default;
  size := GetEnvironmentVariable(PChar(Name), buffer, Length(Buffer));
  if size = 0 then
    Exit;

  if TArray.IndexOf<string>(options, buffer) < 0 then
    Exit;

  Result := buffer;
end;

class procedure Environment.SetEnv(const name: string; const value: string; const options: array of string);
var
  i: Integer;
  opt: TArray<string>;
begin
  SetLength(opt, Length(options));

  for i := Low(opt) to High(opt) do
    opt[i] := options[i];

  Environment.SetEnv(name, value, opt);
end;

class procedure Environment.SetEnv(const name: string; const value: string; const options: TArray<string>);
begin
  Environment.StartLocalEnv;

  if (options <> nil) and (Length(options) > 0) then begin
    if TArray.IndexOf<string>(options, value) < 0 then
      raise Exception.CreateFmt('Invalid environment value for "%s" parameter.', [name]);
  end;

  Environment.localEnv.AddOrSetValue(name, value);

  if not SetEnvironmentVariable(PChar(Name), PChar(value)) then
    raise Exception.CreateFmt('Could not set environment variable "%s".', [name]);
end;

end.
