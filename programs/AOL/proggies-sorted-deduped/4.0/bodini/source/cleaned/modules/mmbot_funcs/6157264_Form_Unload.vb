ï»¿Private Sub Form_Unload(Cancel As Integer) '5DF3D0
  Dim var_18 As TextBox
  loc_005DF444: var_18 = Text1.Text
  loc_005DF470: var_2C = "bodini.ini"
  loc_005DF4C5: var_eax = call Proc_79_43_6089A0("Mass Mailer", "Bot Time", vbNullString & var_18 & vbNullString)
  loc_005DF514: var_18 = Text2.Text
  loc_005DF53D: var_2C = "bodini.ini"
  loc_005DF58C: var_eax = call Proc_79_43_6089A0("Mass Mailer", "Bot Add", vbNullString & var_18 & vbNullString)
  loc_005DF5DA: var_18 = Text3.Text
  loc_005DF600: var_2C = "bodini.ini"
  loc_005DF64D: var_eax = call Proc_79_43_6089A0("Mass Mailer", "Bot Remove", vbNullString & var_18 & vbNullString)
  loc_005DF68A: GoTo loc_005DF6B9
  loc_005DF6B8: Exit Sub
  loc_005DF6B9: 'Referenced from: 005DF68A
End Sub