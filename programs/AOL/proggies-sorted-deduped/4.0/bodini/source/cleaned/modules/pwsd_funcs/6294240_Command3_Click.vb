ï»¿Private Sub Command3_Click() '600AE0
  loc_00600C03: var_54 = MsgBox("Do you want to delete this trojan horse?", CLng(CLng(4132)), "bodini by: spek", 10, 10)
  loc_00600C44: If (var_54 = 6) = 0 Then GoTo loc_00600DBE
  loc_00600C67: var_58 = Text1.Text
  loc_00600C9D: esi = (var_58 = vbNullString) + 1
  loc_00600CB2: If (var_58 <> vbNullString) + 1 <> 0 Then GoTo loc_00600DBE
  loc_00600CD5: var_58 = Text1.Text
  loc_00600D0B: esi = (var_58 = "File...") + 1
  loc_00600D20: If (var_58 <> "File...") + 1 <> 0 Then GoTo loc_00600DBE
  loc_00600D43: var_58 = Text1.Text
  loc_00600D88: var_68 = vbNullString & var_58 & vbNullString
  loc_00600D93: var_eax = Kill 8
  loc_00600DBE: 'Referenced from: 00600C44
  loc_00600DC6: GoTo loc_00600DF8
  loc_00600DF7: Exit Sub
  loc_00600DF8: 'Referenced from: 00600DC6
End Sub