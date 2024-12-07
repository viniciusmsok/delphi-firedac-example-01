inherited FCustomers: TFCustomers
  Caption = 'Customers'
  ClientHeight = 208
  ClientWidth = 629
  StyleElements = [seFont, seClient, seBorder]
  OnClose = FormClose
  ExplicitWidth = 645
  ExplicitHeight = 247
  TextHeight = 15
  object lbID: TLabel [0]
    Left = 0
    Top = 63
    Width = 11
    Height = 15
    Caption = 'ID'
  end
  object lbOficialName: TLabel [1]
    Left = 0
    Top = 119
    Width = 32
    Height = 15
    Caption = 'Name'
  end
  object lbFederalID: TLabel [2]
    Left = 0
    Top = 165
    Width = 21
    Height = 15
    Caption = 'CPF'
  end
  object lbPersonType: TLabel [3]
    Left = 129
    Top = 61
    Width = 62
    Height = 15
    Caption = 'Person type'
  end
  object lbSocialName: TLabel [4]
    Left = 316
    Top = 119
    Width = 64
    Height = 15
    Caption = 'Social name'
  end
  object lbEmail: TLabel [5]
    Left = 169
    Top = 165
    Width = 34
    Height = 15
    Caption = 'E-mail'
  end
  inherited pnTop: TPanel
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
  object eMainName: TEdit
    Left = 0
    Top = 137
    Width = 309
    Height = 23
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 2
    OnExit = eMainNameExit
    OnKeyDown = OnEnterNext
  end
  object cbPersonType: TComboBox
    Left = 129
    Top = 81
    Width = 145
    Height = 23
    Style = csDropDownList
    Enabled = False
    TabOrder = 1
    OnChange = cbPersonTypeChange
    OnKeyDown = OnEnterNext
  end
  object eFederalID: TMaskEdit
    Left = 0
    Top = 183
    Width = 163
    Height = 23
    Enabled = False
    TabOrder = 4
    Text = ''
    OnKeyDown = OnEnterNext
  end
  object eSocialName: TEdit
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
    OnExit = eMainNameExit
    OnKeyDown = OnEnterNext
  end
end
