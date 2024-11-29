inherited FormCadastro: TFormCadastro
  Caption = 'FormCadastro'
  ClientHeight = 412
  ClientWidth = 631
  StyleElements = [seFont, seClient, seBorder]
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 647
  ExplicitHeight = 451
  TextHeight = 15
  object pnTopo: TPanel
    Left = 0
    Top = 0
    Width = 631
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 764
    object btSalvar: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Salvar'
      Enabled = False
      TabOrder = 0
      TabStop = False
      OnClick = btSalvarClick
    end
    object btCancelar: TBitBtn
      AlignWithMargins = True
      Left = 129
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Cancelar'
      Enabled = False
      TabOrder = 1
      TabStop = False
      OnClick = btCancelarClick
    end
    object btExcluir: TBitBtn
      AlignWithMargins = True
      Left = 255
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Excluir'
      Enabled = False
      TabOrder = 2
      TabStop = False
      OnClick = btExcluirClick
    end
    object btPesquisar: TBitBtn
      AlignWithMargins = True
      Left = 381
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Pesquisar'
      TabOrder = 3
      TabStop = False
    end
    object btLogs: TBitBtn
      AlignWithMargins = True
      Left = 507
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Logs'
      Enabled = False
      TabOrder = 4
      TabStop = False
    end
  end
end
