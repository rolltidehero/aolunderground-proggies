VERSION 5.00
Begin VB.Form echo
  Caption = "bodini echo bot"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "echo.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 1560
  ClientHeight = 810
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Start"
    Left = 120
    Top = 480
    Width = 1335
    Height = 255
    TabIndex = 2
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
  Begin TextBox Text2
    BackColor = &HFF8080&
    Left = 120
    Top = 2160
    Width = 1335
    Height = 285
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
    Width = 1335
    Height = 285
    Text = "aim spek"
    TabIndex = 0
    MaxLength = 10
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
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 100
    Left = 600
    Top = 2640
  End
End

Attribute VB_Name = "echo"

