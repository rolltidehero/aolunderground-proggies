
Public Sub Proc_2_0_4784C0
  loc_00478507: var_ret_1 = "AOL Frame25"
  loc_0047850A: var_eax = FindWindow(var_ret_1, var_58)
  loc_00478523: var_30 = FindWindow(var_ret_1, var_58)
  loc_00478536: var_ret_2 = "MDICLIENT"
  loc_0047853F: var_eax = FindWindowEx(var_30, 0, var_ret_2, 0)
  loc_0047854C: var_48 = FindWindowEx(var_30, 0, var_ret_2, 0)
  loc_0047855F: var_ret_3 = "AOL Toolbar"
  loc_00478568: var_eax = FindWindowEx(var_30, 0, var_ret_3, 0)
  loc_00478575: var_24 = FindWindowEx(var_30, 0, var_ret_3, 0)
  loc_00478588: var_ret_4 = "_AOL_Toolbar"
  loc_00478591: var_eax = FindWindowEx(var_24, 0, var_ret_4, 0)
  loc_0047859E: var_20 = FindWindowEx(var_24, 0, var_ret_4, 0)
  loc_004785B1: var_ret_5 = "_AOL_Icon"
  loc_004785BA: var_eax = FindWindowEx(var_20, 0, var_ret_5, 0)
  loc_004785C7: var_50 = FindWindowEx(var_20, 0, var_ret_5, 0)
  loc_004785DA: var_ret_6 = "_AOL_Icon"
  loc_004785E5: var_eax = FindWindowEx(var_20, var_50, var_ret_6, 0)
  loc_004785F5: var_50 = FindWindowEx(var_20, var_50, var_ret_6, 0)
  loc_00478607: var_eax = PostMessage(var_50, 513, 0, 0)
  loc_0047861B: var_eax = PostMessage(var_50, 514, 0, 0)
  loc_00478637: var_ret_7 = "Write Mail"
  loc_00478643: var_ret_8 = "AOL Child"
  loc_0047864C: var_eax = FindWindowEx(var_48, 0, var_ret_8, var_ret_7)
  loc_00478663: var_1C = FindWindowEx(var_48, 0, var_ret_8, var_ret_7)
  loc_0047867A: var_ret_9 = "_AOL_Edit"
  loc_00478683: var_eax = FindWindowEx(var_1C, 0, var_ret_9, 0)
  loc_00478690: var_44 = FindWindowEx(var_1C, 0, var_ret_9, 0)
  loc_004786A3: var_ret_A = "_AOL_Edit"
  loc_004786AE: var_eax = FindWindowEx(var_1C, var_44, var_ret_A, 0)
  loc_004786BE: var_40 = FindWindowEx(var_1C, var_44, var_ret_A, 0)
  loc_004786CE: var_ret_B = "_AOL_Edit"
  loc_004786D9: var_eax = FindWindowEx(var_1C, var_40, var_ret_B, 0)
  loc_004786E9: var_3C = FindWindowEx(var_1C, var_40, var_ret_B, 0)
  loc_004786F9: var_ret_C = "RICHCNTL"
  loc_00478702: var_eax = FindWindowEx(var_1C, 0, var_ret_C, 0)
  loc_00478712: var_18 = FindWindowEx(var_1C, 0, var_ret_C, 0)
  loc_00478722: var_ret_D = "_AOL_Combobox"
  loc_0047872B: var_eax = FindWindowEx(var_1C, 0, var_ret_D, 0)
  loc_0047873B: var_38 = FindWindowEx(var_1C, 0, var_ret_D, 0)
  loc_0047874B: var_ret_E = "_AOL_Fontcombo"
  loc_00478754: var_eax = FindWindowEx(var_1C, 0, var_ret_E, 0)
  loc_00478764: var_4C = FindWindowEx(var_1C, 0, var_ret_E, 0)
  loc_00478774: var_ret_F = "_AOL_Icon"
  loc_0047877D: var_eax = FindWindowEx(var_1C, 0, var_ret_F, 0)
  loc_0047878D: var_28 = FindWindowEx(var_1C, 0, var_ret_F, 0)
  loc_0047879D: var_ret_10 = "_AOL_Icon"
  loc_004787A8: var_eax = FindWindowEx(var_1C, var_28, var_ret_10, 0)
  loc_004787B5: var_2C = FindWindowEx(var_1C, var_28, var_ret_10, 0)
  loc_004787C8: var_ret_11 = "_AOL_Icon"
  loc_004787D1: var_eax = FindWindowEx(var_1C, 0, var_ret_11, 0)
  loc_004787DE: var_54 = FindWindowEx(var_1C, 0, var_ret_11, 0)
  loc_004787ED: 
  loc_004787F7: If var_14 > 13 Then GoTo loc_00478839
  loc_00478804: var_ret_12 = "_AOL_Icon"
  loc_0047880F: var_eax = FindWindowEx(var_1C, var_54, var_ret_12, 0)
  loc_0047881F: var_54 = FindWindowEx(var_1C, var_54, var_ret_12, 0)
  loc_0047882C: 00000001h = 00000001h + var_14
  loc_00478837: GoTo loc_004787ED
  loc_00478839: 'Referenced from: 004787F7
  loc_0047884C: var_58 = CStr(0)
  loc_00478874: var_60 = var_58 & CStr(var_54)
  loc_00478881: fcomp real8 ptr var_7C
  loc_00478890: GoTo loc_00478894
  loc_00478894: 'Referenced from: 00478890
  loc_004788A3: setnz dl
  loc_004788B0: setnz al
  loc_004788BB: setnz al
  loc_004788C9: setnz cl
  loc_004788D7: setnz al
  loc_004788E5: setnz cl
  loc_004788F3: setnz al
  loc_00478901: setnz cl
  loc_0047890F: setnz al
  loc_0047891B: var_68 = Not (eax)
  loc_00478937: If var_68 <> 0 Then GoTo loc_00478628
  loc_00478952: var_eax = SendMessage(var_44, 12, 0, Me)
  loc_00478961: var_ret_14 = var_58
  loc_00478987: var_eax = SendMessage(var_3C, 12, 0, arg_C)
  loc_00478996: var_ret_16 = var_58
  loc_004789BC: var_eax = SendMessage(var_18, 12, 0, arg_10)
  loc_004789CB: var_ret_18 = var_58
  loc_004789EF: var_eax = call Proc_47AEC0(CLng(0.2), , )
  loc_004789F4: var_eax = call Proc_6_5_47E2B0(, , )
  loc_004789FF: GoTo loc_00478A19
  loc_00478A18: Exit Sub
  loc_00478A19: 'Referenced from: 004789FF
End Sub

Public Sub Proc_2_1_478A40
  loc_00478A84: var_ret_1 = "AOL Frame25"
  loc_00478A87: var_eax = FindWindow(var_ret_1, var_28)
  loc_00478AAA: var_ret_2 = "MDIClient"
  loc_00478AB0: var_eax = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  loc_00478ABC: var_1C = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  loc_00478AD0: var_ret_3 = "AOL Child"
  loc_00478AD6: var_eax = FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_00478AE2: var_20 = FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_00478AEF: call Proc_2_15_47AA10(var_20, var_ret_4 = #StkVar1%StkVar2, FindWindowEx(FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0), 0, var_ret_3, 0))
  loc_00478AF9: var_14 = var_ret_4
  loc_00478B16: If InStr(1, var_14, "Instant Message", 0) = 0 Then GoTo loc_00478B28
  loc_00478B20: var_24 = var_20
  loc_00478B23: GoTo loc_00478BEF
  loc_00478B28: 'Referenced from: 00478B16
  loc_00478B33: var_ret_5 = "AOL Child"
  loc_00478B3E: var_eax = FindWindowEx(var_1C, var_20, var_ret_5, 0)
  loc_00478B4E: var_20 = FindWindowEx(var_1C, var_20, var_ret_5, 0)
  loc_00478B5B: var_eax = call Proc_2_15_47AA10(var_20, var_00478BF9, GetLastError())
  loc_00478B8C: setnz bl
  loc_00478B91: eax = InStr(1, call Proc_2_15_47AA10(var_20, var_00478BF9, GetLastError()), "Instant Message", 0) - 1
  loc_00478BB7: setnz dl
  loc_00478BBC: If edx = 0 Then GoTo loc_00478BCD
  loc_00478BC0: If var_20 = 0 Then GoTo loc_00478BD7
  loc_00478BC8: GoTo loc_00478B28
  loc_00478BCD: 'Referenced from: 00478BBC
  loc_00478BCD: var_24 = var_20
  loc_00478BD5: GoTo loc_00478BEF
  loc_00478BD7: 
  loc_00478BE3: GoTo loc_00478BEF
  loc_00478BEE: Exit Sub
  loc_00478BEF: 'Referenced from: 00478B23
End Sub

Public Sub Proc_2_2_478C10
  loc_00478C51: var_ret_1 = "AOL Frame25"
  loc_00478C54: var_eax = FindWindow(var_ret_1, 0)
  loc_00478C7A: var_ret_2 = "MDIClient"
  loc_00478C83: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_00478C88: var_38 = FindWindowEx(var_38, 0, var_ret_2, 0)
  loc_00478C93: var_28 = var_38
  loc_00478CA3: var_ret_3 = "AOL Child"
  loc_00478CAC: var_eax = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_00478CB1: var_38 = FindWindowEx(var_38, 0, var_ret_3, 0)
  loc_00478CBC: var_2C = var_38
  loc_00478CCC: var_ret_4 = "RICHCNTL"
  loc_00478CD5: var_eax = FindWindowEx(var_38, 0, var_ret_4, 0)
  loc_00478CE5: var_1C = FindWindowEx(var_38, 0, var_ret_4, 0)
  loc_00478CF5: var_ret_5 = "_AOL_Listbox"
  loc_00478CFE: var_eax = FindWindowEx(var_2C, 0, var_ret_5, 0)
  loc_00478D0E: var_24 = FindWindowEx(var_2C, 0, var_ret_5, 0)
  loc_00478D1E: var_ret_6 = "_AOL_Icon"
  loc_00478D27: var_eax = FindWindowEx(var_2C, 0, var_ret_6, 0)
  loc_00478D37: var_30 = FindWindowEx(var_2C, 0, var_ret_6, 0)
  loc_00478D47: var_ret_7 = "_AOL_Static"
  loc_00478D50: var_eax = FindWindowEx(var_2C, 0, var_ret_7, 0)
  loc_00478D55: var_38 = FindWindowEx(var_2C, 0, var_ret_7, 0)
  loc_00478D64: If var_1C = 0 Then GoTo loc_00478D8B
  loc_00478D6B: If var_24 = 0 Then GoTo loc_00478D8B
  loc_00478D72: If var_30 = 0 Then GoTo loc_00478D8B
  loc_00478D79: If var_38 = 0 Then GoTo loc_00478D8B
  loc_00478D83: var_18 = var_2C
  loc_00478D86: GoTo loc_00478EA1
  loc_00478D8B: 'Referenced from: 00478D64
  loc_00478D96: var_ret_8 = "AOL Child"
  loc_00478DA1: var_eax = FindWindowEx(var_28, var_2C, var_ret_8, 0)
  loc_00478DA6: var_38 = FindWindowEx(var_28, var_2C, var_ret_8, 0)
  loc_00478DAE: var_2C = var_38
  loc_00478DC1: var_ret_9 = "RICHCNTL"
  loc_00478DCA: var_eax = FindWindowEx(var_38, 0, var_ret_9, 0)
  loc_00478DD7: var_1C = FindWindowEx(var_38, 0, var_ret_9, 0)
  loc_00478DEA: var_ret_A = "_AOL_Listbox"
  loc_00478DF3: var_eax = FindWindowEx(var_2C, 0, var_ret_A, 0)
  loc_00478E00: var_24 = FindWindowEx(var_2C, 0, var_ret_A, 0)
  loc_00478E13: var_ret_B = "_AOL_Icon"
  loc_00478E1C: var_eax = FindWindowEx(var_2C, 0, var_ret_B, 0)
  loc_00478E29: var_30 = FindWindowEx(var_2C, 0, var_ret_B, 0)
  loc_00478E3C: var_ret_C = "_AOL_Static"
  loc_00478E45: var_eax = FindWindowEx(var_2C, 0, var_ret_C, 0)
  loc_00478E4A: var_38 = FindWindowEx(var_2C, 0, var_ret_C, 0)
  loc_00478E59: If var_1C = 0 Then GoTo loc_00478E70
  loc_00478E60: If var_24 = 0 Then GoTo loc_00478E70
  loc_00478E67: If var_30 = 0 Then GoTo loc_00478E70
  loc_00478E6E: If var_38 <> 0 Then GoTo loc_00478E7C
  loc_00478E70: 'Referenced from: 00478E59
  loc_00478E75: If var_2C = 0 Then GoTo loc_00478E89
  loc_00478E77: GoTo loc_00478D8B
  loc_00478E7C: 
  loc_00478E84: var_18 = var_2C
  loc_00478E87: GoTo loc_00478EA1
  loc_00478E89: 'Referenced from: 00478E75
  loc_00478E95: GoTo loc_00478EA1
  loc_00478EA0: Exit Sub
  loc_00478EA1: 'Referenced from: 00478D86
End Sub

Public Sub Proc_2_3_478EC0
  loc_00478F0E: On Error Resume Next
  loc_00478F1B: var_eax = call Proc_2_2_478C10(-1, edi, esi)
  loc_00478F20: var_34 = call Proc_2_2_478C10(-1, edi, esi)
  loc_00478F2E: If var_34 <> 0 Then GoTo loc_00478F35
  loc_00478F30: GoTo loc_00479317
  loc_00478F35: 'Referenced from: 00478F2E
  loc_00478F47: var_ret_1 = "_AOL_Listbox"
  loc_00478F54: var_eax = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_00478F65: var_48 = FindWindowEx(var_34, 0, var_ret_1, 0)
  loc_00478F80: var_eax = GetWindowThreadProcessId(var_48, var_40)
  loc_00478F91: var_24 = GetWindowThreadProcessId(var_48, var_40)
  loc_00478FA6: var_eax = OpenProcess(983056, 0, var_40)
  loc_00478FB7: var_44 = OpenProcess(983056, 0, var_40)
  loc_00478FC5: If var_44 = 0 Then GoTo loc_00479317
  loc_00478FE7: var_eax = SendMessage(var_48, 395, 0, var_70)
  loc_00478FEC: var_74 = SendMessage(var_48, 395, 0, var_70)
  loc_00479001: var_84 = var_74 - 00000001h
  loc_00479015: GoTo loc_00479026
  loc_00479017: 
  loc_0047901A: var_28 = var_28 + 1
  loc_00479023: var_28 = var_28
  loc_00479026: 'Referenced from: 00479015
  loc_0047902F: If var_28 > 0 Then GoTo loc_00479301
  loc_00479067: var_38 = String$(4, vbNullString)
  loc_0047908C: var_eax = SendMessage(var_48, 409, var_28, 0)
  loc_0047909D: var_30 = SendMessage(var_48, 409, var_28, 0)
  loc_004790AA: var_30 = var_30 + 00000018h
  loc_004790DA: var_eax = ReadProcessMemory(var_44, var_30, var_38, 4, var_3C)
  loc_004790ED: var_ret_3 = var_4C
  loc_00479118: var_eax = CopyMemory(var_2C, var_38, 4)
  loc_0047912B: var_ret_5 = var_4C
  loc_00479144: var_2C = var_2C + 00000006h
  loc_00479182: var_38 = String$(16, vbNullString)
  loc_004791BE: var_eax = ReadProcessMemory(var_44, var_2C, var_38, Len(var_38), var_3C)
  loc_004791D1: var_ret_7 = var_4C
  loc_004791FA: InStr(1, var_38, vbNullString, 0) = InStr(1, var_38, vbNullString, 0) - 00000001h
  loc_00479213: var_38 = Left$(var_38, InStr(1, var_38, vbNullString, 0))
  loc_00479224: var_eax = call Proc_2_17_47ACB0(var_38, 0, fs:[00000000h])
  loc_0047922E: var_4C = call Proc_2_17_47ACB0(var_38, 0, fs:[00000000h])
  loc_0047924C: setz dl
  loc_00479267: If var_78 = 0 Then GoTo loc_004792F5
  loc_004792BA: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_004792C2: var_7C = Unknown_VTable_Call[edx+000001ECh]
  loc_004792FC: GoTo loc_00479017
  loc_00479301: 'Referenced from: 0047902F
  loc_0047930C: var_eax = CloseHandle(var_44)
  loc_00479317: 'Referenced from: 00478F30
  loc_0047931C: GoTo loc_00479331
  loc_00479330: Exit Sub
  loc_00479331: 'Referenced from: 0047931C
End Sub

Public Sub Proc_2_4_479360
  loc_004793A4: var_ret_1 = "AOL Frame25"
  loc_004793A7: var_eax = FindWindow(var_ret_1, var_30)
  loc_004793C0: var_18 = FindWindow(var_ret_1, var_30)
  loc_004793D3: var_ret_2 = "MDIClient"
  loc_004793DC: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_004793E9: var_1C = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_00479407: var_30 = "aol://9293:" & Me
  loc_00479411: call Proc_2_8_479AE0(var_30, GetLastError(), var_ret_3 = #StkVar1%StkVar2)
  loc_0047942A: var_ret_4 = "Send Instant Message"
  loc_00479436: var_ret_5 = "AOL Child"
  loc_0047943F: var_eax = FindWindowEx(var_1C, 0, var_ret_5, var_ret_4)
  loc_0047946A: var_ret_6 = "RICHCNTL"
  loc_00479470: var_eax = FindWindowEx(FindWindowEx(var_1C, 0, var_ret_5, var_ret_4), 0, var_ret_6, 0)
  loc_00479475: var_38 = FindWindowEx(var_38, 0, var_ret_6, 0)
  loc_00479480: var_14 = var_38
  loc_00479494: var_ret_7 = "_AOL_Icon"
  loc_0047949A: var_eax = FindWindowEx(var_38, 0, var_ret_7, 0)
  loc_0047949F: var_38 = FindWindowEx(var_38, 0, var_ret_7, 0)
  loc_004794A7: var_28 = var_38
  loc_004794BE: var_ret_8 = "_AOL_Icon"
  loc_004794C6: var_eax = FindWindowEx(var_38, var_28, var_ret_8, 0)
  loc_004794CB: var_38 = FindWindowEx(var_38, var_28, var_ret_8, 0)
  loc_004794D3: var_28 = var_38
  loc_004794EA: var_ret_9 = "_AOL_Icon"
  loc_004794F2: var_eax = FindWindowEx(var_38, var_28, var_ret_9, 0)
  loc_004794F7: var_38 = FindWindowEx(var_38, var_28, var_ret_9, 0)
  loc_004794FF: var_28 = var_38
  loc_00479516: var_ret_A = "_AOL_Icon"
  loc_0047951E: var_eax = FindWindowEx(var_38, var_28, var_ret_A, 0)
  loc_00479523: var_38 = FindWindowEx(var_38, var_28, var_ret_A, 0)
  loc_0047952B: var_28 = var_38
  loc_00479542: var_ret_B = "_AOL_Icon"
  loc_0047954A: var_eax = FindWindowEx(var_38, var_28, var_ret_B, 0)
  loc_0047954F: var_38 = FindWindowEx(var_38, var_28, var_ret_B, 0)
  loc_00479557: var_28 = var_38
  loc_0047956E: var_ret_C = "_AOL_Icon"
  loc_00479576: var_eax = FindWindowEx(var_38, var_28, var_ret_C, 0)
  loc_0047957B: var_38 = FindWindowEx(var_38, var_28, var_ret_C, 0)
  loc_00479583: var_28 = var_38
  loc_0047959A: var_ret_D = "_AOL_Icon"
  loc_004795A2: var_eax = FindWindowEx(var_38, var_28, var_ret_D, 0)
  loc_004795A7: var_38 = FindWindowEx(var_38, var_28, var_ret_D, 0)
  loc_004795AF: var_28 = var_38
  loc_004795C6: var_ret_E = "_AOL_Icon"
  loc_004795CE: var_eax = FindWindowEx(var_38, var_28, var_ret_E, 0)
  loc_004795D3: var_38 = FindWindowEx(var_38, var_28, var_ret_E, 0)
  loc_004795DB: var_28 = var_38
  loc_004795F2: var_ret_F = "_AOL_Icon"
  loc_004795FA: var_eax = FindWindowEx(var_38, var_28, var_ret_F, 0)
  loc_00479607: var_28 = FindWindowEx(var_38, var_28, var_ret_F, 0)
  loc_00479615: If var_38 = 0 Then GoTo loc_0047941B
  loc_00479620: If var_14 = 0 Then GoTo loc_0047941B
  loc_0047962B: If var_28 = 0 Then GoTo loc_0047941B
  loc_00479646: var_eax = SendMessage(var_14, 12, 0, arg_C)
  loc_00479652: var_ret_11 = var_30
  loc_00479677: var_eax = SendMessage(var_28, 513, 0, 0)
  loc_00479691: var_eax = SendMessage(var_28, 514, 0, 0)
  loc_004796A7: var_ret_12 = "America Online"
  loc_004796B3: var_ret_13 = "#32770"
  loc_004796B6: var_eax = FindWindow(var_ret_13, var_ret_12)
  loc_004796BB: var_38 = FindWindow(var_ret_13, var_ret_12)
  loc_004796DF: var_ret_14 = "Send Instant Message"
  loc_004796EB: var_ret_15 = "AOL Child"
  loc_004796F4: var_eax = FindWindowEx(var_1C, 0, var_ret_15, var_ret_14)
  loc_004796F9: var_38 = FindWindowEx(var_1C, 0, var_ret_15, var_ret_14)
  loc_0047970B: var_2C = var_38
  loc_00479719: If var_38 <> 0 Then GoTo loc_0047972A
  loc_00479720: If var_2C <> 0 Then GoTo loc_00479698
  loc_00479728: If var_38 = 0 Then GoTo loc_00479784
  loc_0047972A: 'Referenced from: 00479719
  loc_00479735: var_ret_16 = "Button"
  loc_0047973B: var_eax = FindWindowEx(var_38, 0, var_ret_16, 0)
  loc_00479740: var_38 = FindWindowEx(var_38, 0, var_ret_16, 0)
  loc_0047975B: var_eax = PostMessage(var_38, 256, 32, 0)
  loc_0047976C: var_eax = PostMessage(var_38, 257, 32, 0)
  loc_0047977D: var_eax = PostMessage(var_2C, 16, 0, 0)
  loc_00479784: 
  loc_00479789: GoTo loc_0047979F
  loc_0047979E: Exit Sub
  loc_0047979F: 'Referenced from: 00479789
End Sub

Public Sub Proc_2_5_4797C0
  loc_00479823: var_eax = call Proc_2_4_479360("$IM_OFF, " & Me, "=)", 0)
  loc_00479840: GoTo loc_00479856
  loc_00479855: Exit Sub
  loc_00479856: 'Referenced from: 00479840
End Sub

Public Sub Proc_2_6_479870
  loc_004798AA: var_eax = call Proc_2_1_478A40(edi, esi, ebx)
  loc_004798AF: var_44 = call Proc_2_1_478A40(edi, esi, ebx)
  loc_004798B6: var_eax = call Proc_2_15_47AA10(var_44, , )
  loc_004798C6: var_18 = call Proc_2_15_47AA10(var_44, , )
  loc_004798DE: If InStr(1, var_18, var_00414C98, 0) <> 0 Then GoTo loc_004798F5
  loc_004798E8: var_20 = vbNullString
  loc_004798F3: GoTo loc_0047996E
  loc_004798F5: 'Referenced from: 004798DE
  loc_00479904: var_38 = var_18
  loc_0047991C: Len(var_18) = Len(var_18) - InStr(1, var_18, var_00414C98, 0)
  loc_00479923: Len(var_18) = Len(var_18) - 00000001h
  loc_00479943: var_20 = Right(var_18, Len(var_18))
  loc_00479953: GoTo loc_0047996E
  loc_00479959: If var_4 = 0 Then GoTo loc_00479964
  loc_00479964: 'Referenced from: 00479959
  loc_0047996D: Exit Sub
  loc_0047996E: 'Referenced from: 004798F3
End Sub

Public Sub Proc_2_7_4799A0
  loc_004799E6: var_ret_1 = "America  Online"
  loc_004799F2: var_ret_2 = "AOL Frame25"
  loc_004799F5: var_eax = FindWindow(var_ret_2, var_ret_1)
  loc_00479A22: var_ret_3 = "MDIClient"
  loc_00479A28: var_eax = FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0)
  loc_00479A48: var_ret_4 = "AOL Child"
  loc_00479A51: var_eax = FindWindowEx(FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0), 0, var_ret_4, 0)
  loc_00479A56: var_34 = FindWindowEx(var_34, 0, var_ret_4, 0)
  loc_00479A6B: var_ret_5 = "RICHCNTL"
  loc_00479A74: var_eax = FindWindowEx(var_34, 0, var_ret_5, 0)
  loc_00479A80: var_28 = FindWindowEx(var_34, 0, var_ret_5, 0)
  loc_00479A89: var_eax = call Proc_2_16_47AB50(var_28, , )
  loc_00479A93: var_20 = call Proc_2_16_47AB50(var_28, , )
  loc_00479A9E: GoTo loc_00479AC3
  loc_00479AA4: If var_4 = 0 Then GoTo loc_00479AAF
  loc_00479AAF: 'Referenced from: 00479AA4
  loc_00479AC2: Exit Sub
  loc_00479AC3: 'Referenced from: 00479A9E
End Sub

Public Sub Proc_2_8_479AE0
  loc_00479B21: var_ret_1 = "AOL Frame25"
  loc_00479B24: var_eax = FindWindow(var_ret_1, 0)
  loc_00479B4A: var_ret_2 = "AOL Toolbar"
  loc_00479B53: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), 0, var_ret_2, 0)
  loc_00479B6D: var_ret_3 = "_AOL_Toolbar"
  loc_00479B76: var_eax = FindWindowEx(FindWindowEx(var_2C, 0, var_ret_2, 0), 0, var_ret_3, 0)
  loc_00479B90: var_ret_4 = "_AOL_Combobox"
  loc_00479B99: var_eax = FindWindowEx(FindWindowEx(var_2C, 0, var_ret_3, 0), 0, var_ret_4, 0)
  loc_00479BB3: var_ret_5 = "Edit"
  loc_00479BBC: var_eax = FindWindowEx(FindWindowEx(var_2C, 0, var_ret_4, 0), 0, var_ret_5, 0)
  loc_00479BC1: var_2C = FindWindowEx(var_2C, 0, var_ret_5, 0)
  loc_00479BE0: var_eax = SendMessage(var_2C, 12, 0, Me)
  loc_00479C04: var_eax = SendMessage(var_2C, 258, 32, 0)
  loc_00479C15: var_eax = SendMessage(var_2C, 258, 13, 0)
  loc_00479C21: GoTo loc_00479C2D
  loc_00479C2C: Exit Sub
  loc_00479C2D: 'Referenced from: 00479C21
End Sub

Public Sub Proc_2_9_479C50
  loc_00479CB1: var_40 = LCase(Me)
  loc_00479CBE: var_78 = arg_C
  loc_00479CC8: var_50 = LCase(arg_C)
  loc_00479CD9: call InStr(var_60, edi, var_50, var_40, 00000001h, 0, Me, %x1 = LCase(%StkVar2))
  loc_00479CE0: var_ret_1 = CLng(InStr(var_60, edi, var_50, var_40, 00000001h, 0, Me, %x1 = LCase(%StkVar2)))
  loc_00479D01: 
  loc_00479D03: If var_ret_1 <= 0 Then GoTo loc_00479E3C
  loc_00479D0E: var_ret_1 = var_ret_1 - 00000001h
  loc_00479D3C: var_28 = Left(Me, var_ret_1)
  loc_00479D5B: Len(arg_C) = Len(arg_C) + var_ret_1
  loc_00479D64: var_8C = Len(arg_C)
  loc_00479D78: If var_8C > 0 Then GoTo loc_00479DEF
  loc_00479D94: Len(Me) = Len(Me) - var_ret_1
  loc_00479D9F: var_90 = Len(Me)
  loc_00479DB0: var_90 = var_90 - Len(arg_C)
  loc_00479DE2: var_1C = Right(Me, var_90 + 00000001h + 00000001h)
  loc_00479DED: GoTo loc_00479E03
  loc_00479DEF: 'Referenced from: 00479D78
  loc_00479DF7: var_1C = vbNullString
  loc_00479E03: 'Referenced from: 00479DED
  loc_00479E2A: var_18 = var_28 & arg_10 & var_1C
  loc_00479E3A: GoTo loc_00479E41
  loc_00479E3C: 'Referenced from: 00479D03
  loc_00479E41: 'Referenced from: 00479E3A
  loc_00479E41: var_18 = esi
  loc_00479E55: Len(arg_10) = Len(arg_10) + var_ret_1
  loc_00479E5F: If Len(arg_10) <= 0 Then GoTo loc_00479EC7
  loc_00479E79: var_40 = LCase(Me)
  loc_00479E86: var_78 = arg_C
  loc_00479E90: var_50 = LCase(arg_C)
  loc_00479EA1: call InStr(var_60, 00000000h, var_50, var_40, Len(arg_10))
  loc_00479EA8: var_ret_2 = CLng(InStr(var_60, 00000000h, var_50, var_40, Len(arg_10)))
  loc_00479EC7: 'Referenced from: 00479E5F
  loc_00479ECA: If var_ret_2 >= 1 Then GoTo loc_00479D01
  loc_00479ED6: var_2C = var_18
  loc_00479EE1: GoTo loc_00479F13
  loc_00479EE7: If var_4 = 0 Then GoTo loc_00479EF2
  loc_00479EF2: 'Referenced from: 00479EE7
  loc_00479F12: Exit Sub
  loc_00479F13: 'Referenced from: 00479EE1
  loc_00479F28: Exit Sub
End Sub

Public Sub Proc_2_10_479F50
  loc_00479F9E: On Error Resume Next
  loc_00479FB7: Open arg_C For Input As #1 Len = -1
  loc_0047A006: Close #1
  loc_0047A030: var_50 = Input(LOF(1), 1)
  loc_0047A062: GoTo loc_0047A06E
  loc_0047A06D: Exit Sub
  loc_0047A06E: 'Referenced from: 0047A062
End Sub

Public Sub Proc_2_11_47A090
  loc_0047A0DE: On Error Resume Next
  loc_0047A10C: Open arg_C For Output As #1 Len = -1
  loc_0047A124: Print 1, eax
  loc_0047A136: Close #1
End Sub

Public Sub Proc_2_12_47A160
  loc_0047A1AE: On Error Resume Next
  loc_0047A1C7: Open Me For Input As #1 Len = -1
  loc_0047A1CD: 
  loc_0047A1E1: If EOF(1) <> 0 Then GoTo loc_0047A3DD
  loc_0047A1F9: Input 1, var_24
  loc_0047A20C: var_44 = var_24
  loc_0047A229: InStr(1, var_24, var_004152D0, 0) = InStr(1, var_24, var_004152D0, 0) - 00000001h
  loc_0047A250: var_28 = Left(var_24, InStr(1, var_24, var_004152D0, 0))
  loc_0047A269: var_44 = var_24
  loc_0047A292: Len(var_24) = Len(var_24) - InStr(1, var_24, var_004152D0, 0)
  loc_0047A2B8: var_2C = Right(var_24, Len(var_24))
  loc_0047A321: var_eax = Unknown_VTable_Call[ecx+000001ECh]
  loc_0047A329: var_54 = Unknown_VTable_Call[ecx+000001ECh]
  loc_0047A3A3: var_eax = Unknown_VTable_Call[eax+000001ECh]
  loc_0047A3AB: var_54 = Unknown_VTable_Call[eax+000001ECh]
  loc_0047A3D8: GoTo loc_0047A1CD
  loc_0047A3DD: 'Referenced from: 0047A1E1
  loc_0047A3E6: Close #1
  loc_0047A3F1: GoTo loc_0047A3FD
  loc_0047A3FC: Exit Sub
  loc_0047A3FD: 'Referenced from: 0047A3F1
End Sub

Public Sub Proc_2_13_47A440
  Dim var_4C As Me
  loc_0047A48E: On Error Resume Next
  loc_0047A4A7: Open Me For Output As #1 Len = -1
  loc_0047A4B9: var_4C = arg_C
  loc_0047A4C9: var_48 = var_4C.hDC
  loc_0047A4D1: var_50 = var_48
  loc_0047A50F: var_60 = var_48 - 0001h
  loc_0047A520: GoTo loc_0047A531
  loc_0047A522: 
  loc_0047A525: var_24 = var_24 + 1
  loc_0047A52E: var_24 = var_24
  loc_0047A531: 'Referenced from: 0047A520
  loc_0047A537: If var_24 > 0 Then GoTo loc_0047A654
  loc_0047A549: var_4C = arg_C
  loc_0047A553: var_ret_1 = var_24
  loc_0047A56B: var_50 = var_4C.CurrentY
  loc_0047A5A7: var_ret_2 = var_24
  loc_0047A5BF: var_58 = var_4C.CurrentY
  loc_0047A624: Print 1, var_28 & var_004152D0 & var_2C
  loc_0047A64F: GoTo loc_0047A522
  loc_0047A654: 'Referenced from: 0047A537
  loc_0047A65D: Close #1
  loc_0047A668: GoTo loc_0047A686
  loc_0047A685: Exit Sub
  loc_0047A686: 'Referenced from: 0047A668
  loc_0047A686: Exit Sub
End Sub

Public Sub Proc_2_14_47A6A0
  loc_0047A6ED: var_ret_1 = "AOL Frame25"
  loc_0047A6F0: var_eax = FindWindow(var_ret_1, var_34)
  loc_0047A709: var_24 = FindWindow(var_ret_1, var_34)
  loc_0047A71C: var_ret_2 = "MDICLIENT"
  loc_0047A725: var_eax = FindWindowEx(var_24, 0, var_ret_2, 0)
  loc_0047A732: var_28 = FindWindowEx(var_24, 0, var_ret_2, 0)
  loc_0047A74C: call Proc_2_8_479AE0("aol://4344:1580.prntcon.12263709.564517913", var_ret_3 = #StkVar1%StkVar2, GetLastError())
  loc_0047A765: var_ret_4 = " Parental Controls"
  loc_0047A771: var_ret_5 = "AOL Child"
  loc_0047A77A: var_eax = FindWindowEx(var_28, 0, var_ret_5, var_ret_4)
  loc_0047A791: var_14 = FindWindowEx(var_28, 0, var_ret_5, var_ret_4)
  loc_0047A7A8: var_ret_6 = "_AOL_Icon"
  loc_0047A7B1: var_eax = FindWindowEx(var_14, 0, var_ret_6, 0)
  loc_0047A7C1: var_20 = FindWindowEx(var_14, 0, var_ret_6, 0)
  loc_0047A7CB: If var_14 = 0 Then GoTo loc_0047A756
  loc_0047A7D2: If var_20 = 0 Then GoTo loc_0047A756
  loc_0047A7E7: var_eax = call Proc_47AEC0(CLng(0.3), , )
  loc_0047A7FF: var_eax = PostMessage(var_20, 513, 0, 0)
  loc_0047A813: var_eax = PostMessage(var_20, 514, 0, 0)
  loc_0047A82D: var_eax = call Proc_47AEC0(CLng(0.8), , )
  loc_0047A83D: var_ret_7 = "_AOL_Modal"
  loc_0047A840: var_eax = FindWindow(var_ret_7, 0)
  loc_0047A850: var_1C = FindWindow(var_ret_7, 0)
  loc_0047A860: var_ret_8 = "_AOL_Static"
  loc_0047A869: var_eax = FindWindowEx(var_1C, 0, var_ret_8, 0)
  loc_0047A879: var_2C = FindWindowEx(var_1C, 0, var_ret_8, 0)
  loc_0047A882: var_eax = call Proc_2_16_47AB50(var_2C, , )
  loc_0047A88C: var_18 = call Proc_2_16_47AB50(var_2C, , )
  loc_0047A8A3: If (var_18 = vbNullString) = 0 Then GoTo loc_0047A7EC
  loc_0047A8AE: If var_1C = 0 Then GoTo loc_0047A7EC
  loc_0047A8B9: If var_2C = 0 Then GoTo loc_0047A7EC
  loc_0047A8D5: var_38 = vbNullString
  loc_0047A8F0: var_34 = Chr(10)
  loc_0047A8FE: var_eax = call Proc_2_9_479C50(var_18, var_34, var_38)
  loc_0047A936: var_38 = vbNullString
  loc_0047A94B: var_34 = Chr(13)
  loc_0047A959: var_eax = call Proc_2_9_479C50(call Proc_2_9_479C50(var_18, var_34, var_38), var_34, var_38)
  loc_0047A963: var_18 = call Proc_2_9_479C50(var_18, var_34, var_38)
  loc_0047A99D: eax = (var_18 = "Set Parental Controls") - 1
  loc_0047A9A1: var_30 = (var_18 = "Set Parental Controls") - 1
  loc_0047A9A4: var_eax = PostMessage(var_1C, 16, 0, 0)
  loc_0047A9BB: var_eax = PostMessage(var_14, 16, 0, 0)
  loc_0047A9C8: GoTo loc_0047A9E7
  loc_0047A9E6: Exit Sub
  loc_0047A9E7: 'Referenced from: 0047A9C8
End Sub

Public Sub Proc_2_15_47AA10
  loc_0047AA50: var_eax = GetWindowTextLength(Me)
  loc_0047AA85: var_20 = String(GetWindowTextLength(Me), "")
  loc_0047AAA1: GetWindowTextLength(Me) = GetWindowTextLength(Me) + 00000001h
  loc_0047AABA: var_eax = GetWindowText(Me, var_20, GetWindowTextLength(Me))
  loc_0047AACD: var_ret_2 = var_24
  loc_0047AAE2: var_18 = var_20
  loc_0047AAED: GoTo loc_0047AB1B
  loc_0047AAF3: If var_4 = 0 Then GoTo loc_0047AAFE
  loc_0047AAFE: 'Referenced from: 0047AAF3
  loc_0047AB1A: Exit Sub
  loc_0047AB1B: 'Referenced from: 0047AAED
  loc_0047AB24: Exit Sub
End Sub

Public Sub Proc_2_16_47AB50
  loc_0047AB9A: var_eax = SendMessage(Me, 14, edi, var_58)
  loc_0047ABCF: var_1C = String(SendMessage(Me, 14, edi, var_58), "")
  loc_0047ABF6: SendMessage(Me, 14, edi, var_58) = SendMessage(Me, 14, edi, var_58) + 00000001h
  loc_0047AC06: var_eax = SendMessage(Me, 13, SendMessage(Me, 14, edi, var_58), var_1C)
  loc_0047AC19: var_ret_2 = var_24
  loc_0047AC2E: var_20 = var_1C
  loc_0047AC39: GoTo loc_0047AC67
  loc_0047AC3F: If var_4 = 0 Then GoTo loc_0047AC4A
  loc_0047AC4A: 'Referenced from: 0047AC3F
  loc_0047AC66: Exit Sub
  loc_0047AC67: 'Referenced from: 0047AC39
  loc_0047AC70: Exit Sub
End Sub

Public Sub Proc_2_17_47ACB0
  loc_0047ACFA: var_ret_1 = "AOL Frame25"
  loc_0047ACFD: var_eax = FindWindow(var_ret_1, var_30)
  loc_0047AD23: var_ret_2 = "MDIClient"
  loc_0047AD2C: var_eax = FindWindowEx(FindWindow(var_ret_1, var_30), 0, var_ret_2, 0)
  loc_0047AD31: var_54 = FindWindowEx(var_54, 0, var_ret_2, 0)
  loc_0047AD3C: var_24 = var_54
  loc_0047AD4C: var_ret_3 = "AOL Child"
  loc_0047AD55: var_eax = FindWindowEx(var_54, 0, var_ret_3, 0)
  loc_0047AD65: var_28 = FindWindowEx(var_54, 0, var_ret_3, 0)
  loc_0047AD6E: call Proc_2_15_47AA10(var_28, GetLastError(), var_ret_4 = #StkVar1%StkVar2)
  loc_0047AD78: var_18 = var_ret_4
  loc_0047AD94: If InStr(1, var_18, "Welcome, ", 0) <> 0 Then GoTo loc_0047ADF6
  loc_0047AD96: 
  loc_0047ADAF: InStr(1, var_18, var_00415430, 0) = InStr(1, var_18, var_00415430, 0) - 0000000Ah
  loc_0047ADBC: var_38 = InStr(1, var_18, var_00415430, 0)
  loc_0047ADE6: var_2C = Mid$(var_18, 10, InStr(1, var_18, var_00415430, 0))
  loc_0047ADF1: GoTo loc_0047AE8F
  loc_0047ADF6: 'Referenced from: 0047AD94
  loc_0047AE01: var_ret_5 = "AOL Child"
  loc_0047AE0C: var_eax = FindWindowEx(var_24, var_28, var_ret_5, 0)
  loc_0047AE11: var_54 = FindWindowEx(var_24, var_28, var_ret_5, 0)
  loc_0047AE1C: var_28 = var_54
  loc_0047AE25: call Proc_2_15_47AA10(var_28, var_0047AE99, var_28 = "")
  loc_0047AE2F: var_18 = var_54
  loc_0047AE4B: If InStr(1, var_18, "Welcome, ", 0) = 0 Then GoTo loc_0047AD96
  loc_0047AE56: If var_28 <> 0 Then GoTo loc_0047ADF6
  loc_0047AE60: var_2C = vbNullString
  loc_0047AE6B: GoTo loc_0047AE8F
  loc_0047AE71: If var_4 = 0 Then GoTo loc_0047AE7C
  loc_0047AE7C: 'Referenced from: 0047AE71
  loc_0047AE8E: Exit Sub
  loc_0047AE8F: 'Referenced from: 0047ADF1
End Sub

Public Sub Proc_2_18_47AF50
  loc_0047AF8B: var_ret_1 = "AOL Frame25"
  loc_0047AF92: var_eax = FindWindow(var_ret_1, 0)
  loc_0047AFAB: var_eax = GetMenu(FindWindow(var_ret_1, 0))
  loc_0047AFBB: var_eax = GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me)
  loc_0047AFCB: var_eax = GetMenuItemID(GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me), arg_C)
  loc_0047AFDD: var_eax = SendMessage(FindWindow(var_ret_1, 0), 273, GetMenuItemID(GetSubMenu(GetMenu(FindWindow(var_ret_1, 0)), Me), arg_C), 0)
  loc_0047AFE9: GoTo loc_0047AFF5
  loc_0047AFF4: Exit Sub
  loc_0047AFF5: 'Referenced from: 0047AFE9
End Sub
