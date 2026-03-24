Public Function GetClsName(hWnd) '5DC890
  loc_005DC8E1: call __vbaFixstrConstruct(00000064h, var_20, edi, esi, ebx)
  loc_005DC8F1: var_ret_1 = var_20
  loc_005DC8FC: var_eax = GetClassName(hWnd, var_ret_1, 100)
  loc_005DC923: call __vbaLsetFixstr(esi, var_20, var_24)
  loc_005DC93E: var_24 = var_20
  loc_005DC950: var_40 = var_24
  loc_005DC969: call __vbaLsetFixstr(esi, var_20, var_24)
  loc_005DC97A: var_1C = Left(var_24, GetClassName(hWnd, var_ret_1, 100))
  loc_005DC997: GoTo loc_005DC9C5
  loc_005DC99D: If var_4 = 0 Then GoTo loc_005DC9A8
  loc_005DC9A8: 'Referenced from: 005DC99D
  loc_005DC9C4: Exit Sub
  loc_005DC9C5: 'Referenced from: 005DC997
End Function