Private Sub Text5_KeyPress(KeyAscii As Integer) '5CBE30
  loc_005CBE94: If KeyAscii <> 13 Then GoTo loc_005CC000
  loc_005CBEB7: var_2C = Text5.Text
  loc_005CBF03: var_34 = vbNullString & var_2C & vbNullString
  loc_005CBF2B: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005CBF99: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_58 & vbNullString, Me, Me)
  loc_005CBFCF: Text5.Text = vbNullString
  loc_005CC000: 'Referenced from: 005CBE94
  loc_005CC008: GoTo loc_005CC03E
  loc_005CC03D: Exit Sub
  loc_005CC03E: 'Referenced from: 005CC008
End Sub