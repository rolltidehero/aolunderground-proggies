Private Sub Command1_Click() '5B3B40
  loc_005B3BC3: var_eax = Unknown_VTable_Call[ecx+00000060h]
  loc_005B3BE9: var_2C = var_98
  loc_005B3C38: var_ret_1 = Len(Hex(var_98))
  loc_005B3C44: If var_ret_1 <> 5 Then GoTo loc_005B3C60
  loc_005B3C5C: var_18 = var_0042E980 & var_18
  loc_005B3C5E: GoTo loc_005B3C66
  loc_005B3C60: 'Referenced from: 005B3C44
  loc_005B3C66: 'Referenced from: 005B3C5E
  loc_005B3C6A: If var_ret_1 <> 4 Then GoTo loc_005B3C7E
  loc_005B3C7C: var_18 = "00" & var_18
  loc_005B3C7E: 'Referenced from: 005B3C6A
  loc_005B3C82: If var_ret_1 <> 3 Then GoTo loc_005B3C96
  loc_005B3C94: var_18 = "000" & var_18
  loc_005B3C96: 'Referenced from: 005B3C82
  loc_005B3C9A: If var_ret_1 <> 2 Then GoTo loc_005B3CAE
  loc_005B3CAC: var_18 = "0000" & var_18
  loc_005B3CAE: 'Referenced from: 005B3C9A
  loc_005B3CB2: If var_ret_1 <> 1 Then GoTo loc_005B3CC6
  loc_005B3CC4: var_18 = "00000" & var_18
  loc_005B3CC6: 'Referenced from: 005B3CB2
  loc_005B3CF1: var_44 = "bodini by: spek"
  loc_005B3D14: var_2C = "the value for the selected color is #" & var_18 & vbNullString
  loc_005B3D5F: GoTo loc_005B3D8F
  loc_005B3D8E: Exit Sub
  loc_005B3D8F: 'Referenced from: 005B3D5F
End Sub