Private Sub Timer4_Timer() '5D79B0
  Dim var_1FC As ListBox
  Dim var_80 As ListBox
  loc_005D7AFF: var_eax = call Proc_79_38_607B50(edi, esi, ebx)
  loc_005D7B0A: var_88 = call Proc_79_38_607B50(edi, esi, ebx)
  loc_005D7B3E: var_68 = LCase(call Proc_79_38_607B50(edi, esi, ebx))
  loc_005D7B6F: InStr(1, var_68, var_00431C88, 0) = InStr(1, var_68, var_00431C88, 0) - 00000001h
  loc_005D7B7E: var_88 = InStr(1, var_68, var_00431C88, 0)
  loc_005D7B87: var_198 = var_68
  loc_005D7BC6: var_18 = Mid(var_68, 1, InStr(1, var_68, var_00431C88, 0))
  loc_005D7C0F: var_198 = var_68
  loc_005D7C25: InStr(1, var_68, var_00431C88, 0) = InStr(1, var_68, var_00431C88, 0) + 00000003h
  loc_005D7C51: var_3C = Mid(var_68, InStr(1, var_68, var_00431C88, 0), 10)
  loc_005D7C73: var_198 = var_3C
  loc_005D7C91: var_90 = LCase(var_3C)
  loc_005D7CA8: var_eax = call Proc_79_47_609590(, , )
  loc_005D7CAD: var_98 = call Proc_79_47_609590(, , )
  loc_005D7D31: var_100 = LCase(&H43137C + LCase(call Proc_79_47_609590(, , )) + LCase(" send list"))
  loc_005D7D48: call __vbaVarLikeVar(var_110, var_100, var_90)
  loc_005D7D5B: var_1FC = CBool(__vbaVarLikeVar(var_110, var_100, var_90))
  loc_005D7DA6: If var_1FC = 0 Then GoTo loc_005D8351
  loc_005D7DE7: var_1F4 = List1.ListCount
  loc_005D7E17: var_1F4 = var_1F4 - 0001h
  loc_005D7E33: var_1A8 = var_1F4
  loc_005D7E61: For var_38 = "" To var_1F4 Step 1
  loc_005D7E6A: var_2D0 = var_224
  loc_005D7E7C: If var_2D0 = 0 Then GoTo loc_005D7FF7
  loc_005D7EA9: var_38 = CInt(var_6C)
  loc_005D7EB9: var_80 = List1.List(var_38)
  loc_005D7EE0: var_40 = var_6C
  loc_005D7EF8: var_1C8 = var_40
  loc_005D7F19: var_1A8 = vbNullString
  loc_005D7F2D: var_198 = var_18
  loc_005D7F54: var_1B8 = "-list"
  loc_005D7F99: var_1FC = (var_40 = LCase(vbNullString + LCase(var_18) + "-list"))
  loc_005D7FCE: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D7FE6: Next var_38
  loc_005D7FEC: var_2D0 = Next var_38
  loc_005D7FF2: GoTo loc_005D7E76
  loc_005D7FF7: 'Referenced from: 005D7E7C
  loc_005D8032: var_1F4 = List2.ListCount
  loc_005D8062: var_1F4 = var_1F4 - 0001h
  loc_005D807E: var_1A8 = var_1F4
  loc_005D80AC: For var_38 = "" To var_1F4 Step 1
  loc_005D80B5: var_2D8 = var_244
  loc_005D80C1: 
  loc_005D80CF: If Me = 0 Then GoTo loc_005D8244
  loc_005D80F6: var_38 = CInt(var_6C)
  loc_005D8106: var_80 = List2.List(var_38)
  loc_005D812D: var_40 = var_6C
  loc_005D8145: var_1C8 = var_40
  loc_005D8166: var_1A8 = vbNullString
  loc_005D817A: var_198 = var_18
  loc_005D81A1: var_1B8 = "-list"
  loc_005D81E6: var_1FC = (var_40 = LCase(vbNullString + LCase(var_18) + "-list"))
  loc_005D821B: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D8233: Next var_38
  loc_005D8239: var_2D8 = Next var_38
  loc_005D823F: GoTo loc_005D80C1
  loc_005D8280: var_198 = var_18
  loc_005D82A1: var_1A8 = "-list"
  loc_005D82F2: var_6C = CStr(LCase(var_18) + "-list")
  loc_005D8302: var_eax = List1.AddItem var_6C, var_1B4
  loc_005D8351: 'Referenced from: 005D7DA6
  loc_005D8362: var_198 = var_3C
  loc_005D8372: var_90 = LCase(var_3C)
  loc_005D8388: var_eax = call Proc_79_47_609590(, , )
  loc_005D838D: var_98 = call Proc_79_47_609590(, , )
  loc_005D8413: var_100 = LCase(&H43137C + LCase(call Proc_79_47_609590(, , )) + LCase(" send status"))
  loc_005D8426: var_1C8 = var_3C
  loc_005D8436: var_120 = Ucase(var_3C)
  loc_005D843C: var_1D8 = "<aolpromo>/"
  loc_005D8450: var_eax = call Proc_79_47_609590(var_80, Next var_38, var_234)
  loc_005D8455: var_128 = call Proc_79_47_609590(var_80, Next var_38, var_234)
  loc_005D848A: var_1E8 = " send status"
  loc_005D84B9: var_170 = Ucase("<aolpromo>/" + LCase(call Proc_79_47_609590(var_80, Next var_38, var_234)) + " send status")
  loc_005D84D4: call __vbaVarLikeVar(var_110, var_100, var_90, var_244, Me, Me, var_80, Me, Me)
  loc_005D84F0: call __vbaVarLikeVar(var_180, var_170, var_120, __vbaVarLikeVar(var_110, var_100, var_90, var_244, Me, Me, var_80, Me, Me))
  loc_005D84FE: call Or(var_190, __vbaVarLikeVar(var_180, var_170, var_120, __vbaVarLikeVar(var_110, var_100, var_90, var_244, Me, Me, var_80, Me, Me)))
  loc_005D850B: var_1FC = CBool(Or(var_190, __vbaVarLikeVar(var_180, var_170, var_120, __vbaVarLikeVar(var_110, var_100, var_90, var_244, Me, Me, var_80, Me, Me))))
  loc_005D8586: If var_1FC = 0 Then GoTo loc_005D8730
  loc_005D85B0: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005D862C: var_7C = var_0042EC60 & var_18 & "• " & var_70 & " •commands pending•"
  loc_005D8667: var_eax = call Proc_3_4_5A51B0(var_A0, var_60, 3)
  loc_005D86D9: var_6C = "<font face=""tahoma"">" & call Proc_79_47_609590(, , )
  loc_005D86FA: var_eax = call Proc_79_17_604A50(var_6C & vbNullString, Me, Me)
  loc_005D872B: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005D8730: 'Referenced from: 005D8586
  loc_005D8741: var_198 = var_3C
  loc_005D8751: var_90 = LCase(var_3C)
  loc_005D8767: var_eax = call Proc_79_47_609590(, , )
  loc_005D876C: var_98 = call Proc_79_47_609590(, , )
  loc_005D87AC: var_D0 = " send *"
  loc_005D87F2: var_100 = LCase(&H43137C + LCase(call Proc_79_47_609590(, , )) + LCase(var_D0))
  loc_005D8809: call __vbaVarLikeVar(var_110, var_100, var_90)
  loc_005D8816: var_1FC = CBool(__vbaVarLikeVar(var_110, var_100, var_90))
  loc_005D8867: If var_1FC = 0 Then GoTo loc_005D96D1
  loc_005D8897: var_198 = var_3C
  loc_005D88AD: InStr(1, var_3C, "d ", 0) = InStr(1, var_3C, "d ", 0) + 00000002h
  loc_005D88D4: var_50 = Mid(var_3C, InStr(1, var_3C, "d ", 0), 10)
  loc_005D88F7: var_198 = var_3C
  loc_005D8907: var_90 = Ucase(var_3C)
  loc_005D8921: var_eax = call Proc_79_47_609590(, , )
  loc_005D8934: var_98 = call Proc_79_47_609590(, , )
  loc_005D895B: var_1B8 = " send list"
  loc_005D898A: var_E0 = Ucase(&H43137C + LCase(call Proc_79_47_609590(, , )) + " send list")
  loc_005D89A5: call __vbaVarLikeVar(var_F0, var_E0, var_90)
  loc_005D89B2: var_1FC = CBool(__vbaVarLikeVar(var_F0, var_E0, var_90))
  loc_005D89F5: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D8A0C: var_198 = var_3C
  loc_005D8A1C: var_90 = Ucase(var_3C)
  loc_005D8A36: var_eax = call Proc_79_47_609590(, , )
  loc_005D8A3B: var_98 = call Proc_79_47_609590(, , )
  loc_005D8A70: var_1B8 = " send status"
  loc_005D8A9F: var_E0 = Ucase(&H43137C + LCase(call Proc_79_47_609590(, , )) + " send status")
  loc_005D8ABA: call __vbaVarLikeVar(var_F0, var_E0, var_90)
  loc_005D8AC7: var_1FC = CBool(__vbaVarLikeVar(var_F0, var_E0, var_90))
  loc_005D8B0A: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D8B45: var_1FC = var_80
  loc_005D8B4B: var_1F4 = List1.ListCount
  loc_005D8B7B: var_1F4 = var_1F4 - 0001h
  loc_005D8B97: var_1A8 = var_1F4
  loc_005D8BC5: For var_38 = "" To var_1F4 Step 1
  loc_005D8BCE: var_2E0 = var_264
  loc_005D8BE0: If var_2E0 = 0 Then GoTo loc_005D8D99
  loc_005D8C0D: var_38 = CInt(var_6C)
  loc_005D8C1D: var_80 = List1.List(var_38)
  loc_005D8C44: var_40 = var_6C
  loc_005D8C5C: var_1D8 = var_40
  loc_005D8C7D: var_1A8 = vbNullString
  loc_005D8C91: var_198 = var_18
  loc_005D8CD3: var_1C8 = vbNullString
  loc_005D8D33: var_1FC = (var_40 = LCase(vbNullString + LCase(var_18) + &H431364 + var_50 + vbNullString))
  loc_005D8D70: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D8D88: Next var_38
  loc_005D8D8E: var_2E0 = Next var_38
  loc_005D8D94: GoTo loc_005D8BDA
  loc_005D8D99: 'Referenced from: 005D8BE0
  loc_005D8DD4: var_1F4 = List2.ListCount
  loc_005D8E04: var_1F4 = var_1F4 - 0001h
  loc_005D8E20: var_1A8 = var_1F4
  loc_005D8E4E: For var_38 = "" To var_1F4 Step 1
  loc_005D8E57: var_2E8 = var_284
  loc_005D8E69: If var_2E8 = 0 Then GoTo loc_005D9022
  loc_005D8E96: var_38 = CInt(var_6C)
  loc_005D8EA6: var_80 = List2.List(var_38)
  loc_005D8ECD: var_40 = var_6C
  loc_005D8EE5: var_1D8 = var_40
  loc_005D8F06: var_1A8 = vbNullString
  loc_005D8F1A: var_198 = var_18
  loc_005D8F5C: var_1C8 = vbNullString
  loc_005D8FBC: var_1FC = (var_40 = LCase(vbNullString + LCase(var_18) + &H431364 + var_50 + vbNullString))
  loc_005D8FF9: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D9011: Next var_38
  loc_005D9017: var_2E8 = Next var_38
  loc_005D901D: GoTo loc_005D8E63
  loc_005D9022: 'Referenced from: 005D8E69
  loc_005D902F: If IsNumeric(var_50) <> 0 Then GoTo loc_005D91AB
  loc_005D9057: var_6C = var_0042EC60 & var_18
  loc_005D9061: var_88 = var_6C & "• "
  loc_005D9090: var_198 = " • is invalid•"
  loc_005D90BB: var_70 = var_6C & "• " & var_50 & " • is invalid•"
  loc_005D90F2: var_eax = call Proc_3_4_5A51B0(var_D0, var_60, 3)
  loc_005D9170: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_D0 & vbNullString, var_274, var_284)
  loc_005D91A1: var_eax = call Proc_6098C0(CLng(0.55), Me, Me)
  loc_005D91A6: GoTo loc_005DA019
  loc_005D91AB: 'Referenced from: 005D902F
  loc_005D91D2: var_1F4 = List3.ListCount
  loc_005D9222: var_204 = (var_50 > var_1F4)
  loc_005D9235: If var_204 = 0 Then GoTo loc_005D93B1
  loc_005D925D: var_6C = var_0042EC60 & var_18
  loc_005D9267: var_88 = var_6C & "• "
  loc_005D9296: var_198 = " • is invalid•"
  loc_005D92A0: var_A0 = var_6C & "• " & var_50
  loc_005D92C1: var_70 = var_A0 & " • is invalid•"
  loc_005D92F8: var_eax = call Proc_3_4_5A51B0(var_D0, var_60, 3)
  loc_005D9376: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_D0 & vbNullString, var_80, Me)
  loc_005D93A7: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005D93AC: GoTo loc_005DA019
  loc_005D93B1: 'Referenced from: 005D9235
  loc_005D93F9: call InStr(var_A0, edi, var_1A0, var_90, 00000001h, Me)
  loc_005D9406: var_1FC = CBool(InStr(var_A0, edi, var_1A0, var_90, 00000001h, Me))
  loc_005D942D: If var_1FC = 0 Then GoTo loc_005D95A9
  loc_005D9455: var_6C = var_0042EC60 & var_18
  loc_005D9465: var_88 = var_6C & "• "
  loc_005D948E: var_198 = " • is invalid•"
  loc_005D94A9: var_B0 = var_6C & "• " & var_50 & " • is invalid•"
  loc_005D94B9: var_70 = var_B0
  loc_005D94F0: var_eax = call Proc_3_4_5A51B0(var_D0, var_60, 3)
  loc_005D9559: var_6C = "<font face=""tahoma"">" & var_D0
  loc_005D956E: var_eax = call Proc_79_17_604A50(var_6C & vbNullString, , )
  loc_005D959F: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005D95A4: GoTo loc_005DA019
  loc_005D95A9: 'Referenced from: 005D942D
  loc_005D95EB: var_198 = var_18
  loc_005D9656: var_A0 = var_6C & "• "
  loc_005D9664: ecx = var_50
  loc_005D966B: var_6C = CStr(var_B0)
  loc_005D967B: var_eax = List1.AddItem var_6C, var_B0
  loc_005D96D1: 'Referenced from: 005D8867
  loc_005D96E2: var_198 = var_3C
  loc_005D96F2: var_90 = LCase(var_3C)
  loc_005D9708: var_eax = call Proc_79_47_609590(var_50, var_A0, var_A0)
  loc_005D970D: var_98 = call Proc_79_47_609590(var_50, var_A0, var_A0)
  loc_005D972B: var_B0 = LCase(call Proc_79_47_609590(var_50, 8, 8))
  loc_005D9767: ecx = " find *"
  loc_005D9771: var_E0 = LCase(var_D0)
  loc_005D9788: call __vbaVarLikeVar(var_F0, var_E0, var_90, var_D0, var_1C0, var_C0, var_C0, var_B0, var_1B0, var_1B0, var_90, var_1B4)
  loc_005D9795: var_1FC = CBool(__vbaVarLikeVar(var_F0, var_E0, var_90, var_D0, var_1C0, var_C0, var_C0, var_B0, var_1B0, var_1B0, var_90, var_1B4))
  loc_005D97D8: If var_1FC = 0 Then GoTo loc_005DA019
  loc_005D980E: var_198 = var_3C
  loc_005D9824: InStr(1, var_3C, "d ", 0) = InStr(1, var_3C, "d ", 0) + 00000002h
  loc_005D983C: var_A0 = Mid(var_3C, InStr(1, var_3C, "d ", 0), 10)
  loc_005D984B: var_28 = var_A0
  loc_005D987C: var_90 = Len(var_28)
  loc_005D9893: If (var_90 < 2) <> 0 Then GoTo loc_005DA019
  loc_005D98A7: If IsNumeric(var_28) <> var_FFFFFF Then GoTo loc_005D99B7
  loc_005D98DE: var_70 = var_0042EC60 & var_18 & "• number finds are invalid•"
  loc_005D9915: var_eax = call Proc_3_4_5A51B0(var_A0, var_60, 3)
  loc_005D9967: var_6C = "<font face=""tahoma"">" & var_A0
  loc_005D997C: var_eax = call Proc_79_17_604A50(var_6C & vbNullString, , )
  loc_005D99AD: var_eax = call Proc_6098C0(CLng(0.55), , )
  loc_005D99B2: GoTo loc_005DA019
  loc_005D99B7: 'Referenced from: 005D98A7
  loc_005D99F2: var_1F4 = List1.ListCount
  loc_005D9A22: var_1F4 = var_1F4 - 0001h
  loc_005D9A3E: var_1A8 = var_1F4
  loc_005D9A6C: For var_38 = "" To var_1F4 Step 1
  loc_005D9A75: var_2F0 = var_2A4
  loc_005D9A87: If var_2F0 = 0 Then GoTo loc_005D9C5A
  loc_005D9AB4: var_38 = CInt(var_6C)
  loc_005D9AC4: var_80 = List1.List(var_38)
  loc_005D9AEB: var_40 = var_6C
  loc_005D9B03: var_1D8 = var_40
  loc_005D9B24: var_1A8 = vbNullString
  loc_005D9B38: var_198 = var_18
  loc_005D9B48: var_90 = LCase(var_18)
  loc_005D9B94: var_90 = var_A0
  loc_005D9BA5: var_B0 = var_A0
  loc_005D9BB6: ecx = LCase(var_28)
  loc_005D9BE7: var_1FC = (var_40 = LCase(var_E0))
  loc_005D9C31: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D9C49: Next var_38
  loc_005D9C4F: var_2F0 = Next var_38
  loc_005D9C55: GoTo loc_005D9A81
  loc_005D9C5A: 'Referenced from: 005D9A87
  loc_005D9C95: var_1F4 = List2.ListCount
  loc_005D9CC5: var_1F4 = var_1F4 - 0001h
  loc_005D9CE1: var_1A8 = var_1F4
  loc_005D9D0F: For var_38 = "" To var_1F4 Step 1
  loc_005D9D18: var_2F8 = var_2C4
  loc_005D9D24: 
  loc_005D9D32: If Me = 0 Then GoTo loc_005D9EFF
  loc_005D9D59: var_38 = CInt(var_6C)
  loc_005D9D69: var_80 = List2.List(var_38)
  loc_005D9D90: var_40 = var_6C
  loc_005D9DA8: var_1D8 = var_40
  loc_005D9DC9: var_1A8 = vbNullString
  loc_005D9DDD: var_198 = var_18
  loc_005D9DED: var_90 = LCase(var_18)
  loc_005D9E39: var_90 = var_A0
  loc_005D9E4A: var_B0 = var_A0
  loc_005D9E5B: ecx = LCase(var_28)
  loc_005D9E8C: var_1FC = (var_40 = LCase(var_E0))
  loc_005D9ED6: If var_1FC <> 0 Then GoTo loc_005DA019
  loc_005D9EEE: Next var_38
  loc_005D9EF4: var_2F8 = Next var_38
  loc_005D9EFA: GoTo loc_005D9D24
  loc_005D9F3B: var_198 = var_18
  loc_005D9F4B: var_90 = LCase(var_18)
  loc_005D9FBB: var_6C = CStr(var_B0)
  loc_005D9FC9: var_eax = List1.AddItem var_6C, var_B0
  loc_005DA019: 'Referenced from: 005D7FCE
  loc_005DA022: GoTo loc_005DA0D2
  loc_005DA0D1: Exit Sub
  loc_005DA0D2: 'Referenced from: 005DA022
  loc_005DA16A: Exit Sub
End Sub