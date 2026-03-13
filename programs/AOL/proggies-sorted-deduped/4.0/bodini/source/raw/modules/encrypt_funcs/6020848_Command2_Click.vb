Private Sub Command2_Click() '5BDEF0
  Dim var_16C As TextBox
  loc_005BDF70: var_16C = var_E8
  loc_005BDF8C: var_E4 = Text1.Text
  loc_005BDF94: var_170 = var_E4
  loc_005BDFE9: eax = (var_E4 = vbNullString) + 1
  loc_005BDFEC: var_174 = (var_E4 = vbNullString) + 1
  loc_005BE014: If var_174 = 0 Then GoTo loc_005BE0E5
  loc_005BE069: var_108 = "bodini by: spek"
  loc_005BE08F: var_F8 = "You must type in something to encrypt."
  loc_005BE0E0: GoTo loc_005BEBE7
  loc_005BE0E5: 'Referenced from: 005BE014
  loc_005BE125: var_E4 = Text2.Text
  loc_005BE12D: var_170 = var_E4
  loc_005BE182: eax = (var_E4 = vbNullString) + 1
  loc_005BE185: var_174 = (var_E4 = vbNullString) + 1
  loc_005BE1AD: If var_174 = 0 Then GoTo loc_005BE27E
  loc_005BE202: var_108 = "bodini by: spek"
  loc_005BE228: var_F8 = "You must type in a keyword."
  loc_005BE279: GoTo loc_005BEBE7
  loc_005BE27E: 'Referenced from: 005BE1AD
  loc_005BE287: On Error Resume Next
  loc_005BE2CD: var_E4 = Text1.Text
  loc_005BE2D5: var_170 = var_E4
  loc_005BE321: var_1C4 = Len(var_E4)
  loc_005BE340: If var_60C000 <> 0 Then GoTo loc_005BE34A
  loc_005BE348: GoTo loc_005BE35B
  loc_005BE34A: 'Referenced from: 005BE340
  loc_005BE35B: 'Referenced from: 005BE348
  loc_005BE37E: var_70 = (3038# / var_1CC)
  loc_005BE3C0: var_80 = CInt(1)
  loc_005BE3FE: var_16C = var_E8
  loc_005BE41A: var_E4 = Text1.Text
  loc_005BE422: var_170 = var_E4
  loc_005BE46E: var_140 = Len(var_E4)
  loc_005BE4BC: For var_90 = 1 To Len(var_E4) Step 1
  loc_005BE4C2: var_1AC = var_90
  loc_005BE4E0: GoTo loc_005BEAA4
  loc_005BE4E5: 
  loc_005BE525: var_E4 = Text1.Text
  loc_005BE52D: var_170 = var_E4
  loc_005BE586: var_1B0 = var_E4
  loc_005BE59C: var_F0 = var_1B0
  loc_005BE64B: var_B0 = Asc(CStr(Mid(var_1B0, CLng(var_90), 1)))
  loc_005BE69D: var_E4 = Text2.Text
  loc_005BE6A5: var_170 = var_E4
  loc_005BE6FE: var_1B4 = var_E4
  loc_005BE714: var_F0 = var_1B4
  loc_005BE756: var_C0 = Mid(var_1B4, CLng(var_80), 1)
  loc_005BE7B9: var_80 = var_80 + 1
  loc_005BE7FF: var_E4 = Text2.Text
  loc_005BE807: var_170 = var_E4
  loc_005BE853: var_130 = Len(var_E4)
  loc_005BE874: var_174 = (var_80 > Len(var_E4))
  loc_005BE89C: If var_174 = 0 Then GoTo loc_005BE8C8
  loc_005BE8C2: var_80 = CInt(1)
  loc_005BE8C8: 'Referenced from: 005BE89C
  loc_005BE943: var_E0 = var_B0 - Asc(CStr(var_C0))
  loc_005BE97D: If (var_E0 < 1) = 0 Then GoTo loc_005BE9F0
  loc_005BE9E8: var_40 = Chr(CLng(var_E0 + 255))
  loc_005BE9EE: GoTo loc_005BEA21
  loc_005BE9F0: 'Referenced from: 005BE97D
  loc_005BEA1B: var_40 = Chr(CLng(var_E0))
  loc_005BEA21: 'Referenced from: 005BE9EE
  loc_005BEA42: var_50 = var_50 + var_40
  loc_005BEA69: var_60 = var_60 + var_70
  loc_005BEA98: Next var_90
  loc_005BEA9E: var_1AC = Next var_90
  loc_005BEAA4: 'Referenced from: 005BE4E0
  loc_005BEAAB: If var_1AC <> 0 Then GoTo loc_005BE4E5
  loc_005BEAD5: var_16C = var_E8
  loc_005BEAFC: Text1.Text = CStr(var_50)
  loc_005BEB04: var_170 = var_16C
  loc_005BEB94: var_eax = Text1.SetFocus
  loc_005BEB9C: var_170 = Text1.SetFocus
  loc_005BEBF4: GoTo loc_005BEC36
  loc_005BEC35: Exit Sub
  loc_005BEC36: 'Referenced from: 005BEBF4
  loc_005BECCD: Exit Sub
End Sub