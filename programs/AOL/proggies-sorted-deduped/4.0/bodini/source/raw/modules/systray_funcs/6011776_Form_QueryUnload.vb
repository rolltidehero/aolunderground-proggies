Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer) '5BBB80
  loc_005BBBD8: repz stosd
  loc_005BBBE2: var_18 = Me.hWnd
  loc_005BBC0B: var_60C514 = var_18
  loc_005BBC24: var_eax = Shell_NotifyIcon(2, var_18)
End Sub