Public Sub Proc_79_35_6076D0
  loc_00607711: var_ret_1 = "AOL Frame25"
  loc_00607714: var_eax = FindWindow(var_ret_1, 0)
  loc_0060773A: var_ret_2 = "AOL Toolbar"
  loc_00607743: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_0060775D: var_ret_3 = "_AOL_Toolbar"
  loc_00607766: var_eax = FindWindowEx(FindWindowEx(var_2C, 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_00607780: var_ret_4 = "_AOL_Combobox"
  loc_00607789: var_eax = FindWindowEx(FindWindowEx(var_2C, 0, var_ret_3, 0), 0, var_ret_4, 0)
  loc_006077A3: var_ret_5 = "Edit"
  loc_006077AC: var_eax = FindWindowEx(FindWindowEx(var_2C, 0, var_ret_4, 0), 0, var_ret_5, 0)
  loc_006077B1: var_2C = FindWindowEx(var_2C, 0, var_ret_5, 0)
  loc_006077D0: var_eax = SendMessage(var_2C, 12, 0, Me)
  loc_006077F4: var_eax = SendMessage(var_2C, 258, 32, 0)
  loc_00607805: var_eax = SendMessage(var_2C, 258, 13, 0)
  loc_00607811: GoTo loc_0060781D
  loc_0060781C: Exit Sub
  loc_0060781D: 'Referenced from: 00607811
End Sub