object wWelcomeForm: TwWelcomeForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Start'
  ClientHeight = 479
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object clModules: TControlList
    Left = 0
    Top = 0
    Width = 761
    Height = 479
    Align = alClient
    BorderStyle = bsNone
    ItemColor = clBtnFace
    ItemWidth = 180
    ItemHeight = 180
    ItemMargins.Left = 8
    ItemMargins.Top = 8
    ItemMargins.Right = 0
    ItemMargins.Bottom = 0
    ColumnLayout = cltMultiTopToBottom
    ParentColor = False
    TabOrder = 0
    OnBeforeDrawItem = clModulesBeforeDrawItem
    OnItemClick = clModulesItemClick
    object txTitle: TLabel
      Left = 12
      Top = 132
      Width = 157
      Height = 21
      Alignment = taCenter
      AutoSize = False
      Caption = 'txTitle'
      EllipsisPosition = epEndEllipsis
      Layout = tlCenter
    end
    object imIcon: TVirtualImage
      Left = 40
      Top = 12
      Width = 96
      Height = 96
      ImageCollection = dmCommon.icSvgIcons
      ImageWidth = 0
      ImageHeight = 0
      ImageIndex = -1
    end
  end
end
