ï»¿Private Sub Command2_Click() '5BB960
  loc_005BB9B7: var_ret_1 = "AOL Frame25"
  loc_005BB9BA: var_eax = FindWindow(var_ret_1, var_18)
  loc_005BB9DA: var_eax = SendMessage(FindWindow(var_ret_1, var_18), 12, 0, "America  Online")
  loc_005BBA00: GoTo loc_005BBA16
  loc_005BBA15: Exit Sub
  loc_005BBA16: 'Referenced from: 005BBA00
End Sub