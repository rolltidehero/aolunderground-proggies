VERSION 5.00
Begin VB.Form mmbot
  Caption = "bodini mass mailer bot"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "mmbot.frx":0
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 3360
  ClientHeight = 1545
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Start"
    Left = 120
    Top = 1200
    Width = 3135
    Height = 255
    TabIndex = 4
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
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1215
    Height = 1035
    TabIndex = 3
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
  Begin Timer Timer2
    Enabled = 0   'False
    Interval = 60000
    Left = 840
    Top = 2280
  End
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 10
    Left = 480
    Top = 2280
  End
  Begin TextBox Text3
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2160
    Top = 840
    Width = 1095
    Height = 285
    Text = "remove me"
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
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2160
    Top = 480
    Width = 1095
    Height = 285
    Text = "add me"
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
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2160
    Top = 120
    Width = 1095
    Height = 285
    Text = "10"
    TabIndex = 0
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
  Begin Label Label3
    Caption = "remove:"
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 840
    Width = 615
    Height = 255
    TabIndex = 7
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label2
    Caption = "add:"
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 480
    Width = 615
    Height = 255
    TabIndex = 6
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label1
    Caption = "min(s):"
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 120
    Width = 615
    Height = 255
    TabIndex = 5
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Tahoma"
      Size = 8.25
      Charset = 0
      Weight = 400
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "mmbot"

