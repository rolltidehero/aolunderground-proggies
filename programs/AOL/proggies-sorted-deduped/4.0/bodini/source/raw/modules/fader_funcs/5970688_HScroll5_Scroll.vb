Private Sub HScroll5_Scroll() '5B1B00
  Dim var_2C As HScrollBar
  loc_005B1B76: var_28 = HScroll4.Value
  loc_005B1BAD: var_2C = HScroll5.Value
  loc_005B1BF6: var_30 = HScroll6.Value
  loc_005B1C2A: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B1C69: GoTo loc_005B1C87
  loc_005B1C86: Exit Sub
  loc_005B1C87: 'Referenced from: 005B1C69
End Sub