Private Sub mnuClearChat_Click() '5AAD90
  loc_005AADEC: var_eax = call Proc_79_19_604D70(edi, esi, ebx)
  loc_005AADFD: var_ret_1 = "RICHCNTL"
  loc_005AAE06: var_eax = FindWindowEx(call Proc_79_19_604D70(edi, esi, ebx), esi, var_ret_1, 0)
  loc_005AAE25: var_4C = FindWindowEx(call Proc_79_19_604D70(edi, esi, ebx), esi, var_ret_1, 0)
  loc_005AAE42: var_ret_2 = CLng(var_4C)
  loc_005AAE45: var_eax = SendMessage(var_ret_2, 13, esi, esi)
  loc_005AAE68: var_38 = SendMessage(var_ret_2, 13, esi, esi)
  loc_005AAE80: var_3C = Space$(CLng(var_38))
  loc_005AAE9C: var_ret_4 = var_3C
  loc_005AAEB6: var_ret_5 = CLng(var_38 + 1)
  loc_005AAEBF: var_ret_6 = CLng(var_4C)
  loc_005AAEC2: var_eax = SendMessage(var_ret_6, 12, var_ret_5, var_ret_4)
  loc_005AAED3: var_ret_7 = var_50
  loc_005AAEE9: var_28 = SendMessage(var_ret_6, 12, var_ret_5, var_ret_4)
  loc_005AAF07: var_18 = var_3C
  loc_005AAF15: GoTo loc_005AAF2A
  loc_005AAF29: Exit Sub
  loc_005AAF2A: 'Referenced from: 005AAF15
End Sub