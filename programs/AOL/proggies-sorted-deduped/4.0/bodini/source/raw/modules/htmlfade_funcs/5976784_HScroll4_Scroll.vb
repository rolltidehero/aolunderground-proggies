Private Sub HScroll4_Scroll() '5B32D0
  Dim var_2C As HScrollBar
  loc_005B3346: var_28 = HScroll4.Value
  loc_005B337D: var_2C = HScroll5.Value
  loc_005B33C6: var_30 = HScroll6.Value
  loc_005B33FA: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B3439: GoTo loc_005B3457
  loc_005B3456: Exit Sub
  loc_005B3457: 'Referenced from: 005B3439
End Sub