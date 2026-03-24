Private Sub Command1_Click() '5DE870
  Dim var_3C As Variant
  loc_005DE910: esi = IsNumeric(Me) + 1
  loc_005DE91C: If IsNumeric(Me) + 1 <> 0 Then GoTo loc_005DF032
  loc_005DE922: var_eax = call Proc_79_19_604D70(Me, edi, IsNumeric(Me) + 1)
  loc_005DE929: If call Proc_79_19_604D70(Me, edi, IsNumeric(Me) + 1) <> 0 Then GoTo loc_005DE9A2
  loc_005DE964: var_4C = "You need to be in a chat room to use the mass mailer bot."
  loc_005DE99D: GoTo loc_005DF032
  loc_005DE9A2: 'Referenced from: 005DE929
  loc_005DE9C1: var_30 = Command1.Caption
  loc_005DE9F1: esi = (var_30 = "Start") + 1
  loc_005DEA09: If (var_30 = "Start") + 1 = 0 Then GoTo loc_005DEE59
  loc_005DEA26: Command1.Caption = "Stop"
  loc_005DEA60: var_30 = Text1.Text
  loc_005DEAB3: var_38 = "•bodini 4.0• mm bot •" & var_30 & " min(s)•"
  loc_005DEADE: var_eax = call Proc_3_4_5A51B0(var_5C, var_28, 3)
  loc_005DEB4C: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_5C & vbNullString, var_3C, Me)
  loc_005DEB7D: var_eax = call Proc_6098C0(CLng(0.5), var_3C, Me)
  loc_005DEBA3: var_30 = Text2.Text
  loc_005DEBF0: var_38 = "•type• " & var_30 & " • to add•"
  loc_005DEC1B: var_eax = call Proc_3_4_5A51B0(var_5C, var_28, 3)
  loc_005DEC89: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_5C & vbNullString, Me, Me)
  loc_005DECBA: var_eax = call Proc_6098C0(CLng(0.5), , )
  loc_005DECE0: var_30 = Text3.Text
  loc_005DED2D: var_38 = "•type• " & var_30 & " • to remove•"
  loc_005DED58: var_eax = call Proc_3_4_5A51B0(var_5C, var_28, 3)
  loc_005DEDC6: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_5C & vbNullString, Me, Me)
  loc_005DEDFB: Timer1.Enabled = True
  loc_005DEE33: Timer2.Enabled = True
  loc_005DEE54: GoTo loc_005DF030
  loc_005DEE6D: Timer1.Enabled = False
  loc_005DEEA5: Timer2.Enabled = False
  loc_005DEEE0: Command1.Caption = "Start"
  loc_005DEF3D: var_C0 = mm.List1.ListCount
  loc_005DEF73: var_18 = CStr(var_C0)
  loc_005DEF8C: var_30 = "•bodini 4.0• mm bot off•"
  loc_005DEFBB: var_eax = call Proc_3_4_5A51B0(var_5C, var_28, 3)
  loc_005DF003: var_30 = "<font face=""tahoma"">" & var_5C
  loc_005DF018: var_eax = call Proc_79_17_604A50(var_30 & vbNullString, var_28, var_30)
  loc_005DF030: 'Referenced from: 005DEE54
  loc_005DF032: 'Referenced from: 005DE91C
  loc_005DF03B: GoTo loc_005DF079
  loc_005DF078: Exit Sub
  loc_005DF079: 'Referenced from: 005DF03B
End Sub