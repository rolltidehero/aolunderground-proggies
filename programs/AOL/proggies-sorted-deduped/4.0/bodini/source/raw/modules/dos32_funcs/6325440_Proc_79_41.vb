Public Sub Proc_79_41_6084C0
  loc_00608521: var_40 = LCase(Me)
  loc_0060852E: var_78 = arg_C
  loc_00608538: var_50 = LCase(arg_C)
  loc_00608549: call InStr(var_60, edi, var_50, var_40, 00000001h, 0, Me, %x1 = LCase(%StkVar2))
  loc_00608550: var_ret_1 = CLng(InStr(var_60, edi, var_50, var_40, 00000001h, 0, Me, %x1 = LCase(%StkVar2)))
  loc_00608571: 
  loc_00608573: If var_ret_1 <= 0 Then GoTo loc_006086AC
  loc_0060857E: var_ret_1 = var_ret_1 - 00000001h
  loc_006085AC: var_28 = Left(Me, var_ret_1)
  loc_006085CB: Len(arg_C) = Len(arg_C) + var_ret_1
  loc_006085D4: var_8C = Len(arg_C)
  loc_006085E8: If var_8C > 0 Then GoTo loc_0060865F
  loc_00608604: Len(Me) = Len(Me) - var_ret_1
  loc_0060860F: var_90 = Len(Me)
  loc_00608620: var_90 = var_90 - Len(arg_C)
  loc_00608652: var_1C = Right(Me, var_90 + 00000001h + 00000001h)
  loc_0060865D: GoTo loc_00608673
  loc_0060865F: 'Referenced from: 006085E8
  loc_00608667: var_1C = vbNullString
  loc_00608673: 'Referenced from: 0060865D
  loc_0060869A: var_18 = var_28 & arg_10 & var_1C
  loc_006086AA: GoTo loc_006086B1
  loc_006086AC: 'Referenced from: 00608573
  loc_006086B1: 'Referenced from: 006086AA
  loc_006086B1: var_18 = esi
  loc_006086C5: Len(arg_10) = Len(arg_10) + var_ret_1
  loc_006086CF: If Len(arg_10) <= 0 Then GoTo loc_00608737
  loc_006086E9: var_40 = LCase(Me)
  loc_006086F6: var_78 = arg_C
  loc_00608700: var_50 = LCase(arg_C)
  loc_00608711: call InStr(var_60, 00000000h, var_50, var_40, Len(arg_10))
  loc_00608718: var_ret_2 = CLng(InStr(var_60, 00000000h, var_50, var_40, Len(arg_10)))
  loc_00608737: 'Referenced from: 006086CF
  loc_0060873A: If var_ret_2 >= 1 Then GoTo loc_00608571
  loc_00608746: var_2C = var_18
  loc_00608751: GoTo loc_00608783
  loc_00608757: If var_4 = 0 Then GoTo loc_00608762
  loc_00608762: 'Referenced from: 00608757
  loc_00608782: Exit Sub
  loc_00608783: 'Referenced from: 00608751
  loc_00608798: Exit Sub
End Sub