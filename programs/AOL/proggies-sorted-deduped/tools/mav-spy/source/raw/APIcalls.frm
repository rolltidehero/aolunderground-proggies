VERSION 5.00
Begin VB.Form APIcalls
  Caption = "Whats needed in your module"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form1"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4710
  ClientHeight = 3195
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    Left = 120
    Top = 120
    Width = 4455
    Height = 3015
    Text = "APIcalls.frx":0
    TabIndex = 0
    MultiLine = -1  'True
    ScrollBars = 3
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

Attribute VB_Name = "APIcalls"


Private Sub Form_Load() '413150
  loc_0041319B: call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  loc_004131B0: var_eax = call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  loc_004131C6: GoTo loc_004131D2
  loc_004131D1: Exit Sub
  loc_004131D2: 'Referenced from: 004131C6
End Sub

Private Sub Form_Resize() '413200
  Dim var_18 As TextBox
  loc_00413255: var_1C = Me.WindowState
  loc_00413281: If var_1C <> 0 Then GoTo loc_004133DF
  loc_0041328E: var_20 = Me.Height
  loc_004132AB: fcomp real4 ptr [004014D0h]
  loc_004132C4: var_24 = Me.Width
  loc_004132E1: fcomp real4 ptr [004014D0h]
  loc_004132F3: GoTo loc_004132F7
  loc_004132F7: 'Referenced from: 004132F3
  loc_004132F9: If eax <> 0 Then GoTo loc_004133DD
  loc_0041331C: var_20 = Text1.Height
  loc_00413350: Text1.Width = var_18
  loc_0041338A: var_20 = Text1.Enabled
  loc_004133BA: Text1.Height = var_18
  loc_004133DD: 'Referenced from: 004132F9
  loc_004133DF: 'Referenced from: 00413281
  loc_004133E8: GoTo loc_004133F4
  loc_004133F3: Exit Sub
  loc_004133F4: 'Referenced from: 004133E8
  loc_004133F4: Exit Sub
End Sub
