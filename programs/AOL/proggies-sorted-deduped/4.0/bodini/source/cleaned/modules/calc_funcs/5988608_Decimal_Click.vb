ï»¿Private Sub Decimal_Click() '5B6100
  loc_005B6179: If (%x1 = Me.hWnd = "NEG") = 0 Then GoTo loc_005B621E
  loc_005B61D9: var_18 = CStr(Format("", "-0."))
  loc_005B61E1: var_eax = Unknown_VTable_Call[ebx+00000054h]
  loc_005B6219: GoTo loc_005B62DA
  loc_005B621E: 'Referenced from: 005B6179
  loc_005B623A: If (Me = "NUMS") = 0 Then GoTo loc_005B62E8
  loc_005B629A: var_18 = CStr(Format("", "0."))
  loc_005B62A2: var_eax = Unknown_VTable_Call[ebx+00000054h]
  loc_005B62DA: 'Referenced from: 005B6219
  loc_005B62E8: 
  loc_005B6301: var_80 = "NUMS"
  loc_005B630F: GoTo loc_005B633B
  loc_005B633A: Exit Sub
  loc_005B633B: 'Referenced from: 005B630F
End Sub