Public Function GetWndName(hWnd) '5DCA00
  loc_005DCA51: call __vbaFixstrConstruct(00000064h, var_20, edi, esi, ebx)
  loc_005DCA61: var_ret_1 = var_20
  loc_005DCA6C: var_eax = GetWindowText(hWnd, var_ret_1, 100)
  loc_005DCA93: call __vbaLsetFixstr(esi, var_20, var_24)
  loc_005DCAAE: var_24 = var_20
  loc_005DCAC0: var_40 = var_24
  loc_005DCAD9: call __vbaLsetFixstr(esi, var_20, var_24)
  loc_005DCAEA: var_18 = Left(var_24, GetWindowText(hWnd, var_ret_1, 100))
  loc_005DCB07: GoTo loc_005DCB35
  loc_005DCB0D: If var_4 = 0 Then GoTo loc_005DCB18
  loc_005DCB18: 'Referenced from: 005DCB0D
  loc_005DCB34: Exit Sub
  loc_005DCB35: 'Referenced from: 005DCB07
End Function