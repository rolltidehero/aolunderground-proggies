Private Sub mnuKillAOL_Click() '5AD300
  loc_005AD351: var_ret_1 = "AOL Frame25"
  loc_005AD358: var_eax = FindWindow(var_ret_1, 0)
  loc_005AD372: var_eax = SendMessage(FindWindow(var_ret_1, 0), 16, ebx, var_20)
  loc_005AD37D: var_ret_2 = SendMessage(FindWindow(var_ret_1, 0), 16, ebx, var_20)
  loc_005AD394: GoTo loc_005AD3A0
  loc_005AD39F: Exit Sub
  loc_005AD3A0: 'Referenced from: 005AD394
End Sub