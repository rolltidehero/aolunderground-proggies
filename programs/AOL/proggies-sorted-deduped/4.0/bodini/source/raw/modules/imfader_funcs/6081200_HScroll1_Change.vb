Private Sub HScroll1_Change() '5CCAB0
  Dim var_2C As HScrollBar
  loc_005CCB26: var_28 = HScroll1.Value
  loc_005CCB5D: var_2C = HScroll2.Value
  loc_005CCBA6: var_30 = HScroll3.Value
  loc_005CCBDA: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005CCC19: GoTo loc_005CCC37
  loc_005CCC36: Exit Sub
  loc_005CCC37: 'Referenced from: 005CCC19
End Sub