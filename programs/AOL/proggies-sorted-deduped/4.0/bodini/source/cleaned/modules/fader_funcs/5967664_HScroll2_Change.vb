ï»¿Private Sub HScroll2_Change() '5B0F30
  Dim var_2C As HScrollBar
  loc_005B0FA6: var_28 = HScroll1.Value
  loc_005B0FDD: var_2C = HScroll2.Value
  loc_005B1026: var_30 = HScroll3.Value
  loc_005B105A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B1099: GoTo loc_005B10B7
  loc_005B10B6: Exit Sub
  loc_005B10B7: 'Referenced from: 005B1099
End Sub