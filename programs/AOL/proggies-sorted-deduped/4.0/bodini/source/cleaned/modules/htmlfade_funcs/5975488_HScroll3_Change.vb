ï»¿Private Sub HScroll3_Change() '5B2DC0
  Dim var_2C As HScrollBar
  loc_005B2E36: var_28 = HScroll1.Value
  loc_005B2E6D: var_2C = HScroll2.Value
  loc_005B2EB6: var_30 = HScroll3.Value
  loc_005B2EEA: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B2F29: GoTo loc_005B2F47
  loc_005B2F46: Exit Sub
  loc_005B2F47: 'Referenced from: 005B2F29
End Sub