Private Sub HScroll3_Scroll() '5CD320
  Dim var_2C As HScrollBar
  loc_005CD396: var_28 = HScroll1.Value
  loc_005CD3CD: var_2C = HScroll2.Value
  loc_005CD416: var_30 = HScroll3.Value
  loc_005CD44A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005CD489: GoTo loc_005CD4A7
  loc_005CD4A6: Exit Sub
  loc_005CD4A7: 'Referenced from: 005CD489
End Sub