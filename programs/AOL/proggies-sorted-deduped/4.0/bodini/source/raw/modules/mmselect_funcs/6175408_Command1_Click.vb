Private Sub Command1_Click() '5E3AB0
  Dim var_3C As Variant
  loc_005E3B1F: var_eax = List1.Clear
  loc_005E3B7D: var_40 = mmoption.Option1.Value
  loc_005E3BA5: setz al
  loc_005E3BB5: If eax = 0 Then GoTo loc_005E3DA3
  loc_005E3BCB: var_ret_1 = "AOL Frame25"
  loc_005E3BCE: var_eax = FindWindow(var_ret_1, 0)
  loc_005E3BEA: var_20 = FindWindow(var_ret_1, 0)
  loc_005E3BFA: var_ret_2 = "MDICLIENT"
  loc_005E3C03: var_eax = FindWindowEx(var_20, 0, var_ret_2, 0)
  loc_005E3C13: var_24 = FindWindowEx(var_20, 0, var_ret_2, 0)
  loc_005E3C21: var_ret_3 = "Incoming/Saved Mail"
  loc_005E3C2D: var_ret_4 = "AOL Child"
  loc_005E3C36: var_eax = FindWindowEx(var_24, 0, var_ret_4, var_ret_3)
  loc_005E3C4D: var_1C = FindWindowEx(var_24, 0, var_ret_4, var_ret_3)
  loc_005E3C5E: If var_1C <> 0 Then GoTo loc_005E3C65
  loc_005E3C60: var_eax = call Proc_79_3_601A00(var_3C, Me, Me)
  loc_005E3C6B: call Proc_79_9_602BD0(GetLastError(), var_ret_5 = #StkVar1%StkVar2, var_38 = "")
  loc_005E3C78: var_28 = var_ret_5
  loc_005E3C86: var_eax = call Proc_6098C0(1, , )
  loc_005E3C8B: var_eax = call Proc_79_9_602BD0(, , )
  loc_005E3C9B: var_2C = call Proc_79_9_602BD0(, , )
  loc_005E3CA6: var_eax = call Proc_6098C0(1, , )
  loc_005E3CAB: var_eax = call Proc_79_9_602BD0(, , )
  loc_005E3CB2: var_ret_8 = call Proc_79_9_602BD0(, , )
  loc_005E3CC0: If var_28 <> 0 Then GoTo loc_005E3C65
  loc_005E3CC5: If var_2C <> 0 Then GoTo loc_005E3C65
  loc_005E3CC7: var_eax = call Proc_79_9_602BD0(, , )
  loc_005E3CD8: var_18 = CStr(call Proc_79_9_602BD0(, , ))
  loc_005E3CE9: var_ret_9 = "AOL Frame25"
  loc_005E3CEC: var_eax = FindWindow(var_ret_9, 0)
  loc_005E3CF9: var_20 = FindWindow(var_ret_9, 0)
  loc_005E3D0C: var_ret_A = "MDICLIENT"
  loc_005E3D15: var_eax = FindWindowEx(var_20, 0, var_ret_A, 0)
  loc_005E3D22: var_24 = FindWindowEx(var_20, 0, var_ret_A, 0)
  loc_005E3D33: var_ret_B = "Incoming/Saved Mail"
  loc_005E3D3F: var_ret_C = "AOL Child"
  loc_005E3D48: var_eax = FindWindowEx(var_24, 0, var_ret_C, var_ret_B)
  loc_005E3D71: var_eax = ShowWindow(FindWindowEx(var_24, 0, var_ret_C, var_ret_B), 6)
  loc_005E3D93: var_eax = call Proc_79_12_602F90(var_3C, var_3C, Me)
  loc_005E3DA1: GoTo loc_005E3DB5
  loc_005E3DA3: 'Referenced from: 005E3BB5
  loc_005E3DB5: 'Referenced from: 005E3DA1
  loc_005E3DF1: var_40 = mmoption.Option2.Value
  loc_005E3E1C: setz dl
  loc_005E3E2F: If var_50 = 0 Then GoTo loc_005E400A
  loc_005E3E40: var_ret_D = "AOL Frame25"
  loc_005E3E43: var_eax = FindWindow(var_ret_D, 0)
  loc_005E3E50: var_20 = FindWindow(var_ret_D, 0)
  loc_005E3E63: var_ret_E = "MDICLIENT"
  loc_005E3E6C: var_eax = FindWindowEx(var_20, 0, var_ret_E, 0)
  loc_005E3E79: var_24 = FindWindowEx(var_20, 0, var_ret_E, 0)
  loc_005E3E8A: var_ret_F = "Incoming/Saved Mail"
  loc_005E3E96: var_ret_10 = "AOL Child"
  loc_005E3E9F: var_eax = FindWindowEx(var_24, 0, var_ret_10, var_ret_F)
  loc_005E3EB6: var_1C = FindWindowEx(var_24, 0, var_ret_10, var_ret_F)
  loc_005E3EC7: If var_1C <> 0 Then GoTo loc_005E3ECE
  loc_005E3EC9: var_eax = call Proc_79_4_601D50(Me, , )
  loc_005E3ED4: var_eax = call Proc_79_11_602E50(, , )
  loc_005E3EE4: var_28 = call Proc_79_11_602E50(, , )
  loc_005E3EEF: var_eax = call Proc_6098C0(1, , )
  loc_005E3EF4: var_eax = call Proc_79_11_602E50(, , )
  loc_005E3F01: var_2C = call Proc_79_11_602E50(, , )
  loc_005E3F0F: var_eax = call Proc_6098C0(1, , )
  loc_005E3F14: var_eax = call Proc_79_11_602E50(, , )
  loc_005E3F1B: var_ret_13 = call Proc_79_11_602E50(, , )
  loc_005E3F29: If var_28 <> 0 Then GoTo loc_005E3ECE
  loc_005E3F2E: If var_2C <> 0 Then GoTo loc_005E3ECE
  loc_005E3F30: var_eax = call Proc_79_11_602E50(, , )
  loc_005E3F41: var_18 = CStr(call Proc_79_11_602E50(, , ))
  loc_005E3F52: var_ret_14 = "AOL Frame25"
  loc_005E3F55: var_eax = FindWindow(var_ret_14, 0)
  loc_005E3F65: var_20 = FindWindow(var_ret_14, 0)
  loc_005E3F75: var_ret_15 = "MDICLIENT"
  loc_005E3F7E: var_eax = FindWindowEx(var_20, 0, var_ret_15, 0)
  loc_005E3F8E: var_24 = FindWindowEx(var_20, 0, var_ret_15, 0)
  loc_005E3F9C: var_ret_16 = "Incoming/Saved Mail"
  loc_005E3FA8: var_ret_17 = "AOL Child"
  loc_005E3FB1: var_eax = FindWindowEx(var_24, 0, var_ret_17, var_ret_16)
  loc_005E3FDA: var_eax = ShowWindow(FindWindowEx(var_24, 0, var_ret_17, var_ret_16), 6)
  loc_005E3FFC: var_eax = call Proc_79_13_603360(var_3C, var_3C, Me)
  loc_005E400A: 'Referenced from: 005E3E2F
  loc_005E4046: var_40 = mmoption.Option3.Value
  loc_005E4071: setz dl
  loc_005E4084: If var_50 = 0 Then GoTo loc_005E425F
  loc_005E4095: var_ret_18 = "AOL Frame25"
  loc_005E4098: var_eax = FindWindow(var_ret_18, 0)
  loc_005E40A5: var_20 = FindWindow(var_ret_18, 0)
  loc_005E40B8: var_ret_19 = "MDICLIENT"
  loc_005E40C1: var_eax = FindWindowEx(var_20, 0, var_ret_19, 0)
  loc_005E40CE: var_24 = FindWindowEx(var_20, 0, var_ret_19, 0)
  loc_005E40DF: var_ret_1A = "Incoming/Saved Mail"
  loc_005E40EB: var_ret_1B = "AOL Child"
  loc_005E40F4: var_eax = FindWindowEx(var_24, 0, var_ret_1B, var_ret_1A)
  loc_005E410B: var_1C = FindWindowEx(var_24, 0, var_ret_1B, var_ret_1A)
  loc_005E411C: If var_1C <> 0 Then GoTo loc_005E4123
  loc_005E411E: var_eax = call Proc_79_5_6020A0(Me, , )
  loc_005E4129: var_eax = call Proc_79_10_602CE0(, , )
  loc_005E4139: var_28 = call Proc_79_10_602CE0(, , )
  loc_005E4144: var_eax = call Proc_6098C0(1, , )
  loc_005E4149: var_eax = call Proc_79_10_602CE0(, , )
  loc_005E4156: var_2C = call Proc_79_10_602CE0(, , )
  loc_005E4164: var_eax = call Proc_6098C0(1, , )
  loc_005E4169: var_eax = call Proc_79_10_602CE0(, , )
  loc_005E4170: var_ret_1E = call Proc_79_10_602CE0(, , )
  loc_005E417E: If var_28 <> 0 Then GoTo loc_005E4123
  loc_005E4183: If var_2C <> 0 Then GoTo loc_005E4123
  loc_005E4185: var_eax = call Proc_79_10_602CE0(, , )
  loc_005E4196: var_18 = CStr(call Proc_79_10_602CE0(, , ))
  loc_005E41A7: var_ret_1F = "AOL Frame25"
  loc_005E41AA: var_eax = FindWindow(var_ret_1F, 0)
  loc_005E41BA: var_20 = FindWindow(var_ret_1F, 0)
  loc_005E41CA: var_ret_20 = "MDICLIENT"
  loc_005E41D3: var_eax = FindWindowEx(var_20, 0, var_ret_20, 0)
  loc_005E41E3: var_24 = FindWindowEx(var_20, 0, var_ret_20, 0)
  loc_005E41F1: var_ret_21 = "Incoming/Saved Mail"
  loc_005E41FD: var_ret_22 = "AOL Child"
  loc_005E4206: var_eax = FindWindowEx(var_24, 0, var_ret_22, var_ret_21)
  loc_005E422F: var_eax = ShowWindow(FindWindowEx(var_24, 0, var_ret_22, var_ret_21), 6)
  loc_005E4251: var_eax = call Proc_79_14_603760(var_3C, var_3C, Me)
  loc_005E425F: 'Referenced from: 005E4084
  loc_005E429B: var_40 = mmoption.Option4.Value
  loc_005E42C6: setz dl
  loc_005E42D9: If var_50 = 0 Then GoTo loc_005E44AE
  loc_005E42EA: var_ret_23 = "AOL Frame25"
  loc_005E42ED: var_eax = FindWindow(var_ret_23, 0)
  loc_005E42FA: var_20 = FindWindow(var_ret_23, 0)
  loc_005E430D: var_ret_24 = "MDICLIENT"
  loc_005E4316: var_eax = FindWindowEx(var_20, 0, var_ret_24, 0)
  loc_005E4323: var_24 = FindWindowEx(var_20, 0, var_ret_24, 0)
  loc_005E4334: var_ret_25 = "Incoming/Saved Mail"
  loc_005E4340: var_ret_26 = "AOL Child"
  loc_005E4349: var_eax = FindWindowEx(var_24, 0, var_ret_26, var_ret_25)
  loc_005E4360: var_1C = FindWindowEx(var_24, 0, var_ret_26, var_ret_25)
  loc_005E4371: If var_1C <> 0 Then GoTo loc_005E4378
  loc_005E4373: var_eax = call Proc_79_2_6016B0(Me, , )
  loc_005E437E: var_eax = call Proc_79_6_6023F0(, , )
  loc_005E438E: var_28 = call Proc_79_6_6023F0(, , )
  loc_005E4399: var_eax = call Proc_6098C0(1, , )
  loc_005E439E: var_eax = call Proc_79_6_6023F0(, , )
  loc_005E43AB: var_2C = call Proc_79_6_6023F0(, , )
  loc_005E43B9: var_eax = call Proc_6098C0(1, , )
  loc_005E43BE: var_eax = call Proc_79_6_6023F0(, , )
  loc_005E43C5: var_ret_29 = call Proc_79_6_6023F0(, , )
  loc_005E43D3: If var_28 <> 0 Then GoTo loc_005E4378
  loc_005E43D8: If var_2C <> 0 Then GoTo loc_005E4378
  loc_005E43DA: var_eax = call Proc_79_6_6023F0(, , )
  loc_005E43EB: var_18 = CStr(call Proc_79_6_6023F0(, , ))
  loc_005E43FC: var_ret_2A = "AOL Frame25"
  loc_005E43FF: var_eax = FindWindow(var_ret_2A, 0)
  loc_005E440F: var_20 = FindWindow(var_ret_2A, 0)
  loc_005E441F: var_ret_2B = "MDICLIENT"
  loc_005E4428: var_eax = FindWindowEx(var_20, 0, var_ret_2B, 0)
  loc_005E4438: var_24 = FindWindowEx(var_20, 0, var_ret_2B, 0)
  loc_005E4446: var_ret_2C = "Incoming/Saved Mail"
  loc_005E4452: var_ret_2D = "AOL Child"
  loc_005E445B: var_eax = FindWindowEx(var_24, 0, var_ret_2D, var_ret_2C)
  loc_005E447E: var_eax = ShowWindow(FindWindowEx(var_24, 0, var_ret_2D, var_ret_2C), 6)
  loc_005E44A0: var_eax = call Proc_79_7_602540(var_3C, var_3C, Me)
  loc_005E44AE: 'Referenced from: 005E42D9
  loc_005E44BA: GoTo loc_005E44D9
  loc_005E44D8: Exit Sub
  loc_005E44D9: 'Referenced from: 005E44BA
End Sub