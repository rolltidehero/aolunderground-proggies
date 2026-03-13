ï»¿Private Sub sckListen_UnknownEvent_D '5C7F70
  loc_005C7FD4: txtIP.Locked = False
  loc_005C8015: cmdListen.Caption = "&Close"
  loc_005C8039: var_eax = Call ipchat.cmdListen_Click
  loc_005C8061: GoTo loc_005C806D
  loc_005C806C: Exit Sub
  loc_005C806D: 'Referenced from: 005C8061
End Sub