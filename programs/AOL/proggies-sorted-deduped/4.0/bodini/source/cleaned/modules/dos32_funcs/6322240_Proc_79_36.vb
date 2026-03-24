ï»¿Public Sub Proc_79_36_607840
  loc_0060787A: var_eax = call Proc_79_19_604D70(edi, esi, ebx)
  loc_0060788B: var_ret_1 = "RICHCNTL"
  loc_00607894: var_eax = FindWindowEx(call Proc_79_19_604D70(edi, esi, ebx), esi, var_ret_1, 0)
  loc_006078A4: var_18 = FindWindowEx(call Proc_79_19_604D70(edi, esi, ebx), esi, var_ret_1, 0)
  loc_006078B1: var_eax = call Proc_79_45_608BE0(var_18, , )
  loc_006078D4: var_30 = call Proc_79_45_608BE0(var_18, , )
  loc_006078DF: GoTo loc_006078FA
  loc_006078E5: If var_4 = 0 Then GoTo loc_006078F0
  loc_006078F0: 'Referenced from: 006078E5
  loc_006078F9: Exit Sub
  loc_006078FA: 'Referenced from: 006078DF
End Sub