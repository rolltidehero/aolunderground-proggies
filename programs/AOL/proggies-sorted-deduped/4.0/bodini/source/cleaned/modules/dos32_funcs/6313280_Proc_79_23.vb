ï»¿Public Sub Proc_79_23_605540
  loc_0060558E: On Error Resume Next
  loc_0060559B: var_eax = call Proc_79_19_604D70(-1, edi, esi)
  loc_006055A0: var_34 = call Proc_79_19_604D70(-1, edi, esi)
  loc_006055AE: If var_34 <> 0 Then GoTo loc_006055B5
  loc_006055B0: GoTo loc_00605997
  loc_006055B5: 'Referenced from: 006055AE
  loc_006055C7: var_ret_1 = "_AOL_Listbox"
  loc_006055D4: var_eax = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_006055E5: var_48 = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_00605600: var_eax = GetWindowThreadProcessId(var_48, var_40)
  loc_00605611: var_24 = GetWindowThreadProcessId(var_48, var_40)
  loc_00605626: var_eax = OpenProcess(983056, 0, var_40)
  loc_00605637: var_44 = OpenProcess(983056, 0, var_40)
  loc_00605645: If var_44 = 0 Then GoTo loc_00605997
  loc_00605667: var_eax = SendMessage(var_48, 395, 0, var_70)
  loc_0060566C: var_74 = SendMessage(var_48, 395, 0, var_70)
  loc_00605681: var_84 = var_74 - 00000001h
  loc_00605695: GoTo loc_006056A6
  loc_00605697: 
  loc_0060569A: var_28 = var_28 + 1
  loc_006056A3: var_28 = var_28
  loc_006056A6: 'Referenced from: 00605695
  loc_006056AF: If var_28 > 0 Then GoTo loc_00605981
  loc_006056E7: var_38 = String$(4, vbNullString)
  loc_0060570C: var_eax = SendMessage(var_48, 409, var_28, 0)
  loc_0060571D: var_30 = SendMessage(var_48, 409, var_28, 0)
  loc_0060572A: var_30 = var_30 + 00000018h
  loc_0060575A: var_eax = ReadProcessMemory(var_44, var_30, var_38, 4, var_3C)
  loc_0060576D: var_ret_3 = var_4C
  loc_00605798: var_eax = CopyMemory(var_2C, var_38, 4)
  loc_006057AB: var_ret_5 = var_4C
  loc_006057C4: var_2C = var_2C + 00000006h
  loc_00605802: var_38 = String$(16, vbNullString)
  loc_0060583E: var_eax = ReadProcessMemory(var_44, var_2C, var_38, Len(var_38), var_3C)
  loc_00605851: var_ret_7 = var_4C
  loc_0060587A: InStr(1, var_38, vbNullString, 0) = InStr(1, var_38, vbNullString, 0) - 00000001h
  loc_00605893: var_38 = Left$(var_38, InStr(1, var_38, vbNullString, 0))
  loc_006058A4: var_eax = call Proc_79_47_609590(var_38, 0, fs:[00000000h])
  loc_006058AE: var_4C = call Proc_79_47_609590(var_38, 0, fs:[00000000h])
  loc_006058CC: setz dl
  loc_006058E7: If var_78 = 0 Then GoTo loc_00605975
  loc_0060593A: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_00605942: var_7C = Unknown_VTable_Call[edx+000001ECh]
  loc_0060597C: GoTo loc_00605697
  loc_00605981: 'Referenced from: 006056AF
  loc_0060598C: var_eax = CloseHandle(var_44)
  loc_00605997: 'Referenced from: 006055B0
  loc_0060599C: GoTo loc_006059B1
  loc_006059B0: Exit Sub
  loc_006059B1: 'Referenced from: 0060599C
End Sub