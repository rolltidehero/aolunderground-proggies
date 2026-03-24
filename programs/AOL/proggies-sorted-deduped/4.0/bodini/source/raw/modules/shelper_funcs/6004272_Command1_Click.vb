Private Sub Command1_Click() '5B9E30
  loc_005B9ECB: var_2C = Text1.Text
  loc_005B9EEF: var_3C = var_2C
  loc_005B9F39: var_AC = " send list"
  loc_005B9F67: var_30 = &H43137C & LCase(var_2C) & " send list"
  loc_005B9F9B: var_eax = call Proc_3_4_5A51B0(var_94, var_24, 3)
  loc_005BA016: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_94 & vbNullString, var_24, "<font face=""tahoma"">" & var_94 & vbNullString)
  loc_005BA036: GoTo loc_005BA07E
  loc_005BA07D: Exit Sub
  loc_005BA07E: 'Referenced from: 005BA036
End Sub