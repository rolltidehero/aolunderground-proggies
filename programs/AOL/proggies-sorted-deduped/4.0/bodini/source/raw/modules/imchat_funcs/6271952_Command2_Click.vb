Private Sub Command2_Click() '5FB3D0
  Dim var_30 As Variant
  Dim var_24 As ListBox
  Dim var_54 As TextBox
  Dim var_34 As TextBox
  Dim var_D4 As TextBox
  loc_005FB48E: var_C8 = List1.ListCount
  loc_005FB4B9: var_C8 = var_C8 - 0001h
  loc_005FB4C9: var_9C = var_C8
  loc_005FB502: For var_24 = "" To var_C8 Step 1
  loc_005FB515: If var_24 = 0 Then GoTo loc_005FB7EB
  loc_005FB53B: var_24 = CInt(var_28)
  loc_005FB543: var_30 = List1.List(var_24)
  loc_005FB56A: var_3C = var_28
  loc_005FB583: var_54 = LCase(var_28)
  loc_005FB5A2: var_2C = Text3.Text
  loc_005FB5C6: var_5C = var_2C
  loc_005FB5DC: var_74 = LCase(0)
  loc_005FB5ED: call __vbaVarLikeVar(var_84, var_74, var_54, var_34, var_54, Me, var_24, Me, var_30, Me, Me, var_54, Me, %x1 = LCase(%StkVar2))
  loc_005FB62C: If CBool(__vbaVarLikeVar(var_84, var_74, var_54, var_34, var_54, Me, var_24, Me, var_30, Me, Me, var_54, Me, %x1 = LCase(%StkVar2))) = 0 Then GoTo loc_005FB6BB
  loc_005FB66B: var_54 = "bodini by: spek"
  loc_005FB68A: var_44 = "Why would you want to add the same screen name to the list twice?"
  loc_005FB6BB: 'Referenced from: 005FB62C
  loc_005FB6DB: var_24 = CInt(var_28)
  loc_005FB6E3: var_30 = List1.List(var_24)
  loc_005FB711: var_3C = var_28
  loc_005FB71B: var_54 = LCase(8)
  loc_005FB73E: var_2C = Text3.Text
  loc_005FB76A: var_5C = var_2C
  loc_005FB774: var_74 = LCase(var_2C)
  loc_005FB789: call __vbaVarLikeVar(var_84, var_74, var_54, var_34, Me, Me, Me, Me)
  loc_005FB7C6: If CBool(__vbaVarLikeVar(var_84, var_74, var_54, var_34, Me, Me, Me, Me)) <> 0 Then GoTo loc_005FB9D6
  loc_005FB7DE: Next var_24
  loc_005FB7E6: GoTo loc_005FB513
  loc_005FB7EB: 'Referenced from: 005FB515
  loc_005FB808: var_28 = Text3.Text
  loc_005FB84F: If Len(var_28) = 0 Then GoTo loc_005FB92B
  loc_005FB86E: var_D4 = var_34
  loc_005FB89E: var_28 = Text3.Text
  loc_005FB8F1: Text3.OLEDragMode = var_28
  loc_005FB92B: 'Referenced from: 005FB84F
  loc_005FB948: var_28 = Text3.Text
  loc_005FB98F: If Len(var_28) = 0 Then GoTo loc_005FB9D6
  loc_005FB9AF: Text3.Text = vbNullString
  loc_005FB9D6: 'Referenced from: 005FB7C6
  loc_005FB9DE: GoTo loc_005FBA23
  loc_005FBA22: Exit Sub
  loc_005FBA23: 'Referenced from: 005FB9DE
  loc_005FBA45: Exit Sub
End Sub