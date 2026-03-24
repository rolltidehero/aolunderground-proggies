ï»¿Private Sub Timer2_Timer() '5FC380
  Dim var_40 As ListBox
  loc_005FC40E: var_ret_1 = "AOL Frame25"
  loc_005FC411: var_eax = FindWindow(var_ret_1, 0)
  loc_005FC431: var_28 = FindWindow(var_ret_1, 0)
  loc_005FC444: var_ret_3 = "MDIClient"
  loc_005FC44D: var_eax = FindWindowEx(var_28, esi, var_ret_3, 0)
  loc_005FC465: var_2C = FindWindowEx(var_28, esi, var_ret_3, 0)
  loc_005FC471: var_78 = "  Instant Message To: "
  loc_005FC4A0: var_24 = CInt(var_34)
  loc_005FC4A6: var_E4 = var_24
  loc_005FC4BA: var_40 = List1.List(var_24)
  loc_005FC4E6: var_48 = var_34
  loc_005FC518: var_ret_5 = CStr("  Instant Message To: " & LCase(var_34))
  loc_005FC526: var_eax = FindWindowEx(var_2C, esi, esi, var_ret_5)
  loc_005FC53B: var_30 = FindWindowEx(var_2C, esi, esi, var_ret_5)
  loc_005FC5A1: var_A4 = List1.ListCount
  loc_005FC5C9: var_A4 = var_A4 - 0001h
  loc_005FC5D9: var_88 = var_A4
  loc_005FC612: For var_24 = "" To var_A4 Step 1
  loc_005FC627: If var_24 = 0 Then GoTo loc_005FC668
  loc_005FC62F: If var_30 = 0 Then GoTo loc_005FC650
  loc_005FC645: var_eax = SendMessage(var_30, 16, esi, var_A4)
  loc_005FC650: 'Referenced from: 005FC62F
  loc_005FC662: Next var_24
  loc_005FC666: GoTo loc_005FC625
  loc_005FC668: 'Referenced from: 005FC627
  loc_005FC670: GoTo loc_005FC6AA
  loc_005FC6A9: Exit Sub
  loc_005FC6AA: 'Referenced from: 005FC670
  loc_005FC6CC: Exit Sub
End Sub