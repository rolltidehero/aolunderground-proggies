Private Sub HScroll3_Scroll() '5B4A70
  Dim var_50 As HScrollBar
  loc_005B4AE9: var_2C = HScroll1.Value
  loc_005B4B20: var_30 = HScroll2.Value
  loc_005B4B4E: var_50 = var_30
  loc_005B4B6A: var_34 = HScroll3.Value
  loc_005B4BA6: HScroll3.Top = RGB(var_2C, var_30, var_34)
  loc_005B4C04: var_2C = HScroll3.Value
  loc_005B4C33: var_18 = CStr(var_2C)
  loc_005B4C3B: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B4C7B: GoTo loc_005B4CA2
  loc_005B4CA1: Exit Sub
  loc_005B4CA2: 'Referenced from: 005B4C7B
End Sub