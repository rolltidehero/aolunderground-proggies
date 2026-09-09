VERSION 5.00
Begin VB.Form Form9
  Caption = "Beta Notes(Please Read)"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  Picture = "Form9.frx":0
  Icon = "Form9.frx":718E
  LinkTopic = "Form9"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4680
  ClientHeight = 3315
  StartUpPosition = 3 'Windows Default
  Begin CommandButton Command1
    Caption = "Ok"
    Left = 120
    Top = 3000
    Width = 4455
    Height = 255
    TabIndex = 2
  End
  Begin TextBox Text1
    BackColor = &H0&
    ForeColor = &HC0&
    Left = 120
    Top = 240
    Width = 4455
    Height = 2775
    Text = "Form9.frx":7498
    TabIndex = 1
    MultiLine = -1  'True
    ScrollBars = 2
    Locked = -1  'True
  End
  Begin Label Label1
    Caption = "Attention Beta Testers!!!!"
    ForeColor = &HFF&
    Left = 120
    Top = 0
    Width = 2415
    Height = 255
    TabIndex = 0
    BackStyle = 0 'Transparent
  End
End

Attribute VB_Name = "Form9"


Private Sub Command1_Click()
  Set var_18 = Me
  var_eax = Global.Unload var_18
  Exit Sub
End Sub

Public Sub Proc_10_1_4801A0
  var_14 = Text1.Text
  call MailToListFlash(var_14, "C:\file.txt", var_20)
  Exit Sub
End Sub
