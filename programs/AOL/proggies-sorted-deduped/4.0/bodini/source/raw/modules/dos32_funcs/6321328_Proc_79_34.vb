Public Sub Proc_79_34_6074B0
  loc_006074F0: var_eax = call Proc_79_18_604B70(edi, esi, ebx)
  loc_00607501: var_ret_1 = "RICHCNTL"
  loc_0060750A: var_eax = FindWindowEx(call Proc_79_18_604B70(edi, esi, ebx), edi, var_ret_1, 0)
  loc_0060751A: var_1C = FindWindowEx(call Proc_79_18_604B70(edi, esi, ebx), edi, var_ret_1, 0)
  loc_00607527: var_eax = call Proc_79_45_608BE0(var_1C, , )
  loc_00607531: var_18 = call Proc_79_45_608BE0(var_1C, , )
  loc_00607546: var_54 = var_18
  loc_00607550: var_3C = Chr(9)
  loc_00607561: call InStr(var_4C, edi, var_3C, var_5C, 00000001h)
  loc_00607568: var_ret_2 = CLng(InStr(var_4C, edi, var_3C, var_5C, 00000001h))
  loc_00607583: 
  loc_0060758F: var_54 = var_18
  loc_00607599: var_3C = Chr(9)
  loc_0060759B: var_ret_2 = var_ret_2 + 00000001h
  loc_006075B2: call InStr(var_4C, edi, var_3C, var_5C, var_ret_2)
  loc_006075B9: var_ret_3 = CLng(InStr(var_4C, edi, var_3C, var_5C, var_ret_2))
  loc_006075D6: If var_ret_3 > 0 Then GoTo loc_00607583
  loc_006075E5: var_54 = var_18
  loc_006075F7: Len(var_18) = Len(var_18) - var_ret_2
  loc_006075FF: Len(var_18) = Len(var_18) - 00000001h
  loc_00607625: var_18 = Right(var_18, Len(var_18))
  loc_0060763D: var_54 = var_18
  loc_00607649: Len(var_18) = Len(var_18) - 00000001h
  loc_00607668: var_20 = Left(var_18, Len(var_18))
  loc_00607678: GoTo loc_006076A6
  loc_0060767E: If var_4 = 0 Then GoTo loc_00607689
  loc_00607689: 'Referenced from: 0060767E
  loc_006076A5: Exit Sub
  loc_006076A6: 'Referenced from: 00607678
  loc_006076AF: Exit Sub
  loc_006076C3: Exit Sub
End Sub