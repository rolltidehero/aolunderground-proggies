Private Sub Timer1_Timer() '5F7180
  loc_005F7210: var_ret_1 = "America Online Timer"
  loc_005F721C: var_ret_2 = "_AOL_Palette"
  loc_005F721F: var_eax = FindWindow(var_ret_2, var_ret_1)
  loc_005F7240: var_18 = FindWindow(var_ret_2, var_ret_1)
  loc_005F7256: var_ret_3 = "_AOL_Modal"
  loc_005F7259: var_eax = FindWindow(var_ret_3, 0)
  loc_005F7273: var_28 = FindWindow(var_ret_3, 0)
  loc_005F7286: var_ret_4 = "_AOL_Static"
  loc_005F728E: var_eax = FindWindowEx(var_28, esi, var_ret_4, 0)
  loc_005F72A5: var_24 = FindWindowEx(var_28, esi, var_ret_4, 0)
  loc_005F72BB: var_ret_5 = "_AOL_Icon"
  loc_005F72C3: var_eax = FindWindowEx(var_28, esi, var_ret_5, 0)
  loc_005F72DD: var_20 = FindWindowEx(var_28, esi, var_ret_5, 0)
  loc_005F72E9: If var_28 = 0 Then GoTo loc_005F74D5
  loc_005F72F2: If var_24 = 0 Then GoTo loc_005F74D5
  loc_005F72FB: If var_20 = 0 Then GoTo loc_005F74D5
  loc_005F7305: var_eax = call Proc_79_45_608BE0(var_28, , )
  loc_005F730F: var_2C = call Proc_79_45_608BE0(var_28, , )
  loc_005F7337: If (var_2C <> vbNullString) <> 0 Then GoTo loc_005F75CD
  loc_005F7341: var_eax = call Proc_79_45_608BE0(var_24, , )
  loc_005F734C: var_40 = call Proc_79_45_608BE0(var_24, , )
  loc_005F735E: var_58 = Ucase(call Proc_79_45_608BE0(var_24, , ))
  loc_005F738B: var_78 = Ucase("You have been idle")
  loc_005F73AF: call InStr(var_88, esi, var_78, var_58, 00000001h)
  loc_005F73EB: If (InStr(var_88, esi, var_78, var_58, 00000001h) <> "") <> 0 Then GoTo loc_005F75CD
  loc_005F73F5: var_eax = call Proc_608D20(var_20, , )
  loc_005F7410: var_C8 = call Proc_608D20(var_20, , )
  loc_005F742F: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005F746F: call __vbaStrR8
  loc_005F747A: var_30 = __vbaStrR8
  loc_005F7494: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005F74D5: 'Referenced from: 005F72E9
  loc_005F74D8: If var_18 = 0 Then GoTo loc_005F75CD
  loc_005F74E8: var_ret_6 = "_AOL_Icon"
  loc_005F74F0: var_eax = FindWindowEx(var_18, esi, var_ret_6, 0)
  loc_005F750D: var_eax = call Proc_608D20(FindWindowEx(var_18, esi, var_ret_6, 0), , )
  loc_005F7545: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005F757F: call __vbaStrR8
  loc_005F758A: var_30 = __vbaStrR8
  loc_005F7592: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005F75CD: 'Referenced from: 005F74D8
  loc_005F75D6: GoTo loc_005F7622
  loc_005F7621: Exit Sub
  loc_005F7622: 'Referenced from: 005F75D6
  loc_005F7622: Exit Sub
End Sub