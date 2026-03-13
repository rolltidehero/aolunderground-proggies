Private Sub Command5_Click() '5B8890
  Dim var_1C As Variant
  loc_005B88F7: var_18 = Command5.Caption
  loc_005B8927: ebx = (var_18 = "Pause") + 1
  loc_005B893E: If (var_18 = "Pause") + 1 = 0 Then GoTo loc_005B89D2
  loc_005B8983: Timer1.Enabled = False
  loc_005B89C0: Command5.Caption = "Unpause"
  loc_005B89C7: If esi >= 0 Then GoTo loc_005B8AA4
  loc_005B89CD: GoTo loc_005B8A95
  loc_005B89D2: 'Referenced from: 005B893E
  loc_005B8A11: Text1.Enabled = False
  loc_005B8A4F: Timer1.Enabled = True
  loc_005B8A8C: Command5.Caption = "Pause"
  loc_005B8A93: If var_1C >= 0 Then GoTo loc_005B8AA4
  loc_005B8A95: 'Referenced from: 005B89CD
  loc_005B8A9E: var_1C = CheckObj(var_1C, var_0042CCB8, 84)
  loc_005B8AA4: 'Referenced from: 005B89C7
  loc_005B8AB5: GoTo loc_005B8ACA
  loc_005B8AC9: Exit Sub
  loc_005B8ACA: 'Referenced from: 005B8AB5
End Sub