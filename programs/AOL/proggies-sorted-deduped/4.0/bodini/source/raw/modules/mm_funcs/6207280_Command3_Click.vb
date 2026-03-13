Private Sub Command3_Click() '5EB730
  Dim var_0060C6B8 As ListBox
  Dim var_2C0 As ListBox
  Dim var_0060C6CC As CheckBox
  loc_005EB8F3: var_2AC = mmselect.List1.ListCount
  loc_005EB91E: var_2AC = var_2AC - 0001h
  loc_005EB92E: var_240 = var_2AC
  loc_005EB962: For var_40 = "" To var_2AC Step 1
  loc_005EB96E: var_318 = var_2F4
  loc_005EB98C: If var_318 = 0 Then GoTo loc_005ED8BF
  loc_005EB9DA: var_40 = CInt(var_2AC)
  loc_005EB9E8: var_40 = mmselect.List1.Selected
  loc_005EBA1E: setz dl
  loc_005EBA37: If var_2C8 = 0 Then GoTo loc_005ED89C
  loc_005EBA3D: var_eax = call Proc_79_8_6029E0(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005EBA44: var_48 = call Proc_79_8_6029E0(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005EBA47: If call Proc_79_8_6029E0(var_D8, var_0060C6B8, var_0060C6B8) = 0 Then GoTo loc_005EDD27
  loc_005EBA5B: var_ret_1 = "_AOL_TabControl"
  loc_005EBA64: var_eax = FindWindowEx(var_48, 0, var_ret_1, 0)
  loc_005EBA91: var_ret_2 = "_AOL_TabPage"
  loc_005EBA97: var_eax = FindWindowEx(FindWindowEx(var_48, 0, var_ret_1, 0), 0, var_ret_2, 0)
  loc_005EBA9C: var_2B0 = FindWindowEx(var_2B0, 0, var_ret_2, 0)
  loc_005EBAB0: var_9C = var_2B0
  loc_005EBACA: var_ret_3 = "_AOL_TabPage"
  loc_005EBAD5: var_eax = FindWindowEx(var_2B0, var_9C, var_ret_3, 0)
  loc_005EBADA: var_2B0 = FindWindowEx(var_2B0, var_9C, var_ret_3, 0)
  loc_005EBAEE: var_9C = var_2B0
  loc_005EBB08: var_ret_4 = "_AOL_TabPage"
  loc_005EBB13: var_eax = FindWindowEx(var_2B0, var_9C, var_ret_4, 0)
  loc_005EBB40: var_ret_5 = "_AOL_Tree"
  loc_005EBB46: var_eax = FindWindowEx(FindWindowEx(var_2B0, var_9C, var_ret_4, 0), 0, var_ret_5, 0)
  loc_005EBB4B: var_2B0 = FindWindowEx(var_2B0, 0, var_ret_5, 0)
  loc_005EBB7E: var_eax = SendMessage(0, 395, 0, 0)
  loc_005EBBA7: var_eax = SendMessage(var_2B0, 390, CLng(var_40), var_2B0)
  loc_005EBBB8: var_eax = PostMessage(var_2B0, 256, 13, 0)
  loc_005EBBC9: var_eax = PostMessage(var_2B0, 257, 13, 0)
  loc_005EBBD8: var_eax = call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005EBBDF: var_98 = call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005EBBE5: If call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8) = 0 Then GoTo loc_005EBBD6
  loc_005EBC0B: var_2C0 = call Proc_79_0_601250(var_D8, var_0060C6B8, var_0060C6B8)
  loc_005EBC11: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EBC82: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EBCB6: If var_60C000 <> 0 Then GoTo loc_005EBCC0
  loc_005EBCBE: GoTo loc_005EBCD1
  loc_005EBCC0: 'Referenced from: 005EBCB6
  loc_005EBCD1: 'Referenced from: 005EBCBE
  loc_005EBCE7: call __vbaStrR8
  loc_005EBCF5: var_D0 = __vbaStrR8
  loc_005EBD05: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005EBD84: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EBDC9: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EBE09: var_2D0 = (var_C8 = var_CC)
  loc_005EBE40: If var_2D0 = 0 Then GoTo loc_005EBF56
  loc_005EBE6D: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EBE96: var_F0 = var_C8
  loc_005EBEB8: var_230 = vbNullString
  loc_005EBEE7: var_240 = vbNullString
  loc_005EBF10: var_128 = vbNullString & Left(var_C8, 2) & vbNullString
  loc_005EBF23: var_A0 = CInt(Me)
  loc_005EBF56: 'Referenced from: 005EBE40
  loc_005EBF7D: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EBFC2: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EBFFE: eax = (var_C8 = var_CC) + 1
  loc_005EC00B: var_2D0 = (var_C8 = var_CC) + 1
  loc_005EC038: If var_2D0 = 0 Then GoTo loc_005EC14E
  loc_005EC05F: var_2C0 = var_D8
  loc_005EC065: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EC08F: var_F0 = var_C8
  loc_005EC0A4: var_230 = vbNullString
  loc_005EC0DF: var_240 = vbNullString
  loc_005EC108: var_128 = vbNullString & Left(var_C8, 3) & vbNullString
  loc_005EC11B: var_A0 = CInt(var_D8)
  loc_005EC14E: 'Referenced from: 005EC038
  loc_005EC18C: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EC1E0: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005EC24D: call __vbaCastObj(var_E0, var_E0, 0, var_00436CC0, Unknown_VTable_Call[eax+00000050h], var_CC, var_DC, var_E0, Me, Me, var_C8, var_D8, Set %StkVar1 = %StkVar2 'Ignore this, Me, 0, var_F8)
  loc_005EC272: var_eax = call Proc_79_50_609A50(var_E4, CInt(var_2BC), var_F8)
  loc_005EC2CD: 
  loc_005EC2D2: If var_28 <> 0 Then GoTo loc_005EC430
  loc_005EC2F1: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005EC2F6: var_eax = call Proc_79_1_601500(, , )
  loc_005EC2FD: var_28 = call Proc_79_1_601500(, , )
  loc_005EC300: If call Proc_79_1_601500(, , ) <> 0 Then GoTo loc_005EC430
  loc_005EC306: var_eax = call Proc_79_0_601250(, , )
  loc_005EC319: var_98 = call Proc_79_0_601250(, , )
  loc_005EC31F: var_ret_7 = "_AOL_Icon"
  loc_005EC32B: var_eax = FindWindowEx(var_98, 0, var_ret_7, 0)
  loc_005EC344: var_B4 = FindWindowEx(var_98, 0, var_ret_7, 0)
  loc_005EC353: 
  loc_005EC35D: If var_18 > 6 Then GoTo loc_005EC3B4
  loc_005EC36D: var_ret_8 = "_AOL_Icon"
  loc_005EC37E: var_eax = FindWindowEx(var_98, var_B4, var_ret_8, 0)
  loc_005EC391: var_B4 = FindWindowEx(var_98, var_B4, var_ret_8, 0)
  loc_005EC3A7: 00000001h = 00000001h + var_18
  loc_005EC3B2: GoTo loc_005EC353
  loc_005EC3B4: 'Referenced from: 005EC35D
  loc_005EC3B9: If var_28 <> 0 Then GoTo loc_005EC430
  loc_005EC3DA: var_eax = SendMessage(var_B4, 513, 0, 0)
  loc_005EC400: var_eax = SendMessage(var_B4, 514, 0, 0)
  loc_005EC420: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005EC425: GoTo loc_005EC2CD
  loc_005EC42A: 
  loc_005EC436: var_eax = call Proc_79_1_601500(, , )
  loc_005EC449: var_28 = call Proc_79_1_601500(, , )
  loc_005EC44C: var_ret_9 = "_AOL_Edit"
  loc_005EC455: var_eax = FindWindowEx(var_28, 0, var_ret_9, 0)
  loc_005EC46E: var_6C = FindWindowEx(var_28, 0, var_ret_9, 0)
  loc_005EC481: var_ret_A = "_AOL_Edit"
  loc_005EC48C: var_eax = FindWindowEx(var_28, var_6C, var_ret_A, 0)
  loc_005EC49F: var_64 = FindWindowEx(var_28, var_6C, var_ret_A, 0)
  loc_005EC4B8: var_ret_B = "_AOL_Edit"
  loc_005EC4C3: var_eax = FindWindowEx(var_28, var_64, var_ret_B, 0)
  loc_005EC4DC: var_60 = FindWindowEx(var_28, var_64, var_ret_B, 0)
  loc_005EC4EF: var_ret_C = "RICHCNTL"
  loc_005EC4F8: var_eax = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_005EC511: var_1C = FindWindowEx(var_28, 0, var_ret_C, 0)
  loc_005EC524: var_ret_D = "_AOL_Combobox"
  loc_005EC52D: var_eax = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_005EC546: var_5C = FindWindowEx(var_28, 0, var_ret_D, 0)
  loc_005EC559: var_ret_E = "_AOL_Fontcombo"
  loc_005EC562: var_eax = FindWindowEx(var_28, 0, var_ret_E, 0)
  loc_005EC57B: var_78 = FindWindowEx(var_28, 0, var_ret_E, 0)
  loc_005EC58E: var_ret_F = "_AOL_Icon"
  loc_005EC597: var_eax = FindWindowEx(var_28, 0, var_ret_F, 0)
  loc_005EC5B0: var_30 = FindWindowEx(var_28, 0, var_ret_F, 0)
  loc_005EC5C3: var_ret_10 = "_AOL_Icon"
  loc_005EC5CE: var_eax = FindWindowEx(var_28, var_30, var_ret_10, 0)
  loc_005EC5E7: var_44 = FindWindowEx(var_28, var_30, var_ret_10, 0)
  loc_005EC5FA: var_ret_11 = "_AOL_Icon"
  loc_005EC603: var_eax = FindWindowEx(var_28, 0, var_ret_11, 0)
  loc_005EC61C: var_B4 = FindWindowEx(var_28, 0, var_ret_11, 0)
  loc_005EC62B: 
  loc_005EC635: If var_18 > 13 Then GoTo loc_005EC689
  loc_005EC645: var_ret_12 = "_AOL_Icon"
  loc_005EC653: var_eax = FindWindowEx(var_28, var_B4, var_ret_12, 0)
  loc_005EC666: var_B4 = FindWindowEx(var_28, var_B4, var_ret_12, 0)
  loc_005EC67C: 00000001h = 00000001h + var_18
  loc_005EC687: GoTo loc_005EC62B
  loc_005EC689: 'Referenced from: 005EC635
  loc_005EC6A2: var_C8 = CStr(0)
  loc_005EC6BE: var_CC = CStr(var_B4)
  loc_005EC6D3: var_D0 = var_C8 & var_CC
  loc_005EC6E0: fcomp real8 ptr var_33C
  loc_005EC6F2: GoTo loc_005EC6F6
  loc_005EC6F6: 'Referenced from: 005EC6F2
  loc_005EC705: setnz al
  loc_005EC70E: setnz cl
  loc_005EC719: setnz dl
  loc_005EC72A: setnz cl
  loc_005EC735: setnz dl
  loc_005EC746: setnz cl
  loc_005EC751: setnz dl
  loc_005EC762: setnz cl
  loc_005EC76D: setnz dl
  loc_005EC79C: If Not (edx) <> 0 Then GoTo loc_005EC42A
  loc_005EC7E3: var_2AC = mmoption.Check8.Value
  loc_005EC811: setz bl
  loc_005EC81F: If ebx = 0 Then GoTo loc_005EC8D6
  loc_005EC829: var_eax = call Proc_79_45_608BE0(var_60, var_D8, var_0060C6CC)
  loc_005EC839: var_4C = call Proc_79_45_608BE0(var_60, var_D8, var_0060C6CC)
  loc_005EC842: var_230 = var_4C
  loc_005EC858: Len(var_4C) = Len(var_4C) - 00000005h
  loc_005EC8AC: var_eax = SendMessage(var_60, 12, 0, Right(var_4C, Len(var_4C)))
  loc_005EC8BE: var_ret_14 = var_C8
  loc_005EC8D6: 'Referenced from: 005EC81F
  loc_005EC8FC: var_C8 = Text1.Text
  loc_005EC933: var_eax = SendMessage(var_6C, 12, 0, var_C8)
  loc_005EC974: var_F8 = Chr(13)
  loc_005EC97F: var_118 = Chr(10)
  loc_005EC9A7: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005EC9E5: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005ECA21: var_140 = var_C8
  loc_005ECA51: var_170 = var_CC
  loc_005ECA8D: var_280 = var_A0
  loc_005ECAA3: var_230 = "•bodini 4.0• mass mailer •spek•"
  loc_005ECAAD: var_240 = "•mail "
  loc_005ECAB7: var_250 = "• of •"
  loc_005ECACB: var_270 = "•this mm is• "
  loc_005ECADF: var_290 = "% •done•"
  loc_005ECB82: var_1E8 = "•bodini 4.0• mass mailer •spek•" & var_F8 & var_118 & "•mail " & var_C8 & "• of •" & var_CC & &H42EC60 & Chr(13) & Chr(10) & "•this mm is• "
  loc_005ECBB5: var_D0 = var_1E8 & var_A0 & "% •done•"
  loc_005ECBF9: var_eax = call Proc_3_4_5A51B0(var_228, var_94, 3)
  loc_005ECC0A: var_C4 = var_228
  loc_005ECCEC: var_C8 = Text2.Text
  loc_005ECD2A: var_CC = vbNullString & var_C8
  loc_005ECD3C: var_100 = var_CC & vbNullString
  loc_005ECD8C: var_230 = vbNullString
  loc_005ECD92: var_250 = vbNullString
  loc_005ECDA7: var_240 = "<p align center><font face=""tahoma""><b>"
  loc_005ECE06: var_178 = var_CC & vbNullString & Chr(13) & Chr(10) & vbNullString & "<p align center><font face=""tahoma""><b>" & var_C4 & vbNullString
  loc_005ECE29: var_eax = SendMessage(var_1C, 12, 0, CStr(var_178))
  loc_005ECEB9: 
  loc_005ECEBE: If var_28 = 0 Then GoTo loc_005ED766
  loc_005ECED8: var_ret_17 = "AOL Frame25"
  loc_005ECEDB: var_eax = FindWindow(var_ret_17, 0)
  loc_005ECEF4: var_54 = FindWindow(var_ret_17, 0)
  loc_005ECF07: var_ret_18 = "MDICLIENT"
  loc_005ECF10: var_eax = FindWindowEx(var_54, 0, var_ret_18, 0)
  loc_005ECF29: var_68 = FindWindowEx(var_54, 0, var_ret_18, 0)
  loc_005ECF3A: var_ret_19 = "Error"
  loc_005ECF49: var_ret_1A = "AOL Child"
  loc_005ECF52: var_eax = FindWindowEx(var_68, 0, var_ret_1A, var_ret_19)
  loc_005ECF75: var_84 = FindWindowEx(var_68, 0, var_ret_1A, var_ret_19)
  loc_005ECF90: var_ret_1B = "America Online"
  loc_005ECF9F: var_ret_1C = "#32770"
  loc_005ECFA2: var_eax = FindWindow(var_ret_1C, var_ret_1B)
  loc_005ECFC5: var_74 = FindWindow(var_ret_1C, var_ret_1B)
  loc_005ECFDF: var_ret_1D = "Static"
  loc_005ECFE8: var_eax = FindWindowEx(var_74, 0, var_ret_1D, 0)
  loc_005ECFFB: var_70 = FindWindowEx(var_74, 0, var_ret_1D, 0)
  loc_005ED014: var_ret_1E = "Static"
  loc_005ED01F: var_eax = FindWindowEx(var_74, var_70, var_ret_1E, 0)
  loc_005ED038: var_2C = FindWindowEx(var_74, var_70, var_ret_1E, 0)
  loc_005ED042: If var_74 = 0 Then GoTo loc_005ED090
  loc_005ED04A: var_eax = call Proc_79_45_608BE0(var_2C, 1, )
  loc_005ED079: var_2C0 = InStr(, call Proc_79_45_608BE0(var_2C, 1, ), "Please refrain from forwarding this message.", 0)
  loc_005ED08A: If var_2C0 <> 0 Then GoTo loc_005ED194
  loc_005ED090: 'Referenced from: 005ED042
  loc_005ED098: If var_84 <> 0 Then GoTo loc_005ED4DA
  loc_005ED09E: var_eax = call Proc_79_1_601500(, , )
  loc_005ED0B1: var_28 = call Proc_79_1_601500(, , )
  loc_005ED0B4: var_ret_1F = "_AOL_Icon"
  loc_005ED0BD: var_eax = FindWindowEx(var_28, 0, var_ret_1F, 0)
  loc_005ED0D6: var_B4 = FindWindowEx(var_28, 0, var_ret_1F, 0)
  loc_005ED0E5: 
  loc_005ED0EF: If var_18 > 11 Then GoTo loc_005ED143
  loc_005ED0FF: var_ret_20 = "_AOL_Icon"
  loc_005ED10D: var_eax = FindWindowEx(var_28, var_B4, var_ret_20, 0)
  loc_005ED120: var_B4 = FindWindowEx(var_28, var_B4, var_ret_20, 0)
  loc_005ED136: 00000001h = 00000001h + var_18
  loc_005ED141: GoTo loc_005ED0E5
  loc_005ED143: 'Referenced from: 005ED0EF
  loc_005ED162: var_eax = SendMessage(var_B4, 513, 0, 0)
  loc_005ED188: var_eax = SendMessage(var_B4, 514, 0, 0)
  loc_005ED18F: GoTo loc_005ECEB9
  loc_005ED194: 
  loc_005ED1A0: var_ret_21 = "America Online"
  loc_005ED1AF: var_ret_22 = "#32770"
  loc_005ED1B2: var_eax = FindWindow(var_ret_22, var_ret_21)
  loc_005ED1D5: var_74 = FindWindow(var_ret_22, var_ret_21)
  loc_005ED1EF: var_ret_23 = "Static"
  loc_005ED1F8: var_eax = FindWindowEx(var_74, 0, var_ret_23, 0)
  loc_005ED20B: var_70 = FindWindowEx(var_74, 0, var_ret_23, 0)
  loc_005ED224: var_ret_24 = "Static"
  loc_005ED22F: var_eax = FindWindowEx(var_74, var_70, var_ret_24, 0)
  loc_005ED248: var_2C = FindWindowEx(var_74, var_70, var_ret_24, 0)
  loc_005ED259: var_ret_25 = "OK"
  loc_005ED268: var_ret_26 = "Button"
  loc_005ED271: var_eax = FindWindowEx(var_74, 0, var_ret_26, var_ret_25)
  loc_005ED2A4: var_eax = call Proc_608D20(FindWindowEx(var_74, 0, var_ret_26, var_ret_25), , )
  loc_005ED2A9: var_eax = call Proc_79_1_601500(, , )
  loc_005ED2BB: var_eax = call Proc_608D70(call Proc_79_1_601500(, , ), , )
  loc_005ED2D9: var_eax = call Proc_6098C0(CLng(0.65), , )
  loc_005ED2EA: var_ret_27 = "AOL Mail"
  loc_005ED2F9: var_ret_28 = "#32770"
  loc_005ED2FC: var_eax = FindWindow(var_ret_28, var_ret_27)
  loc_005ED334: var_ret_29 = "&Yes"
  loc_005ED343: var_ret_2A = "Button"
  loc_005ED349: var_eax = FindWindowEx(FindWindow(var_ret_28, var_ret_27), 0, var_ret_2A, var_ret_29)
  loc_005ED34E: var_2B0 = FindWindowEx(var_2B0, 0, var_ret_2A, var_ret_29)
  loc_005ED36C: var_24 = var_2B0
  loc_005ED384: var_ret_2B = "&No"
  loc_005ED393: var_ret_2C = "Button"
  loc_005ED39B: var_eax = FindWindowEx(var_2B0, var_24, var_ret_2C, var_ret_2B)
  loc_005ED3BC: var_AC = FindWindowEx(var_2B0, var_24, var_ret_2C, var_ret_2B)
  loc_005ED3D4: var_eax = call Proc_608D20(var_AC, , )
  loc_005ED3E0: var_eax = call Proc_608D20(var_AC, , )
  loc_005ED3FE: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005ED403: var_eax = call Proc_79_0_601250(, , )
  loc_005ED408: var_2B0 = call Proc_79_0_601250(, , )
  loc_005ED415: var_eax = call Proc_608D70(var_2B0, , )
  loc_005ED434: var_2C8 = call Proc_608D70(var_2B0, , )
  loc_005ED45D: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005ED4A0: call __vbaStrR8
  loc_005ED4AE: var_CC = __vbaStrR8
  loc_005ED4C8: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005ED4CF: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005ED73D
  loc_005ED4D5: GoTo loc_005ED72E
  loc_005ED4DA: 'Referenced from: 005ED098
  loc_005ED4E6: var_ret_2D = "America Online"
  loc_005ED4F5: var_ret_2E = "#32770"
  loc_005ED4F8: var_eax = FindWindow(var_ret_2E, var_ret_2D)
  loc_005ED51B: var_58 = FindWindow(var_ret_2E, var_ret_2D)
  loc_005ED533: var_ret_2F = "OK"
  loc_005ED542: var_ret_30 = "Button"
  loc_005ED54B: var_eax = FindWindowEx(var_58, 0, var_ret_30, var_ret_2F)
  loc_005ED57E: var_eax = call Proc_608D20(FindWindowEx(var_58, 0, var_ret_30, var_ret_2F), , )
  loc_005ED591: var_ret_31 = "AOL Frame25"
  loc_005ED594: var_eax = FindWindow(var_ret_31, 0)
  loc_005ED5AD: var_54 = FindWindow(var_ret_31, 0)
  loc_005ED5B0: call var_2C8
  loc_005ED5C0: var_ret_32 = "MDICLIENT"
  loc_005ED5C9: var_eax = FindWindowEx(var_54, 0, var_ret_32, 0)
  loc_005ED5E2: var_68 = FindWindowEx(var_54, 0, var_ret_32, 0)
  loc_005ED5E5: call var_2C8
  loc_005ED5F3: var_ret_33 = "Error"
  loc_005ED602: var_ret_34 = "AOL Child"
  loc_005ED60B: var_eax = FindWindowEx(var_68, 0, var_ret_34, var_ret_33)
  loc_005ED644: var_eax = call Proc_608D70(FindWindowEx(var_68, 0, var_ret_34, var_ret_33), , )
  loc_005ED649: var_eax = call Proc_79_0_601250(, , )
  loc_005ED65B: var_eax = call Proc_608D70(call Proc_79_0_601250(, , ), , )
  loc_005ED660: var_eax = call Proc_79_1_601500(, , )
  loc_005ED665: var_2B0 = call Proc_79_1_601500(, , )
  loc_005ED672: var_eax = call Proc_608D70(var_2B0, , )
  loc_005ED691: var_2C8 = call Proc_608D70(var_2B0, , )
  loc_005ED6BA: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005ED6FD: call __vbaStrR8
  loc_005ED70B: var_CC = __vbaStrR8
  loc_005ED725: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005ED72C: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005ED73D
  loc_005ED72E: 'Referenced from: 005ED4D5
  loc_005ED737: Unknown_VTable_Call[eax+00000054h] = CheckObj(var_2C8, var_0042DCB0, 84)
  loc_005ED73D: 'Referenced from: 005ED4CF
  loc_005ED761: GoTo loc_005ED88F
  loc_005ED766: 'Referenced from: 005ECEBE
  loc_005ED766: var_eax = call Proc_79_1_601500(var_D8, var_DC, var_2C8)
  loc_005ED778: var_eax = call Proc_608D70(call Proc_79_1_601500(var_D8, var_DC, var_2C8), var_CC, )
  loc_005ED78A: var_eax = PostMessage(var_98, 16, 0, 0)
  loc_005ED7AA: var_eax = call Proc_6098C0(CLng(0.45), , )
  loc_005ED7CC: var_2C8 = var_DC
  loc_005ED7F2: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005ED835: call __vbaStrR8
  loc_005ED843: var_CC = __vbaStrR8
  loc_005ED853: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005ED88F: 'Referenced from: 005ED761
  loc_005ED89C: 'Referenced from: 005EBA37
  loc_005ED8AE: Next var_40
  loc_005ED8B4: var_318 = Next var_40
  loc_005ED8BA: GoTo loc_005EB986
  loc_005ED8BF: 'Referenced from: 005EB98C
  loc_005ED8D0: var_C8 = "•bodini 4.0• mm •completed•"
  loc_005ED914: var_eax = call Proc_3_4_5A51B0(var_108, var_94, 3)
  loc_005ED977: var_C8 = "<font face=""tahoma"">" & var_CC & vbNullString
  loc_005ED989: var_CC = var_C8 & vbNullString
  loc_005ED992: var_eax = call Proc_79_17_604A50(var_CC, var_94, var_C8)
  loc_005ED9F3: var_2AC = mmoption.Check3.Value
  loc_005EDA21: setz dl
  loc_005EDA32: If edx = 0 Then GoTo loc_005EDA39
  loc_005EDA34: var_eax = call Proc_79_32_6072E0(var_D8, var_0060C6CC, var_0060C6CC)
  loc_005EDA39: 'Referenced from: 005EDA32
  loc_005EDA76: var_2AC = mmoption.Check5.Value
  loc_005EDAA4: setz dl
  loc_005EDAB5: If edx = 0 Then GoTo loc_005EDAE0
  loc_005EDAC2: var_C8 = "Sign Off"
  loc_005EDACF: var_eax = call Proc_79_54_60A7D0(var_C8, var_D8, var_0060C6CC)
  loc_005EDAE0: 'Referenced from: 005EDAB5
  loc_005EDAFE: var_2C0 = call Proc_79_54_60A7D0(var_C8, var_D8, var_0060C6CC)
  loc_005EDB04: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005EDB4F: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005EDB9A: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005EDBFA: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005EDC4A: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005EDCAD: call __vbaCastObj(var_E8, var_E0, var_E8, var_00436CC0, esi, var_CC, var_DC, esi, Me, var_D8, var_C8, var_D8, esi, Me, var_E8, esi)
  loc_005EDCD2: var_eax = call Proc_79_50_609A50(var_E4, CInt(var_2BC), 5)
  loc_005EDD30: GoTo loc_005EDE1F
  loc_005EDE1E: Exit Sub
  loc_005EDE1F: 'Referenced from: 005EDD30
  loc_005EDE66: Exit Sub
End Sub