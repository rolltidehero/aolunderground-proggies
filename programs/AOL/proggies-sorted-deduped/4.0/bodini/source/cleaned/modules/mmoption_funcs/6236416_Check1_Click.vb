ï»¿Private Sub Check1_Click() '5F2900
  loc_005F296B: var_3C = Check1.Value
  loc_005F299C: setz al
  loc_005F29AC: If eax = 0 Then GoTo loc_005F2A28
  loc_005F29C9: Check2.Value = CInt(1)
  loc_005F2A0E: var_eax = mmselect.Hide
  loc_005F2A28: 'Referenced from: 005F29AC
  loc_005F2A45: var_3C = Check1.Value
  loc_005F2A69: setz al
  loc_005F2A79: If eax = 0 Then GoTo loc_005F2B3B
  loc_005F2A9A: Check2.Value = 0
  loc_005F2B1D: var_eax = mmselect.Show var_1C
  loc_005F2B3B: 'Referenced from: 005F2A79
  loc_005F2B47: GoTo loc_005F2B53
  loc_005F2B52: Exit Sub
  loc_005F2B53: 'Referenced from: 005F2B47
End Sub