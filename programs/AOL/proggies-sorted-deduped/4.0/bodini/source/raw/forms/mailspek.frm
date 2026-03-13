VERSION 5.00
Begin VB.Form mailspek
  Caption = "bodini mail spek"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "mailspek.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 3240
  ClientHeight = 2295
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command2
    Caption = "Clear"
    Left = 1680
    Top = 1920
    Width = 1455
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
    Top = 1920
    Width = 1455
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
  Begin OptionButton Option3
    Caption = "Bugs"
    BackColor = &HFFC0C0&
    Left = 2520
    Top = 480
    Width = 735
    Height = 255
    TabIndex = 4
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
  Begin OptionButton Option2
    Caption = "Questions"
    BackColor = &HFFC0C0&
    Left = 1320
    Top = 480
    Width = 1095
    Height = 255
    TabIndex = 3
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
  Begin OptionButton Option1
    Caption = "Comments"
    BackColor = &HFFC0C0&
    Left = 120
    Top = 480
    Width = 1095
    Height = 255
    TabIndex = 2
    Value = 255
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
  Begin TextBox Text1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 3015
    Height = 285
    Text = "comments on bodini"
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
  Begin TextBox Text2
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 840
    Width = 3015
    Height = 1035
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
  End
End

Attribute VB_Name = "mailspek"

