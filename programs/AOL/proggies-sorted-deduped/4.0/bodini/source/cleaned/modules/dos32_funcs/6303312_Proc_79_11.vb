ï»¿Public Sub Proc_79_11_602E50
  loc_00602E84: var_eax = call Proc_79_8_6029E0(edi, esi, ebx)
  loc_00602E8D: If call Proc_79_8_6029E0(edi, esi, ebx) = 0 Then GoTo loc_00602F62
  loc_00602EA3: var_ret_1 = "_AOL_TabControl"
  loc_00602EA8: var_eax = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00602EC1: var_18 = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00602ED4: var_ret_2 = "_AOL_TabPage"
  loc_00602EDD: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00602EEA: var_28 = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00602EFD: var_ret_3 = "_AOL_TabPage"
  loc_00602F08: var_eax = FindWindowEx(var_18, var_28, var_ret_3, 0)
  loc_00602F18: var_28 = FindWindowEx(var_18, var_28, var_ret_3, 0)
  loc_00602F28: var_ret_4 = "_AOL_Tree"
  loc_00602F31: var_eax = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_00602F36: var_30 = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_00602F56: var_eax = SendMessage(var_30, 395, 0, var_30)
  loc_00602F5F: var_24 = SendMessage(var_30, 395, 0, var_30)
  loc_00602F62: 'Referenced from: 00602E8D
  loc_00602F67: GoTo loc_00602F73
  loc_00602F72: Exit Sub
  loc_00602F73: 'Referenced from: 00602F67
End Sub