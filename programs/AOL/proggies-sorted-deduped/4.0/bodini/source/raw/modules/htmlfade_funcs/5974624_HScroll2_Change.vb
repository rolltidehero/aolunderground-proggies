Private Sub HScroll2_Change() '5B2A60
  Dim var_2C As HScrollBar
  loc_005B2AD6: var_28 = HScroll1.Value
  loc_005B2B0D: var_2C = HScroll2.Value
  loc_005B2B56: var_30 = HScroll3.Value
  loc_005B2B8A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005B2BC9: GoTo loc_005B2BE7
  loc_005B2BE6: Exit Sub
  loc_005B2BE7: 'Referenced from: 005B2BC9
End Sub