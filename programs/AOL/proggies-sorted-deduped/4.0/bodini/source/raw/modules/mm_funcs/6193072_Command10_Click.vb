Private Sub Command10_Click() '5E7FB0
  loc_005E80D2: var_18 = InputBox("who do we add to mm?", "bodini 4.0 mass mailer", var_54, var_64, 10, 10, 10)
  loc_005E8112: If Len(var_18) < 3 Then GoTo loc_005E82BA
  loc_005E8124: If Len(var_18) <= 10 Then GoTo loc_005E819B
  loc_005E815A: var_34 = "Screen names are a max of 10 letters."
  loc_005E8196: GoTo loc_005E82BA
  loc_005E819B: 'Referenced from: 005E8124
  loc_005E81EF: var_eax = List1.AddItem var_18, var_98
  loc_005E824C: var_108 = List1.ListCount
  loc_005E827E: var_1C = CStr(var_108)
  loc_005E8286: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005E82BA: 'Referenced from: 005E8112
  loc_005E82C2: GoTo loc_005E830B
  loc_005E830A: Exit Sub
  loc_005E830B: 'Referenced from: 005E82C2
End Sub