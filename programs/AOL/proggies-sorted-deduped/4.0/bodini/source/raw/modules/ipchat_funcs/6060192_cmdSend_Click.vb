Private Sub cmdSend_Click() '5C78A0
  Dim var_20 As Winsock
  loc_005C7913: var_54 = cmdListen.Enabled
  loc_005C793B: setz bl
  loc_005C7949: If ebx = 0 Then GoTo loc_005C79ED
  loc_005C7968: var_18 = txtSend.Text
  loc_005C7996: var_28 = var_18
  loc_005C79C6: var_24 = var_20._RemoteHost
  loc_005C79E8: GoTo loc_005C7A7C
  loc_005C79ED: 'Referenced from: 005C7949
  loc_005C7A06: var_18 = txtSend.Text
  loc_005C7A57: var_34 = var_20._RemoteHost
  loc_005C7A7C: 'Referenced from: 005C79E8
  loc_005C7A96: txtSend.Text = vbNullString
  loc_005C7AC9: GoTo loc_005C7AF1
  loc_005C7AF0: Exit Sub
  loc_005C7AF1: 'Referenced from: 005C7AC9
End Sub