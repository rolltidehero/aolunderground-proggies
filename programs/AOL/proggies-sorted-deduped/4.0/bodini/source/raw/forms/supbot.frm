VERSION 5.00
Begin VB.Form supbot
  Caption = "bodini sup bot"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "supbot.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 1560
  ClientHeight = 840
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1335
    Height = 285
    Text = "sup yo..."
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
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1320
    Width = 1335
    Height = 645
    Visible = 0   'False
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
  Begin CommandButton Command1
    Caption = "Go"
    Left = 120
    Top = 480
    Width = 1335
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
End

Attribute VB_Name = "supbot"

