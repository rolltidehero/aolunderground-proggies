ï»¿Public Sub Proc_26_4_5BBFF0
  Dim var_1C As Variant
  loc_005BC02C: repz stosd
  loc_005BC050: var_30 = Me.hWnd
  loc_005BC078: var_60C514 = var_30
  loc_005BC0A0: var_1C = Me.Icon
  loc_005BC0D9: var_60C524 = CLng(var_2C)
  loc_005BC0F4: var_14 = Me.Caption
  loc_005BC12A: call __vbaLsetFixstr(00000040h, vbNullString, var_14 & vbNullString, %StkVar1 = CheckObj(%StkVar2, %StkVar3, %StkVar4))
  loc_005BC15D: var_eax = Shell_NotifyIcon(0, var_98)
  loc_005BC1A5: var_1C = Global.App
  loc_005BC1C3: Global.TaskVisible = False
  loc_005BC1E3: var_eax = Unknown_VTable_Call[edx+000002B4h]
End Sub