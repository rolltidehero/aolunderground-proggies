ï»¿Private Sub Command2_Click() '5C3000
  Dim var_34 As TextBox
  Dim var_CC As TextBox
  loc_005C30A1: var_2C = Text1.Text
  loc_005C30C5: var_3C = var_2C
  loc_005C3105: var_9C = "â¢bodini 4.0â¢ profile â¢"
  loc_005C313B: var_30 = "â¢bodini 4.0â¢ profile â¢" & LCase(var_2C) & &H42EC60
  loc_005C316F: var_eax = call Proc_3_4_5A51B0(var_94, var_24, 3)
  loc_005C31F0: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_94 & vbNullString, var_24, "<font face=""tahoma"">" & var_94 & vbNullString)
  loc_005C3214: var_CC = CLng(0.5)
  loc_005C3221: var_eax = call Proc_6098C0(var_CC, Me, edi)
  loc_005C3247: var_2C = Text2.Text
  loc_005C327A: var_eax = call Proc_79_29_606C60(var_2C, var_34, call Proc_6098C0(var_CC, Me, edi))
  loc_005C329D: var_CC = CLng(0.7)
  loc_005C32AA: call Proc_6098C0(var_CC, Me, var_34 = %S_edx_S)
  loc_005C32CC: var_2C = Text1.Text
  loc_005C32F0: var_3C = var_2C
  loc_005C333A: var_AC = "â¢ profiler â¢completeâ¢"
  loc_005C3362: var_30 = &H42EC60 & LCase(var_2C) & "â¢ profiler â¢completeâ¢"
  loc_005C3396: var_eax = call Proc_3_4_5A51B0(var_94, var_24, 3)
  loc_005C3411: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_94 & vbNullString, var_24, "<font face=""tahoma"">" & var_94 & vbNullString)
  loc_005C3432: GoTo loc_005C347A
  loc_005C3479: Exit Sub
  loc_005C347A: 'Referenced from: 005C3432
End Sub