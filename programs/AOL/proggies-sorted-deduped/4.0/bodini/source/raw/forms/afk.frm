VERSION 5.00
Begin VB.Form afk
  Caption = "bodini afk bot"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "afk.frx":0
  LinkTopic = "Form8"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4680
  ClientHeight = 1980
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 3240
    Top = 1320
    Width = 1335
    Height = 255
    Text = "not available"
    TabIndex = 8
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
  Begin ListBox List3
    Left = 1320
    Top = 2400
    Width = 1215
    Height = 900
    TabIndex = 6
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
  Begin ListBox List2
    Left = 240
    Top = 2400
    Width = 1095
    Height = 690
    TabIndex = 5
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
  Begin TextBox Text1
    Left = 240
    Top = 2280
    Width = 1095
    Height = 315
    TabIndex = 4
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
  Begin Timer Timer2
    Left = 2640
    Top = 2160
  End
  Begin Timer Timer1
    Left = 2640
    Top = 2280
  End
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 4455
    Height = 1035
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
  Begin Label Label7
    Caption = "v"
    ForeColor = &HFFFFFF&
    Left = 720
    Top = 1680
    Width = 90
    Height = 210
    TabIndex = 11
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
  Begin Label Label6
    Caption = "^"
    ForeColor = &HFFFFFF&
    Left = 480
    Top = 1680
    Width = 75
    Height = 210
    TabIndex = 10
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
  Begin Label Label5
    Caption = "3"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1680
    Width = 90
    Height = 210
    TabIndex = 9
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label4
    Caption = "start"
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1320
    Width = 390
    Height = 210
    TabIndex = 7
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label3
    Caption = "minimize"
    ForeColor = &HFFFFFF&
    Left = 1920
    Top = 1320
    Width = 765
    Height = 210
    TabIndex = 3
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label2
    Caption = "close"
    ForeColor = &HFFFFFF&
    Left = 960
    Top = 1320
    Width = 450
    Height = 210
    TabIndex = 2
    AutoSize = -1  'True
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
  Begin Label Label1
    Caption = "0"
    Left = 3120
    Top = 2280
    Width = 495
    Height = 855
    TabIndex = 1
    BorderStyle = 1 'Fixed Single
    Alignment = 2 'Center
    BackStyle = 0 'Transparent
    BeginProperty Font
      Name = "Arial"
      Size = 8.25
      Charset = 0
      Weight = 700
      Underline = 0 'False
      Italic = 0 'False
      Strikethrough = 0 'False
    EndProperty
  End
End

Attribute VB_Name = "afk"

