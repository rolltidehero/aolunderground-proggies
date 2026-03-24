Private Sub Timer3_Timer() '5D1830
  Dim var_13C As Variant
  Dim var_2E4 As Variant
  Dim var_2EC As Variant
  Dim var_2F4 As Variant
  Dim var_2DC As ListBox
  Dim var_140 As TextBox
  Dim var_154 As ListBox
  Dim var_164 As TextBox
  Dim var_120 As ListBox
  Dim var_0060C640 As TextBox
  loc_005D1A00: var_2DC = Timer3.Interval
  loc_005D1A28: setz bl
  loc_005D1A36: If ebx <> 0 Then GoTo loc_005D7803
  loc_005D1A61: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005D1A97: ebx = (var_120 = "off") + 1
  loc_005D1AAF: If (var_120 = "off") + 1 = 0 Then GoTo loc_005D1B4D
  loc_005D1AB5: 
  loc_005D1ACE: var_eax = call Proc_6098C0(CLng(0.5), Me, var_120)
  loc_005D1AF8: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005D1B47: If (var_120 <> "on") <> 0 Then GoTo loc_005D1AB5
  loc_005D1B4D: 'Referenced from: 005D1AAF
  loc_005D1B6C: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005D1BA2: ebx = (var_120 = "60") + 1
  loc_005D1BBA: If (var_120 = "60") + 1 = 0 Then GoTo loc_005D228B
  loc_005D1BC0: var_eax = call Proc_79_47_609590(var_13C, var_120, var_13C)
  loc_005D1BDE: var_60 = call Proc_79_47_609590(var_13C, var_120, var_13C)
  loc_005D1C01: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005D1C44: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005D1C9A: var_128 = "•bodini 4.0• server •" & var_120 & " mail(s)•"
  loc_005D1CDA: var_eax = call Proc_3_4_5A51B0(var_164, var_FC, 3)
  loc_005D1D51: var_120 = "<font face=""tahoma"">" & var_164
  loc_005D1D6C: var_eax = call Proc_79_17_604A50(var_120 & vbNullString, var_120, var_13C)
  loc_005D1DA3: var_eax = call Proc_6098C0(CLng(0.7), var_0042E980, var_13C)
  loc_005D1DA8: var_eax = call Proc_79_47_609590(var_60, , )
  loc_005D1DAD: var_14C = call Proc_79_47_609590(var_60, , )
  loc_005D1E01: var_27C = "•type• ""/"
  loc_005D1E0B: var_28C = " send list"" • - list•"
  loc_005D1E3F: var_120 = "•type• ""/" + LCase(call Proc_79_47_609590(var_60, , )) + " send list"" • - list•"
  loc_005D1E7F: var_eax = call Proc_3_4_5A51B0(var_1A4, var_FC, 3)
  loc_005D1EF2: var_120 = "<font face=""tahoma"">" & var_1A4
  loc_005D1F0D: var_eax = call Proc_79_17_604A50(var_120 & vbNullString, var_FC, var_120)
  loc_005D1F44: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005D1F49: var_eax = call Proc_79_47_609590(, , )
  loc_005D1F4E: var_14C = call Proc_79_47_609590(, , )
  loc_005D1FA2: var_27C = "•type• ""/"
  loc_005D1FAC: var_28C = " send x"" • - index•"
  loc_005D1FE0: var_120 = "•type• ""/" + LCase(call Proc_79_47_609590(, , )) + " send x"" • - index•"
  loc_005D2020: var_eax = call Proc_3_4_5A51B0(var_1A4, var_FC, 3)
  loc_005D2093: var_120 = "<font face=""tahoma"">" & var_1A4
  loc_005D20AE: var_eax = call Proc_79_17_604A50(var_120 & vbNullString, var_FC, var_120)
  loc_005D20E5: var_eax = call Proc_6098C0(CLng(0.7), , )
  loc_005D20EA: var_eax = call Proc_79_47_609590(, , )
  loc_005D20FD: var_14C = call Proc_79_47_609590(, , )
  loc_005D210D: var_164 = LCase(call Proc_79_47_609590(, , ))
  loc_005D2143: var_27C = "•type• ""/"
  loc_005D214D: var_28C = " find x"" • - query•"
  loc_005D2181: var_120 = "•type• ""/" + var_164 + " find x"" • - query•"
  loc_005D21C1: var_eax = call Proc_3_4_5A51B0(var_1A4, var_FC, 3)
  loc_005D2234: var_120 = "<font face=""tahoma"">" & var_1A4
  loc_005D224F: var_eax = call Proc_79_17_604A50(var_120 & vbNullString, var_FC, var_120)
  loc_005D227E: var_eax = call Proc_6098C0(1, , )
  loc_005D2289: GoTo loc_005D2291
  loc_005D228B: 'Referenced from: 005D1BBA
  loc_005D2291: 'Referenced from: 005D2289
  loc_005D22B0: var_2D8 = List1.ListCount
  loc_005D22DD: setz al
  loc_005D22EE: If eax <> 0 Then GoTo loc_005D7803
  loc_005D2317: var_2DC = Timer3.Interval
  loc_005D2339: setz dl
  loc_005D2350: If edx <> 0 Then GoTo loc_005D7803
  loc_005D237B: var_120 = List1.List(0)
  loc_005D23D4: If InStr(1, var_120, var_00431C88, 0) = 0 Then GoTo loc_005D3B58
  loc_005D23FF: var_120 = List1.List(0)
  loc_005D2449: var_D8 = var_120
  loc_005D24D6: call InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_174, var_13C, Me, Me, var_13C, InStr(1, var_120, var_00431C88, 0), Me, var_13C, Me, Me, var_13C)
  loc_005D24F2: var_ret_1 = CLng(InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_174, var_13C, Me, Me, var_13C, InStr(1, var_120, var_00431C88, 0), Me, var_13C, Me, Me, var_13C) + 1)
  loc_005D2523: var_3C4 = esi
  loc_005D2537: Text2.Text = CStr(Mid(var_D8, var_ret_1, ))
  loc_005D25C6: var_2E4 = var_13C
  loc_005D25F4: call InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_13C, var_164, Me)
  loc_005D2609: var_ret_2 = InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_13C, var_164, Me) - 1
  loc_005D264A: var_120 = CStr(Mid(var_D8, 1, var_ret_2))
  loc_005D265A: Text3.Text = var_120
  loc_005D26D7: Text6.Text = vbNullString
  loc_005D271D: var_eax = List4.Clear
  loc_005D27A1: var_164 = LCase(Me)
  loc_005D27C4: var_17C = var_164
  loc_005D27E2: var_194 = LCase(var_164)
  loc_005D284A: var_120 = CStr(var_164 + &H431C88 + var_194)
  loc_005D285A: Text2.OLEDragMode = var_120
  loc_005D28FC: var_2D8 = List3.ListCount
  loc_005D2926: var_2D8 = var_2D8 - 0001h
  loc_005D2942: var_28C = var_2D8
  loc_005D2977: For var_10C = 0 To var_2D8 Step 1
  loc_005D298B: 
  loc_005D298D: If var_308 = 0 Then GoTo loc_005D2D98
  loc_005D29C6: var_10C = CInt(var_120)
  loc_005D29CC: var_3D0 = var_10C
  loc_005D29E0: var_13C = List3.List(var_10C)
  loc_005D2A1C: var_14C = var_120
  loc_005D2A2C: var_164 = LCase(var_120)
  loc_005D2A55: var_124 = Text2.Text
  loc_005D2A8F: var_128 = var_004342C4 & var_124
  loc_005D2A99: var_16C = var_128 & var_004342C4
  loc_005D2AB7: var_184 = LCase(var_128 & var_004342C4)
  loc_005D2AD2: call __vbaVarLikeVar(var_194, var_184, var_164, var_140, Me, Me, DoEvents, Me, var_13C, Me, Me, var_288)
  loc_005D2B38: If CBool(__vbaVarLikeVar(var_194, var_184, var_164, var_140, Me, Me, DoEvents, Me, var_13C, Me, Me, var_288)) = 0 Then GoTo loc_005D2D76
  loc_005D2B96: var_eax = List4.AddItem "search found!", var_278
  loc_005D2BDF: var_2F4 = DoEvents
  loc_005D2C04: var_120 = Text6.Text
  loc_005D2C4F: var_10C = CInt(var_130)
  loc_005D2C5F: var_140 = List3.List(var_10C)
  loc_005D2CE9: var_138 = var_120 & Chr$(13) & Chr$(10) & var_130
  loc_005D2CEB: var_3D8 = var_138
  loc_005D2CFF: List3.FontName = var_138
  loc_005D2D76: 'Referenced from: 005D2B38
  loc_005D2D8B: Next var_10C
  loc_005D2D93: GoTo loc_005D298B
  loc_005D2D98: 'Referenced from: 005D298D
  loc_005D2DBB: var_120 = Text6.Text
  loc_005D2DF7: esi = (var_120 = vbNullString) + 1
  loc_005D2E12: If (var_120 = vbNullString) + 1 = 0 Then GoTo loc_005D2FF7
  loc_005D2E24: var_14C = (var_120 = vbNullString)
  loc_005D2E42: var_164 = LCase((var_120 = vbNullString))
  loc_005D2E4D: var_18C = var_164
  loc_005D2EB3: var_28C = "• "
  loc_005D2EBD: var_29C = " •not found•"
  loc_005D2F0D: var_120 = &H42EC60 & var_164 & "• " & LCase(var_164) & " •not found•"
  loc_005D2F4D: var_eax = call Proc_3_4_5A51B0(var_1E4, var_FC, 3)
  loc_005D2FC2: 
  loc_005D2FF2: GoTo loc_005D7254
  loc_005D300D: var_2EC = "<font face=""tahoma"">" & var_1E4 & vbNullString
  loc_005D3032: var_2D8 = List4.ListCount
  loc_005D306D: var_120 = CStr(var_2D8)
  loc_005D3083: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005D30EF: var_128 = Text3.Text
  loc_005D3130: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005D3157: var_14C = Unknown_VTable_Call[eax+00000050h]
  loc_005D3175: var_164 = LCase(Unknown_VTable_Call[eax+00000050h])
  loc_005D317A: var_28C = "<font face=""tahoma""><font color=""#FF8080""><b>•bodini 4.0• server •spek•<p>•find results• for •"
  loc_005D3194: var_19C = var_164
  loc_005D31B2: var_1B4 = LCase(var_164)
  loc_005D31B7: var_29C = "•<p>"
  loc_005D31D1: var_1CC = var_1B4
  loc_005D3232: var_204 = "<font face=""tahoma""><font color=""#FF8080""><b>•bodini 4.0• server •spek•<p>•find results• for •" & var_1B4 & "•<p>" + LCase(var_1B4)
  loc_005D325F: var_124 = "•bodini 4.0• " & var_120
  loc_005D326D: var_16C = var_124 & " finds for •"
  loc_005D32F4: var_eax = call Proc_79_15_603B90(0, var_124 & " finds for •" & var_164 & &H42EC60, var_204)
  loc_005D33B3: var_ret_3 = "AOL Frame25"
  loc_005D33B6: var_eax = FindWindow(var_ret_3, 0)
  loc_005D33D3: var_50 = FindWindow(var_ret_3, 0)
  loc_005D33EA: var_ret_4 = "MDICLIENT"
  loc_005D33F3: var_eax = FindWindowEx(var_50, 0, var_ret_4, 0)
  loc_005D3410: var_90 = FindWindowEx(var_50, 0, var_ret_4, 0)
  loc_005D3428: var_ret_5 = "Write Mail"
  loc_005D3437: var_ret_6 = "AOL Child"
  loc_005D3443: var_eax = FindWindowEx(var_90, 0, var_ret_6, var_ret_5)
  loc_005D346A: var_AC = FindWindowEx(var_90, 0, var_ret_6, var_ret_5)
  loc_005D348D: var_ret_7 = "AOL Frame25"
  loc_005D3490: var_eax = FindWindow(var_ret_7, 0)
  loc_005D34A7: var_50 = FindWindow(var_ret_7, 0)
  loc_005D34C4: var_ret_8 = "MDICLIENT"
  loc_005D34CD: var_eax = FindWindowEx(var_50, 0, var_ret_8, 0)
  loc_005D34E4: var_90 = FindWindowEx(var_50, 0, var_ret_8, 0)
  loc_005D3502: var_ret_9 = "Error"
  loc_005D3511: var_ret_A = "AOL Child"
  loc_005D351D: var_eax = FindWindowEx(var_90, 0, var_ret_A, var_ret_9)
  loc_005D3544: var_30 = FindWindowEx(var_90, 0, var_ret_A, var_ret_9)
  loc_005D3555: If var_30 <> 0 Then GoTo loc_005D356A
  loc_005D355F: If var_AC = 0 Then GoTo loc_005D3840
  loc_005D3565: GoTo loc_005D339F
  loc_005D356A: 'Referenced from: 005D3555
  loc_005D3576: var_ret_B = "America Online"
  loc_005D3585: var_ret_C = "#32770"
  loc_005D3588: var_eax = FindWindow(var_ret_C, var_ret_B)
  loc_005D35AF: var_44 = FindWindow(var_ret_C, var_ret_B)
  loc_005D35C7: var_ret_D = "OK"
  loc_005D35D6: var_ret_E = "Button"
  loc_005D35DF: var_eax = FindWindowEx(var_44, 0, var_ret_E, var_ret_D)
  loc_005D361C: var_eax = call Proc_608D20(FindWindowEx(var_44, 0, var_ret_E, var_ret_D), , )
  loc_005D362F: var_ret_F = "AOL Frame25"
  loc_005D3632: var_eax = FindWindow(var_ret_F, 0)
  loc_005D364F: var_50 = FindWindow(var_ret_F, 0)
  loc_005D3666: var_ret_10 = "MDICLIENT"
  loc_005D366F: var_eax = FindWindowEx(var_50, 0, var_ret_10, 0)
  loc_005D368C: var_90 = FindWindowEx(var_50, 0, var_ret_10, 0)
  loc_005D36A4: var_ret_11 = "Error"
  loc_005D36B3: var_ret_12 = "AOL Child"
  loc_005D36BF: var_eax = FindWindowEx(var_90, 0, var_ret_12, var_ret_11)
  loc_005D36F6: var_eax = call Proc_608D70(FindWindowEx(var_90, 0, var_ret_12, var_ret_11), , )
  loc_005D3702: var_eax = call Proc_608D70(var_AC, , )
  loc_005D372E: var_164 = LCase(Me)
  loc_005D3774: var_28C = "• find results •can't be sent•"
  loc_005D37A2: var_120 = &H42EC60 & var_164 & "• find results •can't be sent•"
  loc_005D37E2: var_eax = call Proc_3_4_5A51B0(var_1A4, var_FC, 3)
  loc_005D37F8: var_110 = var_164
  loc_005D383B: GoTo loc_005D2FC2
  loc_005D384F: var_14C = DoEvents
  loc_005D386D: var_164 = LCase(DoEvents)
  loc_005D389A: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005D38C1: var_1BC = Unknown_VTable_Call[ecx+00000050h]
  loc_005D38FE: var_18C = var_120
  loc_005D3941: var_28C = "• "
  loc_005D394B: var_29C = " results for "
  loc_005D3955: var_2AC = " •sent•"
  loc_005D39DD: var_124 = &H42EC60 & var_164 & "• " & var_120 & " results for " & LCase(Unknown_VTable_Call[ecx+00000050h]) & " •sent•"
  loc_005D3A1D: var_eax = call Proc_3_4_5A51B0(var_214, var_FC, 3)
  loc_005D3AF0: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_214 & vbNullString, var_FC, "<font face=""tahoma"">" & var_214 & vbNullString)
  loc_005D3B2C: var_eax = List1.RemoveItem 0
  loc_005D3B81: var_2DC = Timer3.Interval
  loc_005D3BA3: setz bl
  loc_005D3BB7: If ebx <> 0 Then GoTo loc_005D7803
  loc_005D3BE2: var_120 = List1.List(0)
  loc_005D3C3B: If InStr(1, var_120, "-list", 0) = 0 Then GoTo loc_005D5442
  loc_005D3C66: var_120 = List1.List(0)
  loc_005D3CB0: var_D8 = var_120
  loc_005D3CFB: var_2E4 = var_D8
  loc_005D3D3D: call InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_174, var_13C, var_D8, Me, var_13C, Me, Me, var_13C, var_2DC, Me, var_13C)
  loc_005D3D59: var_ret_13 = CLng(InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_174, var_13C, var_D8, Me, var_13C, Me, Me, var_13C, var_2DC, Me, var_13C) + 1)
  loc_005D3D84: var_120 = CStr(Mid(var_D8, var_ret_13, ))
  loc_005D3D94: Text2.Text = var_120
  loc_005D3E51: call InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_13C, Me, Me)
  loc_005D3EAD: var_3E4 = ebx
  loc_005D3EC1: Text3.Text = CStr(Mid(var_D8, 1, InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_13C, Me, Me) - 1))
  loc_005D3F40: var_2E4 = DoEvents
  loc_005D3F46: var_2D8 = List3.ListCount
  loc_005D3F71: var_3E8 = var_2D8
  loc_005D3F90: If var_60C000 <> 0 Then GoTo loc_005D3F9A
  loc_005D3F98: GoTo loc_005D3FAB
  loc_005D3F9A: 'Referenced from: 005D3F90
  loc_005D3FAB: 'Referenced from: 005D3F98
  loc_005D404B: For var_A8 = 1 To Int((var_3F0 / 500)) Step 1
  loc_005D4051: 
  loc_005D4053: If var_338 = 0 Then GoTo loc_005D528C
  loc_005D4080: Multiple2.Text = vbNullString
  loc_005D40F8: var_124 = CStr(var_A8 * 500)
  loc_005D41A3: For var_C8 = (Val(CStr(var_A8 * 500)) - 499#) To Val(var_124) Step 1
  loc_005D41B9: var_398 = var_C8
  loc_005D41C8: 
  loc_005D41D0: If var_398 = 0 Then GoTo loc_005D4509
  loc_005D41FF: var_2D8 = List3.ListCount
  loc_005D4231: var_120 = CStr(var_C8)
  loc_005D4262: var_3F4 = var_2D8 + 0001h
  loc_005D4274: fcomp real8 ptr var_3FC
  loc_005D42AE: If var_400 <> 0 Then GoTo loc_005D4509
  loc_005D42C7: var_2F4 = var_400
  loc_005D42F0: var_120 = Multiple2.Text
  loc_005D435F: var_ret_18 = var_C8 - 1
  loc_005D4366: var_ret_18 = CInt(var_124)
  loc_005D436C: var_404 = var_ret_18
  loc_005D4380: var_140 = List3.List(var_ret_18)
  loc_005D43BA: var_128 = var_120 & vbNullString
  loc_005D43D0: var_16C = var_128 & var_124
  loc_005D4436: var_12C = CStr(var_128 & var_124 & Chr(13) & Chr(10))
  loc_005D443C: var_408 = var_12C
  loc_005D4450: List3.FontName = var_12C
  loc_005D44F2: Next var_C8
  loc_005D44FE: var_398 = Next var_C8
  loc_005D4504: GoTo loc_005D41C8
  loc_005D4522: var_2EC = DoEvents
  loc_005D454B: var_120 = Multiple2.Text
  loc_005D457F: Multiple2.Text = var_120
  loc_005D45E9: Multiple2.Text = vbNullString
  loc_005D4655: var_120 = Multiple2.Text
  loc_005D4698: var_124 = Multiple1.Text
  loc_005D46DA: var_128 = var_120 & var_124
  loc_005D46E0: var_40C = var_128
  loc_005D46F4: Multiple1.Text = var_128
  loc_005D4770: Multiple1.Text = vbNullString
  loc_005D47BD: var_120 = Text3.Text
  loc_005D47E7: var_14C = var_120
  loc_005D4811: var_29C = "<font face=""tahoma""><font color=""#FF8080""><b>•bodini 4.0• server •spek•<p>•type• /"
  loc_005D4825: var_eax = call Proc_79_47_609590(var_13C, var_13C, Me)
  loc_005D4838: var_18C = call Proc_79_47_609590(var_13C, var_13C, Me)
  loc_005D484A: var_2AC = " send list • - list•<p>•type• /"
  loc_005D485E: var_eax = call Proc_79_47_609590(var_13C, var_13C, Me)
  loc_005D4863: var_1CC = call Proc_79_47_609590(var_13C, var_13C, Me)
  loc_005D4883: var_2BC = " send x • - index•<p>•type• /"
  loc_005D4897: var_eax = call Proc_79_47_609590(Me, var_13C, var_13C)
  loc_005D489C: var_20C = call Proc_79_47_609590(Me, var_13C, var_13C)
  loc_005D48BA: var_224 = LCase(call Proc_79_47_609590(Me, var_13C, var_13C))
  loc_005D48BF: var_2CC = " find x • - query•<p><p>"
  loc_005D48D9: var_23C = var_224
  loc_005D4914: var_1B4 = "<font face=""tahoma""><font color=""#FF8080""><b>•bodini 4.0• server •spek•<p>•type• /" & LCase(call Proc_79_47_609590(var_13C, var_13C, Me))
  loc_005D4925: var_1C4 = var_1B4 & " send list • - list•<p>•type• /"
  loc_005D4947: var_204 = var_1C4 & LCase(call Proc_79_47_609590(var_13C, var_13C, Me)) & " send x • - index•<p>•type• /"
  loc_005D498F: var_12C = var_204 & var_224 & " find x • - query•<p><p>" + LCase(var_224)
  loc_005D49BB: var_27C = "•bodini 4.0• server • list "
  loc_005D4A25: var_eax = call Proc_79_15_603B90(LCase(0), "•bodini 4.0• server • list " & var_A8 & &H42EC60, var_12C)
  loc_005D4B00: var_ret_19 = "AOL Frame25"
  loc_005D4B03: var_eax = FindWindow(var_ret_19, 0)
  loc_005D4B1C: var_50 = FindWindow(var_ret_19, 0)
  loc_005D4B33: var_ret_1A = "MDICLIENT"
  loc_005D4B3C: var_eax = FindWindowEx(var_50, 0, var_ret_1A, 0)
  loc_005D4B55: var_90 = FindWindowEx(var_50, 0, var_ret_1A, 0)
  loc_005D4B6D: var_ret_1B = "Write Mail"
  loc_005D4B7C: var_ret_1C = "AOL Child"
  loc_005D4B88: var_eax = FindWindowEx(var_90, 0, var_ret_1C, var_ret_1B)
  loc_005D4BAB: var_AC = FindWindowEx(var_90, 0, var_ret_1C, var_ret_1B)
  loc_005D4BC6: var_ret_1D = "Send To:"
  loc_005D4BD5: var_ret_1E = "_AOL_Static"
  loc_005D4BE1: var_eax = FindWindowEx(var_AC, 0, var_ret_1E, var_ret_1D)
  loc_005D4BE6: var_2DC = FindWindowEx(var_AC, 0, var_ret_1E, var_ret_1D)
  loc_005D4C1B: var_ret_1F = "AOL Frame25"
  loc_005D4C1E: var_eax = FindWindow(var_ret_1F, 0)
  loc_005D4C31: var_50 = FindWindow(var_ret_1F, 0)
  loc_005D4C4E: var_ret_20 = "MDICLIENT"
  loc_005D4C57: var_eax = FindWindowEx(var_50, 0, var_ret_20, 0)
  loc_005D4C6A: var_90 = FindWindowEx(var_50, 0, var_ret_20, 0)
  loc_005D4C88: var_ret_21 = "Error"
  loc_005D4C97: var_ret_22 = "AOL Child"
  loc_005D4CA3: var_eax = FindWindowEx(var_90, 0, var_ret_22, var_ret_21)
  loc_005D4CC6: var_30 = FindWindowEx(var_90, 0, var_ret_22, var_ret_21)
  loc_005D4CD7: If var_30 <> 0 Then GoTo loc_005D4F3A
  loc_005D4CE5: If var_AC <> 0 Then GoTo loc_005D4AEC
  loc_005D4D14: var_120 = Text3.Text
  loc_005D4D3E: var_14C = var_120
  loc_005D4DA8: var_28C = "• list "
  loc_005D4DB2: var_29C = " • sent•"
  loc_005D4E06: var_124 = &H42EC60 & LCase(0) & "• list " & var_A8 & " • sent•"
  loc_005D4E46: var_eax = call Proc_3_4_5A51B0(var_1C4, var_FC, 3)
  loc_005D4EF6: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_1C4 & vbNullString, var_FC, "<font face=""tahoma"">" & var_1C4 & vbNullString)
  loc_005D4F29: Next var_A8
  loc_005D4F35: GoTo loc_005D4051
  loc_005D4F3A: 'Referenced from: 005D4CD7
  loc_005D4F46: var_ret_23 = "America Online"
  loc_005D4F55: var_ret_24 = "#32770"
  loc_005D4F58: var_eax = FindWindow(var_ret_24, var_ret_23)
  loc_005D4F7B: var_44 = FindWindow(var_ret_24, var_ret_23)
  loc_005D4F93: var_ret_25 = "OK"
  loc_005D4FA2: var_ret_26 = "Button"
  loc_005D4FAB: var_eax = FindWindowEx(var_44, 0, var_ret_26, var_ret_25)
  loc_005D4FE4: var_eax = call Proc_608D20(FindWindowEx(var_44, 0, var_ret_26, var_ret_25), , )
  loc_005D4FF7: var_ret_27 = "AOL Frame25"
  loc_005D4FFA: var_eax = FindWindow(var_ret_27, 0)
  loc_005D500D: var_50 = FindWindow(var_ret_27, 0)
  loc_005D502A: var_ret_28 = "MDICLIENT"
  loc_005D5033: var_eax = FindWindowEx(var_50, 0, var_ret_28, 0)
  loc_005D5046: var_90 = FindWindowEx(var_50, 0, var_ret_28, 0)
  loc_005D5064: var_ret_29 = "Error"
  loc_005D5073: var_ret_2A = "AOL Child"
  loc_005D507F: var_eax = FindWindowEx(var_90, 0, var_ret_2A, var_ret_29)
  loc_005D50B2: var_eax = call Proc_608D70(FindWindowEx(var_90, 0, var_ret_2A, var_ret_29), , )
  loc_005D50BE: var_eax = call Proc_608D70(var_AC, , )
  loc_005D50E6: var_120 = Text3.Text
  loc_005D5110: var_14C = var_120
  loc_005D5174: var_28C = "• list "
  loc_005D517E: var_29C = " • can't be sent•"
  loc_005D51D4: var_124 = &H42EC60 & LCase(var_120) & "• list " & var_A8 & " • can't be sent•"
  loc_005D5214: var_eax = call Proc_3_4_5A51B0(var_1C4, var_FC, 3)
  loc_005D522A: var_110 = var_1C4
  loc_005D5287: GoTo loc_005D6E07
  loc_005D528C: 'Referenced from: 005D4053
  loc_005D52C4: var_14C = var_13C
  loc_005D52F7: var_27C = "-list"
  loc_005D5349: var_120 = CStr(LCase(var_13C) + "-list")
  loc_005D5359: Text3.OLEDragMode = var_120
  loc_005D53CD: var_eax = List1.RemoveItem 0
  loc_005D5418: Multiple2.Text = vbNullString
  loc_005D5442: 'Referenced from: 005D3C3B
  loc_005D5465: var_2DC = Timer3.Interval
  loc_005D5487: setz bl
  loc_005D549B: If ebx <> 0 Then GoTo loc_005D7803
  loc_005D54C6: var_120 = List1.List(0)
  loc_005D551F: If InStr(1, var_120, var_00431364, 0) = 0 Then GoTo loc_005D7803
  loc_005D554A: var_120 = List1.List(0)
  loc_005D5594: var_D8 = var_120
  loc_005D55DF: var_2E4 = var_D8
  loc_005D5621: call InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_174, var_13C, var_D8, Me, var_13C, Me, Me, var_13C, var_2DC, Me, var_13C)
  loc_005D563D: var_ret_2B = CLng(InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_174, var_13C, var_D8, Me, var_13C, Me, Me, var_13C, var_2DC, Me, var_13C) + 1)
  loc_005D5668: var_120 = CStr(Mid(var_D8, var_ret_2B, ))
  loc_005D5678: Text2.Text = var_120
  loc_005D5735: call InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_13C, Me, Me)
  loc_005D5791: var_418 = ebx
  loc_005D57A5: Text3.Text = CStr(Mid(var_D8, 1, InStr(var_154, 00000000h, var_284, var_D8, 00000001h, var_13C, Me, Me) - 1))
  loc_005D5820: var_120 = List1.List(0)
  loc_005D5879: If InStr(1, var_120, "-list", 0) <> 0 Then GoTo loc_005D7803
  loc_005D58A2: var_120 = Text2.Text
  loc_005D58DE: ebx = (var_120 = vbNullString) + 1
  loc_005D58F6: If (var_120 <> vbNullString) + 1 <> 0 Then GoTo loc_005D7803
  loc_005D590A: var_13C = var_120
  loc_005D590D: var_eax = FindWindow(var_13C, var_120)
  loc_005D592C: var_50 = FindWindow(var_13C, var_120)
  loc_005D5943: var_120 = var_120
  loc_005D594C: var_eax = FindWindowEx(var_50, 0, var_120, var_120)
  loc_005D5965: var_90 = FindWindowEx(var_50, 0, var_120, var_120)
  loc_005D597D: var_124 = var_50
  loc_005D598C: ecx = var_120
  loc_005D5998: var_eax = FindWindowEx(var_90, 0, var_124, var_120)
  loc_005D59BB: var_78 = FindWindowEx(var_90, 0, var_124, var_120)
  loc_005D59D5: var_120 = var_124
  loc_005D59DE: var_eax = FindWindowEx(var_78, 0, var_120, var_120)
  loc_005D59F7: var_EC = FindWindowEx(var_78, 0, var_120, var_120)
  loc_005D5A22: var_eax = SendMessage(var_EC, 395, 0, 0)
  loc_005D5A50: var_120 = Text2.Text
  loc_005D5AB5: var_eax = SendMessage(var_EC, 390, CLng((var_120 - 1)), 0)
  loc_005D5AE4: var_eax = PostMessage(var_EC, 256, 13, 0)
  loc_005D5AFB: var_eax = PostMessage(var_EC, 257, 13, 0)
  loc_005D5B13: var_eax = call Proc_6098C0(1, var_13C, Me)
  loc_005D5B24: var_EC = vbNull
  loc_005D5B33: var_120 = vbNull
  loc_005D5B36: var_eax = FindWindow(var_120, var_120)
  loc_005D5B59: var_20 = FindWindow(var_120, var_120)
  loc_005D5B73: var_120 = var_120
  loc_005D5B7C: var_eax = FindWindowEx(var_20, 0, var_120, var_120)
  loc_005D5B8F: var_1C = FindWindowEx(var_20, 0, var_120, var_120)
  loc_005D5BAC: var_120 = var_120
  loc_005D5BB7: var_eax = FindWindowEx(var_20, var_1C, var_120, var_120)
  loc_005D5BD0: var_B8 = FindWindowEx(var_20, var_1C, var_120, var_120)
  loc_005D5BE1: If var_20 = 0 Then GoTo loc_005D5E1C
  loc_005D5BF0: var_eax = call Proc_79_45_608BE0(var_B8, 1, "Static")
  loc_005D5BFD: var_120 = call Proc_79_45_608BE0(var_B8, 1, "Static")
  loc_005D5C1F: var_2E4 = InStr(0, var_120, "That mail is no longer available or is not accessible to this account.", 0)
  loc_005D5C34: If var_2E4 = 0 Then GoTo loc_005D5E1C
  loc_005D5C46: var_124 = call Proc_79_45_608BE0(var_B8, 1, "Static")
  loc_005D5C55: ecx = var_120
  loc_005D5C58: var_eax = FindWindow(var_124, var_120)
  loc_005D5C7B: var_20 = FindWindow(var_124, var_120)
  loc_005D5C95: var_124 = var_120
  loc_005D5C9E: var_eax = FindWindowEx(var_20, 0, var_124, var_120)
  loc_005D5CA3: var_2DC = FindWindowEx(var_20, 0, var_124, var_120)
  loc_005D5CB7: var_1C = var_2DC
  loc_005D5CCE: var_120 = var_2DC
  loc_005D5CD9: var_eax = FindWindowEx(var_20, var_1C, var_120, var_120)
  loc_005D5CF2: var_B8 = FindWindowEx(var_20, var_1C, var_120, var_120)
  loc_005D5D0A: var_124 = var_20
  loc_005D5D19: ecx = var_120
  loc_005D5D22: var_eax = FindWindowEx(var_20, 0, var_124, var_120)
  loc_005D5D45: var_4C = FindWindowEx(var_20, 0, var_124, var_120)
  loc_005D5D55: var_eax = call Proc_608D20(var_4C, "OK", "Static")
  loc_005D5D63: var_14C = call Proc_608D20(var_4C, "OK", "Static")
  loc_005D5D81: var_164 = LCase(call Proc_608D20(var_4C, "OK", "Static"))
  loc_005D5DAA: var_120 = Text2.Text
  loc_005D5DEB: var_28C = "• "
  loc_005D5E01: var_18C = var_120
  loc_005D5E0D: var_29C = " •is not available•"
  loc_005D5E17: GoTo loc_005D6CE0
  loc_005D5E22: var_eax = call Proc_79_0_601250(var_13C, var_164, Me)
  loc_005D5E29: var_E8 = call Proc_79_0_601250(var_13C, var_164, Me)
  loc_005D5E2F: If call Proc_79_0_601250(var_13C, var_164, Me) = 0 Then GoTo loc_005D5E1C
  loc_005D5E31: var_eax = call Proc_79_1_601500(Me, 0, "Static")
  loc_005D5E38: var_2C = call Proc_79_1_601500(Me, 0, "Static")
  loc_005D5E3B: If call Proc_79_1_601500(Me, 0, "Static") <> 0 Then GoTo loc_005D5F7A
  loc_005D5E47: var_eax = call Proc_79_0_601250(0, "America Online", "Static")
  loc_005D5E5A: var_E8 = call Proc_79_0_601250(0, "America Online", "Static")
  loc_005D5E60: ecx = var_120
  loc_005D5E6C: var_eax = FindWindowEx(var_E8, 0, call Proc_79_0_601250(0, "America Online", "Static"), var_120)
  loc_005D5E7F: var_11C = FindWindowEx(var_E8, 0, call Proc_79_0_601250(0, "America Online", "Static"), var_120)
  loc_005D5E98: 
  loc_005D5EA2: If var_18 > 6 Then GoTo loc_005D5EFD
  loc_005D5EB2: var_18 = var_120
  loc_005D5EC3: var_eax = FindWindowEx(var_E8, var_11C, var_18, var_120)
  loc_005D5EDC: var_11C = FindWindowEx(var_E8, var_11C, var_18, var_120)
  loc_005D5EF0: 00000001h = 00000001h + var_18
  loc_005D5EFB: GoTo loc_005D5E98
  loc_005D5EFD: 'Referenced from: 005D5EA2
  loc_005D5F1C: var_eax = SendMessage(var_11C, 513, 0, 0)
  loc_005D5F42: var_eax = SendMessage(var_11C, 514, 0, 0)
  loc_005D5F62: var_eax = call Proc_6098C0(CLng(0.55), "_AOL_Icon", 0)
  loc_005D5F6C: If var_2C = 0 Then GoTo loc_005D5E31
  loc_005D5F72: GoTo loc_005D5F7A
  loc_005D5F74: 
  loc_005D5F80: var_eax = call Proc_79_1_601500("_AOL_Icon", 0, 0)
  loc_005D5F93: var_2C = call Proc_79_1_601500("_AOL_Icon", 0, 0)
  loc_005D5F9F: var_eax = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D5FB2: var_74 = FindWindowEx(var_2C, 0, var_2DC, var_120)
  loc_005D5FCF: var_120 = var_120
  loc_005D5FDA: var_eax = FindWindowEx(var_2C, var_74, var_120, var_120)
  loc_005D5FDF: var_2DC = FindWindowEx(var_2C, var_74, var_120, var_120)
  loc_005D5FF3: var_70 = var_2DC
  loc_005D600A: var_120 = var_2DC
  loc_005D6015: var_eax = FindWindowEx(var_2C, var_70, var_120, var_120)
  loc_005D602E: var_6C = FindWindowEx(var_2C, var_70, var_120, var_120)
  loc_005D6045: var_120 = CInt(9)
  loc_005D604E: var_eax = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D6053: var_2DC = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D6067: var_24 = var_2DC
  loc_005D607E: var_120 = var_2DC
  loc_005D6087: var_eax = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D608C: var_2DC = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D60A0: var_68 = var_2DC
  loc_005D60B7: var_120 = var_2DC
  loc_005D60C0: var_eax = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D60C5: var_2DC = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D60D9: var_B4 = var_2DC
  loc_005D60F3: var_120 = var_2DC
  loc_005D60FC: var_eax = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D6101: var_2DC = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D6115: var_38 = var_2DC
  loc_005D612C: var_120 = var_2DC
  loc_005D6137: var_eax = FindWindowEx(var_2C, var_38, var_120, var_120)
  loc_005D614A: var_3C = FindWindowEx(var_2C, var_38, var_120, var_120)
  loc_005D6167: var_120 = var_120
  loc_005D6170: var_eax = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D6183: var_11C = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D61A6: 
  loc_005D61B1: If var_18 > 0 Then GoTo loc_005D6209
  loc_005D61C1: var_120 = vbDataObject
  loc_005D61CF: var_eax = FindWindowEx(var_2C, var_11C, var_120, var_120)
  loc_005D61E8: var_11C = FindWindowEx(var_2C, var_11C, var_120, var_120)
  loc_005D61FC: 00000001h = 00000001h + var_18
  loc_005D6207: GoTo loc_005D61A6
  loc_005D6209: 'Referenced from: 005D61B1
  loc_005D6256: var_128 = CStr(0) & CStr(var_11C)
  loc_005D6263: fcomp real8 ptr var_420
  loc_005D6275: GoTo loc_005D6279
  loc_005D6279: 'Referenced from: 005D6275
  loc_005D6288: setnz dl
  loc_005D6291: setnz al
  loc_005D629C: setnz cl
  loc_005D62AD: setnz al
  loc_005D62B8: setnz cl
  loc_005D62C9: setnz al
  loc_005D62D4: setnz cl
  loc_005D62E5: setnz al
  loc_005D62F0: setnz cl
  loc_005D631F: If Not (ecx) <> 0 Then GoTo loc_005D5F74
  loc_005D6366: var_2D8 = serverop.Check2.Value
  loc_005D6394: setz bl
  loc_005D63A2: If ebx = 0 Then GoTo loc_005D6461
  loc_005D63AC: var_eax = call Proc_79_45_608BE0(var_6C, var_13C, var_0060C640)
  loc_005D63BC: var_48 = call Proc_79_45_608BE0(var_6C, var_13C, var_0060C640)
  loc_005D63C5: var_27C = var_48
  loc_005D63DB: Len(var_48) = Len(var_48) - 00000005h
  loc_005D63F3: var_154 = Right(var_48, Len(var_48))
  loc_005D640B: var_48 = var_154
  loc_005D6424: var_120 = var_154
  loc_005D642F: var_eax = SendMessage(var_6C, 12, 0, var_120)
  loc_005D6447: var_ret_2D = var_120
  loc_005D645F: GoTo loc_005D6467
  loc_005D6461: 'Referenced from: 005D63A2
  loc_005D6467: 'Referenced from: 005D645F
  loc_005D648E: var_120 = Text3.Text
  loc_005D64CB: var_eax = SendMessage(var_74, 12, 0, var_120)
  loc_005D6524: var_120 = Text2.Text
  loc_005D6562: var_124 = "<font face=""tahoma""><font color=""#FF8080""><b>•bodini 4.0• server •spek•<p>•mail number • " & var_120
  loc_005D657C: var_128 = var_124 & var_0042EC60
  loc_005D658A: ecx = var_124 & var_0042EC60
  loc_005D6595: var_eax = SendMessage(var_24, 12, 0, var_12C)
  loc_005D65D5: 
  loc_005D65DA: If var_2C = 0 Then GoTo loc_005D72AC
  loc_005D65F4: var_13C = var_120
  loc_005D65F7: var_eax = FindWindow(var_13C, var_120)
  loc_005D660A: var_50 = FindWindow(var_13C, var_120)
  loc_005D6627: var_120 = var_120
  loc_005D6630: var_eax = FindWindowEx(var_50, 0, var_120, var_120)
  loc_005D6643: var_90 = FindWindowEx(var_50, 0, var_120, var_120)
  loc_005D6661: var_120 = var_124
  loc_005D6670: ecx = var_124
  loc_005D667C: var_eax = FindWindowEx(var_90, 0, var_120, var_120)
  loc_005D669F: var_E4 = FindWindowEx(var_90, 0, var_120, var_120)
  loc_005D66BA: var_120 = var_124
  loc_005D66C9: ecx = var_124
  loc_005D66CC: var_eax = FindWindow(var_120, var_120)
  loc_005D66EF: var_B0 = FindWindow(var_120, var_120)
  loc_005D670C: var_120 = var_124
  loc_005D6718: var_eax = FindWindowEx(var_B0, 0, var_120, var_120)
  loc_005D6731: var_94 = FindWindowEx(var_B0, 0, var_120, var_120)
  loc_005D674B: var_120 = var_B0
  loc_005D675C: var_eax = FindWindowEx(var_B0, var_94, var_120, var_120)
  loc_005D676F: var_34 = FindWindowEx(var_B0, var_94, var_120, var_120)
  loc_005D6786: If var_B0 = 0 Then GoTo loc_005D685F
  loc_005D6792: var_eax = call Proc_79_45_608BE0(var_34, 1, "Static")
  loc_005D67B3: var_424 = InStr(0, call Proc_79_45_608BE0(var_34, 1, "Static"), "That mail is no longer available for forwarding.", 0)
  loc_005D67C0: var_eax = call Proc_79_45_608BE0(var_34, 1, "Static")
  loc_005D67EF: var_424 = InStr(0, call Proc_79_45_608BE0(var_34, 1, "Static"), "The original message is no longer available or was not received by this address.", 0)
  loc_005D67F6: var_eax = call Proc_79_45_608BE0(var_34, 1, "America Online")
  loc_005D6831: var_2E4 = InStr("Error", call Proc_79_45_608BE0(var_34, 1, "America Online"), "Please refrain from forwarding this message.", 0)
  loc_005D6859: If var_2E4 <> 0 Then GoTo loc_005D696B
  loc_005D685F: 'Referenced from: 005D6786
  loc_005D6867: If var_E4 <> 0 Then GoTo loc_005D6E8F
  loc_005D686D: var_eax = call Proc_79_1_601500(DoEvents, Me, )
  loc_005D6880: var_2C = call Proc_79_1_601500(DoEvents, Me, )
  loc_005D6883: var_120 = var_120
  loc_005D688C: var_eax = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D689F: var_11C = FindWindowEx(var_2C, 0, var_120, var_120)
  loc_005D68B8: 
  loc_005D68C2: If var_18 > 11 Then GoTo loc_005D691A
  loc_005D68D2: var_18 = var_120
  loc_005D68E0: var_eax = FindWindowEx(var_2C, var_11C, var_18, var_120)
  loc_005D68F9: var_11C = FindWindowEx(var_2C, var_11C, var_18, var_120)
  loc_005D690D: 00000001h = 00000001h + var_18
  loc_005D6918: GoTo loc_005D68B8
  loc_005D691A: 'Referenced from: 005D68C2
  loc_005D6939: var_eax = SendMessage(var_11C, 513, 0, 0)
  loc_005D695F: var_eax = SendMessage(var_11C, 514, 0, var_2DC)
  loc_005D6966: GoTo loc_005D65D5
  loc_005D696B: 
  loc_005D6977: var_124 = var_2DC
  loc_005D6986: ecx = var_120
  loc_005D6989: var_eax = FindWindow(var_124, var_120)
  loc_005D69AC: var_B0 = FindWindow(var_124, var_120)
  loc_005D69C9: var_124 = var_120
  loc_005D69D5: var_eax = FindWindowEx(var_B0, 0, var_124, var_120)
  loc_005D69DA: var_2DC = FindWindowEx(var_B0, 0, var_124, var_120)
  loc_005D69EE: var_94 = var_2DC
  loc_005D6A08: var_120 = var_2DC
  loc_005D6A19: var_eax = FindWindowEx(var_B0, var_94, var_120, var_120)
  loc_005D6A32: var_34 = FindWindowEx(var_B0, var_94, var_120, var_120)
  loc_005D6A47: var_124 = var_B0
  loc_005D6A56: ecx = var_120
  loc_005D6A62: var_eax = FindWindowEx(var_B0, 0, var_124, var_120)
  loc_005D6A9B: var_eax = call Proc_608D20(FindWindowEx(var_B0, 0, var_124, var_120), "OK", "Static")
  loc_005D6AA0: var_eax = call Proc_79_1_601500(0, "Static", 0)
  loc_005D6AB2: var_eax = call Proc_608D70(call Proc_79_1_601500(0, "Static", 0), "America Online", "_AOL_Icon")
  loc_005D6AC3: var_2DC = CLng(0.65)
  loc_005D6AD0: var_eax = call Proc_6098C0(var_2DC, 0, "_AOL_Icon")
  loc_005D6AE1: var_124 = var_2DC
  loc_005D6AF0: ecx = var_120
  loc_005D6AF3: var_eax = FindWindow(var_124, var_120)
  loc_005D6B16: var_118 = FindWindow(var_124, var_120)
  loc_005D6B31: var_124 = var_120
  loc_005D6B40: var_120 = var_120
  loc_005D6B4C: var_eax = FindWindowEx(var_118, 0, var_120, var_120)
  loc_005D6B6F: var_28 = FindWindowEx(var_118, 0, var_120, var_120)
  loc_005D6B87: var_124 = var_120
  loc_005D6B96: var_120 = var_120
  loc_005D6BA4: var_eax = FindWindowEx(var_118, var_28, var_120, var_120)
  loc_005D6BBD: var_114 = FindWindowEx(var_118, var_28, var_120, var_120)
  loc_005D6BDD: var_eax = call Proc_608D20(var_114, "&No", "&Yes")
  loc_005D6BE9: var_eax = call Proc_608D20(var_114, "AOL Mail", )
  loc_005D6C07: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005D6C0C: var_eax = call Proc_79_0_601250(, , )
  loc_005D6C17: var_2DC = call Proc_79_0_601250(, , )
  loc_005D6C1E: var_eax = call Proc_608D70(var_2DC, , )
  loc_005D6C2C: var_14C = call Proc_608D70(var_2DC, , )
  loc_005D6C4A: var_164 = LCase(call Proc_608D70(var_2DC, , ))
  loc_005D6C73: var_120 = Text2.Text
  loc_005D6CB4: var_28C = "• "
  loc_005D6CCA: var_18C = var_120
  loc_005D6CD6: var_29C = " •is not forwardable•"
  loc_005D6CE0: 'Referenced from: 005D5E17
  loc_005D6D4D: var_124 = &H42EC60 & var_164 & "• " & var_120 & " •is not forwardable•"
  loc_005D6D8D: var_eax = call Proc_3_4_5A51B0(var_1D4, var_FC, 3)
  loc_005D6DA3: var_110 = call Proc_79_47_609590(var_13C, var_13C, Me)
  loc_005D6E07: 'Referenced from: 005D5287
  loc_005D6E23: var_120 = "<font face=""tahoma"">" & var_110
  loc_005D6E35: var_124 = var_120 & vbNullString
  loc_005D6E3E: var_eax = call Proc_79_17_604A50(var_124, var_FC, var_124)
  loc_005D6E7A: var_eax = List1.RemoveItem 0
  loc_005D6E84: If List1.RemoveItem 0 >= 0 Then GoTo loc_005D77F7
  loc_005D6E8A: GoTo loc_005D77E5
  loc_005D6E8F: 'Referenced from: 005D6867
  loc_005D6E9B: ecx = var_124
  loc_005D6EAA: ecx = var_124
  loc_005D6EAD: var_eax = FindWindow(var_120, var_120)
  loc_005D6ED0: var_64 = FindWindow(var_120, var_120)
  loc_005D6EE8: var_124 = var_124
  loc_005D6EF7: ecx = var_120
  loc_005D6F00: var_eax = FindWindowEx(var_64, 0, var_124, var_120)
  loc_005D6F39: var_eax = call Proc_608D20(FindWindowEx(var_64, 0, var_124, var_120), Me, Me)
  loc_005D6F4C: var_DC = var_120
  loc_005D6F4F: var_eax = FindWindow(var_DC, var_120)
  loc_005D6F68: var_50 = FindWindow(var_DC, var_120)
  loc_005D6F7F: var_120 = var_120
  loc_005D6F88: var_eax = FindWindowEx(var_50, 0, var_120, var_120)
  loc_005D6FA1: var_90 = FindWindowEx(var_50, 0, var_120, var_120)
  loc_005D6FB9: var_124 = var_50
  loc_005D6FC8: ecx = var_120
  loc_005D6FD4: var_eax = FindWindowEx(var_90, 0, var_124, var_120)
  loc_005D700D: var_eax = call Proc_608D70(FindWindowEx(var_90, 0, var_124, var_120), , )
  loc_005D7012: var_eax = call Proc_79_0_601250(, , )
  loc_005D7024: var_eax = call Proc_608D70(call Proc_79_0_601250(, , ), , )
  loc_005D7029: var_eax = call Proc_79_1_601500(, , )
  loc_005D702E: var_2DC = call Proc_79_1_601500(, , )
  loc_005D703B: var_eax = call Proc_608D70(var_2DC, , )
  loc_005D7049: var_14C = call Proc_608D70(var_2DC, , )
  loc_005D7067: var_164 = LCase(call Proc_608D70(var_2DC, , ))
  loc_005D7090: var_120 = Text2.Text
  loc_005D70CD: var_18C = var_120
  loc_005D710A: var_28C = "• "
  loc_005D7114: var_29C = " •can't be sent•"
  loc_005D716A: var_124 = &H42EC60 & var_164 & "• " & var_120 & " •can't be sent•"
  loc_005D71AA: var_eax = call Proc_3_4_5A51B0(var_1D4, var_FC, 3)
  loc_005D7240: var_120 = "<font face=""tahoma"">" & call Proc_79_47_609590(var_13C, var_13C, Me)
  loc_005D7252: var_124 = var_120 & vbNullString
  loc_005D7254: 'Referenced from: 005D2FF2
  loc_005D725B: var_eax = call Proc_79_17_604A50(var_124, var_FC, var_124)
  loc_005D7297: var_eax = List1.RemoveItem 0
  loc_005D72A1: If List1.RemoveItem 0 >= 0 Then GoTo loc_005D77F7
  loc_005D72A7: GoTo loc_005D77E5
  loc_005D72AC: 'Referenced from: 005D65DA
  loc_005D72B9: var_eax = PostMessage(var_E8, 16, 0, 0)
  loc_005D72C9: var_14C = var_120 & var_13C
  loc_005D72E7: var_164 = LCase(var_120 & var_13C)
  loc_005D7312: var_120 = Text2.Text
  loc_005D736D: var_124 = serverop.Text2.Text
  loc_005D739C: var_18C = var_120
  loc_005D73B6: var_1BC = var_124
  loc_005D73EE: var_28C = "• "
  loc_005D7404: var_29C = " •"
  loc_005D748C: var_128 = &H42EC60 & var_164 & "• " & var_120 & " •" & var_124 & &H42EC60
  loc_005D74CC: var_eax = call Proc_3_4_5A51B0(var_204, var_FC, 3)
  loc_005D7583: var_120 = "<font face=""tahoma"">" & var_204
  loc_005D75A2: var_eax = call Proc_79_17_604A50(var_120 & vbNullString, , )
  loc_005D75D9: var_2EC = var_120
  loc_005D75F6: var_27C = vbNullString
  loc_005D762A: var_164 = LCase(Me)
  loc_005D765F: var_120 = Text2.Text
  loc_005D768C: var_18C = var_120
  loc_005D76AA: var_29C = vbNullString
  loc_005D7731: var_124 = CStr(vbNullString + var_164 + &H431364 + 0 + vbNullString)
  loc_005D773F: Text2.OLEDragMode = var_124
  loc_005D77D9: var_eax = List1.RemoveItem 0
  loc_005D77E3: If List1.RemoveItem 0 >= 0 Then GoTo loc_005D77F7
  loc_005D77E5: 'Referenced from: 005D6E8A
  loc_005D77F1: List1.RemoveItem 0 = CheckObj(Me, var_00432428, 496)
  loc_005D77F7: 'Referenced from: 005D6E84
  loc_005D7803: 'Referenced from: 005D1A36
  loc_005D7810: GoTo loc_005D78FF
  loc_005D78FE: Exit Sub
  loc_005D78FF: 'Referenced from: 005D7810
  loc_005D7982: Exit Sub
End Sub