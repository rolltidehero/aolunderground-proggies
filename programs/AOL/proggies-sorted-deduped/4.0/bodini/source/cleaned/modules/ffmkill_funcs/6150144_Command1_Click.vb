ï»¿Private Sub Command1_Click() '5DD800
  loc_005DD877: var_2C = Command1.Caption
  loc_005DD8A7: edi = (var_2C = "Start") + 1
  loc_005DD8BC: If (var_2C = "Start") + 1 = 0 Then GoTo loc_005DD9F1
  loc_005DD8CD: var_2C = "â¢bodini 4.0â¢ 45 minute kill â¢spekâ¢"
  loc_005DD8F9: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005DD947: var_2C = "<font face=""tahoma"">" & var_54
  loc_005DD95C: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005DD98F: Timer1.Enabled = True
  loc_005DD9CE: Command1.Caption = "Stop"
  loc_005DDA14: var_2C = Command1.Caption
  loc_005DDA44: ebx = (var_2C = "Stop") + 1
  loc_005DDA59: If (var_2C = "Stop") + 1 = 0 Then GoTo loc_005DDB86
  loc_005DDA6E: var_2C = "â¢bodini 4.0â¢ 45 minute kill offâ¢"
  loc_005DDA9A: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005DDAE2: var_2C = "<font face=""tahoma"">" & var_54
  loc_005DDAF7: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005DDB2C: Timer1.Enabled = False
  loc_005DDB69: Command1.Caption = "Start"
  loc_005DDB86: 'Referenced from: 005DDA59
  loc_005DDB92: GoTo loc_005DDBC4
  loc_005DDBC3: Exit Sub
  loc_005DDBC4: 'Referenced from: 005DDB92
End Sub