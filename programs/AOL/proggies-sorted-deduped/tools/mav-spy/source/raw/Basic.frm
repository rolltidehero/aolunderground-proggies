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


Private Sub Form_Resize() '421800
  loc_0042187D: var_1C = Basic.WindowState
  loc_004218AA: If var_1C <> 0 Then GoTo loc_00421A98
  loc_004218D2: var_20 = Basic.Height
  loc_004218EF: fcomp real4 ptr [004014D0h]
  loc_0042192C: var_24 = Basic.Width
  loc_00421949: fcomp real4 ptr [004014D0h]
  loc_0042195B: GoTo loc_0042195F
  loc_0042195F: 'Referenced from: 0042195B
  loc_00421962: If var_40 <> 0 Then GoTo loc_00421A98
  loc_004219A9: var_20 = Basic.Width
  loc_004219E1: Basic.Top = var_20
  loc_00421A3D: var_20 = Basic.Height
  loc_00421A71: Basic.Width = var_20
  loc_00421A98: 'Referenced from: 004218AA
  loc_00421AA5: GoTo loc_00421AB1
  loc_00421AB0: Exit Sub
  loc_00421AB1: 'Referenced from: 00421AA5
  loc_00421AB1: Exit Sub
End Sub
