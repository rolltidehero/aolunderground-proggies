ï»¿Private Sub Command4_Click() '5EDEA0
  Dim var_0060C6B8 As ListBox
  Dim var_2C8 As ListBox
  Dim var_0060C6CC As CheckBox
  Dim var_E0 As CheckBox
  loc_005EE072: var_2B4 = mmselect.List1.ListCount
  loc_005EE09D: var_2B4 = var_2B4 - 0001h
  loc_005EE0AD: var_248 = var_2B4
  loc_005EE0E1: For var_44 = "" To var_2B4 Step 1
  loc_005EE0ED: var_320 = var_2FC
  loc_005EE10B: If var_320 = 0 Then GoTo loc_005F0368
  loc_005EE159: var_44 = CInt(var_2B4)
  loc_005EE167: var_44 = mmselect.List1.Selected
  loc_005EE19D: setz dl
  loc_005EE1B6: If var_2D0 = 0 Then GoTo loc_005F0345
  loc_005EE1CA: var_ret_1 = "AOL Frame25"
  loc_005EE1CD: var_eax = FindWindow(var_ret_1, 0)
  loc_005EE1FA: var_ret_2 = "MDICLIENT"
  loc_005EE200: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_005EE22B: var_ret_3 = "Incoming/Saved Mail"
  loc_005EE23A: var_ret_4 = "AOL Child"
  loc_005EE240: var_eax = FindWindowEx(FindWindowEx(var_2B8, 0, var_ret_2, 0), 0, var_ret_4, var_ret_3)
  loc_005EE27A: var_ret_5 = "_AOL_Tree"
  loc_005EE280: var_eax = FindWindowEx(FindWindowEx(var_2B8, 0, var_ret_4, var_ret_3), 0, var_ret_5, 0)
  loc_005EE285: var_2B8 = FindWindowEx(var_2B8, 0, var_ret_5, 0)
  loc_005EE2B8: var_eax = SendMessage(0, 395, 0, 0)
  loc_005EE2E1: var_eax = SendMessage(var_2B8, 390, CLng(var_44), var_2B8)
  loc_005EE2F2: var_eax = PostMessage(var_2B8, 256, 13, 0)
  loc_005EE303: var_eax = PostMessage(var_2B8, 257, 13, 0)
  loc_005EE31B: var_eax = call Proc_6098C0(1, var_E0, var_0060C6B8)
  loc_005EE32C: var_ret_7 = "America Online"
  loc_005EE33B: var_ret_8 = "#32770"
  loc_005EE33E: var_eax = FindWindow(var_ret_8, var_ret_7)
  loc_005EE378: var_ret_9 = "Static"
  loc_005EE37E: var_eax = FindWindowEx(FindWindow(var_ret_8, var_ret_7), 0, var_ret_9, 0)
  loc_005EE383: var_2B8 = FindWindowEx(var_2B8, 0, var_ret_9, 0)
  loc_005EE391: var_1C = var_2B8
  loc_005EE3AE: var_ret_A = "Static"
  loc_005EE3B6: var_eax = FindWindowEx(var_2B8, var_1C, var_ret_A, 0)
  loc_005EE3C9: var_84 = FindWindowEx(var_2B8, var_1C, var_ret_A, 0)
  loc_005EE3DD: If var_2B8 = 0 Then GoTo loc_005EE5F6
  loc_005EE3EC: var_eax = call Proc_79_45_608BE0(var_84, 1, FindWindowEx(var_2B8, var_1C, var_ret_A, 0))
  loc_005EE3F9: var_D0 = call Proc_79_45_608BE0(var_84, 1, FindWindowEx(var_2B8, var_1C, var_ret_A, 0))
  loc_005EE426: If InStr(, var_D0, "That mail is no longer available or is not accessible to this account.", 0) = 0 Then GoTo loc_005EE5F6
  loc_005EE438: var_ret_B = "America Online"
  loc_005EE447: var_ret_C = "#32770"
  loc_005EE44A: var_eax = FindWindow(var_ret_C, var_ret_B)
  loc_005EE484: var_ret_D = "Static"
  loc_005EE48A: var_eax = FindWindowEx(FindWindow(var_ret_C, var_ret_B), 0, var_ret_D, 0)
  loc_005EE48F: var_2B8 = FindWindowEx(var_2B8, 0, var_ret_D, 0)
  loc_005EE4A3: var_1C = var_2B8
  loc_005EE4BA: var_ret_E = "Static"
  loc_005EE4C2: var_eax = FindWindowEx(var_2B8, var_1C, var_ret_E, 0)
  loc_005EE4C7: var_2B8 = FindWindowEx(var_2B8, var_1C, var_ret_E, 0)
  loc_005EE4DB: var_84 = var_2B8
  loc_005EE4F3: var_ret_F = "OK"
  loc_005EE502: var_ret_10 = "Button"
  loc_005EE508: var_eax = FindWindowEx(var_2B8, 0, var_ret_10, var_ret_F)
  loc_005EE53B: var_eax = call Proc_608D20(FindWindowEx(FindWindowEx(var_2B8, 0, var_ret_10, var_ret_F), 0, var_ret_10, var_ret_F), , )
  loc_005EE583: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EE5C6: call __vbaStrR8
  loc_005EE5D4: var_D4 = __vbaStrR8
  loc_005EE5E4: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005EE5EB: If Unknown_VTable_Call[edx+00000054h] >= 0 Then GoTo loc_005F0314
  loc_005EE5F1: GoTo loc_005F0305
  loc_005EE5F6: 'Referenced from: 005EE3DD
  loc_005EE5FE: var_eax = call Proc_79_0_601250(var_2D0, var_D4, )
  loc_005EE605: var_A4 = call Proc_79_0_601250(var_2D0, var_D4, )
  loc_005EE60B: If call Proc_79_0_601250(var_2D0, var_D4, ) = 0 Then GoTo loc_005EE5FC
  loc_005EE631: var_2C8 = call Proc_79_0_601250(var_2D0, var_D4, )
  loc_005EE637: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EE6A8: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EE6DC: If var_60C000 <> 0 Then GoTo loc_005EE6E6
  loc_005EE6E4: GoTo loc_005EE6F7
  loc_005EE6E6: 'Referenced from: 005EE6DC
  loc_005EE6F7: 'Referenced from: 005EE6E4
  loc_005EE70D: call __vbaStrR8
  loc_005EE71B: var_D8 = __vbaStrR8
  loc_005EE72B: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005EE7AA: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EE7EF: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EE82F: var_2D8 = (var_D0 = var_D4)
  loc_005EE866: If var_2D8 = 0 Then GoTo loc_005EE97C
  loc_005EE893: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EE8BC: var_F8 = var_D0
  loc_005EE8DE: var_238 = vbNullString
  loc_005EE90D: var_248 = vbNullString
  loc_005EE936: var_130 = vbNullString & Left(, 2) & vbNullString
  loc_005EE949: var_AC = CInt(Me)
  loc_005EE97C: 'Referenced from: 005EE866
  loc_005EE9A3: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EE9E8: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EEA24: eax = (var_D0 = var_D4) + 1
  loc_005EEA31: var_2D8 = (var_D0 = var_D4) + 1
  loc_005EEA5E: If var_2D8 = 0 Then GoTo loc_005EEB74
  loc_005EEA85: var_2C8 = var_E0
  loc_005EEA8B: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EEAB5: var_F8 = var_D0
  loc_005EEACA: var_238 = vbNullString
  loc_005EEB05: var_248 = vbNullString
  loc_005EEB2E: var_130 = vbNullString & Left(, 3) & vbNullString
  loc_005EEB41: var_AC = CInt(var_E0)
  loc_005EEB74: 'Referenced from: 005EEA5E
  loc_005EEBB2: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EEC06: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005EEC73: call __vbaCastObj(var_E8, var_E8, 0, var_00436CC0, Unknown_VTable_Call[eax+00000050h], var_D4, var_E4, var_E8, Me, Me, var_D0, var_E0, Set %StkVar1 = %StkVar2 'Ignore this, Me, 0, var_100)
  loc_005EEC98: var_eax = call Proc_79_50_609A50(var_EC, CInt(var_2C4), var_100)
  loc_005EECF3: 
  loc_005EECF8: If var_2C <> 0 Then GoTo loc_005EEE56
  loc_005EED17: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005EED1C: var_eax = call Proc_79_1_601500(, , )
  loc_005EED23: var_2C = call Proc_79_1_601500(, , )
  loc_005EED26: If call Proc_79_1_601500(, , ) <> 0 Then GoTo loc_005EEE56
  loc_005EED2C: var_eax = call Proc_79_0_601250(, , )
  loc_005EED3F: var_A4 = call Proc_79_0_601250(, , )
  loc_005EED45: var_ret_11 = "_AOL_Icon"
  loc_005EED51: var_eax = FindWindowEx(var_A4, 0, var_ret_11, 0)
  loc_005EED6A: var_BC = FindWindowEx(var_A4, 0, var_ret_11, 0)
  loc_005EED79: 
  loc_005EED83: If var_18 > 6 Then GoTo loc_005EEDDA
  loc_005EED93: var_ret_12 = "_AOL_Icon"
  loc_005EEDA4: var_eax = FindWindowEx(var_A4, var_BC, var_ret_12, 0)
  loc_005EEDB7: var_BC = FindWindowEx(var_A4, var_BC, var_ret_12, 0)
  loc_005EEDCD: 00000001h = 00000001h + var_18
  loc_005EEDD8: GoTo loc_005EED79
  loc_005EEDDA: 'Referenced from: 005EED83
  loc_005EEDDF: If var_2C <> 0 Then GoTo loc_005EEE56
  loc_005EEE00: var_eax = SendMessage(var_BC, 513, 0, 0)
  loc_005EEE26: var_eax = SendMessage(var_BC, 514, 0, 0)
  loc_005EEE46: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005EEE4B: GoTo loc_005EECF3
  loc_005EEE50: 
  loc_005EEE5C: var_eax = call Proc_79_1_601500(, , )
  loc_005EEE6F: var_2C = call Proc_79_1_601500(, , )
  loc_005EEE72: var_ret_13 = "_AOL_Edit"
  loc_005EEE7B: var_eax = FindWindowEx(var_2C, 0, var_ret_13, 0)
  loc_005EEE94: var_6C = FindWindowEx(var_2C, 0, var_ret_13, 0)
  loc_005EEEA7: var_ret_14 = "_AOL_Edit"
  loc_005EEEB2: var_eax = FindWindowEx(var_2C, var_6C, var_ret_14, 0)
  loc_005EEEC5: var_68 = FindWindowEx(var_2C, var_6C, var_ret_14, 0)
  loc_005EEEDE: var_ret_15 = "_AOL_Edit"
  loc_005EEEE9: var_eax = FindWindowEx(var_2C, var_68, var_ret_15, 0)
  loc_005EEF02: var_64 = FindWindowEx(var_2C, var_68, var_ret_15, 0)
  loc_005EEF15: var_ret_16 = "RICHCNTL"
  loc_005EEF1E: var_eax = FindWindowEx(var_2C, 0, var_ret_16, 0)
  loc_005EEF37: var_24 = FindWindowEx(var_2C, 0, var_ret_16, 0)
  loc_005EEF4A: var_ret_17 = "_AOL_Combobox"
  loc_005EEF53: var_eax = FindWindowEx(var_2C, 0, var_ret_17, 0)
  loc_005EEF6C: var_60 = FindWindowEx(var_2C, 0, var_ret_17, 0)
  loc_005EEF7F: var_ret_18 = "_AOL_Fontcombo"
  loc_005EEF88: var_eax = FindWindowEx(var_2C, 0, var_ret_18, 0)
  loc_005EEFA1: var_80 = FindWindowEx(var_2C, 0, var_ret_18, 0)
  loc_005EEFB4: var_ret_19 = "_AOL_Icon"
  loc_005EEFBD: var_eax = FindWindowEx(var_2C, 0, var_ret_19, 0)
  loc_005EEFD6: var_34 = FindWindowEx(var_2C, 0, var_ret_19, 0)
  loc_005EEFE9: var_ret_1A = "_AOL_Icon"
  loc_005EEFF4: var_eax = FindWindowEx(var_2C, var_34, var_ret_1A, 0)
  loc_005EF00D: var_48 = FindWindowEx(var_2C, var_34, var_ret_1A, 0)
  loc_005EF020: var_ret_1B = "_AOL_Icon"
  loc_005EF029: var_eax = FindWindowEx(var_2C, 0, var_ret_1B, 0)
  loc_005EF042: var_BC = FindWindowEx(var_2C, 0, var_ret_1B, 0)
  loc_005EF051: 
  loc_005EF05B: If var_18 > 13 Then GoTo loc_005EF0AF
  loc_005EF06B: var_ret_1C = "_AOL_Icon"
  loc_005EF079: var_eax = FindWindowEx(var_2C, var_BC, var_ret_1C, 0)
  loc_005EF08C: var_BC = FindWindowEx(var_2C, var_BC, var_ret_1C, 0)
  loc_005EF0A2: 00000001h = 00000001h + var_18
  loc_005EF0AD: GoTo loc_005EF051
  loc_005EF0AF: 'Referenced from: 005EF05B
  loc_005EF0C8: var_D0 = CStr(0)
  loc_005EF0E4: var_D4 = CStr(var_BC)
  loc_005EF0F9: var_D8 = var_D0 & var_D4
  loc_005EF106: fcomp real8 ptr var_348
  loc_005EF118: GoTo loc_005EF11C
  loc_005EF11C: 'Referenced from: 005EF118
  loc_005EF12B: setnz al
  loc_005EF134: setnz cl
  loc_005EF13F: setnz dl
  loc_005EF150: setnz cl
  loc_005EF15B: setnz dl
  loc_005EF16C: setnz cl
  loc_005EF177: setnz dl
  loc_005EF188: setnz cl
  loc_005EF193: setnz dl
  loc_005EF1C2: If Not (edx) <> 0 Then GoTo loc_005EEE50
  loc_005EF209: var_2B4 = mmoption.Check8.Value
  loc_005EF237: setz bl
  loc_005EF245: If ebx = 0 Then GoTo loc_005EF2FC
  loc_005EF24F: var_eax = call Proc_79_45_608BE0(var_64, var_E0, var_0060C6CC)
  loc_005EF25F: var_50 = call Proc_79_45_608BE0(var_64, var_E0, var_0060C6CC)
  loc_005EF268: var_238 = var_50
  loc_005EF27E: Len(var_50) = Len(var_50) - 00000005h
  loc_005EF2D2: var_eax = SendMessage(var_64, 12, 0, Right(var_50, Len(var_50)))
  loc_005EF2E4: var_ret_1E = var_D0
  loc_005EF2FC: 'Referenced from: 005EF245
  loc_005EF322: var_D0 = Text1.Text
  loc_005EF359: var_eax = SendMessage(var_6C, 12, 0, var_D0)
  loc_005EF39A: var_100 = Chr(13)
  loc_005EF3A5: var_120 = Chr(10)
  loc_005EF3CD: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005EF40B: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EF447: var_148 = var_D0
  loc_005EF477: var_178 = var_D4
  loc_005EF4B3: var_288 = var_AC
  loc_005EF4C9: var_238 = "â¢bodini 4.0â¢ mass mailer â¢spekâ¢"
  loc_005EF4D3: var_248 = "â¢mail "
  loc_005EF4DD: var_258 = "â¢ of â¢"
  loc_005EF4F1: var_278 = "â¢this mm isâ¢ "
  loc_005EF505: var_298 = "% â¢doneâ¢"
  loc_005EF597: var_1E0 = "â¢bodini 4.0â¢ mass mailer â¢spekâ¢" & var_100 & var_120 & "â¢mail " & var_D0 & "â¢ of â¢" & var_D4 & &H42EC60 & Chr(13) & Chr(10)
  loc_005EF5DB: var_D8 = var_1E0 & "â¢this mm isâ¢ " & var_AC & "% â¢doneâ¢"
  loc_005EF61F: var_eax = call Proc_3_4_5A51B0(var_230, var_A0, 3)
  loc_005EF630: var_CC = var_230
  loc_005EF712: var_D0 = Text2.Text
  loc_005EF750: var_D4 = vbNullString & var_D0
  loc_005EF762: var_108 = var_D4 & vbNullString
  loc_005EF7B2: var_238 = vbNullString
  loc_005EF7B8: var_258 = vbNullString
  loc_005EF7CD: var_248 = "<p align center><font face=""tahoma""><b>"
  loc_005EF82C: var_180 = var_D4 & vbNullString & Chr(13) & Chr(10) & vbNullString & "<p align center><font face=""tahoma""><b>" & var_CC & vbNullString
  loc_005EF84F: var_eax = SendMessage(var_24, 12, 0, CStr(var_180))
  loc_005EF8DF: 
  loc_005EF8E4: If var_2C = 0 Then GoTo loc_005F020F
  loc_005EF8FE: var_ret_21 = "AOL Frame25"
  loc_005EF901: var_eax = FindWindow(var_ret_21, 0)
  loc_005EF91A: var_58 = FindWindow(var_ret_21, 0)
  loc_005EF92D: var_ret_22 = "MDICLIENT"
  loc_005EF936: var_eax = FindWindowEx(var_58, 0, var_ret_22, 0)
  loc_005EF94F: var_74 = FindWindowEx(var_58, 0, var_ret_22, 0)
  loc_005EF960: var_ret_23 = "Error"
  loc_005EF96F: var_ret_24 = "AOL Child"
  loc_005EF978: var_eax = FindWindowEx(var_74, 0, var_ret_24, var_ret_23)
  loc_005EF99B: var_90 = FindWindowEx(var_74, 0, var_ret_24, var_ret_23)
  loc_005EF9B6: var_ret_25 = "America Online"
  loc_005EF9C5: var_ret_26 = "#32770"
  loc_005EF9C8: var_eax = FindWindow(var_ret_26, var_ret_25)
  loc_005EF9EB: var_7C = FindWindow(var_ret_26, var_ret_25)
  loc_005EFA05: var_ret_27 = "Static"
  loc_005EFA0E: var_eax = FindWindowEx(var_7C, 0, var_ret_27, 0)
  loc_005EFA21: var_78 = FindWindowEx(var_7C, 0, var_ret_27, 0)
  loc_005EFA3A: var_ret_28 = "Static"
  loc_005EFA45: var_eax = FindWindowEx(var_7C, var_78, var_ret_28, 0)
  loc_005EFA5E: var_30 = FindWindowEx(var_7C, var_78, var_ret_28, 0)
  loc_005EFA68: If var_7C = 0 Then GoTo loc_005EFB41
  loc_005EFA74: var_eax = call Proc_79_45_608BE0(var_30, 1, )
  loc_005EFA9B: var_34C = InStr(, call Proc_79_45_608BE0(var_30, 1, ), "That mail is no longer available for forwarding.", 0)
  loc_005EFAA2: var_eax = call Proc_79_45_608BE0(var_30, 1, )
  loc_005EFAD1: var_34C = InStr(, call Proc_79_45_608BE0(var_30, 1, ), "The original message is no longer available or was not received by this address.", 0)
  loc_005EFAD8: var_eax = call Proc_79_45_608BE0(var_30, 1, )
  loc_005EFB13: var_2C8 = InStr(, call Proc_79_45_608BE0(var_30, 1, ), "Please refrain from forwarding this message.", 0)
  loc_005EFB3B: If var_2C8 <> 0 Then GoTo loc_005EFC45
  loc_005EFB41: 'Referenced from: 005EFA68
  loc_005EFB49: If var_90 <> 0 Then GoTo loc_005EFF87
  loc_005EFB4F: var_eax = call Proc_79_1_601500(, , )
  loc_005EFB62: var_2C = call Proc_79_1_601500(, , )
  loc_005EFB65: var_ret_29 = "_AOL_Icon"
  loc_005EFB6E: var_eax = FindWindowEx(var_2C, 0, var_ret_29, 0)
  loc_005EFB81: var_BC = FindWindowEx(var_2C, 0, var_ret_29, 0)
  loc_005EFB96: 
  loc_005EFBA0: If var_18 > 11 Then GoTo loc_005EFBF4
  loc_005EFBB0: var_ret_2A = "_AOL_Icon"
  loc_005EFBBE: var_eax = FindWindowEx(var_2C, var_BC, var_ret_2A, 0)
  loc_005EFBD7: var_BC = FindWindowEx(var_2C, var_BC, var_ret_2A, 0)
  loc_005EFBE7: 00000001h = 00000001h + var_18
  loc_005EFBF2: GoTo loc_005EFB96
  loc_005EFBF4: 'Referenced from: 005EFBA0
  loc_005EFC13: var_eax = SendMessage(var_BC, 513, 0, 0)
  loc_005EFC39: var_eax = SendMessage(var_BC, 514, 0, 0)
  loc_005EFC40: GoTo loc_005EF8DF
  loc_005EFC45: 
  loc_005EFC51: var_ret_2B = "America Online"
  loc_005EFC60: var_ret_2C = "#32770"
  loc_005EFC63: var_eax = FindWindow(var_ret_2C, var_ret_2B)
  loc_005EFC86: var_7C = FindWindow(var_ret_2C, var_ret_2B)
  loc_005EFCA0: var_ret_2D = "Static"
  loc_005EFCA9: var_eax = FindWindowEx(var_7C, 0, var_ret_2D, 0)
  loc_005EFCC2: var_78 = FindWindowEx(var_7C, 0, var_ret_2D, 0)
  loc_005EFCD5: var_ret_2E = "Static"
  loc_005EFCE0: var_eax = FindWindowEx(var_7C, var_78, var_ret_2E, 0)
  loc_005EFCF9: var_30 = FindWindowEx(var_7C, var_78, var_ret_2E, 0)
  loc_005EFD0A: var_ret_2F = "OK"
  loc_005EFD19: var_ret_30 = "Button"
  loc_005EFD22: var_eax = FindWindowEx(var_7C, 0, var_ret_30, var_ret_2F)
  loc_005EFD5B: var_eax = call Proc_608D20(FindWindowEx(var_7C, 0, var_ret_30, var_ret_2F), , )
  loc_005EFD60: var_eax = call Proc_79_1_601500(, , )
  loc_005EFD72: var_eax = call Proc_608D70(call Proc_79_1_601500(, , ), , )
  loc_005EFD90: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005EFDA1: var_ret_31 = "AOL Mail"
  loc_005EFDB0: var_ret_32 = "#32770"
  loc_005EFDB3: var_eax = FindWindow(var_ret_32, var_ret_31)
  loc_005EFDEB: var_ret_33 = "&Yes"
  loc_005EFDFA: var_ret_34 = "Button"
  loc_005EFE00: var_eax = FindWindowEx(FindWindow(var_ret_32, var_ret_31), 0, var_ret_34, var_ret_33)
  loc_005EFE05: var_2B8 = FindWindowEx(var_2B8, 0, var_ret_34, var_ret_33)
  loc_005EFE23: var_28 = var_2B8
  loc_005EFE3B: var_ret_35 = "&No"
  loc_005EFE4A: var_ret_36 = "Button"
  loc_005EFE52: var_eax = FindWindowEx(var_2B8, var_28, var_ret_36, var_ret_35)
  loc_005EFE73: var_B4 = FindWindowEx(var_2B8, var_28, var_ret_36, var_ret_35)
  loc_005EFE8B: var_eax = call Proc_608D20(var_B4, , )
  loc_005EFE97: var_eax = call Proc_608D20(var_B4, , )
  loc_005EFEB5: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005EFEBA: var_eax = call Proc_79_0_601250(, , )
  loc_005EFECC: var_eax = call Proc_608D70(call Proc_79_0_601250(, , ), , )
  loc_005EFEEE: var_2D0 = var_E4
  loc_005EFF14: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005EFF57: call __vbaStrR8
  loc_005EFF65: var_D4 = __vbaStrR8
  loc_005EFF75: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005EFF7C: If Unknown_VTable_Call[ecx+00000054h] >= 0 Then GoTo loc_005F01E6
  loc_005EFF82: GoTo loc_005F01D7
  loc_005EFF87: 'Referenced from: 005EFB49
  loc_005EFF93: var_ret_37 = "America Online"
  loc_005EFFA2: var_ret_38 = "#32770"
  loc_005EFFA5: var_eax = FindWindow(var_ret_38, var_ret_37)
  loc_005EFFC8: var_5C = FindWindow(var_ret_38, var_ret_37)
  loc_005EFFE0: var_ret_39 = "OK"
  loc_005EFFEF: var_ret_3A = "Button"
  loc_005EFFF8: var_eax = FindWindowEx(var_5C, 0, var_ret_3A, var_ret_39)
  loc_005F0031: var_eax = call Proc_608D20(FindWindowEx(var_5C, 0, var_ret_3A, var_ret_39), , )
  loc_005F0044: var_ret_3B = "AOL Frame25"
  loc_005F0047: var_eax = FindWindow(var_ret_3B, 0)
  loc_005F005A: var_58 = FindWindow(var_ret_3B, 0)
  loc_005F0063: call var_2D0
  loc_005F0073: var_ret_3C = "MDICLIENT"
  loc_005F007C: var_eax = FindWindowEx(var_58, 0, var_ret_3C, 0)
  loc_005F008F: var_74 = FindWindowEx(var_58, 0, var_ret_3C, 0)
  loc_005F0098: call var_2D0
  loc_005F00A6: var_ret_3D = "Error"
  loc_005F00B5: var_ret_3E = "AOL Child"
  loc_005F00BE: var_eax = FindWindowEx(var_74, 0, var_ret_3E, var_ret_3D)
  loc_005F00F7: var_eax = call Proc_608D70(FindWindowEx(var_74, 0, var_ret_3E, var_ret_3D), , )
  loc_005F00FC: var_eax = call Proc_79_0_601250(, , )
  loc_005F010E: var_eax = call Proc_608D70(call Proc_79_0_601250(, , ), , )
  loc_005F0113: var_eax = call Proc_79_1_601500(, , )
  loc_005F0125: var_eax = call Proc_608D70(call Proc_79_1_601500(, , ), , )
  loc_005F0147: var_2D0 = var_E4
  loc_005F016D: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005F01B0: call __vbaStrR8
  loc_005F01BE: var_D4 = __vbaStrR8
  loc_005F01CE: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F01D5: If Unknown_VTable_Call[ecx+00000054h] >= 0 Then GoTo loc_005F01E6
  loc_005F01D7: 'Referenced from: 005EFF82
  loc_005F01E0: Unknown_VTable_Call[ecx+00000054h] = CheckObj(var_2D0, var_0042DCB0, 84)
  loc_005F01E6: 'Referenced from: 005EFF7C
  loc_005F020A: GoTo loc_005F0338
  loc_005F020F: 'Referenced from: 005EF8E4
  loc_005F020F: var_eax = call Proc_79_1_601500(var_E0, var_E4, var_2D0)
  loc_005F0221: var_eax = call Proc_608D70(call Proc_79_1_601500(var_E0, var_E4, var_2D0), var_D4, )
  loc_005F0233: var_eax = PostMessage(var_A4, 16, 0, 0)
  loc_005F0253: var_eax = call Proc_6098C0(CLng(0.45), , )
  loc_005F029B: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005F02DE: call __vbaStrR8
  loc_005F02EC: var_D4 = __vbaStrR8
  loc_005F02FC: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005F0303: If Unknown_VTable_Call[edx+00000054h] >= 0 Then GoTo loc_005F0314
  loc_005F0305: 'Referenced from: 005EE5F1
  loc_005F030E: Unknown_VTable_Call[edx+00000054h] = CheckObj(var_2D0, var_0042DCB0, 84)
  loc_005F0314: 'Referenced from: 005EE5EB
  loc_005F0338: 'Referenced from: 005F020A
  loc_005F0345: 'Referenced from: 005EE1B6
  loc_005F0357: Next var_44
  loc_005F035D: var_320 = Next var_44
  loc_005F0363: GoTo loc_005EE105
  loc_005F0368: 'Referenced from: 005EE10B
  loc_005F0379: var_D0 = "â¢bodini 4.0â¢ mm â¢completedâ¢"
  loc_005F03BD: var_eax = call Proc_3_4_5A51B0(var_110, var_A0, 3)
  loc_005F0420: var_D0 = "<font face=""tahoma"">" & var_D4 & vbNullString
  loc_005F0432: var_D4 = var_D0 & vbNullString
  loc_005F043B: var_eax = call Proc_79_17_604A50(var_D4, var_A0, var_D0)
  loc_005F049C: var_2B4 = mmoption.Check3.Value
  loc_005F04CA: setz al
  loc_005F04DB: If eax = 0 Then GoTo loc_005F04E2
  loc_005F04DD: var_eax = call Proc_79_32_6072E0(var_E0, var_0060C6CC, var_0060C6CC)
  loc_005F04E2: 'Referenced from: 005F04DB
  loc_005F051F: var_2B4 = mmoption.Check5.Value
  loc_005F054D: setz dl
  loc_005F055E: If edx = 0 Then GoTo loc_005F0589
  loc_005F056B: var_D0 = "Sign Off"
  loc_005F0578: var_eax = call Proc_79_54_60A7D0(var_D0, var_E0, var_0060C6CC)
  loc_005F0589: 'Referenced from: 005F055E
  loc_005F05A7: var_2C8 = call Proc_79_54_60A7D0(var_D0, var_E0, var_0060C6CC)
  loc_005F05AD: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F05F8: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005F0643: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F06A3: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005F06F3: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005F0756: call __vbaCastObj(var_F0, var_E8, var_F0, var_00436CC0, esi, var_D4, var_E4, esi, Me, var_E0, var_D0, var_E0, esi, Me, var_F0, esi)
  loc_005F077B: var_eax = call Proc_79_50_609A50(var_EC, CInt(var_2C4), 5)
  loc_005F07D9: GoTo loc_005F08C8
  loc_005F08C7: Exit Sub
  loc_005F08C8: 'Referenced from: 005F07D9
  loc_005F090F: Exit Sub
End Sub