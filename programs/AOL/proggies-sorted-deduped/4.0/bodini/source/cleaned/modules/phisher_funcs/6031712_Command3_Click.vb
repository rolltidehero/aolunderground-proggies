ï»¿Private Sub Command3_Click() '5C0960
  loc_005C0A6D: var_18 = InputBox("What Screen Name do you want to add?", "Add Name", var_4C, var_5C, 10, 10, 10)
  loc_005C0AAA: If Len(var_18) < 3 Then GoTo loc_005C0BA1
  loc_005C0ABC: If Len(var_18) <= 10 Then GoTo loc_005C0B30
  loc_005C0AF2: var_2C = "The Screen Name May only be 10 Characters long.  No Screen name was added."
  loc_005C0B2E: GoTo loc_005C0BA1
  loc_005C0B30: 'Referenced from: 005C0ABC
  loc_005C0B7A: var_eax = List1.AddItem var_18, var_90
  loc_005C0BA1: 'Referenced from: 005C0AAA
  loc_005C0BA9: GoTo loc_005C0BDF
  loc_005C0BDE: Exit Sub
  loc_005C0BDF: 'Referenced from: 005C0BA9
End Sub