Public Sub Proc_79_2_6016B0
  Dim var_3C As Screen
  Dim var_40 As Screen
  loc_00601700: var_ret_1 = "AOL Frame25"
  loc_00601703: var_eax = FindWindow(var_ret_1, 0)
  loc_0060171F: var_28 = FindWindow(var_ret_1, 0)
  loc_0060172F: var_ret_2 = "AOL Toolbar"
  loc_00601738: var_eax = FindWindowEx(var_28, 0, var_ret_2, 0)
  loc_00601748: var_1C = FindWindowEx(var_28, 0, var_ret_2, 0)
  loc_00601758: var_ret_3 = "_AOL_Toolbar"
  loc_00601761: var_eax = FindWindowEx(var_1C, 0, var_ret_3, 0)
  loc_00601771: var_18 = FindWindowEx(var_1C, 0, var_ret_3, 0)
  loc_00601781: var_ret_4 = "_AOL_Icon"
  loc_0060178A: var_eax = FindWindowEx(var_18, 0, var_ret_4, 0)
  loc_0060179A: var_34 = FindWindowEx(var_18, 0, var_ret_4, 0)
  loc_006017AA: var_ret_5 = "_AOL_Icon"
  loc_006017B5: var_eax = FindWindowEx(var_18, var_34, var_ret_5, 0)
  loc_006017C5: var_34 = FindWindowEx(var_18, var_34, var_ret_5, 0)
  loc_006017D5: var_ret_6 = "_AOL_Icon"
  loc_006017E0: var_eax = FindWindowEx(var_18, var_34, var_ret_6, 0)
  loc_006017ED: var_34 = FindWindowEx(var_18, var_34, var_ret_6, 0)
  loc_006017F9: var_eax = GetCursorPos(var_24)
  loc_00601826: var_3C = Global.Screen
  loc_0060184A: var_44 = Global.Width
  loc_0060188E: var_40 = Global.Screen
  loc_006018B2: var_48 = Global.Height
  loc_006018DC: var_eax = SetCursorPos(CLng(var_44), CLng(var_48))
  loc_00601903: var_eax = PostMessage(var_34, 513, 0, 0)
  loc_00601914: var_eax = PostMessage(var_34, 514, 0, 0)
  loc_0060191B: 
  loc_00601926: var_ret_7 = "#32768"
  loc_00601929: var_eax = FindWindow(var_ret_7, 0)
  loc_00601940: var_eax = IsWindowVisible(FindWindow(var_ret_7, 0))
  loc_00601945: var_44 = IsWindowVisible(var_44)
  loc_0060194E: If var_44 <> 1 Then GoTo loc_0060191B
  loc_0060195A: var_eax = PostMessage(var_44, 256, 38, 0)
  loc_0060196B: var_eax = PostMessage(var_44, 257, 38, 0)
  loc_0060197C: var_eax = PostMessage(var_44, 256, 39, 0)
  loc_0060198D: var_eax = PostMessage(var_44, 257, 39, 0)
  loc_0060199E: var_eax = PostMessage(var_44, 256, 13, 0)
  loc_006019AF: var_eax = PostMessage(var_44, 257, 13, 0)
  loc_006019BE: var_eax = SetCursorPos(var_24, var_20)
  loc_006019CB: GoTo loc_006019EA
  loc_006019E9: Exit Sub
  loc_006019EA: 'Referenced from: 006019CB
End Sub