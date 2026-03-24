Private Sub HScroll3_Change() '5CD170
  Dim var_2C As HScrollBar
  loc_005CD1E6: var_28 = HScroll1.Value
  loc_005CD21D: var_2C = HScroll2.Value
  loc_005CD266: var_30 = HScroll3.Value
  loc_005CD29A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005CD2D9: GoTo loc_005CD2F7
  loc_005CD2F6: Exit Sub
  loc_005CD2F7: 'Referenced from: 005CD2D9
End Sub