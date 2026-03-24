ï»¿Private Sub Command2_Click() '5F4670
  loc_005F4705: var_3C = "â¢bodini 4.0â¢ scrambler bot scoresâ¢"
  loc_005F4734: var_eax = call Proc_3_4_5A51B0(var_68, var_34, 3)
  loc_005F4780: var_3C = "<font face=""tahoma"">" & var_68
  loc_005F4799: var_eax = call Proc_79_17_604A50(var_3C & vbNullString, var_34, var_3C)
  loc_005F47BD: var_A0 = CLng(0.75)
  loc_005F47CA: var_eax = call Proc_6098C0(var_A0, Me, )
  loc_005F4801: var_9C = List1.ListCount
  loc_005F4831: var_9C = var_9C - 0001h
  loc_005F484A: var_80 = var_9C
  loc_005F4875: For var_24 = "" To var_9C Step 1
  loc_005F487E: var_D4 = var_C8
  loc_005F4890: If var_D4 = 0 Then GoTo loc_005F4A08
  loc_005F48BA: var_24 = CInt(var_3C)
  loc_005F48CA: var_48 = List1.List(var_24)
  loc_005F4913: var_44 = "â¢ " & var_3C & " â¢"
  loc_005F493E: var_eax = call Proc_3_4_5A51B0(var_68, var_34, 3)
  loc_005F49AC: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_68 & vbNullString, Me, var_48)
  loc_005F49DD: var_eax = call Proc_6098C0(CLng(0.75), , )
  loc_005F49F4: Next var_24
  loc_005F49FD: var_D4 = Next var_24
  loc_005F4A03: GoTo loc_005F488A
  loc_005F4A08: 'Referenced from: 005F4890
  loc_005F4A11: GoTo loc_005F4A47
  loc_005F4A46: Exit Sub
  loc_005F4A47: 'Referenced from: 005F4A11
  loc_005F4A79: Exit Sub
End Sub