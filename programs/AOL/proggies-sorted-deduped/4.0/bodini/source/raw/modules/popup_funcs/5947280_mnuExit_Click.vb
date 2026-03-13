Private Sub mnuExit_Click() '5ABF90
  loc_005AC027: var_24 = "do you wish to exit bodini by: spek?"
  loc_005AC06B: var_34 = "bodini by: spek"
  loc_005AC0A5: var_ret_1 = CLng(CLng(4132))
  loc_005AC0BF: var_CC = MsgBox(var_24, var_ret_1, var_34, var_94, var_A4)
  loc_005AC0CF: var_64 = MsgBox(var_24, var_ret_1, var_34, var_94, var_A4)
  loc_005AC112: If (var_64 = 6) = 0 Then GoTo loc_005AC11A
  loc_005AC114: End
  loc_005AC11A: 'Referenced from: 005AC112
  loc_005AC122: GoTo loc_005AC13E
  loc_005AC13D: Exit Sub
  loc_005AC13E: 'Referenced from: 005AC122
End Sub