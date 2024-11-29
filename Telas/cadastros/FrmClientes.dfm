inherited FormClientes: TFormClientes
  Caption = 'Clientes'
  ClientHeight = 210
  ClientWidth = 629
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  ExplicitWidth = 645
  ExplicitHeight = 249
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 0
    Top = 63
    Width = 11
    Height = 15
    Caption = 'ID'
  end
  object lbNomeOficial: TLabel [1]
    Left = 0
    Top = 119
    Width = 108
    Height = 15
    Caption = 'Nome (registro civil)'
  end
  object lbRegistroReceita: TLabel [2]
    Left = 0
    Top = 165
    Width = 21
    Height = 15
    Caption = 'CPF'
  end
  object Label4: TLabel [3]
    Left = 129
    Top = 61
    Width = 78
    Height = 15
    Caption = 'Tipo de pessoa'
  end
  object lbNomeSecundario: TLabel [4]
    Left = 316
    Top = 119
    Width = 66
    Height = 15
    Caption = 'Nome social'
  end
  object Label2: TLabel [5]
    Left = 169
    Top = 165
    Width = 34
    Height = 15
    Caption = 'E-mail'
  end
  inherited pnTopo: TPanel
    Width = 629
    TabOrder = 5
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 629
  end
  object nID: TNumberBox
    Left = 0
    Top = 81
    Width = 123
    Height = 23
    CurrencyFormat = nbcfNone
    Decimal = 0
    DisplayFormat = '#'
    MaxValue = 999999999.000000000000000000
    MaxLength = 10
    TabOrder = 0
    OnKeyDown = nIDKeyDown
  end
  object eNomeOficial: TEdit
    Left = 0
    Top = 137
    Width = 309
    Height = 23
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 2
    OnExit = eNomeOficialExit
    OnKeyDown = OnEnterNext
  end
  object cbTipoPessoa: TComboBox
    Left = 129
    Top = 81
    Width = 145
    Height = 23
    Style = csDropDownList
    Enabled = False
    TabOrder = 1
    OnChange = cbTipoPessoaChange
    OnKeyDown = OnEnterNext
  end
  object eRegistroReceita: TMaskEdit
    Left = 0
    Top = 183
    Width = 163
    Height = 23
    Enabled = False
    TabOrder = 4
    Text = ''
    OnKeyDown = OnEnterNext
  end
  object eNomeSecundario: TEdit
    Left = 316
    Top = 137
    Width = 309
    Height = 23
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 3
    OnKeyDown = OnEnterNext
  end
  object eEmail: TEdit
    Left = 169
    Top = 183
    Width = 256
    Height = 23
    CharCase = ecLowerCase
    Enabled = False
    TabOrder = 6
    OnExit = eNomeOficialExit
    OnKeyDown = OnEnterNext
  end
end
