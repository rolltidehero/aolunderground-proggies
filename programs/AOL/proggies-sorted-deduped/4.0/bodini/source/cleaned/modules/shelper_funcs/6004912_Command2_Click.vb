ï»¿Private Sub Command2_Click() '5BA0B0
  Dim var_3C As TextBox
  loc_005BA16F: var_2C = Text1.Text
  loc_005BA193: var_44 = var_2C
  loc_005BA1A6: var_5C = LCase(var_2C)
  loc_005BA1C9: var_30 = Text3.Text
  loc_005BA1F0: var_84 = var_30
  loc_005BA238: var_F4 = " find "
  loc_005BA248: var_104 = vbNullString
  loc_005BA29E: var_34 = &H43137C & var_5C & " find " & LCase(var_30) & vbNullString
  loc_005BA2D5: var_eax = call Proc_3_4_5A51B0(var_DC, var_24, 3)
  loc_005BA373: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_DC & vbNullString, var_3C, var_5C)
  loc_005BA393: GoTo loc_005BA3FF
  loc_005BA3FE: Exit Sub
  loc_005BA3FF: 'Referenced from: 005BA393
End Sub