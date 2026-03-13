ï»¿Private Sub Command1_Click() '5BD390
  Dim var_EC As TextBox
  loc_005BD47C: var_E8 = Text1.Text
  loc_005BD4BC: eax = (var_E8 = vbNullString) + 1
  loc_005BD4BF: var_178 = (var_E8 = vbNullString) + 1
  loc_005BD4DE: If var_178 = 0 Then GoTo loc_005BD53A
  loc_005BD529: var_10C = "bodini by: spek"
  loc_005BD52B: var_134 = "You must type in something to encrypt."
  loc_005BD535: GoTo loc_005BD61A
  loc_005BD53A: 'Referenced from: 005BD4DE
  loc_005BD54B: call ebx(var_EC, var_10C, %ecx = %S_edx_S, var_EC, Me, Me, %ecx = %S_edx_S, esi, 00000008h)
  loc_005BD55D: var_E8 = Text2.Text
  loc_005BD59D: eax = (var_E8 = vbNullString) + 1
  loc_005BD5A0: var_178 = (var_E8 = vbNullString) + 1
  loc_005BD5BF: If var_178 = 0 Then GoTo loc_005BD67E
  loc_005BD60E: var_10C = "bodini by: spek"
  loc_005BD61A: 'Referenced from: 005BD535
  loc_005BD62C: var_FC = "You must type in a keyword."
  loc_005BD679: GoTo loc_005BDE08
  loc_005BD67E: 'Referenced from: 005BD5BF
  loc_005BD68F: call ebx(var_EC, var_10C, %ecx = %S_edx_S)
  loc_005BD6A1: var_E8 = Text1.Text
  loc_005BD6D2: var_1B0 = Len(var_E8)
  loc_005BD70A: If var_60C000 <> 0 Then GoTo loc_005BD714
  loc_005BD712: GoTo loc_005BD725
  loc_005BD714: 'Referenced from: 005BD70A
  loc_005BD725: 'Referenced from: 005BD712
  loc_005BD735: var_74 = (100# / var_1B8)
  loc_005BD760: call ebx(var_EC, %ecx = %S_edx_S, %ecx = %S_edx_S, var_1B8, var_1B4)
  loc_005BD772: var_E8 = Text1.Text
  loc_005BD7A3: var_1BC = Len(var_E8)
  loc_005BD7D8: If var_60C000 <> 0 Then GoTo loc_005BD7E2
  loc_005BD7E0: GoTo loc_005BD7F3
  loc_005BD7E2: 'Referenced from: 005BD7D8
  loc_005BD7F3: 'Referenced from: 005BD7E0
  loc_005BD803: var_84 = (3038# / var_1C4)
  loc_005BD83D: var_94 = CInt(1)
  loc_005BD864: call ebx(var_EC, CInt(1), %ecx = %S_edx_S, var_1C4, var_1C0)
  loc_005BD876: var_E8 = Text1.Text
  loc_005BD8A7: var_144 = Len(var_E8)
  loc_005BD8F5: For var_A4 = 1 To Len(var_E8) Step 1
  loc_005BD901: var_1A4 = var_198
  loc_005BD919: 
  loc_005BD924: If var_1A4 = 0 Then GoTo loc_005BDD5D
  loc_005BD938: call ebx(var_EC, %ecx = %S_edx_S, %ecx = %S_edx_S)
  loc_005BD94A: var_E8 = Text1.Text
  loc_005BD97A: var_F4 = var_E8
  loc_005BDA36: var_C4 = Asc(CStr(Mid(0, CLng(var_A4), 1)))
  loc_005BDA55: call ebx(var_EC, var_C4, %ecx = %S_edx_S)
  loc_005BDA63: var_E8 = Text2.Text
  loc_005BDA8D: var_F4 = var_E8
  loc_005BDAEB: var_D4 = Mid(0, CLng(CInt(1)), 1)
  loc_005BDB45: var_94 = var_94 + 1
  loc_005BDB6A: var_E8 = Text2.Text
  loc_005BDB95: var_134 = Len(var_E8)
  loc_005BDBD6: If (var_94 > Len(var_E8)) = 0 Then GoTo loc_005BDBFA
  loc_005BDBF8: var_94 = CInt(1)
  loc_005BDBFA: 'Referenced from: 005BDBD6
  loc_005BDC62: var_24 = var_C4 + Asc(CStr(var_D4))
  loc_005BDC8C: If (var_24 > 255) = 0 Then GoTo loc_005BDCD5
  loc_005BDCC5: var_ret_4 = CLng(var_24 - 255)
  loc_005BDCD3: GoTo loc_005BDCE7
  loc_005BDCD5: 'Referenced from: 005BDC8C
  loc_005BDCD9: var_ret_5 = CLng(var_24)
  loc_005BDCE7: 'Referenced from: 005BDCD3
  loc_005BDD0E: var_54 = var_54 + Chr(var_ret_5)
  loc_005BDD29: var_64 = var_64 + var_84
  loc_005BDD46: Next var_A4
  loc_005BDD52: var_1A4 = Next var_A4
  loc_005BDD58: GoTo loc_005BD919
  loc_005BDD80: var_E8 = CStr(var_54)
  loc_005BDD90: Text1.Text = var_E8
  loc_005BDDE0: var_eax = Text1.SetFocus
  loc_005BDE08: 'Referenced from: 005BD679
  loc_005BDE11: GoTo loc_005BDE53
  loc_005BDE52: Exit Sub
  loc_005BDE53: 'Referenced from: 005BDE11
  loc_005BDEC8: Exit Sub
End Sub