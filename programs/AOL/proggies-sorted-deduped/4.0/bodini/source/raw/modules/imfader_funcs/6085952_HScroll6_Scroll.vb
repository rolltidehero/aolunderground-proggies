Private Sub HScroll6_Scroll() '5CDD40
  Dim var_2C As HScrollBar
  loc_005CDDB6: var_28 = HScroll4.Value
  loc_005CDDED: var_2C = HScroll5.Value
  loc_005CDE36: var_30 = HScroll6.Value
  loc_005CDE6A: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005CDEA9: GoTo loc_005CDEC7
  loc_005CDEC6: Exit Sub
  loc_005CDEC7: 'Referenced from: 005CDEA9
End Sub