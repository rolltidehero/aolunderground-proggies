ï»¿Private Sub Timer1_Timer() '5DF6E0
  Dim var_64 As Timer
  Dim var_0060C36C As ListBox
  Dim var_140 As ListBox
  loc_005DF7CF: var_138 = Timer1.Enabled
  loc_005DF7F3: setz al
  loc_005DF803: If eax <> 0 Then GoTo loc_005E0669
  loc_005DF809: var_eax = call Proc_79_38_607B50(var_64, Me, Me)
  loc_005DF81F: var_6C = call Proc_79_38_607B50(var_64, Me, Me)
  loc_005DF843: var_58 = LCase(call Proc_79_38_607B50(var_64, Me, Me))
  loc_005DF86D: InStr(1, var_58, var_00431C88, 0) = InStr(1, var_58, var_00431C88, 0) - 00000001h
  loc_005DF87C: var_6C = InStr(1, var_58, var_00431C88, 0)
  loc_005DF87F: var_DC = var_58
  loc_005DF8BF: var_1C = Mid(var_58, 1, InStr(1, var_58, var_00431C88, 0))
  loc_005DF8F8: var_DC = var_58
  loc_005DF90E: InStr(1, var_58, var_00431C88, 0) = InStr(1, var_58, var_00431C88, 0) + 00000003h
  loc_005DF93E: var_18 = Mid(var_58, InStr(1, var_58, var_00431C88, 0), 10)
  loc_005DF964: var_DC = var_18
  loc_005DF9B0: var_140 = (LCase(var_18) = LCase(Me))
  loc_005DF9DB: If var_140 = 0 Then GoTo loc_005E0025
  loc_005DFA37: var_138 = mm.List1.ListCount
  loc_005DFA67: var_138 = var_138 - 0001h
  loc_005DFA83: var_EC = var_138
  loc_005DFAB1: For var_54 =  To var_138 Step 1
  loc_005DFABA: var_194 = var_168
  loc_005DFACC: If var_194 = 0 Then GoTo loc_005DFC3A
  loc_005DFB14: var_54 = CInt(var_5C)
  loc_005DFB24: var_64 = mm.List1.List(var_54)
  loc_005DFB73: var_74 = LCase(var_5C)
  loc_005DFB86: var_DC = var_1C
  loc_005DFB96: var_84 = LCase(var_1C)
  loc_005DFBC5: If (var_74 <> var_84) <> 0 Then GoTo loc_005DFBEC
  loc_005DFBD9: Next var_54
  loc_005DFBDF: var_194 = Next var_54
  loc_005DFBE7: GoTo loc_005DFAC6
  loc_005DFBEC: 'Referenced from: 005DFBC5
  loc_005DFBFA: var_DC = var_1C
  loc_005DFC0A: var_74 = LCase(var_1C)
  loc_005DFC2B: var_FC = "â¢ already on mmâ¢"
  loc_005DFC35: GoTo loc_005E03E4
  loc_005DFC3A: 'Referenced from: 005DFACC
  loc_005DFC7B: var_DC = var_1C
  loc_005DFCBF: var_5C = CStr(LCase(var_1C))
  loc_005DFCCF: var_eax = List1.AddItem var_5C, var_E8
  loc_005DFD64: var_DC = var_1C
  loc_005DFDA8: var_5C = CStr(LCase(var_1C))
  loc_005DFDB8: var_eax = mm.List1.AddItem var_5C, var_E8
  loc_005DFE2F: var_138 = mm.List1.ListCount
  loc_005DFE5F: var_20 = CStr(var_138)
  loc_005DFE78: var_DC = var_1C
  loc_005DFEC7: var_10C = var_20
  loc_005DFEE3: var_FC = "â¢ added to mm â¢"
  loc_005DFF20: var_B4 = &H42EC60 & LCase(var_1C) & & var_20 & &H42EC60
  loc_005DFF2E: var_5C = var_B4
  loc_005DFF65: var_eax = call Proc_3_4_5A51B0(var_D4, var_40, 3)
  loc_005DFFD4: var_5C = "<font face=""tahoma"">" & var_D4
  loc_005DFFE7: var_60 = var_5C & vbNullString
  loc_005DFFED: var_eax = call Proc_79_17_604A50(var_60, var_40, var_5C)
  loc_005E001E: var_eax = call Proc_6098C0(CLng(0.55), var_0060C36C, )
  loc_005E0023: GoTo loc_005E002B
  loc_005E0025: 'Referenced from: 005DF9DB
  loc_005E002B: 'Referenced from: 005E0023
  loc_005E0039: var_DC = var_18
  loc_005E0085: var_140 = (LCase(var_18) = LCase(Me))
  loc_005E00B1: If var_140 = 0 Then GoTo loc_005E0667
  loc_005E010D: var_138 = mm.List1.ListCount
  loc_005E013D: var_138 = var_138 - 0001h
  loc_005E0159: var_EC = var_138
  loc_005E018B: For var_54 =  To var_138 Step 1
  loc_005E0194: var_19C = var_188
  loc_005E01A0: 
  loc_005E01A8: If var_19C = 0 Then GoTo loc_005E0504
  loc_005E01F0: var_54 = CInt(var_5C)
  loc_005E0200: var_64 = mm.List1.List(var_54)
  loc_005E024F: var_74 = LCase(var_5C)
  loc_005E0262: var_DC = var_1C
  loc_005E0272: var_84 = LCase(var_1C)
  loc_005E02A1: If (var_74 <> var_84) <> 0 Then GoTo loc_005E02CC
  loc_005E02B5: Next var_54
  loc_005E02C1: var_19C = Next var_54
  loc_005E02C7: GoTo loc_005E01A0
  loc_005E02CC: 'Referenced from: 005E02A1
  loc_005E02EF: var_54 = CInt(var_64)
  loc_005E02FF: var_eax = List1.RemoveItem var_54
  loc_005E035E: var_140 = var_64
  loc_005E0364: var_54 = CInt(var_64)
  loc_005E0374: var_eax = mm.List1.RemoveItem var_54
  loc_005E03A9: var_DC = var_1C
  loc_005E03B9: var_74 = LCase(var_1C)
  loc_005E03DA: var_FC = "â¢ removed from mmâ¢"
  loc_005E03E4: 'Referenced from: 005DFC35
  loc_005E0402: var_84 = &H42EC60 & var_74
  loc_005E0413: var_94 = var_84 &
  loc_005E0423: var_5C = var_94
  loc_005E045A: var_eax = call Proc_3_4_5A51B0(var_B4, var_40, 3)
  loc_005E04B9: var_5C = "<font face=""tahoma"">" & var_B4
  loc_005E04CE: var_eax = call Proc_79_17_604A50(var_5C & vbNullString, var_40, var_5C)
  loc_005E04F2: var_13C = CLng(0.55)
  loc_005E04FF: GoTo loc_005E0662
  loc_005E0504: 'Referenced from: 005E01A8
  loc_005E0512: var_DC = var_1C
  loc_005E055B: var_FC = "â¢ not on mmâ¢"
  loc_005E0565: call var_140(var_84, var_74, var_F4, var_13C, Me, Me, var_178, var_188, var_0060C36C)
  loc_005E0576: call var_140(var_94, var_104, var_140(var_84, var_74, var_F4, var_13C, Me, Me, var_178, var_188, var_0060C36C))
  loc_005E0586: var_5C = var_140(var_94, var_104, var_140(var_84, var_74, var_F4, var_13C, Me, Me, var_178, var_188, var_0060C36C))
  loc_005E05BD: var_eax = call Proc_3_4_5A51B0(var_B4, var_40, 3)
  loc_005E061C: var_5C = "<font face=""tahoma"">" & var_B4
  loc_005E0631: var_eax = call Proc_79_17_604A50(var_5C & vbNullString, var_40, var_5C)
  loc_005E065B: var_13C = CLng(0.55)
  loc_005E0662: 'Referenced from: 005E04FF
  loc_005E0662: var_eax = call Proc_6098C0(var_13C, , )
  loc_005E0667: 'Referenced from: 005E00B1
  loc_005E0669: 'Referenced from: 005DF803
  loc_005E0672: GoTo loc_005E06CA
  loc_005E06C9: Exit Sub
  loc_005E06CA: 'Referenced from: 005E0672
  loc_005E0725: Exit Sub
End Sub