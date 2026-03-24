Private Sub mnuKillGlyph_Click() '5AD3C0
  loc_005AD417: var_ret_1 = "AOL Frame25"
  loc_005AD41A: var_eax = FindWindow(var_ret_1, 0)
  loc_005AD440: var_ret_2 = "AOL Toolbar"
  loc_005AD449: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_005AD463: var_ret_3 = "_AOL_Toolbar"
  loc_005AD46C: var_eax = FindWindowEx(FindWindowEx(var_2C, 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_005AD471: var_2C = FindWindowEx(var_2C, 0, var_ret_3, 0)
  loc_005AD486: var_ret_4 = "_AOL_Glyph"
  loc_005AD48F: var_eax = FindWindowEx(var_2C, 0, var_ret_4, 0)
  loc_005AD4A0: var_eax = ShowWindow(FindWindowEx(var_2C, 0, var_ret_4, 0), 0)
  loc_005AD4B3: GoTo loc_005AD4BF
  loc_005AD4BE: Exit Sub
  loc_005AD4BF: 'Referenced from: 005AD4B3
End Sub