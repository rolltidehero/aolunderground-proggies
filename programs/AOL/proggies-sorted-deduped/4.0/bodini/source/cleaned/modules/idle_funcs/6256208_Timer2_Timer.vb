ï»¿Private Sub Timer2_Timer() '5F7650
  loc_005F76CC: var_80 = var_3C
  loc_005F76E5: var_eax = Unknown_VTable_Call[eax+00000050h]
  loc_005F7722: call __vbaStrR8
  loc_005F7733: var_30 = __vbaStrR8
  loc_005F773C: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F7786: var_2C = "â¢bodini 4.0â¢ idle bot â¢spekâ¢"
  loc_005F77B2: var_eax = call Proc_3_4_5A51B0(var_5C, var_24, 3)
  loc_005F77FA: var_2C = "<font face=""tahoma"">" & var_5C
  loc_005F780F: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F783A: var_eax = call Proc_6098C0(CLng(0.3), , )
  loc_005F785D: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005F788E: eax = (var_2C = var_0042E988) + 1
  loc_005F7891: var_80 = (var_2C = var_0042E988) + 1
  loc_005F78A8: If var_80 = 0 Then GoTo loc_005F7970
  loc_005F78BD: var_2C = "â¢bodini 4.0â¢ idle bot â¢1 minuteâ¢"
  loc_005F78E9: var_eax = call Proc_3_4_5A51B0(var_5C, var_24, 3)
  loc_005F792B: var_2C = "<font face=""tahoma"">" & var_5C
  loc_005F7940: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F7967: var_74 = CLng(0.3)
  loc_005F796B: GoTo loc_005F7A8A
  loc_005F7970: 'Referenced from: 005F78A8
  loc_005F798D: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005F79CB: var_34 = "â¢bodini 4.0â¢ idle bot â¢" & var_2C & " minutesâ¢"
  loc_005F79F3: var_eax = call Proc_3_4_5A51B0(var_5C, var_24, 3)
  loc_005F7A4E: var_2C = "<font face=""tahoma"">" & var_5C
  loc_005F7A63: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_2C, var_38)
  loc_005F7A83: var_74 = CLng(0.3)
  loc_005F7A8A: 'Referenced from: 005F796B
  loc_005F7A8A: var_eax = call Proc_6098C0(var_74, var_38, call Proc_6098C0(var_74, , ))
  loc_005F7A9C: GoTo loc_005F7AD6
  loc_005F7AD5: Exit Sub
  loc_005F7AD6: 'Referenced from: 005F7A9C
  loc_005F7AE8: Exit Sub
End Sub