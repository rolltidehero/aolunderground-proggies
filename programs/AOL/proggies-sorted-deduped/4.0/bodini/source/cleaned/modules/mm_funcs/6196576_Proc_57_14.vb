ï»¿Public Sub Proc_57_14_5E8D60
  loc_005E8DA7: var_ret_1 = "AOL Frame25"
  loc_005E8DAA: var_eax = FindWindow(var_ret_1, var_30)
  loc_005E8DD0: var_ret_2 = "MDICLIENT"
  loc_005E8DD9: var_eax = FindWindowEx(FindWindow(var_ret_1, var_30), 0, var_ret_2, 0)
  loc_005E8E06: var_eax = FindWindowEx(FindWindowEx(var_38, 0, var_ret_2, 0), 0, "AOL Child", "Error")
  loc_005E8E29: var_ret_5 = "America Online"
  loc_005E8E35: var_ret_6 = "#32770"
  loc_005E8E38: var_eax = FindWindow(var_ret_6, var_ret_5)
  loc_005E8E3D: var_38 = FindWindow(var_ret_6, var_ret_5)
  loc_005E8E4F: var_24 = var_38
  loc_005E8E66: var_ret_7 = "Static"
  loc_005E8E6F: var_eax = FindWindowEx(var_38, 0, var_ret_7, 0)
  loc_005E8E89: var_ret_8 = "Static"
  loc_005E8E94: var_eax = FindWindowEx(var_24, FindWindowEx(var_38, 0, var_ret_7, 0), var_ret_8, 0)
  loc_005E8EA4: var_14 = FindWindowEx(var_24, var_38, var_ret_8, 0)
  loc_005E8EAE: If var_24 = 0 Then GoTo loc_005E8FC2
  loc_005E8EBA: var_eax = call Proc_79_45_608BE0(var_14, 1, )
  loc_005E8EE3: var_3C = InStr(, call Proc_79_45_608BE0(var_14, 1, ), "That mail is no longer available or is not accessible to this account.", 0)
  loc_005E8EED: If var_3C = 0 Then GoTo loc_005E8FC2
  loc_005E8EFC: var_ret_9 = "America Online"
  loc_005E8F08: var_ret_A = "#32770"
  loc_005E8F0B: var_eax = FindWindow(var_ret_A, var_ret_9)
  loc_005E8F10: var_38 = FindWindow(var_ret_A, var_ret_9)
  loc_005E8F22: var_24 = var_38
  loc_005E8F39: var_ret_B = "Static"
  loc_005E8F42: var_eax = FindWindowEx(var_38, 0, var_ret_B, 0)
  loc_005E8F5C: var_ret_C = "Static"
  loc_005E8F67: var_eax = FindWindowEx(var_24, FindWindowEx(var_38, 0, var_ret_B, 0), var_ret_C, 0)
  loc_005E8F77: var_14 = FindWindowEx(var_24, var_38, var_ret_C, 0)
  loc_005E8F85: var_ret_D = "OK"
  loc_005E8F91: var_ret_E = "Button"
  loc_005E8F9A: var_eax = FindWindowEx(var_24, 0, var_ret_E, var_ret_D)
  loc_005E8FBD: var_eax = call Proc_608D20(FindWindowEx(var_24, 0, var_ret_E, var_ret_D), , )
  loc_005E8FC2: 'Referenced from: 005E8EAE
  loc_005E8FC7: GoTo loc_005E8FDD
  loc_005E8FDC: Exit Sub
  loc_005E8FDD: 'Referenced from: 005E8FC7
End Sub