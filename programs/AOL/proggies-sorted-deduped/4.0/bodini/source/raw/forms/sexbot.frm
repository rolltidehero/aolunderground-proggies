VERSION 5.00
Begin VB.Form sexbot
  Caption = "bodini sex bot"
  BackColor = &H800000&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "sexbot.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2145
  ClientHeight = 465
  StartUpPosition = 3 'Windows Default
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 5
    Left = 120
    Top = 1680
  End
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
End

Attribute VB_Name = "sexbot"

