ï»¿Public Sub Proc_79_17_604A50
  loc_00604A80: var_eax = call Proc_79_19_604D70(edi, esi, ebx)
  loc_00604A98: var_1C = call Proc_79_19_604D70(edi, esi, ebx)
  loc_00604A9B: var_ret_1 = "RICHCNTL"
  loc_00604AA1: var_eax = FindWindowEx(call Proc_79_19_604D70(edi, esi, ebx), 0, var_ret_1, 0)
  loc_00604AC7: var_ret_2 = "RICHCNTL"
  loc_00604AD2: var_eax = FindWindowEx(var_1C, FindWindowEx(call Proc_79_19_604D70(edi, esi, ebx), 0, var_ret_1, 0), var_ret_2, 0)
  loc_00604AD7: var_24 = FindWindowEx(var_1C, var_24, var_ret_2, 0)
  loc_00604AF5: var_eax = SendMessage(var_24, 12, 0, vbNullString)
  loc_00604B16: var_eax = SendMessage(var_24, 12, 0, Me)
  loc_00604B3A: var_eax = SendMessage(var_24, 258, 13, 0)
  loc_00604B46: GoTo loc_00604B52
  loc_00604B51: Exit Sub
  loc_00604B52: 'Referenced from: 00604B46
End Sub