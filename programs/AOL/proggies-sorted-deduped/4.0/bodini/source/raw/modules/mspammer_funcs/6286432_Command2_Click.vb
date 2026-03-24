Private Sub Command2_Click() '5FEC60
  Dim var_2C As ListBox
  loc_005FED3D: var_2C = "Who do you want to add?"
  loc_005FED6D: var_18 = InputBox(var_2C, "bodini by: spek", var_4C, var_5C, 10, 10, 10)
  loc_005FEDE7: var_eax = List1.AddItem var_18, var_90
  loc_005FEE16: GoTo loc_005FEE4C
  loc_005FEE4B: Exit Sub
  loc_005FEE4C: 'Referenced from: 005FEE16
End Sub