Private Sub Command1_Click() '5CC6F0
  Dim var_30 As TextBox
  loc_005CC78B: var_eax = Unknown_VTable_Call[ecx+00000060h]
  loc_005CC7C3: var_eax = Unknown_VTable_Call[edx+00000060h]
  loc_005CC7F8: var_1C = Text2.Text
  loc_005CC82B: var_20 = var_1C
  loc_005CC83E: var_50 = var_94
  loc_005CC84D: var_40 = var_90
  loc_005CC861: var_eax = call Proc_3_3_5A4D40(var_68, 3, 3)
  loc_005CC875: var_18 = var_68
  loc_005CC8C8: var_1C = Text1.Text
  loc_005CC936: var_eax = call Proc_79_30_606DE0(vbNullString & var_1C & vbNullString, vbNullString & var_18 & vbNullString, var_30)
  loc_005CC96B: GoTo loc_005CC9B5
  loc_005CC9B4: Exit Sub
  loc_005CC9B5: 'Referenced from: 005CC96B
End Sub