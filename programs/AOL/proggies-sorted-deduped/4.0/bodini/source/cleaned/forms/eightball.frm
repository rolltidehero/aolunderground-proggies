ï»¿VERSION 5.00
Begin VB.Form eightball
  Caption = "bodini 8 ball bot"
  BackColor = &H800000&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "eightball.frx":0
  LinkTopic = "Form11"
  ClientLeft = 4230
  ClientTop = 1620
  ClientWidth = 2160
  ClientHeight = 480
  PaletteMode = 1
  Begin CommandButton Command2
    Caption = "Stop"
    Left = 1080
    Top = 120
    Width = 975
    Height = 255
    TabIndex = 1
  End
  Begin CommandButton Command1
    Caption = "Start"
    Left = 120
    Top = 120
    Width = 975
    Height = 255
    TabIndex = 0
  End
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 5
    Left = 600
    Top = 1080
  End
End

Attribute VB_Name = "eightball"

