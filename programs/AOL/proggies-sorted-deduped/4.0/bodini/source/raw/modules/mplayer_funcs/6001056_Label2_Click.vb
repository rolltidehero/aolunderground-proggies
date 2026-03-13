Private Sub Label2_Click() '5B91A0
  loc_005B9207: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005B9237: edi = (var_18 = "No Repeat") + 1
  loc_005B924F: If (var_18 = "No Repeat") + 1 = 0 Then GoTo loc_005B9273
  loc_005B9268: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B926F: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005B92A2
  loc_005B9271: GoTo loc_005B9293
  loc_005B928A: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005B9291: If Unknown_VTable_Call[eax+00000054h] >= 0 Then GoTo loc_005B92A2
  loc_005B9293: 'Referenced from: 005B9271
  loc_005B929C: Unknown_VTable_Call[eax+00000054h] = CheckObj(Unknown_VTable_Call[eax+00000054h], var_0042DCB0, 84)
  loc_005B92A2: 
  loc_005B92B7: GoTo loc_005B92CC
  loc_005B92CB: Exit Sub
  loc_005B92CC: 'Referenced from: 005B92B7
End Sub