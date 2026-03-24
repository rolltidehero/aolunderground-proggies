Public Sub Proc_79_12_602F90
  loc_00602FD6: var_eax = call Proc_79_8_6029E0(edi, esi, ebx)
  loc_00602FDF: If call Proc_79_8_6029E0(edi, esi, ebx) = 0 Then GoTo loc_0060330E
  loc_00602FF5: var_ret_1 = "_AOL_TabControl"
  loc_00602FFA: var_eax = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00603013: var_18 = FindWindowEx(call Proc_79_8_6029E0(edi, esi, ebx), ebx, var_ret_1, 0)
  loc_00603026: var_ret_2 = "_AOL_TabPage"
  loc_0060302F: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0060303C: var_34 = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0060304F: var_ret_3 = "_AOL_Tree"
  loc_00603058: var_eax = FindWindowEx(var_34, 0, var_ret_3, 0)
  loc_00603080: var_eax = SendMessage(var_74, 395, 0, var_74)
  loc_0060308B: If SendMessage(var_74, 395, 0, var_74) = 0 Then GoTo loc_0060330E
  loc_00603091: SendMessage(var_74, 395, 0, var_74) = SendMessage(var_74, 395, 0, var_74) - 00000001h
  loc_0060309C: var_88 = SendMessage(var_74, 395, 0, var_74)
  loc_006030B1: If ebx > 0 Then GoTo loc_0060330E
  loc_006030CF: var_eax = SendMessage(var_74, 394, ebx, var_74)
  loc_006030DF: SendMessage(var_74, 394, ebx, var_74) = SendMessage(var_74, 394, ebx, var_74) + 00000001h
  loc_006030FC: var_60 = String(SendMessage(var_74, 394, ebx, var_74), 0)
  loc_00603111: var_24 = var_60
  loc_0060313F: var_eax = SendMessage(FindWindowEx(var_34, 0, var_ret_3, 0), 393, ebx, var_24)
  loc_00603152: var_ret_5 = var_38
  loc_0060316A: var_68 = var_24
  loc_00603174: var_50 = Chr(9)
  loc_0060318A: call InStr(var_60, 00000000h, var_50, var_70, 00000001h)
  loc_00603191: var_ret_6 = CLng(InStr(var_60, 00000000h, var_50, var_70, 00000001h))
  loc_006031AF: var_68 = var_24
  loc_006031BF: var_50 = Chr(9)
  loc_006031C5: var_ret_6 = var_ret_6 + 00000001h
  loc_006031DD: call InStr(var_60, 00000000h, var_50, var_70, var_ret_6)
  loc_0060320D: var_68 = var_24
  loc_00603216: Len(var_24) = Len(var_24) - CLng(InStr(var_60, 00000000h, var_50, var_70, var_ret_6))
  loc_0060326D: ebx = ebx + 00000001h
  loc_006032B6: var_40 = CStr(ebx+00000001h) & "]•      " & Right(var_24, Len(var_24))
  loc_006032C0: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_00603300: 00000001h = 00000001h + var_30
  loc_00603309: GoTo loc_006030AB
  loc_0060330E: 'Referenced from: 00602FDF
  loc_00603313: GoTo loc_0060333D
  loc_0060333C: Exit Sub
  loc_0060333D: 'Referenced from: 00603313
  loc_00603346: Exit Sub
End Sub