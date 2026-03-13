ï»¿Public Sub Proc_3_4_5A51B0
  loc_005A522E: var_eax = call Proc_3_6_5A5A20(var_68, arg_C, edi)
  loc_005A524A: var_50 = var_68
  loc_005A525F: var_eax = call Proc_3_6_5A5A20(var_68, arg_10, @%x1)
  loc_005A526F: var_54 = var_68
  loc_005A527E: var_eax = call Proc_3_6_5A5A20(var_68, arg_14, undef 'Ignore this '__vbaFreeVar)
  loc_005A528E: var_18 = var_68
  loc_005A52A5: var_A0 = "&H"
  loc_005A52B9: var_90 = var_50
  loc_005A5332: var_90 = var_50
  loc_005A5346: var_B0 = "&H"
  loc_005A53C4: var_A0 = "&H"
  loc_005A53D8: var_90 = var_50
  loc_005A5412: var_28 = CInt(Val(CStr("&H" + Left(var_50, 2))))
  loc_005A543E: var_A0 = "&H"
  loc_005A5452: var_90 = var_54
  loc_005A548C: var_20 = CInt(Val(CStr("&H" + Right(var_54, 2))))
  loc_005A54B9: var_90 = var_54
  loc_005A54CD: var_B0 = "&H"
  loc_005A5518: var_34 = CInt(Val(CStr("&H" + Mid(var_54, 3, 2))))
  loc_005A554B: var_A0 = "&H"
  loc_005A555F: var_90 = var_54
  loc_005A5599: var_30 = CInt(Val(CStr("&H" + Left(var_54, 2))))
  loc_005A55C5: var_A0 = "&H"
  loc_005A55D9: var_90 = var_18
  loc_005A5613: var_24 = CInt(Val(CStr("&H" + Right(var_18, 2))))
  loc_005A5640: var_90 = var_18
  loc_005A5654: var_B0 = "&H"
  loc_005A569F: var_3C = CInt(Val(CStr("&H" + Mid(var_18, 3, 2))))
  loc_005A56D2: var_A0 = "&H"
  loc_005A56E6: var_90 = var_18
  loc_005A56F6: var_68 = Left(var_18, 2)
  loc_005A5720: var_38 = CInt(Val(CStr("&H" + var_68)))
  loc_005A576C: var_eax = call Proc_3_7_5A5BA0(var_68, CInt(Val(CStr("&H" + Right(var_50, 2)))), CInt(Val(CStr("&H" + Mid(var_50, 3, 2)))))
  loc_005A5777: var_4C = var_68
  loc_005A5783: GoTo loc_005A57B8
  loc_005A5789: If var_4 = 0 Then GoTo loc_005A5794
  loc_005A5794: 'Referenced from: 005A5789
  loc_005A57B7: Exit Sub
  loc_005A57B8: 'Referenced from: 005A5783
End Sub