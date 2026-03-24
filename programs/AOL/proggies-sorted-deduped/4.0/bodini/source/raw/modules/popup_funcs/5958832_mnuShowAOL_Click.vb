Private Sub mnuShowAOL_Click() '5AECB0
  loc_005AECFE: var_ret_1 = "AOL Frame25"
  loc_005AED05: var_eax = FindWindow(var_ret_1, 0)
  loc_005AED20: var_eax = ShowWindow(FindWindow(var_ret_1, 0), 5)
  loc_005AED2F: GoTo loc_005AED3B
  loc_005AED3A: Exit Sub
  loc_005AED3B: 'Referenced from: 005AED2F
End Sub