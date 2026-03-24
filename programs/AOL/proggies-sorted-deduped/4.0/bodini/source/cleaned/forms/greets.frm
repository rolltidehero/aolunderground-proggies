ï»¿VERSION 5.00
Begin VB.Form greets
  Caption = "bodini greets..."
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "greets.frx":0
  BorderStyle = 0 'None
  Icon = "greets.frx":36F2A
  LinkTopic = "Form1"
  MaxButton = 0   'False
  MinButton = 0   'False
  ClientLeft = 0
  ClientTop = 0
  ClientWidth = 2340
  ClientHeight = 3750
  ShowInTaskbar = 0   'False
  StartUpPosition = 3 'Windows Default
  Begin Timer Timer1
    Interval = 1
    Left = 4080
    Top = 2160
  End
  Begin Label Label3
    Caption = "x"
    ForeColor = &HFFFFFF&
    Left = 2160
    Top = 0
    Width = 90
    Height = 210
    TabIndex = 2
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
  Begin Label Label2
    Caption = "-"
    ForeColor = &HFFFFFF&
    Left = 2040
    Top = 0
    Width = 60
    Height = 210
    TabIndex = 1
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
  Begin Label Label1
    Caption = "greets.frx":37234
    ForeColor = &HFF8080&
    Left = 120
    Top = 3840
    Width = 2055
    Height = 8535
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

Attribute VB_Name = "greets"

