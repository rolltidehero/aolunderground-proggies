ï»¿Public Sub Proc_79_13_603360
  loc_006033A6: var_eax = call Proc_79_8_6029E0(edi, esi, ebx)
  loc_006033AF: If call Proc_79_8_6029E0(edi, esi, ebx) = 0 Then GoTo loc_00603709
  loc_006033C5: var_ret_1 = "_AOL_TabControl"
  loc_006033CA: var_eax = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), edi, var_ret_1, 0)
  loc_006033E3: var_18 = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), edi, var_ret_1, 0)
  loc_006033F6: var_ret_2 = "_AOL_TabPage"
  loc_006033FF: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0060340C: var_34 = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0060341F: var_ret_3 = "_AOL_TabPage"
  loc_0060342A: var_eax = FindWindowEx(var_18, var_34, var_ret_3, 0)
  loc_0060343A: var_34 = FindWindowEx(var_18, var_34, var_ret_3, 0)
  loc_0060344A: var_ret_4 = "_AOL_Tree"
  loc_00603453: var_eax = FindWindowEx(var_34, 0, var_ret_4, 0)
  loc_00603463: var_20 = FindWindowEx(var_34, 0, var_ret_4, 0)
  loc_0060347B: var_eax = SendMessage(var_74, 395, 0, var_74)
  loc_00603486: If SendMessage(var_74, 395, 0, var_74) = 0 Then GoTo loc_00603709
  loc_00603492: SendMessage(var_74, 395, 0, var_74) = SendMessage(var_74, 395, 0, var_74) - 00000001h
  loc_0060349B: var_88 = SendMessage(var_74, 395, 0, var_74)
  loc_006034AC: If ebx > 0 Then GoTo loc_00603709
  loc_006034CD: var_eax = SendMessage(var_20, 394, ebx, var_74)
  loc_006034DD: SendMessage(var_20, 394, ebx, var_74) = SendMessage(var_20, 394, ebx, var_74) + 00000001h
  loc_006034FA: var_60 = String(SendMessage(var_20, 394, ebx, var_74), 0)
  loc_0060350F: var_24 = var_60
  loc_0060353D: var_eax = SendMessage(var_20, 393, ebx, var_24)
  loc_00603550: var_ret_6 = var_38
  loc_00603568: var_68 = var_24
  loc_00603572: var_50 = Chr(9)
  loc_00603588: call InStr(var_60, 00000000h, var_50, var_70, 00000001h)
  loc_0060358F: var_ret_7 = CLng(InStr(var_60, 00000000h, var_50, var_70, 00000001h))
  loc_006035AD: var_68 = var_24
  loc_006035BD: var_50 = Chr(9)
  loc_006035C3: var_ret_7 = var_ret_7 + 00000001h
  loc_006035DB: call InStr(var_60, 00000000h, var_50, var_70, var_ret_7)
  loc_0060360B: var_68 = var_24
  loc_00603614: Len(var_24) = Len(var_24) - CLng(InStr(var_60, 00000000h, var_50, var_70, var_ret_7))
  loc_0060365E: ebx = ebx + 00000001h
  loc_00603668: var_90 = ecx
  loc_006036B4: var_40 = CStr(ebx+00000001h) & "]â¢      " & Right(var_24, Len(var_24))
  loc_006036BE: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_006036FB: 00000001h = 00000001h + var_30
  loc_00603704: GoTo loc_006034A6
  loc_00603709: 'Referenced from: 006033AF
  loc_0060370E: GoTo loc_00603738
  loc_00603737: Exit Sub
  loc_00603738: 'Referenced from: 0060370E
  loc_00603741: Exit Sub
End Sub