VERSION 5.00
Begin VB.Form systray
  Caption = "bodini system tray"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  BorderStyle = 0 'None
  Icon = "systray.frx":0
  LinkTopic = "Form2"
  ClientLeft = 150
  ClientTop = 435
  ClientWidth = 345
  ClientHeight = 390
  ShowInTaskbar = 0   'False
  StartUpPosition = 3 'Windows Default
  Begin Menu mnuSystemtray
    Visible = 0   'False
    Caption = "mnuSystemtray"
    Begin Menu Exit
      Caption = "Exit"
    End
  End
End

Attribute VB_Name = "systray"

