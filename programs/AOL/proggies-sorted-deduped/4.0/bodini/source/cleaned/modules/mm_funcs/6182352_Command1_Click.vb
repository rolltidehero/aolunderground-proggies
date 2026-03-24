ï»¿Private Sub Command1_Click() '5E55D0
  Dim var_0060C6B8 As ListBox
  Dim var_2D8 As ListBox
  Dim var_0060C6CC As CheckBox
  Dim var_F0 As CheckBox
  loc_005E57A8: var_2C4 = mmselect.List1.ListCount
  loc_005E57D3: var_2C4 = var_2C4 - 0001h
  loc_005E57E3: var_258 = var_2C4
  loc_005E5817: For var_50 = "" To var_2C4 Step 1
  loc_005E5823: var_350 = var_30C
  loc_005E5841: If var_350 = 0 Then GoTo loc_005E79C9
  loc_005E588F: var_50 = CInt(var_2C4)
  loc_005E589D: var_50 = mmselect.List1.Selected
  loc_005E58D3: setz dl
  loc_005E58EC: If var_2E0 = 0 Then GoTo loc_005E7716
  loc_005E58F2: var_eax = call Proc_79_8_6029E0(var_F0, var_0060C6B8, var_0060C6B8)
  loc_005E58F9: var_58 = call Proc_79_8_6029E0(var_F0, var_0060C6B8, var_0060C6B8)
  loc_005E58FC: If call Proc_79_8_6029E0(var_F0, var_0060C6B8, var_0060C6B8) = 0 Then GoTo loc_005E7E31
  loc_005E5910: var_ret_1 = "_AOL_TabControl"
  loc_005E5919: var_eax = FindWindowEx(var_58, 0, var_ret_1, 0)
  loc_005E5946: var_ret_2 = "_AOL_TabPage"
  loc_005E594C: var_eax = FindWindowEx(FindWindowEx(var_58, 0, var_ret_1, 0), 0, var_ret_2, 0)
  loc_005E5979: var_ret_3 = "_AOL_Tree"
  loc_005E597F: var_eax = FindWindowEx(FindWindowEx(var_2C8, 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_005E5984: var_2C8 = FindWindowEx(var_2C8, 0, var_ret_3, 0)
  loc_005E59B7: var_eax = SendMessage(0, 395, 0, 0)
  loc_005E59E0: var_eax = SendMessage(var_2C8, 390, CLng(var_50), var_2C8)
  loc_005E59F1: var_eax = PostMessage(var_2C8, 256, 13, 0)
  loc_005E5A02: var_eax = PostMessage(var_2C8, 257, 13, 0)
  loc_005E5A11: var_eax = call Proc_79_0_601250(var_F0, var_0060C6B8, var_0060C6B8)
  loc_005E5A18: var_B0 = call Proc_79_0_601250(var_F0, var_0060C6B8, var_0060C6B8)
  loc_005E5A1E: If call Proc_79_0_601250(var_F0, var_0060C6B8, var_0060C6B8) = 0 Then GoTo loc_005E5A0F
  loc_005E5A44: var_2D8 = call Proc_79_0_601250(var_F0, var_0060C6B8, var_0060C6B8)
  loc_005E5A4A: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E5ABB: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E5AEF: If var_60C000 <> 0 Then GoTo loc_005E5AF9
  loc_005E5AF7: GoTo loc_005E5B0A
  loc_005E5AF9: 'Referenced from: 005E5AEF
  loc_005E5B0A: 'Referenced from: 005E5AF7
  loc_005E5B20: call __vbaStrR8
  loc_005E5B2E: var_E8 = __vbaStrR8
  loc_005E5B3E: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005E5BBD: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E5C02: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E5C42: var_2E8 = (var_E0 = var_E4)
  loc_005E5C79: If var_2E8 = 0 Then GoTo loc_005E5D8F
  loc_005E5CA6: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E5CCF: var_108 = var_E0
  loc_005E5CF1: var_248 = vbNullString
  loc_005E5D20: var_258 = vbNullString
  loc_005E5D49: var_140 = vbNullString & Left(var_E0, 2) & vbNullString
  loc_005E5D5C: var_B8 = CInt(Me)
  loc_005E5D8F: 'Referenced from: 005E5C79
  loc_005E5DB6: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E5DFB: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E5E37: eax = (var_E0 = var_E4) + 1
  loc_005E5E44: var_2E8 = (var_E0 = var_E4) + 1
  loc_005E5E71: If var_2E8 = 0 Then GoTo loc_005E5F87
  loc_005E5E98: var_2D8 = var_F0
  loc_005E5E9E: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E5EC8: var_108 = var_E0
  loc_005E5EDD: var_248 = vbNullString
  loc_005E5F18: var_258 = vbNullString
  loc_005E5F41: var_140 = vbNullString & Left(var_E0, 3) & vbNullString
  loc_005E5F54: var_B8 = CInt(var_F0)
  loc_005E5F87: 'Referenced from: 005E5E71
  loc_005E5FC5: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E6019: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005E6086: call __vbaCastObj(var_F8, var_F8, 0, var_00436CC0, Unknown_VTable_Call[eax+00000050h], var_E4, var_F4, var_F8, Me, Me, var_E0, var_F0, Set %StkVar1 = %StkVar2 'Ignore this, Me, 0, var_110)
  loc_005E60AB: var_eax = call Proc_79_50_609A50(var_FC, CInt(var_2D4), var_110)
  loc_005E6106: 
  loc_005E610B: If var_28 <> 0 Then GoTo loc_005E6269
  loc_005E612A: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005E612F: var_eax = call Proc_79_1_601500(, , )
  loc_005E6136: var_28 = call Proc_79_1_601500(, , )
  loc_005E6139: If call Proc_79_1_601500(, , ) <> 0 Then GoTo loc_005E6269
  loc_005E613F: var_eax = call Proc_79_0_601250(, , )
  loc_005E6152: var_B0 = call Proc_79_0_601250(, , )
  loc_005E6158: var_ret_5 = "_AOL_Icon"
  loc_005E6164: var_eax = FindWindowEx(var_B0, 0, var_ret_5, 0)
  loc_005E617D: var_CC = FindWindowEx(var_B0, 0, var_ret_5, 0)
  loc_005E618C: 
  loc_005E6196: If var_18 > 6 Then GoTo loc_005E61ED
  loc_005E61A6: var_ret_6 = "_AOL_Icon"
  loc_005E61B7: var_eax = FindWindowEx(var_B0, var_CC, var_ret_6, 0)
  loc_005E61CA: var_CC = FindWindowEx(var_B0, var_CC, var_ret_6, 0)
  loc_005E61E0: 00000001h = 00000001h + var_18
  loc_005E61EB: GoTo loc_005E618C
  loc_005E61ED: 'Referenced from: 005E6196
  loc_005E61F2: If var_28 <> 0 Then GoTo loc_005E6269
  loc_005E6213: var_eax = SendMessage(var_CC, 513, 0, 0)
  loc_005E6239: var_eax = SendMessage(var_CC, 514, 0, 0)
  loc_005E6259: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005E625E: GoTo loc_005E6106
  loc_005E6263: 
  loc_005E626F: var_eax = call Proc_79_1_601500(, , )
  loc_005E6282: var_28 = call Proc_79_1_601500(, , )
  loc_005E6285: var_ret_7 = "_AOL_Edit"
  loc_005E628E: var_eax = FindWindowEx(var_28, 0, var_ret_7, 0)
  loc_005E62A7: var_7C = FindWindowEx(var_28, 0, var_ret_7, 0)
  loc_005E62BA: var_ret_8 = "_AOL_Edit"
  loc_005E62C5: var_eax = FindWindowEx(var_28, var_7C, var_ret_8, 0)
  loc_005E62D8: var_74 = FindWindowEx(var_28, var_7C, var_ret_8, 0)
  loc_005E62F1: var_ret_9 = "_AOL_Edit"
  loc_005E62FC: var_eax = FindWindowEx(var_28, var_74, var_ret_9, 0)
  loc_005E6315: var_70 = FindWindowEx(var_28, var_74, var_ret_9, 0)
  loc_005E6328: var_ret_A = "RICHCNTL"
  loc_005E6331: var_eax = FindWindowEx(var_28, 0, var_ret_A, 0)
  loc_005E634A: var_1C = FindWindowEx(var_28, 0, var_ret_A, 0)
  loc_005E635D: var_ret_B = "_AOL_Combobox"
  loc_005E6366: var_eax = FindWindowEx(var_28, 0, var_ret_B, 0)
  loc_005E637F: var_6C = FindWindowEx(var_28, 0, var_ret_B, 0)
  loc_005E6392: var_ret_C = "_AOL_Fontcombo"
  loc_005E639B: var_eax = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_005E63B4: var_8C = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_005E63CA: var_ret_D = "_AOL_Icon"
  loc_005E63D3: var_eax = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_005E63EC: var_40 = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_005E63FF: var_ret_E = "_AOL_Icon"
  loc_005E640A: var_eax = FindWindowEx(var_28, var_40, var_ret_E, 0)
  loc_005E6423: var_54 = FindWindowEx(var_28, var_40, var_ret_E, 0)
  loc_005E6436: var_ret_F = "_AOL_Icon"
  loc_005E643F: var_eax = FindWindowEx(var_28, 0, var_ret_F, 0)
  loc_005E6458: var_CC = FindWindowEx(var_28, 0, var_ret_F, 0)
  loc_005E6467: 
  loc_005E6471: If var_18 > 13 Then GoTo loc_005E64C5
  loc_005E6481: var_ret_10 = "_AOL_Icon"
  loc_005E648F: var_eax = FindWindowEx(var_28, var_CC, var_ret_10, 0)
  loc_005E64A2: var_CC = FindWindowEx(var_28, var_CC, var_ret_10, 0)
  loc_005E64B8: 00000001h = 00000001h + var_18
  loc_005E64C3: GoTo loc_005E6467
  loc_005E64C5: 'Referenced from: 005E6471
  loc_005E64E1: var_E0 = CStr(0)
  loc_005E64FD: var_E4 = CStr(var_CC)
  loc_005E6512: var_E8 = var_E0 & var_E4
  loc_005E651F: fcomp real8 ptr var_378
  loc_005E6531: GoTo loc_005E6535
  loc_005E6535: 'Referenced from: 005E6531
  loc_005E6544: setnz al
  loc_005E654D: setnz cl
  loc_005E6558: setnz dl
  loc_005E6569: setnz cl
  loc_005E6574: setnz dl
  loc_005E6585: setnz cl
  loc_005E6590: setnz dl
  loc_005E65A1: setnz cl
  loc_005E65AC: setnz dl
  loc_005E65DB: If Not (edx) <> 0 Then GoTo loc_005E6263
  loc_005E6622: var_2C4 = mmoption.Check8.Value
  loc_005E6650: setz bl
  loc_005E665E: If ebx = 0 Then GoTo loc_005E6715
  loc_005E6668: var_eax = call Proc_79_45_608BE0(var_70, var_F0, var_0060C6CC)
  loc_005E6678: var_5C = call Proc_79_45_608BE0(var_70, var_F0, var_0060C6CC)
  loc_005E6681: var_248 = var_5C
  loc_005E6697: Len(var_5C) = Len(var_5C) - 00000005h
  loc_005E66EB: var_eax = SendMessage(var_70, 12, 0, Right(var_5C, Len(var_5C)))
  loc_005E66FD: var_ret_12 = var_E0
  loc_005E6715: 'Referenced from: 005E665E
  loc_005E673B: var_E0 = Text1.Text
  loc_005E6772: var_eax = SendMessage(var_7C, 12, 0, var_E0)
  loc_005E67B3: var_110 = Chr(13)
  loc_005E67BE: var_130 = Chr(10)
  loc_005E67E6: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005E6824: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E6860: var_158 = var_E0
  loc_005E6890: var_188 = var_E4
  loc_005E68CC: var_298 = var_B8
  loc_005E68E2: var_248 = "â¢bodini 4.0â¢ mass mailer â¢spekâ¢"
  loc_005E68EC: var_258 = "â¢mail "
  loc_005E68F6: var_268 = "â¢ of â¢"
  loc_005E690A: var_288 = "â¢this mm isâ¢ "
  loc_005E691E: var_2A8 = "% â¢doneâ¢"
  loc_005E69B0: var_1F0 = "â¢bodini 4.0â¢ mass mailer â¢spekâ¢" & var_110 & var_130 & "â¢mail " & var_E0 & "â¢ of â¢" & var_E4 & &H42EC60 & Chr(13) & Chr(10)
  loc_005E69F4: var_E8 = var_1F0 & "â¢this mm isâ¢ " & var_B8 & "% â¢doneâ¢"
  loc_005E6A38: var_eax = call Proc_3_4_5A51B0(var_240, var_AC, 3)
  loc_005E6A49: var_DC = var_240
  loc_005E6B2B: var_E0 = Text2.Text
  loc_005E6B69: var_E4 = vbNullString & var_E0
  loc_005E6B7B: var_118 = var_E4 & vbNullString
  loc_005E6BCB: var_248 = vbNullString
  loc_005E6BD1: var_268 = vbNullString
  loc_005E6BE6: var_258 = "<p align center><font face=""tahoma""><b>"
  loc_005E6C45: var_190 = var_E4 & vbNullString & Chr(13) & Chr(10) & vbNullString & "<p align center><font face=""tahoma""><b>" & var_DC & vbNullString
  loc_005E6C68: var_eax = SendMessage(var_1C, 12, 0, CStr(var_190))
  loc_005E6CF8: 
  loc_005E6CFD: If var_28 = 0 Then GoTo loc_005E75E0
  loc_005E6D17: var_ret_15 = "AOL Frame25"
  loc_005E6D1A: var_eax = FindWindow(var_ret_15, 0)
  loc_005E6D33: var_64 = FindWindow(var_ret_15, 0)
  loc_005E6D46: var_ret_16 = "MDICLIENT"
  loc_005E6D4F: var_eax = FindWindowEx(var_64, 0, var_ret_16, 0)
  loc_005E6D68: var_78 = FindWindowEx(var_64, 0, var_ret_16, 0)
  loc_005E6D79: var_ret_17 = "Error"
  loc_005E6D88: var_ret_18 = "AOL Child"
  loc_005E6D91: var_eax = FindWindowEx(var_78, 0, var_ret_18, var_ret_17)
  loc_005E6DB4: var_9C = FindWindowEx(var_78, 0, var_ret_18, var_ret_17)
  loc_005E6DCF: var_ret_19 = "America Online"
  loc_005E6DDE: var_ret_1A = "#32770"
  loc_005E6DE1: var_eax = FindWindow(var_ret_1A, var_ret_19)
  loc_005E6E04: var_88 = FindWindow(var_ret_1A, var_ret_19)
  loc_005E6E21: var_ret_1B = "Static"
  loc_005E6E2D: var_eax = FindWindowEx(var_88, 0, var_ret_1B, 0)
  loc_005E6E40: var_84 = FindWindowEx(var_88, 0, var_ret_1B, 0)
  loc_005E6E5C: var_ret_1C = "Static"
  loc_005E6E6D: var_eax = FindWindowEx(var_88, var_84, var_ret_1C, 0)
  loc_005E6E86: var_3C = FindWindowEx(var_88, var_84, var_ret_1C, 0)
  loc_005E6E93: If var_88 = 0 Then GoTo loc_005E6EE1
  loc_005E6E9B: var_eax = call Proc_79_45_608BE0(var_3C, 1, )
  loc_005E6ECA: var_2D8 = InStr(, call Proc_79_45_608BE0(var_3C, 1, ), "Please refrain from forwarding this message.", 0)
  loc_005E6EDB: If var_2D8 <> 0 Then GoTo loc_005E6FE5
  loc_005E6EE1: 'Referenced from: 005E6E93
  loc_005E6EE9: If var_9C <> 0 Then GoTo loc_005E7343
  loc_005E6EEF: var_eax = call Proc_79_1_601500(, , )
  loc_005E6F02: var_28 = call Proc_79_1_601500(, , )
  loc_005E6F05: var_ret_1D = "_AOL_Icon"
  loc_005E6F0E: var_eax = FindWindowEx(var_28, 0, var_ret_1D, 0)
  loc_005E6F27: var_CC = FindWindowEx(var_28, 0, var_ret_1D, 0)
  loc_005E6F36: 
  loc_005E6F40: If var_18 > 11 Then GoTo loc_005E6F94
  loc_005E6F50: var_ret_1E = "_AOL_Icon"
  loc_005E6F5E: var_eax = FindWindowEx(var_28, var_CC, var_ret_1E, 0)
  loc_005E6F71: var_CC = FindWindowEx(var_28, var_CC, var_ret_1E, 0)
  loc_005E6F87: 00000001h = 00000001h + var_18
  loc_005E6F92: GoTo loc_005E6F36
  loc_005E6F94: 'Referenced from: 005E6F40
  loc_005E6FB3: var_eax = SendMessage(var_CC, 513, 0, 0)
  loc_005E6FD9: var_eax = SendMessage(var_CC, 514, 0, 0)
  loc_005E6FE0: GoTo loc_005E6CF8
  loc_005E6FE5: 
  loc_005E6FF1: var_ret_1F = "America Online"
  loc_005E7000: var_ret_20 = "#32770"
  loc_005E7003: var_eax = FindWindow(var_ret_20, var_ret_1F)
  loc_005E7026: var_88 = FindWindow(var_ret_20, var_ret_1F)
  loc_005E7043: var_ret_21 = "Static"
  loc_005E704F: var_eax = FindWindowEx(var_88, 0, var_ret_21, 0)
  loc_005E7062: var_84 = FindWindowEx(var_88, 0, var_ret_21, 0)
  loc_005E707E: var_ret_22 = "Static"
  loc_005E708F: var_eax = FindWindowEx(var_88, var_84, var_ret_22, 0)
  loc_005E70A8: var_3C = FindWindowEx(var_88, var_84, var_ret_22, 0)
  loc_005E70B9: var_ret_23 = "OK"
  loc_005E70C8: var_ret_24 = "Button"
  loc_005E70D4: var_eax = FindWindowEx(var_88, 0, var_ret_24, var_ret_23)
  loc_005E710D: var_eax = call Proc_608D20(FindWindowEx(var_88, 0, var_ret_24, var_ret_23), , )
  loc_005E7112: var_eax = call Proc_79_1_601500(, , )
  loc_005E7124: var_eax = call Proc_608D70(call Proc_79_1_601500(, , ), , )
  loc_005E7142: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005E7153: var_ret_25 = "AOL Mail"
  loc_005E7162: var_ret_26 = "#32770"
  loc_005E7165: var_eax = FindWindow(var_ret_26, var_ret_25)
  loc_005E719D: var_ret_27 = "&Yes"
  loc_005E71AC: var_ret_28 = "Button"
  loc_005E71B2: var_eax = FindWindowEx(FindWindow(var_ret_26, var_ret_25), 0, var_ret_28, var_ret_27)
  loc_005E71B7: var_2C8 = FindWindowEx(var_2C8, 0, var_ret_28, var_ret_27)
  loc_005E71D5: var_24 = var_2C8
  loc_005E71ED: var_ret_29 = "&No"
  loc_005E71FC: var_ret_2A = "Button"
  loc_005E7204: var_eax = FindWindowEx(var_2C8, var_24, var_ret_2A, var_ret_29)
  loc_005E7225: var_C4 = FindWindowEx(var_2C8, var_24, var_ret_2A, var_ret_29)
  loc_005E723D: var_eax = call Proc_608D20(var_C4, , )
  loc_005E7249: var_eax = call Proc_608D20(var_C4, , )
  loc_005E7267: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005E726C: var_eax = call Proc_79_0_601250(, , )
  loc_005E7271: var_2C8 = call Proc_79_0_601250(, , )
  loc_005E727E: var_eax = call Proc_608D70(var_2C8, , )
  loc_005E729D: var_2E0 = call Proc_608D70(var_2C8, , )
  loc_005E72C6: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E7309: call __vbaStrR8
  loc_005E7317: var_E4 = __vbaStrR8
  loc_005E7331: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005E7338: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005E75AC
  loc_005E733E: GoTo loc_005E759D
  loc_005E7343: 'Referenced from: 005E6EE9
  loc_005E734F: var_ret_2B = "America Online"
  loc_005E735E: var_ret_2C = "#32770"
  loc_005E7361: var_eax = FindWindow(var_ret_2C, var_ret_2B)
  loc_005E7384: var_68 = FindWindow(var_ret_2C, var_ret_2B)
  loc_005E739C: var_ret_2D = "OK"
  loc_005E73AB: var_ret_2E = "Button"
  loc_005E73B4: var_eax = FindWindowEx(var_68, 0, var_ret_2E, var_ret_2D)
  loc_005E73ED: var_eax = call Proc_608D20(FindWindowEx(var_68, 0, var_ret_2E, var_ret_2D), , )
  loc_005E7400: var_ret_2F = "AOL Frame25"
  loc_005E7403: var_eax = FindWindow(var_ret_2F, 0)
  loc_005E741C: var_64 = FindWindow(var_ret_2F, 0)
  loc_005E741F: call var_2E0
  loc_005E742F: var_ret_30 = "MDICLIENT"
  loc_005E7438: var_eax = FindWindowEx(var_64, 0, var_ret_30, 0)
  loc_005E7451: var_78 = FindWindowEx(var_64, 0, var_ret_30, 0)
  loc_005E7454: call var_2E0
  loc_005E7462: var_ret_31 = "Error"
  loc_005E7471: var_ret_32 = "AOL Child"
  loc_005E747A: var_eax = FindWindowEx(var_78, 0, var_ret_32, var_ret_31)
  loc_005E74B3: var_eax = call Proc_608D70(FindWindowEx(var_78, 0, var_ret_32, var_ret_31), , )
  loc_005E74B8: var_eax = call Proc_79_0_601250(, , )
  loc_005E74CA: var_eax = call Proc_608D70(call Proc_79_0_601250(, , ), , )
  loc_005E74CF: var_eax = call Proc_79_1_601500(, , )
  loc_005E74D4: var_2C8 = call Proc_79_1_601500(, , )
  loc_005E74E1: var_eax = call Proc_608D70(var_2C8, , )
  loc_005E7500: var_2E0 = call Proc_608D70(var_2C8, , )
  loc_005E7529: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E756C: call __vbaStrR8
  loc_005E757A: var_E4 = __vbaStrR8
  loc_005E7594: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005E759B: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005E75AC
  loc_005E759D: 'Referenced from: 005E733E
  loc_005E75A6: Unknown_VTable_Call[eax+00000054h] = CheckObj(var_2E0, var_0042DCB0, 84)
  loc_005E75AC: 'Referenced from: 005E7338
  loc_005E75DB: GoTo loc_005E79A4
  loc_005E75E0: 'Referenced from: 005E6CFD
  loc_005E75E0: var_eax = call Proc_79_1_601500(, , )
  loc_005E75F2: var_eax = call Proc_608D70(call Proc_79_1_601500(, , ), , )
  loc_005E7604: var_eax = PostMessage(var_B0, 16, 0, 0)
  loc_005E7624: var_eax = call Proc_6098C0(CLng(0.45), , )
  loc_005E7646: var_2E0 = var_F4
  loc_005E766C: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005E76AF: call __vbaStrR8
  loc_005E76BD: var_E4 = __vbaStrR8
  loc_005E76CD: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005E7716: 'Referenced from: 005E58EC
  loc_005E775B: var_2C4 = mmoption.Check7.Value
  loc_005E778F: setz dl
  loc_005E77A8: If var_2E0 = 0 Then GoTo loc_005E79A6
  loc_005E77BC: var_ret_33 = "AOL Frame25"
  loc_005E77BF: var_eax = FindWindow(var_ret_33, 0)
  loc_005E77EC: var_ret_34 = "MDICLIENT"
  loc_005E77F2: var_eax = FindWindowEx(FindWindow(var_ret_33, 0), 0, var_ret_34, 0)
  loc_005E7816: var_eax = call Proc_79_47_609590(vbNullString, var_F0, var_0060C6CC)
  loc_005E7838: var_E4 = var_0060C6CC & call Proc_79_47_609590(vbNullString, var_F0, var_0060C6CC)
  loc_005E7860: var_ret_35 = var_E4 & "'s Online Mailbox"
  loc_005E7868: var_eax = FindWindowEx(FindWindowEx(var_2C8, 0, var_ret_34, 0), 0, 0, var_ret_35)
  loc_005E78B0: var_ret_36 = "_AOL_Icon"
  loc_005E78B6: var_eax = FindWindowEx(FindWindowEx(var_2C8, 0, 0, var_ret_35), 0, var_ret_36, 0)
  loc_005E792A: For var_38 = 1 To 2 Step 1
  loc_005E7930: 
  loc_005E7932: If var_31C = 0 Then GoTo loc_005E7964
  loc_005E7937: var_eax = GetWindowPlacement(FindWindowEx(var_2C8, 0, var_ret_36, 0), 2)
  loc_005E793C: var_2C8 = GetWindowPlacement(var_2C8, 2)
  loc_005E795C: Next var_38
  loc_005E7962: GoTo loc_005E7930
  loc_005E7964: 'Referenced from: 005E7932
  loc_005E797D: var_eax = SendMessage(0, 513, 0, 0)
  loc_005E799D: var_eax = SendMessage(0, 514, 0, 0)
  loc_005E79A4: 'Referenced from: 005E75DB
  loc_005E79A6: 'Referenced from: 005E77A8
  loc_005E79B8: Next var_50
  loc_005E79BE: var_350 = Next var_50
  loc_005E79C4: GoTo loc_005E583B
  loc_005E79C9: 'Referenced from: 005E5841
  loc_005E79DA: var_E0 = "â¢bodini 4.0â¢ mm â¢completedâ¢"
  loc_005E7A1E: var_eax = call Proc_3_4_5A51B0(var_120, var_AC, 3)
  loc_005E7A81: var_E0 = "<font face=""tahoma"">" & var_E4 & vbNullString
  loc_005E7A93: var_E4 = var_E0 & vbNullString
  loc_005E7A9C: var_eax = call Proc_79_17_604A50(var_E4, var_AC, var_E0)
  loc_005E7AFD: var_2C4 = mmoption.Check3.Value
  loc_005E7B2B: setz al
  loc_005E7B3C: If eax = 0 Then GoTo loc_005E7B43
  loc_005E7B3E: var_eax = call Proc_79_32_6072E0(var_F0, var_0060C6CC, var_0060C6CC)
  loc_005E7B43: 'Referenced from: 005E7B3C
  loc_005E7B80: var_2C4 = mmoption.Check5.Value
  loc_005E7BAE: setz dl
  loc_005E7BBF: If edx = 0 Then GoTo loc_005E7BEA
  loc_005E7BCC: var_E0 = "Sign Off"
  loc_005E7BD9: var_eax = call Proc_79_54_60A7D0(var_E0, var_F0, var_0060C6CC)
  loc_005E7BEA: 'Referenced from: 005E7BBF
  loc_005E7C08: var_2D8 = call Proc_79_54_60A7D0(var_E0, var_F0, var_0060C6CC)
  loc_005E7C0E: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005E7C59: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005E7CA4: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005E7D04: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E7D54: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E7DB7: call __vbaCastObj(var_100, var_F8, var_100, var_00436CC0, esi, var_E4, var_F4, esi, Me, var_F0, var_E0, var_F0, esi, Me, var_100, esi)
  loc_005E7DDC: var_eax = call Proc_79_50_609A50(var_FC, CInt(var_2D4), 5)
  loc_005E7E3A: GoTo loc_005E7F29
  loc_005E7F28: Exit Sub
  loc_005E7F29: 'Referenced from: 005E7E3A
  loc_005E7F83: Exit Sub
End Sub