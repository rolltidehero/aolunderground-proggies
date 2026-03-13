ï»¿Private Sub HScroll2_Scroll() '5B2C10
  Dim var_2C As HScrollBar
  loc_005B2C86: var_28 = HScroll1.Value
  loc_005B2CBD: var_2C = HScroll2.Value
  loc_005B2D06: var_30 = HScroll3.Value
  loc_005B2D3A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B2D79: GoTo loc_005B2D97
  loc_005B2D96: Exit Sub
  loc_005B2D97: 'Referenced from: 005B2D79
End Sub