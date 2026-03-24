Private Sub Command2_Click() '5E4510
  Dim var_24 As ListBox
  loc_005E459A: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005E45E6: var_68 = List1.ListCount
  loc_005E460B: var_68 = var_68 - 0001h
  loc_005E4618: var_4C = var_68
  loc_005E4642: For var_24 = "" To var_68 Step 1
  loc_005E4655: If var_24 = 0 Then GoTo loc_005E4782
  loc_005E4679: var_24 = CInt(-1)
  loc_005E4681: List1.Selected = var_24
  loc_005E46D9: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005E4713: call __vbaStrR8
  loc_005E471E: var_2C = __vbaStrR8
  loc_005E4726: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005E4773: Next var_24
  loc_005E477D: GoTo loc_005E4653
  loc_005E4782: 'Referenced from: 005E4655
  loc_005E478B: GoTo loc_005E47B1
  loc_005E47B0: Exit Sub
  loc_005E47B1: 'Referenced from: 005E478B
  loc_005E47D3: Exit Sub
End Sub