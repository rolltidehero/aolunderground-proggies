ï»¿Private Sub Command1_Click() '5FF410
  Dim var_A4 As TextBox
  loc_005FF4E1: var_9C = Text1.Text
  loc_005FF51D: esi = (var_9C = vbNullString) + 1
  loc_005FF535: If (var_9C <> vbNullString) + 1 <> 0 Then GoTo loc_00600676
  loc_005FF55E: var_9C = Text1.Text
  loc_005FF59A: esi = (var_9C = "File...") + 1
  loc_005FF5B2: If (var_9C <> "File...") + 1 <> 0 Then GoTo loc_00600676
  loc_005FF5DB: var_9C = Text1.Text
  loc_005FF606: Open var_9C For Binary As #2 Len = -1
  loc_005FF637: var_9C = "â¢bodini 4.0â¢ pwsd â¢spekâ¢"
  loc_005FF67B: var_eax = call Proc_3_4_5A51B0(var_C4, var_8C, 3)
  loc_005FF6DC: var_9C = "<font face=""tahoma"">" & var_C4
  loc_005FF6F7: var_eax = call Proc_79_17_604A50(var_9C & vbNullString, var_8C, var_9C)
  loc_005FF72E: var_eax = call Proc_6098C0(CLng(0.1), Me, var_A4)
  loc_005FF75D: var_9C = Text1.Text
  loc_005FF78D: var_AC = var_9C
  loc_005FF7E5: var_10C = "â¢scanningâ¢ "
  loc_005FF81F: var_A0 = "â¢scanningâ¢ " & LCase(0) & &H42EC60
  loc_005FF85F: var_eax = call Proc_3_4_5A51B0(var_104, var_8C, 3)
  loc_005FF8DA: var_9C = "<font face=""tahoma"">" & var_104
  loc_005FF8F5: var_eax = call Proc_79_17_604A50(var_9C & vbNullString, var_8C, var_9C & vbNullString)
  loc_005FF92C: call Proc_6098C0(CLng(0.5), Me, (var_9C = vbNullString))
  loc_005FF949: var_eax = call Proc_79_51_60A2B0("c:\windows\media\robotz windows start.wav", Me, var_A4)
  loc_005FF987: var_54 = LOF(2)
  loc_005FF9AA: var_64 = CInt(1)
  loc_005FF9D8: If (var_54 >= 0) = 0 Then GoTo loc_0060066C
  loc_005FFA06: If (var_54 > 32000) = 0 Then GoTo loc_005FFA14
  loc_005FFA12: GoTo loc_005FFA48
  loc_005FFA14: 'Referenced from: 005FFA06
  loc_005FFA3C: If (var_54 = 0) = 0 Then GoTo loc_005FFA63
  loc_005FFA48: 'Referenced from: 005FFA12
  loc_005FFA5B: var_78 = CInt(1)
  loc_005FFA61: GoTo loc_005FFA6F
  loc_005FFA63: 
  loc_005FFA69: var_78 = var_54
  loc_005FFA6F: 'Referenced from: 005FFA61
  loc_005FFAB2: var_7C = String$(CLng(var_78), &H43134C)
  loc_005FFAD3: Get #2, CLng(var_64), var_7C
  loc_005FFAEC: var_168 = InStr(1, var_7C, "@juno.com", 1)
  loc_005FFB14: var_16C = InStr(1, var_7C, "@hotmail.com", 1)
  loc_005FFB36: var_170 = InStr(1, var_7C, "@rocketmail.com", 1)
  loc_005FFB55: var_174 = InStr(1, var_7C, "PW:", 1)
  loc_005FFB7A: var_178 = InStr(1, var_7C, "SN:", 1)
  loc_005FFB99: var_17C = InStr(1, var_7C, "win32", 1)
  loc_005FFBBB: var_180 = InStr(1, var_7C, "STEALER1", 1)
  loc_005FFBE0: var_184 = InStr(1, var_7C, "PWSTEAL", 1)
  loc_005FFC02: var_188 = InStr(1, var_7C, "@usa.com", 1)
  loc_005FFC21: var_18C = InStr(1, var_7C, "EXPLORER", 1)
  loc_005FFC46: var_190 = InStr(1, var_7C, "Clone", 1)
  loc_005FFC5B: fcomp real4 ptr [00402F98h]
  loc_005FFCD6: var_11C = "â¢ trojan horseâ¢"
  loc_005FFD06: var_9C = &H42EC60 & LCase(Me) & "â¢ trojan horseâ¢"
  loc_005FFD46: var_eax = call Proc_3_4_5A51B0(var_104, var_8C, 3)
  loc_005FFD5C: var_94 = var_104
  loc_005FFDB7: var_9C = "<font face=""tahoma"">" & var_94
  loc_005FFDC9: var_A0 = var_9C & vbNullString
  loc_005FFDD2: var_eax = call Proc_79_17_604A50(var_A0, var_8C, var_9C)
  loc_005FFDF8: Close #2
  loc_005FFE42: var_C4 = "bodini by: spek"
  loc_005FFE64: var_B4 = "This file is a trojan horse."
  loc_005FFEC5: var_eax = call Proc_79_51_60A2B0("c:\windows\media\robotz error.wav", , )
  loc_005FFED8: Close #2
  loc_005FFEDA: GoTo loc_00600674
  loc_005FFEE2: fcomp real4 ptr [00402F98h]
  loc_005FFEF6: fcomp real4 ptr [00402F98h]
  loc_005FFF06: GoTo loc_0060020C
  loc_005FFF0E: fcomp real4 ptr [00402F98h]
  loc_005FFF1E: fcomp real4 ptr [00402F98h]
  loc_005FFF2E: GoTo loc_0060020C
  loc_005FFF36: fcomp real4 ptr [00402F98h]
  loc_005FFF46: fcomp real4 ptr [00402F98h]
  loc_005FFF56: GoTo loc_0060020C
  loc_005FFF5E: fcomp real4 ptr [00402F98h]
  loc_005FFF6E: fcomp real4 ptr [00402F98h]
  loc_005FFF7E: GoTo loc_0060020C
  loc_005FFF89: fcomp real4 ptr [00402F98h]
  loc_00600004: var_11C = "â¢ trojan horseâ¢"
  loc_00600034: Close #&H42EC60 & LCase(9) & "â¢ trojan horseâ¢"
  loc_00600074: var_eax = call Proc_3_4_5A51B0(var_104, var_8C, 3)
  loc_0060008A: Close #var_104
  loc_006000E5: Close #var_94
  loc_006000ED: var_9C = var_94
  loc_006000F7: Close #vbNullString
  loc_00600100: var_eax = call Proc_79_17_604A50(var_A0, Close #var_94, "<font face=""tahoma"">")
  loc_00600136: var_eax = call Proc_79_51_60A2B0("c:\windows\media\robotz error.wav", Me, )
  loc_00600190: var_C4 = "bodini by: spek"
  loc_006001AE: var_B4 = "This file is a trojan horse."
  loc_006001F0: GoTo loc_00600665
  loc_006001F8: fcomp real4 ptr [00402F98h]
  loc_0060020C: 'Referenced from: 005FFF06
  loc_00600233: var_C4 = LCase(var_B4)
  loc_00600273: var_11C = "â¢ trojan horseâ¢"
  loc_0060027D: var_D4 = &H42EC60 & var_C4
  loc_00600292: var_E4 = var_D4 & "â¢ trojan horseâ¢"
  loc_006002E3: var_eax = call Proc_3_4_5A51B0(var_104, var_8C, 3)
  loc_006002F9: var_94 = var_104
  loc_0060034A: call edi(var_94, "<font face=""tahoma"">", var_104, var_8C, var_E4, var_148, var_E4, Me, var_B4, var_C4, var_D4)
  loc_00600354: var_9C = edi(var_94, "<font face=""tahoma"">", var_104, var_8C, var_9C, var_148, var_E4, Me, var_B4, var_C4, var_D4)
  loc_0060035C: call edi(vbNullString, var_9C)
  loc_0060036F: var_eax = call Proc_79_17_604A50(edi(vbNullString, var_9C), , )
  loc_006003A5: var_eax = call Proc_79_51_60A2B0("c:\windows\media\robotz error.wav", , )
  loc_006003FF: var_C4 = "bodini by: spek"
  loc_0060041D: var_B4 = "This file is a trojan horse."
  loc_00600436: GoTo loc_0060063C
  loc_00600444: var_AC = var_E4
  loc_00600462: var_C4 = LCase(9)
  loc_006004A2: var_11C = "â¢ cleanâ¢"
  loc_006004AC: var_D4 = &H42EC60 & var_C4
  loc_006004C1: var_E4 = var_D4 & "â¢ cleanâ¢"
  loc_00600512: var_eax = call Proc_3_4_5A51B0(var_104, var_8C, var_F4)
  loc_00600528: var_94 = call Proc_3_4_5A51B0(var_104, var_8C, var_F4)
  loc_00600579: call edi(var_94, "<font face=""tahoma"">", var_104, var_8C, var_E4, var_148, var_E4, var_E4, 00000010h, var_C4, var_D4)
  loc_00600583: var_9C = edi(var_94, "<font face=""tahoma"">", var_104, var_8C, var_9C, var_148, var_E4, var_E4, 00000010h, var_C4, var_D4)
  loc_0060058B: call edi(vbNullString, var_9C)
  loc_0060059E: var_eax = call Proc_79_17_604A50(edi(vbNullString, var_9C), , )
  loc_00600605: var_C4 = "bodini by: spek"
  loc_00600623: var_B4 = "This file is a clean and does not have a trojan horse."
  loc_0060063C: 'Referenced from: 00600436
  loc_00600665: 'Referenced from: 006001F0
  loc_0060066C: 'Referenced from: 005FF9D8
  loc_0060066E: Close #2
  loc_00600674: 'Referenced from: 005FFEDA
  loc_00600676: 'Referenced from: 005FF535
  loc_0060067F: GoTo loc_006006DC
  loc_006006DB: Exit Sub
  loc_006006DC: 'Referenced from: 0060067F
End Sub