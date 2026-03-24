Private Sub Command1_Click() '5AF930
  loc_005AF9C8: var_eax = Unknown_VTable_Call[ecx+00000050h]
  loc_005AF9F8: edi = (var_28 = vbNullString) + 1
  loc_005AFA0D: If (var_28 = vbNullString) + 1 = 0 Then GoTo loc_005AFAA2
  loc_005AFA4D: var_4C = "bodini by: spek"
  loc_005AFA68: var_3C = "You need a file in order to shield it dumbass."
  loc_005AFA9D: GoTo loc_005AFC6B
  loc_005AFAA2: 'Referenced from: 005AFA0D
  loc_005AFABF: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005AFAE1: Open var_28 For Binary As #1 Len = -1
  loc_005AFB21: Seek #1, 25
  loc_005AFB2F: Put #1, &H42DCAC
  loc_005AFB37: Close #1
  loc_005AFB3F: Close #1
  loc_005AFB62: var_eax = Unknown_VTable_Call[edx+00000050h]
  loc_005AFB88: var_34 = var_28
  loc_005AFBCF: var_7C = "bodini by: spek"
  loc_005AFBFE: var_A4 = vbNullString
  loc_005AFC0E: var_B4 = " has been shielded"
  loc_005AFC2C: var_6C = vbNullString & LCase(var_28) & " has been shielded"
  loc_005AFC6B: 'Referenced from: 005AFA9D
  loc_005AFC73: GoTo loc_005AFCB5
  loc_005AFCB4: Exit Sub
  loc_005AFCB5: 'Referenced from: 005AFC73
End Sub