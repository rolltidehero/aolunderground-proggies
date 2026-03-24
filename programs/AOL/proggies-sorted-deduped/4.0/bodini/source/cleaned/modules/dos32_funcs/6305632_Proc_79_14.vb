ï»¿Public Sub Proc_79_14_603760
  loc_006037A6: var_eax = call Proc_79_8_6029E0(edi, esi, ebx)
  loc_006037AF: If call Proc_79_8_6029E0(edi, esi, ebx) = 0 Then GoTo loc_00603B34
  loc_006037C5: var_ret_1 = "_AOL_TabControl"
  loc_006037CA: var_eax = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), edi, var_ret_1, 0)
  loc_006037E3: var_18 = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), edi, var_ret_1, 0)
  loc_006037F6: var_ret_2 = "_AOL_TabPage"
  loc_006037FF: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0060380C: var_34 = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0060381F: var_ret_3 = "_AOL_TabPage"
  loc_0060382A: var_eax = FindWindowEx(var_18, var_34, var_ret_3, 0)
  loc_0060383A: var_34 = FindWindowEx(var_18, var_34, var_ret_3, 0)
  loc_0060384A: var_ret_4 = "_AOL_TabPage"
  loc_00603855: var_eax = FindWindowEx(var_18, var_34, var_ret_4, 0)
  loc_00603865: var_34 = FindWindowEx(var_18, var_34, var_ret_4, 0)
  loc_00603875: var_ret_5 = "_AOL_Tree"
  loc_0060387E: var_eax = FindWindowEx(var_34, 0, var_ret_5, 0)
  loc_0060388E: var_20 = FindWindowEx(var_34, 0, var_ret_5, 0)
  loc_006038A6: var_eax = SendMessage(var_74, 395, 0, var_74)
  loc_006038B1: If SendMessage(var_74, 395, 0, var_74) = 0 Then GoTo loc_00603B34
  loc_006038BD: SendMessage(var_74, 395, 0, var_74) = SendMessage(var_74, 395, 0, var_74) - 00000001h
  loc_006038C8: var_88 = SendMessage(var_74, 395, 0, var_74)
  loc_006038D7: If ebx > 0 Then GoTo loc_00603B34
  loc_006038F8: var_eax = SendMessage(var_20, 394, ebx, var_74)
  loc_00603908: SendMessage(var_20, 394, ebx, var_74) = SendMessage(var_20, 394, ebx, var_74) + 00000001h
  loc_00603925: var_60 = String(SendMessage(var_20, 394, ebx, var_74), 0)
  loc_0060393A: var_24 = var_60
  loc_00603968: var_eax = SendMessage(var_20, 393, ebx, var_24)
  loc_0060397B: var_ret_7 = var_38
  loc_00603993: var_68 = var_24
  loc_0060399D: var_50 = Chr(9)
  loc_006039B3: call InStr(var_60, 00000000h, var_50, var_70, 00000001h)
  loc_006039BA: var_ret_8 = CLng(InStr(var_60, 00000000h, var_50, var_70, 00000001h))
  loc_006039D8: var_68 = var_24
  loc_006039E8: var_50 = Chr(9)
  loc_006039EE: var_ret_8 = var_ret_8 + 00000001h
  loc_00603A06: call InStr(var_60, 00000000h, var_50, var_70, var_ret_8)
  loc_00603A36: var_68 = var_24
  loc_00603A3F: Len(var_24) = Len(var_24) - CLng(InStr(var_60, 00000000h, var_50, var_70, var_ret_8))
  loc_00603A96: ebx = ebx + 00000001h
  loc_00603ADF: var_40 = CStr(ebx+00000001h) & "]â¢      " & Right(var_24, Len(var_24))
  loc_00603AE9: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_00603B26: 00000001h = 00000001h + var_30
  loc_00603B2F: GoTo loc_006038D1
  loc_00603B34: 'Referenced from: 006037AF
  loc_00603B39: GoTo loc_00603B63
  loc_00603B62: Exit Sub
  loc_00603B63: 'Referenced from: 00603B39
  loc_00603B6C: Exit Sub
End Sub