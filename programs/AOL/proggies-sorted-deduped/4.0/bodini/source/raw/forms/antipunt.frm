VERSION 5.00
Begin VB.Form antipunt
  Caption = "bodini anti punter"
  BackColor = &H800000&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "antipunt.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 2130
  ClientHeight = 450
  StartUpPosition = 3 'Windows Default
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
    Interval = 100
    Left = 0
    Top = 2760
  End
End

Attribute VB_Name = "antipunt"

