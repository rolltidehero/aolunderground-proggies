Private Sub HScroll6_Change() '5B37E0
  Dim var_2C As HScrollBar
  loc_005B3856: var_28 = HScroll4.Value
  loc_005B388D: var_2C = HScroll5.Value
  loc_005B38D6: var_30 = HScroll6.Value
  loc_005B390A: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B3949: GoTo loc_005B3967
  loc_005B3966: Exit Sub
  loc_005B3967: 'Referenced from: 005B3949
End Sub