Public Sub Proc_79_39_607F30
  loc_00607F76: If Len(Me) >= 1 Then GoTo loc_00607F85
  loc_00607F80: GoTo loc_0060805E
  loc_00607F85: 'Referenced from: 00607F76
  loc_00607F9D: var_2C = Chr(13)
  loc_00607FAE: call InStr(var_3C, esi, var_2C, var_4C, 00000001h, var_0060805F, Me, esi, %x1 = Chr(%StkVar2))
  loc_00607FB5: var_ret_1 = CLng(InStr(var_3C, esi, var_2C, var_4C, 00000001h, var_0060805F, Me, esi, %x1 = Chr(%StkVar2)))
  loc_00607FD2: If var_ret_1 = 0 Then GoTo loc_00608038
  loc_00607FDB: 
  loc_00607FED: var_2C = Chr(13)
  loc_00607FEF: var_ret_1 = var_ret_1 + 00000001h
  loc_00608003: call InStr(var_3C, 00000000h, var_2C, var_4C, var_ret_1)
  loc_0060800A: var_ret_2 = CLng(InStr(var_3C, 00000000h, var_2C, var_4C, var_ret_1))
  loc_00608027: If var_ret_2 = 0 Then GoTo loc_00608038
  loc_0060802C: var_1C = var_1C + 00000001h
  loc_00608033: var_1C = var_1C
  loc_00608036: If var_ret_2 <> 0 Then GoTo loc_00607FDB
  loc_00608038: 'Referenced from: 00607FD2
  loc_00608040: var_1C = var_1C + 00000001h
  loc_00608045: var_1C = var_1C
  loc_00608048: GoTo loc_0060805E
  loc_0060805D: Exit Sub
  loc_0060805E: 'Referenced from: 00607F80
  loc_0060805E: Exit Sub
End Sub