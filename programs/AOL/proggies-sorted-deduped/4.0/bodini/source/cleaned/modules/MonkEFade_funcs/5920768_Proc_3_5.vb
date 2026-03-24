ï»¿Public Sub Proc_3_5_5A5800
  loc_005A5857: var_2C = eax
  loc_005A5866: 
  loc_005A587A: If InStr(1, var_2C, arg_10, @InStr(%StkVar4, %StkVar3, %StkVar2, %StkVar1)) = 0 Then GoTo loc_005A5990
  loc_005A5895: var_ret_1 = InStr(1, var_2C, arg_10, 0)
  loc_005A58A3: var_74 = var_2C
  loc_005A58A6: si = si - 0001h
  loc_005A58D9: var_94 = var_2C
  loc_005A58E4: var_84 = edi
  loc_005A5902: Len(arg_10) = Len(arg_10) + si
  loc_005A590B: Len(arg_10) = Len(arg_10) - 00000001h
  loc_005A5929: Len(var_2C) = Len(var_2C) - Len(arg_10)
  loc_005A5968: var_2C = Left(var_2C, si) + edi + Right(var_2C, Len(var_2C))
  loc_005A598B: GoTo loc_005A5866
  loc_005A5990: 'Referenced from: 005A587A
  loc_005A59A3: var_24 = var_2C
  loc_005A59AE: GoTo loc_005A59DB
  loc_005A59B4: If var_4 = 0 Then GoTo loc_005A59BF
  loc_005A59BF: 'Referenced from: 005A59B4
  loc_005A59DA: Exit Sub
  loc_005A59DB: 'Referenced from: 005A59AE
End Sub