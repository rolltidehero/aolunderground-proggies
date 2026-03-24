VERSION 5.00
Begin VB.Form ffmkill
  Caption = "bodini 45 minute killer"
  BackColor = &HFFC0C0&
  ForeColor = &HFFC0C0&
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Icon = "ffmkill.frx":0
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 1650
  ClientHeight = 510
  StartUpPosition = 3 'Windows Default
  Begin Timer Timer1
    Enabled = 0   'False
    Interval = 1000
    Left = 840
    Top = 1560
  End
  Begin CommandButton Command1
    Caption = "Start"
    Left = 360
    Top = 120
    Width = 975
    Height = 255
    TabIndex = 0
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
End

Attribute VB_Name = "ffmkill"

