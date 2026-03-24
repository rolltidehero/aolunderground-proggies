ï»¿Private Sub HScroll1_Change() '5B3E90
  Dim var_50 As HScrollBar
  loc_005B3F09: var_2C = HScroll1.Value
  loc_005B3F40: var_30 = HScroll2.Value
  loc_005B3F6E: var_50 = var_30
  loc_005B3F8A: var_34 = HScroll3.Value
  loc_005B3FC6: HScroll3.Top = RGB(var_2C, var_30, var_34)
  loc_005B4024: var_2C = HScroll1.Value
  loc_005B4053: var_18 = CStr(var_2C)
  loc_005B405B: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B409B: GoTo loc_005B40C2
  loc_005B40C1: Exit Sub
  loc_005B40C2: 'Referenced from: 005B409B
End Sub