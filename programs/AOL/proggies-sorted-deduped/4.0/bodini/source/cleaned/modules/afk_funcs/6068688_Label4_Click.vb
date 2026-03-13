ï»¿Private Sub Label4_Click() '5C99D0
  Dim var_4C As Variant
  loc_005C9A92: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005C9AC2: ebx = (var_2C = "start") + 1
  loc_005C9ADD: If (var_2C = "start") + 1 = 0 Then GoTo loc_005C9E8D
  loc_005C9AEB: var_2C = "â¢bodini 4.0â¢ afk bot â¢spekâ¢"
  loc_005C9B1A: var_eax = call Proc_3_4_5A51B0(var_6C, var_24, 3)
  loc_005C9B68: var_2C = "<font face=""tahoma"">" & var_6C
  loc_005C9B7D: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005C9BAE: var_eax = call Proc_6098C0(CLng(0.5), var_4C, Me)
  loc_005C9BD4: var_2C = Text2.Text
  loc_005C9BFE: var_54 = var_2C
  loc_005C9C14: var_6C = LCase(0)
  loc_005C9C1A: var_eax = call Proc_79_47_609590(var_4C, Me, Me)
  loc_005C9C1F: var_84 = call Proc_79_47_609590(var_4C, Me, Me)
  loc_005C9C4B: var_38 = vbNullString
  loc_005C9C71: var_30 = LCase(call Proc_79_47_609590(var_4C, Me, Me))
  loc_005C9C7F: var_eax = call Proc_79_41_6084C0(var_30, var_34, var_38)
  loc_005C9CBF: var_40 = "â¢ ""." & call Proc_79_41_6084C0(var_30, var_34, var_38)
  loc_005C9CC9: var_A4 = var_40 & " and msg.â¢
  loc_005C9D0F: var_44 = &H42EC60 & var_6C & var_40 & " and msg.â¢
  loc_005C9D46: var_eax = call Proc_3_4_5A51B0(var_DC, var_24, 3)
  loc_005C9DE0: var_2C = "<font face=""tahoma"">" & var_DC
  loc_005C9DF5: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, , )
  loc_005C9E2D: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005C9E65: Timer1.Interval = CInt(1)
  loc_005C9E88: GoTo loc_005CA039
  loc_005C9E8D: 'Referenced from: 005C9ADD
  loc_005C9E95: var_2C = "â¢bodini 4.0â¢ afk bot offâ¢"
  loc_005C9EC4: var_eax = call Proc_3_4_5A51B0(var_6C, var_24, 3)
  loc_005C9F10: var_2C = "<font face=""tahoma"">" & var_6C
  loc_005C9F29: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005C9F5F: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005C9F9A: Timer1.Interval = 0
  loc_005C9FD4: var_eax = List2.Clear
  loc_005CA016: var_eax = List3.Clear
  loc_005CA039: 'Referenced from: 005C9E88
  loc_005CA042: GoTo loc_005CA0BA
  loc_005CA0B9: Exit Sub
  loc_005CA0BA: 'Referenced from: 005CA042
End Sub