ï»¿Private Sub Timer1_Timer() '5CA490
  Dim var_94 As Variant
  Dim var_17C As ListBox
  loc_005CA5BB: var_170 = Timer1.Interval
  loc_005CA5E3: setz bl
  loc_005CA5F1: If ebx <> 0 Then GoTo loc_005CB5E4
  loc_005CA5FC: var_eax = call Proc_79_47_609590(var_0042DCAC, var_94, Me)
  loc_005CA635: var_D8 = LCase(Me & call Proc_79_47_609590(var_0042DCAC, var_94, Me))
  loc_005CA642: call Proc_79_37_607940(var_A8, Me, var_D8 = %S_edx_S)
  loc_005CA655: var_B8 = LCase(var_A8)
  loc_005CA663: var_74 = vbNullString
  loc_005CA689: var_6C = var_D8
  loc_005CA697: var_eax = call Proc_79_41_6084C0(var_6C, var_70, var_74)
  loc_005CA6AB: var_E0 = call Proc_79_41_6084C0(var_6C, var_70, var_74) & var_0043134C
  loc_005CA6D4: call InStr(var_F8, 00000000h, var_E8, var_B8, 00000001h, @%StkVar2 & %x1)
  loc_005CA6E1: var_17C = CBool(InStr(var_F8, 00000000h, var_E8, var_B8, 00000001h, @%StkVar2 & %x1))
  loc_005CA741: If var_17C = 0 Then GoTo loc_005CB5E2
  loc_005CA74E: var_eax = call Proc_79_52_60A380(var_A8, , )
  loc_005CA779: var_1C = LCase(var_A8)
  loc_005CA799: var_eax = call Proc_79_47_609590(var_0042DCAC, , )
  loc_005CA7A3: var_68 = call Proc_79_47_609590(var_0042DCAC, , )
  loc_005CA7A8: var_A0 =  & var_68
  loc_005CA7D4: var_74 = vbNullString
  loc_005CA7FA: var_6C = LCase( & var_68)
  loc_005CA808: var_eax = call Proc_79_41_6084C0(var_6C, var_70, var_74)
  loc_005CA81C: var_eax = call Proc_79_47_609590(var_0042DCAC, , )
  loc_005CA826: var_78 = call Proc_79_47_609590(var_0042DCAC, , )
  loc_005CA82B: var_C0 =  & var_78
  loc_005CA85A: var_84 = vbNullString
  loc_005CA880: var_7C = LCase( & var_78)
  loc_005CA891: var_eax = call Proc_79_41_6084C0(var_7C, var_80, var_84)
  loc_005CA8AE: var_E0 = call Proc_79_41_6084C0(var_6C, var_70, var_74)
  loc_005CA9A0: var_eax = call Proc_79_37_607940(8, , )
  loc_005CA9B3: var_B8 = LCase( & var_68)
  loc_005CA9C0: var_eax = call Proc_79_37_607940(8, , )
  loc_005CA9D3: var_D8 = LCase( & var_78)
  loc_005CA9F8: var_E0 = Mid(var_8C, Len(call Proc_79_41_6084C0(var_7C, var_80, var_84)), var_F8) & var_0043134C
  loc_005CAA39: call InStr(var_F8, 00000000h, var_E8, var_D8, 00000001h, var_118)
  loc_005CAA82: var_18 = Mid(var_B8, CLng(InStr(var_F8, 00000000h, var_E8, var_D8, 00000001h, var_118) + 2), )
  loc_005CAB03: var_17C = var_94
  loc_005CAB09: var_16C = List3.ListCount
  loc_005CAB39: var_16C = var_16C - 0001h
  loc_005CAB55: var_140 = var_16C
  loc_005CAB87: For var_2C = 0 To var_16C Step 1
  loc_005CAB93: var_1E0 = var_1AC
  loc_005CAB9F: 
  loc_005CABA7: If var_1E0 = 0 Then GoTo loc_005CAC60
  loc_005CABD4: var_2C = CInt(var_68)
  loc_005CABE4: var_94 = List3.List(var_2C)
  loc_005CAC19: ebx = (var_68 = var_1C) + 1
  loc_005CAC31: If (var_68 <> var_1C) + 1 <> 0 Then GoTo loc_005CB5E2
  loc_005CAC49: Next var_2C
  loc_005CAC55: var_1E0 = Next var_2C
  loc_005CAC5B: GoTo loc_005CAB9F
  loc_005CAC60: 'Referenced from: 005CABA7
  loc_005CAC91: var_17C = Next var_2C
  loc_005CACC1: var_eax = List2.AddItem var_1C, var_12C
  loc_005CAD16: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005CAD75: var_17C = var_94
  loc_005CAD7B: var_16C = List2.ListCount
  loc_005CADAB: var_16C = var_16C - 0001h
  loc_005CADC7: var_140 = var_16C
  loc_005CADF9: For var_3C = 0 To var_16C Step 1
  loc_005CAE05: var_1E4 = var_1CC
  loc_005CAE11: 
  loc_005CAE1C: If var_1E4 = 0 Then GoTo loc_005CAFD2
  loc_005CAE46: var_3C = CInt(var_68)
  loc_005CAE56: var_94 = List2.List(var_3C)
  loc_005CAE97: var_50 = var_68
  loc_005CAED0: If (var_50 = var_1C) = 0 Then GoTo loc_005CAFA9
  loc_005CAEF2: var_184 = var_98
  loc_005CAF11: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005CAF51: call __vbaStrR8
  loc_005CAF5C: var_6C = __vbaStrR8
  loc_005CAF68: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005CAFA9: 'Referenced from: 005CAED0
  loc_005CAFBB: Next var_3C
  loc_005CAFC7: var_1E4 = Next var_3C
  loc_005CAFCD: GoTo loc_005CAE11
  loc_005CAFF3: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005CB045: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005CB07F: fcomp real8 ptr var_1FC
  loc_005CB091: GoTo loc_005CB095
  loc_005CB095: 'Referenced from: 005CB091
  loc_005CB0CE: If var_18C = 0 Then GoTo loc_005CB234
  loc_005CB0FD: var_6C = var_0042EC60 & var_1C & "â¢ you reached the message limitâ¢"
  loc_005CB134: var_eax = call Proc_3_4_5A51B0(var_B8, var_60, 3)
  loc_005CB19B: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_B8 & vbNullString, "<font face=""tahoma"">" & var_B8 & vbNullString, var_98)
  loc_005CB205: var_eax = List3.AddItem var_1C, var_12C
  loc_005CB22F: GoTo loc_005CB5E2
  loc_005CB234: 'Referenced from: 005CB0CE
  loc_005CB26C: var_130 = vbNullString
  loc_005CB296: var_68 = " - " & var_1C
  loc_005CB2A6: var_D0 = var_68 & " """
  loc_005CB2C2: var_140 = var_18
  loc_005CB32D: var_B8 = vbNullString & Time
  loc_005CB377: var_6C = CStr(var_B8 & var_68 & " """ + LCase(var_18) + &H433C98)
  loc_005CB387: var_eax = List1.AddItem var_6C, var_15C
  loc_005CB420: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005CB458: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005CB4DC: var_84 = var_0042EC60 & var_1C & "â¢ message logged " & var_6C & var_00431C88 & var_78 & var_0042EC60
  loc_005CB516: var_eax = call Proc_3_4_5A51B0(var_B8, var_60, 3)
  loc_005CB5B0: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_B8 & vbNullString, , )
  loc_005CB5DD: var_eax = call Proc_6098C0(CLng(0.75), , )
  loc_005CB5E2: 'Referenced from: 005CA741
  loc_005CB5E4: 'Referenced from: 005CA5F1
  loc_005CB5ED: GoTo loc_005CB693
  loc_005CB692: Exit Sub
  loc_005CB693: 'Referenced from: 005CB5ED
  loc_005CB6EE: Exit Sub
End Sub