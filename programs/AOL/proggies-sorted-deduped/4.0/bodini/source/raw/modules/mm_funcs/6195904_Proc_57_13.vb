Public Sub Proc_57_13_5E8AC0
  loc_005E8B07: var_ret_1 = "AOL Frame25"
  loc_005E8B0A: var_eax = FindWindow(var_ret_1, var_30)
  loc_005E8B30: var_ret_2 = "MDICLIENT"
  loc_005E8B39: var_eax = FindWindowEx(FindWindow(var_ret_1, var_30), 0, var_ret_2, 0)
  loc_005E8B66: var_eax = FindWindowEx(FindWindowEx(var_38, 0, var_ret_2, 0), 0, "AOL Child", "Error")
  loc_005E8B89: var_ret_5 = "America Online"
  loc_005E8B95: var_ret_6 = "#32770"
  loc_005E8B98: var_eax = FindWindow(var_ret_6, var_ret_5)
  loc_005E8B9D: var_38 = FindWindow(var_ret_6, var_ret_5)
  loc_005E8BAF: var_24 = var_38
  loc_005E8BC6: var_ret_7 = "Static"
  loc_005E8BCF: var_eax = FindWindowEx(var_38, 0, var_ret_7, 0)
  loc_005E8BE9: var_ret_8 = "Static"
  loc_005E8BF4: var_eax = FindWindowEx(var_24, FindWindowEx(var_38, 0, var_ret_7, 0), var_ret_8, 0)
  loc_005E8C04: var_14 = FindWindowEx(var_24, var_38, var_ret_8, 0)
  loc_005E8C0E: If var_24 = 0 Then GoTo loc_005E8D22
  loc_005E8C1A: var_eax = call Proc_79_45_608BE0(var_14, 1, )
  loc_005E8C43: var_3C = InStr(, call Proc_79_45_608BE0(var_14, 1, ), "That mail is no longer available or is not accessible to this account.", 0)
  loc_005E8C4D: If var_3C = 0 Then GoTo loc_005E8D22
  loc_005E8C5C: var_ret_9 = "America Online"
  loc_005E8C68: var_ret_A = "#32770"
  loc_005E8C6B: var_eax = FindWindow(var_ret_A, var_ret_9)
  loc_005E8C70: var_38 = FindWindow(var_ret_A, var_ret_9)
  loc_005E8C82: var_24 = var_38
  loc_005E8C99: var_ret_B = "Static"
  loc_005E8CA2: var_eax = FindWindowEx(var_38, 0, var_ret_B, 0)
  loc_005E8CBC: var_ret_C = "Static"
  loc_005E8CC7: var_eax = FindWindowEx(var_24, FindWindowEx(var_38, 0, var_ret_B, 0), var_ret_C, 0)
  loc_005E8CD7: var_14 = FindWindowEx(var_24, var_38, var_ret_C, 0)
  loc_005E8CE5: var_ret_D = "OK"
  loc_005E8CF1: var_ret_E = "Button"
  loc_005E8CFA: var_eax = FindWindowEx(var_24, 0, var_ret_E, var_ret_D)
  loc_005E8D1D: var_eax = call Proc_608D20(FindWindowEx(var_24, 0, var_ret_E, var_ret_D), , )
  loc_005E8D22: 'Referenced from: 005E8C0E
  loc_005E8D27: GoTo loc_005E8D3D
  loc_005E8D3C: Exit Sub
  loc_005E8D3D: 'Referenced from: 005E8D27
End Sub