ï»¿Private Sub Timer1_Timer() '5B96B0
  loc_005B9720: var_3C = var_2C
  loc_005B9739: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005B9776: call __vbaStrR8
  loc_005B9781: var_1C = __vbaStrR8
  loc_005B978E: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B97E2: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005B9804: fcomp real8 ptr [00401E50h]
  loc_005B9816: GoTo loc_005B981A
  loc_005B981A: 'Referenced from: 005B9816
  loc_005B9831: If ebx = 0 Then GoTo loc_005B98DC
  loc_005B984A: var_3C = var_2C
  loc_005B9863: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005B9894: var_1C = var_0042E980 & var_18
  loc_005B98A1: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B98DC: 'Referenced from: 005B9831
  loc_005B98F5: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005B9925: ebx = (var_18 = "60") + 1
  loc_005B993A: If (var_18 = "60") + 1 = 0 Then GoTo loc_005B9A37
  loc_005B9953: var_3C = var_2C
  loc_005B996C: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005B99A9: call __vbaStrR8
  loc_005B99B4: var_1C = __vbaStrR8
  loc_005B99C1: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B9A16: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005B9A37: 'Referenced from: 005B993A
  loc_005B9A63: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005B9A94: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005B9ADB: var_24 = var_18 & var_00431C88 & var_1C
  loc_005B9AE8: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005B9B5A: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005B9B88: var_1C = "Playing File. " & var_18
  loc_005B9B90: var_eax = Unknown_VTable_Call[esi+00000054h]
  loc_005B9BD8: GoTo loc_005B9C0A
  loc_005B9C09: Exit Sub
  loc_005B9C0A: 'Referenced from: 005B9BD8
  loc_005B9C0A: Exit Sub
End Sub