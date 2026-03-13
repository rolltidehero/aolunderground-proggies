ï»¿Private Sub mnuUpchat_Click() '5AF280
  loc_005AF2D7: var_ret_1 = "AOL Frame25"
  loc_005AF2DA: var_eax = FindWindow(var_ret_1, var_28)
  loc_005AF30E: var_38 = FindWindow(var_ret_1, var_28)
  loc_005AF311: var_ret_3 = "_AOL_Modal"
  loc_005AF31A: var_eax = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_005AF32C: var_18 = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_005AF340: var_ret_5 = "_AOL_Gauge"
  loc_005AF34A: var_eax = FindWindowEx(var_18, 0, var_ret_5, 0)
  loc_005AF355: var_ret_6 = FindWindowEx(var_18, 0, var_ret_5, 0)
  loc_005AF368: If var_ret_6 <> 0 Then GoTo loc_005AF36D
  loc_005AF36D: 'Referenced from: 005AF368
  loc_005AF373: var_eax = EnableWindow(var_38, 1)
  loc_005AF380: var_eax = EnableWindow(var_1C, 0)
  loc_005AF393: GoTo loc_005AF39F
  loc_005AF39E: Exit Sub
  loc_005AF39F: 'Referenced from: 005AF393
End Sub