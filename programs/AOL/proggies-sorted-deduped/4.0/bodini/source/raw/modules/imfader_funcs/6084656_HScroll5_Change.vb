Private Sub HScroll5_Change() '5CD830
  Dim var_2C As HScrollBar
  loc_005CD8A6: var_28 = HScroll4.Value
  loc_005CD8DD: var_2C = HScroll5.Value
  loc_005CD926: var_30 = HScroll6.Value
  loc_005CD95A: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005CD999: GoTo loc_005CD9B7
  loc_005CD9B6: Exit Sub
  loc_005CD9B7: 'Referenced from: 005CD999
End Sub