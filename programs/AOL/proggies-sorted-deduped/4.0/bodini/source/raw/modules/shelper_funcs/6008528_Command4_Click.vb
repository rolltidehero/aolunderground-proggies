Private Sub Command4_Click() '5BAED0
  Dim var_3C As TextBox
  loc_005BAF8F: var_2C = Text1.Text
  loc_005BAFB3: var_44 = var_2C
  loc_005BAFC6: var_5C = LCase(var_2C)
  loc_005BAFE9: var_30 = Text2.Text
  loc_005BB010: var_84 = var_30
  loc_005BB058: var_F4 = " send "
  loc_005BB068: var_104 = vbNullString
  loc_005BB0BE: var_34 = &H43137C & var_5C & " send " & LCase(var_30) & vbNullString
  loc_005BB0F5: var_eax = call Proc_3_4_5A51B0(var_DC, var_24, 3)
  loc_005BB193: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_DC & vbNullString, var_3C, var_5C)
  loc_005BB1B3: GoTo loc_005BB21F
  loc_005BB21E: Exit Sub
  loc_005BB21F: 'Referenced from: 005BB1B3
End Sub