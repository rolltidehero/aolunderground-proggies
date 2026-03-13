ï»¿VERSION 5.00
Begin VB.Form help
  Caption = "bodini help"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "help.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4305
  ClientHeight = 1590
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Close"
    Left = 120
    Top = 1200
    Width = 4095
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
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 1560
    Top = 120
    Width = 2655
    Height = 1035
    TabIndex = 1
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
  Begin ListBox List1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1455
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
End

Attribute VB_Name = "help"

