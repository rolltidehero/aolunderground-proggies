ï»¿Private Sub Command3_Click() '5F4AA0
  Dim var_24 As TextBox
  loc_005F4B20: var_18 = Text1.Text
  loc_005F4B56: edi = (var_18 = vbNullString) + 1
  loc_005F4B6B: If (var_18 = vbNullString) + 1 = 0 Then GoTo loc_005F4BDA
  loc_005F4B9D: var_38 = "You have to enter a word to scramble!"
  loc_005F4BD5: GoTo loc_005F4CA3
  loc_005F4BDA: 'Referenced from: 005F4B6B
  loc_005F4C0D: var_18 = Text1.Text
  loc_005F4C42: var_eax = call Proc_79_28_6068D0(var_38, var_18, var_24)
  loc_005F4C51: var_20 = CStr(var_38)
  loc_005F4C59: Text1.Text = var_20
  loc_005F4CA3: 'Referenced from: 005F4BD5
  loc_005F4CAB: GoTo loc_005F4CED
  loc_005F4CEC: Exit Sub
  loc_005F4CED: 'Referenced from: 005F4CAB
End Sub