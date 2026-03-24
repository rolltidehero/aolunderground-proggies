ï»¿Public Sub Proc_3_8_5A6890
  loc_005A694E: var_34 = CStr(Len(arg_24))
  loc_005A697F: var_E8 = var_34
  loc_005A69B0: For var_24 =  To var_34 Step 1
  loc_005A69C8: 
  loc_005A69CA: If var_160 = 0 Then GoTo loc_005A6E21
  loc_005A69D7: var_D8 = arg_24
  loc_005A6A0E: var_30 = Left(arg_24, CLng(var_24))
  loc_005A6A2D: var_D8 = var_30
  loc_005A6A3D: var_80 = Right(var_30, 1)
  loc_005A6A52: var_38 = var_80
  loc_005A6A6A: eax = eax - edx
  loc_005A6A79: var_170 = eax
  loc_005A6A99: If var_60C000 <> 0 Then GoTo loc_005A6AA3
  loc_005A6A9B: fdivr st0, real8 ptr var_178
  loc_005A6AA1: GoTo loc_005A6AB4
  loc_005A6AA3: 'Referenced from: 005A6A99
  loc_005A6AB4: 'Referenced from: 005A6AA1
  loc_005A6AE4: var_128 = ecx
  loc_005A6AEE: ecx = ecx - eax
  loc_005A6AFD: var_17C = ecx
  loc_005A6B1D: If var_60C000 <> 0 Then GoTo loc_005A6B27
  loc_005A6B1F: fdivr st0, real8 ptr var_184
  loc_005A6B25: GoTo loc_005A6B38
  loc_005A6B27: 'Referenced from: 005A6B1D
  loc_005A6B38: 'Referenced from: 005A6B25
  loc_005A6B62: var_108 = arg_10
  loc_005A6B72: edx = edx - ecx
  loc_005A6B81: var_188 = edx
  loc_005A6BA1: If var_60C000 <> 0 Then GoTo loc_005A6BAB
  loc_005A6BA3: fdivr st0, real8 ptr var_190
  loc_005A6BA9: GoTo loc_005A6BBC
  loc_005A6BAB: 'Referenced from: 005A6BA1
  loc_005A6BBC: 'Referenced from: 005A6BA9
  loc_005A6BD9: var_E8 = var_24
  loc_005A6BFF: var_ret_2 = var_34 * var_24
  loc_005A6C28: var_ret_3 = 0# * var_24
  loc_005A6C4E: var_ret_4 = var_34 * var_24
  loc_005A6CB2: var_eax = call Proc_3_6_5A5A20(var_80, RGB(var_24 = CInt(arg_10 = CInt(ecx = CInt(var_190) + ecx) + arg_10) + var_24, var_18C, var_184), var_180)
  loc_005A6CBD: var_48 = var_80
  loc_005A6CCA: If arg_28 <> var_FFFFFF Then GoTo loc_005A6D3F
  loc_005A6CD0: var_5C = var_5C + 0001h
  loc_005A6CDE: var_5C = var_5C
  loc_005A6CE1: If var_5C <= 4 Then GoTo loc_005A6CED
  loc_005A6CED: 'Referenced from: 005A6CE1
  loc_005A6CF1: If var_5C <> 1 Then GoTo loc_005A6D04
  loc_005A6CFB: var_28 = "<sup>"
  loc_005A6D04: 'Referenced from: 005A6CF1
  loc_005A6D08: If var_5C <> 2 Then GoTo loc_005A6D1B
  loc_005A6D12: var_28 = "</sup>"
  loc_005A6D1B: 'Referenced from: 005A6D08
  loc_005A6D1F: If var_5C <> 3 Then GoTo loc_005A6D32
  loc_005A6D29: var_28 = "<sub>"
  loc_005A6D32: 'Referenced from: 005A6D1F
  loc_005A6D36: If var_5C <> 4 Then GoTo loc_005A6D4D
  loc_005A6D3D: GoTo loc_005A6D44
  loc_005A6D3F: 'Referenced from: 005A6CCA
  loc_005A6D44: 'Referenced from: 005A6D3D
  loc_005A6D47: var_28 = vbNullString
  loc_005A6D4D: 'Referenced from: 005A6D36
  loc_005A6D65: var_78 = var_2C & "<Font Color=#"
  loc_005A6D7A: var_70 = var_0042E8A4 & var_28
  loc_005A6D8B: var_98 = var_70 & var_38
  loc_005A6DD1: var_2C = var_2C & "<Font Color=#" & var_48 & var_70 & var_38
  loc_005A6E16: Next var_24
  loc_005A6E1C: GoTo loc_005A69C8
  loc_005A6E21: 'Referenced from: 005A69CA
  loc_005A6E3D: var_6C = var_2C
  loc_005A6E49: GoTo loc_005A6E96
  loc_005A6E4F: If var_4 = 0 Then GoTo loc_005A6E5A
  loc_005A6E5A: 'Referenced from: 005A6E4F
  loc_005A6E95: Exit Sub
  loc_005A6E96: 'Referenced from: 005A6E49
  loc_005A6EE3: Exit Sub
End Sub