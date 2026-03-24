ï»¿Public Sub Proc_79_5_6020A0
  Dim var_3C As Screen
  Dim var_40 As Screen
  loc_006020F0: var_ret_1 = "AOL Frame25"
  loc_006020F3: var_eax = FindWindow(var_ret_1, 0)
  loc_0060210F: var_28 = FindWindow(var_ret_1, 0)
  loc_0060211F: var_ret_2 = "AOL Toolbar"
  loc_00602128: var_eax = FindWindowEx(var_28, 0, var_ret_2, 0)
  loc_00602138: var_1C = FindWindowEx(var_28, 0, var_ret_2, 0)
  loc_00602148: var_ret_3 = "_AOL_Toolbar"
  loc_00602151: var_eax = FindWindowEx(var_1C, 0, var_ret_3, 0)
  loc_00602161: var_18 = FindWindowEx(var_1C, 0, var_ret_3, 0)
  loc_00602171: var_ret_4 = "_AOL_Icon"
  loc_0060217A: var_eax = FindWindowEx(var_18, 0, var_ret_4, 0)
  loc_0060218A: var_34 = FindWindowEx(var_18, 0, var_ret_4, 0)
  loc_0060219A: var_ret_5 = "_AOL_Icon"
  loc_006021A5: var_eax = FindWindowEx(var_18, var_34, var_ret_5, 0)
  loc_006021B5: var_34 = FindWindowEx(var_18, var_34, var_ret_5, 0)
  loc_006021C5: var_ret_6 = "_AOL_Icon"
  loc_006021D0: var_eax = FindWindowEx(var_18, var_34, var_ret_6, 0)
  loc_006021DD: var_34 = FindWindowEx(var_18, var_34, var_ret_6, 0)
  loc_006021E9: var_eax = GetCursorPos(var_24)
  loc_00602216: var_3C = Global.Screen
  loc_0060223A: var_44 = Global.Width
  loc_0060227E: var_40 = Global.Screen
  loc_006022A2: var_48 = Global.Height
  loc_006022CC: var_eax = SetCursorPos(CLng(var_44), CLng(var_48))
  loc_006022F3: var_eax = PostMessage(var_34, 513, 0, 0)
  loc_00602304: var_eax = PostMessage(var_34, 514, 0, 0)
  loc_0060230B: 
  loc_00602316: var_ret_7 = "#32768"
  loc_00602319: var_eax = FindWindow(var_ret_7, 0)
  loc_00602330: var_eax = IsWindowVisible(FindWindow(var_ret_7, 0))
  loc_00602335: var_44 = IsWindowVisible(var_44)
  loc_0060233E: If var_44 <> 1 Then GoTo loc_0060230B
  loc_00602345: 
  loc_0060234E: If 00000001h > 5 Then GoTo loc_0060237D
  loc_00602358: var_eax = PostMessage(var_44, 256, 40, 0)
  loc_00602369: var_eax = PostMessage(var_44, 257, 40, 0)
  loc_00602375: 00000001h = 00000001h + 00000001h
  loc_0060237B: GoTo loc_00602345
  loc_0060237D: 'Referenced from: 0060234E
  loc_00602385: var_eax = PostMessage(var_44, 256, 13, )
  loc_00602396: var_eax = PostMessage(var_44, 257, 13, 0)
  loc_006023A5: var_eax = SetCursorPos(var_24, var_20)
  loc_006023B2: GoTo loc_006023D1
  loc_006023D0: Exit Sub
  loc_006023D1: 'Referenced from: 006023B2
End Sub