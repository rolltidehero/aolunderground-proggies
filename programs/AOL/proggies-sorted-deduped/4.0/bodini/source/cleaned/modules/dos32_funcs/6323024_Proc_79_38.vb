ï»¿Public Sub Proc_79_38_607B50
  loc_00607BC1: var_eax = call Proc_79_36_607840(var_6C, edi, esi)
  loc_00607BDB: var_44 = var_6C
  loc_00607C05: var_94 = Len(var_44)
  loc_00607C4C: For var_28 = 1 To Len(var_44) Step 1
  loc_00607C5A: If var_D0 = 0 Then GoTo loc_00607DAA
  loc_00607C79: var_84 = var_44
  loc_00607CAC: var_48 = Mid(var_44, CLng(var_28), 1)
  loc_00607CD4: var_40 = var_40 & var_48
  loc_00607CDF: var_84 = var_48
  loc_00607CEF: var_6C = Chr(13)
  loc_00607D14: If (var_48 = var_6C) = 0 Then GoTo loc_00607D8B
  loc_00607D20: Len(var_40) = Len(var_40) - 00000001h
  loc_00607D2C: var_64 = Len(var_40)
  loc_00607D32: var_84 = var_40
  loc_00607D68: var_2C = Mid(var_40, 1, Len(var_40))
  loc_00607D85: var_40 = vbNullString
  loc_00607D8B: 'Referenced from: 00607D14
  loc_00607D9D: Next var_28
  loc_00607DA5: GoTo loc_00607C58
  loc_00607DAA: 'Referenced from: 00607C5A
  loc_00607DB2: var_5C = CStr(var_28)
  loc_00607DCF: var_E8 = Len(var_40)
  loc_00607E2B: var_64 = Len(var_40)
  loc_00607E40: var_84 = var_44
  loc_00607E6A: var_58 = Mid(var_44, CLng((var_E4 - var_F0)), Len(var_40))
  loc_00607E79: call __vbaStrVarCopy(var_58, var_C0, var_D0, 00000001h)
  loc_00607E84: var_18 = __vbaStrVarCopy(var_58, var_C0, var_D0, 00000001h)
  loc_00607E8C: GoTo loc_00607EBA
  loc_00607E92: If var_4 = 0 Then GoTo loc_00607E9D
  loc_00607E9D: 'Referenced from: 00607E92
  loc_00607EB9: Exit Sub
  loc_00607EBA: 'Referenced from: 00607E8C
  loc_00607F02: Exit Sub
  loc_00607F16: Exit Sub
End Sub