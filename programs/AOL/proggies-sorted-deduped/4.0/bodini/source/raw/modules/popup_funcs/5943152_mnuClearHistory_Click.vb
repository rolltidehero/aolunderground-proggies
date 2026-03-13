Private Sub mnuClearHistory_Click() '5AAF70
  loc_005AB009: var_ret_1 = "AOL Frame25"
  loc_005AB00C: var_eax = FindWindow(var_ret_1, 0)
  loc_005AB057: var_ret_2 = "AOL Toolbar"
  loc_005AB065: var_ret_3 = CLng(FindWindow(var_ret_1, 0))
  loc_005AB068: var_eax = FindWindowEx(var_ret_3, 0, var_ret_2, 0)
  loc_005AB0AD: var_ret_4 = "_AOL_Toolbar"
  loc_005AB0B9: var_ret_5 = CLng(FindWindowEx(var_ret_3, 0, var_ret_2, 0))
  loc_005AB0BC: var_eax = FindWindowEx(var_ret_5, 0, var_ret_4, 0)
  loc_005AB101: var_ret_6 = "_AOL_Combobox"
  loc_005AB10D: var_ret_7 = CLng(FindWindowEx(var_ret_5, 0, var_ret_4, 0))
  loc_005AB110: var_eax = FindWindowEx(var_ret_7, 0, var_ret_6, 0)
  loc_005AB13C: var_34 = FindWindowEx(var_ret_7, 0, var_ret_6, 0)
  loc_005AB155: var_ret_8 = "Edit"
  loc_005AB161: var_ret_9 = CLng(var_34)
  loc_005AB164: var_eax = FindWindowEx(var_ret_9, 0, var_ret_8, 0)
  loc_005AB1B6: var_ret_A = CLng(var_34)
  loc_005AB1B9: var_eax = SendMessage(var_ret_A, 1030, edi, var_BC)
  loc_005AB1BE: var_C0 = SendMessage(var_ret_A, 1030, edi, var_BC)
  loc_005AB202: var_eax = SendMessage(CLng(FindWindowEx(var_ret_9, 0, var_ret_8, 0)), 12, edi, var_BC)
  loc_005AB254: For var_64 = "" To var_C0 Step 1
  loc_005AB25C: If var_64 = 0 Then GoTo loc_005AB2D0
  loc_005AB26F: var_ret_C = CLng(var_64)
  loc_005AB27B: var_ret_D = CLng(var_34)
  loc_005AB27E: var_eax = SendMessage(var_ret_D, 1028, var_ret_C, var_C0)
  loc_005AB2AA: var_74 = SendMessage(var_ret_D, 1028, var_ret_C, var_C0)
  loc_005AB2C8: Next var_64
  loc_005AB2CE: GoTo loc_005AB25A
  loc_005AB2D0: 'Referenced from: 005AB25C
  loc_005AB2E7: var_ret_E = CLng(var_34)
  loc_005AB2EA: var_eax = SendMessage(var_ret_E, 1030, edi, var_BC)
  loc_005AB33E: var_ret_F = (SendMessage(var_ret_E, 1030, edi, var_BC) = "")
  loc_005AB34C: call Not(var_98, var_ret_F, var_D4, var_E4, 0, %S_eax_S = CLng(%StkVar1), GetLastError())
  loc_005AB35C: If CBool(Not(var_98, var_ret_F, var_D4, var_E4, 0, var_ret_10 <> CLng(%StkVar1) <> 0 Then GoTo loc_005AB209
  loc_005AB36A: GoTo loc_005AB38F
  loc_005AB38E: Exit Sub
  loc_005AB38F: 'Referenced from: 005AB36A
End Sub