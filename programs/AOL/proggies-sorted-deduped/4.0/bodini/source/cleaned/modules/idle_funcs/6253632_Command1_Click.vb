ï»¿Private Sub Command1_Click() '5F6C40
  Dim var_34 As Variant
  Dim var_2C As Variant
  loc_005F6CBA: var_2C = Command1.Caption
  loc_005F6CED: ebx = (var_2C = "Start") + 1
  loc_005F6D07: If (var_2C = "Start") + 1 = 0 Then GoTo loc_005F6E63
  loc_005F6D15: var_2C = "â¢bodini 4.0â¢ idle bot â¢spekâ¢"
  loc_005F6D41: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005F6D8D: var_2C = "<font face=""tahoma"">" & var_54
  loc_005F6DA6: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F6DD5: Timer1.Enabled = True
  loc_005F6E0D: Timer2.Enabled = True
  loc_005F6E4A: Command1.Caption = "Stop"
  loc_005F6E51: If var_2C >= 0 Then GoTo loc_005F702E
  loc_005F6E5E: GoTo loc_005F7026
  loc_005F6E63: 'Referenced from: 005F6D07
  loc_005F6E6B: var_2C = "â¢bodini 4.0â¢ idle bot offâ¢"
  loc_005F6E97: var_eax = call Proc_3_4_5A51B0(var_54, var_24, 3)
  loc_005F6EE3: var_2C = "<font face=""tahoma"">" & var_54
  loc_005F6EFC: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F6F2B: Timer1.Enabled = False
  loc_005F6F63: Timer2.Enabled = False
  loc_005F6F9E: Command1.Caption = "Start"
  loc_005F6FD9: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F7016: var_eax = Unknown_VTable_Call[ecx+00000054h]
  loc_005F701D: If Unknown_VTable_Call[ecx+00000054h] >= 0 Then GoTo loc_005F702E
  loc_005F7026: 'Referenced from: 005F6E5E
  loc_005F7028: Unknown_VTable_Call[ecx+00000054h] = CheckObj(var_34, var_0042DCB0, 84)
  loc_005F702E: 'Referenced from: 005F6E51
  loc_005F703F: GoTo loc_005F7071
  loc_005F7070: Exit Sub
  loc_005F7071: 'Referenced from: 005F703F
End Sub