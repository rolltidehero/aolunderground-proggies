Private Sub Timer2_Timer() '5C6180
  loc_005C61EA: var_2C = "•bodini 4.0• request bot •spek•"
  loc_005C6216: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005C6264: var_2C = "<font face=""tahoma"">" & var_58
  loc_005C6279: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005C62A4: var_eax = call Proc_6098C0(CLng(0.5), ebx, )
  loc_005C62CA: var_2C = Text1.Text
  loc_005C630D: var_34 = "•requesting• " & var_2C & var_0042EC60
  loc_005C6335: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005C63A3: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_58 & vbNullString, Me, Me)
  loc_005C63CE: var_eax = call Proc_6098C0(CLng(0.7), , )
  loc_005C63F4: var_2C = Text3.Text
  loc_005C6437: var_34 = "•type• " & var_2C & " • if you have it•"
  loc_005C645F: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005C64CD: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_58 & vbNullString, Me, Me)
  loc_005C64EE: GoTo loc_005C6524
  loc_005C6523: Exit Sub
  loc_005C6524: 'Referenced from: 005C64EE
End Sub