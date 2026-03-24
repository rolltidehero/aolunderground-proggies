ï»¿Private Sub Timer1_Timer() '5F93F0
  Dim var_160 As ListBox
  Dim var_15C As ListBox
  loc_005F94EC: var_eax = call Proc_79_38_607B50(edi, esi, Me)
  loc_005F94F1: var_CC = call Proc_79_38_607B50(edi, esi, Me)
  loc_005F9530: var_B8 = LCase(call Proc_79_38_607B50(edi, esi, Me))
  loc_005F9560: InStr(1, var_B8, var_00431C88, 0) = InStr(1, var_B8, var_00431C88, 0) - 00000001h
  loc_005F9569: var_CC = InStr(1, var_B8, var_00431C88, 0)
  loc_005F957B: var_11C = var_B8
  loc_005F95BE: var_1C = Mid(var_B8, 1, InStr(1, var_B8, var_00431C88, 0))
  loc_005F9609: var_11C = var_B8
  loc_005F961F: InStr(1, var_B8, var_00431C88, 0) = InStr(1, var_B8, var_00431C88, 0) + 00000003h
  loc_005F964F: var_18 = Mid(var_B8, InStr(1, var_B8, var_00431C88, 0), 10)
  loc_005F967B: var_11C = var_18
  loc_005F968B: var_D4 = LCase(var_18)
  loc_005F96BF: var_160 = (var_D4 = "yes")
  loc_005F96D3: If var_160 = 0 Then GoTo loc_005F9D55
  loc_005F9714: var_158 = List1.ListCount
  loc_005F9744: var_158 = var_158 - 0001h
  loc_005F9760: var_12C = var_158
  loc_005F978E: For var_30 = "" To var_158 Step 1
  loc_005F979A: var_1F0 = var_184
  loc_005F97AC: If var_1F0 = 0 Then GoTo loc_005F98DC
  loc_005F97CB: var_160 = eax
  loc_005F97DC: var_30 = CInt(var_BC)
  loc_005F97EC: var_C4 = List1.List(var_30)
  loc_005F9858: var_D4 = LCase(var_BC)
  loc_005F986B: var_11C = var_1C
  loc_005F987B: var_E4 = LCase(var_1C)
  loc_005F98B0: If (var_D4 <> var_E4) <> 0 Then GoTo loc_005FA357
  loc_005F98C8: Next var_30
  loc_005F98D1: var_1F0 = Next var_30
  loc_005F98D7: GoTo loc_005F97A6
  loc_005F98DC: 'Referenced from: 005F97AC
  loc_005F9917: var_158 = List2.ListCount
  loc_005F9948: var_158 = var_158 - 0001h
  loc_005F9958: var_12C = var_158
  loc_005F9991: For var_50 = "" To var_158 Step 1
  loc_005F999D: var_1F8 = var_50
  loc_005F99A9: 
  loc_005F99B4: If var_1F8 = 0 Then GoTo loc_005F9ADB
  loc_005F99E1: var_50 = CInt(var_BC)
  loc_005F99F1: var_C4 = List2.List(var_50)
  loc_005F9A57: var_D4 = LCase(var_BC)
  loc_005F9A6A: var_11C = var_1C
  loc_005F9A7A: var_E4 = LCase(var_1C)
  loc_005F9AAF: If (var_D4 <> var_E4) <> 0 Then GoTo loc_005F9FBD
  loc_005F9AC7: Next var_50
  loc_005F9AD0: var_1F8 = Next var_50
  loc_005F9AD6: GoTo loc_005F99A9
  loc_005F9B1C: var_11C = var_1C
  loc_005F9B6A: var_BC = CStr(LCase(var_1C))
  loc_005F9B7A: var_eax = List1.AddItem var_BC, var_128
  loc_005F9BCD: var_11C = var_1C
  loc_005F9C1F: var_13C = "â¢ vote addedâ¢"
  loc_005F9C4D: var_BC = &H42EC60 & LCase(var_1C) & "â¢ vote addedâ¢"
  loc_005F9C8D: var_eax = call Proc_3_4_5A51B0(var_114, var_B0, 3)
  loc_005F9CFB: var_BC = "<font face=""tahoma"">" & var_114
  loc_005F9D16: var_eax = call Proc_79_17_604A50(var_BC & vbNullString, var_B0, var_BC)
  loc_005F9D4D: var_eax = call Proc_6098C0(CLng(0.55), , var_C4)
  loc_005F9D55: 'Referenced from: 005F96D3
  loc_005F9D66: var_11C = var_18
  loc_005F9DAA: var_160 = (LCase(var_18) = "no")
  loc_005F9DBE: If var_160 = 0 Then GoTo loc_005FA61F
  loc_005F9DFF: var_158 = List1.ListCount
  loc_005F9E30: var_158 = var_158 - 0001h
  loc_005F9E40: var_12C = var_158
  loc_005F9E79: For var_70 = "" To var_158 Step 1
  loc_005F9E85: var_200 = var_70
  loc_005F9E97: If var_200 = 0 Then GoTo loc_005FA153
  loc_005F9EC7: var_70 = CInt(var_BC)
  loc_005F9ED7: var_C4 = List1.List(var_70)
  loc_005F9F3D: var_D4 = LCase(var_BC)
  loc_005F9F50: var_11C = var_1C
  loc_005F9F60: var_E4 = LCase(var_1C)
  loc_005F9F95: If (var_D4 <> var_E4) <> 0 Then GoTo loc_005F9FBD
  loc_005F9FA9: Next var_70
  loc_005F9FB2: var_200 = Next var_70
  loc_005F9FB8: GoTo loc_005F9E91
  loc_005F9FBD: 'Referenced from: 005F9AAF
  loc_005F9FCE: var_11C = var_1C
  loc_005FA020: var_13C = "â¢ already votedâ¢"
  loc_005FA04E: var_BC = &H42EC60 & LCase(var_1C) & "â¢ already votedâ¢"
  loc_005FA08E: var_eax = call Proc_3_4_5A51B0(var_114, var_B0, 3)
  loc_005FA0FC: var_BC = "<font face=""tahoma"">" & var_114
  loc_005FA117: var_eax = call Proc_79_17_604A50(var_BC & vbNullString, var_B0, var_BC)
  loc_005FA141: var_15C = CLng(0.55)
  loc_005FA14E: GoTo loc_005FA61A
  loc_005FA153: 'Referenced from: 005F9E97
  loc_005FA18E: var_158 = List2.ListCount
  loc_005FA1BE: var_158 = var_158 - 0001h
  loc_005FA1DA: var_12C = var_158
  loc_005FA20B: For var_90 = "" To var_158 Step 1
  loc_005FA217: var_208 = var_1E4
  loc_005FA223: 
  loc_005FA22E: If ebx = 0 Then GoTo loc_005FA3A8
  loc_005FA25E: var_90 = CInt(var_BC)
  loc_005FA26E: var_C4 = List2.List(var_90)
  loc_005FA2D4: var_D4 = LCase(var_BC)
  loc_005FA2E7: var_11C = var_1C
  loc_005FA2F7: var_E4 = LCase(var_1C)
  loc_005FA32C: If (var_D4 <> var_E4) <> 0 Then GoTo loc_005FA357
  loc_005FA343: Next var_90
  loc_005FA34C: var_208 = Next var_90
  loc_005FA352: GoTo loc_005FA223
  loc_005FA357: 'Referenced from: 005F98B0
  loc_005FA368: var_11C = var_1C
  loc_005FA378: var_D4 = LCase(var_1C)
  loc_005FA399: var_13C = "â¢ already votedâ¢"
  loc_005FA3A3: GoTo loc_005FA4D5
  loc_005FA3E9: var_11C = var_1C
  loc_005FA437: var_BC = CStr(LCase(var_1C))
  loc_005FA447: var_eax = List2.AddItem var_BC, var_128
  loc_005FA49A: var_11C = var_1C
  loc_005FA4AA: var_D4 = LCase(var_1C)
  loc_005FA4CB: var_13C = "â¢ vote addedâ¢"
  loc_005FA4D5: 'Referenced from: 005FA3A3
  loc_005FA51A: var_BC = &H42EC60 & var_D4 & "â¢ vote addedâ¢"
  loc_005FA55A: var_eax = call Proc_3_4_5A51B0(var_114, var_B0, 3)
  loc_005FA5C8: var_BC = "<font face=""tahoma"">" & var_114
  loc_005FA5E3: var_eax = call Proc_79_17_604A50(var_BC & vbNullString, var_B0, var_BC)
  loc_005FA613: var_15C = CLng(0.55)
  loc_005FA61A: 'Referenced from: 005FA14E
  loc_005FA61A: var_eax = call Proc_6098C0(var_15C, , var_C4)
  loc_005FA61F: 'Referenced from: 005F9DBE
  loc_005FA628: GoTo loc_005FA67E
  loc_005FA67D: Exit Sub
  loc_005FA67E: 'Referenced from: 005FA628
  loc_005FA722: Exit Sub
End Sub