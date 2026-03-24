ï»¿Private Sub cmdListen_Click() '5C74C0
  Dim var_1C As Variant
  Dim var_0060C618 As Me
  loc_005C752D: var_18 = cmdListen.Caption
  loc_005C755B: eax = (var_18 = "&Listen") + 1
  loc_005C755E: var_48 = (var_18 = "&Listen") + 1
  loc_005C7577: If var_48 = 0 Then GoTo loc_005C773F
  loc_005C7595: var_40 = (var_18 = "&Listen") + 1
  loc_005C7598: cmdListen.Caption = "&Close"
  loc_005C75D0: cmdConnect.Enabled = False
  loc_005C760B: var_40 = var_1C
  loc_005C760E: txtSend.Enabled = True
  loc_005C764C: cmdSend.Enabled = True
  loc_005C7687: var_1C = var_1C._RemoteHost
  loc_005C769A: var_eax = Unknown_VTable_Call[ecx+000001BCh]
  loc_005C7718: var_eax = ipchat2.Show var_20
  loc_005C773A: GoTo loc_005C7853
  loc_005C773F: 'Referenced from: 005C7577
  loc_005C7746: var_eax = Unknown_VTable_Call[eax+00000348h]
  loc_005C7751: call edi(var_1C, Unknown_VTable_Call[eax+00000348h], var_0060C618, 00000046h, 00000000h)
  loc_005C7765: var_eax = Unknown_VTable_Call[edx+0000031Ch]
  loc_005C7770: call edi(var_1C, Unknown_VTable_Call[edx+0000031Ch], var_0060C618)
  loc_005C777D: edi(var_1C, Unknown_VTable_Call[edx+0000031Ch], var_0060C618).Caption = "&Listen"
  loc_005C77A0: var_eax = Unknown_VTable_Call[eax+00000318h]
  loc_005C77AB: call edi(var_1C, Unknown_VTable_Call[eax+00000318h], var_0060C618)
  loc_005C77B5: edi(var_1C, Unknown_VTable_Call[edx+0000031Ch], var_0060C618).Height = NAN
  loc_005C77DE: var_eax = Unknown_VTable_Call[edx+00000310h]
  loc_005C77E9: call edi(var_1C, Unknown_VTable_Call[edx+00000310h], var_0060C618)
  loc_005C781C: var_eax = Unknown_VTable_Call[eax+0000030Ch]
  loc_005C7827: call edi(var_1C, Unknown_VTable_Call[eax+0000030Ch], var_0060C618)
  loc_005C785F: GoTo loc_005C7874
  loc_005C7873: Exit Sub
  loc_005C7874: 'Referenced from: 005C785F
End Sub