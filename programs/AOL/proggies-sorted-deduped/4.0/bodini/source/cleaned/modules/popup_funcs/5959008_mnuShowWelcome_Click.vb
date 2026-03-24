ï»¿Private Sub mnuShowWelcome_Click() '5AED60
  loc_005AEDBD: var_ret_1 = "AOL Frame25"
  loc_005AEDC0: var_eax = FindWindow(var_ret_1, var_24)
  loc_005AEDE3: var_ret_2 = "MDIClient"
  loc_005AEDE9: var_eax = FindWindowEx(FindWindow(var_ret_1, var_24), 0, var_ret_2, 0)
  loc_005AEDEE: var_34 = FindWindowEx(FindWindow(var_ret_1, var_24), 0, var_ret_2, 0)
  loc_005AEE01: call Proc_79_47_609590("Welcome, ", var_ret_3 = #StkVar1%StkVar2, GetLastError())
  loc_005AEE39: var_ret_4 = ecx = %S_edx_S & var_ret_3 & var_00430680
  loc_005AEE44: var_eax = FindWindowEx(var_34, 0, 0, var_ret_4)
  loc_005AEE6B: var_eax = ShowWindow(FindWindowEx(var_34, 0, 0, var_ret_4), 5)
  loc_005AEE7E: GoTo loc_005AEE9C
  loc_005AEE9B: Exit Sub
  loc_005AEE9C: 'Referenced from: 005AEE7E
End Sub