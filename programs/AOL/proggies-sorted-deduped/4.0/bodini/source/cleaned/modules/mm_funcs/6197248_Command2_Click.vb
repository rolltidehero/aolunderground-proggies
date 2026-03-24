ï»¿Private Sub Command2_Click() '5E9000
  Dim var_0060C6B8 As ListBox
  Dim var_2C0 As ListBox
  Dim var_0060C6CC As CheckBox
  loc_005E91C3: var_2AC = mmselect.List1.ListCount
  loc_005E91EE: var_2AC = var_2AC - 0001h
  loc_005E91FE: var_240 = var_2AC
  loc_005E9232: For var_40 = "" To var_2AC Step 1
  loc_005E923E: var_318 = var_2F4
  loc_005E925C: If var_318 = 0 Then GoTo loc_005EB151
  loc_005E92AA: var_40 = CInt(var_2AC)
  loc_005E92B8: var_40 = mmselect.List1.Selected
  loc_005E92EE: setz dl
  loc_005E9307: If var_2C8 = 0 Then GoTo loc_005EB12E
  loc_005E930D: var_eax = call Proc_79_8_6029E0(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005E9314: var_48 = call Proc_79_8_6029E0(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005E9317: If call Proc_79_8_6029E0(var_D8, var_0060C6B8, var_0060C6B8) = 0 Then GoTo loc_005EB5B9
  loc_005E932B: var_ret_1 = "_AOL_TabControl"
  loc_005E9334: var_eax = FindWindowEx(var_48, 0, var_ret_1, 0)
  loc_005E9361: var_ret_2 = "_AOL_TabPage"
  loc_005E9367: var_eax = FindWindowEx(FindWindowEx(var_48, 0, var_ret_1, 0), 0, var_ret_2, 0)
  loc_005E936C: var_2B0 = FindWindowEx(var_2B0, 0, var_ret_2, 0)
  loc_005E9380: var_9C = var_2B0
  loc_005E939A: var_ret_3 = "_AOL_TabPage"
  loc_005E93A5: var_eax = FindWindowEx(var_2B0, var_9C, var_ret_3, 0)
  loc_005E93D2: var_ret_4 = "_AOL_Tree"
  loc_005E93D8: var_eax = FindWindowEx(FindWindowEx(var_2B0, var_9C, var_ret_3, 0), 0, var_ret_4, 0)
  loc_005E93DD: var_2B0 = FindWindowEx(var_2B0, 0, var_ret_4, 0)
  loc_005E9410: var_eax = SendMessage(0, 395, 0, 0)
  loc_005E9439: var_eax = SendMessage(var_2B0, 390, CLng(var_40), var_2B0)
  loc_005E944A: var_eax = PostMessage(var_2B0, 256, 13, 0)
  loc_005E945B: var_eax = PostMessage(var_2B0, 257, 13, 0)
  loc_005E946A: var_eax = call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005E9471: var_98 = call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005E9477: If call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8) = 0 Then GoTo loc_005E9468
  loc_005E949D: var_2C0 = call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005E94A3: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E9514: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E9548: If var_60C000 <> 0 Then GoTo loc_005E9552
  loc_005E9550: GoTo loc_005E9563
  loc_005E9552: 'Referenced from: 005E9548
  loc_005E9563: 'Referenced from: 005E9550
  loc_005E9579: call __vbaStrR8
  loc_005E9587: var_D0 = __vbaStrR8
  loc_005E9597: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005E9616: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E965B: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E969B: var_2D0 = (var_C8 = var_CC)
  loc_005E96D2: If var_2D0 = 0 Then GoTo loc_005E97E8
  loc_005E96FF: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E9728: var_F0 = var_C8
  loc_005E974A: var_230 = vbNullString
  loc_005E9779: var_240 = vbNullString
  loc_005E97A2: var_128 = vbNullString & Left(var_C8, 2) & vbNullString
  loc_005E97B5: var_A0 = CInt(Me)
  loc_005E97E8: 'Referenced from: 005E96D2
  loc_005E980F: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E9854: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E9890: eax = (var_C8 = var_CC) + 1
  loc_005E989D: var_2D0 = (var_C8 = var_CC) + 1
  loc_005E98CA: If var_2D0 = 0 Then GoTo loc_005E99E0
  loc_005E98F1: var_2C0 = var_D8
  loc_005E98F7: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E9921: var_F0 = var_C8
  loc_005E9936: var_230 = vbNullString
  loc_005E9971: var_240 = vbNullString
  loc_005E999A: var_128 = vbNullString & Left(var_C8, 3) & vbNullString
  loc_005E99AD: var_A0 = CInt(var_D8)
  loc_005E99E0: 'Referenced from: 005E98CA
  loc_005E9A1E: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E9A72: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005E9ADF: call __vbaCastObj(var_E0, var_E0, 0, var_00436CC0, Unknown_VTable_Call[eax+00000050h], var_CC, var_DC, var_E0, Me, Me, var_C8, var_D8, Set %StkVar1 = %StkVar2 'Ignore this, Me, 0, var_F8)
  loc_005E9B04: var_eax = call Proc_79_50_609A50(var_E4, CInt(var_2BC), var_F8)
  loc_005E9B5F: 
  loc_005E9B64: If var_28 <> 0 Then GoTo loc_005E9CC2
  loc_005E9B83: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005E9B88: var_eax = call Proc_79_1_601500(, , )
  loc_005E9B8F: var_28 = call Proc_79_1_601500(, , )
  loc_005E9B92: If call Proc_79_1_601500(, , ) <> 0 Then GoTo loc_005E9CC2
  loc_005E9B98: var_eax = call Proc_79_0_601250(, , )
  loc_005E9BAB: var_98 = call Proc_79_0_601250(, , )
  loc_005E9BB1: var_ret_6 = "_AOL_Icon"
  loc_005E9BBD: var_eax = FindWindowEx(var_98, 0, var_ret_6, 0)
  loc_005E9BD6: var_B4 = FindWindowEx(var_98, 0, var_ret_6, 0)
  loc_005E9BE5: 
  loc_005E9BEF: If var_18 > 6 Then GoTo loc_005E9C46
  loc_005E9BFF: var_ret_7 = "_AOL_Icon"
  loc_005E9C10: var_eax = FindWindowEx(var_98, var_B4, var_ret_7, 0)
  loc_005E9C23: var_B4 = FindWindowEx(var_98, var_B4, var_ret_7, 0)
  loc_005E9C39: 00000001h = 00000001h + var_18
  loc_005E9C44: GoTo loc_005E9BE5
  loc_005E9C46: 'Referenced from: 005E9BEF
  loc_005E9C4B: If var_28 <> 0 Then GoTo loc_005E9CC2
  loc_005E9C6C: var_eax = SendMessage(var_B4, 513, 0, 0)
  loc_005E9C92: var_eax = SendMessage(var_B4, 514, 0, 0)
  loc_005E9CB2: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005E9CB7: GoTo loc_005E9B5F
  loc_005E9CBC: 
  loc_005E9CC8: var_eax = call Proc_79_1_601500(, , )
  loc_005E9CDB: var_28 = call Proc_79_1_601500(, , )
  loc_005E9CDE: var_ret_8 = "_AOL_Edit"
  loc_005E9CE7: var_eax = FindWindowEx(var_28, 0, var_ret_8, 0)
  loc_005E9D00: var_6C = FindWindowEx(var_28, 0, var_ret_8, 0)
  loc_005E9D13: var_ret_9 = "_AOL_Edit"
  loc_005E9D1E: var_eax = FindWindowEx(var_28, var_6C, var_ret_9, 0)
  loc_005E9D31: var_64 = FindWindowEx(var_28, var_6C, var_ret_9, 0)
  loc_005E9D4A: var_ret_A = "_AOL_Edit"
  loc_005E9D55: var_eax = FindWindowEx(var_28, var_64, var_ret_A, 0)
  loc_005E9D6E: var_60 = FindWindowEx(var_28, var_64, var_ret_A, 0)
  loc_005E9D81: var_ret_B = "RICHCNTL"
  loc_005E9D8A: var_eax = FindWindowEx(var_28, 0, var_ret_B, 0)
  loc_005E9DA3: var_1C = FindWindowEx(var_28, 0, var_ret_B, 0)
  loc_005E9DB6: var_ret_C = "_AOL_Combobox"
  loc_005E9DBF: var_eax = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_005E9DD8: var_5C = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_005E9DEB: var_ret_D = "_AOL_Fontcombo"
  loc_005E9DF4: var_eax = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_005E9E0D: var_78 = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_005E9E20: var_ret_E = "_AOL_Icon"
  loc_005E9E29: var_eax = FindWindowEx(var_28, 0, var_ret_E, 0)
  loc_005E9E42: var_30 = FindWindowEx(var_28, 0, var_ret_E, 0)
  loc_005E9E55: var_ret_F = "_AOL_Icon"
  loc_005E9E60: var_eax = FindWindowEx(var_28, var_30, var_ret_F, 0)
  loc_005E9E79: var_44 = FindWindowEx(var_28, var_30, var_ret_F, 0)
  loc_005E9E8C: var_ret_10 = "_AOL_Icon"
  loc_005E9E95: var_eax = FindWindowEx(var_28, 0, var_ret_10, 0)
  loc_005E9EAE: var_B4 = FindWindowEx(var_28, 0, var_ret_10, 0)
  loc_005E9EBD: 
  loc_005E9EC7: If var_18 > 13 Then GoTo loc_005E9F1B
  loc_005E9ED7: var_ret_11 = "_AOL_Icon"
  loc_005E9EE5: var_eax = FindWindowEx(var_28, var_B4, var_ret_11, 0)
  loc_005E9EF8: var_B4 = FindWindowEx(var_28, var_B4, var_ret_11, 0)
  loc_005E9F0E: 00000001h = 00000001h + var_18
  loc_005E9F19: GoTo loc_005E9EBD
  loc_005E9F1B: 'Referenced from: 005E9EC7
  loc_005E9F34: var_C8 = CStr(0)
  loc_005E9F50: var_CC = CStr(var_B4)
  loc_005E9F65: var_D0 = var_C8 & var_CC
  loc_005E9F72: fcomp real8 ptr var_33C
  loc_005E9F84: GoTo loc_005E9F88
  loc_005E9F88: 'Referenced from: 005E9F84
  loc_005E9F97: setnz al
  loc_005E9FA0: setnz cl
  loc_005E9FAB: setnz dl
  loc_005E9FBC: setnz cl
  loc_005E9FC7: setnz dl
  loc_005E9FD8: setnz cl
  loc_005E9FE3: setnz dl
  loc_005E9FF4: setnz cl
  loc_005E9FFF: setnz dl
  loc_005EA02E: If Not (edx) <> 0 Then GoTo loc_005E9CBC
  loc_005EA075: var_2AC = mmoption.Check8.Value
  loc_005EA0A3: setz bl
  loc_005EA0B1: If ebx = 0 Then GoTo loc_005EA168
  loc_005EA0BB: var_eax = call Proc_79_45_608BE0(var_60, var_D8, var_0060C6CC)
  loc_005EA0CB: var_4C = call Proc_79_45_608BE0(var_60, var_D8, var_0060C6CC)
  loc_005EA0D4: var_230 = var_4C
  loc_005EA0EA: Len(var_4C) = Len(var_4C) - 00000005h
  loc_005EA13E: var_eax = SendMessage(var_60, 12, 0, Right(var_4C, Len(var_4C)))
  loc_005EA150: var_ret_13 = var_C8
  loc_005EA168: 'Referenced from: 005EA0B1
  loc_005EA18E: var_C8 = Text1.Text
  loc_005EA1C5: var_eax = SendMessage(var_6C, 12, 0, var_C8)
  loc_005EA206: var_F8 = Chr(13)
  loc_005EA211: var_118 = Chr(10)
  loc_005EA239: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005EA277: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EA2B3: var_140 = var_C8
  loc_005EA2E3: var_170 = var_CC
  loc_005EA31F: var_280 = var_A0
  loc_005EA335: var_230 = "â¢bodini 4.0â¢ mass mailer â¢spekâ¢"
  loc_005EA33F: var_240 = "â¢mail "
  loc_005EA349: var_250 = "â¢ of â¢"
  loc_005EA35D: var_270 = "â¢this mm isâ¢ "
  loc_005EA371: var_290 = "% â¢doneâ¢"
  loc_005EA414: var_1E8 = "â¢bodini 4.0â¢ mass mailer â¢spekâ¢" & var_F8 & var_118 & "â¢mail " & var_C8 & "â¢ of â¢" & var_CC & &H42EC60 & Chr(13) & Chr(10) & "â¢this mm isâ¢ "
  loc_005EA447: var_D0 = var_1E8 & var_A0 & "% â¢doneâ¢"
  loc_005EA48B: var_eax = call Proc_3_4_5A51B0(var_228, var_94, 3)
  loc_005EA49C: var_C4 = var_228
  loc_005EA57E: var_C8 = Text2.Text
  loc_005EA5BC: var_CC = vbNullString & var_C8
  loc_005EA5CE: var_100 = var_CC & vbNullString
  loc_005EA61E: var_230 = vbNullString
  loc_005EA624: var_250 = vbNullString
  loc_005EA639: var_240 = "<p align center><font face=""tahoma""><b>"
  loc_005EA698: var_178 = var_CC & vbNullString & Chr(13) & Chr(10) & vbNullString & "<p align center><font face=""tahoma""><b>" & var_C4 & vbNullString
  loc_005EA6BB: var_eax = SendMessage(var_1C, 12, 0, CStr(var_178))
  loc_005EA74B: 
  loc_005EA750: If var_28 = 0 Then GoTo loc_005EAFF8
  loc_005EA76A: var_ret_16 = "AOL Frame25"
  loc_005EA76D: var_eax = FindWindow(var_ret_16, 0)
  loc_005EA786: var_54 = FindWindow(var_ret_16, 0)
  loc_005EA799: var_ret_17 = "MDICLIENT"
  loc_005EA7A2: var_eax = FindWindowEx(var_54, 0, var_ret_17, 0)
  loc_005EA7BB: var_68 = FindWindowEx(var_54, 0, var_ret_17, 0)
  loc_005EA7CC: var_ret_18 = "Error"
  loc_005EA7DB: var_ret_19 = "AOL Child"
  loc_005EA7E4: var_eax = FindWindowEx(var_68, 0, var_ret_19, var_ret_18)
  loc_005EA807: var_84 = FindWindowEx(var_68, 0, var_ret_19, var_ret_18)
  loc_005EA822: var_ret_1A = "America Online"
  loc_005EA831: var_ret_1B = "#32770"
  loc_005EA834: var_eax = FindWindow(var_ret_1B, var_ret_1A)
  loc_005EA857: var_74 = FindWindow(var_ret_1B, var_ret_1A)
  loc_005EA871: var_ret_1C = "Static"
  loc_005EA87A: var_eax = FindWindowEx(var_74, 0, var_ret_1C, 0)
  loc_005EA88D: var_70 = FindWindowEx(var_74, 0, var_ret_1C, 0)
  loc_005EA8A6: var_ret_1D = "Static"
  loc_005EA8B1: var_eax = FindWindowEx(var_74, var_70, var_ret_1D, 0)
  loc_005EA8CA: var_2C = FindWindowEx(var_74, var_70, var_ret_1D, 0)
  loc_005EA8D4: If var_74 = 0 Then GoTo loc_005EA922
  loc_005EA8DC: var_eax = call Proc_79_45_608BE0(var_2C, 1, )
  loc_005EA90B: var_2C0 = InStr(, call Proc_79_45_608BE0(var_2C, 1, ), "Please refrain from forwarding this message.", 0)
  loc_005EA91C: If var_2C0 <> 0 Then GoTo loc_005EAA26
  loc_005EA922: 'Referenced from: 005EA8D4
  loc_005EA92A: If var_84 <> 0 Then GoTo loc_005EAD6C
  loc_005EA930: var_eax = call Proc_79_1_601500(, , )
  loc_005EA943: var_28 = call Proc_79_1_601500(, , )
  loc_005EA946: var_ret_1E = "_AOL_Icon"
  loc_005EA94F: var_eax = FindWindowEx(var_28, 0, var_ret_1E, 0)
  loc_005EA968: var_B4 = FindWindowEx(var_28, 0, var_ret_1E, 0)
  loc_005EA977: 
  loc_005EA981: If var_18 > 11 Then GoTo loc_005EA9D5
  loc_005EA991: var_ret_1F = "_AOL_Icon"
  loc_005EA99F: var_eax = FindWindowEx(var_28, var_B4, var_ret_1F, 0)
  loc_005EA9B2: var_B4 = FindWindowEx(var_28, var_B4, var_ret_1F, 0)
  loc_005EA9C8: 00000001h = 00000001h + var_18
  loc_005EA9D3: GoTo loc_005EA977
  loc_005EA9D5: 'Referenced from: 005EA981
  loc_005EA9F4: var_eax = SendMessage(var_B4, 513, 0, 0)
  loc_005EAA1A: var_eax = SendMessage(var_B4, 514, 0, 0)
  loc_005EAA21: GoTo loc_005EA74B
  loc_005EAA26: 
  loc_005EAA32: var_ret_20 = "America Online"
  loc_005EAA41: var_ret_21 = "#32770"
  loc_005EAA44: var_eax = FindWindow(var_ret_21, var_ret_20)
  loc_005EAA67: var_74 = FindWindow(var_ret_21, var_ret_20)
  loc_005EAA81: var_ret_22 = "Static"
  loc_005EAA8A: var_eax = FindWindowEx(var_74, 0, var_ret_22, 0)
  loc_005EAA9D: var_70 = FindWindowEx(var_74, 0, var_ret_22, 0)
  loc_005EAAB6: var_ret_23 = "Static"
  loc_005EAAC1: var_eax = FindWindowEx(var_74, var_70, var_ret_23, 0)
  loc_005EAADA: var_2C = FindWindowEx(var_74, var_70, var_ret_23, 0)
  loc_005EAAEB: var_ret_24 = "OK"
  loc_005EAAFA: var_ret_25 = "Button"
  loc_005EAB03: var_eax = FindWindowEx(var_74, 0, var_ret_25, var_ret_24)
  loc_005EAB36: var_eax = call Proc_608D20(FindWindowEx(var_74, 0, var_ret_25, var_ret_24), , )
  loc_005EAB3B: var_eax = call Proc_79_1_601500(, , )
  loc_005EAB4D: var_eax = call Proc_608D70(call Proc_79_1_601500(, , ), , )
  loc_005EAB6B: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005EAB7C: var_ret_26 = "AOL Mail"
  loc_005EAB8B: var_ret_27 = "#32770"
  loc_005EAB8E: var_eax = FindWindow(var_ret_27, var_ret_26)
  loc_005EABC6: var_ret_28 = "&Yes"
  loc_005EABD5: var_ret_29 = "Button"
  loc_005EABDB: var_eax = FindWindowEx(FindWindow(var_ret_27, var_ret_26), 0, var_ret_29, var_ret_28)
  loc_005EABE0: var_2B0 = FindWindowEx(var_2B0, 0, var_ret_29, var_ret_28)
  loc_005EABFE: var_24 = var_2B0
  loc_005EAC16: var_ret_2A = "&No"
  loc_005EAC25: var_ret_2B = "Button"
  loc_005EAC2D: var_eax = FindWindowEx(var_2B0, var_24, var_ret_2B, var_ret_2A)
  loc_005EAC4E: var_AC = FindWindowEx(var_2B0, var_24, var_ret_2B, var_ret_2A)
  loc_005EAC66: var_eax = call Proc_608D20(var_AC, , )
  loc_005EAC72: var_eax = call Proc_608D20(var_AC, , )
  loc_005EAC90: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005EAC95: var_eax = call Proc_79_0_601250(, , )
  loc_005EAC9A: var_2B0 = call Proc_79_0_601250(, , )
  loc_005EACA7: var_eax = call Proc_608D70(var_2B0, , )
  loc_005EACC6: var_2C8 = call Proc_608D70(var_2B0, , )
  loc_005EACEF: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EAD32: call __vbaStrR8
  loc_005EAD40: var_CC = __vbaStrR8
  loc_005EAD5A: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005EAD61: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005EAFCF
  loc_005EAD67: GoTo loc_005EAFC0
  loc_005EAD6C: 'Referenced from: 005EA92A
  loc_005EAD78: var_ret_2C = "America Online"
  loc_005EAD87: var_ret_2D = "#32770"
  loc_005EAD8A: var_eax = FindWindow(var_ret_2D, var_ret_2C)
  loc_005EADAD: var_58 = FindWindow(var_ret_2D, var_ret_2C)
  loc_005EADC5: var_ret_2E = "OK"
  loc_005EADD4: var_ret_2F = "Button"
  loc_005EADDD: var_eax = FindWindowEx(var_58, 0, var_ret_2F, var_ret_2E)
  loc_005EAE10: var_eax = call Proc_608D20(FindWindowEx(var_58, 0, var_ret_2F, var_ret_2E), , )
  loc_005EAE23: var_ret_30 = "AOL Frame25"
  loc_005EAE26: var_eax = FindWindow(var_ret_30, 0)
  loc_005EAE3F: var_54 = FindWindow(var_ret_30, 0)
  loc_005EAE42: call var_2C8
  loc_005EAE52: var_ret_31 = "MDICLIENT"
  loc_005EAE5B: var_eax = FindWindowEx(var_54, 0, var_ret_31, 0)
  loc_005EAE74: var_68 = FindWindowEx(var_54, 0, var_ret_31, 0)
  loc_005EAE77: call var_2C8
  loc_005EAE85: var_ret_32 = "Error"
  loc_005EAE94: var_ret_33 = "AOL Child"
  loc_005EAE9D: var_eax = FindWindowEx(var_68, 0, var_ret_33, var_ret_32)
  loc_005EAED6: var_eax = call Proc_608D70(FindWindowEx(var_68, 0, var_ret_33, var_ret_32), , )
  loc_005EAEDB: var_eax = call Proc_79_0_601250(, , )
  loc_005EAEED: var_eax = call Proc_608D70(call Proc_79_0_601250(, , ), , )
  loc_005EAEF2: var_eax = call Proc_79_1_601500(, , )
  loc_005EAEF7: var_2B0 = call Proc_79_1_601500(, , )
  loc_005EAF04: var_eax = call Proc_608D70(var_2B0, , )
  loc_005EAF23: var_2C8 = call Proc_608D70(var_2B0, , )
  loc_005EAF4C: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EAF8F: call __vbaStrR8
  loc_005EAF9D: var_CC = __vbaStrR8
  loc_005EAFB7: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005EAFBE: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005EAFCF
  loc_005EAFC0: 'Referenced from: 005EAD67
  loc_005EAFC9: Unknown_VTable_Call[eax+00000054h] = CheckObj(var_2C8, var_0042DCB0, 84)
  loc_005EAFCF: 'Referenced from: 005EAD61
  loc_005EAFF3: GoTo loc_005EB121
  loc_005EAFF8: 'Referenced from: 005EA750
  loc_005EAFF8: var_eax = call Proc_79_1_601500(var_D8, var_DC, var_2C8)
  loc_005EB00A: var_eax = call Proc_608D70(call Proc_79_1_601500(var_D8, var_DC, var_2C8), var_CC, )
  loc_005EB01C: var_eax = PostMessage(var_98, 16, 0, 0)
  loc_005EB03C: var_eax = call Proc_6098C0(CLng(0.45), , )
  loc_005EB05E: var_2C8 = var_DC
  loc_005EB084: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005EB0C7: call __vbaStrR8
  loc_005EB0D5: var_CC = __vbaStrR8
  loc_005EB0E5: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005EB121: 'Referenced from: 005EAFF3
  loc_005EB12E: 'Referenced from: 005E9307
  loc_005EB140: Next var_40
  loc_005EB146: var_318 = Next var_40
  loc_005EB14C: GoTo loc_005E9256
  loc_005EB151: 'Referenced from: 005E925C
  loc_005EB162: var_C8 = "â¢bodini 4.0â¢ mm â¢completedâ¢"
  loc_005EB1A6: var_eax = call Proc_3_4_5A51B0(var_108, var_94, 3)
  loc_005EB209: var_C8 = "<font face=""tahoma"">" & var_CC & vbNullString
  loc_005EB21B: var_CC = var_C8 & vbNullString
  loc_005EB224: var_eax = call Proc_79_17_604A50(var_CC, var_94, var_C8)
  loc_005EB285: var_2AC = mmoption.Check3.Value
  loc_005EB2B3: setz dl
  loc_005EB2C4: If edx = 0 Then GoTo loc_005EB2CB
  loc_005EB2C6: var_eax = call Proc_79_32_6072E0(var_D8, var_0060C6CC, var_0060C6CC)
  loc_005EB2CB: 'Referenced from: 005EB2C4
  loc_005EB308: var_2AC = mmoption.Check5.Value
  loc_005EB336: setz dl
  loc_005EB347: If edx = 0 Then GoTo loc_005EB372
  loc_005EB354: var_C8 = "Sign Off"
  loc_005EB361: var_eax = call Proc_79_54_60A7D0(var_C8, var_D8, var_0060C6CC)
  loc_005EB372: 'Referenced from: 005EB347
  loc_005EB390: var_2C0 = call Proc_79_54_60A7D0(var_C8, var_D8, var_0060C6CC)
  loc_005EB396: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005EB3E1: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005EB42C: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005EB48C: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EB4DC: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EB53F: call __vbaCastObj(var_E8, var_E0, var_E8, var_00436CC0, esi, var_CC, var_DC, esi, Me, var_D8, var_C8, var_D8, esi, Me, var_E8, esi)
  loc_005EB564: var_eax = call Proc_79_50_609A50(var_E4, CInt(var_2BC), 5)
  loc_005EB5C2: GoTo loc_005EB6B1
  loc_005EB6B0: Exit Sub
  loc_005EB6B1: 'Referenced from: 005EB5C2
  loc_005EB6F8: Exit Sub
End Sub