ï»¿Private Sub sckListen_UnknownEvent_C '5C8210
  Dim var_18 As Winsock
  loc_005C8276: var_28 = var_18._RemoteHost
  loc_005C8280: var_18 = CInt(Me)
  loc_005C8295: setz dl
  loc_005C82AE: If var_4C = 0 Then GoTo loc_005C82D3
  loc_005C82C5: esi = Winsock._RemoteHost
  loc_005C82D3: 'Referenced from: 005C82AE
  loc_005C8306: var_2C = var_18._RemoteHost
  loc_005C832B: txtSend.Enabled = True
  loc_005C836B: cmdSend.Enabled = True
  loc_005C839A: GoTo loc_005C83AF
  loc_005C83AE: Exit Sub
  loc_005C83AF: 'Referenced from: 005C839A
End Sub