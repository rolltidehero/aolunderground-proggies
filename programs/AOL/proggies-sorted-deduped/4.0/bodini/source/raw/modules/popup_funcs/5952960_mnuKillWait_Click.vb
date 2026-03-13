Private Sub mnuKillWait_Click() '5AD5C0
  loc_005AD623: var_ret_1 = "_AOL_Modal"
  loc_005AD626: var_eax = FindWindow(var_ret_1, 0)
  loc_005AD66E: call Proc_79_53_60A710(4, 10, var_ret_2 = #StkVar1%StkVar2)
  loc_005AD686: var_eax = call Proc_6098C0(CLng(0.3), esi, GetLastError())
  loc_005AD6A3: var_ret_3 = CStr(0)
  loc_005AD6AB: var_ret_4 = CLng("_AOL_Icon")
  loc_005AD6B6: var_ret_5 = CLng(FindWindow(var_ret_1, 0))
  loc_005AD6BD: var_eax = FindWindowEx(var_ret_5, var_ret_4, var_ret_3, 0)
  loc_005AD6EF: var_eax = call Proc_608D20(FindWindowEx(var_ret_5, var_ret_4, var_ret_3, 0), , )
  loc_005AD6FD: GoTo loc_005AD713
  loc_005AD712: Exit Sub
  loc_005AD713: 'Referenced from: 005AD6FD
End Sub