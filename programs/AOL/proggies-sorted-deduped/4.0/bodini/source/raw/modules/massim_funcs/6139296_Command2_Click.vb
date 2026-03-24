Private Sub Command2_Click() '5DADA0
  loc_005DAEAD: var_18 = InputBox("What Screen Name do you want to add?", "bodini by: spek", var_4C, var_5C, 10, 10, 10)
  loc_005DAEEA: If Len(var_18) < 3 Then GoTo loc_005DAFE1
  loc_005DAEFC: If Len(var_18) <= 10 Then GoTo loc_005DAF70
  loc_005DAF32: var_2C = "The Screen Name May only be 10 Characters long.  No Screen name was added."
  loc_005DAF6E: GoTo loc_005DAFE1
  loc_005DAF70: 'Referenced from: 005DAEFC
  loc_005DAFBA: var_eax = List1.AddItem var_18, var_90
  loc_005DAFE1: 'Referenced from: 005DAEEA
  loc_005DAFE9: GoTo loc_005DB01F
  loc_005DB01E: Exit Sub
  loc_005DB01F: 'Referenced from: 005DAFE9
End Sub