ï»¿Private Sub Command1_Click() '5C0EB0
  Dim var_54 As TextBox
  Dim var_128 As TextBox
  loc_005C0F5B: var_eax = call Proc_79_31_607240(edi, Me, ebx)
  loc_005C0F84: var_38 = "â¢bodini 4.0â¢ im bomb â¢spekâ¢"
  loc_005C0FB3: var_eax = call Proc_3_4_5A51B0(var_74, var_24, 3)
  loc_005C0FBE: var_34 = var_74
  loc_005C0FF7: var_38 = Text1.Text
  loc_005C103C: var_40 = Text3.Text
  loc_005C1074: var_44 = vbNullString & var_40
  loc_005C1082: var_6C = var_44 & vbNullString
  loc_005C10C6: var_EC = vbNullString
  loc_005C10CC: var_10C = vbNullString
  loc_005C10DE: var_FC = "<p align center>"
  loc_005C117B: var_eax = call Proc_79_30_606DE0(vbNullString & var_38 & vbNullString, var_44 & vbNullString & Chr(13) & Chr(10) & vbNullString & & var_34 & vbNullString, var_54)
  loc_005C120D: var_128 = var_54
  loc_005C1229: var_38 = Text2.Text
  loc_005C126F: call __vbaStrR8
  loc_005C127A: var_3C = __vbaStrR8
  loc_005C128A: Text2.Text = var_3C
  loc_005C12E9: var_eax = FindWindow("#32770", "America Online")
  loc_005C12FD: setnz dl
  loc_005C1318: If edx <> 0 Then GoTo loc_005C1399
  loc_005C1337: var_38 = Text2.Text
  loc_005C135F: fcomp real8 ptr [00402230h]
  loc_005C1371: GoTo loc_005C1375
  loc_005C1375: 'Referenced from: 005C1371
  loc_005C138C: If ebx <> 0 Then GoTo loc_005C13A8
  loc_005C1394: GoTo loc_005C0F6C
  loc_005C1399: 'Referenced from: 005C1318
  loc_005C13A6: GoTo loc_005C1427
  loc_005C13A8: 'Referenced from: 005C138C
  loc_005C13B0: GoTo loc_005C13AE
  loc_005C1426: Exit Sub
  loc_005C1427: 'Referenced from: 005C13A6
  loc_005C1437: Exit Sub
End Sub