ï»¿Public Sub Proc_79_6_6023F0
  loc_00602434: var_ret_1 = "AOL Frame25"
  loc_00602437: var_eax = FindWindow(var_ret_1, var_2C)
  loc_00602450: var_1C = FindWindow(var_ret_1, var_2C)
  loc_00602463: var_ret_2 = "MDICLIENT"
  loc_0060246C: var_eax = FindWindowEx(var_1C, 0, var_ret_2, 0)
  loc_00602479: var_24 = FindWindowEx(var_1C, 0, var_ret_2, 0)
  loc_0060248A: var_ret_3 = "Incoming/Saved Mail"
  loc_00602496: var_ret_4 = "AOL Child"
  loc_0060249F: var_eax = FindWindowEx(var_24, 0, var_ret_4, var_ret_3)
  loc_006024B6: var_20 = FindWindowEx(var_24, 0, var_ret_4, var_ret_3)
  loc_006024CD: var_ret_5 = "_AOL_Tree"
  loc_006024D6: var_eax = FindWindowEx(var_20, 0, var_ret_5, 0)
  loc_006024DB: var_34 = FindWindowEx(var_20, 0, var_ret_5, 0)
  loc_006024FB: var_eax = SendMessage(var_34, 395, 0, var_34)
  loc_00602504: var_18 = SendMessage(var_34, 395, 0, var_34)
  loc_0060250C: GoTo loc_00602522
  loc_00602521: Exit Sub
  loc_00602522: 'Referenced from: 0060250C
End Sub