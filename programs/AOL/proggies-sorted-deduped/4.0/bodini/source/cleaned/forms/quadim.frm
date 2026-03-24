ï»¿VERSION 5.00
Begin VB.Form quadim
  Caption = "bodini quad im"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "quadim.frx":0
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 5430
  ClientHeight = 2250
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command6
    Caption = "Clear All"
    Left = 2760
    Top = 1920
    Width = 1215
    Height = 255
    TabIndex = 13
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
  Begin CommandButton Command4
    Caption = "Send"
    Left = 4080
    Top = 1560
    Width = 1215
    Height = 255
    TabIndex = 12
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
  Begin CommandButton Command3
    Caption = "Send"
    Left = 2760
    Top = 1560
    Width = 1215
    Height = 255
    TabIndex = 11
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
  Begin CommandButton Command2
    Caption = "Send"
    Left = 1440
    Top = 1560
    Width = 1215
    Height = 255
    TabIndex = 10
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
  Begin CommandButton Command1
    Caption = "Send"
    Left = 120
    Top = 1560
    Width = 1215
    Height = 255
    TabIndex = 9
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
  Begin TextBox Text8
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 4080
    Top = 480
    Width = 1215
    Height = 975
    Text = "quadim.frx":30A
    TabIndex = 8
    MultiLine = -1  'True
    ScrollBars = 2
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
  Begin TextBox Text7
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2760
    Top = 480
    Width = 1215
    Height = 975
    Text = "quadim.frx":317
    TabIndex = 7
    MultiLine = -1  'True
    ScrollBars = 2
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
  Begin TextBox Text6
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1440
    Top = 480
    Width = 1215
    Height = 975
    Text = "quadim.frx":324
    TabIndex = 6
    MultiLine = -1  'True
    ScrollBars = 2
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
  Begin TextBox Text5
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 480
    Width = 1215
    Height = 975
    Text = "quadim.frx":331
    TabIndex = 5
    MultiLine = -1  'True
    ScrollBars = 2
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
  Begin CommandButton Command5
    Caption = "Send All"
    Left = 1440
    Top = 1920
    Width = 1215
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
  Begin TextBox Text4
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 4080
    Top = 120
    Width = 1215
    Height = 285
    Text = "xx dajigga"
    TabIndex = 3
    ScrollBars = 2
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
  Begin TextBox Text3
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2760
    Top = 120
    Width = 1215
    Height = 285
    Text = "bofelv"
    TabIndex = 2
    ScrollBars = 2
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
    Left = 1440
    Top = 120
    Width = 1215
    Height = 285
    Text = "unab0mb p3"
    TabIndex = 1
    ScrollBars = 2
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
    Left = 120
    Top = 120
    Width = 1215
    Height = 285
    Text = "aim spek"
    TabIndex = 0
    ScrollBars = 2
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
End

Attribute VB_Name = "quadim"

