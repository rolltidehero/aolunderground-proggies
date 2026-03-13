ï»¿Public Sub Proc_79_3_601A00
  Dim var_38 As Screen
  Dim var_3C As Screen
  loc_00601A50: var_ret_1 = "AOL Frame25"
  loc_00601A53: var_eax = FindWindow(var_ret_1, 0)
  loc_00601A6F: var_24 = FindWindow(var_ret_1, 0)
  loc_00601A7F: var_ret_2 = "AOL Toolbar"
  loc_00601A88: var_eax = FindWindowEx(var_24, 0, var_ret_2, 0)
  loc_00601A98: var_18 = FindWindowEx(var_24, 0, var_ret_2, 0)
  loc_00601AA8: var_ret_3 = "_AOL_Toolbar"
  loc_00601AB1: var_eax = FindWindowEx(var_18, 0, var_ret_3, 0)
  loc_00601AC1: var_14 = FindWindowEx(var_18, 0, var_ret_3, 0)
  loc_00601AD1: var_ret_4 = "_AOL_Icon"
  loc_00601ADA: var_eax = FindWindowEx(var_14, 0, var_ret_4, 0)
  loc_00601AEA: var_30 = FindWindowEx(var_14, 0, var_ret_4, 0)
  loc_00601AFA: var_ret_5 = "_AOL_Icon"
  loc_00601B05: var_eax = FindWindowEx(var_14, var_30, var_ret_5, 0)
  loc_00601B15: var_30 = FindWindowEx(var_14, var_30, var_ret_5, 0)
  loc_00601B25: var_ret_6 = "_AOL_Icon"
  loc_00601B30: var_eax = FindWindowEx(var_14, var_30, var_ret_6, 0)
  loc_00601B3D: var_30 = FindWindowEx(var_14, var_30, var_ret_6, 0)
  loc_00601B49: var_eax = GetCursorPos(var_20)
  loc_00601B76: var_38 = Global.Screen
  loc_00601B9A: var_40 = Global.Width
  loc_00601BDE: var_3C = Global.Screen
  loc_00601C02: var_44 = Global.Height
  loc_00601C2C: var_eax = SetCursorPos(CLng(var_40), CLng(var_44))
  loc_00601C53: var_eax = PostMessage(var_30, 513, 0, 0)
  loc_00601C64: var_eax = PostMessage(var_30, 514, 0, 0)
  loc_00601C6B: 
  loc_00601C76: var_ret_7 = "#32768"
  loc_00601C79: var_eax = FindWindow(var_ret_7, 0)
  loc_00601C90: var_eax = IsWindowVisible(FindWindow(var_ret_7, 0))
  loc_00601C95: var_40 = IsWindowVisible(var_40)
  loc_00601C9E: If var_40 <> 1 Then GoTo loc_00601C6B
  loc_00601CAA: var_eax = PostMessage(var_40, 256, 40, 0)
  loc_00601CBB: var_eax = PostMessage(var_40, 257, 40, 0)
  loc_00601CCC: var_eax = PostMessage(var_40, 256, 40, 0)
  loc_00601CDD: var_eax = PostMessage(var_40, 257, 40, 0)
  loc_00601CEE: var_eax = PostMessage(var_40, 256, 13, 0)
  loc_00601CFF: var_eax = PostMessage(var_40, 257, 13, 0)
  loc_00601D0E: var_eax = SetCursorPos(var_20, var_1C)
  loc_00601D1B: GoTo loc_00601D3A
  loc_00601D39: Exit Sub
  loc_00601D3A: 'Referenced from: 00601D1B
End Sub