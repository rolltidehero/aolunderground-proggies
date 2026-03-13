Private Sub HScroll4_Change() '5B15F0
  Dim var_2C As HScrollBar
  loc_005B1666: var_28 = HScroll4.Value
  loc_005B169D: var_2C = HScroll5.Value
  loc_005B16E6: var_30 = HScroll6.Value
  loc_005B171A: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B1759: GoTo loc_005B1777
  loc_005B1776: Exit Sub
  loc_005B1777: 'Referenced from: 005B1759
End Sub