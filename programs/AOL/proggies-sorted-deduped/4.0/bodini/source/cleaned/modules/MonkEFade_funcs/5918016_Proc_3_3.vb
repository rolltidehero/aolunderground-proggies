ï»¿Public Sub Proc_3_3_5A4D40
  loc_005A4DAF: var_eax = call Proc_3_6_5A5A20(var_58, arg_C, edi)
  loc_005A4DCB: var_40 = var_58
  loc_005A4DE0: var_eax = call Proc_3_6_5A5A20(var_58, arg_10, @%x1)
  loc_005A4DF0: var_44 = var_58
  loc_005A4E07: var_90 = "&H"
  loc_005A4E1B: var_80 = var_40
  loc_005A4E91: var_80 = var_40
  loc_005A4EA2: var_A0 = "&H"
  loc_005A4F1A: var_90 = "&H"
  loc_005A4F2E: var_80 = var_40
  loc_005A4F65: var_20 = CInt(Val(CStr("&H" + Left(var_40, 2))))
  loc_005A4F91: var_90 = "&H"
  loc_005A4FA5: var_80 = var_44
  loc_005A4FDC: var_1C = CInt(Val(CStr("&H" + Right(var_44, 2))))
  loc_005A5009: var_80 = var_44
  loc_005A501A: var_A0 = "&H"
  loc_005A5062: var_2C = CInt(Val(CStr("&H" + Mid(var_44, 3, 2))))
  loc_005A5092: var_90 = "&H"
  loc_005A50A6: var_80 = var_44
  loc_005A50B3: var_58 = Left(var_44, 2)
  loc_005A50DD: var_28 = CInt(Val(CStr("&H" + var_58)))
  loc_005A511D: var_eax = call Proc_3_8_5A6890(var_58, CInt(Val(CStr("&H" + Right(var_40, 2)))), CInt(Val(CStr("&H" + Mid(var_40, 3, 2)))))
  loc_005A5128: var_3C = var_58
  loc_005A5134: GoTo loc_005A5166
  loc_005A513A: If var_4 = 0 Then GoTo loc_005A5145
  loc_005A5145: 'Referenced from: 005A513A
  loc_005A5165: Exit Sub
  loc_005A5166: 'Referenced from: 005A5134
End Sub