Private Sub HScroll5_Change() '5B3480
  Dim var_2C As HScrollBar
  loc_005B34F6: var_28 = HScroll4.Value
  loc_005B352D: var_2C = HScroll5.Value
  loc_005B3576: var_30 = HScroll6.Value
  loc_005B35AA: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B35E9: GoTo loc_005B3607
  loc_005B3606: Exit Sub
  loc_005B3607: 'Referenced from: 005B35E9
End Sub