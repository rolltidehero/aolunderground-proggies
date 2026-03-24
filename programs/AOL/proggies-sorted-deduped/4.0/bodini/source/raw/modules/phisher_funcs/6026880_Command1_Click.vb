Private Sub Command1_Click() '5BF680
  Dim var_40 As ListBox
  Dim var_44 As TextBox
  loc_005BF720: var_78 = List1.ListCount
  loc_005BF745: var_78 = var_78 - 0001h
  loc_005BF752: var_5C = var_78
  loc_005BF77C: For var_28 = "" To var_78 Step 1
  loc_005BF785: var_B4 = var_28
  loc_005BF79D: If var_B4 = 0 Then GoTo loc_005BF8CE
  loc_005BF7C9: var_28 = CInt(var_2C)
  loc_005BF7D1: var_40 = List1.List(var_28)
  loc_005BF815: var_30 = Text1.Text
  loc_005BF875: var_eax = call Proc_79_30_606DE0(var_2C, vbNullString & var_30 & vbNullString, var_44)
  loc_005BF8BD: Next var_28
  loc_005BF8C3: var_B4 = Next var_28
  loc_005BF8C9: GoTo loc_005BF797
  loc_005BF8CE: 'Referenced from: 005BF79D
  loc_005BF8D6: GoTo loc_005BF908
  loc_005BF907: Exit Sub
  loc_005BF908: 'Referenced from: 005BF8D6
  loc_005BF92A: Exit Sub
End Sub