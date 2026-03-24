ï»¿Private Sub HScroll1_Scroll() '5B40F0
  Dim var_50 As HScrollBar
  loc_005B4169: var_2C = HScroll1.Value
  loc_005B41A0: var_30 = HScroll2.Value
  loc_005B41CE: var_50 = var_30
  loc_005B41EA: var_34 = HScroll3.Value
  loc_005B4226: HScroll3.Top = RGB(var_2C, var_30, var_34)
  loc_005B4284: var_2C = HScroll1.Value
  loc_005B42B3: var_18 = CStr(var_2C)
  loc_005B42BB: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B42FB: GoTo loc_005B4322
  loc_005B4321: Exit Sub
  loc_005B4322: 'Referenced from: 005B42FB
End Sub