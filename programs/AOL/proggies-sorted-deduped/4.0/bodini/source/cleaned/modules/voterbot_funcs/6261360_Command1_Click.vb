ï»¿Private Sub Command1_Click() '5F8A70
  Dim var_38 As Variant
  Dim var_2C As Variant
  loc_005F8AF0: var_2C = Command1.Caption
  loc_005F8B26: esi = (var_2C = "Start") + 1
  loc_005F8B3C: If (var_2C = "Start") + 1 = 0 Then GoTo loc_005F8F06
  loc_005F8B4A: var_2C = "â¢bodini 4.0â¢ voter bot â¢spekâ¢"
  loc_005F8B76: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005F8BC0: var_2C = "<font face=""tahoma"">" & var_58
  loc_005F8BD5: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F8C00: var_eax = call Proc_6098C0(CLng(0.7), Me, Me)
  loc_005F8C23: var_2C = Text2.Text
  loc_005F8C6A: var_34 = "â¢questionâ¢ " & var_2C & var_0042EC60
  loc_005F8C92: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005F8D00: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_58 & vbNullString, Me, Me)
  loc_005F8D2B: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005F8D3F: var_2C = "â¢typeâ¢ yes â¢to vote yes"
  loc_005F8D6B: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005F8DAD: var_2C = "<font face=""tahoma"">" & var_58
  loc_005F8DC2: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F8DED: var_eax = call Proc_6098C0(CLng(0.7), , )
  loc_005F8E01: var_2C = "â¢typeâ¢ no â¢to vote no"
  loc_005F8E2D: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005F8E6F: var_2C = "<font face=""tahoma"">" & var_58
  loc_005F8E84: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F8EB9: Timer1.Enabled = True
  loc_005F8EF4: Command1.Caption = "Stop"
  loc_005F8EFB: If Me >= 0 Then GoTo loc_005F9293
  loc_005F8F01: GoTo loc_005F9284
  loc_005F8F06: 'Referenced from: 005F8B3C
  loc_005F8F0E: var_2C = "â¢bodini 4.0â¢ voter bot offâ¢"
  loc_005F8F3A: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005F8F84: var_2C = "<font face=""tahoma"">" & var_58
  loc_005F8F99: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005F8FC0: var_74 = CLng(0.7)
  loc_005F8FC4: var_eax = call Proc_6098C0(var_74, Me, var_38)
  loc_005F8FE7: var_6C = List1.ListCount
  loc_005F903C: var_34 = var_0042EC60 & CStr(var_6C) & "â¢ voted yesâ¢"
  loc_005F9064: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005F90D2: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_58 & vbNullString, call Proc_6098C0(var_74, Me, var_38), Me)
  loc_005F90F9: var_74 = CLng(0.5)
  loc_005F90FD: var_eax = call Proc_6098C0(var_74, , )
  loc_005F9120: var_6C = List2.ListCount
  loc_005F9175: var_34 = var_0042EC60 & CStr(var_6C) & "â¢ voted noâ¢"
  loc_005F919D: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005F91F6: var_2C = "<font face=""tahoma"">" & var_58
  loc_005F920B: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, call Proc_6098C0(var_74, , ), Me)
  loc_005F9240: Timer1.Enabled = False
  loc_005F927B: Command1.Caption = "Start"
  loc_005F9282: If var_2C >= 0 Then GoTo loc_005F9293
  loc_005F9284: 'Referenced from: 005F8F01
  loc_005F928D: var_2C = CheckObj(var_2C, var_0042CCB8, 84)
  loc_005F9293: 'Referenced from: 005F8EFB
  loc_005F92A9: GoTo loc_005F92DF
  loc_005F92DE: Exit Sub
  loc_005F92DF: 'Referenced from: 005F92A9
End Sub