Private Sub Command1_Click() '5F7FA0
  loc_005F80C2: var_18 = Text1.Text
  loc_005F81E6: var_74 = vbNullString & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13) & Chr$(13)
  loc_005F81F2: var_78 = Chr$(13)
  loc_005F81F7: var_AC = var_74 & var_78
  loc_005F8210: var_A4 = Chr(9)
  loc_005F8239: var_7C = Text2.Text
  loc_005F8260: var_CC = var_7C
  loc_005F828B: var_104 = Chr(9)
  loc_005F82B4: var_80 = Text3.Text
  loc_005F82DB: var_11C = var_80
  loc_005F830E: var_15C = vbNullString
  loc_005F83B2: var_eax = call Proc_79_30_606DE0(vbNullString & var_18 & vbNullString, var_74 & var_78 & var_A4 & var_7C & &H431C88 & var_104 & 0 & vbNullString, var_94)
  loc_005F84B8: GoTo loc_005F85BB
  loc_005F85BA: Exit Sub
  loc_005F85BB: 'Referenced from: 005F84B8
End Sub