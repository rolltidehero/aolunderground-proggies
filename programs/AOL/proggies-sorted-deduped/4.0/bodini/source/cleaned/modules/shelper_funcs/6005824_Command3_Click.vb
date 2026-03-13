ï»¿Private Sub Command3_Click() '5BA440
  Dim var_38 As TextBox
  Dim var_3C As TextBox
  Dim var_5C As TextBox
  loc_005BA50B: var_2C = Text5.Text
  loc_005BA54C: var_30 = Text4.Text
  loc_005BA585: setle cl
  loc_005BA5B7: If var_138 = 0 Then GoTo loc_005BA633
  loc_005BA5F2: var_4C = "the starting number must be less then the ending number moron."
  loc_005BA62E: GoTo loc_005BAE18
  loc_005BA633: 'Referenced from: 005BA5B7
  loc_005BA647: var_128 = var_38
  loc_005BA64D: Text4.Enabled = edi
  loc_005BA694: Text5.Enabled = edi
  loc_005BA6D4: var_130 = var_3C
  loc_005BA6F4: var_2C = Text4.Text
  loc_005BA725: var_eax = Unknown_VTable_Call[edx+00000054h]
  loc_005BA77C: var_2C = Text1.Text
  loc_005BA7A6: var_44 = var_2C
  loc_005BA7B8: var_5C = LCase(var_2C)
  loc_005BA7DB: var_30 = Text4.Text
  loc_005BA808: var_84 = var_30
  loc_005BA865: var_F4 = " send "
  loc_005BA86F: var_104 = vbNullString
  loc_005BA8BD: var_34 = &H43137C & var_5C & " send " & LCase(var_30) & vbNullString
  loc_005BA8F4: var_eax = call Proc_3_4_5A51B0(var_DC, var_24, 3)
  loc_005BA998: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_DC & vbNullString, var_3C, var_5C)
  loc_005BA9B0: GoTo loc_005BA9B8
  loc_005BA9B2: 
  loc_005BA9CF: var_eax = call Proc_6098C0(var_124, , )
  loc_005BA9E4: var_130 = call Proc_6098C0(var_124, , )
  loc_005BAA03: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005BAA43: call __vbaStrR8
  loc_005BAA4E: var_30 = __vbaStrR8
  loc_005BAA64: var_eax = Unknown_VTable_Call[eax+00000054h]
  loc_005BAABC: var_2C = Text1.Text
  loc_005BAAE0: var_44 = var_2C
  loc_005BAAF7: var_5C = LCase(0)
  loc_005BAB1E: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005BAB45: var_84 = var_30
  loc_005BABA1: var_F4 = " send "
  loc_005BABAB: var_104 = vbNullString
  loc_005BABF5: var_34 = &H43137C & var_5C & " send " & LCase(0) & vbNullString
  loc_005BAC2C: var_eax = call Proc_3_4_5A51B0(var_DC, var_24, 3)
  loc_005BACB5: var_2C = "<font face=""tahoma"">" & var_DC
  loc_005BACCA: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_3C, var_2C & vbNullString)
  loc_005BACFF: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005BAD34: var_30 = Text5.Text
  loc_005BAD90: If (var_2C <> var_30) <> 0 Then GoTo loc_005BA9B2
  loc_005BADB3: Text4.Enabled = True
  loc_005BADF3: Text5.Enabled = True
  loc_005BAE18: 'Referenced from: 005BA62E
  loc_005BAE21: GoTo loc_005BAE8D
  loc_005BAE8C: Exit Sub
  loc_005BAE8D: 'Referenced from: 005BAE21
  loc_005BAE9F: Exit Sub
End Sub