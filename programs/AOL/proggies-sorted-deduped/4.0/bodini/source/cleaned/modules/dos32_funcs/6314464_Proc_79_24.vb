ï»¿Public Sub Proc_79_24_6059E0
  Dim var_78 As Me
  loc_00605A2E: On Error Resume Next
  loc_00605A3B: var_eax = call Proc_79_19_604D70(-1, edi, esi)
  loc_00605A40: var_34 = call Proc_79_19_604D70(-1, edi, esi)
  loc_00605A4E: If var_34 <> 0 Then GoTo loc_00605A55
  loc_00605A50: GoTo loc_00605F5A
  loc_00605A55: 'Referenced from: 00605A4E
  loc_00605A67: var_ret_1 = "_AOL_Listbox"
  loc_00605A74: var_eax = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_00605A85: var_48 = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_00605AA0: var_eax = GetWindowThreadProcessId(var_48, var_40)
  loc_00605AB1: var_24 = GetWindowThreadProcessId(var_48, var_40)
  loc_00605AC6: var_eax = OpenProcess(983056, 0, var_40)
  loc_00605AD7: var_44 = OpenProcess(983056, 0, var_40)
  loc_00605AE5: If var_44 = 0 Then GoTo loc_00605E3D
  loc_00605B07: var_eax = SendMessage(var_48, 395, 0, var_70)
  loc_00605B0C: var_74 = SendMessage(var_48, 395, 0, var_70)
  loc_00605B21: var_8C = var_74 - 00000001h
  loc_00605B38: GoTo loc_00605B4C
  loc_00605B3A: 
  loc_00605B3D: var_28 = var_28 + 1
  loc_00605B49: var_28 = var_28
  loc_00605B4C: 'Referenced from: 00605B38
  loc_00605B55: If var_28 > 0 Then GoTo loc_00605E27
  loc_00605B8D: var_38 = String$(4, vbNullString)
  loc_00605BB2: var_eax = SendMessage(var_48, 409, var_28, 0)
  loc_00605BC3: var_30 = SendMessage(var_48, 409, var_28, 0)
  loc_00605BD0: var_30 = var_30 + 00000018h
  loc_00605C00: var_eax = ReadProcessMemory(var_44, var_30, var_38, 4, var_3C)
  loc_00605C13: var_ret_3 = var_4C
  loc_00605C3E: var_eax = CopyMemory(var_2C, var_38, 4)
  loc_00605C51: var_ret_5 = var_4C
  loc_00605C6A: var_2C = var_2C + 00000006h
  loc_00605CA8: var_38 = String$(16, vbNullString)
  loc_00605CE4: var_eax = ReadProcessMemory(var_44, var_2C, var_38, Len(var_38), var_3C)
  loc_00605CF7: var_ret_7 = var_4C
  loc_00605D20: InStr(1, var_38, vbNullString, 0) = InStr(1, var_38, vbNullString, 0) - 00000001h
  loc_00605D39: var_38 = Left$(var_38, InStr(1, var_38, vbNullString, 0))
  loc_00605D4A: var_eax = call Proc_79_47_609590(var_38, 0, fs:[00000000h])
  loc_00605D54: var_4C = call Proc_79_47_609590(var_38, 0, fs:[00000000h])
  loc_00605D72: setz dl
  loc_00605D8D: If var_78 = 0 Then GoTo loc_00605E1B
  loc_00605DE0: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_00605DE8: var_7C = Unknown_VTable_Call[edx+000001ECh]
  loc_00605E22: GoTo loc_00605B3A
  loc_00605E27: 'Referenced from: 00605B55
  loc_00605E32: var_eax = CloseHandle(var_44)
  loc_00605E3D: 'Referenced from: 00605AE5
  loc_00605E59: var_70 = var_78.CurrentY
  loc_00605E61: var_7C = var_70
  loc_00605E99: If var_70 <= 0 Then GoTo loc_00605F5A
  loc_00605EC5: 0 = var_78.ScaleTop
  loc_00605ECD: var_7C = var_78
  loc_00605F15: var_84 = var_4C
  loc_00605F5F: GoTo loc_00605F74
  loc_00605F73: Exit Sub
  loc_00605F74: 'Referenced from: 00605F5F
End Sub