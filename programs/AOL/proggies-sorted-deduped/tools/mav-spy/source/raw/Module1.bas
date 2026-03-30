
Public Sub Proc_3_0_414910
  Dim var_14 As Screen
  loc_00414950: var_1C = ebx.Width
  loc_004149A0: var_14 = Global.Screen
  loc_004149C0: var_18 = Global.Width
  loc_004149EA: If var_424000 <> 0 Then GoTo loc_004149F4
  loc_004149F2: GoTo loc_004149FF
  loc_004149F4: 'Referenced from: 004149EA
  loc_004149FA: call _adj_fdiv_m32(var_4015F0, ebx, %StkVar1 = CheckObj(%StkVar2, %StkVar3, %StkVar4), var_14, ebx)
  loc_004149FF: 'Referenced from: 004149F2
  loc_00414A0D: var_eax = Unknown_VTable_Call[ecx+00000074h]
  loc_00414A36: var_1C = Global.TwipsPerPixelY
  loc_00414A78: var_14 = Global.Screen
  loc_00414A98: var_18 = Global.Height
  loc_00414ABC: If var_424000 <> 0 Then GoTo loc_00414AC6
  loc_00414AC4: GoTo loc_00414AD1
  loc_00414AC6: 'Referenced from: 00414ABC
  loc_00414ACC: call _adj_fdiv_m32(var_4015F0, ebx, Me)
  loc_00414AD1: 'Referenced from: 00414AC4
  loc_00414ADB: var_eax = Global.MousePointer =
  loc_00414AFE: GoTo loc_00414B0A
  loc_00414B09: Exit Sub
  loc_00414B0A: 'Referenced from: 00414AFE
  loc_00414B0A: Exit Sub
End Sub

Public Sub Proc_3_1_414B30
  loc_00414B67: var_eax = ReleaseCapture(edi, esi)
  loc_00414B80: var_34 = eax.hWnd
  loc_00414BAA: var_eax = SendMessage(var_34, 161, 2, var_38)
  loc_00414BC3: var_20 = SendMessage(var_34, 161, 2, var_38)
End Sub

Public Sub Proc_3_2_414BF0
  loc_00414C2D: var_eax = GetWindowTextLength(Me)
  loc_00414C3C: var_ret_1 = GetWindowTextLength(Me)
  loc_00414C61: var_24 = String$(si, "")
  loc_00414C90: var_eax = GetWindowText(Me, var_24, var_ret_1 + 0001h)
  loc_00414CA3: var_ret_3 = var_28
  loc_00414CB8: var_20 = var_24
  loc_00414CC3: GoTo loc_00414CE7
  loc_00414CC9: If var_4 = 0 Then GoTo loc_00414CD4
  loc_00414CD4: 'Referenced from: 00414CC9
  loc_00414CE6: Exit Sub
  loc_00414CE7: 'Referenced from: 00414CC3
  loc_00414CF0: Exit Sub
End Sub

Public Sub Proc_3_3_414DC0
  loc_00414E10: var_20 = Space$(255)
  loc_00414E2C: var_eax = GetClassName(Me, var_20, 255)
  loc_00414E3F: var_ret_2 = var_24
  loc_00414E59: var_3C = var_20
  loc_00414E78: var_18 = Trim(var_20)
  loc_00414E88: GoTo loc_00414EAC
  loc_00414E8E: If var_4 = 0 Then GoTo loc_00414E99
  loc_00414E99: 'Referenced from: 00414E8E
  loc_00414EAB: Exit Sub
  loc_00414EAC: 'Referenced from: 00414E88
End Sub

Public Sub Proc_3_4_414ED0
  loc_00414F31: var_40 = LCase(Me)
  loc_00414F3E: var_78 = arg_C
  loc_00414F48: var_50 = LCase(arg_C)
  loc_00414F59: call InStr(var_60, edi, var_50, var_40, 00000001h, 0, Me, %x1 = LCase(%StkVar2))
  loc_00414F60: var_ret_1 = CLng(InStr(var_60, edi, var_50, var_40, 00000001h, 0, Me, %x1 = LCase(%StkVar2)))
  loc_00414F81: 
  loc_00414F83: If var_ret_1 <= 0 Then GoTo loc_004150BC
  loc_00414F8E: var_ret_1 = var_ret_1 - 00000001h
  loc_00414FBC: var_28 = Left(Me, var_ret_1)
  loc_00414FDB: Len(arg_C) = Len(arg_C) + var_ret_1
  loc_00414FE4: var_8C = Len(arg_C)
  loc_00414FF8: If var_8C > 0 Then GoTo loc_0041506F
  loc_00415014: Len(Me) = Len(Me) - var_ret_1
  loc_0041501F: var_90 = Len(Me)
  loc_00415030: var_90 = var_90 - Len(arg_C)
  loc_00415062: var_1C = Right(Me, var_90 + 00000001h + 00000001h)
  loc_0041506D: GoTo loc_00415083
  loc_0041506F: 'Referenced from: 00414FF8
  loc_00415077: var_1C = vbNullString
  loc_00415083: 'Referenced from: 0041506D
  loc_004150AA: var_18 = var_28 & arg_10 & var_1C
  loc_004150BA: GoTo loc_004150C1
  loc_004150BC: 'Referenced from: 00414F83
  loc_004150C1: 'Referenced from: 004150BA
  loc_004150C1: var_18 = esi
  loc_004150D5: Len(arg_10) = Len(arg_10) + var_ret_1
  loc_004150DF: If Len(arg_10) <= 0 Then GoTo loc_00415147
  loc_004150F9: var_40 = LCase(Me)
  loc_00415106: var_78 = arg_C
  loc_00415110: var_50 = LCase(arg_C)
  loc_00415121: call InStr(var_60, 00000000h, var_50, var_40, Len(arg_10))
  loc_00415128: var_ret_2 = CLng(InStr(var_60, 00000000h, var_50, var_40, Len(arg_10)))
  loc_00415147: 'Referenced from: 004150DF
  loc_0041514A: If var_ret_2 >= 1 Then GoTo loc_00414F81
  loc_00415156: var_2C = var_18
  loc_00415161: GoTo loc_00415193
  loc_00415167: If var_4 = 0 Then GoTo loc_00415172
  loc_00415172: 'Referenced from: 00415167
  loc_00415192: Exit Sub
  loc_00415193: 'Referenced from: 00415161
  loc_004151A8: Exit Sub
End Sub

Public Sub Proc_3_5_415230
  loc_004152BA: var_5C = arg_C."List1"
  loc_004152C9: var_5C = Me.arg_C
  loc_00415316: var_5C = arg_C."List1"
  loc_0041531F: var_5C = Me.
  loc_00415369: var_5C = arg_C."List1"
  loc_00415372: var_5C = Me.
  loc_0041538C: 
  loc_00415391: If var_14 = 0 Then GoTo loc_004157B7
  loc_0041539B: var_eax = call Proc_3_2_414BF0(var_14, , )
  loc_004153B0: var_3C = call Proc_3_2_414BF0(var_14, , )
  loc_004153D5: If (var_3C = vbNullString) = 0 Then GoTo loc_004153F1
  loc_004153EB: var_3C = "vbNullString"
  loc_004153F1: 'Referenced from: 004153D5
  loc_00415454: var_5C = arg_C."List1"
  loc_0041545D: var_5C = Me.
  loc_004154D2: var_5C = arg_C."List1"
  loc_004154DB: var_5C = Me.
  loc_004154F1: var_eax = call Proc_3_3_414DC0(var_14, , )
  loc_0041551A: var_44 = call Proc_3_3_414DC0(var_14, , )
  loc_00415553: var_6C = arg_C."List1"
  loc_0041555C: var_6C = Me.
  loc_0041557D: If var_18 = 0 Then GoTo loc_004157B7
  loc_00415586: var_18 = var_14
  loc_00415589: var_eax = GetWindowPlacement(var_14, 2)
  loc_004155A0: var_1C = GetWindowPlacement(var_14, 2)
  loc_004155A3: 
  loc_004155AB: If var_A0 = 0 Then GoTo loc_0041538C
  loc_004155B5: var_eax = call Proc_3_2_414BF0(var_1C, , )
  loc_004155CA: var_2C = call Proc_3_2_414BF0(var_1C, , )
  loc_004155EF: If (var_2C = vbNullString) = 0 Then GoTo loc_0041560B
  loc_00415605: var_2C = "vbNullString"
  loc_0041560B: 'Referenced from: 004155EF
  loc_0041566E: var_5C = arg_C."List1"
  loc_00415677: var_5C = Me.
  loc_004156EC: var_5C = arg_C."List1"
  loc_004156F5: var_5C = Me.
  loc_0041570B: var_eax = call Proc_3_3_414DC0(var_1C, , )
  loc_00415734: var_44 = call Proc_3_3_414DC0(var_1C, , )
  loc_0041576D: var_6C = arg_C."List1"
  loc_00415776: var_6C = Me.
  loc_00415795: var_eax = GetWindowPlacement(var_1C, 2)
  loc_0041579A: var_A0 = GetWindowPlacement(var_1C, 2)
  loc_004157AE: var_1C = var_A0
  loc_004157B1: If var_A0 <> 0 Then GoTo loc_004155A3
  loc_004157B7: 'Referenced from: 00415391
  loc_004157BC: GoTo loc_004157D6
  loc_004157D5: Exit Sub
  loc_004157D6: 'Referenced from: 004157BC
End Sub

Public Sub Proc_3_6_415800
  loc_0041587E: var_44 = arg_C."List1"
  loc_0041588D: var_44 = Me.arg_C
  loc_004158DA: var_44 = arg_C."List1"
  loc_004158E3: var_44 = Me.
  loc_0041592D: var_44 = arg_C."List1"
  loc_00415936: var_44 = Me.
  loc_00415954: var_eax = FindWindowEx(Me, 0, 0, 0)
  loc_0041596F: var_14 = FindWindowEx(Me, 0, 0, 0)
  loc_00415972: var_eax = call Proc_3_2_414BF0(var_14, , )
  loc_00415987: var_24 = call Proc_3_2_414BF0(var_14, , )
  loc_004159AC: If (var_24 = vbNullString) = 0 Then GoTo loc_004159C8
  loc_004159C2: var_24 = "vbNullString"
  loc_004159C8: 'Referenced from: 004159AC
  loc_004159CD: If var_14 = 0 Then GoTo loc_00415BBD
  loc_004159D3: 
  loc_00415A30: var_44 = arg_C."List1"
  loc_00415A39: var_44 = Me.
  loc_00415AA8: var_44 = arg_C."List1"
  loc_00415AB1: var_44 = Me.
  loc_00415AC7: var_eax = call Proc_3_3_414DC0(var_14, , )
  loc_00415AF0: var_2C = call Proc_3_3_414DC0(var_14, , )
  loc_00415B29: var_54 = arg_C."List1"
  loc_00415B32: var_54 = Me.
  loc_00415B50: If var_14 = 0 Then GoTo loc_00415BBD
  loc_00415B5D: var_eax = FindWindowEx(Me, var_14, 0, 0)
  loc_00415B62: var_88 = FindWindowEx(Me, var_14, 0, 0)
  loc_00415B96: If (var_24 = vbNullString) = 0 Then GoTo loc_00415BB2
  loc_00415BAC: var_24 = "vbNullString"
  loc_00415BB2: 'Referenced from: 00415B96
  loc_00415BB7: If var_14 <> 0 Then GoTo loc_004159D3
  loc_00415BBD: 'Referenced from: 004159CD
  loc_00415BC2: GoTo loc_00415BDC
  loc_00415BDB: Exit Sub
  loc_00415BDC: 'Referenced from: 00415BC2
End Sub

Public Sub Proc_3_7_415CF0
  loc_00415D30: var_eax = GetWindowTextLength(Me)
  loc_00415D65: var_18 = String(GetWindowTextLength(Me), "")
  loc_00415D81: GetWindowTextLength(Me) = GetWindowTextLength(Me) + 00000001h
  loc_00415D9A: var_eax = GetWindowText(Me, var_18, GetWindowTextLength(Me))
  loc_00415DAD: var_ret_2 = var_24
  loc_00415DC2: var_20 = var_18
  loc_00415DCD: GoTo loc_00415DFB
  loc_00415DD3: If var_4 = 0 Then GoTo loc_00415DDE
  loc_00415DDE: 'Referenced from: 00415DD3
  loc_00415DFA: Exit Sub
  loc_00415DFB: 'Referenced from: 00415DCD
  loc_00415E04: Exit Sub
End Sub

Public Sub Proc_3_8_415E30
  Dim var_004240D0 As Variant
  Dim var_EC As Variant
  Dim var_2C4 As Variant
  loc_00415F65: On Error Resume Next
  loc_00415F78: If CBool(var_64) = 0 Then GoTo loc_00415FA2
  loc_00415F84: var_ret_1 = CLng(var_54)
  loc_00415F8E: var_ret_2 = CLng(var_98)
  loc_00415F91: var_eax = SetSystemCursor(var_ret_2, var_ret_1)
  loc_00415F96: var_218 = SetSystemCursor(var_ret_2, var_ret_1)
  loc_00415FA2: 'Referenced from: 00415F78
  loc_00415FC8: If eax <> 0 Then GoTo loc_00415FF5
  loc_00415FCA: call Proc_414D10(1, edi, var_ret_3 = CLng(%StkVar1))
  loc_00415FD1: var_eax = call Proc_414D40(ebx, , )
  loc_00415FD6: var_21C = call Proc_414D40(ebx, , )
  loc_00415FDC: var_218 = var_ret_3
  loc_00415FF0: var_eax = call Proc_414D70(var_218, var_21C, )
  loc_00415FF5: 'Referenced from: 00415FC8
  loc_00415FF5: var_84 = call Proc_414D70(var_218, var_21C, )
  loc_0041600A: var_eax = call Proc_3_3_414DC0(var_84, , )
  loc_0041602D: ecx = call Proc_3_3_414DC0(var_84, , )
  loc_00416048: ecx = eax
  loc_00416055: var_C0 = vbNullString
  loc_00416078: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_0041608F: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004160BC: var_C0 = vbNullString
  loc_004160DF: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004160F6: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416146: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_0041615D: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004161AD: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004161C4: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416214: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_0041622B: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_0041627B: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416292: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004162E2: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004162F9: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416349: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416360: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004163B3: var_BC = Chr(34)
  loc_004163CA: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004163E1: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_0041643E: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416455: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004164A6: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004164BD: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_0041650E: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416525: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_00416576: var_eax = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_0041658D: ecx = call Proc_3_4_414ED0(var_0042406C, var_BC, var_C0)
  loc_004165F4: var_214 = Options.Option19.Value
  loc_00416622: setz dl
  loc_00416642: If var_22C = 0 Then GoTo loc_00416672
  loc_0041666C: If (var_80 <> True) <> 0 Then GoTo loc_004216A0
  loc_00416672: 'Referenced from: 00416642
  loc_0041667A: If var_84 = 0 Then GoTo loc_00416E70
  loc_00416680: edi = edi + 00000001h
  loc_0041668B: edi+00000001h = edi+00000001h - 00000001h
  loc_00416694: var_224 = edi+00000001h
  loc_0041669F: If edi+00000001h < 1001 Then GoTo loc_004166A7
  loc_004166A1: var_eax = Err.Raise
  loc_004166A7: 'Referenced from: 0041669F
  loc_004166B7: var_eax = GetParent(edx+eax*4)
  loc_004166CE: var_84 = GetParent(edx+eax*4)
  loc_004166DA: If edi+00000001h < 1001 Then GoTo loc_004166E2
  loc_004166DC: var_eax = Err.Raise
  loc_004166E2: 'Referenced from: 004166DA
  loc_004166F6: If edi+00000001h < 1001 Then GoTo loc_004166FE
  loc_004166F8: var_eax = Err.Raise
  loc_004166FE: 'Referenced from: 004166F6
  loc_00416705: var_eax = call Proc_3_3_414DC0(var_84, var_EC, var_004240D0)
  loc_0041671E: ecx = call Proc_3_3_414DC0(var_84, var_EC, var_004240D0)
  loc_00416732: If edi+00000001h < 1001 Then GoTo loc_00416748
  loc_00416734: var_eax = Err.Raise
  loc_00416740: If edi+00000001h < 1001 Then GoTo loc_00416748
  loc_00416742: var_eax = Err.Raise
  loc_00416748: 'Referenced from: 00416732
  loc_00416759: ecx = ecx+edi*4
  loc_00416766: var_C0 = vbNullString
  loc_0041677B: If edi+00000001h < 1001 Then GoTo loc_00416791
  loc_0041677D: var_eax = Err.Raise
  loc_00416789: If edi+00000001h < 1001 Then GoTo loc_00416791
  loc_0041678B: var_eax = Err.Raise
  loc_00416791: 'Referenced from: 0041677B
  loc_004167A8: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_004167C1: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_004167EE: var_C0 = vbNullString
  loc_00416803: If edi+00000001h < 1001 Then GoTo loc_00416819
  loc_00416805: var_eax = Err.Raise
  loc_00416811: If edi+00000001h < 1001 Then GoTo loc_00416819
  loc_00416813: var_eax = Err.Raise
  loc_00416819: 'Referenced from: 00416803
  loc_00416830: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416849: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_0041688B: If edi+00000001h < 1001 Then GoTo loc_004168A1
  loc_0041688D: var_eax = Err.Raise
  loc_00416899: If edi+00000001h < 1001 Then GoTo loc_004168A1
  loc_0041689B: var_eax = Err.Raise
  loc_004168A1: 'Referenced from: 0041688B
  loc_004168B8: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_004168D1: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416913: If edi+00000001h < 1001 Then GoTo loc_00416929
  loc_00416915: var_eax = Err.Raise
  loc_00416921: If edi+00000001h < 1001 Then GoTo loc_00416929
  loc_00416923: var_eax = Err.Raise
  loc_00416929: 'Referenced from: 00416913
  loc_00416940: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416959: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_0041699B: If edi+00000001h < 1001 Then GoTo loc_004169B1
  loc_0041699D: var_eax = Err.Raise
  loc_004169A9: If edi+00000001h < 1001 Then GoTo loc_004169B1
  loc_004169AB: var_eax = Err.Raise
  loc_004169B1: 'Referenced from: 0041699B
  loc_004169C8: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_004169E1: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416A23: If edi+00000001h < 1001 Then GoTo loc_00416A39
  loc_00416A25: var_eax = Err.Raise
  loc_00416A31: If edi+00000001h < 1001 Then GoTo loc_00416A39
  loc_00416A33: var_eax = Err.Raise
  loc_00416A39: 'Referenced from: 00416A23
  loc_00416A50: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416A69: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416AAB: If edi+00000001h < 1001 Then GoTo loc_00416AC1
  loc_00416AAD: var_eax = Err.Raise
  loc_00416AB9: If edi+00000001h < 1001 Then GoTo loc_00416AC1
  loc_00416ABB: var_eax = Err.Raise
  loc_00416AC1: 'Referenced from: 00416AAB
  loc_00416AD8: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416AF1: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416B33: If edi+00000001h < 1001 Then GoTo loc_00416B49
  loc_00416B35: var_eax = Err.Raise
  loc_00416B41: If edi+00000001h < 1001 Then GoTo loc_00416B49
  loc_00416B43: var_eax = Err.Raise
  loc_00416B49: 'Referenced from: 00416B33
  loc_00416B60: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416B79: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416BCC: var_BC = Chr(34)
  loc_00416BD4: If edi+00000001h < 1001 Then GoTo loc_00416BEA
  loc_00416BD6: var_eax = Err.Raise
  loc_00416BE2: If edi+00000001h < 1001 Then GoTo loc_00416BEA
  loc_00416BE4: var_eax = Err.Raise
  loc_00416BEA: 'Referenced from: 00416BD4
  loc_00416C02: var_eax = call Proc_3_4_414ED0(edx+edi*4, var_BC, var_C0)
  loc_00416C1C: ecx = call Proc_3_4_414ED0(edx+edi*4, var_BC, var_C0)
  loc_00416C6A: If edi+00000001h < 1001 Then GoTo loc_00416C80
  loc_00416C6C: var_eax = Err.Raise
  loc_00416C78: If edi+00000001h < 1001 Then GoTo loc_00416C80
  loc_00416C7A: var_eax = Err.Raise
  loc_00416C80: 'Referenced from: 00416C6A
  loc_00416C98: var_eax = call Proc_3_4_414ED0(ecx+edi*4, var_BC, var_C0)
  loc_00416CB1: ecx = call Proc_3_4_414ED0(ecx+edi*4, var_BC, var_C0)
  loc_00416CF3: If edi+00000001h < 1001 Then GoTo loc_00416D09
  loc_00416CF5: var_eax = Err.Raise
  loc_00416D01: If edi+00000001h < 1001 Then GoTo loc_00416D09
  loc_00416D03: var_eax = Err.Raise
  loc_00416D09: 'Referenced from: 00416CF3
  loc_00416D20: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416D39: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416D7B: If edi+00000001h < 1001 Then GoTo loc_00416D91
  loc_00416D7D: var_eax = Err.Raise
  loc_00416D89: If edi+00000001h < 1001 Then GoTo loc_00416D91
  loc_00416D8B: var_eax = Err.Raise
  loc_00416D91: 'Referenced from: 00416D7B
  loc_00416DA8: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416DC1: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416E03: If edi+00000001h < 1001 Then GoTo loc_00416E19
  loc_00416E05: var_eax = Err.Raise
  loc_00416E11: If edi+00000001h < 1001 Then GoTo loc_00416E19
  loc_00416E13: var_eax = Err.Raise
  loc_00416E19: 'Referenced from: 00416E03
  loc_00416E30: var_eax = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416E49: ecx = call Proc_3_4_414ED0(eax+edi*4, var_BC, var_C0)
  loc_00416E6B: GoTo loc_00416672
  loc_00416E70: 'Referenced from: 0041667A
  loc_00416EB5: var_214 = Options.Option19.Value
  loc_00416EE3: setz dl
  loc_00416F03: If var_22C = 0 Then GoTo loc_00417189
  loc_00416FBF: ecx = InputBox("Please name the function?", var_110, 10, 10, 10, 10, 10)
  loc_0041700E: If (var_00424098 = 0) = 0 Then GoTo loc_004216A0
  loc_0041701F: var_C0 = vbNullString
  loc_00417041: var_eax = call Proc_3_4_414ED0(vbNullString, var_BC, var_C0)
  loc_0041704D: ecx = call Proc_3_4_414ED0(vbNullString, var_BC, var_C0)
  loc_00417095: var_eax = call Proc_3_4_414ED0(vbNullString, var_BC, var_C0)
  loc_004170A1: ecx = call Proc_3_4_414ED0(vbNullString, var_BC, var_C0)
  loc_004170D1: var_BC = Options.Option19.MousePointer
  loc_00417174: var_D0 = var_BC & "vbCrLf" & "Public Function " & var_00424098 & "() As Long" & "vbCrLf"
  loc_00417184: GoTo loc_004176AB
  loc_00417189: 'Referenced from: 00416F03
  loc_004171CE: var_214 = Options.Option4.Value
  loc_004171FC: setz dl
  loc_0041721C: If var_22C = 0 Then GoTo loc_00417397
  loc_0041724F: var_eax = call Proc_3_4_414ED0(vbNullString, 00407BE4h, vbNullString)
  loc_0041725B: call var_2C4(var_EC, var_004240D0, var_004240D0, var_2C4, var_D0)
  loc_004172A3: var_eax = call Proc_3_4_414ED0(vbNullString, 004078B0h, 00407BECh)
  loc_004172AF: call var_2C4
  loc_004172DF: var_BC = Options.Option4.MousePointer
  loc_00417382: var_D0 = var_BC & "vbCrLf" & "Public Function " & var_00424098 & "() As String" & "vbCrLf"
  loc_00417392: GoTo loc_004176AB
  loc_00417397: 'Referenced from: 0041721C
  loc_004173DC: var_214 = Options.Option3.Value
  loc_0041740A: setz dl
  loc_0041742A: If var_22C = 0 Then GoTo loc_004176C0
  loc_004174A2: var_100 = "Enter the name of the sub"
  loc_004174E6: call var_2C4(var_EC, var_004240D0, var_004240D0, var_2C4, var_D0)
  loc_00417535: If (var_00424098 = 0) = 0 Then GoTo loc_004216A0
  loc_00417568: var_eax = call Proc_3_4_414ED0(vbNullString, 00407BE4h, vbNullString)
  loc_00417574: call var_2C4
  loc_004175BC: var_eax = call Proc_3_4_414ED0(vbNullString, 004078B0h, 00407BECh)
  loc_004175C8: call var_2C4
  loc_004175F8: var_BC = Options.Option3.MousePointer
  loc_0041769B: var_D0 = var_BC & "vbCrLf" & "Sub " & var_00424098 & "(TheText As String)" & "vbCrLf"
  loc_004176AB: 'Referenced from: 00417184
  loc_004176AB: Options.Option3.MousePointer = var_D0
  loc_004176B5: If var_D0 >= 0 Then GoTo loc_00417A2B
  loc_004176BB: GoTo loc_00417A19
  loc_004176C0: 'Referenced from: 0041742A
  loc_00417705: var_214 = Options.Option5.Value
  loc_00417733: setz dl
  loc_00417753: If var_22C = 0 Then GoTo loc_00417792
  loc_00417765: Options.Option5.MousePointer = 0
  loc_0041778D: GoTo loc_00417A66
  loc_00417792: 'Referenced from: 00417753
  loc_00417804: var_100 = "Enter the name of the sub"
  loc_00417848: call var_2C4(var_EC, var_004240D0, var_004240D0)
  loc_00417897: If (var_00424098 = 0) = 0 Then GoTo loc_004216A0
  loc_004178CA: var_eax = call Proc_3_4_414ED0(vbNullString, 00407BE4h, vbNullString)
  loc_004178D6: call var_2C4
  loc_0041791E: var_eax = call Proc_3_4_414ED0(vbNullString, 004078B0h, 00407BECh)
  loc_0041792A: call var_2C4
  loc_0041795A: var_BC = Options.Option5.MousePointer
  loc_004179FD: var_D0 = var_BC & "vbCrLf" & "Sub " & var_00424098 & "()" & "vbCrLf"
  loc_00417A0D: Options.Option5.MousePointer = var_D0
  loc_00417A17: If var_D0 >= 0 Then GoTo loc_00417A2B
  loc_00417A19: 'Referenced from: 004176BB
  loc_00417A25: var_D0 = CheckObj(var_2C4, var_00406B74, 164)
  loc_00417A2B: 'Referenced from: 004176B5
  loc_00417A66: 'Referenced from: 0041778D
  loc_00417A68: edi+00000001h = edi+00000001h - 00000001h
  loc_00417A71: var_40 = edi+00000001h
  loc_00417A74: edi+00000001h = edi+00000001h - 00000001h
  loc_00417A7D: var_30 = edi+00000001h
  loc_00417A95: var_BC = Options.Option5.MousePointer
  loc_00417B07: Options.Option5.MousePointer = var_BC & "Dim " & eax+ecx*4
  loc_00417B5A: var_BC = Options.Option5.MousePointer
  loc_00417B94: var_C0 = var_BC & " As Long"
  loc_00417BA0: Options.Option5.MousePointer = var_C0
  loc_00417BCC: 
  loc_00417BDA: 
  loc_00417BDC: If var_30 = 0 Then GoTo loc_00417EA5
  loc_00417BE2: var_30 = var_30 - 00000001h
  loc_00417BEB: var_30 = var_30
  loc_00417BF4: If var_30 < 1001 Then GoTo loc_00417BFC
  loc_00417BF6: var_eax = Err.Raise
  loc_00417BFC: 'Referenced from: 00417BF4
  loc_00417C05: var_1B8 = edx+edi*4
  loc_00417C23: var_110 = LCase(edx+edi*4)
  loc_00417C36: Set var_EC = Me
  loc_00417C42: var_1A8 = var_EC
  loc_00417C60: var_100 = LCase(var_EC)
  loc_00417C72: call __vbaCastObj(var_EC, var_00406B74)
  loc_00417C89: If var_30 < 1001 Then GoTo loc_00417C91
  loc_00417C8B: var_eax = Err.Raise
  loc_00417C91: 'Referenced from: 00417C89
  loc_00417CA1: Len(edx+edi*4) = Len(edx+edi*4) - 00000001h
  loc_00417CB9: var_120 = Left(var_110, Len(edx+edi*4))
  loc_00417CEC: call InStr(var_130, 00000000h, var_120, var_100, 00000001h, Me, __vbaCastObj(var_EC, var_00406B74))
  loc_00417D00: var_22C = (InStr(var_130, 00000000h, var_120, var_100, 00000001h, Me, __vbaCastObj(var_EC, var_00406B74)) = 0)
  loc_00417D42: If var_22C = 0 Then GoTo loc_00417BDA
  loc_00417D5D: var_BC = Options.Option5.MousePointer
  loc_00417DCF: var_C4 = var_BC & ", " & ecx+edx*4
  loc_00417DDB: Options.Option5.MousePointer = var_C4
  loc_00417E2E: var_BC = Options.Option5.MousePointer
  loc_00417E74: Options.Option5.MousePointer = var_BC & " As Long"
  loc_00417EA0: GoTo loc_00417BCC
  loc_00417EA5: 'Referenced from: 00417BDC
  loc_00417EA8: var_40 = var_40 - 00000001h
  loc_00417EF7: var_214 = Options.Option19.Value
  loc_00417F29: setz dl
  loc_00417F49: If var_22C = 0 Then GoTo loc_004184DF
  loc_00417F5D: var_eax = FindWindowEx(4341812, 0, 0, 0)
  loc_00417F74: var_88 = FindWindowEx(4341812, 0, 0, 0)
  loc_00417F7A: 
  loc_00417F7C: If var_218 = 0 Then GoTo loc_004184DF
  loc_00417F85: If ebx = 9 Then GoTo loc_004184DF
  loc_00417F92: var_eax = call Proc_3_3_414DC0(var_88, var_EC, var_004240D0)
  loc_00417FA2: var_3C = call Proc_3_3_414DC0(var_88, var_EC, var_004240D0)
  loc_00417FA7: var_1A8 = var_3C
  loc_00417FC1: Len(var_3C) = Len(var_3C) - 00000001h
  loc_0041800A: var_C0 = vbNullString
  loc_0041802B: var_eax = call Proc_3_4_414ED0(Left(var_3C, Len(var_3C)), var_BC, var_C0)
  loc_0041805B: var_C0 = vbNullString
  loc_0041807C: var_eax = call Proc_3_4_414ED0(call Proc_3_4_414ED0(var_3C, var_BC, var_C0), var_BC, var_C0)
  loc_004180CD: var_eax = call Proc_3_4_414ED0(call Proc_3_4_414ED0(var_3C, var_BC, var_C0), var_BC, var_C0)
  loc_004180D7: var_3C = call Proc_3_4_414ED0(var_3C, var_BC, var_C0)
  loc_004180FF: Set var_EC = Me
  loc_0041810B: var_1A8 = var_EC
  loc_00418129: var_100 = LCase(var_EC)
  loc_0041813B: call __vbaCastObj(var_EC, var_00406B74)
  loc_0041814C: var_1B8 = call Proc_3_4_414ED0(var_3C, var_BC, var_C0)
  loc_0041816A: var_110 = LCase(call Proc_3_4_414ED0(var_3C, var_BC, var_C0))
  loc_00418189: call InStr(var_120, 00000000h, var_110, var_100, 00000001h, Me, __vbaCastObj(var_EC, var_00406B74))
  loc_004181C8: If CBool(InStr(var_120, 00000000h, var_110, var_100, 00000001h, Me, __vbaCastObj(var_EC, var_00406B74))) = 0 Then GoTo loc_00418347
  loc_004181F5: var_3C = var_3C & CStr(0)
  loc_00418212: var_BC = Options.Option19.MousePointer
  loc_00418265: var_C4 = var_BC & ", " & var_3C
  loc_0041826D: Options.Option19.MousePointer = var_C4
  loc_004182BA: var_BC = Options.Option19.MousePointer
  loc_004182F4: var_C0 = var_BC & " As Long"
  loc_004182FC: Options.Option19.MousePointer = var_C0
  loc_0041833C: If var_30 < 1001 Then GoTo loc_00418488
  loc_00418342: GoTo loc_00418482
  loc_00418347: 'Referenced from: 004181C8
  loc_00418356: var_BC = Options.Option19.MousePointer
  loc_004183A9: var_C4 = var_BC & ", " & var_3C
  loc_004183B1: Options.Option19.MousePointer = var_C4
  loc_004183FE: var_BC = Options.Option19.MousePointer
  loc_00418438: var_C0 = var_BC & " As Long"
  loc_00418440: Options.Option19.MousePointer = var_C0
  loc_00418480: If var_30 < 1001 Then GoTo loc_00418488
  loc_00418482: 'Referenced from: 00418342
  loc_00418482: var_eax = Err.Raise
  loc_00418488: 'Referenced from: 0041833C
  loc_00418493: ecx = var_3C
  loc_00418495: var_30 = var_30 + 00000001h
  loc_004184A0: var_30 = var_30
  loc_004184B7: var_eax = FindWindowEx(4341812, var_88, 0, 0)
  loc_004184CE: var_88 = FindWindowEx(4341812, var_88, 0, 0)
  loc_004184DA: GoTo loc_00417F7A
  loc_004184DF: 'Referenced from: 00417F49
  loc_004184E2: var_40 = var_40 + 00000001h
  loc_004184EB: var_68 = var_40
  loc_004184F0: var_40 = var_40 - 00000001h
  loc_004184FF: If var_40 < 1001 Then GoTo loc_00418507
  loc_00418501: var_eax = Err.Raise
  loc_00418507: 'Referenced from: 004184FF
  loc_00418511: var_eax = call Proc_3_2_414BF0(ecx+ebx*4, , )
  loc_0041851D: ecx = call Proc_3_2_414BF0(ecx+ebx*4, , )
  loc_00418525: var_40 = var_40 - 00000001h
  loc_00418534: If var_40 < 1001 Then GoTo loc_0041853C
  loc_00418536: var_eax = Err.Raise
  loc_0041853C: 'Referenced from: 00418534
  loc_00418549: var_ret_4 = var_00424078
  loc_00418561: var_ret_5 = edx+ebx*4
  loc_00418568: var_eax = FindWindow(var_ret_5, var_ret_4)
  loc_0041856D: var_218 = FindWindow(var_ret_5, var_ret_4)
  loc_0041857B: var_40 = var_40 - 00000001h
  loc_0041858A: If var_40 < 1001 Then GoTo loc_00418592
  loc_0041858C: var_eax = Err.Raise
  loc_00418592: 'Referenced from: 0041858A
  loc_004185A8: var_ret_6 = var_BC
  loc_004185B6: var_ret_7 = var_C0
  loc_004185DA: var_B8 = var_218
  loc_004185FB: var_40 = var_40 - 00000002h
  loc_00418607: If var_40 = -1 Then GoTo loc_00418902
  loc_0041860F: var_40 = var_40 - 00000002h
  loc_0041861E: If var_40 < 1001 Then GoTo loc_00418626
  loc_00418620: var_eax = Err.Raise
  loc_00418626: 'Referenced from: 0041861E
  loc_00418639: var_ret_8 = ecx+ebx*4
  loc_00418649: var_ret_9 = CLng(var_B8)
  loc_00418650: var_eax = FindWindowEx(var_ret_9, 0, var_ret_8, 0)
  loc_00418655: var_218 = FindWindowEx(var_ret_9, 0, var_ret_8, 0)
  loc_00418663: var_40 = var_40 - 00000002h
  loc_00418672: If var_40 < 1001 Then GoTo loc_0041867A
  loc_00418674: var_eax = Err.Raise
  loc_0041867A: 'Referenced from: 00418672
  loc_0041868A: var_ret_A = var_BC
  loc_004186B2: var_A8 = var_218
  loc_004186EF: If (var_A8 = 0) = 0 Then GoTo loc_00418902
  loc_004186F5: var_40 = var_40 - 00000001h
  loc_004186FE: var_68 = var_40
  loc_00418703: var_40 = var_40 - 00000001h
  loc_0041870F: If var_40 = -1 Then GoTo loc_00418902
  loc_00418717: var_40 = var_40 - 00000001h
  loc_00418726: If var_40 < 1001 Then GoTo loc_0041872E
  loc_00418728: var_eax = Err.Raise
  loc_0041872E: 'Referenced from: 00418726
  loc_00418740: var_ret_B = eax+ebx*4
  loc_00418750: var_ret_C = CLng(var_A8)
  loc_00418757: var_eax = FindWindowEx(var_ret_C, 0, var_ret_B, 0)
  loc_0041875C: var_218 = FindWindowEx(var_ret_C, 0, var_ret_B, 0)
  loc_0041876A: var_40 = var_40 - 00000001h
  loc_00418779: If var_40 < 1001 Then GoTo loc_00418781
  loc_0041877B: var_eax = Err.Raise
  loc_00418781: 'Referenced from: 00418779
  loc_00418792: var_ret_D = var_BC
  loc_004187B7: var_2C = var_218
  loc_004187F1: If (var_2C = 0) = 0 Then GoTo loc_00418902
  loc_004187F7: var_40 = var_40 - 00000001h
  loc_00418800: var_68 = var_40
  loc_00418805: var_40 = var_40 - 00000001h
  loc_00418811: If var_40 = -1 Then GoTo loc_00418902
  loc_00418819: var_40 = var_40 - 00000001h
  loc_00418828: If var_40 < 1001 Then GoTo loc_00418830
  loc_0041882A: var_eax = Err.Raise
  loc_00418830: 'Referenced from: 00418828
  loc_00418843: var_ret_E = edx+ebx*4
  loc_00418853: var_ret_F = CLng(var_A8)
  loc_0041885A: var_eax = FindWindowEx(var_ret_F, 0, var_ret_E, 0)
  loc_0041885F: var_218 = FindWindowEx(var_ret_F, 0, var_ret_E, 0)
  loc_0041886D: var_40 = var_40 - 00000001h
  loc_0041887C: If var_40 < 1001 Then GoTo loc_00418884
  loc_0041887E: var_eax = Err.Raise
  loc_00418884: 'Referenced from: 0041887C
  loc_00418895: var_ret_10 = var_BC
  loc_004188BA: var_2C = var_218
  loc_004188F4: If (var_2C = 0) = 0 Then GoTo loc_00418902
  loc_004188F6: var_40 = var_40 - 00000001h
  loc_004188FF: var_68 = var_40
  loc_00418902: 'Referenced from: 00418607
  loc_00418943: var_214 = Options.Check4.Value
  loc_00418967: setz bl
  loc_0041897B: If ebx = 0 Then GoTo loc_0041903F
  loc_00418996: var_BC = Options.Check4.MousePointer
  loc_004189B0: var_40 = var_40 - 00000001h
  loc_004189B9: var_22C = var_40
  loc_004189C5: If var_40 < 1001 Then GoTo loc_004189CD
  loc_004189C7: var_eax = Err.Raise
  loc_004189CD: 'Referenced from: 004189C5
  loc_00418A1B: Options.Check4.MousePointer = var_BC & "vbCrLf" & eax+ecx*4
  loc_00418A25: If @%StkVar2 & %x1 >= 0 Then GoTo loc_00418A35
  loc_00418A35: 'Referenced from: 00418A25
  loc_00418A6A: var_BC = Options.Check4.MousePointer
  loc_00418A92: var_108 = var_BC & "& = FindWindow("
  loc_00418AD6: var_C0 = CStr(var_BC & "& = FindWindow(" & Chr(34))
  loc_00418AE6: Options.Check4.MousePointer = var_C0
  loc_00418B4B: var_BC = Options.Check4.MousePointer
  loc_00418B68: var_68 = var_68 - 00000001h
  loc_00418B77: If var_68 < 1001 Then GoTo loc_00418B7F
  loc_00418B79: var_eax = Err.Raise
  loc_00418B7F: 'Referenced from: 00418B77
  loc_00418BA8: var_C0 = var_BC & ecx+esi*4
  loc_00418BBC: Options.Check4.MousePointer = var_C0
  loc_00418C30: var_214 = Options.Check4.Value
  loc_00418C54: setz dl
  loc_00418C6B: If edx = 0 Then GoTo loc_00418F3C
  loc_00418C7A: If var_40 < 1001 Then GoTo loc_00418C82
  loc_00418C7C: var_eax = Err.Raise
  loc_00418C82: 'Referenced from: 00418C7A
  loc_00418C8B: var_eax = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_00418C95: var_70 = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_00418CBE: If (var_70 <> 0) <> 0 Then GoTo loc_00418D80
  loc_00418CC4: var_BC = Options.Check4.MousePointer
  loc_00418CEE: var_108 = var_BC
  loc_00418D0D: var_1A8 = ", VbNullString)"
  loc_00418D5B: var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)")
  loc_00418D6B: Options.Check4.MousePointer = var_C0
  loc_00418D75: If var_C0 >= 0 Then GoTo loc_00419012
  loc_00418D7B: GoTo loc_00419004
  loc_00418D80: 'Referenced from: 00418CBE
  loc_00418D80: var_eax = = Options.Check4.MousePointer
  loc_00418DAA: var_108 = var_BC
  loc_00418DED: var_1B8 = var_70
  loc_00418EB0: var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0)
  loc_00418EC0: Options.Check4.MousePointer = var_C0
  loc_00418F37: GoTo loc_004193B7
  loc_00418F3C: 'Referenced from: 00418C6B
  loc_00418F51: var_BC = Options.Check4.MousePointer
  loc_00418F7B: var_108 = var_BC
  loc_00418F9A: var_1A8 = ", vbNullString)"
  loc_00418FE8: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  loc_00418FF8: Options.Check4.MousePointer = var_C0
  loc_00419002: If var_C0 >= 0 Then GoTo loc_00419012
  loc_00419004: 'Referenced from: 00418D7B
  loc_00419010: var_C0 = CheckObj(var_2C4, var_00406B74, 164)
  loc_00419012: 'Referenced from: 00418D75
  loc_0041903A: GoTo loc_004193AC
  loc_0041903F: 'Referenced from: 0041897B
  loc_00419054: var_BC = Options.Check4.MousePointer
  loc_0041906E: var_2C4 = var_2C4 - 00000001h
  loc_00419077: var_22C = var_2C4
  loc_00419083: If var_2C4 < 1001 Then GoTo loc_0041908B
  loc_00419085: var_eax = Err.Raise
  loc_0041908B: 'Referenced from: 00419083
  loc_004190CA: var_C4 = var_BC & "vbCrLf" & ecx+edx*4
  loc_004190DA: Options.Check4.MousePointer = var_C4
  loc_00419129: var_BC = Options.Check4.MousePointer
  loc_00419151: var_108 = var_BC & "& = FindWindow("
  loc_00419195: var_C0 = CStr(var_BC & "& = FindWindow(" & Chr(34))
  loc_004191A5: Options.Check4.MousePointer = var_C0
  loc_0041920A: var_BC = Options.Check4.MousePointer
  loc_00419227: var_68 = var_68 - 00000001h
  loc_00419236: If var_68 < 1001 Then GoTo loc_0041923E
  loc_00419238: var_eax = Err.Raise
  loc_0041923E: 'Referenced from: 00419236
  loc_00419257: var_308 = edx
  loc_00419267: var_C0 = var_BC & ecx+esi*4
  loc_0041927B: Options.Check4.MousePointer = var_C0
  loc_004192C3: var_BC = Options.Check4.MousePointer
  loc_004192ED: var_108 = var_BC
  loc_0041930C: var_1A8 = ",vbNullString)"
  loc_0041935A: var_C0 = CStr(var_BC & Chr(34) & ",vbNullString)")
  loc_0041936A: Options.Check4.MousePointer = var_C0
  loc_004193AC: 'Referenced from: 0041903A
  loc_004193B7: 'Referenced from: 00418F37
  loc_004193C1: var_68 = var_68 - 00000002h
  loc_004193C9: var_38 = var_68
  loc_004193DC: var_1B8 = var_68
  loc_00419426: For var_B8 = 0 To var_68 Step 1
  loc_0041942C: 
  loc_0041942E: If var_B8 = 0 Then GoTo loc_0041C72B
  loc_0041943E: If var_68 = -1 Then GoTo loc_0041C72B
  loc_00419485: var_214 = Options.Option19.Value
  loc_004194A9: setz dl
  loc_004194C0: If edx = 0 Then GoTo loc_004194CC
  loc_004194C6: If var_68 = 1 Then GoTo loc_0041C72B
  loc_004194CC: 'Referenced from: 004194C0
  loc_0041950D: var_214 = Options.Option19.Value
  loc_00419531: setz dl
  loc_00419548: If edx = 0 Then GoTo loc_004195B2
  loc_00419561: var_1B8 = var_68
  loc_004195AC: If (var_B8 + 2 <> var_68) <> 0 Then GoTo loc_0041BD07
  loc_004195B2: 'Referenced from: 00419548
  loc_004195BB: If var_38 < 1001 Then GoTo loc_004195C3
  loc_004195BD: var_eax = Err.Raise
  loc_004195C3: 'Referenced from: 004195BB
  loc_004195CF: If var_44 = 0 Then GoTo loc_0041BCC9
  loc_004195D7: If var_38 <> 0 Then GoTo loc_00419735
  loc_004195E8: If 00000001h < 1001 Then GoTo loc_004195F0
  loc_004195EA: var_eax = Err.Raise
  loc_004195F0: 'Referenced from: 004195E8
  loc_00419602: var_ret_11 = CInt(4341840)
  loc_00419615: var_eax = FindWindowEx(ecx+esi*4, 0, var_ret_11, 0)
  loc_0041961A: var_218 = FindWindowEx(ecx+esi*4, 0, var_ret_11, 0)
  loc_00419634: var_ret_12 = var_BC
  loc_00419654: If var_218 = 00424034h Then GoTo loc_0041971C
  loc_0041965A: 
  loc_00419666: If var_38 < 1001 Then GoTo loc_0041966A
  loc_00419668: var_eax = Err.Raise
  loc_0041966A: 'Referenced from: 00419666
  loc_00419672: If var_218 = 0 Then GoTo loc_0041972B
  loc_0041967E: If var_38 < 1001 Then GoTo loc_00419682
  loc_00419680: var_eax = Err.Raise
  loc_00419682: 'Referenced from: 0041967E
  loc_00419684: var_38 = var_38 + 00000001h
  loc_00419693: If var_38 < 1001 Then GoTo loc_0041969B
  loc_00419695: var_eax = Err.Raise
  loc_0041969B: 'Referenced from: 00419693
  loc_004196AE: var_ret_13 = ecx+ebx*4
  loc_004196C0: var_eax = FindWindowEx(ecx+esi*4, var_218, var_ret_13, 0)
  loc_004196C5: var_218 = FindWindowEx(ecx+esi*4, var_218, var_ret_13, 0)
  loc_004196D7: If var_38 < 1001 Then GoTo loc_004196DF
  loc_004196D9: var_eax = Err.Raise
  loc_004196DF: 'Referenced from: 004196D7
  loc_004196F0: var_ret_14 = var_BC
  loc_0041970B: var_34 = var_34 + 00000001h
  loc_00419714: var_34 = var_34
  loc_00419717: GoTo loc_0041965A
  loc_0041971C: 'Referenced from: 00419654
  loc_0041971F: var_34 = var_34 + 00000001h
  loc_00419728: var_34 = var_34
  loc_0041972B: 'Referenced from: 00419672
  loc_0041972F: If var_34 >= 4 Then GoTo loc_0041B252
  loc_00419735: 'Referenced from: 004195D7
  loc_0041973B: If var_38 < 1001 Then GoTo loc_00419743
  loc_0041973D: var_eax = Err.Raise
  loc_00419743: 'Referenced from: 0041973B
  loc_00419745: var_38 = var_38 + 00000001h
  loc_0041975A: If var_38 < 1001 Then GoTo loc_0041975E
  loc_0041975C: var_eax = Err.Raise
  loc_0041975E: 'Referenced from: 0041975A
  loc_00419771: var_ret_15 = edx+ebx*4
  loc_00419784: var_eax = FindWindowEx(edx+esi*4, 0, var_ret_15, 0)
  loc_00419789: var_218 = FindWindowEx(edx+esi*4, 0, var_ret_15, 0)
  loc_0041979B: If var_38 < 1001 Then GoTo loc_0041979F
  loc_0041979D: var_eax = Err.Raise
  loc_0041979F: 'Referenced from: 0041979B
  loc_004197B0: var_ret_16 = var_BC
  loc_004197BC: var_44 = var_218
  loc_004197D1: If var_38 < 1001 Then GoTo loc_004197D5
  loc_004197D3: var_eax = Err.Raise
  loc_004197D5: 'Referenced from: 004197D1
  loc_004197DE: If var_218 = 0 Then GoTo loc_0041AAD3
  loc_004197E4: 
  loc_004197F3: If var_38 < 1001 Then GoTo loc_004197F7
  loc_004197F5: var_eax = Err.Raise
  loc_004197F7: 'Referenced from: 004197F3
  loc_00419802: If var_44 = 0 Then GoTo loc_0041A172
  loc_0041980E: If var_38 < 1001 Then GoTo loc_00419812
  loc_00419810: var_eax = Err.Raise
  loc_00419812: 'Referenced from: 0041980E
  loc_00419814: var_38 = var_38 + 00000001h
  loc_00419823: If var_38 < 1001 Then GoTo loc_00419827
  loc_00419825: var_eax = Err.Raise
  loc_00419827: 'Referenced from: 00419823
  loc_0041983A: var_ret_17 = ecx+edi*4
  loc_0041984F: var_eax = FindWindowEx(edx+esi*4, var_44, var_ret_17, 0)
  loc_00419854: var_218 = FindWindowEx(edx+esi*4, var_44, var_ret_17, 0)
  loc_00419866: If var_38 < 1001 Then GoTo loc_0041986A
  loc_00419868: var_eax = Err.Raise
  loc_0041986A: 'Referenced from: 00419866
  loc_0041987B: var_ret_18 = var_BC
  loc_00419887: var_44 = var_218
  loc_004198A5: var_BC = Options.Option19.MousePointer
  loc_0041990C: var_C4 = var_BC & "vbCrLf" & eax+ecx*4
  loc_00419922: var_C8 = var_C4 & var_00407DEC
  loc_00419926: Options.Option19.MousePointer = var_C8
  loc_0041997A: var_BC = Options.Option19.MousePointer
  loc_0041999B: var_38 = var_38 + 00000001h
  loc_004199AA: If var_38 < 1001 Then GoTo loc_004199B2
  loc_004199AC: var_eax = Err.Raise
  loc_004199B2: 'Referenced from: 004199AA
  loc_004199F5: var_C4 = var_BC & "& = FindWindowEx(" & edx+edi*4
  loc_00419A03: Options.Option19.MousePointer = var_C4
  loc_00419A5A: var_BC = Options.Option19.MousePointer
  loc_00419A82: var_314 = edx
  loc_00419A92: var_C0 = var_BC & "&, "
  loc_00419AA0: Options.Option19.MousePointer = var_C0
  loc_00419AE2: var_BC = Options.Option19.MousePointer
  loc_00419B1F: var_318 = ecx
  loc_00419B33: var_C0 = var_BC & eax+ebx*4
  loc_00419B41: Options.Option19.MousePointer = var_C0
  loc_00419B83: var_BC = Options.Option19.MousePointer
  loc_00419BAF: var_108 = var_BC & "&, "
  loc_00419BC8: var_100 = Chr(34)
  loc_00419BF5: var_C0 = CStr(var_BC & "&, " & var_100)
  loc_00419BFD: Options.Option19.MousePointer = var_C0
  loc_00419C60: var_BC = Options.Option19.MousePointer
  loc_00419CA1: var_31C = ecx
  loc_00419CB5: var_C0 = var_BC & eax+ebx*4
  loc_00419CC3: Options.Option19.MousePointer = var_C0
  loc_00419D45: var_214 = Options.Check4.Value
  loc_00419D69: setz al
  loc_00419D80: If eax = 0 Then GoTo loc_0041A079
  loc_00419D8F: If var_38 < 1001 Then GoTo loc_00419D97
  loc_00419D91: var_eax = Err.Raise
  loc_00419D97: 'Referenced from: 00419D8F
  loc_00419DA1: var_eax = call Proc_3_7_415CF0(ecx+esi*4, var_EC, var_004240D0)
  loc_00419DAB: var_70 = call Proc_3_7_415CF0(ecx+esi*4, var_EC, var_004240D0)
  loc_00419DC1: If (var_70 <> 0) <> 0 Then GoTo loc_00419EC0
  loc_00419DD6: var_BC = Options.Check4.MousePointer
  loc_00419E00: var_108 = var_BC
  loc_00419E20: var_1A8 = ", VbNullString)"
  loc_00419E62: var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)")
  loc_00419E6A: Options.Check4.MousePointer = var_C0
  loc_00419EBB: GoTo loc_004197E4
  loc_00419EC0: 'Referenced from: 00419DC1
  loc_00419ECA: If (var_70 = 0) = 0 Then GoTo loc_004197E4
  loc_00419EDF: var_BC = Options.Check4.MousePointer
  loc_00419EE9: If var_BC >= 0 Then GoTo loc_00419EF9
  loc_00419EF7: call ecx(var_BC, Me, var_00406B74, 000000A0h, var_004240D0)
  loc_00419EF9: 'Referenced from: 00419EE9
  loc_00419F09: var_108 = var_BC
  loc_00419F4C: var_1B8 = var_70
  loc_00419FF1: var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0)
  loc_00419FF9: Options.Check4.MousePointer = var_C0
  loc_0041A074: GoTo loc_004197E4
  loc_0041A079: 'Referenced from: 00419D80
  loc_0041A088: var_BC = Options.Check4.MousePointer
  loc_0041A092: If var_BC >= 0 Then GoTo loc_0041A0A2
  loc_0041A0A0: call edx(var_BC, Me, var_00406B74, 000000A0h)
  loc_0041A0A2: 'Referenced from: 0041A092
  loc_0041A0B2: var_108 = var_BC
  loc_0041A0D2: var_1A8 = ", vbNullString)"
  loc_0041A114: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  loc_0041A11C: Options.Check4.MousePointer = var_C0
  loc_0041A16D: GoTo loc_004197E4
  loc_0041A172: 'Referenced from: 00419802
  loc_0041A181: var_BC = Options.Check4.MousePointer
  loc_0041A1FF: var_C8 = var_BC & "vbCrLf" & edx+eax*4 & var_00407DEC
  loc_0041A203: Options.Check4.MousePointer = var_C8
  loc_0041A257: var_BC = Options.Check4.MousePointer
  loc_0041A278: var_38 = var_38 + 00000001h
  loc_0041A287: If var_38 < 1001 Then GoTo loc_0041A28F
  loc_0041A289: var_eax = Err.Raise
  loc_0041A28F: 'Referenced from: 0041A287
  loc_0041A2CA: var_C4 = var_BC & "& = FindWindowEx(" & ecx+edi*4
  loc_0041A2D2: Options.Check4.MousePointer = var_C4
  loc_0041A329: var_BC = Options.Check4.MousePointer
  loc_0041A35F: var_C0 = var_BC & "&, "
  loc_0041A367: Options.Check4.MousePointer = var_C0
  loc_0041A3A9: var_BC = Options.Check4.MousePointer
  loc_0041A3E7: var_320 = eax
  loc_0041A3FB: var_C0 = var_BC & ecx+edi*4
  loc_0041A409: Options.Check4.MousePointer = var_C0
  loc_0041A44B: var_BC = Options.Check4.MousePointer
  loc_0041A477: var_108 = var_BC & "&, "
  loc_0041A490: var_100 = Chr(34)
  loc_0041A4BB: var_C0 = CStr(var_BC & "&, " & var_100)
  loc_0041A4C3: Options.Check4.MousePointer = var_C0
  loc_0041A524: var_BC = Options.Check4.MousePointer
  loc_0041A562: var_324 = eax
  loc_0041A576: var_C0 = var_BC & ecx+ebx*4
  loc_0041A584: Options.Check4.MousePointer = var_C0
  loc_0041A606: var_214 = Options.Check4.Value
  loc_0041A62A: setz dl
  loc_0041A641: If edx = 0 Then GoTo loc_0041A9AA
  loc_0041A650: If var_38 < 1001 Then GoTo loc_0041A658
  loc_0041A652: var_eax = Err.Raise
  loc_0041A658: 'Referenced from: 0041A650
  loc_0041A661: var_eax = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_0041A66B: var_70 = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_0041A681: If (var_70 <> 0) <> 0 Then GoTo loc_0041A7B0
  loc_0041A696: var_BC = Options.Check4.MousePointer
  loc_0041A6C0: var_108 = var_BC
  loc_0041A6E0: var_1A8 = ", VbNullString)"
  loc_0041A6F0: var_1B8 = "vbCrLf"
  loc_0041A74F: var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)" & "vbCrLf")
  loc_0041A757: Options.Check4.MousePointer = var_C0
  loc_0041A7AB: GoTo loc_004195B2
  loc_0041A7B0: 'Referenced from: 0041A681
  loc_0041A7BA: If (var_70 = 0) = 0 Then GoTo loc_004195B2
  loc_0041A7CF: var_BC = Options.Check4.MousePointer
  loc_0041A7D9: If var_BC >= 0 Then GoTo loc_0041A7E9
  loc_0041A7E7: call eax(var_BC, var_BC, var_00406B74, 000000A0h, var_004240D0)
  loc_0041A7E9: 'Referenced from: 0041A7D9
  loc_0041A7F9: var_108 = var_BC
  loc_0041A83C: var_1B8 = var_70
  loc_0041A86C: var_1D8 = "vbCrLf"
  loc_0041A91F: var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0 & "vbCrLf")
  loc_0041A927: Options.Check4.MousePointer = var_C0
  loc_0041A9A5: GoTo loc_004195B2
  loc_0041A9AA: 'Referenced from: 0041A641
  loc_0041A9B9: var_BC = Options.Check4.MousePointer
  loc_0041A9C3: If var_BC >= 0 Then GoTo loc_0041A9D3
  loc_0041A9D1: call ecx(var_BC, Me, var_00406B74, 000000A0h)
  loc_0041A9D3: 'Referenced from: 0041A9C3
  loc_0041A9E3: var_108 = var_BC
  loc_0041AA03: var_1A8 = ", vbNullString)"
  loc_0041AA13: var_1B8 = "vbCrLf"
  loc_0041AA72: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)" & "vbCrLf")
  loc_0041AA7A: Options.Check4.MousePointer = var_C0
  loc_0041AACE: GoTo loc_004195B2
  loc_0041AAD3: 'Referenced from: 004197DE
  loc_0041AAE2: var_BC = Options.Check4.MousePointer
  loc_0041AB45: var_C4 = var_BC & "vbCrLf" & ecx+ebx*4
  loc_0041AB4D: Options.Check4.MousePointer = var_C4
  loc_0041AB9A: var_BC = Options.Check4.MousePointer
  loc_0041ABBA: esi = esi + 00000001h
  loc_0041ABC9: If esi < 1001 Then GoTo loc_0041ABD1
  loc_0041ABCB: var_eax = Err.Raise
  loc_0041ABD1: 'Referenced from: 0041ABC9
  loc_0041AC0E: var_C4 = var_BC & "& = FindWindowEx(" & ecx+edi*4
  loc_0041AC16: Options.Check4.MousePointer = var_C4
  loc_0041AC63: var_BC = Options.Check4.MousePointer
  loc_0041AC8F: var_108 = var_BC & "&, 0&,"
  loc_0041ACD5: var_C0 = CStr(var_BC & "&, 0&," & Chr(34))
  loc_0041ACDD: Options.Check4.MousePointer = var_C0
  loc_0041AD40: var_BC = Options.Check4.MousePointer
  loc_0041AD82: var_328 = edx
  loc_0041AD96: var_C0 = var_BC & ecx+ebx*4
  loc_0041ADA4: Options.Check4.MousePointer = var_C0
  loc_0041AE26: var_214 = Options.Check4.Value
  loc_0041AE4A: setz dl
  loc_0041AE61: If edx = 0 Then GoTo loc_0041B159
  loc_0041AE70: If var_38 < 1001 Then GoTo loc_0041AE78
  loc_0041AE72: var_eax = Err.Raise
  loc_0041AE78: 'Referenced from: 0041AE70
  loc_0041AE81: var_eax = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_0041AE8B: var_70 = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_0041AEA1: If (var_70 <> 0) <> 0 Then GoTo loc_0041AFA0
  loc_0041AEB6: var_BC = Options.Check4.MousePointer
  loc_0041AEE0: var_108 = var_BC
  loc_0041AF00: var_1A8 = ", VbNullString)"
  loc_0041AF42: var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)")
  loc_0041AF4A: Options.Check4.MousePointer = var_C0
  loc_0041AF9B: GoTo loc_004195B2
  loc_0041AFA0: 'Referenced from: 0041AEA1
  loc_0041AFAA: If (var_70 = 0) = 0 Then GoTo loc_004195B2
  loc_0041AFBF: var_BC = Options.Check4.MousePointer
  loc_0041AFC9: If var_BC >= 0 Then GoTo loc_0041AFD9
  loc_0041AFD7: call eax(var_BC, var_BC, var_00406B74, 000000A0h, var_004240D0)
  loc_0041AFD9: 'Referenced from: 0041AFC9
  loc_0041AFE9: var_108 = var_BC
  loc_0041B02C: var_1B8 = var_70
  loc_0041B0D1: var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0)
  loc_0041B0D9: Options.Check4.MousePointer = var_C0
  loc_0041B154: GoTo loc_004195B2
  loc_0041B159: 'Referenced from: 0041AE61
  loc_0041B168: var_BC = Options.Check4.MousePointer
  loc_0041B172: If var_BC >= 0 Then GoTo loc_0041B182
  loc_0041B180: call ecx(var_BC, Me, var_00406B74, 000000A0h)
  loc_0041B182: 'Referenced from: 0041B172
  loc_0041B192: var_108 = var_BC
  loc_0041B1B2: var_1A8 = ", vbNullString)"
  loc_0041B1F4: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  loc_0041B1FC: Options.Check4.MousePointer = var_C0
  loc_0041B24D: GoTo loc_004195B2
  loc_0041B252: 'Referenced from: 0041972F
  loc_0041B261: var_BC = Options.Check4.MousePointer
  loc_0041B2B5: var_C4 = var_BC & "vbCrLf" & "Dim X As Long"
  loc_0041B2BD: Options.Check4.MousePointer = var_C4
  loc_0041B30A: var_BC = Options.Check4.MousePointer
  loc_0041B3A6: var_D0 = var_BC & "vbCrLf" & "For X = 0 To " & CStr(var_34) & "vbCrLf"
  loc_0041B3AE: Options.Check4.MousePointer = var_D0
  loc_0041B410: var_BC = Options.Check4.MousePointer
  loc_0041B45D: var_C0 = var_BC & ecx+ebx*4
  loc_0041B465: Options.Check4.MousePointer = var_C0
  loc_0041B4AB: var_BC = Options.Check4.MousePointer
  loc_0041B4CB: esi = esi + 00000001h
  loc_0041B4D4: var_22C = esi+00000001h
  loc_0041B4DF: If esi < 1001 Then GoTo loc_0041B4E7
  loc_0041B4E1: var_eax = Err.Raise
  loc_0041B4E7: 'Referenced from: 0041B4DF
  loc_0041B527: var_C4 = var_BC & " = FindWindowEx(" & eax+ecx*4
  loc_0041B52F: Options.Check4.MousePointer = var_C4
  loc_0041B57C: var_BC = Options.Check4.MousePointer
  loc_0041B5E3: var_C4 = var_BC & ", " & ecx+ebx*4
  loc_0041B5EB: Options.Check4.MousePointer = var_C4
  loc_0041B638: var_BC = Options.Check4.MousePointer
  loc_0041B668: var_108 = var_BC & ", "
  loc_0041B682: var_100 = Chr(34)
  loc_0041B68E: If esi < 1001 Then GoTo loc_0041B696
  loc_0041B690: var_eax = Err.Raise
  loc_0041B696: 'Referenced from: 0041B68E
  loc_0041B69F: var_1A8 = edx+ebx*4
  loc_0041B6E5: var_C0 = CStr(var_BC & ", " & var_100 & edx+ebx*4)
  loc_0041B6ED: Options.Check4.MousePointer = var_C0
  loc_0041B793: var_214 = Options.Check4.Value
  loc_0041B7B7: setz dl
  loc_0041B7CE: If edx = 0 Then GoTo loc_0041BB1D
  loc_0041B7DA: If esi < 1001 Then GoTo loc_0041B7E2
  loc_0041B7DC: var_eax = Err.Raise
  loc_0041B7E2: 'Referenced from: 0041B7DA
  loc_0041B7EB: var_eax = call Proc_3_7_415CF0(eax+ebx*4, var_EC, var_004240D0)
  loc_0041B7F5: var_70 = call Proc_3_7_415CF0(eax+ebx*4, var_EC, var_004240D0)
  loc_0041B80B: If (var_70 <> 0) <> 0 Then GoTo loc_0041B937
  loc_0041B820: var_BC = Options.Check4.MousePointer
  loc_0041B84A: var_108 = var_BC
  loc_0041B86A: var_1A8 = ", VbNullString)"
  loc_0041B87A: var_1B8 = "vbCrLf"
  loc_0041B8D3: var_C0 = CStr(var_BC & Chr(34) & ", VbNullString)" & "vbCrLf")
  loc_0041B8DB: Options.Check4.MousePointer = var_C0
  loc_0041B932: GoTo loc_0041BC3E
  loc_0041B937: 'Referenced from: 0041B80B
  loc_0041B941: If (var_70 = 0) = 0 Then GoTo loc_0041BC49
  loc_0041B956: var_BC = Options.Check4.MousePointer
  loc_0041B980: var_108 = var_BC
  loc_0041B9C0: var_1B8 = var_70
  loc_0041B9E7: var_1D8 = "vbCrLf"
  loc_0041BA84: var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0 & "vbCrLf")
  loc_0041BA8C: Options.Check4.MousePointer = var_C0
  loc_0041BB18: GoTo loc_0041BC49
  loc_0041BB1D: 'Referenced from: 0041B7CE
  loc_0041BB2C: var_BC = Options.Check4.MousePointer
  loc_0041BB56: var_108 = var_BC
  loc_0041BB76: var_1A8 = ", vbNullString)"
  loc_0041BB86: var_1B8 = "vbCrLf"
  loc_0041BBDF: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)" & "vbCrLf")
  loc_0041BBE7: Options.Check4.MousePointer = var_C0
  loc_0041BC3E: 'Referenced from: 0041B932
  loc_0041BC49: 'Referenced from: 0041BB18
  loc_0041BC58: var_BC = Options.Check4.MousePointer
  loc_0041BC8E: var_C0 = var_BC & "Next X"
  loc_0041BC96: Options.Check4.MousePointer = var_C0
  loc_0041BCC9: 'Referenced from: 004195CF
  loc_0041BCCC: var_38 = var_38 - 00000001h
  loc_0041BCD5: var_38 = var_38
  loc_0041BCED: Next var_B8
  loc_0041BD02: GoTo loc_0041942C
  loc_0041BD0E: If var_38 < 1001 Then GoTo loc_0041BD16
  loc_0041BD10: var_eax = Err.Raise
  loc_0041BD16: 'Referenced from: 0041BD0E
  loc_0041BD19: var_38 = var_38 + 00000001h
  loc_0041BD28: If var_38 < 1001 Then GoTo loc_0041BD30
  loc_0041BD2A: var_eax = Err.Raise
  loc_0041BD30: 'Referenced from: 0041BD28
  loc_0041BD46: var_ret_19 = ecx+edx*4
  loc_0041BD59: var_eax = FindWindowEx(edx+esi*4, 0, var_ret_19, 0)
  loc_0041BD5E: var_218 = FindWindowEx(edx+esi*4, 0, var_ret_19, 0)
  loc_0041BD71: If var_38 < 1001 Then GoTo loc_0041BD79
  loc_0041BD73: var_eax = Err.Raise
  loc_0041BD79: 'Referenced from: 0041BD71
  loc_0041BD8D: var_ret_1A = var_BC
  loc_0041BDB4: var_BC = Options.Check4.MousePointer
  loc_0041BE38: Options.Check4.MousePointer = var_BC & "vbCrLf" & eax+ecx*4 & var_00407DEC
  loc_0041BE8E: var_BC = Options.Check4.MousePointer
  loc_0041BEAB: var_38 = var_38 + 00000001h
  loc_0041BEB4: var_22C = var_38
  loc_0041BEBF: If var_38 < 1001 Then GoTo loc_0041BEC7
  loc_0041BEC1: var_eax = Err.Raise
  loc_0041BEC7: 'Referenced from: 0041BEBF
  loc_0041BF0F: Options.Check4.MousePointer = var_BC & "& = FindWindowEx(" & eax+ecx*4
  loc_0041BF5E: var_BC = Options.Check4.MousePointer
  loc_0041BF90: var_C0 = var_BC & "&, "
  loc_0041BFA0: Options.Check4.MousePointer = var_C0
  loc_0041BFE8: var_BC = Options.Check4.MousePointer
  loc_0041C040: Options.Check4.MousePointer = var_BC & eax+ecx*4
  loc_0041C088: var_BC = Options.Check4.MousePointer
  loc_0041C0B0: var_108 = var_BC & "&, "
  loc_0041C104: Options.Check4.MousePointer = CStr(var_BC & "&, " & Chr(34))
  loc_0041C169: var_BC = Options.Check4.MousePointer
  loc_0041C1B2: var_C0 = var_BC & ecx+edx*4
  loc_0041C1C2: Options.Check4.MousePointer = var_C0
  loc_0041C236: var_214 = Options.Check4.Value
  loc_0041C25A: setz dl
  loc_0041C271: If edx = 0 Then GoTo loc_0041C5F5
  loc_0041C280: If var_38 < 1001 Then GoTo loc_0041C288
  loc_0041C282: var_eax = Err.Raise
  loc_0041C288: 'Referenced from: 0041C280
  loc_0041C291: var_eax = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_0041C29B: var_70 = call Proc_3_7_415CF0(eax+esi*4, var_EC, var_004240D0)
  loc_0041C2B1: If (var_70 <> 0) <> 0 Then GoTo loc_0041C3E7
  loc_0041C2CC: var_BC = Options.Check4.MousePointer
  loc_0041C2F6: var_108 = var_BC
  loc_0041C315: var_1A8 = ", VbNullString)"
  loc_0041C32A: var_1B8 = "vbCrLf"
  loc_0041C399: Options.Check4.MousePointer = CStr(var_BC & Chr(34) & ", VbNullString)" & "vbCrLf")
  loc_0041C3E2: GoTo loc_0041C720
  loc_0041C3E7: 'Referenced from: 0041C2B1
  loc_0041C3F1: If (var_70 = 0) = 0 Then GoTo loc_0041C72B
  loc_0041C40C: var_BC = Options.Check4.MousePointer
  loc_0041C436: var_108 = var_BC
  loc_0041C479: var_1B8 = var_70
  loc_0041C4A9: var_1D8 = "vbCrLf"
  loc_0041C562: var_C0 = CStr(var_BC & Chr(34) & &H407DA8 & Chr(34) & var_70 & Chr(34) & &H407DB0 & "vbCrLf")
  loc_0041C572: Options.Check4.MousePointer = var_C0
  loc_0041C5F0: GoTo loc_0041C72B
  loc_0041C5F5: 'Referenced from: 0041C271
  loc_0041C60A: var_BC = Options.Check4.MousePointer
  loc_0041C634: var_108 = var_BC
  loc_0041C653: var_1A8 = ", vbNullString)"
  loc_0041C668: var_1B8 = "vbCrLf"
  loc_0041C6C7: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)" & "vbCrLf")
  loc_0041C6D7: Options.Check4.MousePointer = var_C0
  loc_0041C720: 'Referenced from: 0041C3E2
  loc_0041C72B: 'Referenced from: 0041942E
  loc_0041C732: If arg_C = var_FFFFFF Then GoTo loc_004216A0
  loc_0041C779: var_214 = Options.Option1.Value
  loc_0041C79D: setz al
  loc_0041C7B4: If eax = 0 Then GoTo loc_0041CAAE
  loc_0041C7CF: var_BC = Options.Option1.MousePointer
  loc_0041C7EC: var_38 = var_38 + 00000001h
  loc_0041C7F5: var_22C = var_38
  loc_0041C800: If var_38 < 1001 Then GoTo loc_0041C808
  loc_0041C802: var_eax = Err.Raise
  loc_0041C808: 'Referenced from: 0041C800
  loc_0041C857: var_C8 = var_BC & "vbCrLf" & "PostMessage " & edx+eax*4
  loc_0041C867: Options.Option1.MousePointer = var_C8
  loc_0041C8BD: var_BC = Options.Option1.MousePointer
  loc_0041C8EF: var_C0 = var_BC & "&, WM_LBUTTONDOWN, 0&, 0&"
  loc_0041C8FF: Options.Option1.MousePointer = var_C0
  loc_0041C947: var_BC = Options.Option1.MousePointer
  loc_0041C964: var_38 = var_38 + 00000001h
  loc_0041C96D: var_22C = var_38
  loc_0041C978: If var_38 < 1001 Then GoTo loc_0041C980
  loc_0041C97A: var_eax = Err.Raise
  loc_0041C980: 'Referenced from: 0041C978
  loc_0041C9DE: Options.Option1.MousePointer = var_BC & "vbCrLf" & "PostMessage " & eax+ecx*4
  loc_0041CA34: var_BC = Options.Option1.MousePointer
  loc_0041CA76: Options.Option1.MousePointer = var_BC & "&, WM_LBUTTONUP, 0&, 0&"
  loc_0041CAA9: GoTo loc_004212C7
  loc_0041CAAE: 'Referenced from: 0041C7B4
  loc_0041CAEF: var_214 = Options.Option2.Value
  loc_0041CB13: setz dl
  loc_0041CB2A: If edx = 0 Then GoTo loc_0041CE02
  loc_0041CB45: var_BC = Options.Option2.MousePointer
  loc_0041CB62: var_38 = var_38 + 00000001h
  loc_0041CB6B: var_22C = var_38
  loc_0041CB76: If var_38 < 1001 Then GoTo loc_0041CB7E
  loc_0041CB78: var_eax = Err.Raise
  loc_0041CB7E: 'Referenced from: 0041CB76
  loc_0041CBCD: var_C8 = var_BC & "vbCrLf" & "SendMessage " & ecx+edx*4
  loc_0041CBDD: Options.Option2.MousePointer = var_C8
  loc_0041CC33: var_BC = Options.Option2.MousePointer
  loc_0041CC65: var_C0 = var_BC & "&, &H201, 0&, 0&"
  loc_0041CC75: Options.Option2.MousePointer = var_C0
  loc_0041CCBD: var_BC = Options.Option2.MousePointer
  loc_0041CCDA: var_38 = var_38 + 00000001h
  loc_0041CCE3: var_22C = var_38
  loc_0041CCEE: If var_38 < 1001 Then GoTo loc_0041CCF6
  loc_0041CCF0: var_eax = Err.Raise
  loc_0041CCF6: 'Referenced from: 0041CCEE
  loc_0041CD45: var_C8 = var_BC & "vbCrLf" & "SendMessage " & edx+eax*4
  loc_0041CD55: Options.Option2.MousePointer = var_C8
  loc_0041CDAB: var_BC = Options.Option2.MousePointer
  loc_0041CDDD: var_C0 = var_BC & "&, &H202, 0&, 0&"
  loc_0041CDED: Options.Option2.MousePointer = var_C0
  loc_0041CDF7: If var_C0 >= 0 Then GoTo loc_0041F877
  loc_0041CDFD: GoTo loc_0041F869
  loc_0041CE02: 'Referenced from: 0041CB2A
  loc_0041CE43: var_214 = Options.Option3.Value
  loc_0041CE67: setz al
  loc_0041CE7E: If eax = 0 Then GoTo loc_0041CFCE
  loc_0041CE99: var_BC = Options.Option3.MousePointer
  loc_0041CEB6: var_38 = var_38 + 00000001h
  loc_0041CEBF: var_22C = var_38
  loc_0041CECA: If var_38 < 1001 Then GoTo loc_0041CED2
  loc_0041CECC: var_eax = Err.Raise
  loc_0041CED2: 'Referenced from: 0041CECA
  loc_0041CF21: var_C8 = var_BC & "vbCrLf" & "SendMessageByString " & edx+eax*4
  loc_0041CF31: Options.Option3.MousePointer = var_C8
  loc_0041CF87: var_BC = Options.Option3.MousePointer
  loc_0041CFB9: var_C0 = var_BC & "&, WM_SETTEXT, 0&, TheText$"
  loc_0041CFC9: GoTo loc_0041CDED
  loc_0041CFCE: 'Referenced from: 0041CE7E
  loc_0041D00F: var_214 = Options.Option4.Value
  loc_0041D033: setz al
  loc_0041D04A: If eax = 0 Then GoTo loc_0041D641
  loc_0041D065: var_BC = Options.Option4.MousePointer
  loc_0041D0AD: var_C4 = var_BC & "vbCrLf" & "Dim TheText As String, TL As Long"
  loc_0041D0BD: Options.Option4.MousePointer = var_C4
  loc_0041D10C: var_BC = Options.Option4.MousePointer
  loc_0041D129: var_38 = var_38 + 00000001h
  loc_0041D132: var_22C = var_38
  loc_0041D13D: If var_38 < 1001 Then GoTo loc_0041D145
  loc_0041D13F: var_eax = Err.Raise
  loc_0041D145: 'Referenced from: 0041D13D
  loc_0041D194: var_C8 = var_BC & "vbCrLf" & "TL& = SendMessageLong(" & ecx+edx*4
  loc_0041D1A4: Options.Option4.MousePointer = var_C8
  loc_0041D1FA: var_BC = Options.Option4.MousePointer
  loc_0041D22C: var_C0 = var_BC & "&, WM_GETTEXTLENGTH, 0&, 0&)"
  loc_0041D23C: Options.Option4.MousePointer = var_C0
  loc_0041D284: var_BC = Options.Option4.MousePointer
  loc_0041D2B4: var_C0 = var_BC & "vbCrLf"
  loc_0041D2C2: var_108 = var_C0 & "TheText$ = String$(TL& + 1, "
  loc_0041D37C: var_C4 = CStr(var_C0 & "TheText$ = String$(TL& + 1, " & Chr(34) & &H407BE4 & Chr(34) & &H407DB0)
  loc_0041D38C: Options.Option4.MousePointer = var_C4
  loc_0041D414: var_BC = Options.Option4.MousePointer
  loc_0041D431: var_38 = var_38 + 00000001h
  loc_0041D43A: var_22C = var_38
  loc_0041D445: If var_38 < 1001 Then GoTo loc_0041D44D
  loc_0041D447: var_eax = Err.Raise
  loc_0041D44D: 'Referenced from: 0041D445
  loc_0041D49C: var_C8 = var_BC & "vbCrLf" & "Call SendMessageByString(" & edx+eax*4
  loc_0041D4AC: Options.Option4.MousePointer = var_C8
  loc_0041D502: var_BC = Options.Option4.MousePointer
  loc_0041D534: var_C0 = var_BC & "&, WM_GETTEXT, TL + 1, TheText$)"
  loc_0041D544: Options.Option4.MousePointer = var_C0
  loc_0041D58C: var_BC = Options.Option4.MousePointer
  loc_0041D5EB: var_C8 = var_BC & "vbCrLf" & var_00424098 & " = Left(TheText$, TL&)"
  loc_0041D5FB: Options.Option4.MousePointer = var_C8
  loc_0041D63C: GoTo loc_004212C7
  loc_0041D641: 'Referenced from: 0041D04A
  loc_0041D682: var_214 = Options.Option5.Value
  loc_0041D6A6: setz dl
  loc_0041D6BD: If edx <> 0 Then GoTo loc_004216A0
  loc_0041D704: var_214 = Options.Option6.Value
  loc_0041D728: setz dl
  loc_0041D73F: If edx = 0 Then GoTo loc_0041DA07
  loc_0041D75A: var_BC = Options.Option6.MousePointer
  loc_0041D777: var_38 = var_38 + 00000001h
  loc_0041D780: var_22C = var_38
  loc_0041D78B: If var_38 < 1001 Then GoTo loc_0041D793
  loc_0041D78D: var_eax = Err.Raise
  loc_0041D793: 'Referenced from: 0041D78B
  loc_0041D7E2: var_C8 = var_BC & "vbCrLf" & "PostMessage " & ecx+edx*4
  loc_0041D7F2: Options.Option6.MousePointer = var_C8
  loc_0041D848: var_BC = Options.Option6.MousePointer
  loc_0041D87A: var_C0 = var_BC & "&, &H201, 0&, 0&"
  loc_0041D88A: Options.Option6.MousePointer = var_C0
  loc_0041D8D2: var_BC = Options.Option6.MousePointer
  loc_0041D8EF: var_38 = var_38 + 00000001h
  loc_0041D8F8: var_22C = var_38
  loc_0041D903: If var_38 < 1001 Then GoTo loc_0041D90B
  loc_0041D905: var_eax = Err.Raise
  loc_0041D90B: 'Referenced from: 0041D903
  loc_0041D95A: var_C8 = var_BC & "vbCrLf" & "PostMessage " & edx+eax*4
  loc_0041D96A: Options.Option6.MousePointer = var_C8
  loc_0041D9C0: var_BC = Options.Option6.MousePointer
  loc_0041D9F2: var_C0 = var_BC & "&, &H202, 0&, 0&"
  loc_0041DA02: GoTo loc_0041CDED
  loc_0041DA07: 'Referenced from: 0041D73F
  loc_0041DA48: var_214 = Options.Option7.Value
  loc_0041DA6C: setz al
  loc_0041DA83: If eax = 0 Then GoTo loc_0041DD4A
  loc_0041DA9E: var_BC = Options.Option7.MousePointer
  loc_0041DABB: var_38 = var_38 + 00000001h
  loc_0041DAC4: var_22C = var_38
  loc_0041DACF: If var_38 < 1001 Then GoTo loc_0041DAD7
  loc_0041DAD1: var_eax = Err.Raise
  loc_0041DAD7: 'Referenced from: 0041DACF
  loc_0041DB26: var_C8 = var_BC & "vbCrLf" & "SendMessage " & edx+eax*4
  loc_0041DB36: Options.Option7.MousePointer = var_C8
  loc_0041DB8C: var_BC = Options.Option7.MousePointer
  loc_0041DBBE: var_C0 = var_BC & "&, &H204, 0&, 0&"
  loc_0041DBCE: Options.Option7.MousePointer = var_C0
  loc_0041DC16: var_BC = Options.Option7.MousePointer
  loc_0041DC33: var_38 = var_38 + 00000001h
  loc_0041DC3C: var_22C = var_38
  loc_0041DC47: If var_38 < 1001 Then GoTo loc_0041DC4F
  loc_0041DC49: var_eax = Err.Raise
  loc_0041DC4F: 'Referenced from: 0041DC47
  loc_0041DCAD: Options.Option7.MousePointer = var_BC & "vbCrLf" & "SendMessage " & eax+ecx*4
  loc_0041DD03: var_BC = Options.Option7.MousePointer
  loc_0041DD35: var_C0 = var_BC & "&, &H205, 0&, 0&"
  loc_0041DD45: GoTo loc_0041CA76
  loc_0041DD4A: 'Referenced from: 0041DA83
  loc_0041DD8B: var_214 = Options.Option8.Value
  loc_0041DDAF: setz dl
  loc_0041DDC6: If edx = 0 Then GoTo loc_0041DF49
  loc_0041DDE1: var_BC = Options.Option8.MousePointer
  loc_0041DDFE: var_38 = var_38 + 00000001h
  loc_0041DE07: var_22C = var_38
  loc_0041DE12: If var_38 < 1001 Then GoTo loc_0041DE1A
  loc_0041DE14: var_eax = Err.Raise
  loc_0041DE1A: 'Referenced from: 0041DE12
  loc_0041DE69: var_C8 = var_BC & "vbCrLf" & "SendMessage " & ecx+edx*4
  loc_0041DE79: Options.Option8.MousePointer = var_C8
  loc_0041DECF: var_BC = Options.Option8.MousePointer
  loc_0041DF01: var_C0 = var_BC & "&, &H203, 0&, 0&"
  loc_0041DF11: Options.Option8.MousePointer = var_C0
  loc_0041DF44: GoTo loc_004212C7
  loc_0041DF49: 'Referenced from: 0041DDC6
  loc_0041DF8A: var_214 = Options.Option9.Value
  loc_0041DFAE: setz dl
  loc_0041DFC5: If edx = 0 Then GoTo loc_0041E115
  loc_0041DFE0: var_BC = Options.Option9.MousePointer
  loc_0041DFFD: var_38 = var_38 + 00000001h
  loc_0041E006: var_22C = var_38
  loc_0041E011: If var_38 < 1001 Then GoTo loc_0041E019
  loc_0041E013: var_eax = Err.Raise
  loc_0041E019: 'Referenced from: 0041E011
  loc_0041E068: var_C8 = var_BC & "vbCrLf" & "EnableWindow " & ecx+edx*4
  loc_0041E078: Options.Option9.MousePointer = var_C8
  loc_0041E0CE: var_BC = Options.Option9.MousePointer
  loc_0041E100: var_C0 = var_BC & "&, 1"
  loc_0041E110: GoTo loc_0041DF11
  loc_0041E115: 'Referenced from: 0041DFC5
  loc_0041E156: var_214 = Options.Option10.Value
  loc_0041E17A: setz dl
  loc_0041E191: If edx = 0 Then GoTo loc_0041E2E1
  loc_0041E1AC: var_BC = Options.Option10.MousePointer
  loc_0041E1C9: var_38 = var_38 + 00000001h
  loc_0041E1D2: var_22C = var_38
  loc_0041E1DD: If var_38 < 1001 Then GoTo loc_0041E1E5
  loc_0041E1DF: var_eax = Err.Raise
  loc_0041E1E5: 'Referenced from: 0041E1DD
  loc_0041E234: var_C8 = var_BC & "vbCrLf" & "EnableWindow " & ecx+edx*4
  loc_0041E244: Options.Option10.MousePointer = var_C8
  loc_0041E29A: var_BC = Options.Option10.MousePointer
  loc_0041E2CC: var_C0 = var_BC & "&, 0"
  loc_0041E2DC: GoTo loc_0041DF11
  loc_0041E2E1: 'Referenced from: 0041E191
  loc_0041E322: var_214 = Options.Option11.Value
  loc_0041E346: setz dl
  loc_0041E35D: If edx = 0 Then GoTo loc_0041E4AD
  loc_0041E378: var_BC = Options.Option11.MousePointer
  loc_0041E395: var_38 = var_38 + 00000001h
  loc_0041E39E: var_22C = var_38
  loc_0041E3A9: If var_38 < 1001 Then GoTo loc_0041E3B1
  loc_0041E3AB: var_eax = Err.Raise
  loc_0041E3B1: 'Referenced from: 0041E3A9
  loc_0041E400: var_C8 = var_BC & "vbCrLf" & "ShowWindow " & ecx+edx*4
  loc_0041E410: Options.Option11.MousePointer = var_C8
  loc_0041E466: var_BC = Options.Option11.MousePointer
  loc_0041E498: var_C0 = var_BC & "&, 1"
  loc_0041E4A8: GoTo loc_0041DF11
  loc_0041E4AD: 'Referenced from: 0041E35D
  loc_0041E4EE: var_214 = Options.Option12.Value
  loc_0041E512: setz dl
  loc_0041E529: If edx = 0 Then GoTo loc_0041E679
  loc_0041E544: var_BC = Options.Option12.MousePointer
  loc_0041E561: var_38 = var_38 + 00000001h
  loc_0041E56A: var_22C = var_38
  loc_0041E575: If var_38 < 1001 Then GoTo loc_0041E57D
  loc_0041E577: var_eax = Err.Raise
  loc_0041E57D: 'Referenced from: 0041E575
  loc_0041E5CC: var_C8 = var_BC & "vbCrLf" & "ShowWindow " & ecx+edx*4
  loc_0041E5DC: Options.Option12.MousePointer = var_C8
  loc_0041E632: var_BC = Options.Option12.MousePointer
  loc_0041E664: var_C0 = var_BC & "&, 0"
  loc_0041E674: GoTo loc_0041DF11
  loc_0041E679: 'Referenced from: 0041E529
  loc_0041E6BA: var_214 = Options.Option13.Value
  loc_0041E6DE: setz dl
  loc_0041E6F5: If edx = 0 Then GoTo loc_0041E845
  loc_0041E710: var_BC = Options.Option13.MousePointer
  loc_0041E72D: var_38 = var_38 + 00000001h
  loc_0041E736: var_22C = var_38
  loc_0041E741: If var_38 < 1001 Then GoTo loc_0041E749
  loc_0041E743: var_eax = Err.Raise
  loc_0041E749: 'Referenced from: 0041E741
  loc_0041E798: var_C8 = var_BC & "vbCrLf" & "SendMessage " & ecx+edx*4
  loc_0041E7A8: Options.Option13.MousePointer = var_C8
  loc_0041E7FE: var_BC = Options.Option13.MousePointer
  loc_0041E830: var_C0 = var_BC & "&, &H10, 0&, 0&"
  loc_0041E840: GoTo loc_0041DF11
  loc_0041E845: 'Referenced from: 0041E6F5
  loc_0041E886: var_214 = Options.Option14.Value
  loc_0041E8AA: setz dl
  loc_0041E8C6: If edx = 0 Then GoTo loc_0041EFBF
  loc_0041E908: var_214 = Options.Check1.Value
  loc_0041E92C: setz dl
  loc_0041E943: If edx = 0 Then GoTo loc_0041EAFB
  loc_0041E95E: var_BC = Options.Check1.MousePointer
  loc_0041E97B: var_38 = var_38 + 00000001h
  loc_0041E984: var_22C = var_38
  loc_0041E98F: If var_38 < 1001 Then GoTo loc_0041E997
  loc_0041E991: var_eax = Err.Raise
  loc_0041E997: 'Referenced from: 0041E98F
  loc_0041EA12: var_D0 = var_BC & "vbCrLf" & "Dim Count as long" & "vbCrLf" & " Count& = SendMessageLong(" & ecx+edx*4
  loc_0041EA22: Options.Check1.MousePointer = var_D0
  loc_0041EA86: var_BC = Options.Check1.MousePointer
  loc_0041EAC8: Options.Check1.MousePointer = var_BC & "&, &H18B, 0&, 0&)"
  loc_0041EAFB: 'Referenced from: 0041E943
  loc_0041EB3C: var_214 = Options.Check2.Value
  loc_0041EB60: setz dl
  loc_0041EB77: If edx = 0 Then GoTo loc_0041EDB9
  loc_0041EB92: var_BC = Options.Check2.MousePointer
  loc_0041EC06: var_CC = var_BC & "vbCrLf" & "Dim Text as String, Index as long" & "vbCrLf" & "TheText$ = String$(255, 0)"
  loc_0041EC16: Options.Check2.MousePointer = var_CC
  loc_0041EC73: var_BC = Options.Check2.MousePointer
  loc_0041EC90: var_38 = var_38 + 00000001h
  loc_0041EC99: var_22C = var_38
  loc_0041ECA4: If var_38 < 1001 Then GoTo loc_0041ECAC
  loc_0041ECA6: var_eax = Err.Raise
  loc_0041ECAC: 'Referenced from: 0041ECA4
  loc_0041ECE5: var_C4 = var_BC & "Call SendMessageByString(" & edx+eax*4
  loc_0041ECF5: Options.Check2.MousePointer = var_C4
  loc_0041ED44: var_BC = Options.Check2.MousePointer
  loc_0041ED76: var_C0 = var_BC & "&, &H189, Index&, Text$)"
  loc_0041ED86: Options.Check2.MousePointer = var_C0
  loc_0041EDB9: 'Referenced from: 0041EB77
  loc_0041EDFA: var_214 = Options.Check3.Value
  loc_0041EE1E: setz dl
  loc_0041EE35: If edx = 0 Then GoTo loc_004212C7
  loc_0041EE50: var_BC = Options.Check3.MousePointer
  loc_0041EE6D: var_38 = var_38 + 00000001h
  loc_0041EE76: var_22C = var_38
  loc_0041EE81: If var_38 < 1001 Then GoTo loc_0041EE89
  loc_0041EE83: var_eax = Err.Raise
  loc_0041EE89: 'Referenced from: 0041EE81
  loc_0041EF04: var_D0 = var_BC & "vbCrLf" & "Dim Index as long" & "vbCrLf" & "SendMessageLong " & ecx+edx*4
  loc_0041EF14: Options.Check3.MousePointer = var_D0
  loc_0041EF78: var_BC = Options.Check3.MousePointer
  loc_0041EFAA: var_C0 = var_BC & "&, &H186, 0, 0&"
  loc_0041EFBA: GoTo loc_0041CA76
  loc_0041EFBF: 'Referenced from: 0041E8C6
  loc_0041EFFB: var_214 = Options.Option15.Value
  loc_0041F01F: setz dl
  loc_0041F036: If edx = 0 Then GoTo loc_0041F186
  loc_0041F051: var_BC = Options.Option15.MousePointer
  loc_0041F06E: var_38 = var_38 + 00000001h
  loc_0041F077: var_22C = var_38
  loc_0041F082: If var_38 < 1001 Then GoTo loc_0041F08A
  loc_0041F084: var_eax = Err.Raise
  loc_0041F08A: 'Referenced from: 0041F082
  loc_0041F0D9: var_C8 = var_BC & "vbCrLf" & "SendMessageLong " & ecx+edx*4
  loc_0041F0E9: Options.Option15.MousePointer = var_C8
  loc_0041F13F: var_BC = Options.Option15.MousePointer
  loc_0041F171: var_C0 = var_BC & "&, BM_SETCHECK, True, 0&"
  loc_0041F181: GoTo loc_0041DF11
  loc_0041F186: 'Referenced from: 0041F036
  loc_0041F1C7: var_214 = Options.Option16.Value
  loc_0041F1EB: setz dl
  loc_0041F202: If edx = 0 Then GoTo loc_0041F352
  loc_0041F21D: var_BC = Options.Option16.MousePointer
  loc_0041F23A: var_38 = var_38 + 00000001h
  loc_0041F243: var_22C = var_38
  loc_0041F24E: If var_38 < 1001 Then GoTo loc_0041F256
  loc_0041F250: var_eax = Err.Raise
  loc_0041F256: 'Referenced from: 0041F24E
  loc_0041F2A5: var_C8 = var_BC & "vbCrLf" & "SendMessageLong " & ecx+edx*4
  loc_0041F2B5: Options.Option16.MousePointer = var_C8
  loc_0041F30B: var_BC = Options.Option16.MousePointer
  loc_0041F33D: var_C0 = var_BC & "&, BM_SETCHECK, False, 0&"
  loc_0041F34D: GoTo loc_0041DF11
  loc_0041F352: 'Referenced from: 0041F202
  loc_0041F393: var_214 = Options.Option17.Value
  loc_0041F3B7: setz dl
  loc_0041F3CE: If edx = 0 Then GoTo loc_0041F696
  loc_0041F3E9: var_BC = Options.Option17.MousePointer
  loc_0041F406: var_38 = var_38 + 00000001h
  loc_0041F40F: var_22C = var_38
  loc_0041F41A: If var_38 < 1001 Then GoTo loc_0041F422
  loc_0041F41C: var_eax = Err.Raise
  loc_0041F422: 'Referenced from: 0041F41A
  loc_0041F471: var_C8 = var_BC & "vbCrLf" & "PostMessage " & ecx+edx*4
  loc_0041F481: Options.Option17.MousePointer = var_C8
  loc_0041F4D7: var_BC = Options.Option17.MousePointer
  loc_0041F509: var_C0 = var_BC & "&, WM_LBUTTONDOWN, 0&, 0&)"
  loc_0041F519: Options.Option17.MousePointer = var_C0
  loc_0041F561: var_BC = Options.Option17.MousePointer
  loc_0041F57E: var_38 = var_38 + 00000001h
  loc_0041F587: var_22C = var_38
  loc_0041F592: If var_38 < 1001 Then GoTo loc_0041F59A
  loc_0041F594: var_eax = Err.Raise
  loc_0041F59A: 'Referenced from: 0041F592
  loc_0041F5E9: var_C8 = var_BC & "vbCrLf" & "PostMessage " & edx+eax*4
  loc_0041F5F9: Options.Option17.MousePointer = var_C8
  loc_0041F64F: var_BC = Options.Option17.MousePointer
  loc_0041F681: var_C0 = var_BC & "&, WM_LBUTTONUP, 0&, 0&"
  loc_0041F691: GoTo loc_0041CDED
  loc_0041F696: 'Referenced from: 0041F3CE
  loc_0041F6D7: var_214 = Options.Option18.Value
  loc_0041F6FB: setz al
  loc_0041F712: If eax = 0 Then GoTo loc_0041F895
  loc_0041F72D: var_BC = Options.Option18.MousePointer
  loc_0041F74A: var_38 = var_38 + 00000001h
  loc_0041F753: var_22C = var_38
  loc_0041F75E: If var_38 < 1001 Then GoTo loc_0041F766
  loc_0041F760: var_eax = Err.Raise
  loc_0041F766: 'Referenced from: 0041F75E
  loc_0041F7B5: var_C8 = var_BC & "vbCrLf" & "SendMessageLong " & edx+eax*4
  loc_0041F7C5: Options.Option18.MousePointer = var_C8
  loc_0041F81B: var_BC = Options.Option18.MousePointer
  loc_0041F84D: var_C0 = var_BC & "&, WM_CHAR, 13, 0&"
  loc_0041F85D: Options.Option18.MousePointer = var_C0
  loc_0041F867: If var_C0 >= 0 Then GoTo loc_0041F877
  loc_0041F869: 'Referenced from: 0041CDFD
  loc_0041F875: var_C0 = CheckObj(var_2C4, var_00406B74, 164)
  loc_0041F877: 'Referenced from: 0041CDF7
  loc_0041F890: GoTo loc_004212C7
  loc_0041F895: 'Referenced from: 0041F712
  loc_0041F8D6: var_214 = Options.Option19.Value
  loc_0041F8FA: setz al
  loc_0041F911: If eax = 0 Then GoTo loc_004212C7
  loc_0041F926: var_eax = FindWindowEx(4341812, 0, 0, 0)
  loc_0041F93D: var_88 = FindWindowEx(4341812, 0, 0, 0)
  loc_0041F948: 
  loc_0041F94A: If var_218 = 0 Then GoTo loc_0041FD7F
  loc_0041F953: If esi = 9 Then GoTo loc_0041FD7F
  loc_0041F95E: var_2C4 = eax
  loc_0041F96E: var_BC = Options.Option19.MousePointer
  loc_0041F9B0: var_428 = edx
  loc_0041F9F5: Options.Option19.MousePointer = var_BC & "vbCrLf" & ecx+esi*4
  loc_0041FA36: var_eax = call Proc_3_3_414DC0(var_88, , )
  loc_0041FA40: var_3C = call Proc_3_3_414DC0(var_88, , )
  loc_0041FA51: var_BC = Options.Option19.MousePointer
  loc_0041FA87: var_C0 = var_BC & "& = FindWindowEx("
  loc_0041FAA4: var_C4 = var_C0 & 4341868
  loc_0041FAAC: Options.Option19.MousePointer = var_C4
  loc_0041FAF5: var_BC = Options.Option19.MousePointer
  loc_0041FB21: var_108 = var_BC & "&, 0&, "
  loc_0041FB3A: var_100 = Chr(34)
  loc_0041FB65: var_C0 = CStr(var_BC & "&, 0&, " & var_100)
  loc_0041FB6D: Options.Option19.MousePointer = var_C0
  loc_0041FBCC: var_BC = Options.Option19.MousePointer
  loc_0041FC01: var_C0 = var_BC & var_3C
  loc_0041FC09: Options.Option19.MousePointer = var_C0
  loc_0041FC4B: var_BC = Options.Option19.MousePointer
  loc_0041FC75: var_108 = var_BC
  loc_0041FC95: var_1A8 = ", vbNullString)"
  loc_0041FCDF: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  loc_0041FCE7: Options.Option19.MousePointer = var_C0
  loc_0041FD37: var_30 = var_30 + 00000001h
  loc_0041FD40: var_30 = var_30
  loc_0041FD57: var_eax = FindWindowEx(4341812, var_88, 0, 0)
  loc_0041FD6E: var_88 = FindWindowEx(4341812, var_88, 0, 0)
  loc_0041FD7A: GoTo loc_0041F948
  loc_0041FD7F: 'Referenced from: 0041F94A
  loc_0041FD7F: var_30 = var_30 - 00000001h
  loc_0041FD88: var_30 = var_30
  loc_0041FDA0: var_BC = Options.Option19.MousePointer
  loc_0041FDE8: var_C4 = var_BC & "vbCrLf" & "If "
  loc_0041FDF8: Options.Option19.MousePointer = var_C4
  loc_0041FE47: var_BC = Options.Option19.MousePointer
  loc_0041FE90: var_C0 = var_BC & ecx+edx*4
  loc_0041FEA0: Options.Option19.MousePointer = var_C0
  loc_0041FEE8: var_BC = Options.Option19.MousePointer
  loc_0041FF1A: var_C0 = var_BC & " <> 0"
  loc_0041FF2A: Options.Option19.MousePointer = var_C0
  loc_0041FF60: var_30 = var_30 - 00000001h
  loc_0041FF69: var_30 = var_30
  loc_0041FF6C: 
  loc_0041FF71: If var_30 <= 0 Then GoTo loc_004200EC
  loc_0041FF89: var_BC = Options.Option19.MousePointer
  loc_0041FFCB: var_438 = edx
  loc_00420010: Options.Option19.MousePointer = var_BC & " And " & ecx+esi*4
  loc_00420059: var_BC = Options.Option19.MousePointer
  loc_00420081: var_43C = ecx
  loc_00420091: var_C0 = var_BC & " <> 0"
  loc_0042009F: Options.Option19.MousePointer = var_C0
  loc_004200D5: var_30 = var_30 - 00000001h
  loc_004200DE: var_30 = var_30
  loc_004200E7: GoTo loc_0041FF6C
  loc_004200EC: 'Referenced from: 0041FF71
  loc_004200EE: var_2C4 = var_43C
  loc_004200FE: var_BC = Options.Option19.MousePointer
  loc_0042019D: Options.Option19.MousePointer = var_BC & "Then" & "vbCrLf" & var_00424098 & "& = " & 4341868
  loc_00420201: var_BC = Options.Option19.MousePointer
  loc_00420249: var_C4 = var_BC & var_004085F8 & "vbCrLf"
  loc_00420259: Options.Option19.MousePointer = var_C4
  loc_004202A8: var_BC = Options.Option19.MousePointer
  loc_0042035C: Options.Option19.MousePointer = var_BC & "Exit Function" & "vbCrLf" & "Else" & "vbCrLf" & "Do Until " & 4341868
  loc_004203C7: var_BC = Options.Option19.MousePointer
  loc_0042041F: Options.Option19.MousePointer = var_BC & "& = 0&" & "vbCrLf"
  loc_0042046E: var_BC = Options.Option19.MousePointer
  loc_004204A4: var_C0 = var_BC & 4341868
  loc_004204B4: Options.Option19.MousePointer = var_C0
  loc_004204FC: var_BC = Options.Option19.MousePointer
  loc_00420549: var_C4 = var_BC & " = FindWindowEx(" & edx+00000004h
  loc_00420559: Options.Option19.MousePointer = var_C4
  loc_004205A8: var_BC = Options.Option19.MousePointer
  loc_004205F3: var_C4 = var_BC & "&, " & 4341868
  loc_00420603: Options.Option19.MousePointer = var_C4
  loc_00420652: var_BC = Options.Option19.MousePointer
  loc_0042067A: var_108 = var_BC & "&, "
  loc_004206EB: var_C0 = CStr(var_BC & "&, " & Chr(34) & &H424050)
  loc_004206FB: Options.Option19.MousePointer = var_C0
  loc_00420767: var_BC = Options.Option19.MousePointer
  loc_00420791: var_108 = var_BC
  loc_004207B0: var_1A8 = ", vbNullString)"
  loc_0042080E: Options.Option19.MousePointer = CStr(var_BC & Chr(34) & ", vbNullString)")
  loc_0042086A: var_eax = FindWindowEx(4341812, 0, 0, 0)
  loc_00420881: var_88 = FindWindowEx(4341812, 0, 0, 0)
  loc_0042088C: 
  loc_0042088E: If var_218 = 0 Then GoTo loc_00420CC3
  loc_00420897: If esi = 9 Then GoTo loc_00420CC3
  loc_004208B2: var_BC = Options.Option19.MousePointer
  loc_004208F4: var_464 = var_2C4
  loc_00420929: var_C4 = var_BC & "vbCrLf" & edx+esi*4
  loc_00420939: Options.Option19.MousePointer = var_C4
  loc_0042097A: var_eax = call Proc_3_3_414DC0(var_88, , )
  loc_00420984: var_3C = call Proc_3_3_414DC0(var_88, , )
  loc_00420995: var_BC = Options.Option19.MousePointer
  loc_004209E9: var_C4 = var_BC & "& = FindWindowEx(" & 4341868
  loc_004209F1: Options.Option19.MousePointer = var_C4
  loc_00420A3A: var_BC = Options.Option19.MousePointer
  loc_00420A66: var_108 = var_BC & "&, 0&, "
  loc_00420AAA: var_C0 = CStr(var_BC & "&, 0&, " & Chr(34))
  loc_00420AB2: Options.Option19.MousePointer = var_C0
  loc_00420B11: var_BC = Options.Option19.MousePointer
  loc_00420B46: var_C0 = var_BC & var_3C
  loc_00420B4E: Options.Option19.MousePointer = var_C0
  loc_00420B90: var_BC = Options.Option19.MousePointer
  loc_00420BBA: var_108 = var_BC
  loc_00420BDA: var_1A8 = ", vbNullString)"
  loc_00420C24: var_C0 = CStr(var_BC & Chr(34) & ", vbNullString)")
  loc_00420C2C: Options.Option19.MousePointer = var_C0
  loc_00420C7C: var_30 = var_30 + 00000001h
  loc_00420C85: var_30 = var_30
  loc_00420C9B: var_eax = FindWindowEx(4341812, var_88, 0, 0)
  loc_00420CA0: var_218 = FindWindowEx(4341812, var_88, 0, 0)
  loc_00420CB2: var_88 = var_218
  loc_00420CBE: GoTo loc_0042088C
  loc_00420CC3: 'Referenced from: 0042088E
  loc_00420CC3: var_30 = var_30 - 00000001h
  loc_00420CCC: var_30 = var_30
  loc_00420CE4: var_BC = Options.Option19.MousePointer
  loc_00420D3C: Options.Option19.MousePointer = var_BC & "vbCrLf" & "If "
  loc_00420D8B: var_BC = Options.Option19.MousePointer
  loc_00420DD4: var_C0 = var_BC & edx+eax*4
  loc_00420DE4: Options.Option19.MousePointer = var_C0
  loc_00420E2C: var_BC = Options.Option19.MousePointer
  loc_00420E6E: Options.Option19.MousePointer = var_BC & " <> 0"
  loc_00420EA4: var_30 = var_30 - 00000001h
  loc_00420EAD: var_30 = var_30
  loc_00420EB0: 
  loc_00420EB2: If var_30 <= 0 Then GoTo loc_00421018
  loc_00420ECD: var_BC = Options.Option19.MousePointer
  loc_00420F2C: var_C4 = var_BC & " And " & ecx+edx*4
  loc_00420F3C: Options.Option19.MousePointer = var_C4
  loc_00420F85: var_BC = Options.Option19.MousePointer
  loc_00420FAD: var_478 = edx
  loc_00420FBD: var_C0 = var_BC & " <> 0"
  loc_00420FCB: Options.Option19.MousePointer = var_C0
  loc_00421001: var_30 = var_30 - 00000001h
  loc_0042100A: var_30 = var_30
  loc_00421013: GoTo loc_00420EB0
  loc_00421018: 'Referenced from: 00420EB2
  loc_0042102D: var_BC = Options.Option19.MousePointer
  loc_004210BC: var_D0 = var_BC & "Then" & "vbCrLf" & var_00424098 & "& = " & 4341868
  loc_004210CC: Options.Option19.MousePointer = var_D0
  loc_00421130: var_BC = Options.Option19.MousePointer
  loc_004211A4: var_CC = var_BC & var_004085F8 & "vbCrLf" & "Exit Function" & "vbCrLf"
  loc_004211FC: var_DC = var_CC & "End If" & "vbCrLf" & "Loop" & "vbCrLf"
  loc_0042123E: var_E8 = var_DC & "End If" & "vbCrLf" & "End Function"
  loc_0042124E: Options.Option19.MousePointer = var_E8
  loc_004212C7: 'Referenced from: 0041CAA9
  loc_00421308: var_214 = Options.Option4.Value
  loc_0042132C: setz al
  loc_00421343: If eax = 0 Then GoTo loc_00421400
  loc_0042135E: var_BC = Options.Option4.MousePointer
  loc_004213A6: var_C4 = var_BC & "vbCrLf" & "End Function"
  loc_004213B6: Options.Option4.MousePointer = var_C4
  loc_004213F0: Exit Sub
  loc_004213FB: GoTo loc_0042177E
  loc_00421400: 'Referenced from: 00421343
  loc_00421441: var_214 = Options.Option19.Value
  loc_00421465: setz dl
  loc_0042147C: If edx <> 0 Then GoTo loc_004216A0
  loc_00421497: var_BC = Options.Option19.MousePointer
  loc_004214C9: var_C0 = var_BC & "vbCrLf"
  loc_004214DF: var_C4 = var_C0 & "End Sub"
  loc_004214EF: Options.Option19.MousePointer = var_C4
  loc_00421529: Exit Sub
  loc_00421534: GoTo loc_0042177E
  loc_0042158B: var_eax = Unknown_VTable_Call[eax+0000001Ch]
  loc_004215BB: var_eax = Unknown_VTable_Call[eax+0000002Ch]
  loc_00421612: var_F8 = CStr(var_218) & ", " & var_C0
  loc_004216A0: 'Referenced from: 0041C732
  loc_004216A0: Exit Sub
  loc_004216AB: GoTo loc_0042177E
  loc_0042177D: Exit Sub
  loc_0042177E: 'Referenced from: 004213FB
  loc_004217D9: Exit Sub
End Sub
