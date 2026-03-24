ï»¿Private Sub Command1_Click() '5A1FE0
  Dim var_34 As TextBox
  loc_005A205A: var_2C = Text1.Text
  loc_005A2090: esi = (var_2C = vbNullString) + 1
  loc_005A20A5: If (var_2C <> vbNullString) + 1 <> 0 Then GoTo loc_005A229C
  loc_005A20B6: var_2C = "â¢bodini 4.0â¢ attention â¢spekâ¢"
  loc_005A20E2: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005A2130: var_2C = "<font face=""tahoma"">" & var_54
  loc_005A2145: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A2170: var_eax = call Proc_6098C0(CLng(0.7), Me, @%StkVar2 & %x1)
  loc_005A2192: var_2C = Text1.Text
  loc_005A21C3: var_eax = call Proc_79_17_604A50(var_2C, var_34, ebx)
  loc_005A21EF: call Proc_6098C0(CLng(0.7), Me, var_34 = %S_edx_S)
  loc_005A2203: var_2C = "â¢bodini 4.0â¢ attention â¢spekâ¢"
  loc_005A222F: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005A226D: var_2C = "<font face=""tahoma"">" & var_54
  loc_005A2282: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A229C: 'Referenced from: 005A20A5
  loc_005A22A5: GoTo loc_005A22D7
  loc_005A22D6: Exit Sub
  loc_005A22D7: 'Referenced from: 005A22A5
End Sub