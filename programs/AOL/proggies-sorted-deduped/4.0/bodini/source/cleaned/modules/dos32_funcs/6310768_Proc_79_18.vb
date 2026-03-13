ï»¿Public Sub Proc_79_18_604B70
  loc_00604BB4: var_ret_1 = "AOL Frame25"
  loc_00604BB7: var_eax = FindWindow(var_ret_1, var_28)
  loc_00604BDA: var_ret_2 = "MDIClient"
  loc_00604BE0: var_eax = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  loc_00604BEC: var_1C = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  loc_00604C00: var_ret_3 = "AOL Child"
  loc_00604C06: var_eax = FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_00604C12: var_20 = FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_00604C1F: call Proc_79_44_608AA0(var_20, var_ret_4 = #StkVar1%StkVar2, FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0))
  loc_00604C56: setnz bl
  loc_00604C5B: eax = InStr(1, var_ret_4, "Instant Message", 0) - 1
  loc_00604C7E: setnz cl
  loc_00604C83: If ecx <> 0 Then GoTo loc_00604C95
  loc_00604C85: 
  loc_00604C8D: var_24 = var_20
  loc_00604C90: GoTo loc_00604D4F
  loc_00604C95: 'Referenced from: 00604C83
  loc_00604CA0: var_ret_5 = "AOL Child"
  loc_00604CAB: var_eax = FindWindowEx(var_1C, var_20, var_ret_5, 0)
  loc_00604CBB: var_20 = FindWindowEx(var_1C, var_20, var_ret_5, 0)
  loc_00604CC8: var_eax = call Proc_79_44_608AA0(var_20, var_00604D59, GetLastError())
  loc_00604CF9: setnz bl
  loc_00604CFE: eax = InStr(1, call Proc_79_44_608AA0(var_20, var_00604D59, GetLastError()), "Instant Message", 0) - 1
  loc_00604D21: setnz cl
  loc_00604D26: If ecx = 0 Then GoTo loc_00604C85
  loc_00604D31: If var_20 <> 0 Then GoTo loc_00604C95
  loc_00604D43: GoTo loc_00604D4F
  loc_00604D4E: Exit Sub
  loc_00604D4F: 'Referenced from: 00604C90
End Sub