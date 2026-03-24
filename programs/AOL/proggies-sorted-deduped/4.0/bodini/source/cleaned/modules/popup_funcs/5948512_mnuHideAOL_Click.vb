ï»¿Private Sub mnuHideAOL_Click() '5AC460
  loc_005AC4AE: var_ret_1 = "AOL Frame25"
  loc_005AC4B5: var_eax = FindWindow(var_ret_1, 0)
  loc_005AC4CF: var_eax = ShowWindow(FindWindow(var_ret_1, 0), ebx)
  loc_005AC4DE: GoTo loc_005AC4EA
  loc_005AC4E9: Exit Sub
  loc_005AC4EA: 'Referenced from: 005AC4DE
End Sub