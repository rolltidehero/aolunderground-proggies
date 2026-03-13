Private Sub Command1_Click() '5FC700
  loc_005FC767: var_18 = Command1.Caption
  loc_005FC797: edi = (var_18 = "Start") + 1
  loc_005FC7AF: If (var_18 = "Start") + 1 = 0 Then GoTo loc_005FC814
  loc_005FC7C8: Command1.Caption = "Stop"
  loc_005FC802: Timer1.Enabled = True
  loc_005FC809: If edi >= 0 Then GoTo loc_005FC87D
  loc_005FC812: GoTo loc_005FC875
  loc_005FC828: Timer1.Enabled = False
  loc_005FC865: Command1.Caption = "Start"
  loc_005FC86C: If edi >= 0 Then GoTo loc_005FC87D
  loc_005FC875: 'Referenced from: 005FC812
  loc_005FC877: edi = CheckObj(esi = "", var_0042CCB8, 84)
  loc_005FC87D: 'Referenced from: 005FC809
  loc_005FC88E: GoTo loc_005FC8A3
  loc_005FC8A2: Exit Sub
  loc_005FC8A3: 'Referenced from: 005FC88E
End Sub