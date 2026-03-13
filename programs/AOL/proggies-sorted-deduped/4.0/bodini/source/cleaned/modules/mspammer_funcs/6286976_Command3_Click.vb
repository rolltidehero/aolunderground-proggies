ï»¿Private Sub Command3_Click() '5FEE80
  loc_005FEF02: var_A0 = List1.ListCount
  loc_005FEF2C: setz al
  loc_005FEF3D: If eax = 0 Then GoTo loc_005FEFB0
  loc_005FEF6F: var_2C = "You stupid fuckhead! What the hell are you trying to do!!!?  You can't remove an SN when there are no damn SNs to remove! Stupid ass...."
  loc_005FEFAB: GoTo loc_005FF037
  loc_005FEFB0: 'Referenced from: 005FEF3D
  loc_005FEFDE: var_A0 = List1.ListIndex
  loc_005FF006: var_eax = List1.RemoveItem var_A0
  loc_005FF037: 'Referenced from: 005FEFAB
  loc_005FF043: GoTo loc_005FF071
  loc_005FF070: Exit Sub
  loc_005FF071: 'Referenced from: 005FF043
End Sub