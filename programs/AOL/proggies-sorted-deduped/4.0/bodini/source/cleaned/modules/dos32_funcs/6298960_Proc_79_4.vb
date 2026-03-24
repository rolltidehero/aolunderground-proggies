ï»¿Public Sub Proc_79_4_601D50
  Dim var_3C As Screen
  Dim var_40 As Screen
  loc_00601DA0: var_ret_1 = "AOL Frame25"
  loc_00601DA3: var_eax = FindWindow(var_ret_1, 0)
  loc_00601DBF: var_28 = FindWindow(var_ret_1, 0)
  loc_00601DCF: var_ret_2 = "AOL Toolbar"
  loc_00601DD8: var_eax = FindWindowEx(var_28, 0, var_ret_2, 0)
  loc_00601DE8: var_1C = FindWindowEx(var_28, 0, var_ret_2, 0)
  loc_00601DF8: var_ret_3 = "_AOL_Toolbar"
  loc_00601E01: var_eax = FindWindowEx(var_1C, 0, var_ret_3, 0)
  loc_00601E11: var_18 = FindWindowEx(var_1C, 0, var_ret_3, 0)
  loc_00601E21: var_ret_4 = "_AOL_Icon"
  loc_00601E2A: var_eax = FindWindowEx(var_18, 0, var_ret_4, 0)
  loc_00601E3A: var_34 = FindWindowEx(var_18, 0, var_ret_4, 0)
  loc_00601E4A: var_ret_5 = "_AOL_Icon"
  loc_00601E55: var_eax = FindWindowEx(var_18, var_34, var_ret_5, 0)
  loc_00601E65: var_34 = FindWindowEx(var_18, var_34, var_ret_5, 0)
  loc_00601E75: var_ret_6 = "_AOL_Icon"
  loc_00601E80: var_eax = FindWindowEx(var_18, var_34, var_ret_6, 0)
  loc_00601E8D: var_34 = FindWindowEx(var_18, var_34, var_ret_6, 0)
  loc_00601E99: var_eax = GetCursorPos(var_24)
  loc_00601EC6: var_3C = Global.Screen
  loc_00601EEA: var_44 = Global.Width
  loc_00601F2E: var_40 = Global.Screen
  loc_00601F52: var_48 = Global.Height
  loc_00601F7C: var_eax = SetCursorPos(CLng(var_44), CLng(var_48))
  loc_00601FA3: var_eax = PostMessage(var_34, 513, 0, 0)
  loc_00601FB4: var_eax = PostMessage(var_34, 514, 0, 0)
  loc_00601FBB: 
  loc_00601FC6: var_ret_7 = "#32768"
  loc_00601FC9: var_eax = FindWindow(var_ret_7, 0)
  loc_00601FE0: var_eax = IsWindowVisible(FindWindow(var_ret_7, 0))
  loc_00601FE5: var_44 = IsWindowVisible(var_44)
  loc_00601FEE: If var_44 <> 1 Then GoTo loc_00601FBB
  loc_00601FF5: 
  loc_00601FFE: If 00000001h > 4 Then GoTo loc_0060202D
  loc_00602008: var_eax = PostMessage(var_44, 256, 40, 0)
  loc_00602019: var_eax = PostMessage(var_44, 257, 40, 0)
  loc_00602025: 00000001h = 00000001h + 00000001h
  loc_0060202B: GoTo loc_00601FF5
  loc_0060202D: 'Referenced from: 00601FFE
  loc_00602035: var_eax = PostMessage(var_44, 256, 13, )
  loc_00602046: var_eax = PostMessage(var_44, 257, 13, 0)
  loc_00602055: var_eax = SetCursorPos(var_24, var_20)
  loc_00602062: GoTo loc_00602081
  loc_00602080: Exit Sub
  loc_00602081: 'Referenced from: 00602062
End Sub