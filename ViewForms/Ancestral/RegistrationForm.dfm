inherited FRegistration: TFRegistration
  Caption = 'FRegistration'
  ClientHeight = 412
  ClientWidth = 631
  StyleElements = [seFont, seClient, seBorder]
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 647
  ExplicitHeight = 451
  TextHeight = 15
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 631
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btSave: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Save'
      Enabled = False
      TabOrder = 0
      TabStop = False
      OnClick = btSaveClick
    end
    object btCancel: TBitBtn
      AlignWithMargins = True
      Left = 129
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Cancel'
      Enabled = False
      TabOrder = 1
      TabStop = False
      OnClick = btCancelClick
    end
    object btDelete: TBitBtn
      AlignWithMargins = True
      Left = 255
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = '&Delete'
      Enabled = False
      TabOrder = 2
      TabStop = False
      OnClick = btDeleteClick
    end
    object btSearch: TBitBtn
      AlignWithMargins = True
      Left = 381
      Top = 3
      Width = 120
      Height = 43
      Align = alLeft
      Caption = 'S&earch'
      TabOrder = 3
      TabStop = False
      OnClick = btSearchClick
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
      OnClick = btLogsClick
    end
  end
end
