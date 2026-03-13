ï»¿Public Sub Proc_79_20_605020
  loc_0060506A: call __vbaVarVargNofree(esi, __vbaVarVargNofree, esi, ebx)
  loc_0060507C: var_ret_1 = CStr(__vbaVarVargNofree(esi, __vbaVarVargNofree, esi, ebx))
  loc_0060508A: call __vbaVarVargNofree(esi, var_ret_1)
  loc_0060508D: var_ret_2 = CLng(__vbaVarVargNofree(esi, var_ret_1))
  loc_00605094: var_eax = FindWindowEx(var_ret_2, , , )
  loc_006050B1: var_24 = FindWindowEx(var_ret_2, , , )
  loc_006050CF: GoTo loc_006050F4
  loc_006050D5: If var_4 = 0 Then GoTo loc_006050E0
  loc_006050E0: 'Referenced from: 006050D5
  loc_006050F3: Exit Sub
  loc_006050F4: 'Referenced from: 006050CF
End Sub