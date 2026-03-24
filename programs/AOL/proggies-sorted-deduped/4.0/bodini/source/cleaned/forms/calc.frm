ï»¿VERSION 5.00
Begin VB.Form calc
  Caption = "bodini calculator"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "calc.frx":0
  LinkTopic = "Form1"
  ClientLeft = 6735
  ClientTop = 1950
  ClientWidth = 2280
  ClientHeight = 2040
  Begin CommandButton Percent
    Caption = "%"
    Left = 1200
    Top = 480
    Width = 480
    Height = 360
    TabIndex = 17
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
  Begin CommandButton Operator
    Caption = "="
    Index = 4
    Left = 1200
    Top = 1560
    Width = 480
    Height = 360
    TabIndex = 16
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
  Begin CommandButton Decimal
    Caption = "."
    Left = 840
    Top = 1560
    Width = 360
    Height = 360
    TabIndex = 15
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
  Begin CommandButton Number
    Caption = "0"
    Index = 0
    Left = 120
    Top = 1560
    Width = 720
    Height = 360
    TabIndex = 14
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
  Begin CommandButton Operator
    Caption = "/"
    Index = 0
    Left = 1200
    Top = 840
    Width = 480
    Height = 360
    TabIndex = 13
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
  Begin CommandButton Operator
    Caption = "X"
    Index = 2
    Left = 1200
    Top = 1200
    Width = 480
    Height = 360
    TabIndex = 12
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
  Begin CommandButton Number
    Caption = "3"
    Index = 3
    Left = 840
    Top = 1200
    Width = 360
    Height = 360
    TabIndex = 11
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
  Begin CommandButton Number
    Caption = "2"
    Index = 2
    Left = 480
    Top = 1200
    Width = 360
    Height = 360
    TabIndex = 10
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
  Begin CommandButton Number
    Caption = "1"
    Index = 1
    Left = 120
    Top = 1200
    Width = 360
    Height = 360
    TabIndex = 9
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
  Begin CommandButton Operator
    Caption = "-"
    Index = 3
    Left = 1680
    Top = 840
    Width = 480
    Height = 360
    TabIndex = 8
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
  Begin CommandButton Operator
    Caption = "+"
    Index = 1
    Left = 1680
    Top = 1200
    Width = 480
    Height = 720
    TabIndex = 7
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
  Begin CommandButton Number
    Caption = "6"
    Index = 6
    Left = 840
    Top = 840
    Width = 360
    Height = 360
    TabIndex = 6
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
  Begin CommandButton Number
    Caption = "5"
    Index = 5
    Left = 480
    Top = 840
    Width = 360
    Height = 360
    TabIndex = 5
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
  Begin CommandButton Number
    Caption = "4"
    Index = 4
    Left = 120
    Top = 840
    Width = 360
    Height = 360
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
  Begin CommandButton CancelEntry
    Caption = "C CE"
    Left = 1680
    Top = 480
    Width = 480
    Height = 360
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
  Begin CommandButton Number
    Caption = "9"
    Index = 9
    Left = 840
    Top = 480
    Width = 360
    Height = 360
    TabIndex = 2
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
  Begin CommandButton Number
    Caption = "8"
    Index = 8
    Left = 480
    Top = 480
    Width = 360
    Height = 360
    TabIndex = 1
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
  Begin CommandButton Number
    Caption = "7"
    Index = 7
    Left = 120
    Top = 480
    Width = 360
    Height = 360
    TabIndex = 0
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
  Begin Label Readout
    Caption = "0."
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 2040
    Height = 255
    TabIndex = 18
    BorderStyle = 1 'Fixed Single
    Alignment = 1 'Right Justify
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

Attribute VB_Name = "calc"

