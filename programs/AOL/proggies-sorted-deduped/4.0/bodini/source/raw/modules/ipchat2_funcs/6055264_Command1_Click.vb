Private Sub Command1_Click() '5C6560
  Dim var_38 As Winsock
  Dim var_3C As TextBox
  Dim var_CC As TextBox
  loc_005C6623: var_B0 = ipchat.cmdListen.Enabled
  loc_005C664E: setz bl
  loc_005C6661: If ebx = 0 Then GoTo loc_005C67A9
  loc_005C6699: var_18 = ipchat.Text1.Text
  loc_005C66D0: var_1C = Text2.Text
  loc_005C6711: var_44 = var_18 & ": " & var_1C
  loc_005C676A: var_38 = var_38._RemoteHost
  loc_005C67A4: GoTo loc_005C68EA
  loc_005C67A9: 'Referenced from: 005C6661
  loc_005C67DB: var_18 = ipchat.Text1.Text
  loc_005C6812: var_1C = Text2.Text
  loc_005C685A: var_24 = var_18 & ": " & var_1C
  loc_005C68B2: var_38 = var_38._RemoteHost
  loc_005C68EA: 'Referenced from: 005C67A4
  loc_005C68FD: var_CC = var_3C
  loc_005C6919: var_1C = Text1.Text
  loc_005C696E: var_18 = ipchat.Text1.Text
  loc_005C69A8: var_24 = Text2.Text
  loc_005C69EA: var_28 = var_1C & var_18 & ":  "
  loc_005C69FF: var_54 = var_28 & var_24
  loc_005C6A44: var_2C = CStr(var_28 & var_24 & Chr(13) & Chr(10))
  loc_005C6A4C: Text2.Text = var_2C
  loc_005C6AE1: Text2.Text = vbNullString
  loc_005C6B14: GoTo loc_005C6B71
  loc_005C6B70: Exit Sub
  loc_005C6B71: 'Referenced from: 005C6B14
End Sub