ï»¿Private Sub HScroll1_Change() '5B2700
  Dim var_2C As HScrollBar
  loc_005B2776: var_28 = HScroll1.Value
  loc_005B27AD: var_2C = HScroll2.Value
  loc_005B27F6: var_30 = HScroll3.Value
  loc_005B282A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B2869: GoTo loc_005B2887
  loc_005B2886: Exit Sub
  loc_005B2887: 'Referenced from: 005B2869
End Sub