Private Sub HScroll2_Scroll() '5B10E0
  Dim var_2C As HScrollBar
  loc_005B1156: var_28 = HScroll1.Value
  loc_005B118D: var_2C = HScroll2.Value
  loc_005B11D6: var_30 = HScroll3.Value
  loc_005B120A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B1249: GoTo loc_005B1267
  loc_005B1266: Exit Sub
  loc_005B1267: 'Referenced from: 005B1249
End Sub