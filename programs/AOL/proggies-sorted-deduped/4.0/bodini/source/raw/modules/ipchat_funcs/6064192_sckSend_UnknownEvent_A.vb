Private Sub sckSend_UnknownEvent_A '5C8840
  loc_005C8905: esi = Winsock._RemoteHost
  loc_005C8917: Beep
  loc_005C8984: var_1C = ipchat2.Text1.Text
  loc_005C89BC: var_40 = var_1C & var_18
  loc_005C89F8: var_20 = CStr(var_1C & var_18 & Chr(13) & Chr(10))
  loc_005C8A00: ipchat2.Text1.Text = var_20
  loc_005C8A65: GoTo loc_005C8AA7
  loc_005C8AA6: Exit Sub
  loc_005C8AA7: 'Referenced from: 005C8A65
End Sub