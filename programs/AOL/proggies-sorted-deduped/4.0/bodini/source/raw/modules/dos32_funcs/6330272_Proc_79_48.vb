Public Sub Proc_79_48_6097A0
  loc_006097E4: var_ret_1 = "AOL Frame25"
  loc_006097E7: var_eax = FindWindow(var_ret_1, var_34)
  loc_0060980D: var_ret_2 = "MDIClient"
  loc_00609816: var_eax = FindWindowEx(FindWindow(var_ret_1, var_34), 0, var_ret_2, 0)
  loc_0060981B: var_48 = FindWindowEx(var_48, 0, var_ret_2, 0)
  loc_0060982E: var_ret_3 = "Welcome, "
  loc_00609839: var_eax = FindWindowEx(var_48, 0, 0, var_ret_3)
  loc_00609850: If FindWindowEx(var_48, 0, 0, var_ret_3) = 0 Then GoTo loc_00609859
  loc_00609859: 'Referenced from: 00609850
  loc_00609866: var_30 = CInt(1)
  loc_00609871: GoTo loc_0060988C
  loc_00609877: If var_4 = 0 Then GoTo loc_00609882
  loc_00609882: 'Referenced from: 00609877
  loc_0060988B: Exit Sub
  loc_0060988C: 'Referenced from: 00609871
End Sub