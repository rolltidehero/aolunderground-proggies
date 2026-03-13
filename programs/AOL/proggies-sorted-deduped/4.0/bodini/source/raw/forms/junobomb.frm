VERSION 5.00
Begin VB.Form junobomb
  Caption = "bodini juno mailbomber"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "junobomb.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2850
  ClientHeight = 2880
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command2
    Caption = "Stop"
    Left = 1440
    Top = 2520
    Width = 1335
    Height = 255
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
  Begin CommandButton Command1
    Caption = "Start"
    Left = 120
    Top = 2520
    Width = 1335
    Height = 255
    TabIndex = 5
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
    Left = 120
    Top = 1560
    Width = 2655
    Height = 855
    Text = "junobomb.frx":30A
    TabIndex = 4
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
    Top = 1200
    Width = 2655
    Height = 285
    Text = "550"
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
  Begin TextBox Text3
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 840
    Width = 2655
    Height = 285
    Text = "bodini 4.0 by: spek"
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
    Left = 120
    Top = 480
    Width = 2655
    Height = 285
    Text = "your juno name"
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
    Left = 120
    Top = 120
    Width = 2655
    Height = 285
    Text = "aim spek"
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
End

Attribute VB_Name = "junobomb"

