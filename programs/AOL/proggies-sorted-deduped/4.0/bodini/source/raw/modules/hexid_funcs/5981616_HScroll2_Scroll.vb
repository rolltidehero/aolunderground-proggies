Private Sub HScroll2_Scroll() '5B45B0
  Dim var_50 As HScrollBar
  loc_005B4629: var_2C = HScroll1.Value
  loc_005B4660: var_30 = HScroll2.Value
  loc_005B468E: var_50 = var_30
  loc_005B46AA: var_34 = HScroll3.Value
  loc_005B46E6: HScroll3.Top = RGB(var_2C, var_30, var_34)
  loc_005B4744: var_2C = HScroll2.Value
  loc_005B4773: var_18 = CStr(var_2C)
  loc_005B477B: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B47BB: GoTo loc_005B47E2
  loc_005B47E1: Exit Sub
  loc_005B47E2: 'Referenced from: 005B47BB
End Sub