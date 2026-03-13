ï»¿Private Sub Timer1_Timer() '5A7520
  loc_005A75B8: var_eax = call Proc_79_52_60A380(var_44, var_34, Me)
  loc_005A75C7: var_2C = CStr(var_44)
  loc_005A75D7: Text2.Text = var_2C
  loc_005A761F: var_3C = var_2C
  loc_005A7631: var_54 = LCase(var_2C)
  loc_005A763C: var_5C = var_54
  loc_005A764E: var_74 = LCase(var_54)
  loc_005A767E: If (var_54 = var_74) = 0 Then GoTo loc_005A779F
  loc_005A7688: var_eax = call Proc_79_37_607940(9, Me, Me)
  loc_005A76A9: var_8C = vbNullString
  loc_005A76AF: var_9C = vbNullString
  loc_005A76EE: var_2C = vbNullString & var_2C & vbNullString
  loc_005A771C: var_eax = call Proc_3_4_5A51B0(var_84, var_24, 3)
  loc_005A7772: var_2C = "<font face=""tahoma"">" & var_84
  loc_005A7787: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005A779F: 'Referenced from: 005A767E
  loc_005A77A7: GoTo loc_005A77E8
  loc_005A77E7: Exit Sub
  loc_005A77E8: 'Referenced from: 005A77A7
End Sub