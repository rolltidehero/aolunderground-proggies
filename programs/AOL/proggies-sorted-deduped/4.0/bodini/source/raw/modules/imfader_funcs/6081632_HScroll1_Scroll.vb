Private Sub HScroll1_Scroll() '5CCC60
  Dim var_2C As HScrollBar
  loc_005CCCD6: var_28 = HScroll1.Value
  loc_005CCD0D: var_2C = HScroll2.Value
  loc_005CCD56: var_30 = HScroll3.Value
  loc_005CCD8A: HScroll3.Top = RGB(var_28, var_2C, var_30)
  loc_005CCDC9: GoTo loc_005CCDE7
  loc_005CCDE6: Exit Sub
  loc_005CCDE7: 'Referenced from: 005CCDC9
End Sub