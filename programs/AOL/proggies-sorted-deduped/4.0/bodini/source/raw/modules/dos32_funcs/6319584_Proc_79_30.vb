Public Sub Proc_79_30_606DE0
  loc_00606E24: var_ret_1 = "AOL Frame25"
  loc_00606E27: var_eax = FindWindow(var_ret_1, var_30)
  loc_00606E40: var_18 = FindWindow(var_ret_1, var_30)
  loc_00606E53: var_ret_2 = "MDIClient"
  loc_00606E5C: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00606E69: var_1C = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00606E87: var_30 = "aol://9293:" & Me
  loc_00606E91: call Proc_79_35_6076D0(var_30, GetLastError(), var_ret_3 = #StkVar1%StkVar2)
  loc_00606EAA: var_ret_4 = "Send Instant Message"
  loc_00606EB6: var_ret_5 = "AOL Child"
  loc_00606EBF: var_eax = FindWindowEx(var_1C, 0, var_ret_5, var_ret_4)
  loc_00606EEA: var_ret_6 = "RICHCNTL"
  loc_00606EF0: var_eax = FindWindowEx(FindWindowEx(var_1C, 0, var_ret_5, var_ret_4), 0, var_ret_6, 0)
  loc_00606EF5: var_38 = FindWindowEx(var_38, 0, var_ret_6, 0)
  loc_00606F00: var_14 = var_38
  loc_00606F14: var_ret_7 = "_AOL_Icon"
  loc_00606F1A: var_eax = FindWindowEx(var_38, 0, var_ret_7, 0)
  loc_00606F1F: var_38 = FindWindowEx(var_38, 0, var_ret_7, 0)
  loc_00606F27: var_28 = var_38
  loc_00606F3E: var_ret_8 = "_AOL_Icon"
  loc_00606F46: var_eax = FindWindowEx(var_38, var_28, var_ret_8, 0)
  loc_00606F4B: var_38 = FindWindowEx(var_38, var_28, var_ret_8, 0)
  loc_00606F53: var_28 = var_38
  loc_00606F6A: var_ret_9 = "_AOL_Icon"
  loc_00606F72: var_eax = FindWindowEx(var_38, var_28, var_ret_9, 0)
  loc_00606F77: var_38 = FindWindowEx(var_38, var_28, var_ret_9, 0)
  loc_00606F7F: var_28 = var_38
  loc_00606F96: var_ret_A = "_AOL_Icon"
  loc_00606F9E: var_eax = FindWindowEx(var_38, var_28, var_ret_A, 0)
  loc_00606FA3: var_38 = FindWindowEx(var_38, var_28, var_ret_A, 0)
  loc_00606FAB: var_28 = var_38
  loc_00606FC2: var_ret_B = "_AOL_Icon"
  loc_00606FCA: var_eax = FindWindowEx(var_38, var_28, var_ret_B, 0)
  loc_00606FCF: var_38 = FindWindowEx(var_38, var_28, var_ret_B, 0)
  loc_00606FD7: var_28 = var_38
  loc_00606FEE: var_ret_C = "_AOL_Icon"
  loc_00606FF6: var_eax = FindWindowEx(var_38, var_28, var_ret_C, 0)
  loc_00606FFB: var_38 = FindWindowEx(var_38, var_28, var_ret_C, 0)
  loc_00607003: var_28 = var_38
  loc_0060701A: var_ret_D = "_AOL_Icon"
  loc_00607022: var_eax = FindWindowEx(var_38, var_28, var_ret_D, 0)
  loc_00607027: var_38 = FindWindowEx(var_38, var_28, var_ret_D, 0)
  loc_0060702F: var_28 = var_38
  loc_00607046: var_ret_E = "_AOL_Icon"
  loc_0060704E: var_eax = FindWindowEx(var_38, var_28, var_ret_E, 0)
  loc_00607053: var_38 = FindWindowEx(var_38, var_28, var_ret_E, 0)
  loc_0060705B: var_28 = var_38
  loc_00607072: var_ret_F = "_AOL_Icon"
  loc_0060707A: var_eax = FindWindowEx(var_38, var_28, var_ret_F, 0)
  loc_00607087: var_28 = FindWindowEx(var_38, var_28, var_ret_F, 0)
  loc_00607095: If var_38 = 0 Then GoTo loc_00606E9B
  loc_006070A0: If var_14 = 0 Then GoTo loc_00606E9B
  loc_006070AB: If var_28 = 0 Then GoTo loc_00606E9B
  loc_006070C6: var_eax = SendMessage(var_14, 12, 0, arg_C)
  loc_006070D2: var_ret_11 = var_30
  loc_006070F7: var_eax = SendMessage(var_28, 513, 0, 0)
  loc_00607111: var_eax = SendMessage(var_28, 514, 0, 0)
  loc_00607127: var_ret_12 = "America Online"
  loc_00607133: var_ret_13 = "#32770"
  loc_00607136: var_eax = FindWindow(var_ret_13, var_ret_12)
  loc_0060713B: var_38 = FindWindow(var_ret_13, var_ret_12)
  loc_0060715F: var_ret_14 = "Send Instant Message"
  loc_0060716B: var_ret_15 = "AOL Child"
  loc_00607174: var_eax = FindWindowEx(var_1C, 0, var_ret_15, var_ret_14)
  loc_00607179: var_38 = FindWindowEx(var_1C, 0, var_ret_15, var_ret_14)
  loc_0060718B: var_2C = var_38
  loc_00607199: If var_38 <> 0 Then GoTo loc_006071AA
  loc_006071A0: If var_2C <> 0 Then GoTo loc_00607118
  loc_006071A8: If var_38 = 0 Then GoTo loc_00607204
  loc_006071AA: 'Referenced from: 00607199
  loc_006071B5: var_ret_16 = "Button"
  loc_006071BB: var_eax = FindWindowEx(var_38, 0, var_ret_16, 0)
  loc_006071C0: var_38 = FindWindowEx(var_38, 0, var_ret_16, 0)
  loc_006071DB: var_eax = PostMessage(var_38, 256, 32, 0)
  loc_006071EC: var_eax = PostMessage(var_38, 257, 32, 0)
  loc_006071FD: var_eax = PostMessage(var_2C, 16, 0, 0)
  loc_00607204: 
  loc_00607209: GoTo loc_0060721F
  loc_0060721E: Exit Sub
  loc_0060721F: 'Referenced from: 00607209
End Sub