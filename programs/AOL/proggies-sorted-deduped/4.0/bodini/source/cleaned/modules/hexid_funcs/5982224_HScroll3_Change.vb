ï»¿Private Sub HScroll3_Change() '5B4810
  Dim var_50 As HScrollBar
  loc_005B4889: var_2C = HScroll1.Value
  loc_005B48C0: var_30 = HScroll2.Value
  loc_005B48EE: var_50 = var_30
  loc_005B490A: var_34 = HScroll3.Value
  loc_005B4946: HScroll3.Top = RGB(var_2C, var_30, var_34)
  loc_005B49A4: var_2C = HScroll3.Value
  loc_005B49D3: var_18 = CStr(var_2C)
  loc_005B49DB: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B4A1B: GoTo loc_005B4A42
  loc_005B4A41: Exit Sub
  loc_005B4A42: 'Referenced from: 005B4A1B
End Sub