Public Sub Proc_79_25_605FA0
  Dim var_1C As Screen
  loc_00605FE0: var_54 = eax.Width
  loc_0060602D: var_1C = Global.Screen
  loc_0060604D: var_50 = Global.Width
  loc_0060607A: If var_60C000 <> 0 Then GoTo loc_00606084
  loc_00606082: GoTo loc_0060608F
  loc_00606084: 'Referenced from: 0060607A
  loc_0060608A: call _adj_fdiv_m32(var_403308, %StkVar1 = CheckObj(%StkVar2, %StkVar3, %StkVar4), var_1C, ebx)
  loc_0060608F: 'Referenced from: 00606082
  loc_006060A4: var_14 = CLng(((var_50 - var_54) / 2))
  loc_006060B5: var_54 = Global.TwipsPerPixelY
  loc_006060F9: var_1C = Global.Screen
  loc_0060611D: var_50 = Global.Height
  loc_00606142: If var_60C000 <> 0 Then GoTo loc_0060614C
  loc_0060614A: GoTo loc_00606157
  loc_0060614C: 'Referenced from: 00606142
  loc_00606152: call _adj_fdiv_m32(var_403308)
  loc_00606157: 'Referenced from: 0060614A
  loc_006061D9: var_eax = Unknown_VTable_Call[edx+000002A4h]
  loc_006061FD: GoTo loc_00606209
  loc_00606208: Exit Sub
  loc_00606209: 'Referenced from: 006061FD
  loc_00606209: Exit Sub
End Sub