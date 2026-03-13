ï»¿Public Sub Proc_79_33_607380
  loc_006073BA: var_eax = call Proc_79_18_604B70(edi, esi, ebx)
  loc_006073BF: var_44 = call Proc_79_18_604B70(edi, esi, ebx)
  loc_006073C6: var_eax = call Proc_79_44_608AA0(var_44, , )
  loc_006073D6: var_18 = call Proc_79_44_608AA0(var_44, , )
  loc_006073EE: If InStr(1, var_18, var_00431C88, 0) <> 0 Then GoTo loc_00607405
  loc_006073F8: var_20 = vbNullString
  loc_00607403: GoTo loc_0060747E
  loc_00607405: 'Referenced from: 006073EE
  loc_00607414: var_38 = var_18
  loc_0060742C: Len(var_18) = Len(var_18) - InStr(1, var_18, var_00431C88, 0)
  loc_00607433: Len(var_18) = Len(var_18) - 00000001h
  loc_00607453: var_20 = Right(var_18, Len(var_18))
  loc_00607463: GoTo loc_0060747E
  loc_00607469: If var_4 = 0 Then GoTo loc_00607474
  loc_00607474: 'Referenced from: 00607469
  loc_0060747D: Exit Sub
  loc_0060747E: 'Referenced from: 00607403
End Sub