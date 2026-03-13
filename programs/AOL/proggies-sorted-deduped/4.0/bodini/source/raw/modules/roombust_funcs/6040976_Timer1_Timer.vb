Private Sub Timer1_Timer() '5C2D90
  loc_005C2DE6: var_ret_1 = "America Online"
  loc_005C2DF2: var_ret_2 = "#32770"
  loc_005C2DF5: var_eax = FindWindow(var_ret_2, var_ret_1)
  loc_005C2E22: var_ret_3 = "OK"
  loc_005C2E28: var_eax = FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0)
  loc_005C2E44: var_eax = PostMessage(FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0), 513, 0, 0)
  loc_005C2E55: var_eax = PostMessage(FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0), 514, 0, 0)
  loc_005C2E68: GoTo loc_005C2E7E
  loc_005C2E7D: Exit Sub
  loc_005C2E7E: 'Referenced from: 005C2E68
End Sub