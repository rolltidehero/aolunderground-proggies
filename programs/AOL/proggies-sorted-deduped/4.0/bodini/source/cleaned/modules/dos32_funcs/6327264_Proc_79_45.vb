ï»¿Public Sub Proc_79_45_608BE0
  loc_00608C2A: var_eax = SendMessage(Me, 14, edi, var_58)
  loc_00608C5F: var_1C = String(SendMessage(Me, 14, edi, var_58), "")
  loc_00608C86: SendMessage(Me, 14, edi, var_58) = SendMessage(Me, 14, edi, var_58) + 00000001h
  loc_00608C96: var_eax = SendMessage(Me, 13, SendMessage(Me, 14, edi, var_58), var_1C)
  loc_00608CA9: var_ret_2 = var_24
  loc_00608CBE: var_20 = var_1C
  loc_00608CC9: GoTo loc_00608CF7
  loc_00608CCF: If var_4 = 0 Then GoTo loc_00608CDA
  loc_00608CDA: 'Referenced from: 00608CCF
  loc_00608CF6: Exit Sub
  loc_00608CF7: 'Referenced from: 00608CC9
  loc_00608D00: Exit Sub
End Sub