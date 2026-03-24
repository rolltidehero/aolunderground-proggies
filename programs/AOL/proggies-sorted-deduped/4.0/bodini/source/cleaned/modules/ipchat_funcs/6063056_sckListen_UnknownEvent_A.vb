ï»¿Private Sub sckListen_UnknownEvent_A '5C83D0
  loc_005C8495: esi = Winsock._RemoteHost
  loc_005C850E: var_1C = ipchat2.Text1.Text
  loc_005C8546: var_40 = var_1C & var_18
  loc_005C8582: var_20 = CStr(var_1C & var_18 & Chr(13) & Chr(10))
  loc_005C858A: ipchat2.Text1.Text = var_20
  loc_005C85EF: GoTo loc_005C8631
  loc_005C8630: Exit Sub
  loc_005C8631: 'Referenced from: 005C85EF
End Sub