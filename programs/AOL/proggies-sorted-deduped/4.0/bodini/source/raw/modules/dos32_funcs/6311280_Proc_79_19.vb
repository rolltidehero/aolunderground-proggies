Public Sub Proc_79_19_604D70
  loc_00604DB1: var_ret_1 = "AOL Frame25"
  loc_00604DB4: var_eax = FindWindow(var_ret_1, 0)
  loc_00604DDA: var_ret_2 = "MDIClient"
  loc_00604DE3: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_00604DE8: var_38 = FindWindowEx(var_38, 0, var_ret_2, 0)
  loc_00604DF3: var_28 = var_38
  loc_00604E03: var_ret_3 = "AOL Child"
  loc_00604E0C: var_eax = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_00604E11: var_38 = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_00604E1C: var_2C = var_38
  loc_00604E2C: var_ret_4 = "RICHCNTL"
  loc_00604E35: var_eax = FindWindowEx(var_38, 0, var_ret_4, 0)
  loc_00604E45: var_1C = FindWindowEx(var_38, 0, var_ret_4, 0)
  loc_00604E55: var_ret_5 = "_AOL_Listbox"
  loc_00604E5E: var_eax = FindWindowEx(var_2C, 0, var_ret_5, 0)
  loc_00604E6E: var_24 = FindWindowEx(var_2C, 0, var_ret_5, 0)
  loc_00604E7E: var_ret_6 = "_AOL_Icon"
  loc_00604E87: var_eax = FindWindowEx(var_2C, 0, var_ret_6, 0)
  loc_00604E97: var_30 = FindWindowEx(var_2C, 0, var_ret_6, 0)
  loc_00604EA7: var_ret_7 = "_AOL_Static"
  loc_00604EB0: var_eax = FindWindowEx(var_2C, 0, var_ret_7, 0)
  loc_00604EB5: var_38 = FindWindowEx(var_2C, 0, var_ret_7, 0)
  loc_00604EC4: If var_1C = 0 Then GoTo loc_00604EEB
  loc_00604ECB: If var_24 = 0 Then GoTo loc_00604EEB
  loc_00604ED2: If var_30 = 0 Then GoTo loc_00604EEB
  loc_00604ED9: If var_38 = 0 Then GoTo loc_00604EEB
  loc_00604EE3: var_18 = var_2C
  loc_00604EE6: GoTo loc_00605001
  loc_00604EEB: 'Referenced from: 00604EC4
  loc_00604EF6: var_ret_8 = "AOL Child"
  loc_00604F01: var_eax = FindWindowEx(var_28, var_2C, var_ret_8, 0)
  loc_00604F06: var_38 = FindWindowEx(var_28, var_2C, var_ret_8, 0)
  loc_00604F0E: var_2C = var_38
  loc_00604F21: var_ret_9 = "RICHCNTL"
  loc_00604F2A: var_eax = FindWindowEx(var_38, 0, var_ret_9, 0)
  loc_00604F37: var_1C = FindWindowEx(var_38, 0, var_ret_9, 0)
  loc_00604F4A: var_ret_A = "_AOL_Listbox"
  loc_00604F53: var_eax = FindWindowEx(var_2C, 0, var_ret_A, 0)
  loc_00604F60: var_24 = FindWindowEx(var_2C, 0, var_ret_A, 0)
  loc_00604F73: var_ret_B = "_AOL_Icon"
  loc_00604F7C: var_eax = FindWindowEx(var_2C, 0, var_ret_B, 0)
  loc_00604F89: var_30 = FindWindowEx(var_2C, 0, var_ret_B, 0)
  loc_00604F9C: var_ret_C = "_AOL_Static"
  loc_00604FA5: var_eax = FindWindowEx(var_2C, 0, var_ret_C, 0)
  loc_00604FAA: var_38 = FindWindowEx(var_2C, 0, var_ret_C, 0)
  loc_00604FB9: If var_1C = 0 Then GoTo loc_00604FD0
  loc_00604FC0: If var_24 = 0 Then GoTo loc_00604FD0
  loc_00604FC7: If var_30 = 0 Then GoTo loc_00604FD0
  loc_00604FCE: If var_38 <> 0 Then GoTo loc_00604FDC
  loc_00604FD0: 'Referenced from: 00604FB9
  loc_00604FD5: If var_2C = 0 Then GoTo loc_00604FE9
  loc_00604FD7: GoTo loc_00604EEB
  loc_00604FDC: 
  loc_00604FE4: var_18 = var_2C
  loc_00604FE7: GoTo loc_00605001
  loc_00604FE9: 'Referenced from: 00604FD5
  loc_00604FF5: GoTo loc_00605001
  loc_00605000: Exit Sub
  loc_00605001: 'Referenced from: 00604EE6
End Sub