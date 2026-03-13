Private Sub HScroll2_Change() '5CCE10
  Dim var_2C As HScrollBar
  loc_005CCE86: var_28 = HScroll1.Value
  loc_005CCEBD: var_2C = HScroll2.Value
  loc_005CCF06: var_30 = HScroll3.Value
  loc_005CCF3A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005CCF79: GoTo loc_005CCF97
  loc_005CCF96: Exit Sub
  loc_005CCF97: 'Referenced from: 005CCF79
End Sub