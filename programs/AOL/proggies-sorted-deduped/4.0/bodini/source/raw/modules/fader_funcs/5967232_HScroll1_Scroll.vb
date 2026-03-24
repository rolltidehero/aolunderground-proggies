Private Sub HScroll1_Scroll() '5B0D80
  Dim var_2C As HScrollBar
  loc_005B0DF6: var_28 = HScroll1.Value
  loc_005B0E2D: var_2C = HScroll2.Value
  loc_005B0E76: var_30 = HScroll3.Value
  loc_005B0EAA: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B0EE9: GoTo loc_005B0F07
  loc_005B0F06: Exit Sub
  loc_005B0F07: 'Referenced from: 005B0EE9
End Sub