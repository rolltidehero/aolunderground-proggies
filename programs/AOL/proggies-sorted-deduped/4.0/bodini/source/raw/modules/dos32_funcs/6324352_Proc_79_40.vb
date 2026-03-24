Public Sub Proc_79_40_608080
  loc_006080DF: var_eax = call Proc_79_39_607F30(Me, Me, esi)
  loc_006080EB: If ebx > 0 Then GoTo loc_00608455
  loc_006080F4: If ebx <> 1 Then GoTo loc_00608242
  loc_006080FC: If call Proc_79_39_607F30(Me, Me, esi) <> arg_C Then GoTo loc_00608113
  loc_00608103: var_24 = edi
  loc_0060810E: GoTo loc_00608497
  loc_00608113: 'Referenced from: 006080FC
  loc_00608116: If ecx <> 1 Then GoTo loc_00608242
  loc_00608137: var_44 = Chr(13)
  loc_0060816F: call InStr(var_54, esi, var_44, var_84, 00000001h, var_006084A1, %x1 = Chr(%StkVar2))
  loc_006081E0: var_34 = vbNullString
  loc_006081F1: var_30 = Chr(13)
  loc_006081FF: var_eax = call Proc_79_41_6084C0(Left(Me, CLng(InStr(var_54, esi, Chr(13), var_84, 00000001h, var_006084A1, %x1 = Chr(1)) - 1)), var_30, var_34)
  loc_00608209: var_20 = call Proc_79_41_6084C0(var_20, var_30, var_34)
  loc_0060822D: var_44 = Chr(10)
  loc_0060823D: GoTo loc_0060840A
  loc_00608242: 'Referenced from: 006080F4
  loc_0060824A: var_7C = %x1
  loc_00608257: var_44 = Chr(13)
  loc_0060826F: call InStr(var_54, %ecx = %S_edx_S, var_44, var_84, 00000001h)
  loc_00608276: var_ret_3 = CLng(InStr(var_54, var_54 = %S_edx_S, var_44, var_84, 00000001h))
  loc_00608293: ebx = ebx - 00000001h
  loc_006082A9: If 00000001h > 00000001h Then GoTo loc_0060831D
  loc_006082B3: var_2C = var_ret_3
  loc_006082B6: var_7C = %x1
  loc_006082C3: var_44 = Chr(13)
  loc_006082C9: var_ret_3 = var_ret_3 + 00000001h
  loc_006082E4: call InStr(var_54, 00000000h, var_44, var_84, var_ret_3)
  loc_006082EB: var_ret_4 = CLng(InStr(var_54, 00000000h, var_44, var_84, var_ret_3))
  loc_0060830B: 00000001h = 00000001h + 00000001h
  loc_0060831B: GoTo loc_006082A7
  loc_0060831D: 'Referenced from: 006082A9
  loc_0060831F: If var_ret_4 <> 0 Then GoTo loc_0060832C
  loc_0060832C: 'Referenced from: 0060831F
  loc_00608332: Len(@%x1) = Len(@%x1) - var_2C
  loc_00608342: Len(@%x1) = Len(@%x1) + 00000001h
  loc_00608350: var_3C = Len(@%x1)
  loc_0060835A: var_7C = %x1
  loc_006083B3: var_34 = vbNullString
  loc_006083C0: var_30 = Chr(13)
  loc_006083CE: var_eax = call Proc_79_41_6084C0(Mid(@%x1, var_2C, Len(@%x1)), var_30, var_34)
  loc_006083D8: var_20 = call Proc_79_41_6084C0(var_20, var_30, var_34)
  loc_006083FC: var_44 = Chr(10)
  loc_0060840A: 'Referenced from: 0060823D
  loc_0060840A: var_34 = vbNullString
  loc_00608417: var_30 = var_44
  loc_00608425: var_eax = call Proc_79_41_6084C0(var_20, var_30, var_34)
  loc_00608453: var_24 = call Proc_79_41_6084C0(var_20, var_30, var_34)
  loc_00608455: 'Referenced from: 006080EB
  loc_0060845A: GoTo loc_00608497
  loc_00608460: If var_4 = 0 Then GoTo loc_0060846B
  loc_0060846B: 'Referenced from: 00608460
  loc_00608496: Exit Sub
  loc_00608497: 'Referenced from: 0060810E
  loc_006084A0: Exit Sub
End Sub