Public Sub Proc_79_10_602CE0
  loc_00602D14: var_eax = call Proc_79_8_6029E0(edi, esi, ebx)
  loc_00602D1D: If call Proc_79_8_6029E0(edi, esi, ebx) = 0 Then GoTo loc_00602E1D
  loc_00602D33: var_ret_1 = "_AOL_TabControl"
  loc_00602D38: var_eax = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00602D51: var_18 = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00602D64: var_ret_2 = "_AOL_TabPage"
  loc_00602D6D: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00602D7A: var_28 = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00602D8D: var_ret_3 = "_AOL_TabPage"
  loc_00602D98: var_eax = FindWindowEx(var_18, var_28, var_ret_3, 0)
  loc_00602DA8: var_28 = FindWindowEx(var_18, var_28, var_ret_3, 0)
  loc_00602DB8: var_ret_4 = "_AOL_TabPage"
  loc_00602DC3: var_eax = FindWindowEx(var_18, var_28, var_ret_4, 0)
  loc_00602DD3: var_28 = FindWindowEx(var_18, var_28, var_ret_4, 0)
  loc_00602DE3: var_ret_5 = "_AOL_Tree"
  loc_00602DEC: var_eax = FindWindowEx(var_28, 0, var_ret_5, 0)
  loc_00602DF1: var_30 = FindWindowEx(var_28, 0, var_ret_5, 0)
  loc_00602E11: var_eax = SendMessage(var_30, 395, 0, var_30)
  loc_00602E1A: var_20 = SendMessage(var_30, 395, 0, var_30)
  loc_00602E1D: 'Referenced from: 00602D1D
  loc_00602E22: GoTo loc_00602E2E
  loc_00602E2D: Exit Sub
  loc_00602E2E: 'Referenced from: 00602E22
End Sub