Private Sub Command2_Click() '5B2300
  Dim var_24 As Variant
  Dim var_28 As TextBox
  loc_005B2389: var_24 = Global.Clipboard
  loc_005B23A9: var_eax = Global.Clear
  loc_005B23EF: var_18 = Text2.Text
  loc_005B2425: esi = (var_18 = vbNullString) + 1
  loc_005B2436: If (var_18 = vbNullString) + 1 = 0 Then GoTo loc_005B25BD
  loc_005B246C: var_38 = "You need a code in the textbox to copy"
  loc_005B24CB: var_28 = Global.Clipboard
  loc_005B2511: var_18 = Text2.Text
  loc_005B2576: var_20 = vbNullString & var_18 & vbNullString
  loc_005B257E: var_20 = Text2.ForeColor
  loc_005B25BD: 'Referenced from: 005B2436
  loc_005B25C9: GoTo loc_005B260B
  loc_005B260A: Exit Sub
  loc_005B260B: 'Referenced from: 005B25C9
End Sub