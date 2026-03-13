Public Sub Proc_79_42_6087C0
  loc_00608836: var_18 = String(255, Chr(var_4C))
  loc_0060885F: var_ret_1 = arg_14
  loc_00608875: var_ret_2 = var_18
  loc_00608881: var_ret_3 = vbNullString
  loc_0060888E: var_ret_4 = arg_10
  loc_0060889B: var_ret_5 = arg_C
  loc_0060889E: var_eax = GetPrivateProfileString(var_ret_5, var_ret_4, var_ret_3, var_ret_2, Len(var_18), var_ret_1)
  loc_006088BA: var_ret_6 = var_2C
  loc_006088C1: var_ret_7 = var_30
  loc_006088CB: var_ret_8 = var_38
  loc_006088D2: var_ret_9 = var_3C
  loc_006088DA: var_64 = var_18
  loc_006088F9: var_28 = Left(var_18, GetPrivateProfileString(var_ret_5, var_ret_4, var_ret_3, var_ret_2, Len(var_18), var_ret_1))
  loc_00608923: GoTo loc_00608964
  loc_00608929: If var_4 = 0 Then GoTo loc_00608934
  loc_00608934: 'Referenced from: 00608929
  loc_00608963: Exit Sub
  loc_00608964: 'Referenced from: 00608923
End Sub