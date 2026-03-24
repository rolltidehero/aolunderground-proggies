ï»¿Private Sub Text1_KeyPress(KeyAscii As Integer) '5A23E0
  loc_005A2444: If KeyAscii <> 13 Then GoTo loc_005A26B3
  loc_005A2467: var_2C = Text1.Text
  loc_005A24A3: esi = (var_2C = vbNullString) + 1
  loc_005A24B4: If (var_2C <> vbNullString) + 1 <> 0 Then GoTo loc_005A26B1
  loc_005A24C9: var_2C = "â¢bodini 4.0â¢ attention â¢spekâ¢"
  loc_005A24F5: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005A253F: var_2C = "<font face=""tahoma"">" & var_54
  loc_005A2554: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A2578: var_6C = CLng(0.7)
  loc_005A257F: var_eax = call Proc_6098C0(var_6C, Me, @%StkVar2 & %x1)
  loc_005A25A1: var_2C = Text1.Text
  loc_005A25D2: var_eax = call Proc_79_17_604A50(var_2C, var_34, call Proc_6098C0(var_6C, Me, @%StkVar2 & %x1))
  loc_005A25FE: call Proc_6098C0(CLng(0.7), Me, var_34 = %S_edx_S)
  loc_005A2612: var_2C = "â¢bodini 4.0â¢ attention â¢spekâ¢"
  loc_005A263E: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005A267C: var_2C = "<font face=""tahoma"">" & var_54
  loc_005A2691: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A26B1: 'Referenced from: 005A24B4
  loc_005A26B3: 'Referenced from: 005A2444
  loc_005A26BC: GoTo loc_005A26EE
  loc_005A26ED: Exit Sub
  loc_005A26EE: 'Referenced from: 005A26BC
End Sub