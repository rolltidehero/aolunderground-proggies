ï»¿Private Sub Operator_Click() '5B6C70
  Dim var_C8 As Label
  Dim var_20 As Variant
  Dim var_34 As CommandButton
  loc_005B6CFB: ecx = Me
  loc_005B6D18: var_6C = "NUMS"
  loc_005B6D2B: If (esi+00000058h = "NUMS") = 0 Then GoTo loc_005B6D3F
  loc_005B6D31: esi+00000056h = esi+00000056h + 0001h
  loc_005B6D3F: 'Referenced from: 005B6D2B
  loc_005B6D43: esi+00000056h = esi+00000056h - edi
  loc_005B6D45: If esi+00000056h = 0 Then GoTo loc_005B72B9
  loc_005B6D4B: eax = esi+00000056h - 1
  loc_005B6D4C: If esi+00000056h - 1 = 0 Then GoTo loc_005B7115
  loc_005B6D52: eax = esi+00000056h - 1 - 1
  loc_005B6D53: If esi+00000056h - 1 - 1 <> 0 Then GoTo loc_005B702B
  loc_005B6D61: ecx = esi+00000078h
  loc_005B6D70: var_C8 = esi+00000068h
  loc_005B6D94: If (var_C8 = &H42E970) = 0 Then GoTo loc_005B6DB8
  loc_005B6D9A: call __vbaR8ErrVar(%x1 = Readout.Standing, Me, %x1 = Readout.Standing)
  loc_005B6DA7: call __vbaR8ErrVar(Readout.Font = %StkVar1)
  loc_005B6DB3: GoTo loc_005B6FB2
  loc_005B6DB8: 'Referenced from: 005B6D94
  loc_005B6DD1: var_74 = Readout.Standing
  loc_005B6DD6: If var_74 = 0 Then GoTo loc_005B6DFA
  loc_005B6DDC: call __vbaR8ErrVar(%x1 = Readout.Standing)
  loc_005B6DE9: call __vbaR8ErrVar(Readout.Font = %StkVar1)
  loc_005B6DEF: fsubr st0, real8 ptr var_E8
  loc_005B6DF5: GoTo loc_005B6FB2
  loc_005B6DFA: 'Referenced from: 005B6DD6
  loc_005B6E13: var_74 = Readout.Standing
  loc_005B6E18: If var_74 = 0 Then GoTo loc_005B6E3C
  loc_005B6E1E: call __vbaR8ErrVar(%x1 = Readout.Standing)
  loc_005B6E2B: call __vbaR8ErrVar(Readout.Font = %StkVar1)
  loc_005B6E37: GoTo loc_005B6FB2
  loc_005B6E3C: 'Referenced from: 005B6E18
  loc_005B6E55: var_74 = Readout.Standing
  loc_005B6E5A: If var_74 = 0 Then GoTo loc_005B6F3C
  loc_005B6E73: var_74 = Readout.Standing
  loc_005B6E78: If var_74 = 0 Then GoTo loc_005B6F01
  loc_005B6EB5: var_44 = "Justins Calculator"
  loc_005B6EC7: var_34 = "Can't divide by zero"
  loc_005B6EFC: GoTo loc_005B6FD1
  loc_005B6F01: 'Referenced from: 005B6E78
  loc_005B6F05: call __vbaR8ErrVar(%x1 = Readout.Standing, var_C8)
  loc_005B6F12: call __vbaR8ErrVar(%ecx = %S_edx_S)
  loc_005B6F1F: If var_60C000 <> 0 Then GoTo loc_005B6F29
  loc_005B6F21: fdivr st0, real8 ptr var_F8
  loc_005B6F27: GoTo loc_005B6F3A
  loc_005B6F29: 'Referenced from: 005B6F1F
  loc_005B6F3A: 'Referenced from: 005B6F27
  loc_005B6F3A: GoTo loc_005B6FB2
  loc_005B6F3C: 'Referenced from: 005B6E5A
  loc_005B6F55: var_74 = Readout.Standing
  loc_005B6F5A: If var_74 = 0 Then GoTo loc_005B6F75
  loc_005B6F5D: call __vbaR8ErrVar(%ecx = %S_edx_S, var_C8, var_F8, var_F4)
  loc_005B6F73: GoTo loc_005B6FCB
  loc_005B6F75: 'Referenced from: 005B6F5A
  loc_005B6F8E: var_74 = Readout.Standing
  loc_005B6F93: If var_74 = 0 Then GoTo loc_005B6FD1
  loc_005B6F99: call __vbaR8ErrVar(%x1 = Readout.Standing)
  loc_005B6FA6: call __vbaR8ErrVar(%ecx = %S_edx_S)
  loc_005B6FB2: 'Referenced from: 005B6DB3
  loc_005B6FCB: 'Referenced from: 005B6F73
  loc_005B6FCB: ecx = __vbaR8ErrVar(ecx = %S_edx_S)
  loc_005B6FD1: 'Referenced from: 005B6EFC
  loc_005B6FF1: var_18 = CStr(%x1 = Readout.Standing)
  loc_005B6FF9: var_eax = Unknown_VTable_Call[ebx+00000054h]
  loc_005B702B: 'Referenced from: 005B6D53
  loc_005B704A: If (esi+00000058h = "NEG") = 0 Then GoTo loc_005B7107
  loc_005B7063: ecx = "OPS"
  loc_005B708D: var_eax = Unknown_VTable_Call[ecx+00000040h]
  loc_005B70B1: var_18 = Operator.Caption
  loc_005B70E3: ecx = var_18
  loc_005B7107: 'Referenced from: 005B704A
  loc_005B7110: GoTo loc_005B74B8
  loc_005B7115: 'Referenced from: 005B6D4C
  loc_005B712E: ecx = Me
  loc_005B7161: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_005B7185: var_18 = Operator.Caption
  loc_005B71B6: eax = (var_18 = var_00431364) + 1
  loc_005B71BC: var_7C = (var_18 = var_00431364) + 1
  loc_005B71E8: var_6C = "NUMS"
  loc_005B721F: var_ret_4 = Me And (%x1 = Operator.Index <> "NUMS") And (%x1 = Operator.Left <> &H43136C)
  loc_005B7255: If CBool(var_ret_4) = 0 Then GoTo loc_005B7029
  loc_005B7279: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B72AE: ecx = "NEG"
  loc_005B72B4: GoTo loc_005B7029
  loc_005B72B9: 'Referenced from: 005B6D45
  loc_005B72DD: var_eax = Unknown_VTable_Call[eax+00000040h]
  loc_005B7301: var_18 = Operator.Caption
  loc_005B732F: eax = (var_18 = var_00431364) + 1
  loc_005B7335: var_7C = (var_18 = var_00431364) + 1
  loc_005B7350: var_6C = "NEG"
  loc_005B7369: var_ret_6 = Unknown_VTable_Call[eax+00000054h] And (%x1 = Operator.Index <> "NEG")
  loc_005B73A3: If CBool(var_ret_6) = var_20 Then GoTo loc_005B702B
  loc_005B73DE: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005B7412: var_1C = var_00431364 & var_18
  loc_005B7422: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005B7471: ecx = "NEG"
  loc_005B7477: GoTo loc_005B702B
  loc_005B74B7: Exit Sub
  loc_005B74B8: 'Referenced from: 005B7110
End Sub