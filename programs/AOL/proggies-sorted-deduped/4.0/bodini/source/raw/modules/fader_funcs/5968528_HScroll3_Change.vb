Private Sub HScroll3_Change() '5B1290
  Dim var_2C As HScrollBar
  loc_005B1306: var_28 = HScroll1.Value
  loc_005B133D: var_2C = HScroll2.Value
  loc_005B1386: var_30 = HScroll3.Value
  loc_005B13BA: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B13F9: GoTo loc_005B1417
  loc_005B1416: Exit Sub
  loc_005B1417: 'Referenced from: 005B13F9
End Sub