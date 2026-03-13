ï»¿VERSION 5.00
Begin VB.Form imlink
  Caption = "bodini im link sender"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "imlink.frx":0
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 3405
  ClientHeight = 1920
  StartUpPosition = 3 'Windows Default
  Begin CheckBox Check1
    Caption = "Check1"
    BackColor = &HFFC0C0&
    ForeColor = &HFFC0C0&
    Left = 840
    Top = 1560
    Width = 255
    Height = 195
    TabIndex = 7
  End
  Begin CommandButton Command1
    Caption = "Send"
    Left = 1200
    Top = 1200
    Width = 1095
    Height = 255
    TabIndex = 6
    Default = -1  'True
    BeginProperty Font
      Name = "Verdana"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin TextBox Text3
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 840
    Width = 2055
    Height = 285
    Text = "x3 online"
    TabIndex = 5
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 480
    Width = 2055
    Height = 285
    Text = "www.xclipticonline.com"
    TabIndex = 2
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 120
    Width = 2055
    Height = 285
    Text = "aim spek"
    TabIndex = 1
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label4
    Caption = "non underlined link"
    ForeColor = &HFFFFFF&
    Left = 1200
    Top = 1560
    Width = 1335
    Height = 210
    TabIndex = 8
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label3
    Caption = "description:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 840
    Width = 840
    Height = 210
    TabIndex = 4
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label2
    Caption = "link url:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 480
    Width = 495
    Height = 210
    TabIndex = 3
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label1
    Caption = "person:"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 555
    Height = 210
    TabIndex = 0
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "imlink"

