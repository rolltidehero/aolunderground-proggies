Private Sub HScroll2_Change() '5B4350
  Dim var_50 As HScrollBar
  loc_005B43C9: var_2C = HScroll1.Value
  loc_005B4400: var_30 = HScroll2.Value
  loc_005B442E: var_50 = var_30
  loc_005B444A: var_34 = HScroll3.Value
  loc_005B4486: HScroll3.Top = RGB(var_2C, var_30, var_34)
  loc_005B44E4: var_2C = HScroll2.Value
  loc_005B4513: var_18 = CStr(var_2C)
  loc_005B451B: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B455B: GoTo loc_005B4582
  loc_005B4581: Exit Sub
  loc_005B4582: 'Referenced from: 005B455B
End Sub