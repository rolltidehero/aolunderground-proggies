ï»¿Public Sub Proc_79_44_608AA0
  loc_00608AE0: var_eax = GetWindowTextLength(Me)
  loc_00608B15: var_20 = String(GetWindowTextLength(Me), "")
  loc_00608B31: GetWindowTextLength(Me) = GetWindowTextLength(Me) + 00000001h
  loc_00608B4A: var_eax = GetWindowText(Me, var_20, GetWindowTextLength(Me))
  loc_00608B5D: var_ret_2 = var_24
  loc_00608B72: var_18 = var_20
  loc_00608B7D: GoTo loc_00608BAB
  loc_00608B83: If var_4 = 0 Then GoTo loc_00608B8E
  loc_00608B8E: 'Referenced from: 00608B83
  loc_00608BAA: Exit Sub
  loc_00608BAB: 'Referenced from: 00608B7D
  loc_00608BB4: Exit Sub
End Sub