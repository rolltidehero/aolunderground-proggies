Private Sub HScroll4_Change() '5CD4D0
  Dim var_2C As HScrollBar
  loc_005CD546: var_28 = HScroll4.Value
  loc_005CD57D: var_2C = HScroll5.Value
  loc_005CD5C6: var_30 = HScroll6.Value
  loc_005CD5FA: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005CD639: GoTo loc_005CD657
  loc_005CD656: Exit Sub
  loc_005CD657: 'Referenced from: 005CD639
End Sub