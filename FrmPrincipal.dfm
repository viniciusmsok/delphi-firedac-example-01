object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'Exemplo MySQL 01'
  ClientHeight = 441
  ClientWidth = 624
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 272
    Top = 16
    object miCadastros: TMenuItem
      Caption = 'Cadastros'
      object miClientes: TMenuItem
        Caption = 'Clientes'
        OnClick = miClientesClick
      end
    end
  end
end
