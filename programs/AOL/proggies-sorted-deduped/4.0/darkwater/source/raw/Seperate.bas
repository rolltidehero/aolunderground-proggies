
Public Sub Proc_6_0_47D320
  loc_0047D36D: var_ret_1 = "AOL Frame25"
  loc_0047D370: var_eax = FindWindow(var_ret_1, var_44)
  loc_0047D389: var_18 = FindWindow(var_ret_1, var_44)
  loc_0047D39C: var_ret_2 = "MDIClient"
  loc_0047D3A5: var_eax = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0047D3B2: var_20 = FindWindowEx(var_18, 0, var_ret_2, 0)
  loc_0047D3C5: var_ret_3 = "AOL Child"
  loc_0047D3CE: var_eax = FindWindowEx(var_20, 0, var_ret_3, 0)
  loc_0047D3DB: var_28 = FindWindowEx(var_20, 0, var_ret_3, 0)
  loc_0047D3EE: var_ret_4 = "_AOL_Combobox"
  loc_0047D3F7: var_eax = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_0047D404: var_40 = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_0047D417: var_ret_5 = "_AOL_Edit"
  loc_0047D420: var_eax = FindWindowEx(var_28, 0, var_ret_5, 0)
  loc_0047D44B: var_eax = SendMessage(var_40, 326, 0, var_6C)
  loc_0047D4AA: var_eax = SendMessage(var_40, 334, CLng(SendMessage(var_40, 326, 0, 0) - 1), 0)
  loc_0047D4B9: var_44 = vbNullString
  loc_0047D4C4: var_ret_8 = var_44
  loc_0047D4D2: var_eax = SendMessage(FindWindowEx(var_28, 0, var_ret_5, 0), 12, 0, var_48)
  loc_0047D502: var_eax = SendMessage(var_40, 258, 13, 0)
  loc_0047D520: var_ret_9 = "_AOL_Modal"
  loc_0047D523: var_eax = FindWindow(var_ret_9, 0)
  loc_0047D533: var_2C = FindWindow(var_ret_9, 0)
  loc_0047D543: var_ret_A = "_AOL_Edit"
  loc_0047D54C: var_eax = FindWindowEx(var_2C, 0, var_ret_A, 0)
  loc_0047D55C: var_1C = FindWindowEx(var_2C, 0, var_ret_A, 0)
  loc_0047D56C: var_ret_B = "_AOL_Edit"
  loc_0047D577: var_eax = FindWindowEx(var_2C, var_1C, var_ret_B, 0)
  loc_0047D584: var_24 = FindWindowEx(var_2C, var_1C, var_ret_B, 0)
  loc_0047D597: var_ret_C = "AOL Frame25"
  loc_0047D59A: var_eax = FindWindow(var_ret_C, 0)
  loc_0047D59F: var_6C = FindWindow(var_ret_C, 0)
  loc_0047D5AD: var_eax = IsWindowVisible(var_40)
  loc_0047D5B2: var_6C = IsWindowVisible(var_40)
  loc_0047D5BC: If var_6C <> 0 Then GoTo loc_0047D5D4
  loc_0047D5C3: If var_1C = 0 Then GoTo loc_0047D50F
  loc_0047D5CE: If var_24 = 0 Then GoTo loc_0047D50F
  loc_0047D5D4: 'Referenced from: 0047D5BC
  loc_0047D5D9: If var_1C = 0 Then GoTo loc_0047D65A
  loc_0047D5E0: If var_24 = 0 Then GoTo loc_0047D65A
  loc_0047D5F7: var_eax = SendMessage(var_1C, 12, 0, Me)
  loc_0047D606: var_ret_E = var_44
  loc_0047D626: var_eax = SendMessage(var_24, 12, 0, arg_C)
  loc_0047D635: var_ret_10 = var_44
  loc_0047D653: var_eax = SendMessage(var_24, 258, 13, 0)
  loc_0047D65A: 'Referenced from: 0047D5D9
  loc_0047D65F: GoTo loc_0047D67E
  loc_0047D67D: Exit Sub
  loc_0047D67E: 'Referenced from: 0047D65F
End Sub

Public Sub Proc_6_1_47D6A0
  loc_0047D6E1: var_ret_1 = "AOL Frame25"
  loc_0047D6E4: var_eax = FindWindow(var_ret_1, var_28)
  loc_0047D70A: var_ret_2 = "MDIClient"
  loc_0047D713: var_eax = FindWindowEx(FindWindow(var_ret_1, var_28), 0, var_ret_2, 0)
  loc_0047D718: var_2C = FindWindowEx(var_2C, 0, var_ret_2, 0)
  loc_0047D723: var_1C = var_2C
  loc_0047D733: var_ret_3 = "AOL Child"
  loc_0047D73C: var_eax = FindWindowEx(var_2C, 0, var_ret_3, 0)
  loc_0047D762: var_ret_4 = "AOL Child"
  loc_0047D76D: var_eax = FindWindowEx(var_1C, FindWindowEx(FindWindowEx(var_2C, 0, var_ret_3, 0), 0, var_ret_3, 0), var_ret_4, 0)
  loc_0047D77D: var_24 = FindWindowEx(var_1C, var_24, var_ret_4, 0)
  loc_0047D788: call Proc_2_15_47AA10(var_24, 1, var_24 = "")
  loc_0047D7B1: esi = InStr(FindWindowEx(var_1C, var_24, var_ret_4, 0), GetLastError, "Welcome", 0) - 1
  loc_0047D7B7: If InStr(FindWindowEx(var_1C, var_24, var_ret_4, 0) <> 0 Then GoTo loc_0047D751
  loc_0047D7BF: call Proc_2_15_47AA10(var_24, 1, var_ret_5 = #StkVar1%StkVar2)
  loc_0047D7F6: var_18 = InStr(, var_ret_5, "Welcome", 0)
  loc_0047D7F9: GoTo loc_0047D805
  loc_0047D804: Exit Sub
  loc_0047D805: 'Referenced from: 0047D7F9
End Sub

Public Sub Proc_6_2_47D850
  loc_0047D8F0: var_BC = eax.hDC
  loc_0047D91B: var_BC = var_BC - 0001h
  loc_0047D92B: var_A0 = var_BC
  loc_0047D95F: For var_30 = "" To var_BC Step 1
  loc_0047D971: 
  loc_0047D973: If var_30 = 0 Then GoTo loc_0047DBD4
  loc_0047D99C: var_BC = eax.hDC
  loc_0047D9D5: var_B0 = var_BC
  loc_0047DA2D: For var_20 = var_30 + 1 To var_BC Step 1
  loc_0047DA33: 
  loc_0047DA35: If var_110 = 0 Then GoTo loc_0047DBBB
  loc_0047DA4A: var_30 = CInt(var_34)
  loc_0047DA4E: var_30 = eax.CurrentY
  loc_0047DA72: var_40 = var_34
  loc_0047DA88: var_58 = Ucase(0)
  loc_0047DA9D: var_20 = CInt(var_38)
  loc_0047DAA1: var_20 = eax.CurrentY
  loc_0047DAD1: var_60 = var_38
  loc_0047DADB: var_78 = Ucase(var_38)
  loc_0047DB0F: If (var_58 = var_78) = 0 Then GoTo loc_0047DB9C
  loc_0047DB20: var_20 = CInt(0)
  loc_0047DB24: var_eax = Unknown_VTable_Call[ebx+000001F0h]
  loc_0047DB4D: var_20 = CInt(Unknown_VTable_Call[ebx+000001F0h])
  loc_0047DB51: var_eax = Unknown_VTable_Call[ebx+000001F0h]
  loc_0047DB7A: var_20 = CInt(arg_C)
  loc_0047DB7E: var_eax = Unknown_VTable_Call[ebx+000001F0h]
  loc_0047DB9C: 'Referenced from: 0047DB0F
  loc_0047DBB4: Next var_20
  loc_0047DBB6: GoTo loc_0047DA33
  loc_0047DBBB: 'Referenced from: 0047DA35
  loc_0047DBCD: Next var_30
  loc_0047DBCF: GoTo loc_0047D971
  loc_0047DBD4: 'Referenced from: 0047D973
  loc_0047DBD9: GoTo loc_0047DC0E
  loc_0047DC0D: Exit Sub
  loc_0047DC0E: 'Referenced from: 0047DBD9
  loc_0047DC4C: Exit Sub
End Sub

Public Sub Proc_6_3_47DC70
  loc_0047DCBE: On Error Resume Next
  loc_0047DCD7: Open Me For Input As #1 Len = -1
  loc_0047DCDD: 
  loc_0047DCF1: If EOF(1) <> 0 Then GoTo loc_0047DF16
  loc_0047DD11: Line Input #1, var_30
  loc_0047DD24: Line Input #1, var_40
  loc_0047DD37: Line Input #1, var_50
  loc_0047DD85: var_54 = CStr(var_30)
  loc_0047DD95: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_0047DD9D: var_6C = Unknown_VTable_Call[edx+000001ECh]
  loc_0047DE21: var_54 = CStr(var_40)
  loc_0047DE31: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_0047DE39: var_6C = Unknown_VTable_Call[edx+000001ECh]
  loc_0047DEBD: var_54 = CStr(var_50)
  loc_0047DECD: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_0047DED5: var_6C = Unknown_VTable_Call[edx+000001ECh]
  loc_0047DF11: GoTo loc_0047DCDD
  loc_0047DF16: 'Referenced from: 0047DCF1
  loc_0047DF1F: Close #1
  loc_0047DF2A: GoTo loc_0047DF36
  loc_0047DF35: Exit Sub
  loc_0047DF36: 'Referenced from: 0047DF2A
End Sub

Public Sub Proc_6_4_47DF70
  Dim var_6C As Me
  loc_0047DFBE: On Error Resume Next
  loc_0047DFD7: Open Me For Output As #1 Len = -1
  loc_0047DFF7: var_6C = arg_C
  loc_0047E007: var_68 = var_6C.hDC
  loc_0047E00F: var_70 = var_68
  loc_0047E046: var_68 = var_68 - 0001h
  loc_0047E050: var_4C = var_68
  loc_0047E084: For var_30 = 0 To var_68 Step 1
  loc_0047E08A: var_A8 = var_80
  loc_0047E090: GoTo loc_0047E241
  loc_0047E095: 
  loc_0047E0AE: var_6C = arg_C
  loc_0047E0B9: var_30 = CInt(var_34)
  loc_0047E0D1: var_70 = var_6C.CurrentY
  loc_0047E10F: Print 1, var_34
  loc_0047E12D: var_6C = arg_10
  loc_0047E138: var_30 = CInt(var_34)
  loc_0047E150: var_70 = var_6C.CurrentY
  loc_0047E18E: Print 1, var_34
  loc_0047E1AC: var_6C = arg_14
  loc_0047E1B7: var_30 = CInt(var_34)
  loc_0047E1C7: var_30 = var_6C.CurrentY
  loc_0047E1CF: var_70 = var_30
  loc_0047E20D: Print 1, var_34
  loc_0047E235: Next var_30
  loc_0047E23B: var_A8 = Next var_30
  loc_0047E241: 'Referenced from: 0047E090
  loc_0047E248: If var_A8 <> 0 Then GoTo loc_0047E095
  loc_0047E257: Close #1
  loc_0047E262: GoTo loc_0047E26E
  loc_0047E26D: Exit Sub
  loc_0047E26E: 'Referenced from: 0047E262
  loc_0047E28D: Exit Sub
End Sub

Public Sub Proc_6_5_47E2B0
  loc_0047E2F3: var_ret_1 = "America  Online"
  loc_0047E2FF: var_ret_2 = "AOL Frame25"
  loc_0047E302: var_eax = FindWindow(var_ret_2, var_ret_1)
  loc_0047E333: var_ret_3 = "MDIClient"
  loc_0047E339: var_eax = FindWindowEx(FindWindow(var_ret_2, var_ret_1), 0, var_ret_3, 0)
  loc_0047E34F: var_28 = FindWindowEx(var_68, 0, var_ret_3, 0)
  loc_0047E35F: var_ret_4 = "AOL Child"
  loc_0047E368: var_eax = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_0047E378: var_34 = FindWindowEx(var_28, 0, var_ret_4, 0)
  loc_0047E388: var_ret_5 = "_AOL_Icon"
  loc_0047E391: var_eax = FindWindowEx(var_34, 0, var_ret_5, 0)
  loc_0047E3A1: var_5C = FindWindowEx(var_34, 0, var_ret_5, 0)
  loc_0047E3B1: var_ret_6 = "_AOL_Icon"
  loc_0047E3BC: var_eax = FindWindowEx(var_34, var_5C, var_ret_6, 0)
  loc_0047E3CC: var_14 = FindWindowEx(var_34, var_5C, var_ret_6, 0)
  loc_0047E3DC: var_ret_7 = "_AOL_Icon"
  loc_0047E3E7: var_eax = FindWindowEx(var_34, var_14, var_ret_7, 0)
  loc_0047E3F4: var_18 = FindWindowEx(var_34, var_14, var_ret_7, 0)
  loc_0047E407: var_ret_8 = "_AOL_Icon"
  loc_0047E412: var_eax = FindWindowEx(var_34, var_18, var_ret_8, 0)
  loc_0047E422: var_1C = FindWindowEx(var_34, var_18, var_ret_8, 0)
  loc_0047E432: var_ret_9 = "_AOL_Icon"
  loc_0047E43D: var_eax = FindWindowEx(var_34, var_1C, var_ret_9, 0)
  loc_0047E44D: var_24 = FindWindowEx(var_34, var_1C, var_ret_9, 0)
  loc_0047E45D: var_ret_A = "_AOL_Icon"
  loc_0047E468: var_eax = FindWindowEx(var_34, var_24, var_ret_A, 0)
  loc_0047E475: var_2C = FindWindowEx(var_34, var_24, var_ret_A, 0)
  loc_0047E488: var_ret_B = "_AOL_Icon"
  loc_0047E493: var_eax = FindWindowEx(var_34, var_2C, var_ret_B, 0)
  loc_0047E4A3: var_30 = FindWindowEx(var_34, var_2C, var_ret_B, 0)
  loc_0047E4B3: var_ret_C = "_AOL_Icon"
  loc_0047E4BE: var_eax = FindWindowEx(var_34, var_30, var_ret_C, 0)
  loc_0047E4CE: var_38 = FindWindowEx(var_34, var_30, var_ret_C, 0)
  loc_0047E4DE: var_ret_D = "_AOL_Icon"
  loc_0047E4E9: var_eax = FindWindowEx(var_34, var_38, var_ret_D, 0)
  loc_0047E4F6: var_3C = FindWindowEx(var_34, var_38, var_ret_D, 0)
  loc_0047E509: var_ret_E = "_AOL_Icon"
  loc_0047E514: var_eax = FindWindowEx(var_34, var_3C, var_ret_E, 0)
  loc_0047E524: var_40 = FindWindowEx(var_34, var_3C, var_ret_E, 0)
  loc_0047E534: var_ret_F = "_AOL_Icon"
  loc_0047E53F: var_eax = FindWindowEx(var_34, var_40, var_ret_F, 0)
  loc_0047E54F: var_44 = FindWindowEx(var_34, var_40, var_ret_F, 0)
  loc_0047E55F: var_ret_10 = "_AOL_Icon"
  loc_0047E56A: var_eax = FindWindowEx(var_34, var_44, var_ret_10, 0)
  loc_0047E577: var_48 = FindWindowEx(var_34, var_44, var_ret_10, 0)
  loc_0047E58A: var_ret_11 = "_AOL_Icon"
  loc_0047E595: var_eax = FindWindowEx(var_34, var_48, var_ret_11, 0)
  loc_0047E5A5: var_50 = FindWindowEx(var_34, var_48, var_ret_11, 0)
  loc_0047E5B5: var_ret_12 = "_AOL_Icon"
  loc_0047E5C0: var_eax = FindWindowEx(var_34, var_50, var_ret_12, 0)
  loc_0047E5D0: var_54 = FindWindowEx(var_34, var_50, var_ret_12, 0)
  loc_0047E5E0: var_ret_13 = "_AOL_Icon"
  loc_0047E5EB: var_eax = FindWindowEx(var_34, var_54, var_ret_13, 0)
  loc_0047E5F8: var_58 = FindWindowEx(var_34, var_54, var_ret_13, 0)
  loc_0047E60B: var_ret_14 = "_AOL_Icon"
  loc_0047E616: var_eax = FindWindowEx(var_34, var_58, var_ret_14, 0)
  loc_0047E61B: var_68 = FindWindowEx(var_34, var_58, var_ret_14, 0)
  loc_0047E638: var_eax = SendMessage(var_68, 513, ebx, var_68)
  loc_0047E64D: var_eax = SendMessage(var_68, 514, ebx, var_68)
  loc_0047E659: GoTo loc_0047E66F
  loc_0047E66E: Exit Sub
  loc_0047E66F: 'Referenced from: 0047E659
End Sub
