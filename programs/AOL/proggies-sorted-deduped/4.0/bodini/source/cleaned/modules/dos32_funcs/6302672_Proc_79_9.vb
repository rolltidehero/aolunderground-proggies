ï»¿Public Sub Proc_79_9_602BD0
  loc_00602C04: var_eax = call Proc_79_8_6029E0(edi, esi, ebx)
  loc_00602C0D: If call Proc_79_8_6029E0(edi, esi, ebx) = 0 Then GoTo loc_00602CB7
  loc_00602C23: var_ret_1 = "_AOL_TabControl"
  loc_00602C28: var_eax = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00602C41: var_18 = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00602C54: var_ret_2 = "_AOL_TabPage"
  loc_00602C5D: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00602C6A: var_24 = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00602C7D: var_ret_3 = "_AOL_Tree"
  loc_00602C86: var_eax = FindWindowEx(var_24, 0, var_ret_3, 0)
  loc_00602C8B: var_30 = FindWindowEx(var_24, 0, var_ret_3, 0)
  loc_00602CAB: var_eax = SendMessage(var_30, 395, 0, var_30)
  loc_00602CB4: var_28 = SendMessage(var_30, 395, 0, var_30)
  loc_00602CB7: 'Referenced from: 00602C0D
  loc_00602CBC: GoTo loc_00602CC8
  loc_00602CC7: Exit Sub
  loc_00602CC8: 'Referenced from: 00602CBC
End Sub