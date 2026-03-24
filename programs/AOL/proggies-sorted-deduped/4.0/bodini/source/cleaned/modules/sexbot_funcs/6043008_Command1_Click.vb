ï»¿Private Sub Command1_Click() '5C3580
  loc_005C35FE: var_eax = call Proc_79_19_604D70(edi, esi, Me)
  loc_005C361C: var_24 = call Proc_79_19_604D70(edi, esi, Me)
  loc_005C3646: If (var_24 = "") = 0 Then GoTo loc_005C36E5
  loc_005C3688: var_64 = "bodini by: spek"
  loc_005C36A7: var_54 = "please enter a chat room"
  loc_005C36E5: 'Referenced from: 005C3646
  loc_005C3700: Timer1.Enabled = True
  loc_005C372D: GoTo loc_005C3732
  loc_005C372F: 
  loc_005C3732: 'Referenced from: 005C372D
  loc_005C3744: var_3C = "â¢bodini 4.0â¢ sex bot â¢spekâ¢"
  loc_005C3773: var_eax = call Proc_3_4_5A51B0(var_64, var_34, 3)
  loc_005C37B5: var_3C = "<font face=""tahoma"">" & var_64
  loc_005C37CA: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_34, var_3C)
  loc_005C37F4: var_3C = "â¢/sexâ¢ to get some...â¢"
  loc_005C3823: var_eax = call Proc_3_4_5A51B0(var_64, var_34, 3)
  loc_005C3865: var_3C = "<font face=""tahoma"">" & var_64
  loc_005C387A: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_34, var_3C)
  loc_005C38A3: var_eax = call Proc_6098C0(&H3C, , )
  loc_005C38C8: var_C8 = Timer1.Enabled
  loc_005C38EC: setnz bl
  loc_005C38FA: If ebx <> 0 Then GoTo loc_005C372F
  loc_005C390C: GoTo loc_005C3949
  loc_005C3948: Exit Sub
  loc_005C3949: 'Referenced from: 005C390C
End Sub