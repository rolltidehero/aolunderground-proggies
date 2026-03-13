ï»¿Private Sub txtSend_KeyPress(KeyAscii As Integer) '5C9690
  loc_005C96D7: If KeyAscii <> 13 Then GoTo loc_005C96F8
  loc_005C96DC: var_eax = Call ipchat.cmdSend_Click
  loc_005C96F8: 'Referenced from: 005C96D7
End Sub