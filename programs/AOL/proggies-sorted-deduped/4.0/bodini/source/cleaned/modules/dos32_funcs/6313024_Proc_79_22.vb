ï»¿Public Sub Proc_79_22_605440
  loc_00605481: var_ret_1 = "AOL Frame25"
  loc_00605484: var_eax = FindWindow(var_ret_1, var_2C)
  loc_0060549D: var_1C = FindWindow(var_ret_1, var_2C)
  loc_006054B0: var_ret_2 = "MDICLIENT"
  loc_006054B9: var_eax = FindWindowEx(var_1C, 0, var_ret_2, 0)
  loc_006054BE: var_30 = FindWindowEx(var_1C, 0, var_ret_2, 0)
  loc_006054C8: call Proc_79_19_604D70(var_ret_3 = #StkVar1%StkVar2, GetLastError(), var_2C = "")
  loc_006054D8: var_24 = var_ret_3
  loc_006054DB: var_ret_4 = "_AOL_Listbox"
  loc_006054E4: var_eax = FindWindowEx(var_24, 0, var_ret_4, 0)
  loc_006054E9: var_30 = FindWindowEx(var_24, 0, var_ret_4, 0)
  loc_00605509: var_eax = SendMessage(var_30, 395, 0, var_30)
  loc_00605512: var_18 = SendMessage(var_30, 395, 0, var_30)
  loc_0060551A: GoTo loc_00605526
  loc_00605525: Exit Sub
  loc_00605526: 'Referenced from: 0060551A
End Sub