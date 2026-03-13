ï»¿Private Sub cmdConnect_Click() '5C6E30
  Dim var_20 As Variant
  Dim var_18 As Winsock
  Dim var_34 As Variant
  loc_005C6EB9: var_18 = cmdConnect.Caption
  loc_005C6EEF: ebx = (var_18 = "&Connect") + 1
  loc_005C6F04: If (var_18 = "&Connect") + 1 = 0 Then GoTo loc_005C7332
  loc_005C6F23: var_18 = txtIP.Text
  loc_005C6F54: ebx = Len(var_18) + 1
  loc_005C6F69: If Len(var_18) + 1 = 0 Then GoTo loc_005C6FB2
  loc_005C6F6B: Beep
  loc_005C6F86: var_eax = txtIP.SetFocus
  loc_005C6FAD: GoTo loc_005C744C
  loc_005C6FB2: 'Referenced from: 005C6F69
  loc_005C6FCB: var_18 = txtIP.Text
  loc_005C701B: var_1C = var_18._RemoteHost
  loc_005C7035: ebx = (var_20 = var_1C) + 1
  loc_005C7060: If (var_20 = var_1C) + 1 = 0 Then GoTo loc_005C70D6
  loc_005C7062: Beep
  loc_005C7098: var_34 = "You cannot connect to yourself."
  loc_005C70D1: GoTo loc_005C744C
  loc_005C70D6: 'Referenced from: 005C7060
  loc_005C70F0: cmdConnect.Caption = "&Close"
  loc_005C7128: cmdListen.Enabled = False
  loc_005C7166: txtSend.Enabled = True
  loc_005C71A4: cmdSend.Enabled = True
  loc_005C71E4: var_18 = txtIP.Text
  loc_005C7212: var_2C = var_18
  loc_005C7261: esi = Winsock._RemoteHost
  loc_005C72E8: var_eax = ipchat2.Show var_68
  loc_005C730B: ipchat2.Visible = False
  loc_005C732D: GoTo loc_005C744C
  loc_005C7332: 'Referenced from: 005C6F04
  loc_005C7339: var_eax = Unknown_VTable_Call[edx+0000034Ch]
  loc_005C7344: call edi(var_20, Unknown_VTable_Call[edx+0000034Ch], var_20, 00000046h, 00000000h)
  loc_005C735C: var_eax = Unknown_VTable_Call[ecx+0000031Ch]
  loc_005C7367: call edi(var_20, Unknown_VTable_Call[ecx+0000031Ch], var_20)
  loc_005C7370: edi(var_20, Unknown_VTable_Call[ecx+0000031Ch], var_20).Height = NAN
  loc_005C739A: var_eax = Unknown_VTable_Call[ecx+00000318h]
  loc_005C73A5: call edi(var_20, Unknown_VTable_Call[ecx+00000318h], var_20)
  loc_005C73B1: edi(var_20, Unknown_VTable_Call[ecx+0000031Ch], var_20).Caption = "&Connect"
  loc_005C73D5: var_eax = Unknown_VTable_Call[ecx+00000310h]
  loc_005C73E0: call edi(var_20, Unknown_VTable_Call[ecx+00000310h], var_20)
  loc_005C7415: var_eax = Unknown_VTable_Call[ecx+0000030Ch]
  loc_005C7420: call edi(var_20, Unknown_VTable_Call[ecx+0000030Ch], var_20)
  loc_005C744C: 'Referenced from: 005C6FAD
  loc_005C7458: GoTo loc_005C7496
  loc_005C7495: Exit Sub
  loc_005C7496: 'Referenced from: 005C7458
End Sub