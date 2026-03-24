Public Sub Proc_3_7_5A5BA0
  loc_005A5C69: var_ret_1 = Len(arg_30)
  loc_005A5C74: var_1A4 = var_ret_1
  loc_005A5C93: If var_60C000 <> 0 Then GoTo loc_005A5C9D
  loc_005A5C9B: GoTo loc_005A5CAE
  loc_005A5C9D: 'Referenced from: 005A5C93
  loc_005A5CAE: 'Referenced from: 005A5C9B
  loc_005A5CD3: var_E8 = arg_30
  loc_005A5D01: var_28 = Left(arg_30, CInt((var_1AC / 2)))
  loc_005A5D0F: var_ret_1 = var_ret_1 - CInt((var_1AC / 2))
  loc_005A5D1F: var_E8 = arg_30
  loc_005A5D53: var_30 = Right(arg_30, di)
  loc_005A5D6D: var_ret_2 = Len(var_28)
  loc_005A5D8C: var_F8 = var_ret_2
  loc_005A5DCC: For var_24 = 1 To  Step 1
  loc_005A5DDE: 
  loc_005A5DE0: If var_160 = 0 Then GoTo loc_005A626C
  loc_005A5DED: var_E8 = var_28
  loc_005A5E2A: var_34 = Left(var_28, CLng(var_24))
  loc_005A5E4B: var_E8 = var_34
  loc_005A5E5B: var_90 = Right(var_34, 1)
  loc_005A5E73: var_3C = var_90
  loc_005A5E98: var_1B0 = var_ret_2
  loc_005A5E9E: var_138 = arg_18
  loc_005A5EB2: edx = edx - edx
  loc_005A5EBE: var_1B4 = edx
  loc_005A5EF4: If var_60C000 <> 0 Then GoTo loc_005A5EFE
  loc_005A5EFC: GoTo loc_005A5F0F
  loc_005A5EFE: 'Referenced from: 005A5EF4
  loc_005A5F0F: 'Referenced from: 005A5EFC
  loc_005A5F28: var_118 = arg_1C
  loc_005A5F32: eax = eax - eax
  loc_005A5F3E: var_1C8 = eax-eax
  loc_005A5F69: If var_60C000 <> 0 Then GoTo loc_005A5F73
  loc_005A5F71: GoTo loc_005A5F84
  loc_005A5F73: 'Referenced from: 005A5F69
  loc_005A5F84: 'Referenced from: 005A5F71
  loc_005A5FAC: eax = eax - ecx
  loc_005A5FAF: var_F8 = ecx
  loc_005A5FBF: var_1DC = eax-ecx
  loc_005A5FFF: If var_60C000 <> 0 Then GoTo loc_005A6009
  loc_005A6007: GoTo loc_005A601A
  loc_005A6009: 'Referenced from: 005A5FFF
  loc_005A601A: 'Referenced from: 005A6007
  loc_005A6031: var_ret_4 = var_1E8 * var_1EC
  loc_005A605E: var_ret_5 = (var_1D0 / var_1D8) * var_24
  loc_005A608B: var_ret_6 = (var_1E4 / var_1EC) * var_24
  loc_005A60F6: var_eax = call Proc_3_6_5A5A20(var_90, RGB(= CInt(arg_1C = CInt(arg_18 = CInt(var_24) + arg_18) + arg_1C) +, (var_1BC / var_1C4), var_1D8), var_1D4)
  loc_005A6104: var_5C = var_90
  loc_005A6111: If arg_34 <> var_FFFFFF Then GoTo loc_005A6186
  loc_005A6117: var_7C = var_7C + 0001h
  loc_005A6125: var_7C = var_7C
  loc_005A6128: If var_7C <= 4 Then GoTo loc_005A6134
  loc_005A6134: 'Referenced from: 005A6128
  loc_005A6138: If var_7C <> 1 Then GoTo loc_005A614B
  loc_005A6142: var_2C = "<sup>"
  loc_005A614B: 'Referenced from: 005A6138
  loc_005A614F: If var_7C <> 2 Then GoTo loc_005A6162
  loc_005A6159: var_2C = "</sup>"
  loc_005A6162: 'Referenced from: 005A614F
  loc_005A6166: If var_7C <> 3 Then GoTo loc_005A6179
  loc_005A6170: var_2C = "<sub>"
  loc_005A6179: 'Referenced from: 005A6166
  loc_005A617D: If var_7C <> 4 Then GoTo loc_005A6194
  loc_005A6184: GoTo loc_005A618B
  loc_005A6186: 'Referenced from: 005A6111
  loc_005A618B: 'Referenced from: 005A6184
  loc_005A618E: var_2C = vbNullString
  loc_005A6194: 'Referenced from: 005A617D
  loc_005A61AC: var_88 = var_60 & "<Font Color=#"
  loc_005A61C7: var_80 = var_0042E8A4 & var_2C
  loc_005A61DA: var_A8 = var_80 & var_3C
  loc_005A621D: var_60 = var_60 & "<Font Color=#" & var_5C & var_80 & var_3C
  loc_005A6261: Next var_24
  loc_005A6267: GoTo loc_005A5DDE
  loc_005A626C: 'Referenced from: 005A5DE0
  loc_005A6278: var_ret_7 = Len(var_30)
  loc_005A6297: var_F8 = var_ret_7
  loc_005A62D7: For var_24 = 1 To  Step 1
  loc_005A62DD: 
  loc_005A62DF: If var_180 = 0 Then GoTo loc_005A676B
  loc_005A62EC: var_E8 = var_30
  loc_005A6329: var_34 = Left(var_30, CLng(var_24))
  loc_005A634A: var_E8 = var_34
  loc_005A635A: var_90 = Right(var_34, 1)
  loc_005A6372: var_3C = var_90
  loc_005A6397: var_1B0 = var_ret_7
  loc_005A639D: var_138 = arg_24
  loc_005A63B1: edx = edx - edx
  loc_005A63BD: var_1F0 = edx
  loc_005A63F3: If var_60C000 <> 0 Then GoTo loc_005A63FD
  loc_005A63FB: GoTo loc_005A640E
  loc_005A63FD: 'Referenced from: 005A63F3
  loc_005A640E: 'Referenced from: 005A63FB
  loc_005A6427: var_118 = arg_28
  loc_005A6431: eax = eax - eax
  loc_005A643D: var_204 = eax-eax
  loc_005A6468: If var_60C000 <> 0 Then GoTo loc_005A6472
  loc_005A6470: GoTo loc_005A6483
  loc_005A6472: 'Referenced from: 005A6468
  loc_005A6483: 'Referenced from: 005A6470
  loc_005A64AB: eax = eax - ecx
  loc_005A64AE: var_F8 = ecx
  loc_005A64BE: var_218 = eax-ecx
  loc_005A64FE: If var_60C000 <> 0 Then GoTo loc_005A6508
  loc_005A6506: GoTo loc_005A6519
  loc_005A6508: 'Referenced from: 005A64FE
  loc_005A6519: 'Referenced from: 005A6506
  loc_005A6530: var_ret_9 = var_224 * var_228
  loc_005A655D: var_ret_A = (var_20C / var_214) * var_24
  loc_005A658A: var_ret_B = (var_220 / var_228) * var_24
  loc_005A65F5: var_eax = call Proc_3_6_5A5A20(var_90, RGB(= CInt(arg_28 = CInt(arg_24 = CInt(var_24) + arg_24) + arg_28) +, (var_1F8 / var_200), var_214), var_210)
  loc_005A6603: var_5C = var_90
  loc_005A6610: If arg_34 <> var_FFFFFF Then GoTo loc_005A6685
  loc_005A6616: var_7C = var_7C + 0001h
  loc_005A6624: var_7C = var_7C
  loc_005A6627: If var_7C <= 4 Then GoTo loc_005A6633
  loc_005A6633: 'Referenced from: 005A6627
  loc_005A6637: If var_7C <> 1 Then GoTo loc_005A664A
  loc_005A6641: var_2C = "<sup>"
  loc_005A664A: 'Referenced from: 005A6637
  loc_005A664E: If var_7C <> 2 Then GoTo loc_005A6661
  loc_005A6658: var_2C = "</sup>"
  loc_005A6661: 'Referenced from: 005A664E
  loc_005A6665: If var_7C <> 3 Then GoTo loc_005A6678
  loc_005A666F: var_2C = "<sub>"
  loc_005A6678: 'Referenced from: 005A6665
  loc_005A667C: If var_7C <> 4 Then GoTo loc_005A6693
  loc_005A6683: GoTo loc_005A668A
  loc_005A6685: 'Referenced from: 005A6610
  loc_005A668A: 'Referenced from: 005A6683
  loc_005A668D: var_2C = vbNullString
  loc_005A6693: 'Referenced from: 005A667C
  loc_005A66AB: var_88 = var_64 & "<Font Color=#"
  loc_005A66C6: var_80 = var_0042E8A4 & var_2C
  loc_005A66D9: var_A8 = var_80 & var_3C
  loc_005A671C: var_64 = var_64 & "<Font Color=#" & var_5C & var_80 & var_3C
  loc_005A6760: Next var_24
  loc_005A6766: GoTo loc_005A62DD
  loc_005A676B: 'Referenced from: 005A62DF
  loc_005A6792: var_4C = var_60 & var_64
  loc_005A679E: GoTo loc_005A67EE
  loc_005A67A4: If var_4 = 0 Then GoTo loc_005A67AF
  loc_005A67AF: 'Referenced from: 005A67A4
  loc_005A67ED: Exit Sub
  loc_005A67EE: 'Referenced from: 005A679E
  loc_005A6853: Exit Sub
End Sub