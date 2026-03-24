ï»¿Private Sub Command2_Click() '5BC690
  Dim var_2C As CommonDialog
  Dim var_DC As CommonDialog
  Dim Me As CommonDialog
  Dim var_B8 As Variant
  loc_005BC6F5: On Error Resume Next
  loc_005BC702: var_74 = vbNullString
  loc_005BC750: edx = CommonDialog._Action
  loc_005BC7B4: var_2C = var_2C._Action
  loc_005BC7CA: var_74 = "Select a DLL or EXE which includes Icons"
  loc_005BC818: Me = CommonDialog._Action
  loc_005BC82E: var_74 = "Icon Resources (*.ico;*.exe;*.dll)|*.ico;*.exe;*.dll|All Files|*.*"
  loc_005BC87C: edx = CommonDialog._Action
  loc_005BC8E0: var_2C = var_2C._Action
  loc_005BC8FC: var_34 = Err
  loc_005BC910: var_B8 = CBool(Err)
  loc_005BC929: If var_B8 = 0 Then GoTo loc_005BC969
  loc_005BC943: var_DC = var_2C
  loc_005BC958: var_2C.InitDir = var_2C
  loc_005BC964: GoTo loc_005BCF4D
  loc_005BC969: 'Referenced from: 005BC929
  loc_005BC993: var_3C = Me._Action
  loc_005BC9AA: ecx = Me
  loc_005BC9CF: var_eax = DestroyIcon(var_0060C024)
  loc_005BC9DA: 
  loc_005BCA31: var_2C = Global.App
  loc_005BCA36: var_BC = var_2C
  loc_005BCA91: var_B0 = Global.hInstance
  loc_005BCA99: var_C4 = var_B0
  loc_005BCAE8: var_ret_1 = var_0060C028
  loc_005BCAF6: var_eax = ExtractIcon(var_B0, var_ret_1, var_24)
  loc_005BCB10: var_ret_2 = var_28
  loc_005BCB1C: var_60C024 = ExtractIcon(var_B0, var_ret_1, var_24)
  loc_005BCB41: If var_60C024 <> 0 Then GoTo loc_005BCB45
  loc_005BCB43: GoTo loc_005BCB7C
  loc_005BCB45: 'Referenced from: 005BCB41
  loc_005BCB50: var_24 = var_24 + 0001h
  loc_005BCB5A: var_24 = var_24
  loc_005BCB6C: var_eax = DestroyIcon(var_0060C024)
  loc_005BCB77: GoTo loc_005BC9DA
  loc_005BCB7C: 'Referenced from: 005BCB43
  loc_005BCB89: If var_24 <> 0 Then GoTo loc_005BCC22
  loc_005BCBCF: var_4C = "bodini by: spek"
  loc_005BCBE9: var_3C = "There are no icons in this file."
  loc_005BCC22: 'Referenced from: 005BCB89
  loc_005BCC4D: var_A4 = var_24
  loc_005BCCAB: setz dl
  loc_005BCCEB: var_28 = CStr(var_24 & IIf(False, " image", " images"))
  loc_005BCD01: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005BCD06: var_BC = Unknown_VTable_Call[eax+00000054h]
  loc_005BCD94: var_B8 = var_2C
  loc_005BCD9E: var_24 = var_24 - 0001h
  loc_005BCDA8: var_44 = var_24
  loc_005BCDC8: setz dl
  loc_005BCDE8: var_5C = IIf(False, 0, var_24)
  loc_005BCE08: VScroll1.Max = CInt(var_2C)
  loc_005BCE10: var_BC = var_B8
  loc_005BCE94: var_B8 = var_2C
  loc_005BCEAB: VScroll1.Value = 0
  loc_005BCEB3: var_BC = var_B8
  loc_005BCF0B: var_eax = Call iextract.VScroll1_Change
  loc_005BCF11: var_B8 = Call iextract.VScroll1_Change
  loc_005BCF59: GoTo loc_005BCF89
  loc_005BCF88: Exit Sub
  loc_005BCF89: 'Referenced from: 005BCF59
  loc_005BCF89: Exit Sub
End Sub