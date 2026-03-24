VERSION 5.00
Begin VB.Form mrender
  Caption = "bodini macro render"
  BackColor = &H800000&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "mrender.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2880
  ClientHeight = 2385
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Render Macro"
    Left = 120
    Top = 2040
    Width = 2655
    Height = 255
    TabIndex = 2
  End
  Begin PictureBox Picture1
    BackColor = &H0&
    Picture = "mrender.frx":30A
    Left = 120
    Top = 120
    Width = 2655
    Height = 855
    TabIndex = 1
    ScaleMode = 1
    AutoRedraw = False
    FontTransparent = True
  End
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 1080
    Width = 2655
    Height = 855
    TabIndex = 0
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
    Appearance = 0 'Flat
  End
End

Attribute VB_Name = "mrender"

