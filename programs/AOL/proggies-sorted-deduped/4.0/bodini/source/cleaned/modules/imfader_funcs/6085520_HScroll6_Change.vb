ï»¿Private Sub HScroll6_Change() '5CDB90
  Dim var_2C As HScrollBar
  loc_005CDC06: var_28 = HScroll4.Value
  loc_005CDC3D: var_2C = HScroll5.Value
  loc_005CDC86: var_30 = HScroll6.Value
  loc_005CDCBA: HScroll6.Top = RGB(var_28, var_2C, var_30)
  loc_005CDCF9: GoTo loc_005CDD17
  loc_005CDD16: Exit Sub
  loc_005CDD17: 'Referenced from: 005CDCF9
End Sub