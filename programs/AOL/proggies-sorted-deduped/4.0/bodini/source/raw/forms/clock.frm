VERSION 5.00
Begin VB.Form clock
  Caption = "bodini clock"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "clock.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 3180
  ClientHeight = 795
  StartUpPosition = 3 'Windows Default
  Begin Timer Timer2
    Interval = 1
    Left = 600
    Top = 1920
  End
  Begin Timer Timer1
    Interval = 1
    Left = 240
    Top = 1920
  End
  Begin Image Image1
    Picture = "clock.frx":30A
    Left = 240
    Top = 120
    Width = 480
    Height = 480
  End
  Begin Label Label4
    ForeColor = &HFFFFFF&
    Left = 1680
    Top = 480
    Width = 1335
    Height = 255
    TabIndex = 3
    BackStyle = 0 'Transparent
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
  Begin Label Label3
    ForeColor = &HFFFFFF&
    Left = 1680
    Top = 120
    Width = 1335
    Height = 255
    TabIndex = 2
    BackStyle = 0 'Transparent
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
  Begin Label Label2
    Caption = "Date:"
    ForeColor = &HFFFFFF&
    Left = 960
    Top = 480
    Width = 735
    Height = 255
    TabIndex = 1
    BackStyle = 0 'Transparent
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
  Begin Label Label1
    Caption = "Time:"
    ForeColor = &HFFFFFF&
    Left = 960
    Top = 120
    Width = 735
    Height = 255
    TabIndex = 0
    BackStyle = 0 'Transparent
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

Attribute VB_Name = "clock"

