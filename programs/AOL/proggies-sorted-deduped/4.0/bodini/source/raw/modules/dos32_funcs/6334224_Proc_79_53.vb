Public Sub Proc_79_53_60A710
  loc_0060A74B: var_ret_1 = "AOL Frame25"
  loc_0060A752: var_eax = FindWindow(var_ret_1, 0)
  loc_0060A76B: var_eax = GetMenu(FindWindow(var_ret_1, 0))
  loc_0060A77B: var_eax = GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me)
  loc_0060A78B: var_eax = GetMenuItemID(GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me), arg_C)
  loc_0060A79D: var_eax = SendMessage(FindWindow(var_ret_1, 0), 273, GetMenuItemID(GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me), arg_C), 0)
  loc_0060A7A9: GoTo loc_0060A7B5
  loc_0060A7B4: Exit Sub
  loc_0060A7B5: 'Referenced from: 0060A7A9
End Sub