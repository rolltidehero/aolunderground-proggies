ï»¿Private Sub mnuKillWelcome_Click() '5AD740
  loc_005AD79D: var_ret_1 = "AOL Frame25"
  loc_005AD7A0: var_eax = FindWindow(var_ret_1, var_24)
  loc_005AD7C3: var_ret_2 = "MDIClient"
  loc_005AD7C9: var_eax = FindWindowEx(FindWindow(var_ret_1, var_24), 0, var_ret_2, 0)
  loc_005AD7CE: var_34 = FindWindowEx(FindWindow(var_ret_1, var_24), 0, var_ret_2, 0)
  loc_005AD7E1: call Proc_79_47_609590("Welcome, ", var_ret_3 = #StkVar1%StkVar2, GetLastError())
  loc_005AD819: var_ret_4 = ecx = %S_edx_S & var_ret_3 & var_00430680
  loc_005AD824: var_eax = FindWindowEx(var_34, 0, 0, var_ret_4)
  loc_005AD84B: var_eax = ShowWindow(FindWindowEx(var_34, 0, 0, var_ret_4), 0)
  loc_005AD85E: GoTo loc_005AD87C
  loc_005AD87B: Exit Sub
  loc_005AD87C: 'Referenced from: 005AD85E
End Sub