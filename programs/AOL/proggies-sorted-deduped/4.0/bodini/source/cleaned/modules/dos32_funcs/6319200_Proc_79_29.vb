ï»¿Public Sub Proc_79_29_606C60
  loc_00606C9A: var_eax = call Proc_79_19_604D70(edi, esi, ebx)
  loc_00606CA1: If call Proc_79_19_604D70(edi, esi, ebx) = 0 Then GoTo loc_00606DA5
  loc_00606CBA: If (Me = vbNullString) = 0 Then GoTo loc_00606DA5
  loc_00606CC1: var_eax = call Proc_79_39_607F30(Me, , )
  loc_00606CD7: var_14 = call Proc_79_39_607F30(Me, , )
  loc_00606CE2: If 00000001h > 0 Then GoTo loc_00606DA5
  loc_00606CF0: var_eax = call Proc_79_40_608080(Me, var_20, )
  loc_00606CFA: var_1C = call Proc_79_40_608080(Me, var_20, )
  loc_00606D05: If Len(var_1C) <= 3 Then GoTo loc_00606D6A
  loc_00606D10: If Len(var_1C) <= 92 Then GoTo loc_00606D49
  loc_00606D1F: var_38 = var_1C
  loc_00606D3E: var_1C = Left(var_1C, 92)
  loc_00606D49: 'Referenced from: 00606D10
  loc_00606D4D: var_eax = call Proc_79_17_604A50(var_1C, , )
  loc_00606D65: var_eax = call Proc_6098C0(CLng(0.6), , )
  loc_00606D6A: 'Referenced from: 00606D05
  loc_00606D6A: 00000001h = 00000001h + 00000001h
  loc_00606D72: If 00000001h <= 4 Then GoTo loc_00606D91
  loc_00606D8C: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_00606D91: 'Referenced from: 00606D72
  loc_00606D99: 00000001h = 00000001h + var_20
  loc_00606DA0: GoTo loc_00606CDF
  loc_00606DA5: 'Referenced from: 00606CA1
  loc_00606DAB: GoTo loc_00606DB7
  loc_00606DB6: Exit Sub
  loc_00606DB7: 'Referenced from: 00606DAB
  loc_00606DC0: Exit Sub
End Sub