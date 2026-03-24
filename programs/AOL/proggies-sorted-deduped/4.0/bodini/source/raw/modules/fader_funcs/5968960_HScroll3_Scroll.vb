Private Sub HScroll3_Scroll() '5B1440
  Dim var_2C As HScrollBar
  loc_005B14B6: var_28 = HScroll1.Value
  loc_005B14ED: var_2C = HScroll2.Value
  loc_005B1536: var_30 = HScroll3.Value
  loc_005B156A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B15A9: GoTo loc_005B15C7
  loc_005B15C6: Exit Sub
  loc_005B15C7: 'Referenced from: 005B15A9
End Sub