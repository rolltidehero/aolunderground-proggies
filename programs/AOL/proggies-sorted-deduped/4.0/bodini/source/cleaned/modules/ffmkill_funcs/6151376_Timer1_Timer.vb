ï»¿Private Sub Timer1_Timer() '5DDCD0
  loc_005DDD29: var_ret_1 = "America Online Timer"
  loc_005DDD35: var_ret_2 = "_AOL_Palette"
  loc_005DDD38: var_eax = FindWindow(var_ret_2, var_ret_1)
  loc_005DDD5C: If FindWindow(var_ret_2, var_ret_1) = 0 Then GoTo loc_005DDD8D
  loc_005DDD69: var_ret_3 = "_AOL_Icon"
  loc_005DDD6F: var_eax = FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0)
  loc_005DDD88: var_eax = call Proc_608D20(FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0), , )
  loc_005DDD8D: 'Referenced from: 005DDD5C
  loc_005DDD99: GoTo loc_005DDDAF
  loc_005DDDAE: Exit Sub
  loc_005DDDAF: 'Referenced from: 005DDD99
End Sub