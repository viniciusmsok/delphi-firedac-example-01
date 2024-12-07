object FMain: TFMain
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'Delphi Firedac Example 01'
  ClientHeight = 441
  ClientWidth = 624
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmMenu
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object mmMenu: TMainMenu
    Left = 272
    Top = 16
    object miRegister: TMenuItem
      Caption = '&Register'
      object miCustomer: TMenuItem
        Caption = '&Customer'
        OnClick = miCustomerClick
      end
    end
    object miPtBR: TMenuItem
      Caption = 'Pt-BR'
      OnClick = miPtBRClick
    end
    object miEnUS: TMenuItem
      Caption = 'En-US'
      OnClick = miPtBRClick
    end
  end
end
