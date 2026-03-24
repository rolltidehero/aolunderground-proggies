Private Sub HScroll4_Change() '5B3120
  Dim var_2C As HScrollBar
  loc_005B3196: var_28 = HScroll4.Value
  loc_005B31CD: var_2C = HScroll5.Value
  loc_005B3216: var_30 = HScroll6.Value
  loc_005B324A: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B3289: GoTo loc_005B32A7
  loc_005B32A6: Exit Sub
  loc_005B32A7: 'Referenced from: 005B3289
End Sub