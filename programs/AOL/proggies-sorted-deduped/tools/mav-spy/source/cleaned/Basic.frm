VERSION 5.00
Begin VB.Form Basic
  Caption = "API Basics"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4950
  ClientHeight = 3255
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    Left = 120
    Top = 120
    Width = 4695
    Height = 3015
    Text = "Basic.frx":0
    TabIndex = 0
    MultiLine = -1  'True
    ScrollBars = 2
    Locked = -1  'True
  End
End

Attribute VB_Name = "Basic"


Private Sub Form_Resize()
  var_1C = Basic.WindowState
  If var_1C <> 0 Then GoTo loc_00421A98
  var_20 = Basic.Height
  var_24 = Basic.Width
  GoTo loc_0042195F
  If var_40 <> 0 Then GoTo loc_00421A98
  var_20 = Basic.Width
  Basic.Top = var_20
  var_20 = Basic.Height
  Basic.Width = var_20
  Exit Sub
  Exit Sub
End Sub
