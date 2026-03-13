Private Sub Command1_Click() '5BB7E0
  loc_005BB83E: var_ret_1 = "AOL Frame25"
  loc_005BB845: var_eax = FindWindow(var_ret_1, 0)
  loc_005BB84A: var_30 = FindWindow(var_ret_1, 0)
  loc_005BB870: var_1C = Text1.Text
  loc_005BB8CE: var_eax = SendMessage(var_30, 12, edi, vbNullString & var_1C & vbNullString)
  loc_005BB909: GoTo loc_005BB934
  loc_005BB933: Exit Sub
  loc_005BB934: 'Referenced from: 005BB909
End Sub