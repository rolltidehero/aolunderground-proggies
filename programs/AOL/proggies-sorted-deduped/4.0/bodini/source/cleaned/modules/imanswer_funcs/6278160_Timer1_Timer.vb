ï»¿Private Sub Timer1_Timer() '5FCC10
  Dim var_70 As TextBox
  loc_005FCCE1: var_60 = "â¢bodini 4.0â¢ im answer â¢spekâ¢"
  loc_005FCD13: var_eax = call Proc_3_4_5A51B0(var_90, var_3C, 3)
  loc_005FCD21: var_5C = var_90
  loc_005FCD45: var_ret_1 = "AOL Frame25"
  loc_005FCD4C: var_eax = FindWindow(var_ret_1, 0)
  loc_005FCD7B: var_eax = FindWindowEx(FindWindow(var_ret_1, 0), esi, "MDIClient", 0)
  loc_005FCD8B: var_eax = call Proc_79_18_604B70(var_3C, var_60, var_174)
  loc_005FCD9A: var_17C = call Proc_79_18_604B70(var_3C, var_60, var_174)
  loc_005FCDA0: var_ret_3 = "RICHCNTL"
  loc_005FCDAF: var_eax = FindWindowEx(var_17C, esi, var_ret_3, 0)
  loc_005FCDDF: var_4C = FindWindowEx(var_17C, esi, var_ret_3, 0)
  loc_005FCDF7: If CBool(var_4C) = 0 Then GoTo loc_005FD1AA
  loc_005FCE4B: var_eax = call Proc_79_33_607380(var_124, , )
  loc_005FCE55: var_60 = call Proc_79_33_607380(var_124, , )
  loc_005FCE65: var_eax = List1.AddItem var_60
  loc_005FCEE3: var_eax = call Proc_79_34_6074B0(var_124, , )
  loc_005FCEED: var_60 = call Proc_79_34_6074B0(var_124, , )
  loc_005FCEFD: var_eax = List2.AddItem var_60
  loc_005FCF32: var_eax = call Proc_79_33_607380(vbNullString, var_70, Me)
  loc_005FCF6E: var_2C = Me & call Proc_79_33_607380(vbNullString, var_70, Me) & vbNullString
  loc_005FCFA4: var_60 = Text1.Text
  loc_005FCFD8: var_64 = vbNullString & var_60
  loc_005FCFF1: var_A8 = var_64 & vbNullString
  loc_005FD030: var_148 = vbNullString
  loc_005FD036: var_168 = vbNullString
  loc_005FD051: var_158 = "<p align center>"
  loc_005FD0D9: var_128 = vbNullString
  loc_005FD0DF: var_138 = vbNullString
  loc_005FD117: var_eax = call Proc_79_30_606DE0(vbNullString & var_2C & vbNullString, var_64 & vbNullString & Chr(13) & Chr(10) & vbNullString & "<p align center>" & var_5C & vbNullString, var_70)
  loc_005FD195: var_eax = call Proc_79_18_604B70(, , )
  loc_005FD19F: var_eax = SendMessage(call Proc_79_18_604B70(, , ), 16, esi, esi)
  loc_005FD1AA: 'Referenced from: 005FCDF7
  loc_005FD1B2: GoTo loc_005FD22E
  loc_005FD22D: Exit Sub
  loc_005FD22E: 'Referenced from: 005FD1B2
End Sub