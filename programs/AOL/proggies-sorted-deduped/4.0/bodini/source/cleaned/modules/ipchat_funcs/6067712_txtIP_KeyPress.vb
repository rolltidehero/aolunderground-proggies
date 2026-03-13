ï»¿Private Sub txtIP_KeyPress(KeyAscii As Integer) '5C9600
  loc_005C9647: If KeyAscii <> 13 Then GoTo loc_005C9668
  loc_005C964C: var_eax = Call ipchat.cmdConnect_Click
  loc_005C9668: 'Referenced from: 005C9647
End Sub