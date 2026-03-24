Private Sub List1_Click() '5E5260
  Dim var_24 As ListBox
  Dim var_38 As ListBox
  loc_005E52CD: var_38 = var_24
  loc_005E52E6: var_28 = List1.ListIndex
  loc_005E5312: var_28 = List1.Selected
  loc_005E533D: setz dl
  loc_005E5354: If edx = 0 Then GoTo loc_005E5417
  loc_005E5389: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005E53C3: call __vbaStrR8
  loc_005E53CE: var_1C = __vbaStrR8
  loc_005E53D6: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005E5417: 'Referenced from: 005E5354
  loc_005E5427: var_38 = var_20
  loc_005E5443: var_28 = List1.ListIndex
  loc_005E546F: var_28 = List1.Selected
  loc_005E549B: setz cl
  loc_005E54B0: If ecx = 0 Then GoTo loc_005E5569
  loc_005E54E1: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E551B: call __vbaStrR8
  loc_005E5526: var_1C = __vbaStrR8
  loc_005E552E: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005E5569: 'Referenced from: 005E54B0
  loc_005E5576: GoTo loc_005E559C
  loc_005E559B: Exit Sub
  loc_005E559C: 'Referenced from: 005E5576
  loc_005E559C: Exit Sub
End Sub