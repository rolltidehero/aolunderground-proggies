Private Sub Command4_Click() '5E4AC0
  Dim var_30 As ListBox
  Dim var_24 As ListBox
  loc_005E4B6C: var_98 = List1.ListCount
  loc_005E4B94: var_98 = var_98 - 0001h
  loc_005E4BA4: var_7C = var_98
  loc_005E4BDA: For var_24 = "" To var_98 Step 1
  loc_005E4BED: If var_24 = 0 Then GoTo loc_005E4DD0
  loc_005E4C13: var_24 = CInt(var_28)
  loc_005E4C1B: var_30 = List1.List(var_24)
  loc_005E4C46: var_4C = var_28
  loc_005E4C56: var_3C = var_28
  loc_005E4C70: call InStr(var_64, 00000000h, var_44, var_54, 00000001h, Me, var_24, Me, var_30, Me, Me, var_24, Me, edi)
  loc_005E4CA3: If CBool(InStr(var_64, 00000000h, var_44, var_54, 00000001h, Me, var_24, Me, var_30, Me, Me, var_24, Me, edi)) = 0 Then GoTo loc_005E4DAF
  loc_005E4CC7: var_24 = CInt(-1)
  loc_005E4CCF: List1.Selected = var_24
  loc_005E4D27: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005E4D61: call __vbaStrR8
  loc_005E4D6C: var_2C = __vbaStrR8
  loc_005E4D74: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005E4DAF: 'Referenced from: 005E4CA3
  loc_005E4DC1: Next var_24
  loc_005E4DCB: GoTo loc_005E4BEB
  loc_005E4DD0: 'Referenced from: 005E4BED
  loc_005E4DD9: GoTo loc_005E4E13
  loc_005E4E12: Exit Sub
  loc_005E4E13: 'Referenced from: 005E4DD9
  loc_005E4E35: Exit Sub
End Sub