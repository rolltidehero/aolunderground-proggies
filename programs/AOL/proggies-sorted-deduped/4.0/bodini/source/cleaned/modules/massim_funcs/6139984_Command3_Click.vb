ï»¿Private Sub Command3_Click() '5DB050
  Dim var_18 As ListBox
  Dim var_2C As ListBox
  loc_005DB0D2: var_A0 = List1.ListCount
  loc_005DB0FC: setz al
  loc_005DB10D: If eax = 0 Then GoTo loc_005DB180
  loc_005DB13F: var_2C = "You stupid fuckhead! What the hell are you trying to do!!!?  You can't remove an SN when there are no damn SNs to remove! Stupid ass...."
  loc_005DB17B: GoTo loc_005DB2D1
  loc_005DB180: 'Referenced from: 005DB10D
  loc_005DB19C: var_A0 = List1.SelCount
  loc_005DB1C3: setz cl
  loc_005DB1D7: If var_18 = 0 Then GoTo loc_005DB24A
  loc_005DB209: var_2C = "You stupid fuckhead! What the hell are you trying to do!!!? Did your mom drop you on your head when you were a kid! You need to select someone to remove!!!"
  loc_005DB245: GoTo loc_005DB2D1
  loc_005DB24A: 'Referenced from: 005DB1D7
  loc_005DB278: var_A0 = List1.ListIndex
  loc_005DB2A0: var_eax = List1.RemoveItem var_A0
  loc_005DB2D1: 'Referenced from: 005DB17B
  loc_005DB2DD: GoTo loc_005DB30B
  loc_005DB30A: Exit Sub
  loc_005DB30B: 'Referenced from: 005DB2DD
End Sub