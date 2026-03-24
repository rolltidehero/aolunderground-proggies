Private Sub HScroll1_Scroll() '5B28B0
  Dim var_2C As HScrollBar
  loc_005B2926: var_28 = HScroll1.Value
  loc_005B295D: var_2C = HScroll2.Value
  loc_005B29A6: var_30 = HScroll3.Value
  loc_005B29DA: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B2A19: GoTo loc_005B2A37
  loc_005B2A36: Exit Sub
  loc_005B2A37: 'Referenced from: 005B2A19
End Sub