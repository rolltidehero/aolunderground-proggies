Public Sub Proc_79_1_601500
  loc_00601541: var_ret_1 = "AOL Frame25"
  loc_00601544: var_eax = FindWindow(var_ret_1, var_28)
  loc_00601567: var_ret_2 = "MDIClient"
  loc_0060156D: var_eax = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  loc_00601579: var_18 = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  loc_0060158D: var_ret_3 = "AOL Child"
  loc_00601593: var_eax = FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_0060159F: var_20 = FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_006015C3: var_eax = FindWindowEx(FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0), 0, "_AOL_Static", "Send Now")
  loc_006015E1: If FindWindowEx(FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28) = 0 Then GoTo loc_006015F3
  loc_006015EB: var_24 = var_20
  loc_006015EE: GoTo loc_00601691
  loc_006015F3: 'Referenced from: 006015E1
  loc_006015F6: 
  loc_00601601: var_ret_6 = "AOL Child"
  loc_00601609: var_eax = FindWindowEx(var_18, var_20, var_ret_6, 0)
  loc_00601615: var_20 = FindWindowEx(var_18, var_20, var_ret_6, 0)
  loc_00601639: var_eax = FindWindowEx(FindWindowEx(var_18, var_20, var_ret_6, 0), 0, "_AOL_Static", "Send Now")
  loc_00601657: If FindWindowEx(FindWindowEx(var_18, var_20, var_ret_6, 0) <> 0 Then GoTo loc_00601662
  loc_0060165E: If var_20 = 0 Then GoTo loc_0060166F
  loc_00601660: GoTo loc_006015F6
  loc_00601662: 'Referenced from: 00601657
  loc_0060166A: var_24 = var_20
  loc_0060166D: GoTo loc_00601691
  loc_0060166F: 
  loc_0060167B: GoTo loc_00601691
  loc_00601690: Exit Sub
  loc_00601691: 'Referenced from: 006015EE
End Sub