ï»¿VERSION 5.00
Begin VB.Form mmoption
  Caption = "bodini mass mailer options"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 0 'None
  Icon = "mmoption.frx":0
  LinkTopic = "Form1"
  ClientLeft = 0
  ClientTop = 0
  ClientWidth = 4680
  ClientHeight = 2145
  ShowInTaskbar = 0   'False
  StartUpPosition = 3 'Windows Default
  Begin CheckBox Check8
    Caption = "Remove Forward"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 1560
    Width = 1815
    Height = 195
    TabIndex = 11
    Value = 1
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
  Begin CheckBox Check7
    Caption = "Keep Mail As New"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 1320
    Width = 1815
    Height = 195
    TabIndex = 10
    Value = 1
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
  Begin CheckBox Check6
    Caption = "BBC Mails"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 1080
    Width = 1815
    Height = 195
    TabIndex = 9
    Value = 1
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
  Begin CheckBox Check5
    Caption = "Sign Off After MM"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 840
    Width = 1815
    Height = 195
    TabIndex = 8
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
  Begin CheckBox Check4
    Caption = "Close Chat Room"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 600
    Width = 1815
    Height = 195
    TabIndex = 7
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
  Begin CheckBox Check3
    Caption = "Turn IMs Off"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 360
    Width = 1815
    Height = 195
    TabIndex = 6
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
  Begin CheckBox Check2
    Caption = "All Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1680
    Width = 1215
    Height = 195
    TabIndex = 5
    Value = 1
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
  Begin CheckBox Check1
    Caption = "Select Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1440
    Width = 1215
    Height = 195
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
  Begin OptionButton Option4
    Caption = "Flash Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1080
    Width = 1215
    Height = 255
    TabIndex = 3
    Value = 255
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
  Begin OptionButton Option3
    Caption = "Sent Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 840
    Width = 1215
    Height = 255
    TabIndex = 2
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
  Begin OptionButton Option2
    Caption = "Old Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 600
    Width = 1215
    Height = 255
    TabIndex = 1
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
  Begin OptionButton Option1
    Caption = "New Mail"
    BackColor = &HFFC0C0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 360
    Width = 1215
    Height = 255
    TabIndex = 0
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
  Begin Label Label3
    Caption = "bodini mm options"
    ForeColor = &HFFFFFF&
    Left = 1560
    Top = 15
    Width = 1275
    Height = 195
    TabIndex = 14
    AutoSize = -1  'True
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
    Caption = "-"
    ForeColor = &HFFFFFF&
    Left = 4320
    Top = 0
    Width = 60
    Height = 210
    TabIndex = 13
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
    Caption = "x"
    ForeColor = &HFFFFFF&
    Left = 4440
    Top = 0
    Width = 90
    Height = 210
    TabIndex = 12
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

Attribute VB_Name = "mmoption"

