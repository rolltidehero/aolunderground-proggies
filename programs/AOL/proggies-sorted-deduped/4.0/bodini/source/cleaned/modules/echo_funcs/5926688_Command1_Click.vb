ï»¿Private Sub Command1_Click() '5A6F20
  Dim var_2C As Variant
  loc_005A6FC1: var_2C = Command1.Caption
  loc_005A6FF1: ebx = (var_2C = "Start") + 1
  loc_005A700C: If (var_2C = "Start") + 1 = 0 Then GoTo loc_005A729F
  loc_005A701A: var_2C = "â¢bodini 4.0â¢ echo bot â¢spekâ¢"
  loc_005A7049: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005A7097: var_2C = "<font face=""tahoma"">" & var_54
  loc_005A70AC: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A70DD: call Proc_6098C0(CLng(0.3), Me, var_2C = %S_edx_S)
  loc_005A70FD: var_54 = LCase(Me)
  loc_005A711E: var_9C = "â¢echo:â¢ "
  loc_005A7165: var_2C = "â¢echo:â¢ " & var_54 & &H42EC60
  loc_005A7199: var_eax = call Proc_3_4_5A51B0(var_94, var_24, 3)
  loc_005A71F4: var_2C = "<font face=""tahoma"">" & var_94
  loc_005A7209: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A723E: Timer1.Enabled = True
  loc_005A727B: Command1.Caption = "Stop"
  loc_005A729A: GoTo loc_005A73CB
  loc_005A729F: 'Referenced from: 005A700C
  loc_005A72A7: var_2C = "â¢bodini 4.0â¢ echo bot offâ¢"
  loc_005A72D6: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005A7322: var_2C = "<font face=""tahoma"">" & var_54
  loc_005A733B: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A736D: Timer1.Enabled = edi
  loc_005A73AE: Command1.Caption = "Start"
  loc_005A73CB: 'Referenced from: 005A729A
  loc_005A73D4: GoTo loc_005A741C
  loc_005A741B: Exit Sub
  loc_005A741C: 'Referenced from: 005A73D4
End Sub