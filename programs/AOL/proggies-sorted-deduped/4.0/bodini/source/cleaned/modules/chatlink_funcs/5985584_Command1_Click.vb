ï»¿Private Sub Command1_Click() '5B5530
  Dim var_38 As TextBox
  Dim var_18 As TextBox
  loc_005B55AF: var_3C = Check1.Value
  loc_005B55D7: setz al
  loc_005B55E8: If eax = 0 Then GoTo loc_005B56EF
  loc_005B5607: var_18 = Text1.Text
  loc_005B563E: var_20 = Text2.Text
  loc_005B56B9: var_eax = call Proc_79_17_604A50("< a href=" & var_18 & "></u>" & var_20 & vbNullString & "</a>", var_38, var_18)
  loc_005B56EA: GoTo loc_005B57EB
  loc_005B56EF: 'Referenced from: 005B55E8
  loc_005B5708: var_18 = Text1.Text
  loc_005B573F: var_20 = Text2.Text
  loc_005B57BA: var_eax = call Proc_79_17_604A50("< a href=" & var_18 & var_0042E8A4 & var_20 & vbNullString & "</a>", var_38, var_18)
  loc_005B57EB: 'Referenced from: 005B56EA
  loc_005B5802: GoTo loc_005B583C
  loc_005B583B: Exit Sub
  loc_005B583C: 'Referenced from: 005B5802
End Sub