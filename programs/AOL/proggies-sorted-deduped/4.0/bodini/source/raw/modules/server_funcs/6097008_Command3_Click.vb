Private Sub Command3_Click() '5D0870
  Dim var_44 As Timer
  loc_005D08F3: var_80 = Timer2.Interval
  loc_005D0916: setz bl
  loc_005D0924: If ebx <> 0 Then GoTo loc_005D0F0E
  loc_005D093D: FindWindow("AOL Frame25", var_ret_2 = #StkVar1%StkVar2)
  loc_005D0950: var_18 = var_ret_2
  loc_005D0967: var_ret_3 = "MDICLIENT"
  loc_005D0970: var_eax = FindWindowEx(var_18, 0, var_ret_3, 0)
  loc_005D097D: var_1C = FindWindowEx(var_18, 0, var_ret_3, 0)
  loc_005D0992: var_ret_4 = "Incoming/Saved Mail"
  loc_005D099E: var_ret_5 = "AOL Child"
  loc_005D09A7: var_eax = FindWindowEx(var_1C, 0, var_ret_5, var_ret_4)
  loc_005D09BE: var_20 = FindWindowEx(var_1C, 0, var_ret_5, var_ret_4)
  loc_005D09CF: If var_20 <> 0 Then GoTo loc_005D09E6
  loc_005D09D1: call Proc_79_2_6016B0(Me, var_ret_6 = #StkVar1%StkVar2, GetLastError())
  loc_005D09E1: var_eax = call Proc_6098C0(1, , )
  loc_005D09E6: 'Referenced from: 005D09CF
  loc_005D09F1: var_ret_7 = "AOL Frame25"
  loc_005D09F4: var_eax = FindWindow(var_ret_7, 0)
  loc_005D0A01: var_18 = FindWindow(var_ret_7, 0)
  loc_005D0A18: var_ret_8 = "MDICLIENT"
  loc_005D0A21: var_eax = FindWindowEx(var_18, 0, var_ret_8, 0)
  loc_005D0A2E: var_1C = FindWindowEx(var_18, 0, var_ret_8, 0)
  loc_005D0A43: var_ret_9 = "Incoming/Saved Mail"
  loc_005D0A4F: var_ret_A = "AOL Child"
  loc_005D0A58: var_eax = FindWindowEx(var_1C, 0, var_ret_A, var_ret_9)
  loc_005D0A7B: var_eax = ShowWindow(FindWindowEx(var_1C, 0, var_ret_A, var_ret_9), 6)
  loc_005D0A9D: var_eax = List3.Clear
  loc_005D0ADA: var_eax = call Proc_79_7_602540(var_44, var_44, List3.Clear)
  loc_005D0AF4: var_8C = call Proc_79_7_602540(var_44, var_44, List3.Clear)
  loc_005D0B13: var_7C = List3.ListCount
  loc_005D0B48: var_38 = CStr(var_7C)
  loc_005D0B62: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005D0BAF: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005D0BDF: ebx = (var_38 = var_0042E980) + 1
  loc_005D0BF9: If (var_38 = var_0042E980) + 1 = 0 Then GoTo loc_005D0C54
  loc_005D0C2E: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005D0C80: var_8C = var_48
  loc_005D0C9C: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005D0CD0: var_3C = var_38 & " mails refreshed..."
  loc_005D0CE0: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005D0D26: var_eax = call Proc_6098C0(var_80, Me, var_48)
  loc_005D0D44: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005D0D8E: var_40 = "•bodini 4.0• server preping •" & var_38 & " mail(s)•"
  loc_005D0DB6: var_eax = call Proc_3_4_5A51B0(var_68, var_30, 3)
  loc_005D0E0F: var_38 = "<font face=""tahoma"">" & var_68
  loc_005D0E24: var_eax = call Proc_79_17_604A50(var_38 & vbNullString, var_38, var_44)
  loc_005D0E74: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005D0EA2: var_eax = call Proc_6098C0(3, var_0060C654, "setting up mail lists...")
  loc_005D0EDF: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005D0F07: var_eax = call Proc_6098C0(1, var_44, "mail refreshed")
  loc_005D0F0E: 'Referenced from: 005D0924
  loc_005D0F16: GoTo loc_005D0F50
  loc_005D0F4F: Exit Sub
  loc_005D0F50: 'Referenced from: 005D0F16
End Sub