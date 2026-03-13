Public Sub Proc_79_8_6029E0
  loc_00602A21: var_ret_1 = "AOL Frame25"
  loc_00602A24: var_eax = FindWindow(var_ret_1, 0)
  loc_00602A4A: var_ret_2 = "MDIClient"
  loc_00602A53: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_00602A58: var_30 = FindWindowEx(var_30, 0, var_ret_2, 0)
  loc_00602A63: var_20 = var_30
  loc_00602A73: var_ret_3 = "AOL Child"
  loc_00602A7C: var_eax = FindWindowEx(var_30, 0, var_ret_3, 0)
  loc_00602A81: var_30 = FindWindowEx(var_30, 0, var_ret_3, 0)
  loc_00602A8C: var_24 = var_30
  loc_00602A9C: var_ret_4 = "_AOL_TabControl"
  loc_00602AA5: var_eax = FindWindowEx(var_30, 0, var_ret_4, 0)
  loc_00602AAA: var_30 = FindWindowEx(var_30, 0, var_ret_4, 0)
  loc_00602AB5: var_14 = var_30
  loc_00602AC5: var_ret_5 = "_AOL_TabPage"
  loc_00602ACE: var_eax = FindWindowEx(var_30, 0, var_ret_5, 0)
  loc_00602AD3: var_30 = FindWindowEx(var_30, 0, var_ret_5, 0)
  loc_00602AE2: If var_14 = 0 Then GoTo loc_00602AFB
  loc_00602AE9: If var_30 = 0 Then GoTo loc_00602AFB
  loc_00602AF3: var_1C = var_24
  loc_00602AF6: GoTo loc_00602BB1
  loc_00602AFB: 'Referenced from: 00602AE2
  loc_00602B06: var_ret_6 = "AOL Child"
  loc_00602B11: var_eax = FindWindowEx(var_20, var_24, var_ret_6, 0)
  loc_00602B16: var_30 = FindWindowEx(var_20, var_24, var_ret_6, 0)
  loc_00602B1E: var_24 = var_30
  loc_00602B31: var_ret_7 = "_AOL_TabControl"
  loc_00602B3A: var_eax = FindWindowEx(var_30, 0, var_ret_7, 0)
  loc_00602B3F: var_30 = FindWindowEx(var_30, 0, var_ret_7, 0)
  loc_00602B47: var_14 = var_30
  loc_00602B5A: var_ret_8 = "_AOL_TabPage"
  loc_00602B63: var_eax = FindWindowEx(var_30, 0, var_ret_8, 0)
  loc_00602B68: var_30 = FindWindowEx(var_30, 0, var_ret_8, 0)
  loc_00602B77: If var_14 = 0 Then GoTo loc_00602B80
  loc_00602B7E: If var_30 <> 0 Then GoTo loc_00602B8C
  loc_00602B80: 'Referenced from: 00602B77
  loc_00602B85: If var_24 = 0 Then GoTo loc_00602B99
  loc_00602B87: GoTo loc_00602AFB
  loc_00602B8C: 
  loc_00602B94: var_1C = var_24
  loc_00602B97: GoTo loc_00602BB1
  loc_00602B99: 'Referenced from: 00602B85
  loc_00602BA5: GoTo loc_00602BB1
  loc_00602BB0: Exit Sub
  loc_00602BB1: 'Referenced from: 00602AF6
End Sub