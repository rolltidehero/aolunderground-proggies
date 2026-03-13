Private Sub Timer1_Timer() '5C5760
  Dim var_40 As TextBox
  Dim var_120 As TextBox
  Dim var_44 As TextBox
  Dim var_B4 As OptionButton
  Dim var_2C As TextBox
  loc_005C580F: var_eax = call Proc_79_37_607940(var_54, Me, esi)
  loc_005C581C: var_64 = LCase(var_54)
  loc_005C583F: var_2C = Text3.Text
  loc_005C5877: var_30 = vbNullString & var_2C
  loc_005C5890: var_6C = var_30 & vbNullString
  loc_005C58B1: var_128 = (var_64 = LCase(var_30 & vbNullString))
  loc_005C58F9: If var_128 = 0 Then GoTo loc_005C60CA
  loc_005C591F: var_DC = vbNullString
  loc_005C5933: var_eax = call Proc_79_52_60A380(var_54, var_40, 8)
  loc_005C5946: var_EC = vbNullString
  loc_005C597A: var_2C = CStr(vbNullString & var_54 & vbNullString)
  loc_005C598A: Text4.Text = var_2C
  loc_005C59F1: var_118 = Option1.Value
  loc_005C5A1C: setz bl
  loc_005C5A2A: If ebx = 0 Then GoTo loc_005C5B7D
  loc_005C5A49: var_eax = call Proc_6098C0(CLng(0.5), var_40, Me)
  loc_005C5A6B: var_2C = Text4.Text
  loc_005C5A8F: var_4C = var_2C
  loc_005C5AA6: var_64 = LCase(0)
  loc_005C5AC9: var_30 = Text2.Text
  loc_005C5AF7: var_8C = var_30
  loc_005C5B27: var_EC = "• "
  loc_005C5B76: var_B4 = &H42EC60 & var_64 & "• " & var_30 &
  loc_005C5B78: GoTo loc_005C5F8A
  loc_005C5B7D: 'Referenced from: 005C5A2A
  loc_005C5B9D: var_118 = Option2.Value
  loc_005C5BC8: setz bl
  loc_005C5BD6: If ebx = 0 Then GoTo loc_005C6083
  loc_005C5BF9: var_2C = Text4.Text
  loc_005C5C1D: var_4C = var_2C
  loc_005C5C33: var_64 = LCase(0)
  loc_005C5C56: var_30 = Text2.Text
  loc_005C5CBD: var_DC = vbNullString
  loc_005C5CC3: var_EC = vbNullString
  loc_005C5CFB: var_eax = call Proc_79_30_606DE0(vbNullString & var_64 & vbNullString, vbNullString & var_30 & vbNullString, var_44)
  loc_005C5D5F: var_eax = call Proc_6098C0(CLng(0.5), var_44, var_64)
  loc_005C5D6D: var_ret_1 = "America Online"
  loc_005C5D7D: var_ret_2 = "#32770"
  loc_005C5D84: var_eax = FindWindow(var_ret_2, var_ret_1)
  loc_005C5D89: var_11C = FindWindow(var_ret_2, var_ret_1)
  loc_005C5DA5: setz al
  loc_005C5DC6: If var_120 <> 0 Then GoTo loc_005C60C8
  loc_005C5DD5: var_ret_3 = "America Online"
  loc_005C5DE5: var_ret_4 = "#32770"
  loc_005C5DEC: var_eax = FindWindow(var_ret_4, var_ret_3)
  loc_005C5DF1: var_11C = FindWindow(var_ret_4, var_ret_3)
  loc_005C5E0D: setnz dl
  loc_005C5E2E: If var_120 = 0 Then GoTo loc_005C6083
  loc_005C5E4D: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005C5E73: var_2C = Text4.Text
  loc_005C5E9D: var_4C = var_2C
  loc_005C5EB3: var_64 = LCase(0)
  loc_005C5ED6: var_30 = Text2.Text
  loc_005C5F01: var_8C = var_30
  loc_005C5F44: var_EC = "• "
  loc_005C5F88: var_B4 = &H42EC60 & var_64 & "• " & 0 &
  loc_005C5F8A: 'Referenced from: 005C5B78
  loc_005C5F98: var_34 = var_B4
  loc_005C5FCF: var_eax = call Proc_3_4_5A51B0(var_D4, var_24, 3)
  loc_005C6054: var_2C = "<font face=""tahoma"">" & var_D4
  loc_005C6069: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_44, var_64)
  loc_005C6081: GoTo loc_005C60C8
  loc_005C6083: 'Referenced from: 005C5BD6
  loc_005C60A1: Text4.Text = vbNullString
  loc_005C60C8: 'Referenced from: 005C5DC6
  loc_005C60CA: 'Referenced from: 005C58F9
  loc_005C60D3: GoTo loc_005C6143
  loc_005C6142: Exit Sub
  loc_005C6143: 'Referenced from: 005C60D3
End Sub