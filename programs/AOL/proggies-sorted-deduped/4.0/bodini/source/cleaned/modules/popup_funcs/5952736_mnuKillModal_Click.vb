ï»¿Private Sub mnuKillModal_Click() '5AD4E0
  loc_005AD533: 
  loc_005AD53E: var_ret_1 = "_AOL_Modal"
  loc_005AD545: var_eax = FindWindow(var_ret_1, 0)
  loc_005AD550: var_ret_2 = FindWindow(var_ret_1, 0)
  loc_005AD570: var_eax = SendMessage(var_ret_2, 16, 0, 0)
  loc_005AD57A: If var_ret_2 <> 0 Then GoTo loc_005AD533
  loc_005AD588: GoTo loc_005AD594
  loc_005AD593: Exit Sub
  loc_005AD594: 'Referenced from: 005AD588
End Sub