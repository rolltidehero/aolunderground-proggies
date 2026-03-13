Private Sub Timer2_Timer() '5D15D0
  loc_005D163E: var_28 = Timer2.Interval
  loc_005D1660: setz al
  loc_005D1670: If eax <> 0 Then GoTo loc_005D17D4
  loc_005D16A9: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005D16E3: call __vbaStrR8
  loc_005D16EE: var_1C = __vbaStrR8
  loc_005D16F6: var_eax = Unknown_VTable_Call[edi+00000054h]
  loc_005D1750: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005D1780: edi = (var_18 = "63") + 1
  loc_005D1795: If (var_18 = "63") + 1 = 0 Then GoTo loc_005D17D2
  loc_005D17B1: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005D17D2: 'Referenced from: 005D1795
  loc_005D17D4: 'Referenced from: 005D1670
  loc_005D17DD: GoTo loc_005D1803
  loc_005D1802: Exit Sub
  loc_005D1803: 'Referenced from: 005D17DD
  loc_005D1803: Exit Sub
End Sub