Private Sub Command11_Click() '5E8340
  Dim var_20 As ListBox
  Dim var_B0 As ListBox
  loc_005E83C5: var_A4 = List1.ListCount
  loc_005E83EF: setz bl
  loc_005E83FD: If ebx = 0 Then GoTo loc_005E8424
  loc_005E841B: var_68 = "You have nobody on the list to remove."
  loc_005E8422: GoTo loc_005E849D
  loc_005E8424: 'Referenced from: 005E83FD
  loc_005E8440: var_A4 = List1.SelCount
  loc_005E846A: setz bl
  loc_005E8478: If ebx = 0 Then GoTo loc_005E84EB
  loc_005E849D: 'Referenced from: 005E8422
  loc_005E84AA: var_30 = "Please highlight who you would like to remove."
  loc_005E84E6: GoTo loc_005E8618
  loc_005E84EB: 'Referenced from: 005E8478
  loc_005E84FE: var_B0 = var_20
  loc_005E851D: var_A4 = List1.ListIndex
  loc_005E854B: var_eax = List1.RemoveItem var_A4
  loc_005E85AA: var_A4 = List1.ListCount
  loc_005E85DC: var_18 = CStr(var_A4)
  loc_005E85E4: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005E8618: 'Referenced from: 005E84E6
  loc_005E8624: GoTo loc_005E865B
  loc_005E865A: Exit Sub
  loc_005E865B: 'Referenced from: 005E8624
End Sub