Private Sub HScroll1_Change() '5B0BD0
  Dim var_2C As HScrollBar
  loc_005B0C46: var_28 = HScroll1.Value
  loc_005B0C7D: var_2C = HScroll2.Value
  loc_005B0CC6: var_30 = HScroll3.Value
  loc_005B0CFA: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B0D39: GoTo loc_005B0D57
  loc_005B0D56: Exit Sub
  loc_005B0D57: 'Referenced from: 005B0D39
End Sub