Private Sub Number_Click() '5B6540
  Dim var_28 As CommandButton
  Dim var_17C As CommandButton
  Dim var_174 As CommandButton
  loc_005B661F: If (%x1 = Me.hWnd = "NUMS") = 0 Then GoTo loc_005B66E3
  loc_005B668E: var_18 = CStr(Format("", &H42DCAC))
  loc_005B669E: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B66E3: 'Referenced from: 005B661F
  loc_005B66F0: If esi+00000054h = 0 Then GoTo loc_005B6821
  loc_005B6706: var_17C = var_30
  loc_005B6726: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005B6764: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_005B6788: var_18 = Number.Caption
  loc_005B67BB: var_20 = var_1C & var_18
  loc_005B67C1: var_198 = var_20
  loc_005B67D5: Number.Caption = var_20
  loc_005B681C: GoTo loc_005B6AAB
  loc_005B682C: call var_17C(var_30, var_28, var_30, Me)
  loc_005B683C: call var_17C(var_2C, var_17C(var_30, var_28, var_30, Me), Me)
  loc_005B683E: var_174 = var_17C(var_2C, var_17C(var_30, var_28, var_30, Me), Me)
  loc_005B6894: var_60 = Format("", &H42DCAC)
  loc_005B68A5: var_98 = var_30
  loc_005B68D3: call InStr(var_80, edi, var_60, var_70, 00000001h, 00000001h, 00000001h, Me)
  loc_005B6904: var_B0 = Left(var_30, CLng(InStr(var_80, edi, var_60, var_70, 00000001h, 00000001h, 00000001h, Me) - 1))
  loc_005B6918: call var_17C(var_24, var_B0, Me)
  loc_005B692A: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_005B694E: var_18 = Number.Caption
  loc_005B696F: var_B8 = var_18
  loc_005B6A0B: var_1C = CStr(var_B0 + var_18 + Format("", &H42DCAC))
  loc_005B6A1B: Number.Caption = var_1C
  loc_005B6AAB: 'Referenced from: 005B681C
  loc_005B6AD9: If (%x1 = Number.Index = "NEG") = 0 Then GoTo loc_005B6B89
  loc_005B6B12: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005B6B40: var_1C = var_00431364 & var_18
  loc_005B6B48: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B6B89: 'Referenced from: 005B6AD9
  loc_005B6BA5: var_1A0 = "NUMS"
  loc_005B6BB3: GoTo loc_005B6C43
  loc_005B6C42: Exit Sub
  loc_005B6C43: 'Referenced from: 005B6BB3
End Sub