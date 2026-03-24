Private Sub File1_Click() '5B00D0
  Dim var_58 As Variant
  Dim var_A8 As FileListBox
  Dim var_48 As FileListBox
  loc_005B015E: var_A8 = var_58
  loc_005B017D: var_9C = File1.ListIndex
  loc_005B01AF: var_48 = File1.List(var_9C)
  loc_005B01E3: var_24 = var_48
  loc_005B0219: var_48 = Dir1.Path
  loc_005B0254: var_4C = Dir1.Path
  loc_005B0278: var_60 = var_48
  loc_005B02B9: var_34 = Mid(var_48, Len(var_4C), 1)
  loc_005B0313: If (var_34 = &H431038) = 0 Then GoTo loc_005B03DB
  loc_005B0336: var_48 = Dir1.Path
  loc_005B0371: var_4C = File1.FileName
  loc_005B03AD: var_44 = var_48 & var_4C
  loc_005B03D6: GoTo loc_005B04B1
  loc_005B03DB: 'Referenced from: 005B0313
  loc_005B03F8: var_48 = Dir1.Path
  loc_005B0433: var_4C = File1.FileName
  loc_005B0484: var_44 = var_48 & var_00431038 & var_4C
  loc_005B04B1: 'Referenced from: 005B03D6
  loc_005B04D1: var_48 = CStr(var_44)
  loc_005B04D9: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005B050B: GoTo loc_005B054C
  loc_005B054B: Exit Sub
  loc_005B054C: 'Referenced from: 005B050B
End Sub