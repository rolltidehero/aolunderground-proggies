VERSION 5.00
Begin VB.Form Enlarge
  Caption = "Enlarged Code"
  ScaleMode = 1
  AutoRedraw = False
  FontTransparent = True
  'Icon = n/a
  LinkTopic = "Form2"
  ClientLeft = 60
  ClientTop = 345
  ClientWidth = 4935
  ClientHeight = 3405
  StartUpPosition = 3 'Windows Default
  Begin TextBox Text1
    Left = 120
    Top = 120
    Width = 4695
    Height = 3135
    Text = "Text1"
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

Attribute VB_Name = "Enlarge"


Private Sub Form_Load() '421AE0
  loc_00421B2B: call __vbaCastObj(Me, var_00407424, edi, Me, ebx)
  loc_00421B40: var_eax = call Proc_4151D0(var_18, var_18, __vbaCastObj(Me, var_00407424, edi, Me, ebx))
  loc_00421B56: GoTo loc_00421B62
  loc_00421B61: Exit Sub
  loc_00421B62: 'Referenced from: 00421B56
End Sub

Private Sub Form_Resize() '421B90
  loc_00421C0D: var_1C = Enlarge.WindowState
  loc_00421C3A: If var_1C <> 0 Then GoTo loc_00421E28
  loc_00421C62: var_20 = Enlarge.Height
  loc_00421C7F: fcomp real4 ptr [004014D0h]
  loc_00421CBC: var_24 = Enlarge.Width
  loc_00421CD9: fcomp real4 ptr [004014D0h]
  loc_00421CEB: GoTo loc_00421CEF
  loc_00421CEF: 'Referenced from: 00421CEB
  loc_00421CF2: If var_40 <> 0 Then GoTo loc_00421E28
  loc_00421D39: var_20 = Enlarge.Width
  loc_00421D71: Enlarge.Top = var_20
  loc_00421DCD: var_20 = Enlarge.Height
  loc_00421E01: Enlarge.Width = var_20
  loc_00421E28: 'Referenced from: 00421C3A
  loc_00421E35: GoTo loc_00421E41
  loc_00421E40: Exit Sub
  loc_00421E41: 'Referenced from: 00421E35
  loc_00421E41: Exit Sub
End Sub
