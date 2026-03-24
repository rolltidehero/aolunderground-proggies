ï»¿Private Sub Timer1_Timer() '5F5060
  Dim var_64 As Variant
  Dim var_78 As ListBox
  Dim var_13C As ListBox
  Dim var_144 As ListBox
  Dim var_4C As TextBox
  loc_005F5155: var_130 = Timer1.Interval
  loc_005F5180: setz dl
  loc_005F5199: If var_144 <> 0 Then GoTo loc_005F6437
  loc_005F51A3: var_eax = call Proc_79_37_607940(var_78, var_64, Me)
  loc_005F51C5: var_4C = Text1.Text
  loc_005F51EF: var_80 = var_4C
  loc_005F5210: var_144 = (var_78 = var_4C)
  loc_005F523A: If var_144 = 0 Then GoTo loc_005F6437
  loc_005F5244: var_eax = call Proc_79_52_60A380(var_78, var_64, call Proc_79_37_607940(var_78, var_64, Me))
  loc_005F526C: var_1C = LCase(var_78)
  loc_005F52B5: var_4C = Text1.Text
  loc_005F52E2: var_70 = var_68
  loc_005F5317: var_98 = Mid(var_68, Len(var_4C), 10)
  loc_005F536F: var_eax = call Proc_79_37_607940(var_78, var_68, Me)
  loc_005F538C: var_eax = call Proc_79_37_607940(var_98, Me, Me)
  loc_005F539F: var_A8 = LCase(var_98)
  loc_005F53C8: var_B0 = var_98 & var_0043134C
  loc_005F5408: call InStr(var_C8, ebx, var_B8, var_A8, 00000001h, var_E8, Me, Set %StkVar1 = %StkVar2 'Ignore this, Me, ebx)
  loc_005F5451: var_18 = Mid(LCase(var_68), CLng(InStr(var_C8, ebx, var_B8, var_A8, 00000001h, var_E8, Me, Set %StkVar1 = 2 + 2), )
  loc_005F54CC: var_13C = var_78
  loc_005F54D2: var_12C = List1.ListCount
  loc_005F5502: var_12C = var_12C - 0001h
  loc_005F551E: var_110 = var_12C
  loc_005F554C: For var_34 = "" To var_12C Step 1
  loc_005F5555: var_17C = var_168
  loc_005F5567: If var_17C = 0 Then GoTo loc_005F5E09
  loc_005F558D: var_34 = CInt(var_4C)
  loc_005F559D: var_64 = List1.List(var_34)
  loc_005F55EC: If InStr(1, var_4C, var_1C, 0) <> 0 Then GoTo loc_005F5613
  loc_005F5600: Next var_34
  loc_005F5606: var_17C = Next var_34
  loc_005F560E: GoTo loc_005F5561
  loc_005F5613: 'Referenced from: 005F55EC
  loc_005F5625: var_13C = Next var_34
  loc_005F5643: var_64 = List1.List(CInt(var_4C))
  loc_005F5691: var_68 = List1.List(CInt(var_50))
  loc_005F56B8: var_70 = var_4C
  loc_005F56EE: InStr(1, var_50, "- ", 0) = InStr(1, var_50, "- ", 0) + 00000002h
  loc_005F571B: var_24 = Mid(0, InStr(1, var_50, "- ", 0), var_88)
  loc_005F5770: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005F57B8: call __vbaStrR8
  loc_005F57C3: var_24 = __vbaStrR8
  loc_005F57F7: var_34 = CInt(var_64)
  loc_005F57FD: var_190 = var_34
  loc_005F5811: var_eax = List1.RemoveItem var_34
  loc_005F5896: var_4C = var_1C & " - "
  loc_005F58AC: var_50 = var_4C & var_24
  loc_005F58BC: var_eax = List1.AddItem var_50, var_FC
  loc_005F5910: var_13C = var_4C
  loc_005F5916: Text1.Text = vbNullString
  loc_005F595D: Text2.Text = vbNullString
  loc_005F599E: var_13C = var_64
  loc_005F59A4: Text3.Text = vbNullString
  loc_005F59EB: Text4.Text = vbNullString
  loc_005F5A2C: var_13C = var_64
  loc_005F5A32: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F5A70: Text1.Enabled = True
  loc_005F5AAE: var_13C = var_64
  loc_005F5AB4: Text2.Enabled = True
  loc_005F5AF8: Text3.Enabled = True
  loc_005F5B36: var_13C = var_64
  loc_005F5B3C: Text4.Enabled = True
  loc_005F5B83: Command1.Caption = "Start"
  loc_005F5BC1: Timer1.Interval = 0
  loc_005F5BFD: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005F5C5C: var_54 = var_0042EC60 & var_1C & "â¢ correct â¢ "
  loc_005F5C6D: call __vbaStrR8(var_138, var_134, var_54, Me, var_50, var_64, Me, Me, var_64, Me, Me, var_64, Me, Me, var_64)
  loc_005F5C78: var_58 = __vbaStrR8(var_138, var_134, var_54, Me, var_50, var_64, Me, Me, var_64, Me, Me, var_64, Me, Me, var_64)
  loc_005F5C99: var_60 =  & var_58 & " sec'sâ¢"
  loc_005F5CC7: var_eax = call Proc_3_4_5A51B0(var_88, var_44, 3)
  loc_005F5D36: var_4C = "<font face=""tahoma"">" & var_88
  loc_005F5D4F: var_eax = call Proc_79_17_604A50(var_4C & vbNullString, , )
  loc_005F5D73: var_130 = CLng(0.75)
  loc_005F5D80: var_eax = call Proc_6098C0(var_130, , )
  loc_005F5D9C: Timer2.Interval = 0
  loc_005F5DD8: var_eax = call Proc_6098C0(CLng(0.75), var_64, call Proc_6098C0(CLng(0.75), , ))
  loc_005F5DF7: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F5DFE: If Unknown_VTable_Call[ecx+00000054h] >= 0 Then GoTo loc_005F6430
  loc_005F5E04: GoTo loc_005F6421
  loc_005F5E09: 'Referenced from: 005F5567
  loc_005F5E1C: var_144 = var_68
  loc_005F5E50: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005F5EB2: var_50 = var_1C & " - "
  loc_005F5EC8: var_54 = var_50 & var_4C
  loc_005F5ED8: var_eax = Unknown_VTable_Call[edx+000001ECh]
  loc_005F5F37: Text1.Text = vbNullString
  loc_005F5F7E: Text2.Text = vbNullString
  loc_005F5FC5: Text3.Text = vbNullString
  loc_005F600C: Text4.Text = vbNullString
  loc_005F6053: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005F6091: Text1.Enabled = True
  loc_005F60D5: Text2.Enabled = True
  loc_005F6119: Text3.Enabled = True
  loc_005F615D: Text4.Enabled = True
  loc_005F61A4: Command1.Caption = "Start"
  loc_005F61E2: Timer1.Interval = 0
  loc_005F621E: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005F627D: var_54 = var_0042EC60 & var_1C & "â¢ correct â¢ "
  loc_005F628E: call __vbaStrR8(var_138, var_134, var_54, var_64, var_50, var_64, var_64, var_64, var_64, var_64, var_64, var_64, var_64, var_64, var_64)
  loc_005F6299: var_58 = __vbaStrR8(var_138, var_134, var_54, var_64, var_50, var_64, var_64, var_64, var_64, var_64, var_64, var_64, var_64, var_64, var_64)
  loc_005F62BA: var_60 =  & var_58 & " sec'sâ¢"
  loc_005F62E8: var_eax = call Proc_3_4_5A51B0(var_88, var_44, 3)
  loc_005F6370: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_88 & vbNullString, , )
  loc_005F63A1: var_eax = call Proc_6098C0(CLng(0.75), , )
  loc_005F63BD: Timer2.Interval = 0
  loc_005F63EC: var_130 = CLng(0.75)
  loc_005F63F9: var_eax = call Proc_6098C0(var_130, var_64, var_64)
  loc_005F6418: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005F641F: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005F6430
  loc_005F6421: 'Referenced from: 005F5E04
  loc_005F642A: Unknown_VTable_Call[eax+00000054h] = CheckObj(call Proc_6098C0(var_130, var_64, var_64), var_0042DCB0, 84)
  loc_005F6430: 'Referenced from: 005F5DFE
  loc_005F6437: 'Referenced from: 005F5199
  loc_005F6440: GoTo loc_005F64BA
  loc_005F64B9: Exit Sub
  loc_005F64BA: 'Referenced from: 005F6440
  loc_005F6502: Exit Sub
End Sub