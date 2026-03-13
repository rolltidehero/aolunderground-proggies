Public Sub Proc_79_37_607940
  loc_0060799E: var_eax = call Proc_79_38_607B50(edi, esi, ebx)
  loc_006079BA: var_44 = call Proc_79_38_607B50(edi, esi, ebx)
  loc_006079C0: var_eax = call Proc_79_52_60A380(var_5C, , )
  loc_006079E9: var_eax = call Proc_79_52_60A380(var_7C, , )
  loc_00607AB1: var_34 = Mid$(CStr(var_44), CLng(Len(call Proc_79_38_607B50(edi, esi, ebx)) + 4), Len(var_44) - Len(var_7C))
  loc_00607ABC: GoTo loc_00607B03
  loc_00607AC2: If var_4 = 0 Then GoTo loc_00607ACD
  loc_00607ACD: 'Referenced from: 00607AC2
  loc_00607B02: Exit Sub
  loc_00607B03: 'Referenced from: 00607ABC
End Sub