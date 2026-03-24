Public Sub Proc_79_54_60A7D0
  loc_0060A820: var_ret_1 = "AOL Frame25"
  loc_0060A827: var_eax = FindWindow(var_ret_1, 0)
  loc_0060A839: var_20 = FindWindow(var_ret_1, 0)
  loc_0060A843: var_eax = GetMenu(FindWindow(var_ret_1, 0))
  loc_0060A84D: var_28 = GetMenu(FindWindow(var_ret_1, 0))
  loc_0060A850: var_eax = GetMenuItemCount(GetMenu(FindWindow(var_ret_1, 0)))
  loc_0060A859: GetMenuItemCount(GetMenu(FindWindow(var_ret_1, 0))) = GetMenuItemCount(GetMenu(FindWindow(var_ret_1, 0))) - 00000001h
  loc_0060A864: var_98 = GetMenuItemCount(GetMenu(FindWindow(var_ret_1, 0)))
  loc_0060A873: If eax > 0 Then GoTo loc_0060A9E4
  loc_0060A87E: var_eax = GetSubMenu(var_28, eax)
  loc_0060A888: var_eax = GetMenuItemCount(GetSubMenu(var_28, eax))
  loc_0060A891: GetMenuItemCount(GetSubMenu(var_28, eax)) = GetMenuItemCount(GetSubMenu(var_28, eax)) - 00000001h
  loc_0060A89C: var_A0 = GetMenuItemCount(GetSubMenu(var_28, eax))
  loc_0060A8AB: If eax > 0 Then GoTo loc_0060A9BD
  loc_0060A8B3: var_eax = GetMenuItemID(GetSubMenu(var_28, eax), eax)
  loc_0060A8E7: var_1C = String$(100, &H43134C)
  loc_0060A90B: var_eax = GetMenuString(GetSubMenu(var_28, eax), GetMenuItemID(GetSubMenu(var_28, eax), eax), var_1C, 100, 1)
  loc_0060A91A: var_ret_3 = var_38
  loc_0060A934: var_70 = var_1C
  loc_0060A93E: var_48 = LCase(var_1C)
  loc_0060A95F: var_58 = LCase(Me)
  loc_0060A975: call InStr(var_68, 00000000h, var_58, var_48, 00000001h, GetSubMenu(var_28, eax), GetLastError(), GetMenuItemID(GetSubMenu(var_28, eax), eax))
  loc_0060A985: var_90 = CBool(InStr(var_68, 00000000h, var_58, var_48, 00000001h, GetSubMenu(var_28, eax), GetLastError(), GetMenuItemID(GetSubMenu(var_28, eax), eax)))
  loc_0060A9A7: If var_90 <> 0 Then GoTo loc_0060A9D1
  loc_0060A9B1: 00000001h = 00000001h + var_2C
  loc_0060A9B8: GoTo loc_0060A8A5
  loc_0060A9BD: 'Referenced from: 0060A8AB
  loc_0060A9C5: 00000001h = 00000001h + var_24
  loc_0060A9CC: GoTo loc_0060A86D
  loc_0060A9D1: 
  loc_0060A9DD: var_eax = SendMessage(var_20, 273, GetMenuItemID(GetSubMenu(var_28, eax), eax), 0)
  loc_0060A9E4: 'Referenced from: 0060A873
  loc_0060A9E9: GoTo loc_0060AA0C
  loc_0060AA0B: Exit Sub
  loc_0060AA0C: 'Referenced from: 0060A9E9
  loc_0060AA15: Exit Sub
End Sub