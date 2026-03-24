ï»¿Public Sub Proc_79_28_6068D0
  loc_00606935: var_24 = arg_C & var_0043134C
  loc_0060693D: GoTo loc_00606941
  loc_00606941: 'Referenced from: 0060693D
  loc_00606956: InStr(1, var_24, var_0043134C, 0) = InStr(1, var_24, var_0043134C, 0) - 00000001h
  loc_0060695F: var_4C = InStr(1, var_24, var_0043134C, 0)
  loc_00606977: var_38 = Mid$(var_24, 1, InStr(1, var_24, var_0043134C, 0))
  loc_00606996: var_20 = Len(var_38)
  loc_006069A0: 
  loc_006069A8: If var_18 > 0 Then GoTo loc_00606B30
  loc_006069C0: Randomize(10)
  loc_006069F3: var_9C = Len(var_38)
  loc_00606A1B: var_ret_2 = Int((var_88 * var_A4))
  loc_00606A75: var_1C = var_1C & Mid$(var_38, si, 1)
  loc_00606A92: si = si - 0001h
  loc_00606AA0: var_4C = si-0001h
  loc_00606AC5: si-0001h = si-0001h + 0001h
  loc_00606AEE: var_38 = Mid$(var_38, 1, ) & Mid$(var_38, si, 10)
  loc_00606B1E: 00000001h = 00000001h + var_18
  loc_00606B2B: GoTo loc_006069A0
  loc_00606B30: 'Referenced from: 006069A8
  loc_00606B44: var_1C = var_1C & var_0043134C
  loc_00606B6B: InStr(1, var_24, var_0043134C, 0) = InStr(1, var_24, var_0043134C, 0) + 00000001h
  loc_00606B80: var_24 = Mid$(var_24, InStr(1, var_24, var_0043134C, 0), 10)
  loc_00606B9C: If InStr(1, var_24, var_0043134C, 0) <> 0 Then GoTo loc_0060693F
  loc_00606BAD: var_6C = var_1C
  loc_00606BC3: var_34 = RTrim(var_1C)
  loc_00606BCF: GoTo loc_00606C04
  loc_00606BD5: If var_4 = 0 Then GoTo loc_00606BE0
  loc_00606BE0: 'Referenced from: 00606BD5
  loc_00606C03: Exit Sub
  loc_00606C04: 'Referenced from: 00606BCF
  loc_00606C19: Exit Sub
End Sub