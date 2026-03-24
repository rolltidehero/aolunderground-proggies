Private Sub HScroll4_Scroll() '5B17A0
  Dim var_2C As HScrollBar
  loc_005B1816: var_28 = HScroll4.Value
  loc_005B184D: var_2C = HScroll5.Value
  loc_005B1896: var_30 = HScroll6.Value
  loc_005B18CA: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005B1909: GoTo loc_005B1927
  loc_005B1926: Exit Sub
  loc_005B1927: 'Referenced from: 005B1909
End Sub