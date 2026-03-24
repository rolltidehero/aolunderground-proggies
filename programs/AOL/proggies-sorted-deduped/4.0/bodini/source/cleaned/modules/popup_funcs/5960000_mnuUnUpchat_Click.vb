ï»¿Private Sub mnuUnUpchat_Click() '5AF140
  loc_005AF197: var_ret_1 = "AOL Frame25"
  loc_005AF19A: var_eax = FindWindow(var_ret_1, var_28)
  loc_005AF1CE: var_38 = FindWindow(var_ret_1, var_28)
  loc_005AF1D1: var_ret_3 = "_AOL_Modal"
  loc_005AF1DA: var_eax = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_005AF1EC: var_18 = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_005AF200: var_ret_5 = "_AOL_Gauge"
  loc_005AF20A: var_eax = FindWindowEx(var_18, 0, var_ret_5, 0)
  loc_005AF215: var_ret_6 = FindWindowEx(var_18, 0, var_ret_5, 0)
  loc_005AF228: If var_ret_6 <> 0 Then GoTo loc_005AF22D
  loc_005AF22D: 'Referenced from: 005AF228
  loc_005AF233: var_eax = EnableWindow(var_1C, 1)
  loc_005AF240: var_eax = EnableWindow(var_38, 0)
  loc_005AF253: GoTo loc_005AF25F
  loc_005AF25E: Exit Sub
  loc_005AF25F: 'Referenced from: 005AF253
End Sub