Private Sub Command1_Click() '5B5930
  Dim var_18 As TextBox
  Dim var_44 As TextBox
  Dim var_20 As TextBox
  loc_005B59B9: var_48 = Check1.Value
  loc_005B59E4: setz dl
  loc_005B59F7: If var_54 = 0 Then GoTo loc_005B5B57
  loc_005B5A16: var_18 = Text1.Text
  loc_005B5A4D: var_20 = Text2.Text
  loc_005B5A84: var_28 = Text3.Text
  loc_005B5B15: var_eax = call Proc_79_30_606DE0(vbNullString & var_18 & vbNullString, "< a href=" & var_20 & "></u>" & var_28 & "</a>", var_44)
  loc_005B5B52: GoTo loc_005B5CAC
  loc_005B5B57: 'Referenced from: 005B59F7
  loc_005B5B70: var_18 = Text1.Text
  loc_005B5BA7: var_20 = Text2.Text
  loc_005B5BDE: var_28 = Text3.Text
  loc_005B5C6F: var_eax = call Proc_79_30_606DE0(vbNullString & var_18 & vbNullString, "< a href=" & var_20 & var_0042E8A4 & var_28 & "</a>", var_44)
  loc_005B5CAC: 'Referenced from: 005B5B52
  loc_005B5CC3: GoTo loc_005B5D09
  loc_005B5D08: Exit Sub
  loc_005B5D09: 'Referenced from: 005B5CC3
End Sub