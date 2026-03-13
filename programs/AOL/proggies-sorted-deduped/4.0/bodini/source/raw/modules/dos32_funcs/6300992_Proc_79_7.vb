Public Sub Proc_79_7_602540
  loc_00602596: var_ret_1 = "AOL Frame25"
  loc_00602599: var_eax = FindWindow(var_ret_1, 0)
  loc_006025AC: var_24 = FindWindow(var_ret_1, 0)
  loc_006025C2: var_ret_2 = "MDICLIENT"
  loc_006025CA: var_eax = FindWindowEx(var_24, edi, var_ret_2, 0)
  loc_006025D7: var_2C = FindWindowEx(var_24, edi, var_ret_2, 0)
  loc_006025EC: var_ret_3 = "Incoming/Saved Mail"
  loc_006025F8: var_ret_4 = "AOL Child"
  loc_00602600: var_eax = FindWindowEx(var_2C, edi, var_ret_4, var_ret_3)
  loc_00602617: var_28 = FindWindowEx(var_2C, edi, var_ret_4, var_ret_3)
  loc_00602628: If var_28 = 0 Then GoTo loc_00602986
  loc_00602638: var_ret_5 = "_AOL_Tree"
  loc_00602640: var_eax = FindWindowEx(var_28, edi, var_ret_5, 0)
  loc_00602645: var_74 = FindWindowEx(var_28, edi, var_ret_5, 0)
  loc_00602650: var_34 = var_74
  loc_00602667: var_eax = SendMessage(var_74, 395, edi, var_74)
  loc_006026A2: var_20 = String(255, "")
  loc_006026B7: SendMessage(var_74, 395, edi, var_74) = SendMessage(var_74, 395, edi, var_74) - 00000001h
  loc_006026C0: var_88 = SendMessage(var_74, 395, edi, var_74)
  loc_006026CE: If ebx > 0 Then GoTo loc_00602986
  loc_006026EB: var_eax = SendMessage(var_34, 394, ebx, var_74)
  loc_006026FB: SendMessage(var_34, 394, ebx, var_74) = SendMessage(var_34, 394, ebx, var_74) + 00000001h
  loc_00602718: var_60 = String(SendMessage(var_34, 394, ebx, var_74), 0)
  loc_0060272D: var_20 = var_60
  loc_0060275B: var_eax = SendMessage(var_34, 393, ebx, var_20)
  loc_0060276E: var_ret_7 = var_38
  loc_00602786: var_68 = var_20
  loc_00602790: var_50 = Chr(9)
  loc_006027A6: call InStr(var_60, 00000000h, var_50, var_70, 00000001h)
  loc_006027AD: var_ret_8 = CLng(InStr(var_60, 00000000h, var_50, var_70, 00000001h))
  loc_006027CB: var_68 = var_20
  loc_006027DB: var_50 = Chr(9)
  loc_006027E1: var_ret_8 = var_ret_8 + 00000001h
  loc_006027F9: call InStr(var_60, 00000000h, var_50, var_70, var_ret_8)
  loc_00602829: var_68 = var_20
  loc_00602832: Len(var_20) = Len(var_20) - CLng(InStr(var_60, 00000000h, var_50, var_70, var_ret_8))
  loc_00602879: var_3C = vbNullString
  loc_0060288E: var_38 = Chr(0)
  loc_0060289C: var_eax = call Proc_79_41_6084C0(Right(var_20, Len(var_20)), var_38, var_3C)
  loc_006028A6: var_20 = call Proc_79_41_6084C0(var_20, var_38, var_3C)
  loc_006028E9: ebx = ebx + 00000001h
  loc_0060291A: var_3C = CStr(ebx+00000001h) & "]•      "
  loc_0060292C: var_40 = var_3C & var_20
  loc_0060292E: var_90 = var_3C & var_20
  loc_0060293F: var_eax = Unknown_VTable_Call[eax+000001ECh]
  loc_00602979: 00000001h = 00000001h + ebx+00000001h
  loc_00602981: GoTo loc_006026C8
  loc_00602986: 'Referenced from: 00602628
  loc_0060298B: GoTo loc_006029B5
  loc_006029B4: Exit Sub
  loc_006029B5: 'Referenced from: 0060298B
  loc_006029BE: Exit Sub
End Sub