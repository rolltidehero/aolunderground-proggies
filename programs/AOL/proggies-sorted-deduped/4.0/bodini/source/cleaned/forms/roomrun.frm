ï»¿VERSION 5.00
Begin VB.Form roomrun
  Caption = "bodini room runner"
  BackColor = &H800000&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "roomrun.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2925
  ClientHeight = 1155
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command2
    Caption = "Stop"
    Left = 1440
    Top = 840
    Width = 1335
    Height = 255
    TabIndex = 3
  End
  Begin CommandButton Command1
    Caption = "Start"
    Left = 120
    Top = 840
    Width = 1335
    Height = 255
    TabIndex = 2
  End
  Begin TextBox Text2
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 480
    Width = 2655
    Height = 285
    Text = "20"
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
    BackColor = &H0&
    ForeColor = &HFFFFFF&
    Left = 120
    Top = 120
    Width = 2655
    Height = 285
    Text = "bodini"
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

Attribute VB_Name = "roomrun"

