ï»¿Private Sub Timer2_Timer() '5E0750
  loc_005E07D0: var_70 = Timer2.Enabled
  loc_005E07F1: setz al
  loc_005E0802: If eax <> 0 Then GoTo loc_005E0C49
  loc_005E083A: var_2C = Text1.Text
  loc_005E087D: call __vbaStrR8
  loc_005E08A1: Text1.Text = __vbaStrR8
  loc_005E08FF: var_2C = Text1.Text
  loc_005E0949: var_34 = "â¢bodini 4.0â¢ mm bot â¢" & var_2C & " min(s)â¢"
  loc_005E0971: var_eax = call Proc_3_4_5A51B0(var_5C, var_24, 3)
  loc_005E09DF: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_5C & vbNullString, var_3C, Me)
  loc_005E0A0A: var_eax = call Proc_6098C0(CLng(0.45), , )
  loc_005E0A2D: var_2C = Text2.Text
  loc_005E0A74: var_34 = "â¢typeâ¢ " & var_2C & " â¢ to addâ¢"
  loc_005E0A9C: var_eax = call Proc_3_4_5A51B0(var_5C, var_24, 3)
  loc_005E0B0A: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_5C & vbNullString, Me, Me)
  loc_005E0B35: var_eax = call Proc_6098C0(CLng(0.45), , )
  loc_005E0B57: var_2C = Text3.Text
  loc_005E0B9B: var_34 = "â¢typeâ¢ " & var_2C & " â¢ to removeâ¢"
  loc_005E0BC3: var_eax = call Proc_3_4_5A51B0(var_5C, var_24, 3)
  loc_005E0C33: call Proc_79_17_604A50("<font face=""tahoma"">" & var_5C & vbNullString, %v = "", Me)
  loc_005E0C49: 'Referenced from: 005E0802
  loc_005E0C52: GoTo loc_005E0C8C
  loc_005E0C8B: Exit Sub
  loc_005E0C8C: 'Referenced from: 005E0C52
  loc_005E0C9E: Exit Sub
End Sub