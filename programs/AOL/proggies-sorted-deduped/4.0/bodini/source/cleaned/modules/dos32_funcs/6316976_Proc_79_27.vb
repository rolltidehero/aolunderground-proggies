ï»¿Public Sub Proc_79_27_6063B0
  loc_006063FE: On Error Resume Next
  loc_0060640B: var_eax = call Proc_79_19_604D70(-1, edi, esi)
  loc_00606410: var_34 = call Proc_79_19_604D70(-1, edi, esi)
  loc_0060641E: If var_34 <> 0 Then GoTo loc_00606425
  loc_00606420: GoTo loc_00606879
  loc_00606425: 'Referenced from: 0060641E
  loc_00606437: var_ret_1 = "_AOL_Listbox"
  loc_00606444: var_eax = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_0060645B: var_4C = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_00606476: var_eax = GetWindowThreadProcessId(var_4C, var_44)
  loc_0060648D: var_24 = GetWindowThreadProcessId(var_4C, var_44)
  loc_006064A2: var_eax = OpenProcess(983056, 0, var_44)
  loc_006064B9: var_48 = OpenProcess(983056, 0, var_44)
  loc_006064C7: If var_48 = 0 Then GoTo loc_00606879
  loc_006064EF: var_eax = SendMessage(var_4C, 395, 0, var_C4)
  loc_006064F4: var_C8 = SendMessage(var_4C, 395, 0, var_C4)
  loc_0060650F: var_D4 = var_C8 - 00000001h
  loc_00606526: GoTo loc_0060653A
  loc_00606528: 
  loc_0060652B: var_28 = var_28 + 1
  loc_00606537: var_28 = var_28
  loc_0060653A: 'Referenced from: 00606526
  loc_00606543: If var_28 > 0 Then GoTo loc_00606863
  loc_00606584: var_3C = String$(4, vbNullString)
  loc_006065A9: var_eax = SendMessage(var_4C, 409, var_28, 0)
  loc_006065C0: var_30 = SendMessage(var_4C, 409, var_28, 0)
  loc_006065CD: var_30 = var_30 + 00000018h
  loc_006065FD: var_eax = ReadProcessMemory(var_48, var_30, var_3C, 4, var_40)
  loc_00606610: var_ret_3 = var_50
  loc_0060663B: var_eax = CopyMemory(var_2C, var_3C, 4)
  loc_0060664E: var_ret_5 = var_50
  loc_00606667: var_2C = var_2C + 00000006h
  loc_006066AE: var_3C = String$(16, vbNullString)
  loc_006066EA: var_eax = ReadProcessMemory(var_48, var_2C, var_3C, Len(var_3C), var_40)
  loc_006066FD: var_ret_7 = var_50
  loc_00606726: InStr(1, var_3C, vbNullString, 0) = InStr(1, var_3C, vbNullString, 0) - 00000001h
  loc_0060673F: var_3C = Left$(var_3C, InStr(1, var_3C, vbNullString, 0))
  loc_00606750: var_eax = call Proc_79_47_609590(var_3C, 0, fs:[00000000h])
  loc_0060675A: var_50 = call Proc_79_47_609590(var_3C, 0, fs:[00000000h])
  loc_0060676F: var_B8 = ( = var_50)
  loc_00606783: var_98 = var_3C
  loc_006067F6: var_CC = CBool(( = var_50) And (LCase(var_3C) = LCase(Me)))
  loc_00606829: If var_CC = 0 Then GoTo loc_00606857
  loc_00606843: var_eax = call Proc_79_26_606230(var_28, , )
  loc_00606855: GoTo loc_00606879
  loc_00606857: 'Referenced from: 00606829
  loc_0060685E: GoTo loc_00606528
  loc_00606863: 'Referenced from: 00606543
  loc_0060686E: var_eax = CloseHandle(var_48)
  loc_00606879: 'Referenced from: 00606420
  loc_0060687E: GoTo loc_006068A8
  loc_006068A7: Exit Sub
  loc_006068A8: 'Referenced from: 0060687E
End Sub