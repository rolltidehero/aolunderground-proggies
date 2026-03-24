ï»¿Public Sub Proc_79_26_606230
  loc_00606261: var_eax = call Proc_79_22_605440(edi, esi, ebx)
  loc_00606269: call Proc_79_22_605440(edi, esi, ebx) = call Proc_79_22_605440(edi, esi, ebx) - 00000001h
  loc_00606274: If Me > 0 Then GoTo loc_00606382
  loc_0060627A: var_eax = call Proc_79_19_604D70(, , )
  loc_00606291: var_ret_1 = "_AOL_Listbox"
  loc_00606296: var_eax = FindWindowEx(call Proc_79_19_604D70(, , ), edi, var_ret_1, 0)
  loc_006062A1: var_30 = FindWindowEx(call Proc_79_19_604D70(, , ), edi, var_ret_1, 0)
  loc_006062C9: var_eax = SendMessage(var_30, 390, Me, var_30)
  loc_006062DA: var_eax = PostMessage(var_30, 515, 0, 0)
  loc_006062E9: var_eax = call Proc_79_21_605130(, , )
  loc_006062F0: var_24 = call Proc_79_21_605130(, , )
  loc_006062F3: If call Proc_79_21_605130(, , ) = 0 Then GoTo loc_006062E7
  loc_00606302: var_ret_2 = "_AOL_Checkbox"
  loc_0060630B: var_eax = FindWindowEx(var_24, 0, var_ret_2, 0)
  loc_00606310: var_30 = FindWindowEx(var_24, 0, var_ret_2, 0)
  loc_00606338: var_eax = SendMessage(var_30, 240, 0, var_30)
  loc_0060633D: var_34 = SendMessage(var_30, 240, 0, var_30)
  loc_0060634C: var_eax = PostMessage(var_30, 513, 0, 0)
  loc_0060635F: var_eax = PostMessage(var_30, 514, 0, 0)
  loc_0060636D: If var_34 = 0 Then GoTo loc_00606323
  loc_0060637B: var_eax = PostMessage(var_24, 16, 0, 0)
  loc_00606382: 'Referenced from: 00606274
  loc_00606387: GoTo loc_00606393
  loc_00606392: Exit Sub
  loc_00606393: 'Referenced from: 00606387
  loc_00606393: Exit Sub
End Sub