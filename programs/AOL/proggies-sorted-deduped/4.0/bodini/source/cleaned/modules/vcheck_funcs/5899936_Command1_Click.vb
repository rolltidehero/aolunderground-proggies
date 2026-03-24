ï»¿Private Sub Command1_Click() '5A06A0
  Dim esi As Inet
  Dim var_C4 As Inet
  Dim var_54 As CommandButton
  loc_005A0756: On Error Resume Next
  loc_005A0776: Command1.Enabled = edi
  loc_005A07BA: var_54 = URL.Text
  loc_005A07DE: var_64 = var_54
  loc_005A0853: var_7C = esi._URL
  loc_005A0873: var_28 = Me
  loc_005A089E: var_A8 = "http://www.saturnnet.com/dave/software/versions/aboutv.html"
  loc_005A093E: var_2C = var_C4._URL
  loc_005A095B: var_A8 = "http://www.saturnnet.com/dave/software/versions/dllink.html"
  loc_005A09FB: var_50 = var_C4._URL
  loc_005A0A21: var_24 = vbNullString
  loc_005A0A2B: var_20 = vbNullString
  loc_005A0A4A: var_4C = vbNullString
  loc_005A0A6B: call UBound(00000001h, var_28)
  loc_005A0A71: UBound(00000001h, var_28) = UBound(00000001h, var_28) - 00000001h
  loc_005A0A7A: var_B8 = UBound(00000001h, var_28)
  loc_005A0AC1: For var_3C = 0 To UBound(00000001h, var_28) Step 1
  loc_005A0AC7: 
  loc_005A0AC9: If var_F8 = 0 Then GoTo loc_005A0B82
  loc_005A0AD2: var_A8 = vbNullString
  loc_005A0AE7: If var_28 = 0 Then GoTo loc_005A0B10
  loc_005A0AED: If var_28 <> 1 Then GoTo loc_005A0B10
  loc_005A0AF3: var_ret_1 = CLng(var_3C)
  loc_005A0AFE: var_ret_1 = var_ret_1 - eax+00000014h
  loc_005A0B04: If var_ret_1 < 0 Then GoTo loc_005A0B0C
  loc_005A0B06: var_eax = Err.Raise
  loc_005A0B0C: 'Referenced from: 005A0B04
  loc_005A0B0E: GoTo loc_005A0B16
  loc_005A0B10: 'Referenced from: 005A0AE7
  loc_005A0B10: var_eax = Err.Raise
  loc_005A0B16: 'Referenced from: 005A0B0E
  loc_005A0B4D: var_24 = var_24 + Chr(edx+eax)
  loc_005A0B77: Next var_3C
  loc_005A0B7D: GoTo loc_005A0AC7
  loc_005A0B82: 'Referenced from: 005A0AC9
  loc_005A0B98: call UBound(00000001h, var_2C, var_F8, var_108)
  loc_005A0B9E: UBound(00000001h, var_2C, var_F8, var_108) = UBound(00000001h, var_2C, var_F8, var_108) - 00000001h
  loc_005A0BA7: var_B8 = UBound(00000001h, var_2C, var_F8, var_108)
  loc_005A0BEE: For var_3C = 0 To UBound(00000001h, var_2C, var_F8, var_108) Step 1
  loc_005A0BF4: 
  loc_005A0BF6: If var_128 = 0 Then GoTo loc_005A0CAF
  loc_005A0BFF: var_A8 = vbNullString
  loc_005A0C14: If var_2C = 0 Then GoTo loc_005A0C3D
  loc_005A0C1A: If var_2C <> 1 Then GoTo loc_005A0C3D
  loc_005A0C20: var_ret_2 = CLng(var_3C)
  loc_005A0C2B: var_ret_2 = var_ret_2 - eax+00000014h
  loc_005A0C31: If var_ret_2 < 0 Then GoTo loc_005A0C39
  loc_005A0C33: var_eax = Err.Raise
  loc_005A0C39: 'Referenced from: 005A0C31
  loc_005A0C3B: GoTo loc_005A0C43
  loc_005A0C3D: 'Referenced from: 005A0C14
  loc_005A0C3D: var_eax = Err.Raise
  loc_005A0C43: 'Referenced from: 005A0C3B
  loc_005A0C7A: var_20 = var_20 + Chr(ecx+eax)
  loc_005A0CA4: Next var_3C
  loc_005A0CAA: GoTo loc_005A0BF4
  loc_005A0CAF: 'Referenced from: 005A0BF6
  loc_005A0CC5: call UBound(00000001h, var_50, var_118, var_128)
  loc_005A0CCB: UBound(00000001h, var_50, var_118, var_128) = UBound(00000001h, var_50, var_118, var_128) - 00000001h
  loc_005A0CD4: var_B8 = UBound(00000001h, var_50, var_118, var_128)
  loc_005A0D1B: For var_3C = 0 To UBound(00000001h, var_50, var_118, var_128) Step 1
  loc_005A0D27: 
  loc_005A0D29: If var_3C = 0 Then GoTo loc_005A0DB8
  loc_005A0D34: If var_50 = 0 Then GoTo loc_005A0D5D
  loc_005A0D3A: If var_50 <> 1 Then GoTo loc_005A0D5D
  loc_005A0D40: var_ret_3 = CLng(var_3C)
  loc_005A0D4B: var_ret_3 = var_ret_3 - eax+00000014h
  loc_005A0D51: If var_ret_3 < 0 Then GoTo loc_005A0D59
  loc_005A0D53: var_eax = Err.Raise
  loc_005A0D59: 'Referenced from: 005A0D51
  loc_005A0D5B: GoTo loc_005A0D63
  loc_005A0D5D: 'Referenced from: 005A0D34
  loc_005A0D5D: var_eax = Err.Raise
  loc_005A0D63: 'Referenced from: 005A0D5B
  loc_005A0D90: var_4C = var_4C + Chr(ecx+eax)
  loc_005A0DAD: Next var_3C
  loc_005A0DB3: GoTo loc_005A0D27
  loc_005A0DB8: 'Referenced from: 005A0D29
  loc_005A0DD7: Richtextbox1.Text = var_24
  loc_005A0E17: Text1.Text = var_20
  loc_005A0E5A: var_54 = CStr(var_4C)
  loc_005A0E62: Text2.Text = var_54
  loc_005A0EAF: Command1.Enabled = True
  loc_005A0ED2: GoTo loc_005A0F64
  loc_005A0F1C: var_6C = "I'm sorry, but Prophecy 2.0 is having trouble detecting the server. The server may be down, or you have a faulty connection. You may also want to update your Prophecy runtime files. Please go to http://www.saturnnet.com/dave/software/download.html -Thanks. -Unab0mb"
  loc_005A0F64: 'Referenced from: 005A0ED2
  loc_005A0F64: Exit Sub
  loc_005A0F6F: GoTo loc_005A0FBB
  loc_005A0FBA: Exit Sub
  loc_005A0FBB: 'Referenced from: 005A0F6F
  loc_005A102E: Exit Sub
End Sub