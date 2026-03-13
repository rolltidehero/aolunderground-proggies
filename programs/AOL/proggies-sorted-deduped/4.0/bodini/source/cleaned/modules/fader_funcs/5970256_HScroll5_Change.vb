ï»¿Private Sub HScroll5_Change() '5B1950
  Dim var_2C As HScrollBar
  loc_005B19C6: var_28 = HScroll4.Value
  loc_005B19FD: var_2C = HScroll5.Value
  loc_005B1A46: var_30 = HScroll6.Value
  loc_005B1A7A: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B1AB9: GoTo loc_005B1AD7
  loc_005B1AD6: Exit Sub
  loc_005B1AD7: 'Referenced from: 005B1AB9
End Sub