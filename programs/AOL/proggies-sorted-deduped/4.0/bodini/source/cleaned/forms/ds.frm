ï»¿VERSION 5.00
Begin VB.Form ds
  Caption = "bodini decompile shield"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "ds.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4230
  ClientHeight = 2055
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Shield File"
    Left = 120
    Top = 1680
    Width = 3975
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
  Begin DriveListBox Drive1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2160
    Top = 1240
    Width = 1935
    Height = 315
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
  Begin DirListBox Dir1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 2160
    Top = 120
    Width = 1935
    Height = 990
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
  Begin FileListBox File1
    BackColor = &HFF8080&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 1935
    Height = 1455
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
  Begin Label Label1
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = -14400
    Top = 2520
    Width = 15
    Height = 210
    TabIndex = 3
    Alignment = 2 'Center
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
End

Attribute VB_Name = "ds"

