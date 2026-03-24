ï»¿Private Sub Command1_Click() '5C5040
  Dim var_38 As Variant
  loc_005C50BD: var_2C = Command1.Caption
  loc_005C50F3: esi = (var_2C = "Start") + 1
  loc_005C5109: If (var_2C = "Start") + 1 = 0 Then GoTo loc_005C54B2
  loc_005C5117: var_2C = "â¢bodini 4.0â¢ request bot â¢spekâ¢"
  loc_005C5143: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005C518D: var_2C = "<font face=""tahoma"">" & var_58
  loc_005C51A2: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005C51CD: var_eax = call Proc_6098C0(CLng(0.5), Me, Me)
  loc_005C51F0: var_2C = Text1.Text
  loc_005C5237: var_34 = "â¢requestingâ¢ " & var_2C & var_0042EC60
  loc_005C525F: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005C52CD: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_58 & vbNullString, Me, Me)
  loc_005C52F8: var_eax = call Proc_6098C0(CLng(0.7), , )
  loc_005C531B: var_2C = Text3.Text
  loc_005C5362: var_34 = "â¢typeâ¢ " & var_2C & " â¢ if you have itâ¢"
  loc_005C538A: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005C53F8: var_eax = call Proc_79_17_604A50("<font face=""tahoma"">" & var_58 & vbNullString, Me, Me)
  loc_005C542D: Timer1.Enabled = True
  loc_005C5465: Timer2.Enabled = True
  loc_005C54A0: Command1.Caption = "Stop"
  loc_005C54A7: If var_38 >= 0 Then GoTo loc_005C5605
  loc_005C54AD: GoTo loc_005C55F6
  loc_005C54B2: 'Referenced from: 005C5109
  loc_005C54BA: var_2C = "â¢bodini 4.0â¢ request bot offâ¢"
  loc_005C54E6: var_eax = call Proc_3_4_5A51B0(var_58, var_24, 3)
  loc_005C5530: var_2C = "<font face=""tahoma"">" & var_58
  loc_005C5545: var_eax = call Proc_79_17_604A50(var_2C & vbNullString, var_24, var_2C)
  loc_005C557A: Timer1.Enabled = False
  loc_005C55B2: Timer2.Enabled = False
  loc_005C55ED: Command1.Caption = "Start"
  loc_005C55F4: If Me >= 0 Then GoTo loc_005C5605
  loc_005C55F6: 'Referenced from: 005C54AD
  loc_005C55FF: Me = CheckObj(Me, var_0042CCB8, 84)
  loc_005C5605: 'Referenced from: 005C54A7
  loc_005C561B: GoTo loc_005C5651
  loc_005C5650: Exit Sub
  loc_005C5651: 'Referenced from: 005C561B
End Sub