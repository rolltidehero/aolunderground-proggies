ï»¿Private Sub Command3_Click() '5E4800
  Dim var_24 As ListBox
  loc_005E4897: var_68 = List1.ListCount
  loc_005E48BC: var_68 = var_68 - 0001h
  loc_005E48C9: var_4C = var_68
  loc_005E48F3: For var_24 = "" To var_68 Step 1
  loc_005E4906: If var_24 = 0 Then GoTo loc_005E4A3E
  loc_005E4929: var_A8 = var_24
  loc_005E492F: var_24 = CInt(0)
  loc_005E493D: List1.Selected = var_24
  loc_005E4995: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005E49CF: call __vbaStrR8
  loc_005E49DA: var_2C = __vbaStrR8
  loc_005E49E2: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005E4A2F: Next var_24
  loc_005E4A39: GoTo loc_005E4904
  loc_005E4A3E: 'Referenced from: 005E4906
  loc_005E4A47: GoTo loc_005E4A6D
  loc_005E4A6C: Exit Sub
  loc_005E4A6D: 'Referenced from: 005E4A47
  loc_005E4A8F: Exit Sub
End Sub