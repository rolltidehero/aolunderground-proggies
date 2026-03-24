ï»¿Private Sub Form_Unload(Cancel As Integer) '5B8F60
  loc_005B8FD4: var_18 = Text1.Text
  loc_005B9000: var_2C = "bodini.ini"
  loc_005B9055: var_eax = call Proc_79_43_6089A0("Media Player", "Last Used", vbNullString & var_18 & vbNullString)
  loc_005B908E: GoTo loc_005B90BD
  loc_005B90BC: Exit Sub
  loc_005B90BD: 'Referenced from: 005B908E
End Sub